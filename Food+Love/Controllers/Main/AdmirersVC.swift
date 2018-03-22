//  AdmirersVC.swift
//  Food+Love
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.


import UIKit
import VegaScrollFlowLayout

class AdmirersVC: UIViewController {
    
    @IBOutlet weak var admirerCV: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
       // setUpCollectionViewLayout()
        


	}
    
    private func loadData() {
    
    }
    
    
    func setUpCollectionViewLayout() {
        let layout = VegaScrollFlowLayout()
        admirerCV.dataSource = self
        admirerCV.delegate = self
        admirerCV.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: admirerCV.frame.width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.isPagingEnabled = false
        layout.springHardness = 200
        admirerCV.collectionViewLayout.invalidateLayout()
        
    }

}


extension AdmirersVC: UICollectionViewDataSource {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = admirerCV.dequeueReusableCell(withReuseIdentifier: "AdmirerCell", for: indexPath) as! AdmirerCollectionViewCell
        return cell
    }
    
    
    
}

extension AdmirersVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let feedStoryBoards = UIStoryboard(name: "Feed", bundle: nil)
//    
//         self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
