//
//  Formatters.swift
//  NetStreamAppleTV
//
//  Created by Oleksii Shvachenko on 6/7/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Foundation

extension DateFormatter {

  static var unlocalizedTimeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = "HH:mm"
    return formatter
  }

  static var timeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("HH:mm")
    return formatter
  }

  static var panTimeFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("HH:mm:ss")
    return formatter
  }
  
  static var selectDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("MMMM d YYYY")
    return formatter
  }
  
  static var tvGuideSelectedDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("E d MMM")
    return formatter
  }

  static var recordingDateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("EEEE d MMM")
    return formatter
  }
  
}
