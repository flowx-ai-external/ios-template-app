//
//  Custom1ViewController.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit
import FlowXRenderer

class Custom1ViewController: FXController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var userApplication: UserApplication?
    
    override func populateUI() {
        self.userApplication = (data as? [String: Any])?.decode()
        updateViews()
    }
    
    override func updateUI() {
        self.userApplication = (data as? [String: Any])?.decode()
        updateViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()

    }

    func updateViews() {
        let firstName = userApplication?.firstname ?? "Stranger"
        welcomeLabel.text = "Welcome, \(firstName)!"
    }

    func setupAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.iconImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }
    
    @IBAction func didTouchContinueButton(_ sender: Any) {
        guard let action = actions?.first(where: { $0.name == "continueAction" }) else {
            return
        }
        
        FlowX.sharedInstance.runAction(action: action, params: nil)
    }
}
