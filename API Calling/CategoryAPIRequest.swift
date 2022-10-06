//
//  CategoryAPIRequest.swift
//  Farm29
//
//  Created by eAlphaMac2 on 06/05/22.
//

import Foundation
import Alamofire
enum CategoryAPIRequest: URLRequestConvertible {
    
    case getCategory
    case getMonthlyPackdata
    case getMonthlyPackdataWithUser
    case getbanners
    case getSubCategories(categoryID:String)
    case getItems(categoryID:String,subCategoryId:String,name:String,pageNum:String)
    case getItemswithOutPage(categoryID:String,subCategoryId:String,name:String)
    case getItemsOfferPage(min_percentage:String,flat_percentage:String,upto_percentage:String,most_forgotten_item:String)
    case getTopRatedItems
    case getItemsDetails(ItemID:Int)
    case getrecentSeacheByUser
    case getItemswithoutPageByUser(categoryID:String,subCategoryId:String,name:String)
    private var method: HTTPMethod {
        switch self {
        case .getCategory,.getMonthlyPackdata,.getbanners,.getSubCategories,.getItems,.getTopRatedItems,.getItemsDetails,.getItemswithOutPage,.getrecentSeacheByUser,.getItemswithoutPageByUser,.getItemsOfferPage,.getMonthlyPackdataWithUser :
            return .get
            
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .getrecentSeacheByUser,.getItems,.getItemswithoutPageByUser,.getMonthlyPackdataWithUser :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
    case .getCategory,.getbanners,.getSubCategories,.getTopRatedItems,.getItemsDetails,.getItemswithOutPage,.getItemsOfferPage,.getMonthlyPackdata:
        return nil
    
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .getCategory:
            return "items/CategoryAPI/"
        case .getMonthlyPackdata:
            return "items/MonthlyItemsPackAPI/"
        case .getMonthlyPackdataWithUser:
            return "items/MonthlyItemsPackAPIV1/"
        case .getbanners:
            return "items/CarouselListAPIV1/"
        case .getSubCategories(let categoryID):
            return "items/SubCategoryAPIV1/?category_id=\(categoryID)"
        case .getItems(let categoryID, let subCatID, let name,let pageNUm):
            return "items/ItemAPIV1/?category=\(categoryID)&subcategory=\(subCatID)&name=\(name)&page=\(pageNUm)"
        case .getTopRatedItems:
            return "items/MostOrderedItemsAPI/"
        case .getItemsDetails(let itemID):
            return "items/ItemDetailAPI/\(itemID)/"
        case .getItemswithOutPage(let categoryID, let subCatID, let name):
            return "items/ItemAPIV1/?category=\(categoryID)&subcategory=\(subCatID)&name=\(name)"
        case .getrecentSeacheByUser:
            return "items/UserRecentSearchesAPI/"
        case .getItemswithoutPageByUser(let categoryID, let subCatID, let name):
            return "items/ItemAPIV2/?name=\(name)"
        case .getItemsOfferPage(let min_percentage, let flat_percentage, let upto_percentage,let most_forgotten_item):
            return "items/ItemAPIV1/?min_percentage=\(min_percentage)&flat_percentage=\(flat_percentage)&upto_percentage=\(upto_percentage)&most_forgotten_item=\(most_forgotten_item)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
        case .getCategory,.getMonthlyPackdata,.getbanners,.getSubCategories,.getTopRatedItems,.getItemsDetails,.getItemsOfferPage :
        urlstr =  APIParameters.AllContentbaseURL + path
    let url = try urlstr.asURL()
   // let url = URL(string: "\(AppData.baseUrlWithJsonApi)/my_content?is_blocked_in_mlibro=true")!
    
    var Request = URLRequest(url: url)

    // HTTP Method
        Request.httpMethod = method.rawValue
        Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        Request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

    return Request
        case .getItems,.getItemswithOutPage :
        urlstr =  APIParameters.AllContentbaseURL + path
    let url = try urlstr.asURL()
   // let url = URL(string: "\(AppData.baseUrlWithJsonApi)/my_content?is_blocked_in_mlibro=true")!

    var urlRequest = URLRequest(url: url)

    // HTTP Method
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//            if let headers = headers {
//                urlRequest.headers = headers
//            }

    return urlRequest
        case .getrecentSeacheByUser:
            let url = try APIParameters.AllContentbaseURL.asURL()
            var searchurlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            searchurlRequest.httpMethod = method.rawValue
            // Common Headers
            searchurlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            searchurlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
        
            if let headers = headers {
                searchurlRequest.headers = headers
            }
            
            return searchurlRequest
        case .getItemswithoutPageByUser,.getMonthlyPackdataWithUser :
            urlstr =  APIParameters.AllContentbaseURL + path
           let url = try urlstr.asURL()
            var itemsRequest = URLRequest(url: url)
            // HTTP Method
            itemsRequest.httpMethod = method.rawValue
            // Common Headers
            itemsRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            itemsRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
        
            if let headers = headers {
                itemsRequest.headers = headers
            }
            
            return itemsRequest
    }
    }
}
