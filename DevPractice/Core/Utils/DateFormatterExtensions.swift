//
//  DateFormatorExtensions.swift
//  DevPractice
//
//  Created by Tony Mu on 10/11/21.
//

import Foundation

class DateTestHelper {
    static func createDate(year: Int = 2021,
                           month: Int = 1,
                           day: Int = 1,
                           hour: Int = 0,
                           min: Int = 0,
                           sec: Int = 0,
                           timeZoneId: String = "Pacific/Auckland") -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = min
        dateComponents.second = sec
        dateComponents.timeZone = TimeZone(abbreviation: timeZoneId)
        return NSCalendar(calendarIdentifier: .gregorian)?.date(from: dateComponents)
    }
}

extension DateFormatter {
    static var baseFormattor: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_NZ")
        formatter.timeZone = TimeZone(identifier: "Pacific/Auckland")
        formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return formatter
    }
    
    static var isoDateFormatter: DateFormatter {
        let formatter = baseFormattor
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    static var ddMMMyyyDateFormatter: DateFormatter {
        let formatter = baseFormattor
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }
}
