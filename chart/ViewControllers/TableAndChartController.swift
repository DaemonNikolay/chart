//
//  TableAndChartController.swift
//  chart
//
//  Created by Nikolay Eckert on 18/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import UIKit


class TableAndChartController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = Api()
        api.getPoints()
    }
}
