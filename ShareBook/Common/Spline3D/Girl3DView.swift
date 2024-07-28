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
        let url = Bundle.main.url(forResource: "girl3D", withExtension: "splineswift")!
        
        SplineView(sceneFileURL: url)
            .clipShape(Rectangle())
            .scaledToFill()
            .frame(width: 395, height: 550)
    }
}

#Preview {
    Girl3DView()
}
