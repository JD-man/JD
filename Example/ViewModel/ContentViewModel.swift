//
//  ViewModel.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/10.
//

import Foundation
import Combine
import SwiftUI
import JDA

final class ContentViewModel: ObservableObject, ViewModelType {
  @Published var state = State()
  var action = ActionSubject<Action>()
  var cancelable = Set<AnyCancellable>()
  
  enum Action {
    case buttonDidTap
    case validationText(String)
  }
  
  enum Effect {
    case reqres
    case reqresError
    case validation(String)
  }
  
  struct State {
    var response: String = "response"
    var inputText: String = ""
    var validText: String = "validtext"
  }
  
  func effect(action: Action) -> any Publisher<Effect, Never> {
    switch action {
    case .buttonDidTap:
      guard let id = Int(state.inputText) else { return Empty().eraseToAnyPublisher() }
      return APIService.shared.singleUser(id: id)
        .map { _ in .reqres }
        .catch { _ in return Just<Effect>(.reqresError) }
    case .validationText(let text):
      return Just(.validation(text))
    }
  }
  
  func reduce(effect: Effect, state: State) -> State {
    var newState = state
    switch effect {
    case .reqres:
      newState.response = "reqres"
    case .reqresError:
      newState.response = "Error Occur"
    case .validation(let text):
      newState.inputText = text
      newState.validText = text.uppercased()
    }
    return newState
  }
}
