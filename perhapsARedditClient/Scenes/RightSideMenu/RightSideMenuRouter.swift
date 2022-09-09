//
//  RightSideMenuRouter.swift
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

protocol RightSideMenuRoutingLogic {
    func backToStart()
    func dismissSelf()
}

protocol RightSideMenuDataPassing { }

final class RightSideMenuRouter: RightSideMenuRoutingLogic, RightSideMenuDataPassing {
    // MARK: - Clean Components
    
    weak var viewController: RightSideMenuViewController?
    
    // MARK: - Routing
    
    func backToStart() {
        let destinationVC = GreetConfigurator.configure()
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    func dismissSelf() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
