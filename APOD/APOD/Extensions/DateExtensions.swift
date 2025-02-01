//
//  DateExtensions.swift
//  APOD
//
//  Created by Thays Prado on 31/01/25.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
