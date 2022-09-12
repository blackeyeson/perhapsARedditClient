//
//  MainScreenWorker.swift
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

protocol MainScreenWorkerLogic {
    func fetchPosts(subreddit: String, timePeriod: String, numberOfPosts: Int) async throws -> RedditPosts
}

final class MainScreenWorker: MainScreenWorkerLogic {
    // MARK: - Fields
    
    private var api: APIManager
    
    init(apiManager: APIManager) {
        self.api = apiManager
    }
    
    // MARK: - Methods
    
    func fetchPosts(subreddit: String, timePeriod: String, numberOfPosts: Int) async throws -> RedditPosts {
        let sub = try await api.getUserDefaults(Key: "subreddit", type: String.self)
        let time = try await api.getUserDefaults(Key: "timePeriod", type: String.self)
        return try await api.fetchData(
            urlString: "https://www.reddit.com/r/\(sub ?? subreddit)/top/.json?t=\(time ?? timePeriod)&limit=\(100)",
            decodingType: RedditPosts.self
        )
    }
}
