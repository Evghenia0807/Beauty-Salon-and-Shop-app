//
//  OrderCart.swift
//  NON
//  Created by Evghenia Nedbailova on 16/06/2024.


//   Offerings:
//      1. Salon Services (stored array: chosenSalonServices)
//         - Stored separately due to complex data management needs.
//      2. Gift Vouchers
//      3. Cosmetic Products (or Shop Products)
//         - Both stored in array: chosenItems
//   Arrays chosenItems and chosenSalonServices handle all items the user can pay for.




import UIKit
import SwiftUI
import Combine

protocol CartItem {
    var id: UUID { get }
    var displayName: String { get }
    var price: Int { get }
    var amount: Int { get }
    var delivery: Bool { get }
    var imageName: String { get }
}

class Cart: ObservableObject {
    static let shared = Cart()
    
    private init() {
        loadFromUserDefaults()
    }

    @Published private(set) var chosenSalonServices: [Category: [ServiceNamePrice]] = [:]
    @Published private(set) var chosenItems: [CartItem] = []
    
    func manageSalonServices(category: Category, service: ServiceNamePrice) {
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

    func addItem(_ item: CartItem){
            chosenItems.append(item)
            NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
            saveToUserDefaults()
        }
        
        func removeItem(withId id: UUID) {
            chosenItems.removeAll { $0.id == id }
            NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
            saveToUserDefaults()
        }

    private func saveToUserDefaults() {
            let defaults = UserDefaults.standard
            if let encoded = try? JSONEncoder().encode(chosenSalonServices) {
                defaults.set(encoded, forKey: "chosenServices")
            }
        let giftVouchers = chosenItems.compactMap { $0 as? GiftVoucher }
            if let encodedGiftVouchers = try? JSONEncoder().encode(giftVouchers) {
                defaults.set(encodedGiftVouchers, forKey: "cartGiftVouchers")
            }
        let shopProducts = chosenItems.compactMap { $0 as? ShopProduct }
             if let encodedShopProducts = try? JSONEncoder().encode(shopProducts) {
                 defaults.set(encodedShopProducts, forKey: "cartShopProducts")
             }
        }
    
    private func loadFromUserDefaults() {
           let defaults = UserDefaults.standard
           if let savedData = defaults.data(forKey: "chosenServices"),
              let decoded = try? JSONDecoder().decode([Category: [ServiceNamePrice]].self, from: savedData) {
               chosenSalonServices = decoded
           }
        if let savedGiftVouchers = defaults.data(forKey: "cartGiftVouchers"),
               let decodedGiftVouchers = try? JSONDecoder().decode([GiftVoucher].self, from: savedGiftVouchers) {
                chosenItems.append(contentsOf: decodedGiftVouchers)
            }
        if let savedShopProducts = defaults.data(forKey: "cartShopProducts"),
                let decodedShopProducts = try? JSONDecoder().decode([ShopProduct].self, from: savedShopProducts) {
                 chosenItems.append(contentsOf: decodedShopProducts)
             }
       }
    
    func isSelected(category: Category, service: ServiceNamePrice) -> Bool {
        guard let existingServices = chosenSalonServices[category] else { return false }
        return existingServices.contains(where: { $0.name == service.name })
    }
}
