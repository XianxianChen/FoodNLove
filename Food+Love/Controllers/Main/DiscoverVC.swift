//
//  DiscoverVC.swift
//  Food+Love
//
//  Created by C4Q on 3/13/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout

class DiscoverVC: UIViewController {
    let cellSpacing: CGFloat = 0.6

    @IBOutlet weak var discoverCV: UICollectionView!
    @IBOutlet var foodTagCV: UICollectionView!
    
 
    //Dummy Data
    var lover1 = Lover(id: "0001", name: "susan", email: "susan@gmail.com", profileImageUrl: "")
    var lover2 = Lover(id: "0002", name: "jeff", email: "jeff@gmail.com", profileImageUrl: "")
    var lover3 = Lover(id: "0003", name: "li", email: "li@gmail.com", profileImageUrl: "")
    var lovers = [Lover]() {
        didSet{
            discoverCV.reloadData()
        }
    }
    var foodTags = [String]() {
        didSet {
            foodTagCV.reloadData()
        }
    }

    // view lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        loadLovers()
        loadFoodTags()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDiscoverCV()
        setUpBackground()
        setUpTagCV()
    }
    

    private func setUpDiscoverCV() {
        discoverCV.dataSource = self
        discoverCV.delegate = self
        foodTagCV.dataSource = self
        foodTagCV.delegate = self
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellSpacing)
        let cellHeight = floor(screenSize.height * cellSpacing)
        
        let insetX = (view.bounds.width  - cellWidth) / 3
        let insetY = (view.bounds.height - cellHeight) / 3
        
        let layout = VegaScrollFlowLayout()
        discoverCV.collectionViewLayout = layout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        discoverCV?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    private func setUpTagCV() {
        foodTagCV.layer.cornerRadius = 45
        foodTagCV.layer.borderColor = UIColor.black.cgColor
        foodTagCV.layer.borderWidth = 0.5
    }
    
    private func setUpBackground() {

        let backgroundImage = UIImageView()
        backgroundImage.image = #imageLiteral(resourceName: "discoverBG")
        backgroundImage.contentMode = .scaleToFill
        view.addSubview(backgroundImage)
        
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = backgroundImage.frame
        blurView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.addSubview(blurView)
    }
    
    
    
    private func loadLovers() {
        //Load data here
        lovers = [lover1, lover2, lover3]
        
    }
    
    private func loadFoodTags(){
        foodTags = ["Thai", "Japanese", "Tacos"]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK - UICollectionView Extension
extension DiscoverVC: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == foodTagCV {
            return foodTags.isEmpty ? 1 : foodTags.count
        }
        return lovers.isEmpty ? 1 : lovers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == foodTagCV {
            let cell = foodTagCV.dequeueReusableCell(withReuseIdentifier: "FoodTagCell", for: indexPath) as! FoodTagCollectionViewCell
            let tag = foodTags[indexPath.row]
            cell.foodTagLabel.text = tag
            return cell
        }
        
        let cell = discoverCV.dequeueReusableCell(withReuseIdentifier: "DiscoverCell", for: indexPath) as! DiscoverCollectionViewCell
        let lover = lovers[indexPath.row]
        cell.userNameAgeLabel.text = lover.name
        return cell
    }
    

}

extension DiscoverVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == foodTagCV {
            //perform filter of discover CV here
        }
        //perform segue to profile here
//        let selectedLover = lovers[indexPath.row]
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "OtherUserProfileVC") as! OtherUserProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension DiscoverVC: UICollectionViewDelegate {
    
}
