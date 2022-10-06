//
//  AddCartViewModel.swift
//  Farm29
//
//  Created by FLYPIGEON on 11/05/22.
//

import Foundation
import Alamofire

class AddCartViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:AddCartRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                   completion(response.result)
              
                                   }
       }
    static func AddCartItem(itemID:Any,quatity:Int,familyPackID:Any, choosenOilPack:Any, completion:@escaping (Result<AddCartModel, AFError>)->Void) {

        performRequest(route:AddCartRequest.AddCartItems(itemID: itemID, quantity: quatity,familyPackID:familyPackID, chosen_oil_pack: choosenOilPack), completion: completion)
       }
    static func getCart( completion:@escaping (Result<CartModel, AFError>)->Void) {

        performRequest(route:AddCartRequest.getCartDetails, completion: completion)
       }
    static func updateCart(itemID:Any,quatity:Int,familyPackID:Any,oilPackID:Any, completion:@escaping (Result<AddCartModel, AFError>)->Void) {

        performRequest(route:AddCartRequest.UpdateCartItem(itemID: itemID, quantity: quatity, familyPackID: familyPackID, chosen_oil_pack: oilPackID), completion: completion)
       }
    static func deleteCartItem(itemID:Any,monthlyPackID:Any,oilPackID:Any, completion:@escaping (Result<Empty , AFError>)->Void) {

        performRequest(route:AddCartRequest.DeleteCartItem(itemID: itemID,monthlyPackID:monthlyPackID, chosen_oil_pack: oilPackID), completion: completion)
       }
    static func deleteCart( completion:@escaping (Result<Empty, AFError>)->Void) {

        performRequest(route:AddCartRequest.DeleteCart, completion: completion)
       }
    
    static func DeleteCartMutliItems(cart_items:[[String:Any]], completion:@escaping (Result<Empty , AFError>)->Void) {

        performRequest(route:AddCartRequest.DeleteCartMutliItems(cartItems:cart_items), completion: completion)
       }
}
