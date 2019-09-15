//
//  Api.swift
//  chart
//
//  Created by Nikolay Eckert on 15/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import Alamofire



// TODO: requires refactoring

class Api {
    private var baseUrl = "https://demo.bankplus.ru"
    
    static let sharedInstance = Api()
    
    
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "demo.bankplus.ru": .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    public func getPoints() { // the solution works
        let url = "\(baseUrl)/mobws/json/pointsList?version=1.1"
        
        print(url)
        
        let params2 : Parameters = ["count": "2"]
        
        Api.sharedInstance.defaultManager.request(url, method: .post, parameters: params2, encoding: URLEncoding.httpBody, headers: ["Content-Type":"application/x-www-form-urlencoded"]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print("response : \(response)")
                }
                break
                
            case .failure(_):
                print("Failure : \(response.result.error)")
                break
            }
        }
    }
}
