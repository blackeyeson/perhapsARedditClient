//
//  LoginInteractor.swift
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

protocol LoginBusinessLogic {
    func didTapLogin(username: String?, password: String?) -> Bool
    func didTapSignup(username: String?, password: String?) -> Bool
}

protocol LoginDataStore { }

final class LoginInteractor: LoginDataStore {
//    private let presenter: LoginPresentationLogic
    private let worker: LoginWorkerLogic

    // MARK: - Object Lifecycle
    
    init(worker: LoginWorkerLogic) {
//        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - BusinessLogic

extension LoginInteractor: LoginBusinessLogic {

    func didTapLogin(username: String?, password: String?) -> Bool {
        if username != nil && password != nil && username != "" && password != "" {
            let bool = worker.login(username: username!, password: password!)
            if bool { worker.saveUser(username: username) }
            return bool
        }
        return false
    }
    
    func didTapSignup(username: String?, password: String?) -> Bool {
        if username != nil && password != nil && username != "" && password != "" {
            let bool = worker.register(username: username!, password: password!)
            if bool { worker.saveUser(username: username) }
            return bool
        }
        return false
    }
    
}

