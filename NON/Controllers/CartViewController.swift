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

        // Создаем SwiftUI представление с тремя OrderDisplayView в ScrollView
        let swiftUIView = ScrollView {
            VStack() {
                OrderDisplayView(total: 350, serviceCount: 2)
                OrderDisplayView(total: 150, serviceCount: 1)
                OrderDisplayView(total: 450, serviceCount: 3)
            }
            .padding()
            .background(Color.black)
            .cornerRadius(10)
        }
            .padding()
            .background(Color.black)

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
