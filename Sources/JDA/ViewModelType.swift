//
//  ViewModelType.swift
//  MVVMSwiftUIStudy
//
//  Created by JD-man on 2022/10/29.
//

import Foundation
import SwiftUI
import Combine

protocol ViewModelType: ObservableObject {
  associatedtype Action
  associatedtype Effect
  associatedtype State
  
  typealias EffectPublisher = any Publisher<Effect, Never>
  
  // Property
  var cancelable: Set<AnyCancellable> { get set }
  var action: ActionSubject<Action> { get }
  var state: State { get set }
  
  func effect(action: Action) -> EffectPublisher
  func reduce(effect: Effect, state: State) -> State
}

extension ViewModelType {
  fileprivate func initialBinding() {
    action.stream()
      .flatMap { [weak self] action -> AnyPublisher<Effect, Never> in
        guard let self = self else { return Empty().eraseToAnyPublisher() }
        return self.effect(action: action).eraseToAnyPublisher()
      }
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in
        guard let self = self else { return }
        self.state = self.reduce(effect: $0, state: self.state)
      }.store(in: &cancelable)
  }
  
  func start() -> Self {
    ViewModelStarter.start(self)
    return self
  }
  
  func value<T>(
    value: (State) -> T,
    input: @escaping (T) -> Action
  ) -> Binding<T> {
    let element = value(self.state)
    let observable = ValueObservable(
      value: element,
      action: self.action,
      input: input
    )
    return ObservedObject(initialValue: observable).projectedValue.value
  }
}

struct ViewModelStarter {
  private static var checker: [String: Bool] = [:]
  
  private static func isInitialed(_ viewModel: any ViewModelType) -> Bool {
    let viewModelName = String(describing: viewModel)
    guard let isChecked = checker[viewModelName] else { return false }
    return isChecked
  }
  
  private static func checkInitialState(_ viewModel: any ViewModelType, state: Bool) {
    let viewModelName = String(describing: viewModel)
    checker[viewModelName] = state
  }
  
  static func start(_ viewModel: some ViewModelType) {
    if isInitialed(viewModel) == false {
      viewModel.action.initiateSubject()
      viewModel.initialBinding()
      checkInitialState(viewModel, state: true)
    } else {
      checkInitialState(viewModel, state: false)
      start(viewModel)
    }
  }
}
