//
//  MyUserdefaults.swift
//  WalletX
//
//  Created by ElintMinds_11 on 06/03/20.
//  Copyright © 2020 ElintMinds_11. All rights reserved.
//

import Foundation

struct MyUserDefaults {
    static let instance = MyUserDefaults()
    private init(){}
    
    enum Key:String {
        case accessToken,userId,email,password
    }
    
    private let defaults = UserDefaults.standard
    
    func set<T:Any>(value:T,key:Key){
        defaults.setValue(value, forKey:key.rawValue)
    }
    
    func get<T>(key:Key) -> T? {
        return defaults.value(forKey: key.rawValue) as? T
    }
    
    func wipeAllData(){
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
