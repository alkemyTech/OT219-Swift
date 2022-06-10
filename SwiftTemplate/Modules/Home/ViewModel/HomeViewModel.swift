//
//  HomeViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didGetNewsData()
    func didFailGettingNewsData(error: String)
    func didFailGettingNewsData()
    func didGetSlidesData()
    func didFailGettingSlidesData()
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
    
    var newsService: NewsFetching
    
    init(newsService: NewsFetching = NewsService()){
        self.newsService = newsService
    }
    
    func getNewsData(){
        DispatchQueue.global().async { [weak self] in
            self?.newsService.fetchNews { news in
                self?.news = news
                self?.getNewsCount() == 0 ? self?.delegate?.didFailGettingNewsData(error: ApiError.noNewsData.errorDescription!) : self?.delegate?.didGetNewsData()
            } onError: { error in
                self?.delegate?.didFailGettingNewsData(error: error)
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
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc func moveNextIndex(){
        if currentCellIndex < 3 {
            currentCellIndex += 1
        }else {
            currentCellIndex = 0
        }
        delegateTimer?.updateImageView(at: currentCellIndex)
    }
    
    
    var slides = [Slides]()
    
    func getSlidesData(){
        DispatchQueue.global().async {
            SlidesService.shared.fetchSlides { [weak self] slides in
                self?.slides = slides
                self?.getSlidesCount() == 0 ? self?.delegate?.didFailGettingSlidesData() : self?.delegate?.didGetSlidesData()
            } onError: { [weak self] error in
                self?.delegate?.didFailGettingSlidesData()
            }
        }
    }
    
    func getSlidesCount() -> Int{
        return slides.count
    }
    
    func getSlides(at index:Int) -> Slides{
        return slides[index]
    }
    
}
