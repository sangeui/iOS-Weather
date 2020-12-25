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
    var viewModel: WeatherListViewModel
    var height: NSLayoutConstraint!
    
    var safeAreaTop: CGFloat { window?.safeAreaInsets.top ?? 0 }
    
    var weathers: [WeatherInformation] = [] {
        didSet {
            print("✅ WeatherListView — 새로운 날씨 정보가 등록되었습니다.")
            DispatchQueue.main.async {
                self.height.constant = CGFloat(self.weathers.count) * (75 + self.safeAreaTop)
                self.reloadData()
            }
        }
    }
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init()
        self.height = self.heightAnchor.constraint(equalToConstant: 0)
        self.height.isActive = true
        
        self.delegate = self
        self.dataSource = self
        
        viewModel.weatherProvider.weathers.bind(listener: { self.weathers = $0 })
        viewModel.weatherProvider.getUserWeather()
    }
}
extension WeatherListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let test = "\(Date(timeIntervalSince1970: self.weathers[indexPath.row].weather?.current?.dt ?? 0))"
        
        cell.textLabel?.text = test
        
        return cell
        
    }
}
extension WeatherListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.fullWeatherResponder.requestFullWeatherView(indexPath.row)
    }
}
public class TableView: UITableView {
    public init() { super.init(frame: .zero, style: .plain) }
    
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) { fatalError("지원하지 않음") }
}
