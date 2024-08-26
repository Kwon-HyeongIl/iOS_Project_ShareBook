//
//  Room3DView.swift
//  ShareBook
//
//  Created by 권형일 on 7/28/24.
//

import SwiftUI
import SplineRuntime

struct ScatteredBook3DView: View {
    var body: some View {
        let url = Bundle.main.url(forResource: "scatteredBook3D", withExtension: "splineswift")!
         
        SplineView(sceneFileURL: url)
            .scaledToFill()
            .frame(width: 250, height: 170)
    }
}

#Preview {
    ScatteredBook3DView()
}
