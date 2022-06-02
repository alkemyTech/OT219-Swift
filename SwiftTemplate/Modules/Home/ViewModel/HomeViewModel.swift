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

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    private var sectionsTitles = ["News"]
    
    private var news = [News]()
    
    func getNewsData(){
        DispatchQueue.global().async {
            NewsService.shared.fetchNews { [weak self] news in
                self?.news = news
                self?.getNewsCount() == 0 ? self?.delegate?.didFailGettingNewsData() : self?.delegate?.didGetNewsData()
                //self?.delegate?.didGetNewsData()
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
}
