//
//  BookingCollectionViewCell.swift
//  NON
//
//  Created by Evghenia Nedbailova on 19/01/2024.
//

import UIKit



class BookingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: BookingCollectionViewCell.self)
    

    @IBOutlet weak var cellPic: UIImageView!
    @IBOutlet weak var conteinerView: UIView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
  
       
   private func fillBookingCell(index: IndexPath){
    
        conteinerView.frame = self.bounds
        conteinerView.layer.cornerRadius = 10
        cellPic.layer.cornerRadius = 10
        cellPic.image = CollectionDataModel.sections[index.row].image
    }
    
    
    func selectedBookingCell(index: IndexPath){
        fillBookingCell(index: index)
        conteinerView.dropShadow(color: Colors.mainColorPink, opacity: 0.12, radius: 2)
        cellPic.layer.borderColor = Colors.mainColorPink
        cellPic.layer.borderWidth = 0.25
    }
    
    func deselectedBookingCell(index: IndexPath){
        fillBookingCell(index: index)
        conteinerView.dropShadow(color: Colors.subtitleColorPink, opacity: 0.12, radius: 2)
        cellPic.layer.borderColor = Colors.subtitleColorPink
        cellPic.layer.borderWidth = 0.17
    }
}









//import UIKit
//
//
//
//class BookingCollectionViewCell: UICollectionViewCell {
//    
//    static let identifier = String(describing: BookingCollectionViewCell.self)
//    
//
//    @IBOutlet weak var cellPic: UIImageView!
//    @IBOutlet weak var conteinerView: UIView!
//
//    
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    
//  
//       
//    
//    func fillBookingCell(index: Int){
//    
//        conteinerView.frame = self.bounds
//        conteinerView.layer.cornerRadius = 10
//        conteinerView.dropShadow(color: Colors.subtitleColorPink, opacity: 0.12, radius: 2)
//        cellPic.layer.borderColor = Colors.subtitleColorPink
//        cellPic.layer.borderWidth = 0.17
//        cellPic.layer.cornerRadius = 10
//        cellPic.image = CollectionDataModel.sections[index].image
//    
//    }
//
//
//}
//
