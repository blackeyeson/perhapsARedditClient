//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: AnyObject {
    func login(username: String?, password: String?)
    func dismiss()
}

final class LoginViewController: UIViewController {
    // MARK: - Views
    
    @IBOutlet var myView: UIView!
    @IBOutlet var actionButton: UIButton!
    @IBOutlet var changeModeButton: UIButton!
    
    // MARK: - Clean Components
    
    private var interactor: LoginBusinessLogic = LoginInteractor(worker: LoginWorker(apiManager: APIManager()))
    private var router: LoginRoutingLogic & LoginDataPassing = LoginRouter()
    
    // MARK: - Fields
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    var loginMode = true
   
    // MARK: - config
    
    func config() {
        let apiManager = APIManager()
        let worker = LoginWorker(apiManager: apiManager)
        let interactor = LoginInteractor(worker: worker)
        let router = LoginRouter()
        self.interactor = interactor
        self.router = router
        router.viewController = self
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        myView.layer.cornerRadius = 5
        myView.layer.masksToBounds = true
    }
    
    //MARK: - Actions
    
    @IBAction func back(_ sender: Any) {
        dismiss()
    }
    @IBAction func login(_ sender: Any) {
        if loginMode {
            login(username: usernameField.text, password: passwordField.text)
        } else {
            addAcount(username: usernameField.text, password: passwordField.text)
        }
        
    }
    @IBAction func tapOut(_ sender: Any) {
        dismiss()
    }
    @IBAction func SignUp(_ sender: Any) {
        changeMode()
    }
}

// MARK: - DisplayLogic

extension LoginViewController: LoginDisplayLogic {

    func login(username: String?, password: String?) {
        let bool = interactor.didTapLogin(username: username, password: password)
        if bool {
            self.router.loginSuccessNavigateToMain(username: username)
            
        } else {
            print("err/login")
            alertUserWithError(error: "Login failed", message: "User not Found")
        }
    }
    
    func addAcount(username: String?, password: String?) {
        let bool = interactor.didTapSignup(username: username, password: password)
        if bool {
            self.router.loginSuccessNavigateToMain(username: username)
        } else {
            print("err/signup")
            alertUserWithError(error: "Sign up failed", message: nil)
        }
    }
    
    func changeMode() {
        loginMode = !loginMode
        if loginMode {
            actionButton.setTitle("Log in", for: .normal)
            changeModeButton.setTitle("New to Reddit? Sign up", for: .normal)
        } else {
            actionButton.setTitle("Sign Up", for: .normal)
            changeModeButton.setTitle("log in?", for: .normal)
        }
    }
    
    func alertUserWithError(error: String, message: String?) {
        let alert = UIAlertController(title: error, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismiss() {
        router.dismissSelf()
    }
}