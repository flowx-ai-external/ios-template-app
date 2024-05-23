//
//  DashboardViewController.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit
import FlowXRenderer
import FXAuthLibrary
import Combine

class DashboardViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.layer.cornerRadius = 28
            startButton.layer.masksToBounds = true
        }
    }

    
    var processNavigationController = FXNavigationViewController.navigationController()
    var subscription: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAuthButton()

    }

    func setupAuthButton() {
        if let _ = FXAuth.sharedInstance.accessToken {
            authButton.setTitle("Logout", for: .normal)
        } else {
            authButton.setTitle("Login", for: .normal)
        }
    }

    @IBAction func didTouchAuthButton(_ sender: Any) {
        if let _ = FXAuth.sharedInstance.accessToken {
            FXAuth.sharedInstance.logout {
                self.setupAuthButton()
            }
        } else {
            showLogin()
        }
    }
    
    @IBAction func didTouchStartProcess(_ sender: Any) {
        subscription = FXTheme.sharedInstance.themeFetched.sink { fetched in
            if fetched {
                DispatchQueue.main.async {
                    self.attemptStartProcess()
                }
            }
        }
    }
    
    //MARK: Start process

    func attemptStartProcess() {
        FXAuth.sharedInstance.getAccessToken { accessToken in
            if accessToken != nil {
                self.startProcess()
            } else {
                self.showLogin()
            }
        }
    }

    func startProcess() {
        
        processNavigationController = FXNavigationViewController.navigationController()

        FlowX.sharedInstance.startProcess(navigationController: processNavigationController,
                                          name: ProcessConstants.templateProcess,
                                          params: [:],
                                          isModal: true,
                                          showLoader: true)
  
        processNavigationController.modalPresentationStyle = .overFullScreen
        self.present(processNavigationController, animated: true, completion: nil)
    }
    
    //MARK: Login
    
    func showLogin() {
        let loginViewController: LoginViewController = viewController()
        loginViewController.completion = { [weak self] in
            self?.handleSuccessfulLogin()
        }
        present(loginViewController, animated: true, completion: nil)
    }
    
    func handleSuccessfulLogin() {
        setupAuthButton()

        FXSessionConfig.sharedInstance.configure { (config) in
            config.token = FXAuth.sharedInstance.accessToken
            config.sessionManager = FXAuth.sharedInstance.sessionManager()
        }
        
        if let accessToken = FXAuth.sharedInstance.accessToken {
            FlowX.sharedInstance.updateAuthorization(token: accessToken)
        }
        
        subscription?.cancel()
        FXTheme.sharedInstance.setupTheme(withUuid: ProcessConstants.themeId,
                                          localFileUrl: Bundle.main.url(forResource: "theme", withExtension: "json"),
                                          completion: nil)
    }
    
}
