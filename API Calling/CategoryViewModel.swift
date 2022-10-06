//
//  CategoryViewModel.swift
//  Farm29
//
//  Created by eAlphaMac2 on 06/05/22.
//

import Foundation
import Alamofire

class CategoryViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:CategoryAPIRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
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
    static func getCategories( completion:@escaping (Result<CategoryModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getCategory, completion: completion)
       }
    static func getBanners( completion:@escaping (Result<BannerModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getbanners, completion: completion)
       }
    static func getSubctegories(categoryID:String, completion:@escaping (Result<SubcategoryModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getSubCategories(categoryID: categoryID), completion: completion)
       }
    static func getItems(categoryID:String,subCategoryId:String,name:String,pageNum:String, completion:@escaping (Result<ItemModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getItems(categoryID: categoryID, subCategoryId: subCategoryId, name: name, pageNum: pageNum), completion: completion)
       }
    static func getTopRatedItems( completion:@escaping (Result<TopRatedItemsModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getTopRatedItems, completion: completion)
       }
    static func getItemsDetails(itemID:Int, completion:@escaping (Result<ItemDetailsModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getItemsDetails(ItemID: itemID), completion: completion)
       }
    static func getItemswithoutPage(categoryID:String,subCategoryId:String,name:String, completion:@escaping (Result<ItemModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getItemswithOutPage(categoryID: categoryID, subCategoryId: subCategoryId, name: name), completion: completion)
       }
    static func getItemswithoutPageByUser(categoryID:String,subCategoryId:String,name:String, completion:@escaping (Result<ItemModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getItemswithoutPageByUser(categoryID: categoryID, subCategoryId: subCategoryId, name: name), completion: completion)
       }
    static func getrecentSearch( completion:@escaping (Result<RecentSearchModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getrecentSeacheByUser, completion: completion)
       }
    static func getItemsOffers(min_percentage:String,flat_percentage:String,upto_percentage:String,most_forgotten_item:String, completion:@escaping (Result<ItemModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getItemsOfferPage(min_percentage: min_percentage, flat_percentage: flat_percentage, upto_percentage: upto_percentage, most_forgotten_item: most_forgotten_item), completion: completion)
       }
    static func getMonthlyPackData( completion:@escaping (Result<MonthlyPackModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getMonthlyPackdata, completion: completion)
       }
    static func getMonthlyPackWithUserData( completion:@escaping (Result<MonthlyPackModel, AFError>)->Void) {

        performRequest(route:CategoryAPIRequest.getMonthlyPackdataWithUser, completion: completion)
       }
}
