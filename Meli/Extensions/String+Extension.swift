//
//  String+Extension.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Foundation

extension String {
    static let empty = ""

    var toOnlyDate: String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = MeliConstants.DateFormat.dateWithTime
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = MeliConstants.DateFormat.onlyDate
        guard let date = inputFormatter.date(from: self) else { return nil }
        return outputFormatter.string(from: date)
    }
}
