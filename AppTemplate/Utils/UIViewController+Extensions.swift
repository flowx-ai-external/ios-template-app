//
//  UIViewController+Extensions.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit

func viewController<T: UIViewController>() -> T {
    let storyboard = UIStoryboard(name: "Main", bundle: .main)
    return storyboard.instantiateViewController(identifier: String.init(describing: T.self))
}
