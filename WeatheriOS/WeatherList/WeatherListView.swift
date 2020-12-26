//
//  WeatherListView.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/25.
//

import UIKit
import WeatherUIKit
import WeatherKit

class WeatherListView: TableView {
    var listViewModel: WeatherListViewModel
    var toolViewModel: WeatherToolViewModel
    
    var tableViewCellHeight: CGFloat {
        UIScreen.main.bounds.height * 0.1025
    }
    
    var weathers: [WeatherInformation] = [] {
        didSet {
            print("✅ WeatherListView — 새로운 날씨 정보가 등록되었습니다.")
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    init(listViewModel: WeatherListViewModel, toolViewModel: WeatherToolViewModel) {
        self.listViewModel = listViewModel
        self.toolViewModel = toolViewModel
        super.init()
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .black
        self.tableFooterView = UIView()
        self.contentInsetAdjustmentBehavior = .never
        
        listViewModel.weatherProvider.weathers.bind(listener: { self.weathers = $0 })
        listViewModel.weatherProvider.getUserWeather()
    }
}
extension WeatherListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return weathers.count }
        else if section == 1 { return 1 }
        else { return 0 }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0, indexPath.row == 0 { return tableViewCellHeight + safeAreaInsets.top }
        if indexPath.section == 1 { return tableViewCellHeight * 0.75 }
        return tableViewCellHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 { return WeatherToolCell(toolViewModel: toolViewModel) }
        else {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
            let hStack = UIStackView()
            hStack.distribution = .equalSpacing
            hStack.layout(using: { proxy in
                proxy.becomeChild(of: cell)
                proxy.leading.equal(to: cell.layoutMarginsGuide.leadingAnchor)
                proxy.trailing.equal(to: cell.layoutMarginsGuide.trailingAnchor)
                proxy.top.equal(to: cell.layoutMarginsGuide.topAnchor, offsetBy: safeAreaInsets.top)
                proxy.bottom.equal(to: cell.safeAreaLayoutGuide.bottomAnchor)
            })
            
            let vStack = UIStackView()
            vStack.axis = .vertical
            vStack.distribution = .fillProportionally
            hStack.addArrangedSubview(vStack)
            
            let sub = UILabel()
            sub.text = "중구"
            let main = UILabel()
            main.text = "나의 위치"
            let temp = UILabel()
            temp.text = "9"
            vStack.addArrangedSubview(sub)
            vStack.addArrangedSubview(main)
            hStack.addArrangedSubview(temp)
            
            return cell
        }
    }
}
extension WeatherListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewModel.fullWeatherResponder.requestFullWeatherView(indexPath.row)
    }
}
public class TableView: UITableView {
    public init() { super.init(frame: .zero, style: .plain) }
    
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) { fatalError("지원하지 않음") }
}
