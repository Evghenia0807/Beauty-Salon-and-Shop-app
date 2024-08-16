//
//  GiftVoucherViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 23/02/2024.
//

import UIKit
import SwiftUI

class GiftVoucherViewController: LogoViewController {
    
    var hostingController: UIHostingController<GiftVoucherModalView>?
    var isModalPresented: Bool = false
    
    @IBOutlet weak var giftVoucher: UIImageView!
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var trailingConstraint1: NSLayoutConstraint!
    @IBOutlet weak var trailingConstrait2: NSLayoutConstraint!
    @IBOutlet weak var trailingConstrait3: NSLayoutConstraint!
    @IBOutlet weak var subtitleText: UILabel!
    var buyButton = ButtonWithShadow()
    var largeText: [UILabel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateSetup()
        buyButtonSetup()
        setupHostingController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.5) {
            self.buyButton.alpha = 1
        }
    }
    
    
    
    private func setupHostingController() {
        let modalView = GiftVoucherModalView(isPresented: Binding(
                       get: { self.isModalPresented },
                       set: { newValue in
                           if newValue {
                               self.isModalPresented = newValue
                               self.hostingController?.view.isHidden = false
                               self.hostingController?.view.alpha = 0.0
                               UIView.animate(withDuration: 0.6, animations: {
                                   self.hostingController?.view.alpha = 1.0
                                   self.hostingController?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                               })
                           } else {
                               UIView.animate(withDuration: 0.6, animations: {
                                   self.hostingController?.view.alpha = 0.0
                               }, completion: { _ in
                                   self.hostingController?.view.isHidden = true
                                   self.isModalPresented = newValue
                               })
                           }
                       }
                   ))
        hostingController = UIHostingController(rootView: modalView)
        
        if let hostingController = hostingController {
            hostingController.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            hostingController.view.isHidden = true
            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            hostingController.didMove(toParent: self)
        }
    }
  
    private func buyButtonSetup(){
        buyButton = ButtonWithShadow(title: "Purchase", width: 200, height: 80, onTap: {
            [weak self] in
            self?.buyButtonTapped()
        })
        view.addSubview(buyButton)
        buyButton.alpha = 0.4
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(greaterThanOrEqualTo: subtitleText.bottomAnchor, constant: -5),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            buyButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            buyButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        let topConstraint = buyButton.topAnchor.constraint(equalTo: subtitleText.bottomAnchor, constant: 20)
        topConstraint.priority = UILayoutPriority(850)
        
        let bottomConstraint = buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        bottomConstraint.priority = UILayoutPriority(860)
        
        let heightConstraint = buyButton.heightAnchor.constraint(equalToConstant: 60)
        heightConstraint.priority = UILayoutPriority(950)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, heightConstraint])
    }
    
    
    private func buyButtonTapped() {
        isModalPresented = true
        hostingController?.view.isHidden = false
        hostingController?.view.alpha = 0.0
        UIView.animate(withDuration: 0.6, animations: {
            self.hostingController?.view.alpha = 1.0
            self.hostingController?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        })
    }
    
    private func initialSetup() {
        largeText.append(line1)
        largeText.append(line2)
        largeText.append(line3)
       
        for line in largeText {
            line.translatesAutoresizingMaskIntoConstraints = false
        }
        subtitleText.alpha = 0.5
        subtitleText.adjustsFontSizeToFitWidth = true
    }
    
    private func animateSetup() {
        UIView.animate(withDuration: 2) {
            for line in self.largeText {
                line.textAlignment = .right
                self.trailingConstraint1.constant = 5
                self.trailingConstrait2.constant = 5
                self.trailingConstrait3.constant = 5
                line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
                line.adjustsFontSizeToFitWidth = true
                self.view.layoutIfNeeded()
            }
            self.subtitleText.alpha = 1
        }
    }
}
