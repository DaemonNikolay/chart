//
//  ViewController.swift
//  chart
//
//  Created by Nikolay Eckert on 15/09/2019.
//  Copyright © 2019 Nikolay Eckert. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var buttonGo: UIButton!
    @IBOutlet weak var textFieldCountPoints: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let api = Api()
        //        api.getPoints()
    }
    
    @IBAction func buttonGo_Click(_ sender: UIButton) {
        print(textFieldCountPoints?.text ?? "Empty field")
        
        //        self.performSegue(withIdentifier: "showTableAndChart", sender: self)
        
        let st : UIStoryboard = UIStoryboard(name: "TCs", bundle: nil)
        
        let vc = st.instantiateViewController(withIdentifier: "TCs")
        
        self.present(vc, animated: true, completion:nil)
    }
}
