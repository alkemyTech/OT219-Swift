//
//  HomeViewModel.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import UIKit

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
            TestimonialsService.shared.fetchTestimonials { [weak self] testimonials in
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

//MARK: - Custom classes

extension HomeViewModel {
    func createButton(title: String, width: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight ) ->CustomButton{
        let button = CustomButton(titleLabel: title, width: width)
        button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        return button
    }
    
    func createImage(image: String, mode: UIView.ContentMode, radius: CGFloat = 0) -> CustomImage{
        let image = CustomImage(imageName: image, mode: mode, radius: radius)
        return image
    }
    
    func createLabel(label: String, fontSize: CGFloat, fontWeight: UIFont.Weight, labelLines: Int = 1) -> CustomLabel{
        let label = CustomLabel(label: label, fontSize: fontSize, fontWeight: fontWeight)
        label.numberOfLines = labelLines
        return label
    }
}
