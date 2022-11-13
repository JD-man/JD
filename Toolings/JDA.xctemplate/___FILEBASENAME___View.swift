//___FILEHEADER___

import SwiftUI
import JDA

struct ___VARIABLE_jdaname___View: ViewType {
  @StateObject var viewModel: ___VARIABLE_jdaname___ViewModel
  
  var body: some View {
    EmptyView()
  }
}

struct ___VARIABLE_jdaname___View_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = ___VARIABLE_jdaname___ViewModel()
    ___VARIABLE_jdaname___View(viewModel: viewModel)
  }
}
