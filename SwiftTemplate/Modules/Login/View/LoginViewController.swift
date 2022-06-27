//
//  LoginViewController.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 26/6/22.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate{

    //MARK: - Properties
    
    private lazy var viewModel : LoginViewModel = {
        let viewModel = LoginViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    lazy var sizeView = CGSize(width: view.frame.width, height: view.frame.height)
    
    private lazy var viewWithProperties: UIView = {
        let view = UIView()
        view.frame.size = sizeView
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = sizeView
        scroll.frame = self.view.bounds
        scroll.autoresizingMask = .flexibleHeight
//        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    private var imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LOGO-SOMOS MAS")
        return imageView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.setHeight(40)
        return textField
        }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.setHeight(40)
        return textField
        }()
    
    private var requiredEmail: UILabel = {
        let label = UILabel()
        label.text = "*Required Field*"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemRed
        return label
    }()
    
    private var requiredPassword: UILabel = {
        let label = UILabel()
        label.text = "*Required Field*"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .systemRed
        return label
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGray
        button.isEnabled = false
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(40)
        return button
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No tienes cuenta? Registrate!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setHeight(20)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        setupView()
        addTargeds()
    }
    //MARK: - Setup
    func setupView(){
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewWithProperties)
        

        viewWithProperties.addSubview(imageLogo)
        imageLogo.centerX(inView: viewWithProperties)
        imageLogo.anchor(top: viewWithProperties.topAnchor, paddingTop: 20)

        let stackEmail = UIStackView(arrangedSubviews: [emailTextField, requiredEmail])
        stackEmail.axis = .vertical
        stackEmail.spacing = 5

        let stackPassword = UIStackView(arrangedSubviews: [passwordTextField, requiredPassword])
        stackPassword.axis = .vertical
        stackPassword.spacing = 5

        let stacks = UIStackView(arrangedSubviews: [stackEmail, stackPassword])
        stacks.axis = .vertical
        stacks.distribution = .fill
        stacks.spacing = 20

        viewWithProperties.addSubview(stacks)
        viewWithProperties.addSubview(loginButton)
        viewWithProperties.addSubview(registerButton)
        
        stacks.centerX(inView: scrollView)
        stacks.anchor(left: viewWithProperties.leftAnchor, bottom: loginButton.topAnchor, right: viewWithProperties.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)
        
        loginButton.anchor(left: viewWithProperties.leftAnchor, bottom: registerButton.topAnchor, right: viewWithProperties.rightAnchor, paddingLeft: 20, paddingBottom: 5, paddingRight: 20)

        registerButton.anchor(left: viewWithProperties.leftAnchor, bottom: viewWithProperties.bottomAnchor, right: viewWithProperties.rightAnchor, paddingLeft: 50, paddingBottom: 130, paddingRight: 50)

    }
    //MARK: - Targeds
    func addTargeds(){
        emailTextField.addTarget(self, action: #selector(showRequiredEmail), for: UIControl.Event.editingChanged)
        emailTextField.addTarget(self, action: #selector(validateEmail), for: UIControl.Event.editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(showRequiredPassword), for: UIControl.Event.editingChanged)
        passwordTextField.addTarget(self, action: #selector(validatePassword), for: UIControl.Event.editingChanged)
        loginButton.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        registerButton.addTarget(self, action: #selector(goToSignup), for: UIControl.Event.touchUpInside)
    }
    
    @objc func showRequiredEmail(){
        viewModel.showRequiredEmail(email: emailTextField.text)
    }
    
    @objc func validateEmail(){
        viewModel.validateEmail(email: emailTextField.text)
    }
    
    @objc func showRequiredPassword(){
        viewModel.showRequiredPassword(password: passwordTextField.text)
    }
    
    @objc func validatePassword(){
        viewModel.validationsPassword(password: passwordTextField.text)
    }
    
    @objc func login(){
        viewModel.login(email: emailTextField.text!, pass: passwordTextField.text!)
    }
    
    @objc func goToSignup(){
        let signupVC = SignupViewController()
        self.navigationController?.pushViewController(signupVC, animated: true)
    }
    
    
    //MARK: - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField || textField == passwordTextField{
            scrollView.frame.origin.y -= 200
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField || textField == passwordTextField{
            scrollView.frame.origin.y = 0
        }
    }
}



//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate{

    func requiredEmailLabel() {
        requiredEmail.isHidden = false
    }
    
    func hiddenRequiredEmail() {
        requiredEmail.isHidden = true
    }
    
    func requiredPasswordLabel() {
        requiredPassword.isHidden = false
    }
    
    func hiddenRequiredPassword() {
        requiredPassword.isHidden = true
    }
    
    func activateButton() {
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(named: "ButtonColor")
    }
    
    func desactivateButton() {
        loginButton.isEnabled = false
        loginButton.backgroundColor = .systemGray
    }
    
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
