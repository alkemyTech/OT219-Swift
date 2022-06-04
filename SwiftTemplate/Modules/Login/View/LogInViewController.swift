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
        title = "LogIn"
        checkIfLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func navigateToSignUp(_ sender: Any) {
        let signUpvc = SignupViewController()
        self.navigationController?.pushViewController(signUpvc,animated:true)
    }
    
    private func checkIfLogin(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.viewModel.checkLogin()
        }
    }

}


//MARK: - LoginViewModelDelegate

extension LogInViewController: LoginViewModelDelegate{
    func showErrorLogin(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        present(alert, animated: true)
    }
    
    func didSuccessUserLogin() {
        print("logueado")
    }
    
    func didFailUserLogin(error: String) {
        print(error)
    }
    
    
}
