//
//  BookingCollectionViewManager.swift
//  NON
//
//  Created by Evghenia Nedbailova on 14/06/2024.
//

import UIKit

class BookingCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var viewController: BookingViewController?
    var selectedCell = IndexPath(row: 0, section: 0)
    
    init(viewController: BookingViewController) {
        self.viewController = viewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionDataModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookingCollectionViewCell.identifier, for: indexPath) as! BookingCollectionViewCell
        if indexPath == selectedCell {
            cell.selectedBookingCell(index: indexPath)
        } else {
            cell.deselectedBookingCell(index: indexPath)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath
        collectionView.reloadData()
        
        viewController?.servicesTableView.currentCategory = CollectionDataModel.sections[indexPath.row].title
        viewController?.categoryName.text = viewController?.servicesTableView.currentCategory.rawValue
        viewController?.servicesTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
