//
//  Custom2ViewController.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit
import FlowXRenderer
import SwiftUI

class Custom2ViewModel: ObservableObject {
    
    @Published var userApplication: UserApplication?
    
}

class Custom2ViewController: FXController {

    var childViewController: UIHostingController<Custom2View>?
    @ObservedObject var viewModel = Custom2ViewModel()
    
    
    override func populateUI() {
        viewModel.userApplication = (data as? [String: Any])?.decode()
    }
    
    override func updateUI() {
        viewModel.userApplication = (data as? [String: Any])?.decode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        childViewController = UIHostingController(rootView: Custom2View(viewModel: viewModel))
        
        addChild(childViewController!)
        view.addSubview(childViewController!.view)

        childViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        childViewController?.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        childViewController?.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        childViewController?.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        childViewController?.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        childViewController?.didMove(toParent: self)

        childViewController?.rootView.continueCallback = continueCallback
        
    }
    
    lazy var continueCallback: () -> Void = { [weak self] in
        if let action = self?.actions?.first {
            FlowX.sharedInstance.runAction(action: action)
        }
    }
    
}
