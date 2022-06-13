//
//  WelcomeViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 1/6/22.
//

import UIKit

class WelcomeViewController: UIViewController  {
//    
//    private let tableView : UITableView = {
//        let table = UITableView()
//        table.register(CollectionTableViewCell.self,
//                       forCellReuseIdentifier: CollectionTableViewCell.identifier)
//        return table
//    }()
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
//    
//    private lazy var viewModel : WelcomeViewModel = {
//        let viewModel = WelcomeViewModel()
//        return viewModel
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//}
////MARK: - UITableViewDelegate and UITableViewDataSource
//extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource{
//    
//    func setupViews(){
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.moduls.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let viewModelx = viewModel.moduls[indexPath.row]
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else{
//            fatalError()
//        }
//        cell.configure(with: viewModelx)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.size.width/0.59
//    }
}
