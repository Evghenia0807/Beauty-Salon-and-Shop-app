//
//  BookingTableCell.swift
//  NON
//
//  Created by Evghenia Nedbailova on 07/02/2024.
//

import UIKit

class BookingTableCell: UITableViewCell {

   static let indentifier = "BookingTableCell"
    
    var serviceName = UILabel()
    var price = UILabel()
    var serviceIsChosen: Bool = false {
        didSet{
            updateAccessoryView()
        }
    }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let accesory = accessoryView {
            let margin: CGFloat = accesory.frame.width * 2
            accesory.frame.origin.x = self.contentView.frame.width - accesory.frame.width + margin
            price.trailingAnchor.constraint(equalTo: accesory.leadingAnchor, constant: -5).isActive = true
        }
    }
    
   
    func setupCell(){
        contentView.addSubview(serviceName)
        contentView.addSubview(price)
               
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        
        serviceName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        serviceName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        serviceName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        accessoryView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
       
        accessoryView = UIImageView(image: UIImage(systemName: "plus"))
        accessoryView?.isUserInteractionEnabled = true
        
        updateAccessoryView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(accessoryTapped))
        accessoryView?.addGestureRecognizer(tapGesture)
        
        backgroundColor = .black
        serviceName.textColor = .white
        price.textColor = UIColor(cgColor: Colors.subtitleColorPink)
    }
    
    func updateAccessoryView() {
           guard let accessoryImageView = accessoryView as? UIImageView else { return }
           accessoryImageView.tintColor = serviceIsChosen ? UIColor(cgColor: Colors.mainColorPink) : UIColor(cgColor: Colors.darkGray)
        
    }
    
    @objc func accessoryTapped() {
        serviceIsChosen.toggle()
        }
    
    
}
