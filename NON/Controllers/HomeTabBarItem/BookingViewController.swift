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
    var servicesTableView = BookingTableView()
    let customHeaderView = UIView()
    let categoryName = UILabel()
    var bookButton = ButtonWithShadow()
    var collectionViewManager: BookingCollectionViewManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewManager = BookingCollectionViewManager(viewController: self)
        setupUIComponents()
        activateConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBookButtonState), name: .cartDidUpdate, object: nil) // << Добавлено
                updateBookButtonState() // << Добавлено
            }

            @objc func updateBookButtonState() {
                let hasSelectedServices = !Cart.shared.chosenServices.isEmpty
                bookButton.isActive = hasSelectedServices
            }

            deinit {
                NotificationCenter.default.removeObserver(self, name: .cartDidUpdate, object: nil) // << Добавлено
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
            
            servicesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            servicesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            servicesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            servicesTableView.topAnchor.constraint(equalTo: customHeaderView.bottomAnchor)
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
        categoryName.text = servicesTableView.currentCategory.rawValue
        categoryName.textColor = Colors.UIColorType.mainColorPink.value
        categoryName.textAlignment = .left
        categoryName.font = .systemFont(ofSize: 30, weight: .light)
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        
        bookButton = ButtonWithShadow(title: "Book", width: 200, height: 60, goToIdentifier: CartViewController.identifier)
        bookButton.isActive = false
        
        customHeaderView.addSubview(categoryName)
        customHeaderView.addSubview(bookButton)
    }

    private func setupTableView(){
        servicesTableView.backgroundColor = .black
        servicesTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        servicesTableView.separatorColor = Colors.UIColorType.mainColorPink.value
        servicesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(servicesTableView)
    }
    
    private func setupCollectionView(){
        categoryCollectionView.dataSource = collectionViewManager
        categoryCollectionView.delegate = collectionViewManager
        categoryCollectionView.register(UINib(nibName: BookingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BookingCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        categoryCollectionView.collectionViewLayout = layout
    }
}
