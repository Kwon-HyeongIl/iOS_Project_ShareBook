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
        let url = Bundle.main.url(forResource: "fullGirl3D", withExtension: "splineswift")!
        
        SplineView(sceneFileURL: url)
    }
}

#Preview {
    FullGirl3DView()
}
