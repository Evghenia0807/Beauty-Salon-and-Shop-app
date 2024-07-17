//
//  CardView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 15/07/2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Order Cart")
                    .font(.system(size: 40))
                    .foregroundColor(Colors.SwiftUIColorType.almostBlack.value)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .salonServices))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .giftVoucher))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .beautyProducts))
                
                promoCodeView
                Spacer(minLength: 50)
                cartSummaryView
                Spacer(minLength: 20)
                checkoutButton
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black)
    }

    private var promoCodeView: some View {
        HStack {
            TextField("Enter promo code", text: $viewModel.promoCode)
                .padding()
                .background(Colors.SwiftUIColorType.almostBlack.value.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.system(size: 14)) // Уменьшаем шрифт

            Button(action: viewModel.applyPromoCode) {
                Text("Apply")
                    .padding()
                    .background(Colors.SwiftUIColorType.mainColorPink.value)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }

    private var cartSummaryView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Subtotal:")
                    .foregroundColor(.white)
                Spacer()
                Text("\(viewModel.totalWithoutDiscount, specifier: "%.2f") AED")
                    .foregroundColor(.white)
            }
            
            if viewModel.discount > 0 {
                HStack {
                    Text("Discount (\(Int(viewModel.discount))%):")
                        .foregroundColor(.white)
                    Spacer()
                    Text("-\(viewModel.totalWithoutDiscount * viewModel.discount / 100, specifier: "%.2f") AED")
                        .foregroundColor(.white)
                }
            }
            
            if viewModel.hasDeliveryItems {
                HStack {
                    Text("Delivery Fee:")
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(viewModel.deliveryFee, specifier: "%.2f") AED")
                        .foregroundColor(.white)
                }
            }

            HStack {
                Text("Tax (\(viewModel.taxRate)%):")
                    .foregroundColor(.white)
                Spacer()
                Text("\(viewModel.taxAmount, specifier: "%.2f") AED")
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("Order Total:")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18)) // Увеличиваем шрифт
                Spacer()
                Text("\(viewModel.finalTotal, specifier: "%.2f") AED")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18)) // Увеличиваем шрифт
            }
        }
        .padding()
        .background(Colors.SwiftUIColorType.almostBlack.value)
        .cornerRadius(10)
    }

    private var checkoutButton: some View {
        Button(action: viewModel.checkout) {
            Text("Checkout")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Colors.SwiftUIColorType.mainColorPink.value)
                .cornerRadius(10)
        }
        .padding([.leading, .trailing], 16)
    }
}
