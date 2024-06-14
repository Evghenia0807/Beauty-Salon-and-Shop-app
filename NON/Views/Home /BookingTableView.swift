//
//  BookingTableView.swift
//  NON
//
//  Created by Evghenia Nedbailova on 05/02/2024.
//

import UIKit

class BookingTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    let Data = BookingData()
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
        Data.fill(object: .tableView(currentCategory)).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Data.fill(object: .tableView(currentCategory))[section].serviceNamePrice.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Data.fill(object: .tableView(currentCategory))[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableCell", for: indexPath) as! BookingTableCell
        cell.serviceName.text = Data.fill(object: .tableView(currentCategory))[indexPath.section].serviceNamePrice[indexPath.row].name
        cell.price.text = Data.fill(object: .tableView(currentCategory))[indexPath.section].serviceNamePrice[indexPath.row].price
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



