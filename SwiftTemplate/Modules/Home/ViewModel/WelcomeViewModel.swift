//
//  WelcomeViewModel.swift
//  SwiftTemplate
//
//  Created by Adriancys Jesus Villegas Toro on 2/6/22.
//

import Foundation

class WelcomeViewModel{
    
    var welcomeData = WelcomeModel(description: "Lorem ipsum es el texto que se usa habitualmente en diseño gráfico o de moda en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final. habitualmente en diseño gráfico o de moda en demostraciones de tipografías o de borradores de diseño para probar el diseño visual antes de insertar el texto final.", nameImage: "ong")
    
    func getDescriptionWelcomeViewModel() -> String {
        welcomeData.description
    }
    
    func getImage() -> String {
        welcomeData.nameImage
    }
    
    func errorGettingData() -> String{
        if welcomeData.description.isEmpty || welcomeData.nameImage.isEmpty{
            return "We cannot show data welcomeView"
        }else {
            return ""
        }
        
    }
}
