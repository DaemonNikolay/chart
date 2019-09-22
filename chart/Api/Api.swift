//
//  Api.swift
//  chart
//
//  Created by Nikolay Eckert on 20/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import Alamofire


class Api {
    private static let _host: String = "demo.bankplus.ru"
    
    private var _baseUrl: String = "https://\(_host)"
    var baseUrl: String  {
        get { return self._baseUrl }
    }
    
    static let sharedInstance = ApiPoints()
    
    
    let manager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            _host: .disableEvaluation
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
