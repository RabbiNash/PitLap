//
//  AppIconService.swift
//  PitLap
//
//  Created by Tinashe Makuti on 18/02/2025.
//

import Foundation
import UIKit

protocol AppIconServiceType {
    func updateAppIcon(to iconName: String?, completion: ((Error?) -> Void)?)
}

struct AppIconService: AppIconServiceType {
    func updateAppIcon(to iconName: String?, completion: ((Error?) -> Void)? = nil) {
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: completion)
    }
}

