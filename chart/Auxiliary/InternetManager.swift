//
//  InternetManager.swift
//  chart
//
//  Created by Nikolay Eckert on 23/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import Alamofire


class InternetManager {
    static func checkInternetConnection() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
