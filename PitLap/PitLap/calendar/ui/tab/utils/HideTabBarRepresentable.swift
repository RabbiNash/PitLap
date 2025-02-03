//
//  Hide.swift
//  PitLap
//
//  Created by Tinashe MAKUTI on 21/01/2025.
//

import SwiftUI
import UIKit

struct HideTabBar: UIViewRepresentable {
    init(result: @escaping () -> Void) {
        UITabBar.appearance().isHidden = true
        self.result = result
    }

    var result: () -> ()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear

        DispatchQueue.main.async {
            if let tabController = view.tabController {
                UITabBar.appearance().isHidden = false
                tabController.tabBar.isHidden = true
                result()
            }
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {  }
}

extension UIView {
    var tabController: UITabBarController? {
        if let controler = sequence(first: self, next: { $0.next }).first(where: { $0 is UITabBarController }) {
            return controler as? UITabBarController
        }

        return nil
    }
}
