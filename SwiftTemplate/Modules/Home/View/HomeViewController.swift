//
//  HomeViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 31/05/2022.
//

import UIKit

class HomeViewController: UIViewController{
    
    //MARK: - Properties

    lazy var viewModel: HomeViewModel = {
        let homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        return homeViewModel
    }()
    
    private let newsFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.idenfifier)
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsFeedTable.frame = view.bounds
    }
    
    private func setupTable(){
        newsFeedTable.delegate = self
        newsFeedTable.dataSource = self
    }
    
    private func setupView(){
        view.addSubview(newsFeedTable)
    }
}

//MARK: - TableViewDelegate & DataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.idenfifier, for: indexPath) as? CollectionTableViewCell else {
           return UITableViewCell()
       }
        
       return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getSectionTitle(at: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        
    }
    
}

//MARK: - News delegate

extension HomeViewController: HomeViewModelDelegate {
    
    func didGetNewsData() {
        
    }
    
    func didFailGettingNewsData(error: String) {
        
    }
}
