//
//  AddAddressViewModel.swift
//  Farm29
//
//  Created by FLYPIGEON on 16/05/22.
//

import Foundation
import Alamofire

class AddAddressViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:AddAddressRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                    completion(response.result)
              
                                   }
       }
    static func getAddressDetails( completion:@escaping (Result<AddAddressModel, AFError>)->Void) {

        performRequest(route:AddAddressRequest.getAddressDetails, completion: completion)
       }
    static func deleteAdddressDetail(addrID:String, completion:@escaping (Result<Empty, AFError>)->Void) {

        performRequest(route:AddAddressRequest.deleteAddressDetails(addrID: addrID), completion: completion)
       }
    static func AddAdddressDetails(UserName:String,HouseNo:String,apartmentNo:String,landmark:String,area:String,Steet:String,city:String,State:String,addrNickName:String,picode:String,lat:Double,lang:Double,phone:String,address:String, completion:@escaping (Result<AddedAddress, AFError>)->Void) {

        performRequest(route:AddAddressRequest.AddAddress(UserName: UserName, HouseNo: HouseNo, apartmentNo: apartmentNo, landmark: landmark, area: area, Steet: Steet, city: city, State: State, addrNickName: addrNickName, picode: picode, lat: lat, lang: lang,phoneNum: phone, address: address), completion: completion)
       }
    static func UpdateAddressDetails(UserName:String,HouseNo:String,apartmentNo:String,landmark:String,area:String,Steet:String,city:String,State:String,addrNickName:String,picode:String,lat:Double,lang:Double,phone:String,address:String,addressID:String, completion:@escaping (Result<AddedAddress, AFError>)->Void) {

        performRequest(route:AddAddressRequest.UpdateAddress(UserName: UserName, HouseNo: HouseNo, apartmentNo: apartmentNo, landmark: landmark, area: area, Steet: Steet, city: city, State: State, addrNickName: addrNickName, picode: picode, lat: lat, lang: lang,phoneNum: phone,address: address,addressID: addressID), completion: completion)
       }
    static func getlocation(lat:String,lang:String, completion:@escaping (Result<LocationModel, AFError>)->Void) {

        performRequest(route:AddAddressRequest.getLocation(lat: lat, lang: lang), completion: completion)
       }
}
