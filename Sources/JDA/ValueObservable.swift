//
//  ValueObservable.swift
//  MVVMSwiftUIStudy
//
//  Created by JD-man on 2022/10/29.
//

import Foundation
import Combine

final class ValueObservable<T, Action>: ObservableObject {
  
  var value: T {
    willSet {
      action.send(input(newValue))
    }
  }

  private let input: (T) -> Action
  private let action: ActionSubject<Action>

  init(
    value: T,
    action: ActionSubject<Action>,
    input: @escaping (T) -> Action
  ) {
    self.value = value
    self.action = action
    self.input = input
  }
}
