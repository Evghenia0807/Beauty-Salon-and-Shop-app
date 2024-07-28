//
//  OrderCart.swift
//  NON
//
//  Created by Evghenia Nedbailova on 16/06/2024.
//



import UIKit
import SwiftUI
import Combine

class Cart: ObservableObject {
    static let shared = Cart()
    
    private init() {
        loadFromUserDefaults()
    }

    @Published var chosenSalonServices: [Category: [ServiceNamePrice]] = [:]
    @Published var chosenGiftVoucher: [Int] = []
    @Published var chosenShopProducts: [String] = []

    func updateCart(category: Category, service: ServiceNamePrice) {
        var existingServices = chosenSalonServices[category] ?? []

        if let serviceIndex = existingServices.firstIndex(where: { $0.name == service.name }) {
            // Удаление услуги
            existingServices.remove(at: serviceIndex)
        } else {
            // Добавление новой услуги
            existingServices.append(service)
        }

        if existingServices.isEmpty {
            // Удаление категории, если услуг в ней больше нет
            chosenSalonServices.removeValue(forKey: category)
        } else {
            // Обновление категории с оставшимися услугами
            chosenSalonServices[category] = existingServices
        }
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
        saveToUserDefaults()
    }

    func addGiftVoucher(_ voucher: Int) {
        chosenGiftVoucher.append(voucher)
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
        saveToUserDefaults()
    }

    func addShopProduct(_ product: String) {
        chosenShopProducts.append(product)
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
        saveToUserDefaults()
    }

    private func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(chosenSalonServices) {
            defaults.set(encoded, forKey: "chosenServices")
        }
        if let encodedVouchers = try? JSONEncoder().encode(chosenGiftVoucher) {
            defaults.set(encodedVouchers, forKey: "chosenVouchers")
        }
        if let encodedProducts = try? JSONEncoder().encode(chosenShopProducts) {
            defaults.set(encodedProducts, forKey: "chosenProducts")
        }
    }

    private func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "chosenServices"),
           let decoded = try? JSONDecoder().decode([Category: [ServiceNamePrice]].self, from: savedData) {
            chosenSalonServices = decoded
        }
        if let savedVouchers = defaults.data(forKey: "chosenVouchers"),
           let decodedVouchers = try? JSONDecoder().decode([Int].self, from: savedVouchers) {
            chosenGiftVoucher = decodedVouchers
        }
        if let savedProducts = defaults.data(forKey: "chosenProducts"),
           let decodedProducts = try? JSONDecoder().decode([String].self, from: savedProducts) {
            chosenShopProducts = decodedProducts
        }
    }

    func isSelected(category: Category, service: ServiceNamePrice) -> Bool {
        guard let existingServices = chosenSalonServices[category] else { return false }
        return existingServices.contains(where: { $0.name == service.name })
    }
}
