//
//  RightSideMenuModels.swift
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

enum RightSideMenu {
    // MARK: Use cases
    
    enum getUsername {
        struct Request {  }
        
        struct Response { let username: String }
        
        struct ViewModel { let username: String }
    }
    
    enum removeAcc {
        struct Request {  }
        
        struct Response {  }
        
        struct ViewModel {  }
    }
}
