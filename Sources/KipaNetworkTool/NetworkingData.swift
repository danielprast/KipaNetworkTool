//
//  NetworkingData.swift
//  
//
//  Created by Daniel Prastiwa on 21/02/22.
//

import Foundation

public enum NetworkRequestMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum RequestParams {
    case body(_: [String: Any]?)
    case url(_: [String: Any]?)
}

public enum URLRequestType {
  case defaultRequest
  case multipart(_ boundary: String)
}

public struct FileDataBody {
  let key: String
  let filename: String
  let data: Data
  let mimeType: String
}

public struct TextPlainBody {
  let key: String
  let value: String
  let mimeType: String
  
  public init(key: String, value: String) {
    self.key = key
    self.value = value
    self.mimeType = "text/plain"
  }
}

extension Dictionary {
  public func percentEscaped() -> String {
    return map { (key, value) in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
    }.joined(separator: "&")
  }
}

extension CharacterSet {
  static public let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@"
    let subDelimitersToEncode = "!$&'()*+,;="
    
    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}

extension Data {
    mutating public func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
