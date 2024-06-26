//
//  CartViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 23/06/2024.
//

import UIKit
import SwiftUI

class CartViewController: UIViewController {
    static let identifier = "CartViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let orderDisplayView = UIHostingController(rootView: OrderDisplayView(total: 350, serviceCount: 2))
        addChild(orderDisplayView)
        orderDisplayView.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(orderDisplayView.view)
        
        NSLayoutConstraint.activate([
            orderDisplayView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            orderDisplayView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            orderDisplayView.view.topAnchor.constraint(equalTo: view.topAnchor),
            orderDisplayView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        orderDisplayView.didMove(toParent: self)
        
        // Добавляем наблюдателя за изменением размера контента
        orderDisplayView.view.setContentHuggingPriority(.required, for: .vertical)
        orderDisplayView.view.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}











//import UIKit
//import SwiftUI
//
//class CartViewController: UIViewController {
//
//    static let identifier = "CartViewController"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let cartView = UIHostingController(rootView: CartView())
//        addChild(cartView)
//        cartView.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(cartView.view)
//        
//        NSLayoutConstraint.activate([
//            cartView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cartView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cartView.view.topAnchor.constraint(equalTo: view.topAnchor),
//            cartView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//        
//        cartView.didMove(toParent: self)
//    }
//}
