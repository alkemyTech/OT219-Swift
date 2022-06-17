//
//  ContactViewController.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 17/06/2022.
//

import UIKit

class ContactViewController: UIViewController {
    //MARK: - Properties
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
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        return textField
    }()
    
    private let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Mensaje"
        return placeholderLabel
    }()
    
    private let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar mensaje", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
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
        logoImage.anchor(top: scrollView.safeAreaLayoutGuide.topAnchor, paddingTop: 32)

        //Label
        scrollView.addSubview(labelContactate)
        labelContactate.centerX(inView: scrollView)
        labelContactate.anchor(top: logoImage.bottomAnchor, paddingTop: 20)

        //Stack
        let stack = UIStackView(arrangedSubviews: [fullnameTextfield, emailTextField])
        stack.axis = .vertical
        stack.spacing = 20
        scrollView.addSubview(stack)
        stack.anchor(top: labelContactate.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        //TextView
        msgTextField.delegate = self
        msgTextField.isScrollEnabled = false
        scrollView.addSubview(msgTextField)
        msgTextField.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        
        placeholderLabel.sizeToFit()
        msgTextField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 20, y: (msgTextField.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !msgTextField.text.isEmpty
        
        //Button
        scrollView.addSubview(sendMessageButton)
        sendMessageButton.anchor(top: msgTextField.bottomAnchor, left: scrollView.leftAnchor, paddingTop: 20, paddingLeft: 20)
    }
}

extension ContactViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
