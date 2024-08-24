//
//  GiftVoucherModalView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 04/08/2024.
//

import SwiftUI

struct GiftVoucherOptionsView: View {
    @Binding var isPresented: Bool
    @State private var amount: Int = 500
    @State private var isDeliverySelected: Bool = false
    
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
            
            VStack {
                Text("Enter Amount")
                    .font(.title)
                    .foregroundColor(Colors.SwiftUIColorType.subtitleColorPink.value)
                
                Text("Minimum amount: 500 AED")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                  
                HStack {
                    Button(action: {
                        if amount > 500 {
                            amount -= 50
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(Colors.SwiftUIColorType.lightCyan.value.opacity(0.9))
                            .font(.largeTitle)
                    }
                    
                    Text("\(amount) aed")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        amount += 50
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(Colors.SwiftUIColorType.lightCyan.value)
                            .font(.largeTitle)
                    }
                }
                .padding()
                
                HStack {
                    Text("Include Delivery")
                        .foregroundColor(Colors.SwiftUIColorType.lightCyan.value)
                        .padding(.trailing)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(isDeliverySelected ? Colors.SwiftUIColorType.darkCyan.value : Colors.SwiftUIColorType.darkGray.value.opacity(0.6))
                            .frame(width: 50, height: 31)
                        Toggle(isOn: $isDeliverySelected) {
                            EmptyView()
                        }
                        .toggleStyle(SwitchToggleStyle(tint: Colors.SwiftUIColorType.darkCyan.value))
                        .labelsHidden()
                    }
                }
                
                Button(action: {
                    Cart.shared.addItem(GiftVoucher(delivery: isDeliverySelected, price: amount))
                    isPresented = false
                }) {
                    Text("Add to Cart")
                        .foregroundColor(Colors.SwiftUIColorType.mainColorPink.value)
                        .padding(.horizontal,30)
                        .padding(.vertical,20)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .shadow(color: .black.opacity(0.6), radius: 2)
            }
            .padding(30)
            .padding(.top,40)
            .padding(.bottom,40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(#colorLiteral(red: 0.831372549, green: 0.09411764706, blue: 0.462745098, alpha: 1)).opacity(0.8))
            )
            .padding(40)
            .transition(.opacity)
        }
    }
}
