//
//  OrderDisplayView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 26/06/2024.
//

import SwiftUI

struct OrderDisplayView: View {
    @ObservedObject var viewModel: OrderDisplayViewModel

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(viewModel.category.rawValue)
                    .foregroundColor(.white)
                Spacer()
                if viewModel.services.isEmpty {
                    Text("No purchases")
                        .foregroundColor(.white)
                } else {
                    VStack(alignment: .trailing) {
                        Text("Total: ")
                            .foregroundColor(.black)
                            .fontWeight(.bold) +
                        Text("\(viewModel.total, specifier: "%.2f") AED")
                            .foregroundColor(.white)
                        Text("\(viewModel.services.count) services")
                            .foregroundColor(.blue)
                            .font(.footnote)
                    }
                }
                if !viewModel.services.isEmpty {
                    Button(action: {
                        withAnimation {
                            viewModel.isExpanded.toggle()
                        }
                    }) {
                        Image(systemName: viewModel.isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(Colors.SwiftUIColorType.mainColorPink.value.opacity(0.7))
            .cornerRadius(10)

            if viewModel.isExpanded {
                switch viewModel.category {
                case .salonServices:
                    salonServicesView
                case .giftVoucher, .beautyProducts:
                    genericEmptyView
                }
            }
        }
    }

    private var salonServicesView: some View {
        VStack(spacing: 10) { // Добавляем отступы между элементами
            ForEach(viewModel.services, id: \.1.name) { category, service in
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
                            .foregroundColor(.white .opacity(0.7))
                        Spacer()
                        Text("\(service.price)")
                            .foregroundColor(Colors.SwiftUIColorType.mainColorPink.value)
                        Button(action: {
                            withAnimation {
                                viewModel.removeService(category: category, service: service)
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
}


