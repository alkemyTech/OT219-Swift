//
//  ContactViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 17/06/2022.
//

import UIKit

class ContactViewController: UIViewController {
    //MARK: - Properties
    
    private var didChangeTextOrHideKeyboard = true
    private var viewModel: ContactViewModel?

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "LOGO-SOMOS MAS")
        return imageView
    }()
    
    private let fullnameTextfield: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.keyboardType = .default
        textField.placeholder = "Nombre y apellido"
        textField.setHeight(40)
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)

        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.keyboardType = .emailAddress
        textField.placeholder = "Email"
        textField.setHeight(40)
        return textField
    }()
    
    private let msgTextField: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isScrollEnabled = true
        textField.sizeToFit()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        textField.setHeight(150)
        return textField
    }()
    
    private let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Mensaje"
        placeholderLabel.sizeToFit()
        placeholderLabel.textColor = .tertiaryLabel
        return placeholderLabel
    }()
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar mensaje", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setHeight(50)
        button.setWidth(170)
        return button
    }()
    
    private let labelContactate: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 15))
        label.text = "¡Contactate con nosotros!"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObserverKeyboard()
        configureNavigationBar()
        
        viewModel = ContactViewModel()
        viewModel?.delegate = self
    }
    
    //MARK: - Helpers
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        //Logo
        scrollView.addSubview(logoImage)
        logoImage.centerX(inView: scrollView)
        logoImage.setDimensions(height: 80, width: 120)
        logoImage.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor, paddingTop: 20)

        //Label
        scrollView.addSubview(labelContactate)
        labelContactate.centerX(inView: scrollView)
        labelContactate.anchor(top: logoImage.bottomAnchor, paddingTop: 20)

        //Stack
        let stack = UIStackView(arrangedSubviews: [fullnameTextfield, emailTextField, msgTextField])
        stack.axis = .vertical
        stack.spacing = 20
        scrollView.addSubview(stack)
        stack.anchor(top: labelContactate.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        //TextView
        msgTextField.delegate = self
        msgTextField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 20, y: (msgTextField.font?.pointSize)! / 2)
        placeholderLabel.isHidden = !msgTextField.text.isEmpty
        
        //Button
        scrollView.addSubview(sendMessageButton)
        sendMessageButton.anchor(top: msgTextField.bottomAnchor, left: scrollView.leftAnchor, paddingTop: 30, paddingLeft: 20)
        configurationButton()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    func configurationButton(){
        sendMessageButton.backgroundColor = .gray
        sendMessageButton.isEnabled = false
    }
    
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Contacto"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    func setupObserverKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.addTarget(self, action: #selector(self.changeTextOrHideKeyboard), for: .editingChanged)
        fullnameTextfield.addTarget(self, action: #selector(self.changeTextOrHideKeyboard), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(self.validateEmail), for: .editingDidEnd)
        fullnameTextfield.addTarget(self, action: #selector(self.validateName), for: .editingDidEnd)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func changeTextOrHideKeyboard() {
        didChangeTextOrHideKeyboard = true
    }
    
    @objc func validateEmail() {
        viewModel?.validateEmail(value: emailTextField.text)
    }
    
    @objc func validateName() {
        viewModel?.validateName(value: fullnameTextfield.text)
    }
    
    @objc func validateMessage() {
        viewModel?.validateMessage(value: msgTextField.text)
    }
}

//MARK: - UITextViewDelegate
extension ContactViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        validateMessage()
    }
}

//MARK: - Func Keyboard Handlers
extension ContactViewController {
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if msgTextField.isFirstResponder && (didChangeTextOrHideKeyboard == true) {
            guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpace = self.scrollView.frame.height - (sendMessageButton.frame.origin.y + sendMessageButton.frame.height)
            self.scrollView.frame.origin.y -= keyboardHeight - bottomSpace + 10
            didChangeTextOrHideKeyboard = false
        }
    }
    
    @objc private func keyboardWillHide() {
        self.scrollView.frame.origin.y = 0
        didChangeTextOrHideKeyboard = true
    }
}

//MARK: - ContactViewModelDelegate
extension ContactViewController: ContactViewModelDelegate {
    func activateButton() {
        sendMessageButton.backgroundColor = .systemBlue
        sendMessageButton.isEnabled = true
    }
    
    func desactivateButton() {
        sendMessageButton.isEnabled = false
        sendMessageButton.backgroundColor = .gray
    }
    
    func showAlertsTextFields(messages: String) {
        let alert = UIAlertController(title: "Error", message: messages, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
