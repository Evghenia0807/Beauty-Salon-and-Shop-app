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
    @State private var localServices: [(Category, ServiceNamePrice)] = []
    @State private var localItems: [CartItem] = []
    @State private var isExpanded: Bool = false
    @EnvironmentObject var cartModel: CartModel

    init(category: ShoppingCategoryName) {
        self.category = category
        if category == .salonServices {
            self._localServices = State(initialValue: OrderDisplayView.loadServices(for: category))
        } else {
            self._localItems = State(initialValue: OrderDisplayView.loadItems(for: category))
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(category.rawValue)
                    .foregroundColor(.white)
                Spacer()
                if localServices.isEmpty && localItems.isEmpty {
                    Text("No purchases")
                        .foregroundColor(.white)
                } else {
                    VStack(alignment: .trailing) {
                        Text("Total: ")
                            .foregroundColor(.black)
                            .fontWeight(.bold) +
                        Text("\(totalAmount()) AED")
                            .foregroundColor(.white)
                        Text("\(itemCount()) items")
                            .foregroundColor(.blue)
                            .font(.footnote)
                    }
                }
                if !localServices.isEmpty || !localItems.isEmpty {
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
            return AnyView(itemsView)
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

    private var itemsView: some View {
        VStack(spacing: 10) {
            ForEach(localItems, id: \.id) { item in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black)
                        .shadow(color: Colors.SwiftUIColorType.darkGray.value, radius: 1.5, x: 0, y: 0)
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text(item.displayName)
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                        Text("\(item.price) AED")
                            .foregroundColor(Colors.SwiftUIColorType.mainColorPink.value)
                        Button(action: {
                            withAnimation {
                                removeItem(item)
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
            Text("No items selected")
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

    private func removeItem(_ item: CartItem) {
        Cart.shared.removeItem(withId: item.id)
        localItems.removeAll { $0.id == item.id }
        if localItems.isEmpty {
            isExpanded = false
        }
    }

    private func totalAmount() -> Int {
        switch category {
        case .salonServices:
            return localServices.map { $0.1.price }.reduce(0, +)
        default:
            return localItems.map { $0.price }.reduce(0, +)
        }
    }

    private func itemCount() -> Int {
        switch category {
        case .salonServices:
            return localServices.count
        default:
            return localItems.count
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
        default:
            return []
        }
    }

    private static func loadItems(for category: ShoppingCategoryName) -> [CartItem] {
        switch category {
        case .giftVoucher:
            return Cart.shared.chosenItems.compactMap { $0 as? GiftVoucher }
        case .beautyProducts:
            return Cart.shared.chosenItems.compactMap { $0 as? ShopProduct }
        default:
            return []
        }
    }
}
