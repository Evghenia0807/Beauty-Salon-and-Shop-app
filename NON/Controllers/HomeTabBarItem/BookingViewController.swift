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
    let serviceName = UILabel()
    var selectedCell = IndexPath(row: 0, section: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIComponents()
        activateConstraints()
    }
    
    
    private func setupUIComponents(){
        setupCollectionView()
        customHeader()
        setupTableView()
    }
    
    private func activateConstraints(){
        NSLayoutConstraint.activate([
            customHeaderView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            customHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customHeaderView.heightAnchor.constraint(equalToConstant: 70),
            customHeaderView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            serviceName.topAnchor.constraint(equalTo: customHeaderView.topAnchor),
            serviceName.bottomAnchor.constraint(equalTo: customHeaderView.bottomAnchor),
            serviceName.leadingAnchor.constraint(equalTo: customHeaderView.leadingAnchor),
            serviceName.trailingAnchor.constraint(equalTo: customHeaderView.trailingAnchor),
            
            tableServicesList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableServicesList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableServicesList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableServicesList.topAnchor.constraint(equalTo: customHeaderView.bottomAnchor)
        ])
    }
    
    private func customHeader(){
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        customHeaderView.backgroundColor = .black
        customHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customHeaderView)
        serviceNameSetup()
    }
        
    private func serviceNameSetup(){
        serviceName.text = tableServicesList.service.rawValue
        serviceName.textColor = UIColor(cgColor: Colors.mainColorPink)
        serviceName.textAlignment = .left
        serviceName.font = .systemFont(ofSize: 30, weight: .light)
        serviceName.translatesAutoresizingMaskIntoConstraints = false
        customHeaderView.addSubview(serviceName)
    }

    private func setupTableView(){
        tableServicesList.dataSource = tableServicesList
        tableServicesList.delegate = tableServicesList
        tableServicesList.backgroundColor = .black
        tableServicesList.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        tableServicesList.separatorColor = UIColor(cgColor: Colors.mainColorPink)
        tableServicesList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableServicesList)
    }
    
    private func setupCollectionView(){
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
        serviceName.text =  tableServicesList.service.rawValue
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
    
    
