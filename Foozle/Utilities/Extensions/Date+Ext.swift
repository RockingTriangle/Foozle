//
//  Date+Ext.swift
//  Foozle
//
//  Created by Mike Conner on 6/4/21.
//

import SwiftUI

extension Date {
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self)
    }
}
