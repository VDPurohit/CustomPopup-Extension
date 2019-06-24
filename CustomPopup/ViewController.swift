//
//  ViewController.swift
//  CustomPopup
//
//  Created by Admin on 24/06/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnShowAlert:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func btnShowPopupClicked(_ sender: UIButton) {
        CustomAlertVC.showPopup(in: self) { (value) in
            if (value) {
                print("true")
            }else {
                print("false")
            }
        }
    }
    
}

