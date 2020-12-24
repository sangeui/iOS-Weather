//
//  ViewController.swift
//  WeatherUIKit
//
//  Created by 서상의 on 2020/12/24.
//

import UIKit

open ViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable, message: "지원하지 않음")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable, message: "지원하지 않음")
    public required init?(coder aDecoder: NSCoder) {
      fatalError("지원하지 않음")
    }
}
