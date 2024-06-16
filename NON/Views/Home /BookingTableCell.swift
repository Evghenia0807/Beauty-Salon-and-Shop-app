//
//  BookingTableCell.swift
//  NON
//
//  Created by Evghenia Nedbailova on 07/02/2024.
//

import UIKit

class BookingTableCell: UITableViewCell {

   static let indentifier = "BookingTableCell"
    
    let accessoryPlus = UIImageView(image: UIImage(systemName: "plus"))
    var serviceName = UILabel()
    var price = UILabel()
    var serviceIsChosen: Bool = false {
        didSet{
            updateAccessoryView()
        }
    }
    var category: Category?
    var section: Sections?
    var service: ServiceNamePrice?
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
   
    func setupCell(){

        accessoryView = accessoryPlus
        accessoryPlus.contentMode = .scaleAspectFit
        accessoryPlus.isUserInteractionEnabled = true
        
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        price.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(serviceName)
        contentView.addSubview(price)
        
        activateConstraints()
        updateAccessoryView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(accessoryTapped))
        accessoryPlus.addGestureRecognizer(tapGesture)
        
        backgroundColor = .black
        serviceName.textColor = .white
        price.textColor = UIColor(cgColor: Colors.subtitleColorPink)
    }
    
    func activateConstraints(){
        NSLayoutConstraint.activate([
            serviceName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            serviceName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            serviceName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
    }
    
    func updateAccessoryView() {
        accessoryPlus.tintColor = serviceIsChosen ? UIColor(cgColor: Colors.mainColorPink) : UIColor(cgColor: Colors.darkGray)
    }
    
    @objc func accessoryTapped() {
        serviceIsChosen.toggle()
        guard let category = category, let section = section, let service = service else { return }

                Cart.shared.updateCart(category: category, section: section, service: service) // << Изменено

                print(Cart.shared.chosenServices)
    }
}
