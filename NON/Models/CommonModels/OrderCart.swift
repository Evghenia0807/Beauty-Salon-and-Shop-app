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

    var chosenServices: [Category: [Sections]] = [:]

    func updateCart(category: Category, section: Sections, service: ServiceNamePrice) {
        var existingServices = chosenServices[category] ?? []

        if let sectionIndex = existingServices.firstIndex(where: { $0.sectionName == section.sectionName }) {
            var sectionServices = existingServices[sectionIndex].serviceNamePrice
            if let serviceIndex = sectionServices.firstIndex(where: { $0.name == service.name }) {
                // Удаление услуги
                sectionServices.remove(at: serviceIndex)
                if sectionServices.isEmpty {
                    // Удаление секции, если услуги в ней больше нет
                    existingServices.remove(at: sectionIndex)
                } else {
                    // Обновление секции с оставшимися услугами
                    existingServices[sectionIndex].serviceNamePrice = sectionServices
                }
            } else {
                // Добавление новой услуги в существующую секцию
                sectionServices.append(service)
                existingServices[sectionIndex].serviceNamePrice = sectionServices
            }
        } else {
            // Добавление новой секции с услугой
            existingServices.append(Sections(sectionName: section.sectionName, serviceNamePrice: [service]))
        }

        if existingServices.isEmpty {
            // Удаление категории, если секций в ней больше нет
            chosenServices.removeValue(forKey: category)
        } else {
            // Обновление категории с оставшимися секциями
            chosenServices[category] = existingServices
        }
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
        saveToUserDefaults()
    }

    private func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(chosenServices) {
            defaults.set(encoded, forKey: "chosenServices")
        }
    }

    private func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "chosenServices"),
           let decoded = try? JSONDecoder().decode([Category: [Sections]].self, from: savedData) {
            chosenServices = decoded
        }
    }

    func isSelected(category: Category, section: Sections, service: ServiceNamePrice) -> Bool {
        guard let existingServices = chosenServices[category] else { return false }
        if let sectionIndex = existingServices.firstIndex(where: { $0.sectionName == section.sectionName }) {
            let sectionServices = existingServices[sectionIndex].serviceNamePrice
            return sectionServices.contains(where: { $0.name == service.name })
        }
        return false
    }
}
