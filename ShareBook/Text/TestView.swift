//
//  TestVIew.swift
//  ShareBook
//
//  Created by 권형일 on 8/8/24.
//

import SwiftUI

@Observable 
class ViewModel {
    var text = ""
}

struct ParentView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        VStack {
            ChildView(viewModel: viewModel)

            Text("입력값: \(viewModel.text)")
        }
    }
}

struct ChildView: View {
    @Bindable var viewModel: ViewModel

    var body: some View {
        TextField("입력하세요", text: $viewModel.text)
    }
}


#Preview {
    ParentView()
}
