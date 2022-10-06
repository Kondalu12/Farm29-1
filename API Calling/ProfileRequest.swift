//
//  ProfileRequest.swift
//  Farm29
//
//  Created by FLYPIGEON on 17/05/22.
//

import Foundation
import Alamofire
enum ProfileRequest: URLRequestConvertible {
    
    case UpdateProfileDetails(email:String,name:String,date_of_birth:String,userID:String)
   case getProfileDetails
    case deleteUser
    case deleteAccount
    case getNotifications
    private var method: HTTPMethod {
        switch self {
        case .getProfileDetails, .getNotifications  :
            return .get
        case .UpdateProfileDetails :
            return .put
        case .deleteUser :
            return .post
        case .deleteAccount :
            return .delete
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .getProfileDetails,.UpdateProfileDetails,.deleteUser,.getNotifications,.deleteAccount:
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
//    case .deleteUser :
//        return nil
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getProfileDetails:
            return "users/customer_profile/"
        case .UpdateProfileDetails(_,_,_,let userID):
            return "users/customer_update/\(userID)/"
        
        case .deleteUser:
            return "logout/"
        case .deleteAccount:
            return "users/UserAccountDeleteAPI/"
        case .getNotifications:
            return "users/NotificationMessageAPI/"
        }
    }
    private var parameters: Parameters? {
        switch self {
       
        case .UpdateProfileDetails(let email,let name,let dob,_):
            return [ "email": email, "name" : name, "date_of_birth": dob]
        case .getProfileDetails,.getNotifications,.deleteAccount:
            return nil
        case .deleteUser:
            return ["refresh_token":"\(AppStorage.refreshToken!)"]
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getProfileDetails,.getNotifications,.deleteAccount :
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
        
        case .deleteUser :
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
        case .UpdateProfileDetails:
            let url = try APIParameters.AllContentbaseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            urlRequest.httpMethod = method.rawValue
            // Common Headers
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue("a/form-data", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
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
            
    }
    }
}
