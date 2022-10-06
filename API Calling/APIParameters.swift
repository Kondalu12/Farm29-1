//
//  APIParameters.swift
//  WOQOODY APP
//
//  Created by eAlphaMac2 on 28/09/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import Alamofire
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

struct APIParameters {
    static let baseURL = "http://3.109.142.98/"
    static let AllContentbaseURL = "http://3.109.142.98/api/v1/"
    static let AllCompetitonbaseURL = "https://8x5woqwmtg.execute-api.ap-south-1.amazonaws.com/dev/"
    static let AllContestbaseURL = "https://el9mdk3862.execute-api.ap-south-1.amazonaws.com/dev"
//http://192.168.1.69:8000/
   // "http://3.109.142.98/api/v1/"
    //http://192.168.1.69:8000/
}
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    
    }

    enum ContentType: String {
        case json = "application/json"
        case Loginjson = "application/raw"
        //x-www-form-urlencoded
    }

