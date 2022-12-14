//
//  LoginModels.swift
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

enum Login {
  // MARK: Use cases
  
    enum login {
        struct Request { let username: String?; let password: String? }

        struct Response { let username: String; let success: Bool }

        struct ViewModel { let username: String?; let password: String? }
    }
    
    enum dismiss {
        struct Request {  }

        struct Response {  }

        struct ViewModel {  }
    }
   
    enum register {
        struct Request { let username: String?; let password: String? }
        
        struct Response { let username: String; let success: Bool }
        
        struct ViewModel { let username: String }
    }
}
