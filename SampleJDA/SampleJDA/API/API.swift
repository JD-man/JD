//
//  API.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/30.
//

import Foundation

protocol APIType {
  var baseURL: String { get }
  var path: String { get }
  var parameter: [String: Any]? { get }
  var header: [String: String]? { get }
}

enum API {
  case singleUser(id: Int)
}

extension API: APIType {
  var baseURL: String {
    return "https://reqres.in"
  }
  
  var path: String {
    switch self {
    case .singleUser(let id):
      return "/api/users/\(id)"
    }
  }
  
  var parameter: [String : Any]? {
    switch self {
    case .singleUser: return nil
    }
  }
  
  var header: [String : String]? {
    return nil
  }
}
