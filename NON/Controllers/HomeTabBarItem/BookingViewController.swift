//
//  MakeABookingViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 19/01/2024.
//

//MARK: Map
//CollectionView -> here
//CollectionViewCell -> apart
// TableView -> apart
// TableViewCell -> apart



import UIKit

class BookingViewController: LogoViewController {
   

   
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let tableServicesList = BookingTableView()
    let customHeaderView = UIView()
    let label = UILabel()
    var selectedCell = IndexPath(row: 0, section: 0)
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        customHeader()
    }
   
    
    func customHeader(){
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        customHeaderView.backgroundColor = .black
        customHeaderView.addSubview(label)
        tableServicesList.tableHeaderView = customHeaderView
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: customHeaderView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: customHeaderView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: customHeaderView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: customHeaderView.trailingAnchor).isActive = true
        label.text = tableServicesList.service.rawValue
        label.textColor = UIColor(cgColor: Colors.mainColorPink)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .light)
    }

    
    
    func setupTableView(){
        tableServicesList.dataSource = tableServicesList
        tableServicesList.delegate = tableServicesList
        tableServicesList.backgroundColor = .black
        tableServicesList.separatorColor = UIColor(cgColor: Colors.mainColorPink)
        tableServicesList.sectionIndexColor = .blue
        
        view.addSubview(tableServicesList)
        tableServicesList.translatesAutoresizingMaskIntoConstraints = false
        tableServicesList.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableServicesList.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableServicesList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableServicesList.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor).isActive = true
    }
    
    
    
    func setupCollectionView(){
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: BookingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BookingCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        categoryCollectionView.collectionViewLayout = layout
    }
    
    
    func setupCell(indexP: IndexPath) -> UICollectionViewCell{
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: BookingCollectionViewCell.identifier, for: indexP) as! BookingCollectionViewCell
            if indexP == selectedCell {
                cell.selectedBookingCell(index: indexP)
            } else {
                cell.deselectedBookingCell(index: indexP)
            }
        return cell
    } 
}






extension  BookingViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CollectionDataModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        setupCell(indexP: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath
        collectionView.reloadData()
        
        tableServicesList.service = CollectionDataModel.sections[indexPath.row].title
        label.text =  tableServicesList.service.rawValue
        tableServicesList.reloadData()
        
    }
}
    
    
    
    extension BookingViewController: UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            CGSize(width: 120, height: 110)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            5
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            5
        }
    }
    
    


//import UIKit
//
//class BookingViewController: LogoViewController {
//   
//
//   
//    @IBOutlet weak var categoryCollectionView: UICollectionView!
//    
//    let tableServicesList = BookingTableView()
//    let customHeaderView = UIView()
//    let label = UILabel()
//    
//   
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupCollectionView()
//        setupTableView()
//        customHeader()
//       
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//     
//        selectFirstItemInCollectionView()
//    }
//    
//    
//    func selectFirstItemInCollectionView() {
//            let firstIndexPath = IndexPath(item: 0, section: 0)
//            if categoryCollectionView.numberOfItems(inSection: 0) > 0 {
//                categoryCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .top)
//                collectionView(categoryCollectionView, didSelectItemAt: firstIndexPath)
//            }
//        }
//    
//    
//    func customHeader(){
//        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
//        customHeaderView.backgroundColor = .black
//        customHeaderView.addSubview(label)
//        tableServicesList.tableHeaderView = customHeaderView
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: customHeaderView.topAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: customHeaderView.bottomAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: customHeaderView.leadingAnchor).isActive = true
//        label.trailingAnchor.constraint(equalTo: customHeaderView.trailingAnchor).isActive = true
//        label.text = tableServicesList.service.rawValue
//        label.textColor = UIColor(cgColor: Colors.mainColorPink)
//        label.textAlignment = .left
//        label.font = .systemFont(ofSize: 30, weight: .light)
//     
//        
//    }
//
//
//    func setupCollectionView(){
//        categoryCollectionView.dataSource = self
//        categoryCollectionView.delegate = self
//        categoryCollectionView.register(UINib(nibName: BookingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BookingCollectionViewCell.identifier)
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        categoryCollectionView.collectionViewLayout = layout
//    }
//    
//    
//    
//    func setupTableView(){
//        tableServicesList.dataSource = tableServicesList
//        tableServicesList.delegate = tableServicesList
//        tableServicesList.backgroundColor = .black
//        tableServicesList.separatorColor = UIColor(cgColor: Colors.mainColorPink)
//        tableServicesList.sectionIndexColor = .blue
//        
//        view.addSubview(tableServicesList)
//        tableServicesList.translatesAutoresizingMaskIntoConstraints = false
//        tableServicesList.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        tableServicesList.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tableServicesList.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableServicesList.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor).isActive = true
//    }
//    
//    func updateCellStyle(at indexPath: IndexPath, isSelected: Bool) {
//        if let cell = categoryCollectionView.cellForItem(at: indexPath) as? BookingCollectionViewCell {
//            if isSelected {
//                cell.conteinerView.dropShadow(color: Colors.mainColorPink, opacity: 0.12, radius: 2)
//                cell.cellPic.layer.borderColor = Colors.mainColorPink
//                cell.cellPic.layer.borderWidth = 0.25
//            } else {
//                cell.conteinerView.dropShadow(color: Colors.subtitleColorPink, opacity: 0.12, radius: 2)
//                cell.cellPic.layer.borderColor = Colors.subtitleColorPink
//                cell.cellPic.layer.borderWidth = 0.17
//            }
//        }
//    }
//    
//
//}
//
//
//
//
//extension  BookingViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        CollectionDataModel.sections.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: BookingCollectionViewCell.identifier, for: indexPath) as! BookingCollectionViewCell
//        cell.fillBookingCell(index: indexPath.row)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        tableServicesList.service = CollectionDataModel.sections[indexPath.row].title
//        label.text =  tableServicesList.service.rawValue
//        tableServicesList.reloadData()
//        
//        updateCellStyle(at: indexPath, isSelected: true)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        updateCellStyle(at: indexPath, isSelected: false)
//    }
//}
//    
//    
//    
//    extension BookingViewController: UICollectionViewDelegateFlowLayout{
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            CGSize(width: 120, height: 110)
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            5
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            5
//        }
//    }
//    
//
