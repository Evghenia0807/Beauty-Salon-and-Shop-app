//
//  CartModel.swift
//  NON
//  Created by Evghenia Nedbailova on 21/07/2024.

//  CartPropertyWrapper here


import SwiftUI
import Combine

struct ShopProduct: CartItem, Codable {
    let id: UUID
    let displayName: String
    let price: Int
    let imageName: String
    var amount: Int
    var delivery: Bool
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}

struct GiftVoucher: CartItem, Codable {
    var id: UUID = UUID()
    let delivery: Bool
    let price: Int
    var amount: Int {
        return 1
    }
    var displayName: String {
        return "Gift Voucher"
    }
    var imageName: String {
        return "Gift Voucher"
    }
    var image: UIImage? {
            return UIImage(named: imageName)
        }
}

class CartModel: ObservableObject {
    @Published var subtotal = 0
    @Published var finalTotal = 0.0
    @Published var giftVouchersTotal = 0
    @Published var giftVouchersCount = 0
    @Published var shopProductsTotal = 0
    @Published var shopProductsCount = 0
    @Published var promoCode: String = ""
    @Published var discount: Double = 0.0
    var deliveryFee: Double = 0
    let taxRate: Double = 5.0

    private var cancellables = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartDidUpdate), name: .cartDidUpdate, object: nil)
        calculateAllTotalsAndCounts()
        calculateFinalTotal()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .cartDidUpdate, object: nil)
    }

    @objc private func cartDidUpdate() {
        calculateAllTotalsAndCounts()
        calculateFinalTotal()
    }

    func calculateAllTotalsAndCounts() {
        let servicesTotal = Cart.shared.chosenSalonServices.flatMap { $0.value }.compactMap { $0.price }.reduce(0, +)
        let itemsTotal = Cart.shared.chosenItems.compactMap { $0.price }.reduce(0, +)
        subtotal = servicesTotal + itemsTotal

        let giftVoucherResult = calculateTotalsAndCount(for: GiftVoucher.self)
        giftVouchersTotal = giftVoucherResult.total
        giftVouchersCount = giftVoucherResult.count

        let shopProductResult = calculateTotalsAndCount(for: ShopProduct.self)
        shopProductsTotal = shopProductResult.total
        shopProductsCount = shopProductResult.count
    }

    func calculateFinalTotal() {
        let subtotal = Double(self.subtotal)
        let discountAmount = subtotal * discount / 100
        let tax = (subtotal - discountAmount) * taxRate / 100
        let total = subtotal - discountAmount + tax
        finalTotal = total
    }

    func calculateTotalsAndCount<T: CartItem>(for itemType: T.Type) -> (total: Int, count: Int) {
        let filteredItems = Cart.shared.chosenItems.compactMap { $0 as? T }
        let total = filteredItems.compactMap { $0.price }.reduce(0, +)
        let count = filteredItems.count
        return (total, count)
    }

    var taxAmount: Double {
        (Double(subtotal) - Double(subtotal) * discount / 100) * taxRate / 100
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



