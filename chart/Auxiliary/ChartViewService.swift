//
//  ChartViewService.swift
//  chart
//
//  Created by Nikolay Eckert on 22/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation


class ChartViewService {
    private static var _coordinates: [CoordinateString] = []
    static var coordinates: [CoordinateString] {
        get { return ChartViewService._coordinates }
        set { ChartViewService._coordinates = newValue }
    }
    
    
    static func clearCoordinates() -> Void {
        ChartViewService.coordinates = []
    }
}
