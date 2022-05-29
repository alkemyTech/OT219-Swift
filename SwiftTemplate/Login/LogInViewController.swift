//
//  LogInViewController.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 27/05/22.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "LogIn"
     
    }


    @IBAction func button(_ sender: Any) {
        let SignUpvc = SignupViewController()
        self.navigationController?.pushViewController(SignUpvc,animated:true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
  
}
