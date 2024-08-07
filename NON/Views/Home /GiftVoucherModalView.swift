//
//  GiftVoucherModalView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 04/08/2024.
//

import SwiftUI


struct GiftVoucherModalView: View {
    @Binding var isPresented: Bool
    @State private var amount: Int = 500
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                isPresented = false
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                )
            
            VStack(spacing: 20) {
                Text("Enter Amount for Gift Voucher")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("Minimum amount: 500 AED")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                HStack {
                    Button(action: {
                        if amount > 500 {
                            amount -= 50
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    
                    Text("\(amount) AED")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        amount += 50
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                }
                
                Button(action: {
                    // Добавить в корзину действие
                }) {
                    Text("Add to Cart")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.831372549, green: 0.09411764706, blue: 0.462745098, alpha: 1)).opacity(0.8))
            )
            .padding(40)
            .transition(.opacity)
        }
    }
}
