//
//  CardView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 15/07/2024.
//
import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CartModel

    var body: some View {
        VStack() {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Order Cart")
                        .font(.system(size: 40))
                        .foregroundColor(Colors.SwiftUIColorType.almostBlack.value)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    OrderDisplayView(category: .salonServices)
                    OrderDisplayView(category: .giftVoucher)
                    OrderDisplayView(category: .beautyProducts)
                    
                    promoCodeView
                }
                .padding()
                .background(Color.black)
                .cornerRadius(10)
            }
            .background(Color.black)

            // Static CartSummaryView and CheckoutButton
            VStack() {
                CartSummaryView()
                    .background(Color.black)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                checkoutButton
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }
        .background(Color.black)
    }

    private var promoCodeView: some View {
        HStack {
            TextField("Enter promo code", text: $viewModel.promoCode)
                .padding()
                .background(Colors.SwiftUIColorType.almostBlack.value.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.system(size: 14))

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
    }
}
