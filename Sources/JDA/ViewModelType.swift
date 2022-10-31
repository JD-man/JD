//
//  ViewModelType.swift
//  MVVMSwiftUIStudy
//
//  Created by JD-man on 2022/10/29.
//

import SwiftUI
import Combine

public protocol ViewModelType: ObservableObject {
  associatedtype Action
  associatedtype Effect
  associatedtype State
  
  // Property
  var cancelable: Set<AnyCancellable> { get set }
  var action: ActionSubject<Action> { get }
  var state: State { get set }
  
  func effect(action: Action) -> any Publisher<Effect, Never>
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
  
  public func start() -> Self {
    ViewModelStarter.start(self)
    return self
  }
  
  public func value<T>(
    _ value: (State) -> T,
    action input: @escaping (T) -> Action
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

public struct ViewModelStarter {
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
