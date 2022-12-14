//
//  GreetPresenter.swift
//  perhapsARedditClient
//
//  Created by a on 19.09.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GreetPresentationLogic {
    func presentAlert(response: Greet.unsupportedAlert.Response)
}

class GreetPresenter: GreetPresentationLogic {
    // MARK: - Clean Components
    
    weak var viewController: GreetDisplayLogic?
    
}

// MARK: - PresentationLogic

extension GreetPresenter {
    
    func presentAlert(response: Greet.unsupportedAlert.Response) {
        viewController?.presentAlert(viewModel: Greet.unsupportedAlert.ViewModel(alert: response.alert))
    }
}
