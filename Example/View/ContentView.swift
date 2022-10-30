//
//  ContentView.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/10.
//

import SwiftUI
import JDA

struct ContentView: ViewType {
  typealias ViewModel = ContentViewModel
  @StateObject var viewModel: ContentViewModel
  
  // body는 뷰를 구성하는곳
  var body: some View {
    NavigationView {
      VStack {
        Button("Request") {
          viewModel.action.send(.buttonDidTap)
        }
        
        Text(viewModel.state.response)
        
        Text(viewModel.state.validText)
        
        TextField("Validation Text", text: viewModel.value(value: {
          $0.inputText
        }, input: {
          ContentViewModel.Action.validationText($0)
        }))
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentViewBuilder.content.view
  }
}

