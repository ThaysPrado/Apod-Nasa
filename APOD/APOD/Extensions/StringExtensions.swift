//
//  StringExtensions.swift
//  APOD
//
//  Created by Thays Prado on 01/02/25.
//

extension String {
    func removeBreakLines() -> String {
        return self.replacingOccurrences(of: "\n", with: "")
    }
}
