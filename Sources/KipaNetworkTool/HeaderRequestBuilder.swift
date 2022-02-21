//
//  HeaderRequestBuilder.swift
//  
//
//  Created by Daniel Prastiwa on 21/02/22.
//

import Foundation

public class HeaderRequestBuilder {
  
  private var header: HeaderNetworkRequest = [:]
  
  //crete singleton
  private static var shared: HeaderRequestBuilder?
  
  public class var sharedInstance: HeaderRequestBuilder {
    guard let shared = self.shared else {
      let shared = HeaderRequestBuilder()
      self.shared = shared
      return shared
    }
    return shared
  }
  
  public class func destroyHeader(){
    shared = nil
  }
  
  public func setJsonContent() -> Self {
    header["Content-Type"] = "application/json"
    return self
  }
  
  public func setFormUrlEncoded() -> Self {
    header["Content-Type"] = "application/x-www-form-urlencoded"
    return self
  }
  
  public func withToken(auth: String) -> Self {
    if !auth.isEmpty {
      header["Authorization"] = "Bearer \(auth)"
    }
    return self
  }
  
  public func setNoCache() -> Self {
    header["Cache-Control"] = "no-cache"
    return self
  }
  
  public func build() -> HeaderNetworkRequest {
    return header
  }
  
  public func builds() {
    headers = header
  }
  
  var headers: [String: String] {
    get{
      return header
    }
    
    set{}
  }
}
