//
//  logingViewController.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 25/05/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: LoginViewModel?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LoginViewModel(delegate: self)

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.viewModel?.checkLogin()
        }

    }

}

extension LogInViewController: LoginViewModelDelegate{
    func didSuccessUserLogin() {
        print("logueado")
    }
    
    func didFailUserLogin(error: String) {
        print(error)
    }
    
    
}
