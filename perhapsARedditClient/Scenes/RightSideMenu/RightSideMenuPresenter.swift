//
//  RightSideMenuPresenter.swift
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

protocol RightSideMenuPresentationLogic {
    func presentUsername(response: RightSideMenu.getUsername.Response)
}

class RightSideMenuPresenter: RightSideMenuPresentationLogic {
    // MARK: - Clean Components
    
    weak var viewController: RightSideMenuDisplayLogic?
}

// MARK: - PresentationLogic

extension RightSideMenuPresenter {

    
    func presentUsername(response: RightSideMenu.getUsername.Response) {
        let viewmodel = response.username
        viewController?.displayUsername(ViewModel: RightSideMenu.getUsername.ViewModel(username: viewmodel))
    }
}

