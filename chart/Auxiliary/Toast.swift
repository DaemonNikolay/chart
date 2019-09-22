//
//  Toast.swift
//  chart
//
//  Created by Nikolay Eckert on 23/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import Foundation
import UIKit


class Toast: UIViewController {
    static func showToast(message : String, viewSelf: UIViewController) {
        let widthFrame: CGFloat = 330
        
        let frameX = viewSelf.view.frame.size.width/2 - widthFrame/2
        let frameY = viewSelf.view.frame.size.height-100
        let frame = CGRect(x: frameX, y: frameY, width: widthFrame, height: 35)
        
        let toastLabel = UILabel(frame: frame)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        
        viewSelf.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
