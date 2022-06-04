//
//  MenuOption.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 04/06/2022.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case Inicio
    case Nosotros
    case Novedades
    case Testimonios
    case Contacto
    case Contribuye

    var description: String {
        switch self {
            case .Inicio: return "Inicio"
            case .Nosotros: return "Nosotros"
            case .Novedades: return "Novedades"
            case .Testimonios: return "Testimonios"
            case .Contacto: return "Contacto"
            case .Contribuye: return "Contribuye"
        }
    }
}
