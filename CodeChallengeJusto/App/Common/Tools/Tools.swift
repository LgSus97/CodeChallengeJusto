//
//  Tools.swift
//  CodeChallengeJusto
//
//  Created by Jesus Loaiza Herrera on 07/08/22.
//

import Foundation

class Tools {
  class func getIdShortVideo(urlVideo:String) -> String{
    var id = String()
    let pattern = ##"^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*"##
    let regex = try! NSRegularExpression(pattern: pattern)
    let stringRange = NSRange(location: 0, length: urlVideo.utf16.count)
    if let firstMatch = regex.firstMatch(in: urlVideo, range: stringRange) {
      let result: [String] = (1 ..< firstMatch.numberOfRanges).map { (urlVideo as NSString).substring(with: firstMatch.range(at: $0)) }
      print(result)
      id = result[0]
    } else {
      id = String()
      print("No matches were found.")
    }
    return id
  }
  
}
