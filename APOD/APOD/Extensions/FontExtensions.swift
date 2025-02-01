//
//  FontExtensions.swift
//  Apod-Nasa
//
//  Created by Thays Prado on 29/01/25.
//

import SwiftUI

extension Font {
    /// - Parameters:
    ///   - weight: Font Weight (regular, light, bold)
    ///   - forTextStyle: Font size
    static func helvetica(with weight: NasaFontWeight, forTextStyle customStyle: NasaTextStyle) -> Font {
        let name = "Helvetica-\(weight.rawValue)"
        if let uiFont = UIFont(name: name, size: customStyle.size) {
            return Font(uiFont as CTFont)
        }
        return .system(size: customStyle.size, weight: weight.swiftUIFontWeight, design: .default)
    }
}
