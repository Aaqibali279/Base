//
//  ViewController.swift
//  Base
//
//  Created by Aqib Ali on 28/06/20.
//  Copyright © 2020 Aqib Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func show(_ sender: Any) {
        showSnackBar(message: "Hello", actionText: "CLOSE") {
            
        }
    }
    
}

