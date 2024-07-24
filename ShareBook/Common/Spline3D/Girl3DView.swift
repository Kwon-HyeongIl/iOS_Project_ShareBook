//
//  GirlView.swift
//  ShareBook
//
//  Created by 권형일 on 7/23/24.
//

import SwiftUI
import SplineRuntime

struct Girl3DView: View {
    var body: some View {
        let url = URL(string: "https://build.spline.design/OXLvOKSJCJsWX1vI51tS/scene.splineswift")!
        
        SplineView(sceneFileURL: url).ignoresSafeArea(.all)
            .clipShape(Rectangle())
            .scaledToFill()
            .frame(width: 395, height: 550)
    }
}

#Preview {
    Girl3DView()
}
