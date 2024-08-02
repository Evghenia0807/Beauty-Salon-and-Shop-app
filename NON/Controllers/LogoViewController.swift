//
//  LogoViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 19/02/2024.
//

import UIKit

class LogoViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
   
    
    
    func setup(){
        let conteiner = UIView()
        let label = UILabel()
        view.backgroundColor = .black
        label.font = UIFont(name: "Optima", size: 30)
        label.textColor = Colors.UIColorType.mainColorPink.value
        label.textAlignment = .center
        label.text = "NON"
        conteiner.addSubview(label)
        navigationItem.titleView = conteiner
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: conteiner.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: conteiner.centerYAnchor).isActive = true
        
        let backButton = UIBarButtonItem()
            backButton.title = ""
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    

}
