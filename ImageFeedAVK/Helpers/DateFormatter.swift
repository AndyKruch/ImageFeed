//
//  DateFormatter.swift
//  ImageFeedAVK
//
//  Created by Andy Kruch on 13.07.23.
//

import Foundation

extension Date {
    static private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    
    var dateTimeString: String { Date.dateFormatter.string(from: self) }
    
    func convertStringToDate(_ string: String) -> Date? {
        let date = Date.dateFormatter.date(from: string)
        return date
    }
}

