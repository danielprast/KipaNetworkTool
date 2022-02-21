//
//  FormDataBuilder.swift
//  
//
//  Created by Daniel Prastiwa on 21/02/22.
//

import Foundation

public class MultipartFormDataBuilder {
  
  let lineBreak = "\r\n"
  var dataBody = Data()
  var boundary = MultipartFormDataBuilder.generateBoundaryString()
  
  static public func generateBoundaryString() -> String {
    return "Boundary-\(UUID().uuidString)"
  }
  
  @discardableResult
  public func set(boundaryString boundary: String) -> Self {
    self.boundary = boundary
    return self
  }
  
  @discardableResult
  public func set(params: NetworkRequestParameters) -> Self {
    for (key, value) in params {
      dataBody.append("--\(boundary + lineBreak)")
      dataBody.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
      dataBody.append("\(value)\(lineBreak)")
    }
    
    return self
  }
  
  @discardableResult
  public func set(files: [FileDataBody]) -> Self {
    for file in files {
      dataBody.append("--\(boundary + lineBreak)")
      dataBody.append("Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.filename)\"\(lineBreak)")
      dataBody.append("Content-Type: \(file.mimeType + lineBreak + lineBreak)")
      dataBody.append(file.data)
      dataBody.append(lineBreak)
    }
    
    return self
  }
  
  public func build() -> Data {
    dataBody.append("--\(boundary)--\(lineBreak)")
    return dataBody
  }
}
