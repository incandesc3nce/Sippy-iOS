//
//  UserInfo.swift
//  Sippy
//
//  Created by Dmitry on 18.05.2024.
//

import Foundation

struct UserInfo {
    var name: String = "Иван"
    var password: String = ""
    var email: String = ""
    
    var gender: Int = 1
    var age: Int = 0
    
    var bio: String = ""
    
    
}

var loggedIn = false
var userToken: String = UserDefaults.standard.string(forKey: "token") ?? ""

var localUser = UserInfo()

var pointsAround: [NearestPoint] = []

var nearLocations: [Location] = []
