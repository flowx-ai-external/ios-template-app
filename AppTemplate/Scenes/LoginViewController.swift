//
//  LoginViewController.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit
import FXAuthLibrary

class LoginViewController: UIViewController {

    var completion: (() -> Void)?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 28
            loginButton.layer.masksToBounds = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTouchLoginButton(_ sender: Any) {
        submitForm()
    }

    func submitForm() {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                  return
              }
        
        FXAuth.sharedInstance.loginUser(withUsername: email, password: password) { success, error in
            if success {
                self.dismiss(animated: true) {
                    self.completion?()
                }
            } else {
                self.showFailureAlert()
            }
        }
    }
    
    func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "Login failed", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
}
