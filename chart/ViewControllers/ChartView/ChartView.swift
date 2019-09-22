//
//  ChartView.swift
//  chart
//
//  Created by Nikolay Eckert on 22/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import UIKit


class ChartView: UIView {
    
    private var _coordinates: [CoordinateString] = []
    var coordinates: [CoordinateString] {
        get { return _coordinates }
        set { _coordinates = newValue }
    }
    
    
    override func draw(_ rect: CGRect) {
        self.coordinates = self.getCoordinates()
        
        let maxAxisX = self.maxAxisX()
        let minAxisX = self.minAxisX()
        
        let maxAxisY = self.maxAxisY()
        let minAxisY = self.minAxisY()
        
        let sizeFrame = self.frame.size
        let scaleAxisX = Double(sizeFrame.width) / (maxAxisX - minAxisX)
        let scaleAxisY = Double(sizeFrame.height) / (maxAxisY - minAxisY)
        
        let sortCoordinate: [CoordinateString] = self.sortCoordinatesOnX()
        var coordinatesForChart: [PositionCoordinateDouble] = []
        
        for coordinate in sortCoordinate {
            let coordinateXFloat = (Double(coordinate.x)! - minAxisX) * scaleAxisX
            var coordinateYFloat = (Double(coordinate.y)! - maxAxisY) * scaleAxisY
            
            coordinateYFloat = abs(coordinateYFloat)
            
            coordinatesForChart.append(PositionCoordinateDouble(start: coordinateXFloat, end: coordinateYFloat))
        }
        
        self.drawLines(coordinatesForChart: coordinatesForChart)
    }
    
    private func drawLines(coordinatesForChart: [PositionCoordinateDouble]) -> Void {
        var coordinates: [PositionCoordinateDouble] = coordinatesForChart
        
        let line = UIBezierPath()
        line.move(to: CGPoint(x: coordinates[0].start, y: coordinates[0].end))
        
        coordinates.remove(at: 0)
        
        for coordinate in coordinates {
            line.addLine(to: CGPoint(x: coordinate.start, y: coordinate.end))
        }
        
        line.stroke()
        line.close()
    }
    
    private func sortCoordinatesOnX() -> [CoordinateString] {
        var coordinates: [CoordinateString] = self.coordinates
        
        coordinates.sort(by: sorterForCoordinateX)
        
        return coordinates
    }
    
    func sorterForCoordinateX(first: CoordinateString, second: CoordinateString) -> Bool {
        let firstPointX = Double(first.x)!
        let secondPointX = Double(second.x)!
        
        return firstPointX < secondPointX
    }
    
    private func roundWithKoefficient(value: Double, koefficientRound: Int) -> Double {
        let koefficient = Double(koefficientRound)
        
        return round(value * koefficient) / koefficient
    }
    
    private func getCoordinates() -> [CoordinateString] {
        let coordinates = ChartViewService.coordinates
        
        ChartViewService.clearCoordinates()
        
        return coordinates
    }
    
    private func maxAxisX() -> Double {
        let maxX = ChartView.maxPointX(coordinates: coordinates)
        let minX = ChartView.minPointX(coordinates: coordinates)
        
        let maxAxisX = ChartView.maxForAxisX(first: maxX, second: minX)
        
        return maxAxisX
    }
    
    private func maxAxisY() -> Double {
        let maxY = ChartView.maxPointY(coordinates: coordinates)
        let minY = ChartView.minPointY(coordinates: coordinates)
        
        let maxAxisY = ChartView.maxForAxisY(first: maxY, second: minY)
        
        return maxAxisY
    }
    
    private func minAxisX() -> Double {
        let maxX = ChartView.maxPointX(coordinates: coordinates)
        let minX = ChartView.minPointX(coordinates: coordinates)
        
        let maxAxisX = ChartView.minForAxisX(first: maxX, second: minX)
        
        return maxAxisX
    }
    
    private func minAxisY() -> Double {
        let maxY = ChartView.maxPointY(coordinates: coordinates)
        let minY = ChartView.minPointY(coordinates: coordinates)
        
        let maxAxisY = ChartView.minForAxisY(first: maxY, second: minY)
        
        return maxAxisY
    }
    
    private static func minForAxisX(first: Double, second: Double) -> Double {
        return ChartView.comparisonPointsMin(first: first, second: second)
    }
    
    private static func minForAxisY(first: Double, second: Double) -> Double {
        return ChartView.comparisonPointsMin(first: first, second: second)
    }
    
    private static func maxForAxisX(first: Double, second: Double) -> Double {
        return ChartView.comparisonPointsMax(first: first, second: second)
    }
    
    private static func maxForAxisY(first: Double, second: Double) -> Double {
        return ChartView.comparisonPointsMax(first: first, second: second)
    }
    
    private static func comparisonPointsMin(first: Double, second: Double) -> Double {
        return first < second ? first : second
    }
    
    private static func comparisonPointsMax(first: Double, second: Double) -> Double {
        return first > second ? first : second
    }
    
    private static func maxPointY(coordinates: [CoordinateString]) -> Double {
        var max: Double = Double(coordinates[0].y)!
        
        for coordinate in coordinates {
            let coordinateYFloat = Double(coordinate.y)!
            if (coordinateYFloat > max) {
                max = coordinateYFloat
            }
        }
        
        return max
    }
    
    private static func maxPointX(coordinates: [CoordinateString]) -> Double {
        var max: Double = Double(coordinates[0].x)!
        
        for coordinate in coordinates {
            let coordinateXFloat = Double(coordinate.x)!
            if (coordinateXFloat > max) {
                max = coordinateXFloat
            }
        }
        
        return max
    }
    
    private static func minPointY(coordinates: [CoordinateString]) -> Double {
        var min: Double = Double(coordinates[0].y)!
        
        for coordinate in coordinates {
            let coordinateYFloat = Double(coordinate.y)!
            if (coordinateYFloat < min) {
                min = coordinateYFloat
            }
        }
        
        return min
    }
    
    private static func minPointX(coordinates: [CoordinateString]) -> Double {
        var min: Double = Double(coordinates[0].x)!
        
        for coordinate in coordinates {
            let coordinateXFloat = Double(coordinate.x)!
            if (coordinateXFloat < min) {
                min = coordinateXFloat
            }
        }
        
        return min
    }
}
