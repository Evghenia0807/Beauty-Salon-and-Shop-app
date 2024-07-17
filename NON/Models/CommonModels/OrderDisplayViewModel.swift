//
//  OrderDisplayViewModel.swift
//  NON
//
//  Created by Evghenia Nedbailova on 08/07/2024.
//


import SwiftUI


enum ShoppingCategoryName: String {
    case salonServices = "Salon Services"
    case giftVoucher = "Gift Voucher"
    case beautyProducts = "Beauty Products"
}


class OrderDisplayViewModel: ObservableObject {
    @Published var isExpanded: Bool = false
    var category: ShoppingCategoryName

    init(category: ShoppingCategoryName) {
        self.category = category
    }

    var services: [(Category, ServiceNamePrice)] {
        switch category {
        case .salonServices:
            return Cart.shared.chosenSalonServices.flatMap { category, services in
                services.map { service in
                    (category, service)
                }
            }
        case .giftVoucher:
            return []
        case .beautyProducts:
            return []
        }
    }

    var total: Double {
        services.reduce(0) { total, categoryService in
            if let price = Double(categoryService.1.price.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        }
    }
    
    func removeService(category: Category, service: ServiceNamePrice) {
        withAnimation {
            Cart.shared.updateCart(category: category, service: service)
            if services.isEmpty {
                isExpanded = false
            }
            objectWillChange.send()
        }
    }
}


