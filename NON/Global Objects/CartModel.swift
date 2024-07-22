//
//  CartModel.swift
//  NON
//  Created by Evghenia Nedbailova on 21/07/2024.

//  CartPropertyWrapper here
//


import UIKit
import SwiftUI
import Combine

class CartModel: ObservableObject {
    @Published var totalNoDiscount = CartPropertyWrapper(value: 0)
    @Published var finalTotal = CartPropertyWrapper(value: 0)
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartDidUpdate), name: .cartDidUpdate, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cartDidUpdate, object: nil)
    }
    
    @objc private func cartDidUpdate() {
        calculateTotalNoDiscount()
    }
    
    func calculateTotalNoDiscount() {
        let totalServices = Cart.shared.chosenSalonServices.flatMap { $0.value }.reduce(0.0) { total, service in
            if let price = Double(service.price.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        }
        
        let totalVouchers = Cart.shared.chosenGiftVoucher.reduce(0.0) { $0 + Double($1) }
        
        let totalProducts = Cart.shared.chosenShopProducts.reduce(0.0) { (total, priceString) -> Double in
            if let price = Double(priceString.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        }
        
        let total = totalServices + totalVouchers + totalProducts
        totalNoDiscount.value = Int(total)
    }
}

class CartPropertyWrapper: ObservableObject {
    @Published var value: Int
    init(value: Int) {
        self.value = value
    }
}
