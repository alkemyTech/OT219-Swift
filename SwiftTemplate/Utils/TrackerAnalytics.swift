//
//  TrackerAnalytics.swift
//  SwiftTemplate
//
//  Created by Cristian Sancricca on 21/06/2022.
//

import Foundation
import FirebaseAnalytics

class TrackerAnalytics {
    static func trackCreateUserSuccess(_ user:String) {
        Analytics.logEvent("Success_CreateUser", parameters: ["user": user])
    }
    
    static func trackCreateUserFail(error: String) {
        Analytics.logEvent("Fail_CreateUser", parameters: ["error": error])
    }
    
    static func trackLoginUser(_ user: String) {
        Analytics.logEvent("Success_LoginUser", parameters: ["user": user])
    }
    
    static func trackLoginUserFail(error: String) {
        Analytics.logEvent("Fail_LoginUser", parameters: ["error": error])
    }
    
    static func trackErrorNewsSeccion(error: String){
        Analytics.logEvent("Error_NewsSeccion", parameters: ["error": error])
    }
    
    static func trackErrorTestimonialsSeccion(error: String){
        Analytics.logEvent("Error_Testimonials", parameters: ["error": error])
    }
}
