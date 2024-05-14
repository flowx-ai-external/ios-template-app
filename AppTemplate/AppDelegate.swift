//
//  AppDelegate.swift
//  AppTemplate
//
//  Created by Bogdan Ionescu on 12.04.2023.
//

import UIKit
import FlowXRenderer
import FXAuthLibrary

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let fxDataSource = MyFXDataSource()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureFXAuth()
        configureFlowX()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

//MARK: Configure FlowX
extension AppDelegate {
    
    func configureFlowX() {
        FXConfig.sharedInstance.configure { (config) in
            config.language = "en-US"
            config.enginePath = EnvironmentConstants.environment.enginePath
            config.baseURL = EnvironmentConstants.environment.baseURL
            config.imageBaseURL = EnvironmentConstants.environment.imageBaseURL
            config.logLevel = .verbose
        }
        
        if let accessToken = FXAuth.sharedInstance.accessToken {
            FXSessionConfig.sharedInstance.configure { (config) in
                config.token = accessToken
                config.sessionManager = FXAuth.sharedInstance.sessionManager()
            }
            FlowX.sharedInstance.startSession()
            
            FXTheme.sharedInstance.setupTheme(withUuid: "{theme-uuid}",
                                              localFileUrl: Bundle.main.url(forResource: "theme", withExtension: "json"),
                                              completion: nil)
        }

        FlowX.sharedInstance.dataSource = fxDataSource
    }
    
}

//MARK: Configure FXAuth
extension AppDelegate: FXAuthDelegate {
    
    func configureFXAuth() {
        FXAuthConfig.sharedInstance.configure { (config) in
            config.authBaseURL = EnvironmentConstants.environment.authBaseURL
            config.clientId = EnvironmentConstants.environment.authClientId
            
            config.useKeychainPersistence = true
            config.keychainServiceName = "FXTemplateAppService"
            config.logEnabled = true
        }
        FXAuth.sharedInstance.authDelegate = self
    }
    
    func accessTokenRefreshed(accessToken: String?) {
        if let accessToken = accessToken {
            FlowX.sharedInstance.updateAuthorization(token: accessToken)
        }
    }
    
    func invalidSession() {
        
    }
    
}
