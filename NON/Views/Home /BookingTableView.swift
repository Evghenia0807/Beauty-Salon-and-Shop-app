//
//  BookingTableView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 05/02/2024.
//

import UIKit

class BookingTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    let data = BookingData()
    var currentCategory = Category.nails
    
    init() {
            super.init(frame: .zero, style: .plain)
            setupTableView()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupTableView()
        }

        private func setupTableView() {
            self.register(BookingTableCell.self, forCellReuseIdentifier: "BookingTableCell")
            self.delegate = self
            self.dataSource = self
        }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.fill(object: .tableView(currentCategory)).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.fill(object: .tableView(currentCategory))[section].serviceNamePrice.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data.fill(object: .tableView(currentCategory))[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableCell", for: indexPath) as! BookingTableCell
        let section = data.fill(object: .tableView(currentCategory))[indexPath.section]
        let service = section.serviceNamePrice[indexPath.row]
                
                cell.serviceName.text = service.name
                cell.price.text = service.price
                cell.category = currentCategory
                cell.section = section
                cell.service = service
                
                cell.serviceIsChosen = Cart.shared.isSelected(category: currentCategory, service: service)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = Colors.UIColorType.almostBlack.value
        tableView.deselectRow(at: indexPath, animated: true)
        let category = data.fill(object: .tableView(currentCategory))[indexPath.section]
        let service = category.serviceNamePrice[indexPath.row]

                
                Cart.shared.updateCart(category: currentCategory, service: service)

                
                tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
}



