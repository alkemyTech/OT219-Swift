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
    
    private var timer : Timer?
    
    private var currentCellIndex = 0
    
    var programs : [ProgramsCollectionViewCellViewModel] = [
        ProgramsCollectionViewCellViewModel(title: "program A", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy"),
        ProgramsCollectionViewCellViewModel(title: "program B",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "LOGO-SOMOS MAS"),
        ProgramsCollectionViewCellViewModel(title: "program C",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy"),
        ProgramsCollectionViewCellViewModel(title: "program D", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "LOGO-SOMOS MAS"),
        ProgramsCollectionViewCellViewModel(title: "program E",description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dictum, nisi nec accumsan dictum, erat ante consectetur urna, sit amet rutrum nisl mauris eget mauris. Aliquam blandit magna in dui varius, ac aliquam ex dapibus. Sed fringilla a nisi ut porta. Proin eleifend lobortis dui quis faucibus. Curabitur dignissim ultricies efficitur. Pellentesque condimentum purus sed ligula lacinia, eu sollicitudin erat vulputate. Aenean tincidunt vehicula mattis. Sed quis tortor sit amet elit placerat condimentum. Donec gravida magna id mi bibendum cursus.", nameImage: "logo-Alkemy")
    ]
    
    
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
 //MARK: - Programs Cells
extension HomeViewModel{
    
    func getProgramCount() -> Int{
        programs.count
    }
    
    func getProgram(index: Int) -> ProgramsCollectionViewCellViewModel{
        programs[index]
    }
}

