//
//  MultiSelectionPickerView.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import SwiftUI

// https://github.com/SimplyKyra/SimplyKyraBlog/blob/main/SwiftExamples/CustomMultiSelectionPicker.swift
struct MultiSelectionPickerView<T: MultiSelectionType>: View where T: Equatable {
    // The list of items to display
    let allItems: [T]
    // Binding to the selected items
    @Binding var selectedItems: [T]
    
    var body: some View {
        Form {
            List {
                ForEach(allItems) { item in
                    Button(action: {
                        withAnimation {
                            if selectedItems.contains(item) {
                                selectedItems.removeAll { $0 == item }
                            } else {
                                selectedItems.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(selectedItems.contains(item) ? 1.0 : 0.0)
                            Text(item.title)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
    }
}


//#Preview {
//    MultiSelectionPickerView(allItems: ["Tinashe", "Rabbi", "Cash"], selectedItems: .constant(["Tinashe", "Rabbi"]))
//}
