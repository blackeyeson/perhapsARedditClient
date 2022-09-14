//
//  RightSideMenuViewController.swift
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

protocol LeftSideMenuDisplayLogic: AnyObject {
    func dismiss()
    func updateMain()
    func selectRow(int: Int)
    func displaySubs(viewModel: LeftSideMenu.getSubs.ViewModel)
}

final class LeftSideMenuViewController: UIViewController {
    // MARK: - Clean Components
    
    private var interactor: LeftSideMenuBusinessLogic = LeftSideMenuInteractor(worker: LeftSideMenuWorker(apiManager: APIManager()), presenter: leftSideMenuPresenter())
    private var router: LeftSideMenuRoutingLogic & LeftSideMenuDataPassing = LeftSideMenuRouter()
    
    // MARK: - View
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // MARK: - Fields
    
    private var dataSource = [String]()
    private var filterString = ""
    var subs = ["cats", "PixelArt", "memes", "gaming", "pics", "MadeMeSmile", "HolUp", "interestingasfuck", "shittymoviedetails", "pcmasterrace", "therewasanattempt", "aww", "meirl", "PrequelMemes", "ThatsInsane", "funny", "mildlyinfuriating"]
    var urls = [
        "https://styles.redditmedia.com/t5_2qhta/styles/communityIcon_2fsd7ji8awg91.png",
        "https://styles.redditmedia.com/t5_2ql09/styles/communityIcon_k7ch3e2u2m711.png",
        "https://styles.redditmedia.com/t5_2qjpg/styles/communityIcon_bzdtpod2vtv81.png",
        "https://styles.redditmedia.com/t5_2qh03/styles/communityIcon_1isvxgkk7hw51.png",
        "https://b.thumbs.redditmedia.com/VZX_KQLnI1DPhlEZ07bIcLzwR1Win808RIt7zm49VIQ.png",
        "https://styles.redditmedia.com/t5_2uqcm/styles/communityIcon_kfqpkjbvpv001.png",
        "https://styles.redditmedia.com/t5_qir9n/styles/communityIcon_kbu1joqjxok81.png",
        "https://styles.redditmedia.com/t5_2qhsa/styles/communityIcon_5v3bepmshpg81.png",
        nil,
        "https://styles.redditmedia.com/t5_2sgp1/styles/communityIcon_1mit7n6qhy481.png",
        "https://styles.redditmedia.com/t5_39ne7/styles/communityIcon_k0dgce7sy1721.png",
        "https://styles.redditmedia.com/t5_2qh1o/styles/communityIcon_6fzlk8ukx6s51.jpg",
        "https://b.thumbs.redditmedia.com/4ADRnu2cwKIkpQt0N-g36-iq6EfTNFVV1RComMcEZiU.png",
        "https://styles.redditmedia.com/t5_3i60n/styles/communityIcon_pnk38l2ezem91.png",
        "https://b.thumbs.redditmedia.com/_LjV26levDKqJsKKZUPIr2lmD2QY-CWYKsXse5J9fnw.png",
        "https://a.thumbs.redditmedia.com/kIpBoUR8zJLMQlF8azhN-kSBsjVUidHjvZNLuHDONm8.png",
        "https://styles.redditmedia.com/t5_2ubgg/styles/communityIcon_lkxajjefezh51.png"
    ]
    
    var subreddits: [String] = []
    var urlStrings: [String?] = []
    // MARK: - config
    
    func config() {
        let presenter = leftSideMenuPresenter()
        let apiManager = APIManager()
        let worker = LeftSideMenuWorker(apiManager: apiManager)
        let interactor = LeftSideMenuInteractor(worker: worker, presenter: presenter)
        let router = LeftSideMenuRouter()
        self.interactor = interactor
        self.router = router
        router.viewController = self
        presenter.viewController = self
    }
    
    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        subreddits = subs
        urlStrings = urls
        Task { await interactor.getSubs(request: LeftSideMenu.getSubs.Request()) }
        setupView()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        tableConfiguration()
        pickerViewConfig()
        searchBarConfig()
    }
    
    private func pickerViewConfig() {
        pickerView.dataSource = self
        pickerView.delegate = self
        Task { await interactor.selectRow() }
    }
    
    private func setTableData(data: [String]) {
        self.dataSource = data
        tableView.reloadData()
    }
    
    private func searchBarConfig() {
        searchBar.delegate = self
        searchBar.barStyle = UIBarStyle.black
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
    }
    
    //MARK: - actions
    
    @IBAction func tap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func swipe(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pics(_ sender: Any) {
        changeSub(sub: "pics")
    }
    @IBAction func photography(_ sender: Any) {
        changeSub(sub: "memes")
    }
    @IBAction func pixelart(_ sender: Any) {
        changeSub(sub: "PixelArt")
    }
    @IBAction func cat(_ sender: Any) {
        changeSub(sub: "cat")
    }

    //MARK: - functions
    
    func changeSub(sub: String) {
        interactor.didTapSubreddit(request: LeftSideMenu.setSub.Request(subreddit: sub))
        updateMain()
    }

    func changeTimePeriod(period: String) {
        interactor.didTapTimePeriod(request: LeftSideMenu.setperiod.Request(timePeriod: period))
        updateMain()
    }
    
    func rowToString(row: Int) -> String {
        switch row {
        case 0:
            return "day"
        case 1:
            return "week"
        case 2:
            return "month"
        case 3:
            return "year"
        case 4:
            return "all"
        default:
            print("error \(row)")
            return "day"
        }
    }
}

// MARK: - pickerView
extension LeftSideMenuViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { 5 }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rowToString(row: row)
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let returnString = rowToString(row: row)
        return NSAttributedString(string: returnString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
    inComponent component: Int) {
        let period = rowToString(row: row)
        changeTimePeriod(period: period)
    }
}

// MARK: - DisplayLogic
extension LeftSideMenuViewController: LeftSideMenuDisplayLogic {
    
    func displaySubs(viewModel: LeftSideMenu.getSubs.ViewModel) {
        setTableData(data: viewModel.subNames)
        tableView.reloadData()
    }
    
    func selectRow(int: Int) {
        pickerView.selectRow(int, inComponent: 0, animated: false)
    }
    
    func dismiss() {
        router.dismissSelf()
    }
    func updateMain() {
        NotificationCenter.default.post(name: Notification.Name("com.testCompany.Notification.reloadData"), object: nil)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension LeftSideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if filterString != "" {
//            return dataSource.filter { $0.contains(filterString) }.count
//        } else {
//            return dataSource.count
//        }
        subreddits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var model = dataSource[indexPath.row]

        let model = subreddits[indexPath.row]
        let url = urlStrings[indexPath.row]
        
//        if filterString != "" {
//            model = dataSource.filter { $0.contains(filterString) }[indexPath.row]
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//        cell.config(subredditName: model)
        cell.configure(sub: model, icon: url)
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        changeSub(sub: subreddits[indexPath.row])
        subreddits = subs
        urlStrings = urls
    }
    
    //MARK: - functions
    
    func tableConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.reloadData()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
//            self?.tableView.reloadData()
//        }
    }
}

//MARK: - SearchBar
extension LeftSideMenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        subreddits = subs
        urlStrings = urls
        if !searchText.isEmpty {
            var returnSubs = [String]()
            var returnUrls = [String?]()
            
            for i in 0...subs.count-1 {
                if subs[i].contains(searchText) {
                    returnSubs += [subs[i]]
                    returnUrls += [urls[i]]
                }
            }
            
            subreddits = returnSubs
            urlStrings = returnUrls
        }
        tableView.reloadData()
    }
}
