//
//  CartModel.swift
//  NON
//  Created by Evghenia Nedbailova on 21/07/2024.

//  CartPropertyWrapper here


import SwiftUI
import Combine

class CartModel: ObservableObject {
    @Published var totalWithoutDiscount = 0.0
    @Published var finalTotal = 0.0
    @Published var promoCode: String = ""
    @Published var discount: Double = 0.0
    let deliveryFee: Double = 20.0
    let taxRate: Double = 5.0

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartDidUpdate), name: .cartDidUpdate, object: nil)
        calculateTotalNoDiscount()
        calculateFinalTotal()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .cartDidUpdate, object: nil)
    }
    
    @objc private func cartDidUpdate() {
        calculateTotalNoDiscount()
        calculateFinalTotal()
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
        totalWithoutDiscount = total
    }
    
    func calculateFinalTotal() {
        let subtotal = Double(totalWithoutDiscount)
        let discountAmount = subtotal * discount / 100
        let delivery = hasDeliveryItems ? deliveryFee : 0
        let tax = (subtotal - discountAmount) * taxRate / 100
        let total = subtotal - discountAmount + delivery + tax
        finalTotal = total
    }

    var hasDeliveryItems: Bool {
        !Cart.shared.chosenGiftVoucher.isEmpty || !Cart.shared.chosenShopProducts.isEmpty
    }

    var taxAmount: Double {
        (Double(totalWithoutDiscount) - Double(totalWithoutDiscount) * discount / 100) * taxRate / 100
    }

    func applyPromoCode() {
        if promoCode == "DISCOUNT10" {
            discount = 10.0
        } else {
            discount = 0.0
        }
        calculateFinalTotal()
    }
    
    func checkout() {
        print("Checkout with total: \(finalTotal) AED")
    }
}
