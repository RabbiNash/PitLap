//
//  SessionItemView.swift
//  Box Box
//
//  Created by Tinashe MAKUTI on 31/12/2024.
//

import SwiftUI

struct SessionItemView: View {
    private let sessionName: String
    private let sessionTime: String

    init(sessionName: String, sessionTime: String) {
        self.sessionName = sessionName
        self.sessionTime = sessionTime
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(sessionName)
                    .frame(maxWidth: 120, alignment: .leading)

                Spacer()

                Text(Date.getHumanisedDate(dateString: sessionTime) ?? " ")
                    .lineLimit(2)

            }
            .frame(alignment: .leading)
            .padding(.top, 8)
            .padding(.bottom, 12)

            Divider()
        }
    }
}
