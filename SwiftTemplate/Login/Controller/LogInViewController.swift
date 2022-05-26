//
//  logingViewController.swift
//  SwiftTemplate
//
//  Created by Alejandro Martinez on 25/05/22.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        LoginService.shared.login { token in
            print(token)
        } onError: { error in
            print(error)
        }

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
