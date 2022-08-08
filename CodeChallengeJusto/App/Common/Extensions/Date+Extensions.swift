//
//  Date+Extensions.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import Foundation

extension Date {
  
  func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = fromFormat
    let date = inputDateFormatter.date(from: dateString)
    
    let outputDateFormatter = DateFormatter()
    outputDateFormatter.dateFormat = toFormat
    return outputDateFormatter.string(from: date!)
  }
  
}
