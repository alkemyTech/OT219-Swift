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
    // func didFailAllServices()
}

protocol TimerNewsUpdate: AnyObject {
    func updateImageView(at index:Int)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    weak var delegateTimer: TimerNewsUpdate?
    
    private var sectionsTitles = ["News"]
    
    var news = [News]()
    
    private var timer : Timer?
    
    private var currentCellIndex = 0
    
    private var isServiceNewsAvailable = false
    private var isServiceSlidesAvailable = false
    private var isServiceTestimonialAvailable = false
    
    func getNewsData(){
        DispatchQueue.global().async {
            NewsService.shared.fetchNews { [weak self] news in
                self?.news = news
                //self?.getNewsCount() == 0 ? self?.delegate?.didFailGettingNewsData() : self?.delegate?.didGetNewsData()
                self?.isServiceNewsAvailable = true
            } onError: { [weak self] error in
                //self?.delegate?.didFailGettingNewsData()
                self?.isServiceNewsAvailable = false
            }
        }
    }
    
    func getAllServices(){
        getNewsData()
        //getNewsTestimonial
        //getNewsSlides
        
        checkServiceAvailable()
    }
    
    func checkServiceAvailable(){
        // aca chequeo con un if news && slide && test { delegate.didFailAll... else didFailNews, test, slide,
        if !isServiceNewsAvailable {
            delegate?.didFailGettingNewsData()
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
