//
//  APIService.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/30.
//

import Foundation
import Combine

final class APIService {
  static let shared = APIService()
  
  func singleUser(id: Int) -> AnyPublisher<SingleUserResponse, Error> {
    let api = API.singleUser(id: id)
    guard let url = URL(string: api.baseURL + api.path) else { return Empty().eraseToAnyPublisher()
    }
    
    return URLSession.shared
      .dataTaskPublisher(for: url)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: SingleUserResponse.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
  }
}
