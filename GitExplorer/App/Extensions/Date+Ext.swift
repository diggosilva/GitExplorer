//
//  Date+Ext.swift
//  GitExplorer
//
//  Created by Diggo Silva on 16/03/25.
//

import Foundation

extension Date {
    func formatDate() -> String {
        return formatted(.dateTime.month().year())
    }
}
