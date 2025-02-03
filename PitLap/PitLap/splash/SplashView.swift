//
//  SplashView.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 20/01/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            ProgressView()
        }.frame(alignment: .center)
    }
}


struct F1SoftTyre: View {
    var body: some View {
        Circle()
            .fill(Color.red)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .padding(8)
            )

    }
}

struct RollingTyreView: View {
    @State private var rotation = 0.0
    @State private var offset: CGFloat = -200

    var body: some View {
        F1SoftTyre()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(rotation))
            .offset(x: offset)
            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: rotation)
            .onAppear {
                withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                    rotation = 360
                    offset = 200
                }
            }
    }
}

struct RollingTyreView_Previews: PreviewProvider {
    static var previews: some View {
        RollingTyreView()
    }
}



#Preview {
    SplashView()
}
