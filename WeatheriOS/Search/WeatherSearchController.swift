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
    static func makeNavigationBar(with items: [UINavigationItem], style: UIBarStyle = .black, tint: UIColor = .white) -> UINavigationBar {
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

class WeatherSearchController: ViewController {
    private var navBar: UINavigationBar!
    private var navItem: UINavigationItem!
    private var searchBar: WeatherSearchBar!
    
    private let holder = "Search"
    private let prompt = "Enter city, postcode or airport location"
    
    private let resultTableView = UITableView()
    
    private var searchResults = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    
    private let searchResponder: SearchResponder
    private var emptyResults: Bool = false
    
    init(searchResponder: SearchResponder) {
        self.searchResponder = searchResponder
        super.init()
        
        searchBar = WeatherSearchBar(delegate: self, placeHolder: holder)
        navItem = UINavigationItem.makeNavigationItem(prompt: prompt, titleView: searchBar)
        navBar = UINavigationBar.makeNavigationBar(with: [navItem])
        
        navBar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.height.equal(toConstant: 44)
        })
        
        resultTableView.backgroundView = UIVisualEffectView.makeVisualEffectView()
        resultTableView.separatorStyle = .none
        resultTableView.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: navBar.bottomAnchor)
        })
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = searchBar.text!
        
        resultTableView.dataSource = self
        resultTableView.delegate = self
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
        if emptyResults || (searchCompleter.isSearching && !searchBar.text!.isEmpty) { return 1 }
        else { return searchResults.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchCompleter.isSearching && indexPath.row == 0 && searchResults.isEmpty {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Indicator")
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .gray
            cell.textLabel?.text = "validating city..."
            return cell
        } else if emptyResults {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Indicator")
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .gray
            cell.textLabel?.text = "No results found."
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "SearchCell")
            let result = searchResults[indexPath.row]
            cell.textLabel?.text = result.title + " " + result.subtitle
            cell.textLabel?.textColor = .gray
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension WeatherSearchController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !searchResults.isEmpty { searchBar.endEditing(true) }
    }
}
extension WeatherSearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResponder.closeSearchView()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResults.removeAll(); resultTableView.reloadData()
            emptyResults = false
        }
        else {
            resultTableView.reloadData()
            searchCompleter.pointOfInterestFilter = .init(including: [.airport])
            searchCompleter.resultTypes = [.address, .pointOfInterest]
            searchCompleter.queryFragment = searchText
        }
    }
}
extension WeatherSearchController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completer.results.forEach { print($0.title, "||||", $0.subtitle)}
        searchResults = completer.results.filter {
            if Int($0.title) != nil { return true }
            else if $0.title.components(separatedBy: ",").count > 1,
                    $0.subtitle.isEmpty { return true }
            else { return false }
        }
        if searchResults.count == 0 { emptyResults = true }
        else { emptyResults = false }
        resultTableView.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error)
    }
}
