//
//  TextStyle.swift
//  Apod-Nasa
//
//  Created by Thays Prado on 29/01/25.
//

import SwiftUI

internal enum NasaFontWeight: String {
    case regular = "Regular"
    case bold = "Bold"
    case black = "Black"
    case light = "Light"

    var swiftUIFontWeight: Font.Weight {
        switch self {
        case .regular:
            return .regular
        case .bold:
            return .bold
        case .black:
            return .black
        case .light:
            return .light
        }
    }
}

internal enum NasaTextStyle {
    /// Default Size 60pt
    case largeTitle
    /// Default Size 44pt
    case title1
    /// Default Size 34pt
    case title2
    /// Default Size 24pt
    case title3
    /// Default Size 22pt
    case subheadline
    /// Default Size 16pt
    case body
    /// Default Size 13pt
    case callout
    
    internal var size: CGFloat {
        var size: CGFloat = 0
        switch self {
        case .largeTitle:
            size = 60
        case .title1:
            size = 44
        case .title2:
            size = 34
        case .title3:
            size = 24
        case .subheadline:
            size = 22
        case .body:
            size = 16
        case .callout:
            size = 13
        }
        return size
    }
    
    internal var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        }
    }
}
