//
//  OrderRequest.swift
//  Farm29
//
//  Created by FLYPIGEON on 18/05/22.
//

import Foundation
import Alamofire
enum OrderRequest: URLRequestConvertible {
    
    case placeOrder(custemerID:String,isNewAddr:Bool,addressID:String,address:[String:Any],OrderItems:[[String:Any]],couponCode:String,OrderedBill:Float,deliveryCharges:Float,CoupontDiscount:Float,TaxCharges:Float,Promotional:Float,GrandTotal:Float,PaymentType:String,PaymentID:String,walletbalance:Float,UsingWallet:Bool,isSubscribed:String,total_saved:Int,add_to_wallet:Bool,TotalWallet:Int)
    case OrderDetails
    case OrderDetailswithPage(pagenum:Int)
    case RecentlyOrderDetails
    case OrderDetailsData(OrderID:String)
    case CancelOrder(OrderID:String,reson:String)
    case applyCoupon(custemerID:String,OrderItems:[[String:Any]],couponCode:String,OrderedBill:Float,GrandTotal:Float)
    case TransactioStatusAPI(order_id:String,checkSum:String,channelId:String)
   case CalculateDistance(delivery_address_id:String,OrderItems:[[String:Any]])
    case CalculateAddressDistance(lattitude:Float,longitude:Float)
    case AddToWallet(paymentID:String,amount:Int)
    case TaxableInvoice(OrderID:String)
    case OrderInvoice(OrderID:String)
    private var method: HTTPMethod {
        switch self {
      
        case .placeOrder,.applyCoupon, .TransactioStatusAPI,.CalculateDistance,.AddToWallet,.CalculateAddressDistance ,.TaxableInvoice,.OrderInvoice :
            return .post
        case .OrderDetails,.RecentlyOrderDetails,.OrderDetailswithPage:
            return .get
        case .OrderDetailsData :
            return .get
        case .CancelOrder :
            return .patch
        }
    }
    private var headers: HTTPHeaders? {
    switch self {
    case .placeOrder,.OrderDetails,.OrderDetailsData,.applyCoupon,.RecentlyOrderDetails,.CancelOrder,.CalculateDistance,.AddToWallet,.OrderDetailswithPage,.CalculateAddressDistance,.TaxableInvoice,.OrderInvoice :
            return ["Authorization" : "Bearer \(AppStorage.userToken ?? "")"]
    case .TransactioStatusAPI :
        return nil
    }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .placeOrder:
            return "order/OrderAPI/"
        case .CalculateDistance:
            return "f29/CalculateDistanceAPI/"
        case .CalculateAddressDistance:
            return "f29/AddressCalculateDistanceAPI/"
        case .AddToWallet:
            return "f29/AddWalletMoneyAPI/"
        case .OrderDetails:
            return "order/UserOrdersListAPI/"
        case .OrderDetailsData(let orderID) :
            return "order/OrderDetailAPI/\(orderID)/"
        case .applyCoupon :
            return "order/ApplyCoupon/"
        case .RecentlyOrderDetails :
            return "order/UserOrdersListAPIV1/"
        case .CancelOrder(let orderID,_) :
            return "order/OrderCancelAPI/\(orderID)/"
        case .TransactioStatusAPI :
            return "payment/PaytmTransactionStatusAPI/"
        case .OrderDetailswithPage(let page):
            return "order/UserOrdersListAPI/?page=\(page)"
        case .OrderInvoice :
            return "order/OrderStatementInvoiceGeneratorPDFAPI/"
        case .TaxableInvoice :
            return "order/TaxableInvoiceGeneratorPDFAPI/"
        }
    }
    private var parameters: Parameters? {
        switch self {
        case .placeOrder(let userName,let isNewAddr,let addressID, let address,let OrderItems, let couponCode, let OrderedBill, let deliveryCharges,let CoupontDiscount,let TaxCharges, let Promotional, let GrandTotal, let PaymentType,let PaymentID,let walleteBalance, let UsingWallet,let isSubscribed,let total_saved,let add_to_wallet,let TotalWallet ):
            return [ "customer_id": userName, "is_new_address" : isNewAddr, "delivery_address_id": addressID, "delivery_address" : address,"order_items": OrderItems, "coupon_code" : couponCode, "ordered_bill": OrderedBill, "delivery_charges" : deliveryCharges,"coupon_discount" : CoupontDiscount,"taxes_charges" : TaxCharges, "promotional": Promotional, "grand_total" : GrandTotal,"payment_type":PaymentType,"payment_order_id":PaymentID,"booking_device":"IOS","used_wallet_balance":walleteBalance,"using_wallet_balance":UsingWallet,"is_subscribed_order":isSubscribed,"total_you_saved": total_saved,"add_to_wallet" : add_to_wallet,"wallet_amount" : TotalWallet]
        case .OrderDetails,.RecentlyOrderDetails,.OrderDetailswithPage:
            return nil
        case .OrderDetailsData:
            return nil
        case .applyCoupon(let userName,let OrderItems, let couponCode, let OrderedBill,let GrandTotal):
            return [ "customer_id": userName,"order_items": OrderItems, "coupon_code" : couponCode, "ordered_bill": OrderedBill,"grand_total":GrandTotal]
        case .CancelOrder(_,let reson):
            return [ "order_canceled": "True","order_canceled_reason" : reson]
        case .TransactioStatusAPI(let orderID,let checkSum, let channel):
            return [ "order_id": orderID,"payment_checkSumHash": checkSum, "channelId" : channel]
        case .CalculateDistance(let addresID, let OrderItems) :
            return [ "delivery_address_id": addresID,"order_items": OrderItems ]
        case .CalculateAddressDistance(let lat, let longi) :
            return [ "latitude": lat,"longitude": longi ]
        case .AddToWallet(let paymentID, let amount) :
            return [ "payment_transaction_id": paymentID,"wallet_balance": amount]
        case .TaxableInvoice(let orderid):
            return [ "order_id": orderid]
        case .OrderInvoice(let orderid):
            return [ "order_id": orderid]
        }
    }
    func asURLRequest() throws -> URLRequest {
        var urlstr = ""
        switch self {
       
        
        case .placeOrder,.applyCoupon,.CalculateDistance,.AddToWallet,.CalculateAddressDistance,.TaxableInvoice,.OrderInvoice:
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
            //print (parameters)
            if let headers = headers {
                urlRequest.headers = headers
            }
            
            return urlRequest
        case .TransactioStatusAPI:
            let url = try APIParameters.AllContentbaseURL.asURL()
            var TransurlRequest = URLRequest(url: url.appendingPathComponent(path))
            
            // HTTP Method
            TransurlRequest.httpMethod = method.rawValue
            // Common Headers
            TransurlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            TransurlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
            // Parameters
            if let parameters = parameters {
                do {
                    TransurlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
           
            
            return TransurlRequest
        case .OrderDetails,.OrderDetailsData,.RecentlyOrderDetails,.OrderDetailswithPage:
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
    
    case .CancelOrder :
        let url = try APIParameters.AllContentbaseURL.asURL()
        var urlRequest1 = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
            urlRequest1.httpMethod = method.rawValue
        // Common Headers
            urlRequest1.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
            urlRequest1.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest1.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        if let headers = headers {
            urlRequest1.headers = headers
        }
        
        return urlRequest1
        
    }
}
}
