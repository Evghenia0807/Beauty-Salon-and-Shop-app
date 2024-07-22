//
//  ServicesCategory.swift
//  NON
//  Created by Evghenia Nedbailova on 24/01/2024.
//

// Category (Nails,HairCut..)
// Section (Manicure,Pedicure..)
// Service (Gel polish ... price)


import UIKit



//MARK: Models

enum BookingVCModel {
    case collectionView(CollectionDataModel)
    case tableView(Category)
}


struct CollectionDataModel: Hashable{
    let image: UIImage?
    let title: Category

   static var sections: [Self] = [
        .init(image: UIImage(named: "Nails"), title: Category.nails),
        .init(image: UIImage(named: "Face Care"), title: Category.faceCare),
        .init(image: UIImage(named: "Hair Cut"), title: Category.hair),
        .init(image: UIImage(named: "Massage"), title: Category.massage),
        .init(image: UIImage(named: "Lashes"), title: Category.lashes),
        .init(image: UIImage(named: "Cosmetology"), title: Category.cosmetology),
        .init(image: UIImage(named: "MakeUp"), title: Category.cosmetology),
        .init(image: UIImage(named: "Permanent"), title: Category.permanent)
    ]
}


enum Category: String, Codable{
    case nails = "Nails"
    case hair = "Hair Cut"
    case lashes = "Lashes"
    case massage = "Massage"
    case faceCare = "Face Care"
    case cosmetology = "Cosmetology"
    case makeUp = "MakeUp"
    case permanent = "Permanent"
}


struct Sections: Codable{
    let sectionName: String
    var serviceNamePrice: [ServiceNamePrice]
    }


struct ServiceNamePrice: Codable{
    let name: String
    let price: String

    init(name: String, price: Int) {
        self.name = name
        self.price = "\(price) AED"
    }
}









//MARK: Data

struct BookingData{
    
    
    func fill(object: BookingVCModel) -> [Sections]{
        var array = [Sections]()
        
        switch object {
            case .tableView(let category) where category == .nails : array = nailsData
            case .tableView(let category) where category == .lashes : array = lashesData
            case .tableView(let category) where category == .hair : array = hairData
            case .tableView(let category) where category == .massage : array = massage
            case .tableView(let category) where category == .faceCare : array = faceCare
            case .tableView(let category) where category == .makeUp : array = makeUp
            case .tableView(let category) where category == .permanent : array = permanent
            case .tableView(let category) where category == .cosmetology : array = cosmetology
            default: break
        }
        return array
    }
    
    
    
    let nailsData: [Sections] = [
        .init(sectionName: "Manicure",
              serviceNamePrice: [.init(name: "Acrilyc nail extension full set", price: 199),
                                 .init(name: "Infill nail EXTENSIOextensionNS", price: 150),
                                 .init(name: "+ Gel polish", price: +25),
                                 .init(name: "Ombre full set (Acrilyc/gel)", price: 250),
                                 .init(name: "Gel overlay", price: 200)]),
        .init(sectionName: "Pedicure",
              serviceNamePrice: [.init(name: "French Pedicure", price: 110),
                                 .init(name: "@Infill nail EXTENSIOextensionNS", price: 150),
                                 .init(name: "Classic Pedicure", price: 95),
                                 .init(name: "@Ombre full set (Acrilyc/gel)", price: 250),
                                 .init(name: "@Gel overlay", price: 200),
                                 .init(name: "Basic Pedicure", price: 85)]),
        .init(sectionName: "MANICURE/PEDICURE COMBO", serviceNamePrice: [
                                 .init(name: "Basic Manicure/Pedicure", price: 130),
                                 .init(name: "Classic Manicure/Pedicure", price: 160),
                                 .init(name: "French Manicure/Pedicure", price: 170),
                                 .init(name: "Princess Manicure/Pedicure", price: 65),
                                 .init(name: "Polish Change Hands/Feet", price: 50),
                                 .init(name: "Gel Couture Polish Change", price: 55)]),
        .init(sectionName: "Podiatrist",
              serviceNamePrice: [.init(name: "Nail and Skin Fungus", price: 200),
                                 .init(name: "Diabetic Feet", price: 250),
                                 .init(name: "Unexplained foot swelling", price: 300),
                                 .init(name: "Toe walking", price: 150),
                                 .init(name: "Hammertoes", price: 300),
                                 .init(name: "Ingrown Toenails", price: 100),
                                 .init(name: "Warts / Verrucae", price: 199),]),
        .init(sectionName: "TREATMENTS",
              serviceNamePrice: [.init(name: "Spa Manicure Regular", price: 140),
                                 .init(name: "Spa Manicure Bright Citron", price: 210),
                                 .init(name: "Paraffin Hands", price: 170),
                                 .init(name: "Paraffin Feet", price: 250),
                                 .init(name: "Paraffin Hands with Manicure", price: 260)]),
        .init(sectionName: "ARTIFICIAL NAIL SETS", serviceNamePrice: [
                                 .init(name: "Fake Nails Set", price: 210),
                                 .init(name: "Fake Nails Application", price: 40),
                                 .init(name: "Fake Nails Removal", price: 110)])
        
    ]
    
