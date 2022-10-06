//
//  ProfileViewModel.swift
//  Farm29
//
//  Created by FLYPIGEON on 17/05/22.
//

import Foundation
import Alamofire

class ProfileViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:ProfileRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                   completion(response.result)
              
                                   }
       }
    static func getProfileDetails( completion:@escaping (Result<ProfileModel, AFError>)->Void) {

        performRequest(route:ProfileRequest.getProfileDetails, completion: completion)
       }
   
    static func UpdateProfileDetailss(name:String,email:String,dob:String,userID:String, completion:@escaping (Result<UpdateProfileModel, AFError>)->Void) {

        performRequest(route:ProfileRequest.UpdateProfileDetails(email: email, name: name, date_of_birth: dob, userID: userID), completion: completion)
       }
    static func logout( completion:@escaping (Result<Empty, AFError>)->Void) {

        performRequest(route:ProfileRequest.deleteUser, completion: completion)
       }
    static func deleteAcount( completion:@escaping (Result<DeleteAccountModel, AFError>)->Void) {

        performRequest(route:ProfileRequest.deleteAccount, completion: completion)
       }
    static func getNotifications( completion:@escaping (Result<NotificationModel, AFError>)->Void) {

        performRequest(route:ProfileRequest.getNotifications, completion: completion)
       }
}

