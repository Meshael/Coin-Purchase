//
//  IAPManager.swift
//  Coin Purchase
//
//  Created by Mashael Alharbi on 16/02/2023.
//

import Foundation
import StoreKit

final class IAPManager:NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver, ObservableObject {
    static let shared = IAPManager()
    
    var products = [SKProduct]()
    private var completion: ((Int) -> Void)?
    enum Product: String,CaseIterable {
        case Coins_20
        case Coins_40
        case Coins_60
        case Coins_80
        case Coins_100
        
        var count: Int {
            switch self{
                
            case .Coins_20:
                return 20
            case .Coins_40:
                return 40
            case .Coins_60:
                return 60
            case .Coins_80:
                return 80
            case .Coins_100:
                return 100
            }
        }
    }
    
    public func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: [])
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }
    
    public func purchase(product: Product, comoletion: @escaping ((Int) -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        self.completion = comoletion
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                if let product = Product(rawValue: $0.payment.productIdentifier){
                    completion?(product.count)
                }
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
    
}
