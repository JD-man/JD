//
//  ViewType.swift
//  MVVMSwiftUIStudy
//
//  Created by JD-man on 2022/10/30.
//

import SwiftUI

public protocol ViewType: View {
  associatedtype ViewModel: ViewModelType
  var viewModel: ViewModel { get }
}
