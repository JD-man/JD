//
//  ViewBuilder.swift
//  MVVMSwiftUIStudy
//
//  Created by 조동현 on 2022/10/30.
//

import Foundation
import SwiftUI
import JDA

protocol ViewBuilderType {
  associatedtype ViewType: View
  var view: ViewType { get }
}

enum ContentViewBuilder: ViewBuilderType {
  case content
  
  var view: some View {
    switch self {
    case .content:
      return makeContentView()
    }
  }
}

extension ContentViewBuilder {
  @ViewBuilder
  private func makeContentView() -> some View {
    let contentViewModel = ContentViewModel().start()
    ContentView(viewModel: contentViewModel)
  }
}
