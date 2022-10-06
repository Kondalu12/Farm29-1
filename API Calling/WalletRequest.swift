//
//  WalletRequest.swift
//  Farm29
//
//  Created by FLYPIGEON on 04/07/22.
//

import Foundation
import Alamofire
enum WalletRequest: URLRequestConvertible {
    
  
   case getWalletBalance
    case getWalletTransaction
    private var method: HTTPMethod {
        switch self {
        case .getWalletBalance  :
            return .get
        case .getWalletTransaction :
            return .get
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .getWalletBalance,.getWalletTransaction :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
//    case .deleteUser :
//        return nil
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getWalletBalance:
            return "f29/WalletAPI/"
        case .getWalletTransaction:
            return "f29/WalletTransactionAPI/"
        }
    }
    private var parameters: Parameters? {
        switch self {
    
        
        case .getWalletBalance,.getWalletTransaction:
            return nil
       
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getWalletBalance,.getWalletTransaction:
            urlstr =  APIParameters.AllContentbaseURL  + path
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
        
       
    }
    }
}
