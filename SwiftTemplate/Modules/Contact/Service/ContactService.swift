//
//  ContactService.swift
//  SwiftTemplate
//
//  Created by Cristian Costa on 21/06/2022.
//

import Foundation
import Alamofire

struct ContactService {
    
    let url = ProcessInfo.processInfo.environment["baseURL"]
    
    func postMessage(message: ContactMessage, didSignUp: @escaping (ContactData) -> (), didFail: @escaping () -> ()) {
        guard let parameters = message.dictionary else {return}
        guard let urlSafe = url else {return}
        ApiManager.shared.post(url: "\(urlSafe)api/contacts", params: parameters, completion: { response in
            switch response {
                case .success(let data):
                    do {
                        if let data = data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .useDefaultKeys
                            let resp = try decoder.decode(ContactData.self, from: data)
                            didSignUp(resp)
                        } else {
                            didFail()
                        }
                    } catch {
                        didFail()
                    }
                case .failure(_):
                    didFail()
            }
        })
    }
}
