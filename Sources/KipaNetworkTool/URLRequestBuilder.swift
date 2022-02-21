//
//  URLRequestBuilder.swift
//  
//
//  Created by Daniel Prastiwa on 21/02/22.
//

import Foundation

public class URLRequestBuilder {
  var baseURL: URL
  var path: String
  var method: NetworkRequestMethod = .get
  var headers: HeaderNetworkRequest?
  var parameters: NetworkRequestParameters?
  var files: [FileDataBody]?
  var httpBody: Data?
  var urlRequest: URLRequest!
  
  public init(with baseURL: URL, path: String) {
    self.baseURL = baseURL
    self.path = path
  }
  
  @discardableResult
  func set(method: NetworkRequestMethod) -> Self {
    self.method = method
    return self
  }
  
  @discardableResult
  func set(path: String) -> Self {
    self.path = path
    return self
  }
  
  @discardableResult
  func set(headers: HeaderNetworkRequest?) -> Self {
    self.headers = headers
    return self
  }
  
  @discardableResult
  public func set(parameters: NetworkRequestParameters?) -> Self {
    self.parameters = parameters
    return self
  }
  
  @discardableResult
  public func set(httpBody: Data?) -> Self {
    self.httpBody = httpBody
    return self
  }
  
  public func build(requestType: URLRequestType = .defaultRequest) throws -> URLRequest {
    switch requestType {
    case .multipart(let boundary):
      return buildMultipartRequest(boundary)
    case .defaultRequest:
      return buildDefaultRequest()
    }
  }
  
  private func initURLRequest() {
    urlRequest = URLRequest(
      url: baseURL.appendingPathComponent(path),
      cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
      timeoutInterval: 100
    )
    
    urlRequest.httpMethod = method.rawValue
  }
  
  private func buildMultipartRequest(_ boundary: String) -> URLRequest {
    initURLRequest()
    
    headers?.forEach {
      urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
    }
    
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)",
                        forHTTPHeaderField: "Content-Type")
    
    if let params = self.parameters {
      let formDataBuilder = MultipartFormDataBuilder()
        .set(boundaryString: boundary)
        .set(params: params)
      
      if let files = self.files {
        formDataBuilder.set(files: files)
      }
      
      urlRequest.httpBody = formDataBuilder.build()
    }
    
    return urlRequest
  }
  
  private func buildDefaultRequest() -> URLRequest {
    initURLRequest()
    urlRequest.httpBody = httpBody
    
    headers?.forEach {
      urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
    }
    
    return urlRequest
  }
  
  
}
