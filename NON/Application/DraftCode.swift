//
//  DraftCode.swift
//  NON
//
//  Created by Evghenia Nedbailova on 05/07/2024.
//


#if TEMP_CODE

import UIKit
import SwiftUI

class CartViewController: LogoViewController {
    static let identifier = "CartViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем SwiftUI представление с тремя OrderDisplayView в ScrollView
        let swiftUIView = ScrollView {
            VStack() {
                OrderDisplayView(total: 350, serviceCount: 2)
                OrderDisplayView(total: 150, serviceCount: 1)
                OrderDisplayView(total: 450, serviceCount: 3)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
            .padding()

        // Создаем UIHostingController
        let hostingController = UIHostingController(rootView: swiftUIView)

        // Добавляем UIHostingController в текущий UIViewController
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // Устанавливаем ограничения
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }
}







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
            .background(Color.pink.opacity(0.7))
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
                        .background(Color.pink.opacity(0.5))
                        .cornerRadius(8)
                    }
                }
                .padding(.top, 10)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding([.leading, .trailing], 10)
                .transition(.opacity)
            }
        }
       
    }
}

struct OrderDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDisplayView(total: 99.99, serviceCount: 3)
    }
}















#endif
