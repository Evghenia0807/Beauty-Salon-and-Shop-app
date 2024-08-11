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
            // Темный градиент заднего фона с эффектом bloom
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    // Bloom effect в виде цветовых круглых пятен
                    ZStack {
                        Circle()
                            .fill(Color.purple.opacity(0.4))
                            .frame(width: 300, height: 300)
                            .offset(x: -150, y: -250)
                            .blur(radius: 100)
                        
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 250, height: 250)
                            .offset(x: 150, y: 150)
                            .blur(radius: 80)
                        
                        Circle()
                            .fill(Colors.SwiftUIColorType.mainColorPink.value.opacity(0.5))
                            .frame(width: 200, height: 200)
                            .offset(x: -200, y: 300)
                            .blur(radius: 100)
                    }
                )
            
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Spacer()
                
                Text("Enter Amount")
                    .font(.title)
                    .foregroundColor(.white)
                
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
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    
                    Text("\(amount) aed")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
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
                
                Spacer()
            }
            .padding()
            .background(
                // Полупрозрачный фон с лёгким цветовым градиентом
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.09935290366, green: 0.09935290366, blue: 0.09935290366, alpha: 1)).opacity(0.3), Color(#colorLiteral(red: 0.2444417477, green: 0.003845657455, blue: 0.9699226022, alpha: 1)).opacity(0.2), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)).opacity(0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    .blur(radius: 1)
            )
            .padding(.horizontal,50)
            .padding(.vertical,170)
            .transition(.opacity)
        }
    }
}
