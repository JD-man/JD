//___FILEHEADER___

import Combine
import SwiftUI
import JDA

final class ___VARIABLE_jdaname___ViewModel: ViewModelType {
  @Published var state = State()
  var action = ActionSubject<Action>()
  var cancelable = Set<AnyCancellable>()
  
  enum Action {}
  
  enum Effect {}
  
  struct State {}
  
  func effect(action: Action) -> any Publisher<Effect, Never> {}
  
  func reduce(effect: Effect, state: State) -> State {}
}
