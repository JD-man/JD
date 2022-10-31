//
//  ActionSubject.swift
//  MVVMSwiftUIStudy
//
//  Created by JD-man on 2022/10/30.
//

import Combine

final public class ActionSubject<Action> {
  private let subject: PassthroughSubject<Action, Never>
  private var isInitiated: Bool
  
  public init() {
    self.subject = .init()
    self.isInitiated = false
  }
  
  func stream() -> PassthroughSubject<Action, Never> {
    return subject
  }
  
  public func send(_ action: Action) {
    assert(isInitiated, "Please ViewModel.start()")
    subject.send(action)
  }
  
  func initiateSubject() {
    isInitiated = true
  }
}
