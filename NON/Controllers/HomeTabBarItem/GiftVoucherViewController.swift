//
//  GiftVoucherViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 23/02/2024.
//

import UIKit

class GiftVoucherViewController: LogoViewController {
    
  
    
    @IBOutlet weak var giftVoucher: UIImageView!
    
    
    @IBOutlet weak var line1: UILabel!
    @IBOutlet weak var line2: UILabel!
    @IBOutlet weak var line3: UILabel!
    @IBOutlet weak var trailingConstraint1: NSLayoutConstraint!
    @IBOutlet weak var trailingConstrait2: NSLayoutConstraint!
    @IBOutlet weak var trailingConstrait3: NSLayoutConstraint!
    @IBOutlet weak var subtitleText: UILabel!
    var buyButton: ButtonWithShadow!
    
    
    var largeText: [UILabel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateSetup()
        buyButtonSetup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.5) {
            self.buyButton.alpha = 1
        }
    }
    
   
    
    
    private func buyButtonSetup(){
        buyButton = ButtonWithShadow(title: "Purchase", width: 200, height: 80,  goToIdentifier: HomeViewController.identifier)
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
        
        let topConstrait = buyButton.topAnchor.constraint(equalTo: subtitleText.bottomAnchor, constant: 20)
        topConstrait.priority = UILayoutPriority(850)
        
        let bottomConstrait = buyButton.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        bottomConstrait.priority = UILayoutPriority(860)
        
        let heightContraint =  buyButton.heightAnchor.constraint(equalToConstant: 60)
        heightContraint.priority = UILayoutPriority(950)
        
        NSLayoutConstraint.activate([
            topConstrait,
            bottomConstrait,
            heightContraint
        ])
        
       
    }
    
    
    
    private func initialSetup(){
        
        largeText.append(line1)
        largeText.append(line2)
        largeText.append(line3)
       
        for line in largeText {
            line.translatesAutoresizingMaskIntoConstraints = false
        }
        subtitleText.alpha = 0.5
        subtitleText.adjustsFontSizeToFitWidth = true
    }
    
    
    private func animateSetup(){
        
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

