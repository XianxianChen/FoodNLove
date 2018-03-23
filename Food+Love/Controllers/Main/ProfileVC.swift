//  ProfileVC.swift
//  Food+Love
//  Created by C4Q on 3/13/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import Firebase
import ImageIO
import FSPagerView

class ProfileVC: UIViewController {
    
    // MARK: Action Buttons
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UINavigationItem!
    @IBOutlet weak var userBioView: UIView!
    @IBOutlet weak var userOneLineBio: UILabel!
    @IBOutlet weak var userOneLineBioAnswerLab: UILabel!
    @IBOutlet weak var userLookingFoLabel: UILabel!
    @IBOutlet weak var userLookingForAnswerLab: UILabel!
    @IBOutlet weak var userFoodPreferenceCV: UICollectionView!
    @IBOutlet weak var userFavRestaurantLab: UILabel!
    @IBOutlet weak var userFavRestaurantAnswerLab: UILabel!
    @IBOutlet weak var userAgeLocationView: UIView!
    @IBOutlet weak var userAgeLocationLabel: UILabel!
    @IBOutlet weak var userTraitsCV: UICollectionView!
    @IBOutlet weak var userPageControl: FSPageControl!
    @IBOutlet weak var userPicsPagerView: FSPagerView!{
        didSet {
            self.userPicsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }


    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "Are you sure you want to Logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            do {
                try Auth.auth().signOut()
                if let welcomeController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC")  {
                    self.navigationController?.setViewControllers([welcomeController], animated: true)
                }
            }
            catch { print("Error signing out: \(error)") }
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        //TODO: Settings page
        
    }
    
    private func editLabels() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tapGesture.numberOfTapsRequired = 1
        let labels = [userOneLineBioAnswerLab, userAgeLocationLabel, userLookingForAnswerLab, userFavRestaurantAnswerLab]
        labels.forEach {
            $0?.isUserInteractionEnabled = true
            $0?.addGestureRecognizer(tapGesture)
        }
    }
    
   @objc private func labelTapped() {
//         let labels = [userOneLineBioAnswerLab, userAgeLocationLabel, userLookingForAnswerLab, userFavRestaurantAnswerLab]
//    labels.forEach {
//        $0?.isHidden = true
        //reveal text fields
    }

    
    
    // MARK: Properties
    private var currentAuthUser = Auth.auth().currentUser
    
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        //setUpPageControl()
        self.parent?.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    
    
    
    //MARK: Helper Functions
    private func configureNavBar() {
        self.navigationItem.title = "Profile"
        let uploadButton = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(uploadButtonClicked))
        self.navigationItem.leftBarButtonItem = uploadButton
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutPressed(_:)))
        self.navigationController?.navigationItem.rightBarButtonItem  = logOutButton
    }
    
    //MARK: Page Control
    private func setUpPageControl() {
        userPageControl.numberOfPages = 5
        userPageControl.setFillColor(.gray, for: .normal)
        userPageControl.setFillColor(.white, for: .selected)
    }
    //MARK: Picture Scroll View
    private func setUpPagerView() {
        userPicsPagerView.dataSource = self
        userPicsPagerView.delegate = self
        userPicsPagerView.transformer = FSPagerViewTransformer(type: .depth)
    }
    
    @objc private func uploadButtonClicked() {
        //Add alert sheet for pictures here
        let alertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let openCamera = UIAlertAction.init(title: "Take Photo", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        let openGallery = UIAlertAction(title: "Upload from Photo Library", style: .default) { [weak self] (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = false
                self?.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        alertSheet.addAction(openCamera)
        alertSheet.addAction(openGallery)
        alertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
        self.present(alertSheet, animated: true, completion: nil)
        
    }
    
    
    
    
}

extension ProfileVC: FSPagerViewDataSource, FSPagerViewDelegate {
    //MARK: Sets Up Number of Circles in Page Control
    internal func numberOfItems(in pagerView: FSPagerView) -> Int {
        //return user images count
        return 5
    }
    
    //MARK: Sets up images in scroll view
    internal func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        userPageControl.currentPage = index
        cell.imageView?.contentMode = .scaleAspectFit
        //        cell.imageView?.image = UIImage(named: images[index])
        return cell
    }
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let selectedImage: UIImage?
//        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
//            selectedImage = editedImage
//        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//            selectedImage = originalImage
//        }
//
//        if let selectImage = selectedImage {
//            let imageName = UUID().uuidString
//            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
//            if let uploadData = UIImageJPEGRepresentation(selectImage, 0.1) {
//                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
//                    if error != nil { print(error!); return }
//                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
//                       //Need path for image
//                    }
//                })
//            }
//
//        }
//        dismiss(animated: true, completion: nil)
//    }
}
}


extension ProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        textF.hidden = true
//        lbl.hidden = false
//        lbl.text = textF.text
        return true
    }
}
