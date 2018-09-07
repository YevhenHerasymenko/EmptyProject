//
//  DateFormatter.swift
//  ukmdm
//
//  Created by Yevhen Herasymenko on 12/22/17.
//  Copyright © 2017 UK MDM. All rights reserved.
//

import Foundation

extension DateFormatter {

  // Formatter for standart date in ISO style
  @nonobjc static var formatISO: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }

}
