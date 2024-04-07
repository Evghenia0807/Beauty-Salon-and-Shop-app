
//  ButtonWithShadow.swift
//  NON
//
//  Created by Evghenia Nedbailova on 29/12/2023.


import UIKit

class ButtonWithShadow: UIView {


    let selfLabel = UILabel()
    let conteinerForLabel = UIView()
    let gradientLayer = CAGradientLayer()

    required init?(coder: NSCoder, controller: UIViewController, goToIdentifier: String) {
        super.init(coder: coder)
    }

    init(title: String, width: Int, height: Int, titleSize: CGFloat? = nil, controller: UIViewController, goToIdentifier: String) {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)
        buttonSetup(title: title, frame: frame, titleSize: titleSize)
        self.isUserInteractionEnabled = true
        let gesture = CustomTapGestureRec(target: self, action: #selector(buttonPressed))
        gesture.numberOfTapsRequired = 1
        gesture.controllers = controller
        gesture.identifier = goToIdentifier
        self.addGestureRecognizer(gesture)
    }
    
    
   

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = conteinerForLabel.bounds
    }




    func buttonSetup(title: String, frame: CGRect, titleSize: CGFloat?) {



        layer.cornerRadius = self.frame.height / 2.5
        backgroundColor = .black.withAlphaComponent(0.5)
        self.frame = frame
        layer.borderWidth = 0.50
        layer.borderColor = Colors.mainColorPink
        dropShadow(color: Colors.mainColorPink, opacity: 0.45, radius: 7)
        self.layoutIfNeeded()
        translatesAutoresizingMaskIntoConstraints = false

       
        
        conteinerForLabel.layer.cornerRadius = self.frame.height / 2.5
        conteinerForLabel.translatesAutoresizingMaskIntoConstraints = false
        conteinerForLabel.layer.masksToBounds = true
        addSubview(conteinerForLabel)
        conteinerForLabel.topAnchor.constraint(equalTo: topAnchor, constant: self.frame.height * 0.09).isActive = true
        conteinerForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -( self.frame.height * 0.09)).isActive = true
        conteinerForLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.frame.height * 0.09).isActive = true
        conteinerForLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -( self.frame.height * 0.09)).isActive = true
        
        
       
        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]


        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        conteinerForLabel.layer.insertSublayer(gradientLayer, at: 0)


        selfLabel.text = title
        selfLabel.textColor = UIColor(cgColor: Colors.subtitleColorPink)
        selfLabel.font = selfLabel.font.withSize(titleSize ?? (self.frame.height * 0.25))
        selfLabel.textAlignment = .center
        selfLabel.numberOfLines = 0
        selfLabel.translatesAutoresizingMaskIntoConstraints = false
        conteinerForLabel.addSubview(selfLabel)
        selfLabel.topAnchor.constraint(equalTo: conteinerForLabel.topAnchor).isActive = true
        selfLabel.bottomAnchor.constraint(equalTo: conteinerForLabel.bottomAnchor).isActive = true
        selfLabel.leadingAnchor.constraint(equalTo: conteinerForLabel.leadingAnchor).isActive = true
        selfLabel.trailingAnchor.constraint(equalTo: conteinerForLabel.trailingAnchor).isActive = true

    }


    @objc func buttonPressed(sender: CustomTapGestureRec){

        gradientLayer.colors = [#colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]
        sender.controllers!.performSegue(withIdentifier: sender.identifier!, sender: nil)
    }


}


//gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]


//gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//gradientLayer.endPoint = CGPoint(x: 1, y: 1)







//import UIKit
//
//class ButtonWithShadow: UIView {
//
//   
//    let selfLabel = UILabel()
//    
//    required init?(coder: NSCoder, controller: UIViewController, goToIdentifier: String) {
//        super.init(coder: coder)
//    }
//    
//    init(title: String, width: Int, height: Int, titleSize: CGFloat? = nil, controller: UIViewController, goToIdentifier: String) {
//        let frame = CGRect(x: 0, y: 0, width: width, height: height)
//        super.init(frame: frame)
//        buttonSetup(title: title, frame: frame, titleSize: titleSize)
//        self.isUserInteractionEnabled = true
//        let gesture = CustomTapGestureRec(target: self, action: #selector(buttonPressed))
//        gesture.numberOfTapsRequired = 1
//        gesture.controllers = controller
//        gesture.identifier = goToIdentifier
//        self.addGestureRecognizer(gesture)
//        
//
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//
//
//    func buttonSetup(title: String, frame: CGRect, titleSize: CGFloat?) {
//        
//        
//        
//        layer.cornerRadius = self.frame.height / 2.5
//        backgroundColor = .black.withAlphaComponent(0.5)
//        self.frame = frame
//        layer.borderWidth = 0.20
//        layer.borderColor = Colors.mainColorPink
//        dropShadow()
//        translatesAutoresizingMaskIntoConstraints = false
//        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
//        heightAnchor.constraint(equalToConstant: frame.height).isActive = true
//        
//        let conteinerForLabel = UIView()
//        conteinerForLabel.backgroundColor = .black
//        conteinerForLabel.layer.cornerRadius = self.frame.height / 2.5
//        conteinerForLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(conteinerForLabel)
//        conteinerForLabel.topAnchor.constraint(equalTo: topAnchor, constant: self.frame.height * 0.09).isActive = true
//        conteinerForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -( self.frame.height * 0.09)).isActive = true
//        conteinerForLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.frame.height * 0.09).isActive = true
//        conteinerForLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -( self.frame.height * 0.09)).isActive = true
//        
//        
//        selfLabel.text = title
//        selfLabel.textColor = UIColor(cgColor: Colors.mainColorPink).withAlphaComponent(0.90)
//        selfLabel.font = selfLabel.font.withSize(titleSize ?? (self.frame.height * 0.25))
//        selfLabel.textAlignment = .center
//        selfLabel.translatesAutoresizingMaskIntoConstraints = false
//        conteinerForLabel.addSubview(selfLabel)
//        selfLabel.topAnchor.constraint(equalTo: conteinerForLabel.topAnchor).isActive = true
//        selfLabel.bottomAnchor.constraint(equalTo: conteinerForLabel.bottomAnchor).isActive = true
//        selfLabel.leadingAnchor.constraint(equalTo: conteinerForLabel.leadingAnchor).isActive = true
//        selfLabel.trailingAnchor.constraint(equalTo: conteinerForLabel.trailingAnchor).isActive = true
//        
//    }
//    
//    func lightUp(){
//        layer.shadowOpacity = (0.35 * 2)
//        layer.shadowRadius = (frame.width + frame.height) * 15 / 100
//        selfLabel.font = selfLabel.font.withSize(self.frame.height * 0.35)
//    }
//    
//    
//    @objc func buttonPressed(sender: CustomTapGestureRec){
//        
//        lightUp()
//        sender.controllers!.performSegue(withIdentifier: sender.identifier!, sender: nil)
//     
//        
//    }
//    
//    
//}
//
//
