//
//  ViewController.swift
//  chart
//
//  Created by Nikolay Eckert on 15/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import UIKit
import Alamofire


class StartingController: UIViewController {
    
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var textFieldCountPoints: UITextField!
    
    private var _points: [CoordinateString] = []
    var points: [CoordinateString] {
        get { return _points }
        set { _points = newValue }
    }
    
    
    @IBAction func buttonGo_Click(_ sender: UIButton) {
        if (!InternetManager.checkInternetConnection()) {
            Toast.showToast(message: "Internet connection error", viewSelf: self)
            return
        }
        
        let countPointsString: String? = self.textFieldCountPoints.text
        if countPointsString == nil || countPointsString!.isEmpty || Int(countPointsString!)! <= 0 {
            Toast.showToast(message: "Count points must be greater than zero", viewSelf: self)
            return
        }
        
        let countPointsInt: Int = Int(countPointsString!)!
        let apiPoints = ApiPoints()
        
        apiPoints.getPoints(count: countPointsInt).responseJSON {
            (response: DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    let elements = response.value as? NSDictionary
                    let result = elements?.object(forKey: "result")
                    
                    if (result == nil) {
                        self.toastErrorWithBase64(messageBase64: self.extractionMessageBase64(elements: elements))
                        return
                    }
                    
                    let resultInt = result as! Int
                    if resultInt != 0 {
                        Toast.showToast(message: "Result not equal zero", viewSelf: self)
                        return
                    }
                    
                    self.points = self.extractionCoordinates(points: self.extractionPoints(elements: elements))
                    
                    self.performSegue(withIdentifier: "showTableAndChart", sender: self)
                    
                    self.clearTextFieldCountPoints()
                }
                
                break
                
            case .failure(_):
                let messageFailure = "Failure : \(String(describing: response.result.error))"
                Toast.showToast(message: messageFailure, viewSelf: self)
                print(messageFailure)
                
                break
            }
        }
    }
    
    private func clearTextFieldCountPoints() -> Void {
        self.textFieldCountPoints.text = ""
    }
    
    private func extractionMessageBase64(elements: NSDictionary?) -> String {
        let response = elements?.object(forKey: "response") as! NSDictionary
        let messageBase64 = response.object(forKey: "message") as! String
        
        return messageBase64
    }
    
    private func extractionPoints(elements: NSDictionary?) -> [NSDictionary] {
        let response = elements?.object(forKey: "response") as! NSDictionary
        let points = response.object(forKey: "points") as! [NSDictionary]
        
        return points
    }
    
    private func extractionCoordinates(points: [NSDictionary]) -> [CoordinateString] {
        var coordinates: [CoordinateString] = []
        for point in points {
            let pointX = point.object(forKey: "x") as! String
            let pointY = point.object(forKey: "y") as! String
            let coordinate = CoordinateString(x: pointX, y: pointY)
            
            coordinates.append(coordinate)
        }
        
        return coordinates
    }
    
    private func toastErrorWithBase64(messageBase64: String) -> Void {
        let decodedData = Data(base64Encoded: messageBase64)!
        var decodedString = String(data: decodedData, encoding: .utf8)!
        
        if decodedString.isEmpty {
            decodedString = "The error message is empty"
        }
        
        Toast.showToast(message: decodedString, viewSelf: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTableAndChart" {
            if let destinationVC = segue.destination as? TableAndChartController {
                destinationVC.points = points
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
