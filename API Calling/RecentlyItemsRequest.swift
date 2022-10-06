//
//  RecentlyItemsRequest.swift
//  Farm29
//
//  Created by eAlphaMac2 on 06/05/22.
//

import Foundation
import Alamofire
enum RecentlyItemsRequest: URLRequestConvertible {
    
    case getRecentlyItems
    case getOffers
    case viewedItems(itemID:Int)
    case getPushNotification(fcmtoken:String,deviceID:String,type:String)
    private var method: HTTPMethod {
        switch self {
        case .getRecentlyItems,.getOffers  :
            return .get
        case .viewedItems,.getPushNotification :
            return .post
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .getRecentlyItems, .getOffers,.viewedItems,.getPushNotification :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getRecentlyItems:
            return "order/RecentlyViewsAPI/"
        case .getOffers:
            return "order/ValidCouponListAPI/"
        
        case .viewedItems:
            return "order/RecentlyViewsAPI/"
        case .getPushNotification:
            return "devices"
        
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .viewedItems(let idd):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["view_item": idd]
        case .getRecentlyItems, .getOffers :
            return nil
        case .getPushNotification(let fcmtoken,let deviceID,let type):
            return ["registration_id": fcmtoken,"device_id":deviceID,"type":type]
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getRecentlyItems,.getOffers :
        urlstr =  APIParameters.AllContentbaseURL + path
    let url = try urlstr.asURL()
   // let url = URL(string: "\(AppData.baseUrlWithJsonApi)/my_content?is_blocked_in_mlibro=true")!
    
    var Request = URLRequest(url: url)

    // HTTP Method
        Request.httpMethod = method.rawValue
        Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            if let headers = headers {
                Request.headers = headers
            }

    return Request
        
        case .viewedItems:
            let url = try APIParameters.AllContentbaseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            urlRequest.httpMethod = method.rawValue
            // Common Headers
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            if let headers = headers {
                urlRequest.headers = headers
            }
            
            return urlRequest
        case .getPushNotification :
//            let url = try APIParameters.AllContentbaseURL.asURL()
//            var urlRequesttt = URLRequest(url: url.appendingPathComponent(path))
            urlstr =  APIParameters.baseURL + path
           let url = try urlstr.asURL()
       // let url = URL(string: "\(AppData.baseUrlWithJsonApi)/my_content?is_blocked_in_mlibro=true")!
        
        var urlRequesttt = URLRequest(url: url)
            // HTTP Method
            urlRequesttt.httpMethod = method.rawValue
            // Common Headers
            urlRequesttt.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequesttt.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
            if let parameters = parameters {
                do {
                    urlRequesttt.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            if let headers = headers {
                urlRequesttt.headers = headers
            }
            
            return urlRequesttt
    }
    }
}
