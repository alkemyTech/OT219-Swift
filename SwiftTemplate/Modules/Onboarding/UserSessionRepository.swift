//
//  UserSessionRepository.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 8/6/22.
//

import UIKit

class UserSessionRepository: UINavigationController {
    
    
    func validateCurrentUser() -> Bool{
        if let data = UserDefaults.standard.string(forKey: Constants.keyUserDefaults){
            return true
        }else {
            return false
        }
    }
/*    esta clase podria dedicarse para validaciones al momento de agregar comentarios,
        para la apertura de la app y para la parte del log Out
 */

}
