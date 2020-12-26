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
    
    var screenHeight: CGFloat { UIScreen.main.bounds.height }
    var safeAreaTop: CGFloat { return safeAreaInsets.top }
    var safeAreaBottom: CGFloat { return safeAreaInsets.bottom }
    
    var cellHeight: CGFloat { screenHeight * 0.1025 }
    var topCellHeight: CGFloat { cellHeight + safeAreaTop }
    var toolCellHeight: CGFloat { (cellHeight * 0.75) + safeAreaBottom }
    
    var weathers: [WeatherInformation] = [] {
        didSet {
            print("✅ WeatherListView — 새로운 날씨 정보가 등록되었습니다.")
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        visibleCells.forEach {
            let positionYInView = convert($0.frame, to: self.superview).origin.y
            print(positionYInView + safeAreaInsets.top)
        }
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
        if section == 0 { return 20 }
        else if section == 1 { return 1 }
        else { return 0 }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toolSection(indexPath) { return toolCellHeight }
        if listTopRow(indexPath) { return cellHeight + safeAreaInsets.top }
        else { return cellHeight }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if toolSection(indexPath) {
            let cell = WeatherToolCell(toolViewModel: toolViewModel)
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.cornerRadius = 10
            return cell
        }
        else {
            let cell: WeatherListCell
            
            if indexPath.row == 0 {
                cell = WeatherListCell(type: .top)
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.layer.cornerRadius = 10
                cell.clipsToBounds = true
            } else {
                cell = WeatherListCell(type: .normal)
            }
            return cell
        }
    }
}
extension WeatherListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViewModel.fullWeatherResponder.requestFullWeatherView(indexPath.row)
    }
}
extension WeatherListView {
    func listTopRow(_ indexPath: IndexPath) -> Bool {
        return listSection(indexPath) && indexPath.row == 0
    }
    func listSection(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    func toolSection(_ indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
}
public class TableView: UITableView {
    public init() { super.init(frame: .zero, style: .plain) }
    
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) { fatalError("지원하지 않음") }
}
