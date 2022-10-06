//
//  LoginView.swift
//  CollegeStars
//
//  Created by Mac on 17/11/20.
//

import Foundation
import Alamofire

class LoginView {
    @discardableResult
    private static func performRequest<T:Decodable>(route:LoginRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                               switch response.result {
                                   case .failure(let error):
                                       //print(error)
                                   completion(response.result)
                                   case .success :
                                   completion(response.result)
               }
           }
       }
    static func login(mobile: String,  completion:@escaping (Result<LoginModel, AFError>)->Void) {

        performRequest(route:LoginRequest.login(mobile:mobile), completion: completion)
       }
    static func VerifyOTP(mobile: String,sessionID:String,Otp:String,  completion:@escaping (Result<VerifyModel, AFError>)->Void) {

        performRequest(route:LoginRequest.verifyOtp( sessionID: sessionID, Otp: Otp,mobile: mobile), completion: completion)
       }
    static func refreshToken(token:String, completion:@escaping (Result<refreshModel, AFError>)->Void) {

        performRequest(route:LoginRequest.refreshToken(refresh: token), completion: completion)
       }
    static func referalDeatils(userID:String,name: String,email:String,referal:String,  completion:@escaping (Result<ReferalModel, AFError>)->Void) {

        performRequest(route:LoginRequest.referalDeatils(userID:userID,name: name, email: email, referal: referal), completion: completion)
       }
}
