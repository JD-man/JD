# JDA

조동의 SwiftUI 구조 연구 대소동

---

## ViewModel

### ViewModelType
- 뷰모델 클래스에 ViewModelType 프로토콜 채택
```swift
import JDA

final class ContentViewModel: ViewModelType { }
```

### Property
- 기본 프로퍼티 3형제 초기화
```swift
  @Published var state = State()
  var action = ActionSubject<Action>()
  var cancelable = Set<AnyCancellable>()
```

### Action
- View에 Binding되는 Action (enum)

```swift
enum Action {
  case buttonDidTap
  case validationText(String)
}
```

### effect()
- Action에 의한 Networking과 같은 effect가 일어남
- Publisher<Effect, Never>를 반환

```swift
func effect(action: Action) -> any Publisher<Effect, Never> {
  switch action {
  case .buttonDidTap:
    guard let id = Int(state.inputText) else { 
      return Empty().eraseToAnyPublisher()
    }
    return APIService.shared.singleUser(id: id)
      .map { _ in .reqres }
      .catch { _ in return Just<Effect>(.reqresError) }
    case .validationText(let text):
      return Just(.validation(text))
  }
}
```

### Effect
- effect()의 결과로 실행되는 Effect (enum)

```swift
enum Effect {
  case reqres
  case reqresError
  case validation(String)
}
```

### reduce()
- Effect의 실행으로 State 변경

```swift
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
```

### State
- View의 상태
```swift
struct State {
  var response: String = "response"
  var inputText: String = ""
  var validText: String = "validtext"
}
```

---

## View

### ViewType Protocol
- View는 ViewType 프로토콜 채택
```swift
struct ContentView: ViewType { }
```

### ViewModel 정의
```swift
typealias ViewModel = ContentViewModel
@StateObject var viewModel: ContentViewModel
```

### Action Binding
- Button 등의 Action
```swift
Button("Request") {
  viewModel.action.send(.buttonDidTap)
}
```

- TextField 등의 Binding
```swift
TextField("Validation Text", text: viewModel.value(value: {
    $0.inputText
  }, input: {
    ContentViewModel.Action.validationText($0)
}))
```

### State Usage
- 필요한곳에 ViewModel State 사용
```swift
Text(viewModel.state.response)        
Text(viewModel.state.validText)
```

---