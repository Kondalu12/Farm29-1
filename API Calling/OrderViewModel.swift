//
//  OrderViewModel.swift
//  Farm29
//
//  Created by FLYPIGEON on 18/05/22.
//

import Foundation
import Alamofire

class OrderViewModel {
    @discardableResult
    private static func performRequest<T:Decodable>(route:OrderRequest, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
           return AF.request(route)
                           .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in

                                   completion(response.result)
              
                                   }
       }
    static func PlaceOrder(custemerID:String,isNewAddr:Bool,addressID:String,address:[String:Any],OrderItems:[[String:Any]],couponCode:String,OrderedBill:Float,deliveryCharges:Float,CoupontDiscount:Float,TaxCharges:Float,Promotional:Float,GrandTotal:Float,PaymentType:String,PaymentID:String,walletbalance:Float,UsingWallet:Bool,isSubscribed:String,totalSaved:Int,add_to_wallet:Bool,TotalWallet:Int, completion:@escaping (Result<PlaceOrderModel, AFError>)->Void) {

        performRequest(route:OrderRequest.placeOrder(custemerID: custemerID, isNewAddr: isNewAddr, addressID: addressID, address: address, OrderItems: OrderItems, couponCode: couponCode, OrderedBill: OrderedBill, deliveryCharges: deliveryCharges, CoupontDiscount: CoupontDiscount, TaxCharges: TaxCharges, Promotional: Promotional, GrandTotal: GrandTotal, PaymentType: PaymentType, PaymentID: PaymentID,walletbalance:walletbalance,UsingWallet: UsingWallet,isSubscribed:isSubscribed,total_saved: totalSaved,add_to_wallet:add_to_wallet, TotalWallet: TotalWallet), completion: completion)
       }
   
    static func getOrderDetails( completion:@escaping (Result<OderaDetailsModel, AFError>)->Void) {

        performRequest(route:OrderRequest.OrderDetails, completion: completion)
       }
    static func getOrderDetailswithPage(pageNum:Int, completion:@escaping (Result<OderaDetailsModel, AFError>)->Void) {

        performRequest(route:OrderRequest.OrderDetailswithPage(pagenum: pageNum), completion: completion)
       }
    static func getOrderDetailsData(orderID:String, completion:@escaping (Result<OrderDetailsDataModel, AFError>)->Void) {

        performRequest(route:OrderRequest.OrderDetailsData(OrderID: orderID), completion: completion)
       }
    static func ApplyCoupon(custemerID:String,OrderItems:[[String:Any]],couponCode:String,OrderedBill:Float,grandTotal:Float, completion:@escaping (Result<applyCouponModel, AFError>)->Void) {

        performRequest(route:OrderRequest.applyCoupon(custemerID: custemerID, OrderItems: OrderItems, couponCode: couponCode, OrderedBill: OrderedBill, GrandTotal: grandTotal), completion: completion)
       }
    static func getrecentlyOrderDetails( completion:@escaping (Result<RecentlyOrdersModel, AFError>)->Void) {

        performRequest(route:OrderRequest.RecentlyOrderDetails, completion: completion)
       }
    static func cancelOrder(orderID:String,reason:String, completion:@escaping (Result<cancelOrderModel, AFError>)->Void) {

        performRequest(route:OrderRequest.CancelOrder(OrderID: orderID,reson: reason), completion: completion)
       }
    static func TransActionStatus(orderID:String,checksum:String,channelID:String, completion:@escaping (Result<TransactionStatusModel, AFError>)->Void) {

        performRequest(route:OrderRequest.TransactioStatusAPI(order_id: orderID, checkSum: checksum, channelId: channelID), completion: completion)
       }
    static func CaluculateDeliveryDistance(addressID:String,OrderItems:[[String:Any]], completion:@escaping (Result<DistanceCalculateModel, AFError>)->Void) {

        performRequest(route:OrderRequest.CalculateDistance(delivery_address_id: addressID, OrderItems: OrderItems), completion: completion)
       }
    static func CaluculateAddressDistance(lattitude:Float,longitude:Float, completion:@escaping (Result<addressDistanceCalculationModel, AFError>)->Void) {

        performRequest(route:OrderRequest.CalculateAddressDistance(lattitude: lattitude, longitude: longitude), completion: completion)
       }
    static func AddtoWallet(paymentID:String,amount:Int, completion:@escaping (Result<ADDBalanceResults, AFError>)->Void) {

        performRequest(route:OrderRequest.AddToWallet(paymentID: paymentID, amount: amount), completion: completion)
       }
    static func getTaxableInvoice(OrderID:String, completion:@escaping (Result<Empty, AFError>)->Void) {

        performRequest(route:OrderRequest.TaxableInvoice(OrderID: OrderID), completion: completion)
       }
    static func getOrderInvoice(OrderID:String, completion:@escaping (Result<Empty, AFError>)->Void) {

        performRequest(route:OrderRequest.OrderInvoice(OrderID: OrderID), completion: completion)
       }
}

