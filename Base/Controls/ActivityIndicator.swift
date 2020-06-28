// 
//  ActivityIndicator.swift
//  breadwallet
//
//  Created by ElintMinds_11 on 11/05/20.
//  Copyright © 2020 Breadwinner AG. All rights reserved.
//
//  See the LICENSE file at the project root for license information.
//

import UIKit
import NVActivityIndicatorView

class ActivityIndicator: UIViewController , NVActivityIndicatorViewable {
    static let instance = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let color = UIColor.darkGray
    
    func show(with message:String) {
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: message + "...", type: .ballGridPulse, color: color, backgroundColor: UIColor.lightGray.withAlphaComponent(0.35), textColor: color)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("please wait...")
        }
        
    }
    
    func hide() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.stopAnimating(nil)
        }
    }
    
}

