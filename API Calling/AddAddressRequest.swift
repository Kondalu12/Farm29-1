//
//  AddAddressRequest.swift
//  Farm29
//
//  Created by FLYPIGEON on 16/05/22.
//

import Foundation
import Alamofire
enum AddAddressRequest: URLRequestConvertible {
    
    case AddAddress(UserName:String,HouseNo:String,apartmentNo:String,landmark:String,area:String,Steet:String,city:String,State:String,addrNickName:String,picode:String,lat:Double,lang:Double,phoneNum:String,address:String)
   case getAddressDetails
    case getLocation(lat:String,lang:String)
    case UpdateAddress(UserName:String,HouseNo:String,apartmentNo:String,landmark:String,area:String,Steet:String,city:String,State:String,addrNickName:String,picode:String,lat:Double,lang:Double,phoneNum:String,address:String,addressID:String)
    case deleteAddressDetails(addrID:String)
    private var method: HTTPMethod {
        switch self {
        case .getAddressDetails  :
            return .get
        case .AddAddress,.getLocation :
            return .post
        case .UpdateAddress :
            return .put
        case .deleteAddressDetails :
            return .delete
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .AddAddress,.getAddressDetails,.UpdateAddress,.deleteAddressDetails :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
    case .getLocation :
        return nil
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getAddressDetails:
            return "order/CustomerAddressAPI/"
        case .UpdateAddress(_,_,_,_,_,_,_,_,_,_,_,_,_,_,let addressID):
            return "order/CustomerAddressDetailAPI/\(addressID)/"
        case .deleteAddressDetails(let addressID):
            return "order/CustomerAddressDetailAPI/\(addressID)/"
        case .AddAddress:
            return "order/CustomerAddressAPI/"
        case .getLocation:
            return "items/IPAddresstoCity/"
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .AddAddress(let userName,let houseNo,let apartnum, let landmark,let area, let street, let city, let state,let addrName,let pincode, let lat, let lang, let phoneNum,let address):
            return [ "customer_name": userName, "house_no" : houseNo, "apartment_name": apartnum, "landmark" : landmark,"area_details": area, "street_details" : street, "city": city, "state" : state,"address_nickname" : addrName,"pincode" : pincode, "latitude": lat, "longitude" : lang,"phone_number":phoneNum,"address":address]
        case .UpdateAddress(let userName,let houseNo,let apartnum, let landmark,let area, let street, let city, let state,let addrName,let pincode, let lat, let lang, let phoneNum,let address,_):
            return [ "customer_name": userName, "house_no" : houseNo, "apartment_name": apartnum, "landmark" : landmark,"area_details": area, "street_details" : street, "city": city, "state" : state,"address_nickname" : addrName,"pincode" : pincode, "latitude": lat, "longitude" : lang,"phone_number":phoneNum,"address":address]
        case .getAddressDetails,.deleteAddressDetails:
            return nil
        case .getLocation(let lat,let lang) :
            return [ "Latitude": lat, "Longitude" : lang]
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getAddressDetails :
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
        
        case .AddAddress,.UpdateAddress,.getLocation :
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
        case .deleteAddressDetails :
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
    return deleteRequest
    }
    }
}
