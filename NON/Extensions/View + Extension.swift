//
//  View + Extension.swift
//  NON
//
//  Created by Evghenia Nedbailova on 27/12/2023.
//

import Foundation
import UIKit

public extension UIView {



    func dropShadow(color: CGColor, opacity: Float, radius: CGFloat) {

       

        self.clipsToBounds = false
        
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 4, height: -3)
        layer.shadowRadius = (frame.width + frame.height) * radius / 100
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}



//self.clipsToBounds = false
//
//layer.shadowColor = Colors.mainColorPink
//layer.shadowOpacity = 0.35
//layer.shadowOffset = .zero
//layer.shadowRadius = (frame.width + frame.height) * 5 / 100
//layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//layer.shouldRasterize = true
//layer.rasterizationScale = UIScreen.main.scale



// чтобы тень получилось нужна последовательность :

//myView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
//
//myView.dropShadow()
//myView.backgroundColor = .black
//myView.layer.cornerRadius = 10

//view.addSubview(shadow)

//myView.translatesAutoresizingMaskIntoConstraints = false
//myView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//myView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//myView.heightAnchor.constraint(equalToConstant: 200).isActive = true




