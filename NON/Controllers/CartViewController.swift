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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = ScrollView {
            VStack(spacing: 20) {
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .salonServices))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .giftVoucher))
                OrderDisplayView(viewModel: OrderDisplayViewModel(category: .beautyProducts))
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.black)

        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        
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
