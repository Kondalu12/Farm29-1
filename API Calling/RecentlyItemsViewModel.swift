//
//  RecentlyItemsViewModel.swift
//  Farm29
//
//  Created by eAlphaMac2 on 06/05/22.
//

import Foundation
import Alamofire

class RecentlyItemsViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:RecentlyItemsRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                   completion(response.result)
              
                                   }
       }
    static func getRecentlyItems( completion:@escaping (Result<ViewedItemModel, AFError>)->Void) {

        performRequest(route:RecentlyItemsRequest.getRecentlyItems, completion: completion)
       }
    static func getOffers( completion:@escaping (Result<OffersModel, AFError>)->Void) {

        performRequest(route:RecentlyItemsRequest.getOffers, completion: completion)
       }
    static func viewedItems(itemID:Int, completion:@escaping (Result<AddRecentModel, AFError>)->Void) {

        performRequest(route:RecentlyItemsRequest.viewedItems(itemID: itemID), completion: completion)
       }
    static func getPushNotifivations(fcmtoken:String,deviceID:String,type:String, completion:@escaping (Result<pushNotifModel, AFError>)->Void) {

        performRequest(route:RecentlyItemsRequest.getPushNotification(fcmtoken: fcmtoken, deviceID: deviceID, type: type), completion: completion)
       }
}
