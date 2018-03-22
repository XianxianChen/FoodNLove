//
//  OtherUserProfileVC.swift
//  Food+Love
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit
import FSPagerView

class OtherUserProfileVC: UIViewController {
    
    var visitedUser: Lover! {
        didSet{
            print(visitedUser.name!)
        }
    }
    var photos = [#imageLiteral(resourceName: "bg_cook"), #imageLiteral(resourceName: "bg_love1"), #imageLiteral(resourceName: "bg_date2"), #imageLiteral(resourceName: "bg_desert")]
    
    @IBOutlet weak var otherUserPagerView: FSPagerView! {
        didSet {
            self.otherUserPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var otherUserPagerControl: FSPageControl!
    @IBOutlet weak var ageLocationView: UIView!
    @IBOutlet weak var ageLocationLabel: UILabel!
    @IBOutlet weak var otherUserTraitCV: UICollectionView!
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var favoriteRestaurantLab: UILabel!
    @IBOutlet weak var favoriteRestaurantAnswerLab: UILabel!
    @IBOutlet weak var favoriteCuisinesCV: UICollectionView!
    @IBOutlet weak var oneLineBioLabel: UILabel!
    @IBOutlet weak var oneLineBioAnswer: UILabel!
    @IBOutlet weak var whatTheyLookForLabel: UILabel!
    @IBOutlet weak var whatTheyLookForAnswerLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setUpPagerView()
        setUpPageControl()
        setUpViews()
        
    }
    
    private func configureNavBar() {
        self.navigationItem.title = "User Name"
        let likeButton = UIBarButtonItem(title: "Like", style: .plain, target: self, action: #selector(likeButtonTapped))
        self.navigationItem.rightBarButtonItem = likeButton
        
    }
    
    
    @objc private func likeButtonTapped() {
        //Function sends like to Firebase Storage
    }
    
    //MARK: Page Control
    private func setUpPageControl() {
        otherUserPagerControl.numberOfPages = 5
        otherUserPagerControl.setFillColor(.gray, for: .normal)
        otherUserPagerControl.setFillColor(.lightGray , for: .selected)
    }
    //MARK: Picture Scroll View
    private func setUpPagerView() {
        otherUserPagerView.dataSource = self
        otherUserPagerView.delegate = self
        otherUserPagerView.transformer = FSPagerViewTransformer(type: .depth)
    }
    
    private func setUpViews() {
        let views = [ageLocationView, otherUserTraitCV, otherUserPagerView] as [UIView]
        views.forEach {
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.borderWidth = 0.5
            $0.layer.shadowColor = UIColor.lightGray.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 3)
            $0.layer.shadowRadius = 4
            $0.layer.shadowOpacity = 2
        }
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

extension OtherUserProfileVC: FSPagerViewDataSource, FSPagerViewDelegate {
  
    //MARK: Sets Up Number of Circles in Page Control
    internal func numberOfItems(in pagerView: FSPagerView) -> Int {
        //return user images count
        return photos.count
    }
    
    //MARK: Sets up images in scroll view
    internal func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let photo = photos[index]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = photo
        cell.imageView?.contentMode = .scaleAspectFit
        otherUserPagerControl.currentPage = index
        return cell
    }
    
}

