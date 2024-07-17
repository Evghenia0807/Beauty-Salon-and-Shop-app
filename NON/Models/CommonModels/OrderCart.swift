//
//  OrderCart.swift
//  NON
//
//  Created by Evghenia Nedbailova on 16/06/2024.
//



import Foundation

class Cart {
    static let shared = Cart()
    private init() {
        loadFromUserDefaults()
    }

    var chosenSalonServices: [Category: [ServiceNamePrice]] = [:]
    var chosenGiftVoucher: [Int] = []
    var chosenShopProducts: [String] = []

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

    private func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(chosenSalonServices) {
            defaults.set(encoded, forKey: "chosenServices")
        }
    }

    private func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "chosenServices"),
           let decoded = try? JSONDecoder().decode([Category: [ServiceNamePrice]].self, from: savedData) {
            chosenSalonServices = decoded
        }
    }

    func isSelected(category: Category, service: ServiceNamePrice) -> Bool {
        guard let existingServices = chosenSalonServices[category] else { return false }
        return existingServices.contains(where: { $0.name == service.name })
    }
}



