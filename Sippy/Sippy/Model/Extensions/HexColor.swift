//
//  HexColor.swift
//  Sippy
//
//  Created by Dmitry on 17.05.2024.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xff) / 255,
                green: Double((hex >> 08) & 0xff) / 255,
                blue: Double((hex >> 00) & 0xff) / 255,
                opacity: alpha
            )
        }
}
