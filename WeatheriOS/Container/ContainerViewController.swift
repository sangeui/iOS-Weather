//
//  ContainerViewController.swift
//  WeatheriOS
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit
import WeatherUIKit
import WeatherKit

public class ContainerViewController: ViewController {
    let containerViewModel: ContainerViewModel
    let pageViewController: PageViewController
    let simpleWeatherViewController: WeatherSimpleViewController
    let initialViewController: InitialViewController
    
    init(containerViewModel: ContainerViewModel,
         initialViewController: InitialViewController,
         pageViewController: PageViewController,
         simpleWeatherViewController: WeatherSimpleViewController) {
        self.containerViewModel = containerViewModel
        self.initialViewController = initialViewController
        self.pageViewController = pageViewController
        self.simpleWeatherViewController = simpleWeatherViewController
        
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        listenViewState()
    }
    
    func listenViewState() {
        containerViewModel.view.bind(listener: move(to:))
    }
    func move(to view: WeatherView) {
        switch view {
        case .simple:
            simpleWeatherViewController.modalPresentationStyle = .fullScreen
            addFullScreen(childViewController: simpleWeatherViewController)
        case .full(_):
            self.present(pageViewController, animated: true, completion: nil)
        case .initial:
            addFullScreen(childViewController: initialViewController)
        }
    }
}
extension UIViewController {

  // MARK: - Methods
  public func addFullScreen(childViewController child: UIViewController) {
    guard child.parent == nil else {
      return
    }

    addChild(child)
    view.addSubview(child.view)

    child.view.translatesAutoresizingMaskIntoConstraints = false
    let constraints = [
      view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
      view.topAnchor.constraint(equalTo: child.view.topAnchor),
      view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
    ]
    constraints.forEach { $0.isActive = true }
    view.addConstraints(constraints)

    child.didMove(toParent: self)
  }

  public func remove(childViewController child: UIViewController?) {
    guard let child = child else {
      return
    }

    guard child.parent != nil else {
      return
    }
    
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
}
