//
//  CartViewModel.swift
//  NON
//
//  Created by Evghenia Nedbailova on 15/07/2024.
//


import Combine
import UIKit

class CartViewModel: ObservableObject {
    @Published var promoCode: String = ""
    @Published var discount: Double = 0.0
    let deliveryFee: Double = 20.0
    let taxRate: Double = 5.0 // Пример налога в процентах

    var totalWithoutDiscount: Double {
        Cart.shared.chosenSalonServices.flatMap { $0.value }.reduce(0) { total, service in
            if let price = Double(service.price.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        }
    }

    var hasDeliveryItems: Bool {
        !Cart.shared.chosenGiftVoucher.isEmpty || !Cart.shared.chosenShopProducts.isEmpty
    }

    var taxAmount: Double {
        (totalWithoutDiscount - totalWithoutDiscount * discount / 100) * taxRate / 100
    }

    var finalTotal: Double {
        let subtotal = totalWithoutDiscount
        let discountAmount = subtotal * discount / 100
        let delivery = hasDeliveryItems ? deliveryFee : 0
        return subtotal - discountAmount + delivery + taxAmount
    }

    func applyPromoCode() {
        // Пример логики применения промокода
        if promoCode == "DISCOUNT10" {
            discount = 10.0
        } else {
            discount = 0.0
        }
    }
    
    func checkout() {
        print("Checkout with total: \(finalTotal) AED")
    }
}
