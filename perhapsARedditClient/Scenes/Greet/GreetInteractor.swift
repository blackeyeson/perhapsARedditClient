//
//  GreetInteractor.swift
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

protocol GreetBusinessLogic {
    func saveGuest(request: Greet.skipLogin.Request)
    func didTapUnsupported(request: Greet.unsupportedAlert.Request)
}

class GreetInteractor: GreetBusinessLogic {
    private let worker: GreetWorkerLogic
    private let presenter: GreetPresentationLogic

    init(worker: GreetWorkerLogic, presenter: GreetPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func didTapUnsupported(request: Greet.unsupportedAlert.Request) {
        let alert = request.alert
        
        presenter.presentAlert(response: Greet.unsupportedAlert.Response(alert: alert))
    }
    
    func saveGuest(request: Greet.skipLogin.Request) {
        worker.loginAsGuest(response: Greet.skipLogin.Response())
    }
}
