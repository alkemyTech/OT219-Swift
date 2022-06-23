//
//  logingViewController.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 25/05/22.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!

    @IBOutlet weak var spinnerLoading: UIActivityIndicatorView!
    
    lazy var viewModel: LoginViewModel = {
        let loginViewModel = LoginViewModel()
        loginViewModel.delegate = self
        return loginViewModel
    }()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LogIn"
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    //MARK: - setupView
    func setupView(){
        spinnerLoading.isHidden = true
    }
    
    func showSpinner(){
        spinnerLoading.isHidden = false
        spinnerLoading.startAnimating()
    }
    
    func hiddenSpinner(){
        spinnerLoading.isHidden = true
        spinnerLoading.stopAnimating()
    }
    
    @IBAction func navigateToHome(_ sender: Any) {
        showSpinner()
        guard let email = emailTextField.text else {return}
        guard let pass = passTextField.text else {return}

        DispatchQueue.main.async {
            self.viewModel.login(email: email, pass: pass)
            self.hiddenSpinner()
        }
    }
    
    @IBAction func navigateToSignUp(_ sender: Any) {
        let signUpvc = SignupViewController()
        self.navigationController?.pushViewController(signUpvc,animated:true)
    }
}

//MARK: - LoginViewModelDelegate

extension LogInViewController: LoginViewModelDelegate{

    
    func didSuccessUserLogin() {
        let homeViewController = ContainerController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    func didFailUserLogin(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel))
        present(alert, animated: true)
    }
}
