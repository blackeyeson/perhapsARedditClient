//
//  GreetRouter.swift
//  perhapsARedditClient
//
//  Created by a on 03.09.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

//@objc protocol GreetRoutingLogic
//{
//  //func routeToSomewhere(segue: UIStoryboardSegue?)
//}
//
//protocol GreetDataPassing {
//  var dataStore: GreetDataStore? { get }
//}
//
//class GreetRouter: NSObject, GreetRoutingLogic, GreetDataPassing
//{
//  weak var viewController: GreetViewController?
//  var dataStore: GreetDataStore?
//
//}

protocol GreetRoutingLogic {
    func openURL(stringURL: String)
    func presentMain()
    func presentLogin()
    var viewController: GreetViewController? { get set }
}

final class GreetRouter: GreetRoutingLogic {
    
    // MARK: - Clean Components
    
    weak var viewController: GreetViewController?
    
    // MARK: - Routing
    
    func openURL(stringURL: String) {
        if let url = URL(string: stringURL) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func presentMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.config()
        
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func presentLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        vc.config()
        
        viewController?.present(vc, animated: true, completion: nil)
    }
}
