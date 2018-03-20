//  ProfileVC.swift
//  Food+Love
//  Created by C4Q on 3/13/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.

import UIKit
import Firebase


class ProfileVC: UIViewController {

	// MARK: Action Buttons
	@IBOutlet weak var logoutButton: UIBarButtonItem!
	@IBOutlet weak var settingsButton: UINavigationItem!


	@IBAction func logoutPressed(_ sender: UIBarButtonItem) {
		let alertView = UIAlertController(title: "Are you sure you want to Logout?", message: nil, preferredStyle: .alert)
		let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
			do {
				try Auth.auth().signOut()
				let welcomeVC = WelcomeVC()
				let welcomeNavCon = UINavigationController(rootViewController: welcomeVC)
				self.present(welcomeNavCon, animated: true)
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


	// MARK: Properties
	private var currentAuthUser = Auth.auth().currentUser


	// MARK: View Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureNavBar()
	}


	//MARK: Helper Functions
	private func configureNavBar() {
		self.navigationItem.title = "Profile"
	}



}
