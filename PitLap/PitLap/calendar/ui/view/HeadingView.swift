//
//  HeadingView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 31/12/2024.
//

import SwiftUI

struct HeadingView: View {

    private let headingImage: String
    private let headingText: String

    init(headingImage: String, headingText: String) {
        self.headingImage = headingImage
        self.headingText = headingText
    }

    var body: some View {
        HStack {
            Image(systemName: headingImage)
                .foregroundColor(.accentColor)
                .imageScale(.large)

            Text(headingText)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}
