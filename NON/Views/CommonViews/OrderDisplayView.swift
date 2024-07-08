//
//  OrderDisplayView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 26/06/2024.
//

import SwiftUI

enum ShoppingCategoryName {
    case salonServices
    case giftVoucher
    case beautyProducts
}

struct OrderDisplayView: View {
    @State private var isExpanded: Bool = false
    var category: ShoppingCategoryName
    
    private var services: [ServiceNamePrice] {
        switch category {
        case .salonServices:
            return Cart.shared.chosenSalonServices.flatMap { $0.value }
        case .giftVoucher:
            return Cart.shared.chosenGiftVoucher.map { ServiceNamePrice(name: "Gift Voucher \($0)", price: 0) }
        case .beautyProducts:
            return Cart.shared.chosenShopProducts.map { ServiceNamePrice(name: $0, price: 0) }
        }
    }

    private var total: Double {
        services.reduce(0) { total, service in
            if let price = Double(service.price.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(categoryTitle)
                    .foregroundColor(.white)
                Spacer()
                if services.isEmpty {
                    Text("No purchases")
                        .foregroundColor(.white)
                } else {
                    VStack(alignment: .trailing) {
                        Text("Total: \(total, specifier: "%.2f") AED")
                            .foregroundColor(.white)
                        Text("\(services.count) services")
                            .foregroundColor(.blue)
                            .font(.footnote)
                    }
                }
                if !services.isEmpty {
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Colors.SwiftUIColorType.mainColorPink.value)
            .cornerRadius(10)

            if isExpanded {
                switch category {
                case .salonServices:
                    salonServicesView
                case .giftVoucher, .beautyProducts:
                    genericEmptyView
                }
            }
        }
    }

    private var categoryTitle: String {
        switch category {
        case .salonServices:
            return "Salon Services"
        case .giftVoucher:
            return "Gift Voucher"
        case .beautyProducts:
            return "Beauty Products"
        }
    }

    private var salonServicesView: some View {
        VStack {
            ForEach(services, id: \.name) { service in
                HStack {
                    Image(systemName: "scissors") // Replace with actual image if available
                    Text(service.name)
                    Spacer()
                    Text("\(service.price)")
                    Button(action: {
                        // Remove service action
                    }) {
                        Image(systemName: "trash")
                    }
                }
                .padding()
                .background(Colors.SwiftUIColorType.darkGray.value)
                .cornerRadius(8)
            }
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding([.leading, .trailing], 10)
        .transition(.opacity)
        .padding(.bottom, 20)
    }

    private var genericEmptyView: some View {
        VStack {
            Text("No services selected")
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.black)
        .cornerRadius(10)
        .padding([.leading, .trailing], 10)
        .transition(.opacity)
        .padding(.bottom, 20)
    }
}
