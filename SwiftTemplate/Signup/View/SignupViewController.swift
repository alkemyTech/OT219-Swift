//
//  SignupViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 23/05/2022.
//

import UIKit

class SignupViewController: UIViewController {

    //MARK: - Properties
    private var viewModel = SignUpViewModel()
    private var isKeyboardExpanded = false
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo-Alkemy")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let emailTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardType = .emailAddress
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textField
    }()
    
    private let fullnameTextfield: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .white
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textField
    }()
    
    private let reEnterPasswordTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = .none
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(40)
        textField.attributedPlaceholder = NSAttributedString(string: "Re enter Password", attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        return textField
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(40)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Already have an Account? Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupGradientLayer()
        setupView()
        setupObserverKeyboard()
        
        viewModel.delegate = self
        
        //Call this function when user press register button !
        viewModel.register(name: "name", email: "emailxdddd", pass: "pass")
    }

    //MARK: - Helpers
    
    private func setupView(){
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        
        scrollView.addSubview(logoImage)
        logoImage.centerX(inView: scrollView)
        logoImage.setDimensions(height: 80, width: 120)
        logoImage.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,fullnameTextfield, passwordTextField ,reEnterPasswordTextField, signupButton])
        stack.axis = .vertical
        stack.spacing = 20
        scrollView.addSubview(stack)
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 42, paddingLeft: 32, paddingRight: 32)
        
        
        scrollView.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.centerX(inView: scrollView)
        alreadyHaveAccountButton.anchor(bottom: scrollView.safeAreaLayoutGuide.bottomAnchor)
    
    }
    
    private func setupGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemGray.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    func setupObserverKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardAppear(notification: NSNotification){
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        scrollView.contentInset.bottom = view.convert(keyboardFrameValue.cgRectValue, from: nil).size.height
    }
    
    @objc func keyboardDisappear(){
        scrollView.contentInset.bottom = 0
    }
}

extension SignupViewController: SignUpViewModelDelegate {
    func userRegisterSuccess() {

    }
    
    func userRegisterError() {

    }
}
