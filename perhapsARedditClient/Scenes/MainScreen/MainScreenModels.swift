//
//  MainScreenModels.swift
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

enum MainScreen
{
    // MARK: Use cases
    
    enum GetPosts {
        
        struct Request { let subreddit: String; let timePeriod: String; let numberOfPosts: Int }
        
        struct Response { let data: RedditPosts; let hiddenPosts: [String]; let iconUrlString: String }
        
        struct ViewModel { let tableData: [PostForTable]; let hiddenPosts: [String] }
    }
    
    enum ShowPostDetails {
        
        struct Request { let postId: String }
        
        struct Response {  }
        
        struct ViewModel {  }
    }
}