    let lashesData: [Sections] = [
        .init(sectionName: "EYELASH EXTENSIONS", serviceNamePrice: [
                                 .init(name: "Eyelashes (Single)", price: 260),
                                 .init(name: "Eyelashes (Stripe)", price: 210),
                                 .init(name: "Full Set", price: 360),
                                 .init(name: "Application", price: 50),
                                 .init(name: "Extension Touch up", price: 260),
                                 .init(name: "Extension Removal", price: 70)])
    ]

    
    let hairData: [Sections] = [
        .init(sectionName: "CUT", serviceNamePrice: [
                                 .init(name: "Trim", price: 120),
                                 .init(name: "Fringe", price: 50),
                                 .init(name: "Restyle", price: 200),
                                 .init(name: "Toddler", price: 120),
                                 .init(name: "Princess Cut (1-4 Years)", price: 90),
                                 .init(name: "Hair Wash", price: 75)]),
        .init(sectionName: "BLOWDRY", serviceNamePrice: [
                                 .init(name: "Medium Hair", price: 120),
                                 .init(name: "Long Hair", price: 180),
                                 .init(name: "Open Hair Style", price: 350),
                                 .init(name: "Hair Braid", price: 100)]),
        .init(sectionName: "FULL COLOR", serviceNamePrice: [
                                 .init(name: "Roots", price: 315),
                                 .init(name: "Short Hair", price: 580),
                                 .init(name: "Medium Hair", price: 680),
                                 .init(name: "Long Hair", price: 780),
                                 .init(name: "Extra Long Hair", price: 1000)]),
        .init(sectionName: "HAIR EXTENSIONS", serviceNamePrice: [
                                 .init(name: "M&F Hair Extensions (Clip)", price: 840),
                                 .init(name: "ape Hair Extension Cleaning", price: 6),
                                 .init(name: "Tape Hair Extension Removal", price: 75),
                                 .init(name: "CLIPHairExtensions-Quikkies", price: 400),
                                 .init(name: "Keratin/Micro Keratin", price: 10)])
                                 
    ]
    
    let massage: [Sections] = [
        .init(sectionName: "Massage", serviceNamePrice: [
                                 .init(name: "Face Massage", price: 105),
                                 .init(name: "Face Lifting Massage", price: 190),
                                 .init(name: "Head Massage", price: 105),
                                 .init(name: "Neck & Shoulder Massage", price: 150),
                                 .init(name: "Back Massage - 15 min", price: 65),
                                 .init(name: "..........", price: 70)]),
        .init(sectionName: "Hot Stone", serviceNamePrice: [
                                 .init(name: "Add on Hot Stone", price: 160),
                                 .init(name: "Full Body Massage - Promotion", price: 160),
                                 .init(name: "Thai Massage - 60 min", price: 350),
                                 .init(name: "Swidish Massage", price: 315),
                                 .init(name: "Aromatherapy Massage", price: 260),
                                 .init(name: "Slimming Massage", price: 360)])
    ]
    
    let faceCare: [Sections] = [
        .init(sectionName: "FACE FILM WAX", serviceNamePrice: [
                                 .init(name: "Nose", price: 35),
                                 .init(name: "Full Face", price: 150),
                                 .init(name: "Full Face & Neck", price: 200),
                                 .init(name: "Neck & Shoulder Massage", price: 150),
                                 .init(name: "Back Massage - 15 min", price: 65),
                                 .init(name: "..........", price: 70)]),
        .init(sectionName: "Hot Stone", serviceNamePrice: [
                                 .init(name: "Facial Mask", price: 160),
                                 .init(name: "Add-on Mask", price: 50),
                                 .init(name: "Hydrabrasion - Hydrabrasion", price: 550),
                                 .init(name: "Anti-Aging Treatment", price: 600),
                                 .init(name: "Vit C Express", price: 360),
                                 .init(name: "Lift Some", price: 360)])
    ]
    

    let cosmetology: [Sections] = [
        .init(sectionName: "BODY WAXING", serviceNamePrice: [
                                 .init(name: "Half Legs", price: 95),
                                 .init(name: "Chest", price: 45),
                                 .init(name: "Stomach Line", price: 45),
                                 .init(name: "Bikini Line", price: 65),
                                 .init(name: "Bikini", price: 95),
                                 .init(name: "Full Body", price: 150)]),
        .init(sectionName: "Hot Stone", serviceNamePrice: [
                                 .init(name: "Add on Hot Stone", price: 160),
                                 .init(name: "Full Body Massage - Promotion", price: 160),
                                 .init(name: "Thai Massage - 60 min", price: 350),
                                 .init(name: "Swidish Massage", price: 315),
                                 .init(name: "Aromatherapy Massage", price: 260),
                                 .init(name: "Slimming Massage", price: 360)])
    ]
    
    
    let makeUp: [Sections] = [
        .init(sectionName: "MakeUp", serviceNamePrice: [
                                 .init(name: "Eye Make Up", price: 160),
                                 .init(name: "Base Make Up", price: 315),
                                 .init(name: "Normal Day Make Up", price: 360),
                                 .init(name: "Day Make up & Eyelashes", price: 360),
                                 .init(name: "Evening Make up & Eyelashes", price: 550),
                                 .init(name: "Prova Make up", price: 360)])
    ]
    
    let permanent: [Sections] = [
        .init(sectionName: "THREADING", serviceNamePrice: [
                                 .init(name: "Eyebrows", price: 85),
                                 .init(name: "Eyebrow Tweezer", price: 55),
                                 .init(name: "Foreheade", price: 35),
                                 .init(name: "Chin", price: 30),
                                 .init(name: "Back Massage - 15 min", price: 65),
                                 .init(name: "..........", price: 70)]),
        .init(sectionName: "TINTING", serviceNamePrice: [
                                 .init(name: "Eyebrows", price: 130),
                                 .init(name: "Eyelashes", price: 150),
                                 .init(name: "Eyebrow Trimming", price: 150),
                                 .init(name: "Swidish Massage", price: 315),
                                 .init(name: "Eyebrow Mousse/SHAVE", price: 85),
                                 .init(name: "Slimming Massage", price: 360)])
    ]

}




