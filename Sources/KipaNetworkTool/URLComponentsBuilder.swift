//
//  URLComponentsBuilder.swift
//
//
//  Created by Daniel Prastiwa on 19/02/22.
//

import Foundation

// MARK: - URLComponents Builder

public class URLComponentsBuilder {
  
  private var components = URLComponents()
  
  public init(
    scheme: String,
    host: String,
    path: String
  ) {
    components.scheme = scheme
    components.host = host
    components.path = path
  }
  
  @discardableResult
  public func addPath(_ path: String) -> Self {
    if !path.isEmpty {
      components.path.append("/\(path)")
    }
    return self
  }
  
  @discardableResult
  public func setQueryItems(queries: [URLQueryItem]) -> Self {
    components.queryItems = queries
    return self
  }
  
  public func build() -> URLComponents {
    return components
  }
  
}
