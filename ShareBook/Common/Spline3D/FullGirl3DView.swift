//
//  3DRoomView.swift
//  ShareBook
//
//  Created by 권형일 on 7/23/24.
//

import SwiftUI
import SplineRuntime

struct FullGirl3DView: View {
    var body: some View {
        let url = URL(string: "https://build.spline.design/7BgJtNEz09DV9AFPcOx2/scene.splineswift")!
        
        SplineView(sceneFileURL: url)
            .clipShape(Rectangle())
            .scaledToFill()
            .frame(width: 395, height: 550)
    }
}

#Preview {
    FullGirl3DView()
}
