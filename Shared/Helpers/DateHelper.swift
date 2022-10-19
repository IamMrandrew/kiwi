//
//  DateHelper.swift
//  Kiwi
//
//  Created by Andrew Li on 12/10/2022.
//

import Foundation

class DateHelper {
    static var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        return calendar
    }
    
    // Predefined days getters
    
    static func getStartOfToday() -> Date {
        return calendar.startOfDay(for: Date())
    }
    
    static func getEndOfToday() -> Date {
        return calendar.date(byAdding: .day, value: 1, to: getStartOfToday())!
    }
    
    static func getStartOfYesterday() -> Date {
        return calendar.date(byAdding: .day, value: -2, to: getStartOfToday())!
    }
    
    static func getStartOfNDaysBefore(days: Int) -> Date {
        return calendar.date(byAdding: .day, value: -days, to: getStartOfToday())!
    }
    
    // Boolean getters for filters
    static func isItemTodayOnly(_ item: EntryEntity) -> Bool {
        return item.entryTime! >= DateHelper.getStartOfToday() && item.entryTime! < DateHelper.getEndOfToday()
    }
    
    static func isItemYesterdayOnly(_ item: EntryEntity) -> Bool {
        return item.entryTime! >= DateHelper.getStartOfYesterday() && item.entryTime! < DateHelper.getStartOfToday()
    }
    
}
