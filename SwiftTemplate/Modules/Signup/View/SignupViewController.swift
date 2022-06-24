//
//  SignupViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 23/05/2022.
//

import UIKit

class SignupViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var viewModel: SignUpViewModel = {
        let viewModel = SignUpViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private var isKeyboardExpanded = false
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    private var logoImage: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         imageView.image = UIImage(named: "LOGO-SOMOS MAS")
         return imageView
     }()
    
    private lazy var emailTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email"
        textField.delegate = self
        textField.setHeight(40)
        return textField
    }()
    
    private lazy var fullnameTextfield: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.setHeight(40)
        textField.delegate = self
        textField.placeholder = "Fullname"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.setHeight(40)
        textField.placeholder = "Password"
        textField.delegate = self
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.placeholder = "Confirm Password"
        textField.setHeight(40)
        textField.delegate = self
        return textField
    }()
    
    private let labelSamePassword: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        label.text = "Passwords are not the same"
        label.isHidden = true
        return label
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrarme", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(40)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ya tenes cuenta? Ingresa!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        setupView()
        setupObserverKeyboard()
  
        configurationButton()

        viewModel = SignUpViewModel()
        viewModel?.delegate = self
    }

    //MARK: - Helpers
    
    func configurationButton(){
        signupButton.backgroundColor = .gray
        signupButton.isEnabled = false
    }
    
    private func setupView(){
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(logoImage)
        logoImage.centerX(inView: containerView)
        logoImage.setHeight(200)
        logoImage.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextfield, passwordTextField ,confirmPasswordTextField, labelSamePassword,signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        containerView.addSubview(stack)
        stack.anchor(top: logoImage.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        
        containerView.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.centerX(inView: containerView)
        alreadyHaveAccountButton.anchor(top: stack.bottomAnchor, paddingTop: 10)
    
    }
    
    @objc func showLogin(){
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupObserverKeyboard(){
        
        emailTextField.addTarget(self, action: #selector(self.validateEmail), for: UIControl.Event.editingDidEnd)
        
        fullnameTextfield.addTarget(self, action: #selector(self.validateName), for: .editingDidEnd)
        
        passwordTextField.addTarget(self, action: #selector(self.validatePassword), for: .editingDidEnd)
        
        confirmPasswordTextField.addTarget(self, action: #selector(self.validateSamePassword), for: .allEditingEvents)
        
        signupButton.addTarget(self, action: #selector(self.registerUser), for: .touchUpInside)
        
    }

    @objc func validateEmail(){
        viewModel.validateEmail(value: emailTextField.text)
    }
    
    @objc func validateName(){
        viewModel.validateName(value: fullnameTextfield.text)
    }

    @objc func validatePassword(){
        viewModel.validatePasswordA(value: passwordTextField.text)
    }
    
    @objc func validateSamePassword(){
        viewModel?.validateSamePassword(valueA: passwordTextField.text, valueB: confirmPasswordTextField.text)
    }
    
    @objc func registerUser(){
        viewModel?.register(name: fullnameTextfield.text!, email: emailTextField.text!, pass: passwordTextField.text!)
        signupButton.endEditing(true)
    }
}

//MARK: - TextField Delegate

extension SignupViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField || textField == confirmPasswordTextField {
            self.scrollView.frame.origin.y -= 200
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField || textField == confirmPasswordTextField {
            self.scrollView.frame.origin.y = 0
        }
    }
}

//MARK: - Signup Delegate

extension SignupViewController: SignUpViewModelDelegate {
    func desactivateButton() {
        signupButton.isEnabled = false
        signupButton.backgroundColor = .gray
    }
    
    func labelPasswordNotShow() {
        labelSamePassword.isHidden = true
    }
    
    func labelPasswordShow() {
        labelSamePassword.isHidden = false
    }
    
    func activateButton() {
        signupButton.backgroundColor = UIColor(named: "ButtonColor")
        signupButton.isEnabled = true
    }
    
    func showAlertsTextFields(messages: String) {
        let alert = UIAlertController(title: "Error", message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func userRegisterSuccess() {
        let alert = UIAlertController(title: "Usuario registrado de manera exitosa", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {(action: UIAlertAction!) in
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func userRegisterError() {
        let alert = UIAlertController(title: "Error", message: "No pudimos registrar el usuario, por favor revise nuevamente sus datos e intente nuevamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
