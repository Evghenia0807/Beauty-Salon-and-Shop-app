//
//  Logo.swift
//  NON
//
//  Created by Evghenia Nedbailova on 06/12/2023.
//

import UIKit

class Logo: UILabel {
    
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    init(textSize: CGFloat){
        super.init(frame: CGRectZero)
        attributedText = setupLogo(textSize: textSize)
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        numberOfLines = 2
       
    }
    
    func setupLogo(textSize: CGFloat) -> NSAttributedString {
        
        
        paragraphStyle.paragraphSpacing = -25
        paragraphStyle.alignment = .center

        
        let titleAtributes: [NSAttributedString.Key: Any] =
        [ .font: UIFont.systemFont(ofSize: textSize),
          .foregroundColor: Colors.mainColorPink,
        ]
        
        let subtitleAtributes: [NSAttributedString.Key: Any] =
        [ .font: UIFont.systemFont(ofSize: textSize / 9),
          .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
          .kern: 4
        ]
        
        let title = NSMutableAttributedString(string: "NON", attributes: titleAtributes)
        title.addAttribute(.font, value: UIFont(name: "Optima" , size: textSize) ?? UIFont.systemFont(ofSize: textSize), range: NSMakeRange(0, title.length))
                            
        let subTitle = NSMutableAttributedString(string: "\r\n not only nails  ", attributes: subtitleAtributes)
        
        title.append(subTitle)
        title.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, title.length))
        
        
        return title
    }
    

}


//\r\n










//import UIKit
//
//class Logo: UIStackView {
//    
//    
//
//    private var mineName: UILabel = {
//        let label = UILabel()
//        label.text = "NON"
//        label.textColor = UIColor(cgColor: Colors.mainColorPink)
//        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private var subtitleName: UILabel = {
//        let label = UILabel()
//        label.text = "Not Only Nails"
//        label.textColor = UIColor(cgColor: Colors.subtitleColorPink)
//        label.numberOfLines = 0
//        label.adjustsFontSizeToFitWidth = true
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    
//    
//    required init(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//   
//    init(textSize: CGFloat){
//    
//            mineName.font = UIFont(name: "Optima", size: textSize)
//            subtitleName.font = UIFont(name: "Optima", size: textSize / 6)
//            super.init(frame: CGRectZero)
//            self.spacing =  -(textSize / 5)
//            setupStack()
//        }
//    
//    
//    func setupStack(){
//        addArrangedSubview(mineName)
//        addArrangedSubview(subtitleName)
//        axis = .vertical
//        alignment = .center
//        translatesAutoresizingMaskIntoConstraints = false
//      
//    }
//    
//
//}
//
//
