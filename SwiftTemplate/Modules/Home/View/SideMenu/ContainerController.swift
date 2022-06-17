//
//  ContrainerController.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 03/06/2022.
//

import UIKit

class ContainerController: UIViewController {
    //MARK: - Properties
    var menuController: MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    //MARK: - Init
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    //MARK: - Handlers
    func configureHomeController() {
        let homeController = HomeViewController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            //add menu controller
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 150
            }, completion: nil)
        } else {
            //hide menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.centerController.view.frame.origin.x = 0
            } completion: { (_) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .Inicio:
            showToast(message: "Inicio", font: UIFont.systemFont(ofSize: 20))
        case .Nosotros:
            let nosotrosViewController = NosotrosViewController()
            self.navigationController?.pushViewController(nosotrosViewController, animated: true)
        case .Novedades:
            showToast(message: "Novedades", font: UIFont.systemFont(ofSize: 20))
        case .Testimonios:
            showToast(message: "Testimonios", font: UIFont.systemFont(ofSize: 20))
        case .Contacto:
            showToast(message: "Contacto", font: UIFont.systemFont(ofSize: 20))
        case .Contribuye:
            showToast(message: "Contribuye", font: UIFont.systemFont(ofSize: 20))
        }
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 90, y: self.view.frame.size.height-100, width: 180, height: 42))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.textAlignment = .center;
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:.curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}

extension ContainerController: HomeViewControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded.toggle()
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
