//
//  PitlapTabView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 12/02/2025.
//

import SwiftUI

//struct CustomPicker<T: Hashable & CaseIterable>: View {
//    @Binding var selectedOption: T
//    var titleProvider: (T) -> String
//    var color: Color
//    
//    var body: some View {
//        HStack {
//            ForEach(Array(T.allCases), id: \._self) { option in
//                Button(action: {
//                    withAnimation {
//                        selectedOption = option
//                    }
//                }) {
//                    Text(titleProvider(option))
//                        .font(.system(size: 14, weight: .medium))
//                        .padding(.horizontal, 16)
//                        .padding(.vertical, 8)
//                        .background(selectedOption == option ? color : Color.clear)
//                        .foregroundColor(selectedOption == option ? .white : color)
//                        .overlay(
//                            Capsule()
//                                .stroke(color, lineWidth: selectedOption == option ? 0 : 1)
//                        )
//                        .clipShape(Capsule())
//                }
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .padding(4)
//        .cornerRadius(10)
//        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
//    }
//}
