//
//  logingViewController.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 25/05/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var viewModel: LoginViewModel = {
        let loginViewModel = LoginViewModel()
        loginViewModel.delegate = self
        return loginViewModel
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfLogin()
        
        
        //test
        DispatchQueue.main.async {
            NewsService.shared.getNews { news in
                print(news)
            } onError: { error in
                print("hubo un error\(error)")
            }

        }

    }
    
    private func checkIfLogin(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.viewModel.checkLogin()
        }
    }

}


//MARK: - LoginViewModelDelegate

extension LogInViewController: LoginViewModelDelegate{
    func didSuccessUserLogin() {
        print("logueado")
    }
    
    func didFailUserLogin(error: String) {
        print(error)
    }
    
    
}
