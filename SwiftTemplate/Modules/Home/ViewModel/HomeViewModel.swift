//
//  HomeViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didGetNewsData()
    func didFailGettingNewsData()
}

protocol TimerNewsUpdate: AnyObject {
    func updateImageView(at index:Int)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    weak var delegateTimer: TimerNewsUpdate?
    
    private var sectionsTitles = ["News"]
    
    var news = [News]()
    private var viewModels: [TitleCollectionViewCellViewModel] = []
    
    private var timer : Timer?
    
    private var currentCellIndex = 0
    
    func getSectionsCount() -> Int {
        var sections = 0
        if getNewsCount() > 0 {
            sections += 1
        } else if getWelcomeCount() > 0 {
            sections += 1
        }
        return sections
    }
    
    // MARK: Welcome methods
    func getWelcomeData() -> [CollectionTableViewCellViewModel] {
        // Aca estoy trayendo el mock que creaste
        return WelcomeViewModel().moduls
    }
    
    func getWelcomeCount() -> Int {
        // y aca la cantidad
        return WelcomeViewModel().moduls.count
    }
    
    // MARK: News methods
    func getNewsData(){
        DispatchQueue.global().async {
            NewsService.shared.fetchNews { [weak self] news in
                self?.news = news
                self?.getNewsCount() == 0 ? self?.delegate?.didFailGettingNewsData() : self?.delegate?.didGetNewsData()
            } onError: { [weak self] error in
                self?.delegate?.didFailGettingNewsData()
            }
        }
    }
    
    func getNews(at index:Int) -> News{
        return news[index]
    }
    
    func getNewsCount() -> Int{
        return news.count
    }
    
    func getSectionTitle(at index: Int) ->String{
        sectionsTitles[index]
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveNextIndex(){
        if currentCellIndex < 3 {
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        delegateTimer?.updateImageView(at: currentCellIndex)
    }
}
