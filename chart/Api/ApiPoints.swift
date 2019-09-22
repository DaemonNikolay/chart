//
//  Api.swift
//  chart
//
//  Created by Nikolay Eckert on 15/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import Alamofire


class ApiPoints : Api {
    override var baseUrl: String {
        get { return super.baseUrl }
    }
    
    
    public func getPoints(count: Int) -> DataRequest {
        let url = "\(baseUrl)/mobws/json/pointsList?version=1.1"
        let params : Parameters = ["count": "\(count)"]
        
        let result : DataRequest = ApiPoints.sharedInstance.manager.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: ["Content-Type":"application/x-www-form-urlencoded"])
        
        return result
    }
}
