//
//  MenuController.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 03/06/2022.
//

import UIKit

private let reuseIdentifier = "MenuOptionCell"

class MenuController: UIViewController {
    //MARK: - Properties

    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-150, height: self.view.frame.height)
        return view
    }()
    
    var tableView: UITableView!
    var delegate: HomeViewControllerDelegate?
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    //MARK: - Handlers
    private func setupView(){
        //set menuView
        view.addSubview(menuView)
        menuView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
