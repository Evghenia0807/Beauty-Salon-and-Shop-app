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
    let listOfServices = BookingTableView()
    let customHeaderView = UIView()
    let categoryName = UILabel()
    var selectedCell = IndexPath(row: 0, section: 0)
    var bookButton = ButtonWithShadow()
    
    
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
            customHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            categoryName.topAnchor.constraint(equalTo: customHeaderView.topAnchor),
            categoryName.bottomAnchor.constraint(equalTo: customHeaderView.bottomAnchor),
            categoryName.leadingAnchor.constraint(equalTo: customHeaderView.leadingAnchor, constant: 10),
            categoryName.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            
            bookButton.topAnchor.constraint(equalTo: customHeaderView.topAnchor,constant: 10),
            bookButton.bottomAnchor.constraint(equalTo: customHeaderView.bottomAnchor,constant: -10),
            bookButton.trailingAnchor.constraint(equalTo: customHeaderView.trailingAnchor,constant: -10),
            bookButton.leadingAnchor.constraint(equalTo: categoryName.trailingAnchor,constant: 10),
            
            listOfServices.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listOfServices.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listOfServices.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listOfServices.topAnchor.constraint(equalTo: customHeaderView.bottomAnchor)
        ])
    }
    
    private func customHeader(){
        customHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        customHeaderView.backgroundColor = .black
        customHeaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(customHeaderView)
        configHeaderSubviews()
    }
        
    private func configHeaderSubviews(){
        categoryName.text = listOfServices.service.rawValue
        categoryName.textColor = UIColor(cgColor: Colors.mainColorPink)
        categoryName.textAlignment = .left
        categoryName.font = .systemFont(ofSize: 30, weight: .light)
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        
        bookButton = ButtonWithShadow(title: "Book", width: 200, height: 60, goToIdentifier: "MakeABookingViewController")
        bookButton.isActive = false
        
        customHeaderView.addSubview(categoryName)
        customHeaderView.addSubview(bookButton)
    }

    private func setupTableView(){
        listOfServices.dataSource = listOfServices
        listOfServices.delegate = listOfServices
        listOfServices.backgroundColor = .black
        listOfServices.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        listOfServices.separatorColor = UIColor(cgColor: Colors.mainColorPink)
        listOfServices.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listOfServices)
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
        
        listOfServices.service = CollectionDataModel.sections[indexPath.row].title
        categoryName.text =  listOfServices.service.rawValue
        listOfServices.reloadData()
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
    
    
