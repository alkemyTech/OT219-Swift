//
//  WelcomeViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 1/6/22.
//

import UIKit

class WelcomeViewController: UIViewController  {

    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
}
//MARK: - UITableViewDelegate and UITableViewDataSource
extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "hello world"
        return cell
    }
    
    
    func setupViews(){
        view.addSubview(tableView)
        tableView.dataSource = self
    }
}
