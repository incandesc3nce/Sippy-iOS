//
//  UserInfo.swift
//  Sippy
//
//  Created by Dmitry on 18.05.2024.
//

import Foundation

struct UserInfo {
    var name: String = ""
    var password: String = ""
    var email: String = ""
    
    var gender: Int = 0
    var age: Int = 0
    
    var token: String = ""
}

var localUser = UserInfo()
