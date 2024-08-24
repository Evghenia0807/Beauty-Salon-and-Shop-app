//
//  CartSummaryView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 22/07/2024.
//

import SwiftUI

struct CartSummaryView: View {
    @EnvironmentObject var viewModel: CartModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Subtotal:")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Spacer()
                Text("\(Double(viewModel.subtotal), specifier: "%.2f") AED")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }
            
            if viewModel.discount > 0 {
                HStack {
                    Text("Discount (\(Int(viewModel.discount))%):")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                    Spacer()
                    Text("-\(Double(viewModel.subtotal) * viewModel.discount / 100, specifier: "%.2f") AED")
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                }
            }
            
            HStack {
                Text("Delivery Fee:")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Spacer()
                Text("0.00 AED")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }

            HStack {
                Text("Tax (\(viewModel.taxRate)%):")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                Spacer()
                Text("\(viewModel.taxAmount, specifier: "%.2f") AED")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            }
            
            HStack {
                Text("Order Total:")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                Spacer()
                Text("\(Double(viewModel.finalTotal), specifier: "%.2f") AED")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(10)
    }
}
