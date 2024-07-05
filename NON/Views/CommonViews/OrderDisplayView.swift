//
//  OrderDisplayView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 26/06/2024.
//

import SwiftUI

struct OrderDisplayView: View {
    @State private var isExpanded: Bool = false
    var total: Double
    var serviceCount: Int

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Salon Services")
                    .foregroundColor(.white)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Total: $\(total, specifier: "%.2f")")
                        .foregroundColor(.white)
                    Text("\(serviceCount) services")
                        .foregroundColor(.blue)
                        .font(.footnote)
                }
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Colors.SwiftUIColorType.mainColorPink.value)
            .cornerRadius(10)
            
            if isExpanded {
                VStack {
                    ForEach(0..<serviceCount, id: \.self) { _ in
                        HStack {
                            Image(systemName: "scissors")
                            Text("Service Name")
                            Spacer()
                            Text("$Price")
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
                .padding(.bottom,20)
            }
        }
       
    }
}

struct OrderDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDisplayView(total: 99.99, serviceCount: 3)
    }
}
