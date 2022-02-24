//
//  NetworkError.swift
//  
//
//  Created by Daniel Prastiwa on 21/02/22.
//

import Foundation

public enum NetworkError: LocalizedError {
  case custom(String)
  case cannotMapToObject
  case nilValue(String)
  case unauthorized           //Status code 401
  case forbidden              //Status code 403
  case notFound               //Status code 404
  case internalServerError    //Status code 500
  case noInternetConnection
  case badRequest
  case parsingError
}
