//
//  WalletViewModel.swift
//  Farm29
//
//  Created by FLYPIGEON on 04/07/22.
//

import Foundation
import Alamofire

class WalletViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:WalletRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                   completion(response.result)
              
                                   }
       }
    static func getWalletBalance( completion:@escaping (Result<WalletbalanceModel, AFError>)->Void) {

        performRequest(route:WalletRequest.getWalletBalance, completion: completion)
       }
    static func getWalletTransaction( completion:@escaping (Result<TransactionModel, AFError>)->Void) {

        performRequest(route:WalletRequest.getWalletTransaction, completion: completion)
       }
   
 
}

