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

class WeatherSearchController: ViewController {
    private let searchBar = WeatherSearchBar(placeHolder: "Search")
    private let containerBar = UINavigationBar()
    private let containerItem = UINavigationItem()
    
    private let resultView = UITableView()
    
    private var searchResults = [MKLocalSearchCompletion]()
    private let searchCompleter = MKLocalSearchCompleter()
    
    private let searchResponder: SearchResponder
    
    init(searchResponder: SearchResponder) {
        self.searchResponder = searchResponder
        super.init()
        
        searchBar.delegate = self
        containerItem.prompt = "Enter city, postcode or airport location"
        containerItem.titleView = searchBar
        containerBar.setItems([containerItem], animated: true)
        containerBar.tintColor = .white
        containerBar.barStyle = .black
        
        containerBar.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.top.equal(to: self.view.topAnchor)
            proxy.height.equal(toConstant: 44)
        })
        
        let blurEffect = UIBlurEffect(style: .systemThickMaterialDark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        
        resultView.backgroundView = blurredEffectView
        resultView.backgroundColor = .clear
        resultView.separatorStyle = .none
        resultView.layout(using: { proxy in
            proxy.becomeChild(of: self.view)
            proxy.leading.equal(to: self.view.leadingAnchor)
            proxy.trailing.equal(to: self.view.trailingAnchor)
            proxy.bottom.equal(to: self.view.bottomAnchor)
            proxy.top.equal(to: containerBar.bottomAnchor)
        })
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = searchBar.text!
        
        resultView.dataSource = self
        resultView.delegate = self
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SearchCell")
        let result = searchResults[indexPath.row]
        cell.textLabel?.text = result.title + " " + result.subtitle
        cell.textLabel?.textColor = .gray
        cell.backgroundColor = .clear
        return cell
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
        if searchText.isEmpty { searchResults.removeAll(); resultView.reloadData()}
        else {
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
            else if $0.title.components(separatedBy: .whitespaces).count == 1 { return true }
            else { return $0.subtitle.isEmpty }
        }
        resultView.reloadData()
    }
    
    private func completer(completer: MKLocalSearchCompleter, didFailWithError error: NSError) {
        // handle error
    }
}
