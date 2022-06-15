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
    func didGetTestimonialsData()
    func didFailGettingTestimonialsData(error: String)
    func didGetWelcomeData()
    func didFailGettingWelcomeData(error: String)
    
}

protocol TimerNewsUpdate: AnyObject {
    func updateImageView(at index:Int)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    weak var delegateTimer: TimerNewsUpdate?
    private var sectionsTitles = ["News"]
    
    var news = [News]()
    var testimonials = [Testimonials]()
    
    private var timer : Timer?
    
    private var currentCellIndex = 0
    
    // MARK: - Welcome methods
    
    func getDataWelcome() {
        if WelcomeViewModel().getDescriptionWelcomeViewModel().isEmpty || WelcomeViewModel().getImage().isEmpty{
            let error = "Error getting data on Welcome View"
            self.delegate?.didFailGettingWelcomeData(error: error)
        }
    }
    
    func getDescriptionWelcome() -> String{
        WelcomeViewModel().getDescriptionWelcomeViewModel()
    }
    
    func getImageWelcome() -> String {
        WelcomeViewModel().getImage()
    }
    
    // MARK: News methods
    var newsService: NewsFetching
    var testimonialService: TestimonialsFetching
    
    init(newsService: NewsFetching = NewsService(), testimonio: TestimonialsFetching = TestimonialsService()){
        self.newsService = newsService
        self.testimonialService = testimonio
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
        timer = Timer.scheduledTimer(timeInterval: 5.5, target: self, selector: #selector(moveNextIndex), userInfo: nil, repeats: true)
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
}

//MARK: - Testimonials Logic
extension HomeViewModel {
    
    func getTestimonialsData() {
        DispatchQueue.global().async {
            self.testimonialService.fetchTestimonials { [weak self] testimonials in
                self?.testimonials = testimonials
                self?.getNewsCount() == 0 ? self?.delegate?.didFailGettingTestimonialsData(error: ApiError.noTestimonialsData.errorDescription!) : self?.delegate?.didGetTestimonialsData()
            } onError: { [weak self] error in
                self?.delegate?.didFailGettingTestimonialsData(error: error)
            }
        }
    }
    
    func getTestimonials(at index: Int) -> Testimonials {
        return testimonials[index]
    }
    
    func getTestimonialsCount() -> Int{
        return testimonials.count
    }
}
