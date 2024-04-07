//
//  File.swift
//  NON
//
//  Created by Evghenia Nedbailova on 10/12/2023.
//

import UIKit

struct HomeAutoSliderModel {
    let image: UIImage?
    let nameLabel: String
}


extension HomeAutoSliderModel {
    static var data = [
        HomeAutoSliderModel(image: UIImage(named: "HairCutSlide"), nameLabel: "HairCut"),
        HomeAutoSliderModel(image: UIImage(named: "ManicureSlide"), nameLabel: "Manicure"),
        HomeAutoSliderModel(image: UIImage(named: "BrowsSlide"), nameLabel: "Brows"),
        HomeAutoSliderModel(image: UIImage(named: "MassageSlide"), nameLabel: "Massage"),
        HomeAutoSliderModel(image: UIImage(named: "MakeupSlide"), nameLabel: "Makeup"),
        HomeAutoSliderModel(image: UIImage(named: "FaceCareSlide"), nameLabel: "FaceCare"),
        HomeAutoSliderModel(image: UIImage(named: "LashesSlide"), nameLabel: "Lashes"),
        HomeAutoSliderModel(image: UIImage(named: "CosmetologySlide"), nameLabel: "Cosmetology")
        
    ]
}
