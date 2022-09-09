//
//  MainScreenInteractor.swift
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

protocol MainScreenBusinessLogic {
    func getPosts(request: MainScreen.GetPosts.Request)
//    func didTapCountry(request: Table.ShowCountryDetails.Request)
}

protocol MainScreenDataStore {
//    var selectedCountry: Country? { get }
}

final class MainScreenInteractor: MainScreenDataStore {
    private let presenter: MainScreenPresentationLogic
    private let worker: MainScreenWorkerLogic
    
    var redditPosts: RedditPosts? = nil
//    private(set) var selectedCountry: Country?
    
    // MARK: - Object Lifecycle
    
    init(presenter: MainScreenPresentationLogic, worker: MainScreenWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - CountriesBusinessLogic

extension MainScreenInteractor: MainScreenBusinessLogic {

//    func didTapCountry(request: MainScreen.ShowCountryDetails.Request) {
//        self.selectedCountry = countries.first { $0.latlng == request.coord}
//        presenter.presentSelectedCountry(response: Table.ShowCountryDetails.Response())
//    }
    
    func getPosts(request: MainScreen.GetPosts.Request) {
        Task {
            do {
                let redditPosts = try await worker.fetchPosts(subreddit: request.subreddit, timePeriod: request.timePeriod, numberOfPosts: request.numberOfPosts)
                DispatchQueue.main.async { [weak self] in
                    self?.redditPosts = redditPosts
                    self?.presenter.presentPosts(response: MainScreen.GetPosts.Response(data: redditPosts))
                }
            } catch { print(error) }
        }
    }
}
