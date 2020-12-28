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
    var listTopCellHeight: CGFloat { cellHeight + safeAreaTop }
    var toolCellHeight: CGFloat { (cellHeight * 0.75) + safeAreaBottom }
    
    var sampleNumber = 5
    
    var weathers: [WeatherInformation] = [] {
        didSet {
            print("✅ WeatherListView — 새로운 날씨 정보가 등록되었습니다.")
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if abs(contentOffset.y) > safeAreaTop {
            
        }
        for visibleCell in visibleCells {
            guard let cell = visibleCell as? WeatherListCell else { continue }
            let positionYInView = convert(visibleCell.frame, to: self.window).origin.y
            let position: CGFloat
            if cell.isListTopRow { position = positionYInView + safeAreaTop }
            else { position = positionYInView }
            if safeAreaTop > position {
                cell.clipViewHeightConstraint?.constant = cell.clipViewHeight! - (safeAreaTop - position)
            } else {
                cell.clipViewHeightConstraint?.constant = cell.clipViewHeight ?? 0
            }
            
            if positionYInView > safeAreaTop {
            }
        }
    }
    
    init(listViewModel: WeatherListViewModel, toolViewModel: WeatherToolViewModel) {
        self.listViewModel = listViewModel
        self.toolViewModel = toolViewModel
        super.init()
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .gray
        self.contentInsetAdjustmentBehavior = .never
        self.separatorStyle = .none
    }
}
extension WeatherListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isToolSection(section) { return 1 }
        else { return sampleNumber }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toolSection(indexPath) { return toolCellHeight }
        if listTopRow(indexPath) { return listTopCellHeight }
        else { return cellHeight }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if toolSection(indexPath) { return makeToolCell() }
        else if listTopRow(indexPath) { return makeListTopCell() }
        else if listBottomRow(indexPath) { return makeListBottomCell() }
        else { return makeListCell(.normal) }
    }
}
extension WeatherListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isListSection(indexPath.section) {
            listViewModel.fullWeatherResponder.requestFullWeatherView(indexPath.row)
        }
    }
}
private extension WeatherListView {
    func makeToolCell() -> WeatherToolCell {
        return WeatherToolCell(toolViewModel: toolViewModel)
    }
    func makeListTopCell() -> WeatherListCell {
        let cell = makeListCell(.top(safeAreaTop))
        return cell
    }
    func makeListBottomCell() -> WeatherListCell {
        let cell = makeListCell(.normal)
        cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    func makeListCell(_ type: ListCellType) -> WeatherListCell {
        return WeatherListCell(type: type)
    }
    func isListSection(_ section: Int) -> Bool {
        return section == 0
    }
    func isToolSection(_ section: Int) -> Bool {
        return section == 1
    }
    func listTopRow(_ indexPath: IndexPath) -> Bool {
        return listSection(indexPath) && indexPath.row == 0
    }
    func listBottomRow(_ indexPath: IndexPath) -> Bool {
        return listSection(indexPath) && indexPath.row == sampleNumber - 1
    }
    func listSection(_ indexPath: IndexPath) -> Bool {
        return isListSection(indexPath.section)
    }
    func toolSection(_ indexPath: IndexPath) -> Bool {
        return isToolSection(indexPath.section)
    }
}
public class TableView: UITableView {
    public init() { super.init(frame: .zero, style: .plain) }
    
    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder: NSCoder) { fatalError("지원하지 않음") }
}
