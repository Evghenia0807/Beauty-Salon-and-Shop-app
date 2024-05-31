//
//  BookingTableView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 05/02/2024.
//

import UIKit

class BookingTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    let Data = BookingData()
    var service = ServicesType.nails
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        Data.fill(object: .tableView(service)).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.fill(object: .tableView(service))[section].serviceNamePrice.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Data.fill(object: .tableView(service))[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(BookingTableCell.self,
                                 forCellReuseIdentifier: "BookingTableCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableCell", for: indexPath) as! BookingTableCell
        cell.setupCell()
        cell.serviceName.text = Data.fill(object: .tableView(service))[indexPath.section].serviceNamePrice[indexPath.row].name
        cell.price.text = Data.fill(object: .tableView(service))[indexPath.section].serviceNamePrice[indexPath.row].price
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(cgColor: Colors.almostBlack)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookingTableCell else { return }
               cell.serviceIsChosen.toggle()
    }
    
}



