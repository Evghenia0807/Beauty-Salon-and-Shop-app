//
//  BookingTableCell.swift
//  NON
//
//  Created by Evghenia Nedbailova on 07/02/2024.
//

import UIKit

class BookingTableCell: UITableViewCell {

    let indentifier = "BookingTableCell"
    
   
    var serviceName = UILabel()
    var price = UILabel()
    
    
    
   
    func setupCell(){
        
        
        addSubview(serviceName)
        addSubview(price)
        
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        serviceName.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        serviceName.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
        serviceName.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5).isActive = true
        price.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        price.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5).isActive = true
        price.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5).isActive = true
        
        self.backgroundColor = .black
        serviceName.textColor = .white
        price.textColor = UIColor(cgColor: Colors.subtitleColorPink)
      
    }
    
    
}
