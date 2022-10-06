//
//  AddCartRequest.swift
//  Farm29
//
//  Created by FLYPIGEON on 11/05/22.
//

import Foundation
import Alamofire
enum AddCartRequest: URLRequestConvertible {
    
    case getCartDetails
    case AddCartItems(itemID:Any ,quantity:Int,familyPackID:Any,chosen_oil_pack:Any)
    case DeleteCart
    case UpdateCartItem(itemID:Any,quantity:Int,familyPackID:Any,chosen_oil_pack:Any)
    case DeleteCartItem(itemID:Any,monthlyPackID:Any,chosen_oil_pack:Any)
    case DeleteCartMutliItems(cartItems:[[String:Any]])
    case getCartItemDetails
    private var method: HTTPMethod {
        switch self {
        case .getCartDetails,.getCartItemDetails :
            return .get
        case .AddCartItems :
            return .post
        case .UpdateCartItem :
            return .patch
        case .DeleteCart, .DeleteCartItem,.DeleteCartMutliItems :
            return .delete
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getCartDetails:
            return "order/CartAPIView/"
        case .getCartItemDetails:
            return "order/CartDetail/"
        case .AddCartItems:
            return "order/CartAPIView/"
        case .UpdateCartItem :
            return "order/CartDetailV1/"
        case .DeleteCart:
            return "order/CartAPIView/"
        case .DeleteCartItem :
            return "order/CartDetailV1/"
        case .DeleteCartMutliItems :
            return "order/MultipuleCartAPIView/"
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .AddCartItems(let itemID,let quantity,let familyPackID,let choosenOilPack):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["item": itemID,"quantity":quantity,"family_pack_id":familyPackID,"chosen_oil_pack":choosenOilPack]
        case .UpdateCartItem(let id,let quantity,let familyPackID, let oilPackID):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["item": id,"quantity":Int(quantity) ,"family_pack_id": familyPackID, "chosen_oil_pack" : oilPackID]
        case .DeleteCartItem(let id,let familyPackID,let oilPackID):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["item": id,"family_pack_id": familyPackID, "chosen_oil_pack" : oilPackID]
        case .getCartDetails, .getCartItemDetails,.DeleteCart :
            return nil
        case .DeleteCartMutliItems(let cartItems):
            //   return [ "username": "ASW.ST24", "password" : "ST20#127" ]
            return ["cart_items": cartItems]
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .getCartDetails, .getCartItemDetails,.AddCartItems,.UpdateCartItem,.DeleteCart,.DeleteCartItem,.DeleteCartMutliItems :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
    }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getCartDetails,.getCartItemDetails :
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
        
        case .UpdateCartItem :
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
            if let parameters = parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
            return urlRequest
        case .DeleteCart,.DeleteCartItem, .DeleteCartMutliItems :
        urlstr =  APIParameters.AllContentbaseURL + path
    let url = try urlstr.asURL()
   // let url = URL(string: "\(AppData.baseUrlWithJsonApi)/my_content?is_blocked_in_mlibro=true")!
    
    var deleteRequest = URLRequest(url: url)

    // HTTP Method
            deleteRequest.httpMethod = method.rawValue
            deleteRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            deleteRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            if let headers = headers {
                deleteRequest.headers = headers
            }
            if let parameters = parameters {
                do {
                    deleteRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
    return deleteRequest
        case .AddCartItems:
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
    }
    }
}
