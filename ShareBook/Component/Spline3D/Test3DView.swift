//
//  Test3DView.swift
//  ShareBook
//
//  Created by 권형일 on 7/29/24.
//

import SwiftUI
import SplineRuntime

struct Test3DView: View {
    var body: some View {
//        let url = Bundle.main.url(forResource: "fullGirl3D", withExtension: "splineswift")!
        let url = URL(string: "https://build.spline.design/1tnjs-hjoG2dS6mdUTh9/scene.splineswift")!

        HStack {
            SplineView(sceneFileURL: url)
                .frame(width: 100, height: 100)
                .border(.black)
            
            Text("dfs")
        }
    }
}

#Preview {
    Test3DView()
}
