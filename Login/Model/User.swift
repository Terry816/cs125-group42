//
//  User.swift
//  Hydration
//
//  Created by Philip Nguyen on 3/5/24.
//

import Foundation

struct User : Identifiable, Codable{
    
    var id: String
    var fullname: String
    var email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return "" //maybe make the image of the person here
    }
    
    var age: Int
    var gender: String
    var height: Int
    var weight: Int
    var activity: String
    
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Terry Kim", email: "test@gmail.com", age: 20, gender: "Male", height: 190, weight: 250, activity: "Sedentary")
}
