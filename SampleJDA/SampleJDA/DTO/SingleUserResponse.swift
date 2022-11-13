//
//  Models.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/30.
//

import Foundation

struct SingleUserResponse: Codable {
  var data: SingleUserData
  var support: SingleUserSupport
}

struct SingleUserData: Codable {
  var id: Int
  var email: String
  var firstName: String
  var lastName: String
  var avatar: String
  
  enum CodingKeys: String, CodingKey {
    case id, avatar, email
    case firstName = "first_name"
    case lastName = "last_name"
  }
}

struct SingleUserSupport: Codable {
  var url: String
  var text: String
}

/*
 {
     "data": {
         "id": 2,
         "email": "janet.weaver@reqres.in",
         "first_name": "Janet",
         "last_name": "Weaver",
         "avatar": "https://reqres.in/img/faces/2-image.jpg"
     },
     "support": {
         "url": "https://reqres.in/#support-heading",
         "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
     }
 }
 */
