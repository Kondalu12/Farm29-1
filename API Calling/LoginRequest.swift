//
//  LoginRequest.swift
//  WOQOODY APP
//
//  Created by eAlphaMac2 on 28/09/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Alamofire

enum LoginRequest: URLRequestConvertible {
    struct LoginParameterKey {
        static let mobile = "phone_number"//"username"
       
    }
   
    case login(mobile:String)
    case verifyOtp(sessionID:String,Otp:String,mobile:String)
    case refreshToken(refresh:String)
    case referalDeatils(userID:String,name: String,email:String,referal:String)
    private var method: HTTPMethod {
        switch self {
        case .login,.verifyOtp  :
            return .post
        case .refreshToken :
            return .post
        case .referalDeatils :
            return .put
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "users/customer_sendotp/"
        case .verifyOtp:
            return "users/customer_verifyotp/"
        case .refreshToken:
                return "login/refresh/"
        case .referalDeatils(let userID,_,_,_):
                return "users/customer_update_referral/\(userID)/"
        
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .refreshToken(let Code):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["refresh": Code]
        case .login(let phone_num)  :
            return ["phone_number": phone_num]
        case .verifyOtp (let sessionID, let otp,let phone_num) :
            return [ "session_id": sessionID,"otp_input": otp,"phone_number": phone_num ]
        case .referalDeatils(_,let name,let email,let referal):
             return [ "name": name, "email" : email,"referral_code_used" : referal ]
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .refreshToken,.login,.verifyOtp :
        return nil
    case .referalDeatils:
        return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
       
    
    }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .login,.verifyOtp :
            let url = try APIParameters.AllContentbaseURL.asURL()
            var Request = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            Request.httpMethod = method.rawValue
            // Common Headers
            Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
            if let parameters = parameters {
                do {
                    Request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
    return Request
        
        case .refreshToken :
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
            
            
            return urlRequest
        case .referalDeatils :
            let url = try APIParameters.AllContentbaseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            urlRequest.httpMethod = method.rawValue
            // Common Headers
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue("multipart/form-data; boundary=<calculated when request is sent>", forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            if let headers = headers {
                urlRequest.headers = headers
            }
            // Parameters
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            
            
            return urlRequest
    }
    }
}
