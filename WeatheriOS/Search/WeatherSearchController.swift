//
//  SearchController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/27.
//

import UIKit
import WeatherUIKit
import WeatherKit
import MapKit

private extension UINavigationItem {
    static func makeNavigationItem(prompt: String, titleView: UIView? = nil) -> UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.prompt = prompt
        navigationItem.titleView = titleView
        
        return navigationItem
    }
}
private extension UINavigationBar {
    typealias Items = [UINavigationItem]
    static func makeNavigationBar(with items: Items, style: UIBarStyle = .black, tint: UIColor = .white) -> UINavigationBar {
        let navigationBar = UINavigationBar()
        navigationBar.setItems(items, animated: true)
        navigationBar.barStyle = style
        navigationBar.tintColor = tint
        
        return navigationBar
    }
}
private extension UIVisualEffectView {
    static func makeVisualEffectView() -> UIVisualEffectView {
        let effect = UIBlurEffect(style: .systemThickMaterialDark)
        let effectView = UIVisualEffectView(effect: effect)
        return effectView
    }
}
private extension UITableView {
    typealias Delegate = UITableViewDelegate & UITableViewDataSource
    
    static func makeTableView(delegate: Delegate, backgroundView: UIView? = nil) -> UITableView {
        let tableView = UITableView()
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.backgroundView = backgroundView
        tableView.separatorStyle = .none
        return tableView
    }
}
private extension MKLocalSearchCompleter {
    typealias Delegate = MKLocalSearchCompleterDelegate
    static func makeCompleter(delegate: Delegate) -> MKLocalSearchCompleter {
        let completer = MKLocalSearchCompleter()
        completer.delegate = delegate
        completer.pointOfInterestFilter = .init(including: [.airport])
        completer.resultTypes = [.address, .pointOfInterest]
        return completer
    }
}

class WeatherSearchController: ViewController {
    // MARK: - 유저 인터페이스
    private var searchBar: WeatherSearchBar!
    private var navBar: UINavigationBar!
    private var navItem: UINavigationItem!
    private var resultTableView: UITableView!
    // MARK: -
    private let holder = "Search"
    private let prompt = "Enter city, postcode or airport location"
    // MARK: -
    private var searchCompleter: MKLocalSearchCompleter!
    private var searchResults = [MKLocalSearchCompletion]()
    
    private let searchResponder: SearchResponder
    
    private var searchResultsCache = [String:[MKLocalSearchCompletion]]()
    private var emptyResults: Bool = false
    
    init(searchResponder: SearchResponder) {
        self.searchResponder = searchResponder
        super.init()
        
        // 프로퍼티 초기화
        searchBar = WeatherSearchBar(delegate: self, placeHolder: holder)
        navItem = UINavigationItem.makeNavigationItem(prompt: prompt, titleView: searchBar)
        navBar = UINavigationBar.makeNavigationBar(with: [navItem])
        resultTableView = UITableView.makeTableView(delegate: self, backgroundView: UIVisualEffectView.makeVisualEffectView())
        searchCompleter = MKLocalSearchCompleter.makeCompleter(delegate: self)
        
        navBar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.height.equal(toConstant: 44)
        })
        
        resultTableView.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: navBar.bottomAnchor)
        })
    }
    
    @objc func willEnterForeground() {
        self.searchBar.becomeFirstResponder()
    }
    @objc func didEnterBackground() {
        self.searchBar.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async { self.searchBar.becomeFirstResponder() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.searchBar.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}
extension WeatherSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
//        if emptyResults || (searchCompleter.isSearching && !searchBar.text!.isEmpty) { return 1 }
//        else { return searchResults.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherSearchResultCell(reuseIdentifier: "ResultCell")
        let result = searchResults[indexPath.row]
        let text = result.combineTitleWithSpace
        
        if let nsText = text as? NSString {
            let nsRange = nsText.range(of: searchCompleter.queryFragment)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: nsRange)
            cell.setAttributedText(attributedText)
        } else {
            cell.setText(text)
        }
        return cell
//        if searchCompleter.isSearching && indexPath.row == 0 && searchResults.isEmpty {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "Indicator")
//            cell.backgroundColor = .clear
//            cell.textLabel?.textColor = .gray
//            cell.textLabel?.text = "validating city..."
//            return cell
//        } else if emptyResults {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "Indicator")
//            cell.backgroundColor = .clear
//            cell.textLabel?.textColor = .gray
//            cell.textLabel?.text = "No results found."
//            return cell
//        } else {
//
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension WeatherSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < searchResults.count else { return }
        let result = searchResults[indexPath.row]
        MKLocalSearch(request: MKLocalSearch.Request(completion: result)).start { (response, error) in
            guard let response = response else { return }
            print(response.boundingRegion.center.latitude, response.boundingRegion.center.longitude)
            print(response.mapItems.first?.name)
            print(response.mapItems)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤이 되었을 때, 사용자가 목록을 볼 수 있도록 키보드 인터페이스를 숨겨야 한다.
        if !searchResults.isEmpty { searchBar.endEditing(true) }
    }
}
extension WeatherSearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // UISearchBar의 취소 버튼이 터치되면, 현재 뷰 컨트롤러를 끝내야 한다.
        searchResponder.closeSearchView()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { searchResults.removeAll(); emptyResults = false }
//        else if let cachedResults = searchResultsCache[searchText] { searchResults = cachedResults }
        else { searchCompleter.queryFragment = searchText }
        resultTableView.reloadData()
    }
}
extension WeatherSearchController: MKLocalSearchCompleterDelegate {
    func appleWeatherLike(completion: MKLocalSearchCompletion) -> Bool {
        // 사용자가 우편번호를 입력했을 경우
        if completion.title.isInteger { return true }
        // 행정구역의 경우 subtitle이 존재하지 않으며, title은 하나 이상의 쉼표로 구분되어 있다
        else if completion.title.isSeparated(by: ","), completion.subtitle.isEmpty { return true }
        else { return false }
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        print(completer.queryFragment)
//        print(completer.results.forEach({ print($0.combineTitleWithSpace) }))
//        let filteredResults = completer.results.filter(appleWeatherLike(completion:))
//        searchResultsCache.updateValue(filteredResults, forKey: completer.queryFragment)
        searchResults = completer.results
        // 필터 결과, 전달할 결과가 존재하지 않으면 적절한 프로퍼티를 참으로 설정한다
//        if filteredResults.isEmpty { emptyResults = true }
//        // 그렇지 않으면 거짓으로 설정한다
//        else { emptyResults = false }
        
        resultTableView.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
