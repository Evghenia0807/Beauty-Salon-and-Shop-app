//
//  CartViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 23/06/2024.
//

import UIKit
import SwiftUI

class CartViewController: LogoViewController {
    static let identifier = "CartViewController"
    
    private var promoCode: String = ""
    private var discount: Double = 0.0
    private var hostingController: UIHostingController<AnyView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        let swiftUIView = ScrollView {
            VStack(spacing: 20) {
                Text("Order Card")
                    .font(.system(size: 40))
                    .foregroundColor(Colors.SwiftUIColorType.almostBlack.value)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                   
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .salonServices))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .giftVoucher))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .beautyProducts))
                
                promoCodeView
                Spacer(minLength: 50)
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black)

        hostingController = UIHostingController(rootView: AnyView(swiftUIView))

        if let hostingController = hostingController {
            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }

        view.addSubview(checkoutButton)
    }

    private func setupConstraints() {
        guard let hostingControllerView = hostingController?.view else { return }

        hostingControllerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingControllerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100) 
        ])

        NSLayoutConstraint.activate([
            checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private var promoCodeView: some View {
        HStack {
            TextField("Enter promo code", text: Binding(get: {
                self.promoCode
            }, set: { newValue in
                self.promoCode = newValue
            }))
                .padding()
                .background(Colors.SwiftUIColorType.almostBlack.value.opacity(0.7))
                .cornerRadius(10)
                .foregroundColor(.white)

            Button(action: {
                self.applyPromoCode()
            }) {
                Text("Apply")
                    .padding()
                    .background(Colors.SwiftUIColorType.mainColorPink.value)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }

    private lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = Colors.UIColorType.mainColorPink.value
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func applyPromoCode() {
        // Пример логики применения промокода
        if promoCode == "DISCOUNT10" {
            discount = 10.0
        } else {
            discount = 0.0
        }
    }
    
    @objc private func checkout() {
        // Логика завершения покупки
        let total = Cart.shared.chosenSalonServices.flatMap { $0.value }.reduce(0) { total, service in
            if let price = Double(service.price.replacingOccurrences(of: " AED", with: "")) {
                return total + price
            }
            return total
        } * (1 - discount / 100)
        
        print("Checkout with total: \(total) AED")
    }
}
