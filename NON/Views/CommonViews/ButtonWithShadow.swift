
//  ButtonWithShadow.swift
//  NON
//
//  Created by Evghenia Nedbailova on 29/12/2023.


import UIKit

class ButtonWithShadow: UIView {

    var title: String
    var width: Int
    var height: Int
    var goToIdentifier: String?
    var titleSize: CGFloat?
    
    let selfLabel = UILabel()
    let containerForLabel = UIView()
    let gradientLayer = CAGradientLayer()
    
    var isActive: Bool = true {
        didSet {
            updateButtonAppearance()
        }
    }

   

    init(title: String, width: Int, height: Int, titleSize: CGFloat? = nil, goToIdentifier: String) {
        
        self.title = title
        self.width = width
        self.height = height
        self.goToIdentifier = goToIdentifier
        self.titleSize = titleSize
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        buttonSetup()
        addTapGesture()
        self.isUserInteractionEnabled = true
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = self.bounds.width * 0.1
        layer.cornerRadius = radius
        containerForLabel.layer.cornerRadius = radius
        gradientLayer.frame = containerForLabel.bounds
        dropShadow(color: Colors.mainColorPink, opacity: 0.45, radius: 7)
    }




    func buttonSetup(){
        
        backgroundColor = .black.withAlphaComponent(0.5)
        layer.borderWidth = 0.50
        layer.borderColor = Colors.mainColorPink
        self.layoutIfNeeded()
        translatesAutoresizingMaskIntoConstraints = false

       
        
        containerForLabel.translatesAutoresizingMaskIntoConstraints = false
        containerForLabel.layer.masksToBounds = true
        addSubview(containerForLabel)
        containerForLabel.topAnchor.constraint(equalTo: topAnchor, constant: self.frame.height * 0.09).isActive = true
        containerForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -( self.frame.height * 0.09)).isActive = true
        containerForLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.frame.height * 0.09).isActive = true
        containerForLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -( self.frame.height * 0.09)).isActive = true
        
        
       
        gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]


        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        containerForLabel.layer.insertSublayer(gradientLayer, at: 0)


        selfLabel.text = title
        selfLabel.textColor = UIColor(cgColor: Colors.subtitleColorPink)
        selfLabel.font = selfLabel.font.withSize(titleSize ?? (self.frame.height * 0.25))
        selfLabel.textAlignment = .center
        selfLabel.numberOfLines = 0
        selfLabel.translatesAutoresizingMaskIntoConstraints = false
        containerForLabel.addSubview(selfLabel)
        selfLabel.topAnchor.constraint(equalTo: containerForLabel.topAnchor).isActive = true
        selfLabel.bottomAnchor.constraint(equalTo: containerForLabel.bottomAnchor).isActive = true
        selfLabel.leadingAnchor.constraint(equalTo: containerForLabel.leadingAnchor).isActive = true
        selfLabel.trailingAnchor.constraint(equalTo: containerForLabel.trailingAnchor).isActive = true

        updateButtonAppearance()
    }
        
        
    func updateButtonAppearance() {
                  if isActive {
                      containerForLabel.backgroundColor = .clear
                      gradientLayer.isHidden = false
                      selfLabel.textColor = UIColor(cgColor: Colors.subtitleColorPink).withAlphaComponent(1)
                      self.isUserInteractionEnabled = true
                  } else {
                      containerForLabel.backgroundColor = .black
                      gradientLayer.isHidden = true
                      selfLabel.textColor = UIColor(cgColor: Colors.subtitleColorPink).withAlphaComponent(0.5)
                      self.isUserInteractionEnabled = false
                  }
              }

    
    func addTapGesture(){
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
        
    }
    
    
    func findVC() -> UIViewController?{
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewContoller = nextResponder as? UIViewController{
                return viewContoller
            }
            responder = nextResponder
        }
        return nil
    }


    @objc func buttonPressed(){

        gradientLayer.colors = [#colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]
        
        guard let goToIdentifier = goToIdentifier else {return}
        guard let controller = findVC() else {return}
        controller.performSegue(withIdentifier: goToIdentifier, sender: nil)
    }


}


