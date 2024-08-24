//
//  OrderDisplayView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 26/06/2024.
//

import SwiftUI

enum ShoppingCategoryName: String {
    case salonServices = "Salon Services"
    case giftVoucher = "Gift Voucher"
    case beautyProducts = "Beauty Products"
}

struct OrderDisplayView: View {
    var category: ShoppingCategoryName
    @State private var localServices: [(Category, ServiceNamePrice)]
    @State private var isExpanded: Bool = false
    @EnvironmentObject var cartModel: CartModel

    init(category: ShoppingCategoryName) {
        self.category = category
        self._localServices = State(initialValue: OrderDisplayView.loadServices(for: category))
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(category.rawValue)
                    .foregroundColor(.white)
                Spacer()
                if localServices.isEmpty {
                    Text("No purchases")
                        .foregroundColor(.white)
                } else {
                    VStack(alignment: .trailing) {
                        Text("Total: ")
                            .foregroundColor(.black)
                            .fontWeight(.bold) +
                        Text("\(cartModel.totalWithoutDiscount) AED")
                            .foregroundColor(.white)
                        Text("\(localServices.count) services")
                            .foregroundColor(.blue)
                            .font(.footnote)
                    }
                }
                if !localServices.isEmpty {
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
            .background(Colors.SwiftUIColorType.mainColorPink.value.opacity(0.7))
            .cornerRadius(10)

            if isExpanded {
                categoryView
            }
        }
    }

    private var categoryView: some View {
        switch category {
        case .salonServices:
            return AnyView(salonServicesView)
        case .giftVoucher, .beautyProducts:
            return AnyView(genericEmptyView)
        }
    }

    private var salonServicesView: some View {
        VStack(spacing: 10) {
            ForEach(localServices, id: \.1.name) { category, service in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                        .shadow(color: Colors.SwiftUIColorType.darkGray.value, radius: 1.5, x: 0, y: 0)
                    HStack {
                        Image(category.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text(service.name)
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                        Text("\(service.priceString)")
                            .foregroundColor(Colors.SwiftUIColorType.mainColorPink.value)
                        Button(action: {
                            withAnimation {
                                removeService(category: category, service: service)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(Colors.SwiftUIColorType.darkGray.value)
                        }
                    }
                    .padding()
                }
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
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

    private func removeService(category: Category, service: ServiceNamePrice) {
        Cart.shared.manageSalonServices(category: category, service: service)
        localServices.removeAll { $0.1.name == service.name }
        if localServices.isEmpty {
            isExpanded = false
        }
    }

    private static func loadServices(for category: ShoppingCategoryName) -> [(Category, ServiceNamePrice)] {
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
}
