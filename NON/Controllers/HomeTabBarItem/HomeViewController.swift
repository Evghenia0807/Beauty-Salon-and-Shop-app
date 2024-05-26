//
//  HomeViewController.swift
//  NON
//
//  Created by Evghenia Nedbailova on 14/06/2023.
//

import UIKit

class HomeViewController: UIViewController {

    static let identifier = "HomeVC"
    
    @IBOutlet weak var homeCollectioView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var sliderLabel: UILabel!
    
    
    var logo = Logo(textSize: 120)
    var counter = 0
    var timer = Timer()
   
    

    var shoppingButton = ButtonWithShadow()
    var bookingButton = ButtonWithShadow()
    var voucherButton = ButtonWithShadow()


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrangeSubviews()

        counter = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        shoppingButton.gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]
        bookingButton.gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]
        voucherButton.gradientLayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.09121344239, green: 0.0176126454, blue: 0.05065562576, alpha: 0.130924048).cgColor, #colorLiteral(red: 0.1260530949, green: 0.02903844602, blue: 0.0775596872, alpha: 0.1470146937).cgColor, #colorLiteral(red: 0.1666823626, green: 0.03838055208, blue: 0.1042519435, alpha: 0.2171719784).cgColor, #colorLiteral(red: 0.3153567016, green: 0.05996914953, blue: 0.1897078753, alpha: 0.4067673842).cgColor,  #colorLiteral(red: 0.491002202, green: 0.08269806951, blue: 0.2915512919, alpha: 0.5).cgColor, #colorLiteral(red: 0.6323029399, green: 0.08555687219, blue: 0.3645603657, alpha: 0.7098768626).cgColor, #colorLiteral(red: 0.7606634498, green: 0.09257154912, blue: 0.4276409745, alpha: 0.8934706126).cgColor, #colorLiteral(red: 0.8294126391, green: 0.09603773803, blue: 0.4644299746, alpha: 1).cgColor]

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
  


    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }


    @objc func autoScroll(){

        if counter < HomeAutoSliderModel.data.count   {
            let index = IndexPath.init(row: counter, section: 0)
            homeCollectioView.scrollToItem(at:  index, at: .centeredHorizontally, animated: true)
            pageControll.currentPage = counter
            sliderLabel.text = HomeAutoSliderModel.data[counter].nameLabel
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(row: counter, section: 0)
            homeCollectioView.scrollToItem(at:  index, at: .centeredHorizontally, animated: false)
            pageControll.currentPage = counter
            sliderLabel.text = HomeAutoSliderModel.data[counter].nameLabel
            counter = 1
        }
    }


    func arrangeSubviews(){

        homeCollectioView.dataSource = self
        homeCollectioView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        homeCollectioView.collectionViewLayout = layout

        
        view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: homeCollectioView.bottomAnchor, constant: 15).isActive = true
//        logo.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 140).isActive = true

        shoppingButton = ButtonWithShadow(title: "Shopping", width: 250, height: 70, goToIdentifier: "ShoppingViewController")
        bookingButton = ButtonWithShadow(title: "Make a booking", width: 250, height: 70, goToIdentifier: "MakeABookingViewController")
        voucherButton = ButtonWithShadow(title: "Buy a Gift Voucher", width: 250, height: 70, goToIdentifier: "GiftVoucherViewController")
        arrangeButtons(array: [shoppingButton,bookingButton,voucherButton])

    }

    func arrangeButtons(array: [ButtonWithShadow]){

        
        for button in array {
            view.addSubview(button)
            button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            button.layoutIfNeeded()
        }
        array[0].topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 35).isActive = true
        array[0].widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        array[1].topAnchor.constraint(equalTo: shoppingButton.bottomAnchor, constant: shoppingButton.frame.size.height / 3).isActive = true
        array[1].widthAnchor.constraint(equalTo: array[0].widthAnchor).isActive = true
        array[1].heightAnchor.constraint(equalTo: array[0].heightAnchor).isActive = true
        array[2].topAnchor.constraint(equalTo: bookingButton.bottomAnchor, constant: shoppingButton.frame.size.height / 3).isActive = true
        array[2].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -55).isActive = true
        array[2].widthAnchor.constraint(equalTo: array[0].widthAnchor).isActive = true
        array[2].heightAnchor.constraint(equalTo: array[0].heightAnchor).isActive = true
       
    }
}






extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HomeAutoSliderModel.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath)
        let sliderImageView = cell.contentView.viewWithTag(10) as! UIImageView
        sliderImageView.image = HomeAutoSliderModel.data[indexPath.row].image
        return cell
    }
}



extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}




