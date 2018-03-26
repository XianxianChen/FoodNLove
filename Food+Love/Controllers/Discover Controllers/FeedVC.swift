//
//  MainFeedViewController.swift
//  Food+Love
//
//  Created by Gloria Washington on 3/21/18.
//  Copyright © 2018 Gloria Washington. All rights reserved.
//


import UIKit
import Parchment
import Firebase


class FeedVC: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let discoverVC = UIViewController.storyboardInstance(storyboardName: "Discover", viewControllerIdentifiier: "DiscoverVC")
		let admirersVC = UIViewController.storyboardInstance(storyboardName: "Discover", viewControllerIdentifiier: "AdmirersVC")
		let pagingViewController = FixedPagingViewController(viewControllers: [discoverVC, admirersVC])
		addChildViewController(pagingViewController)
		view.addSubview(pagingViewController.view)
		pagingViewController.didMove(toParentViewController: self)
		pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			pagingViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			pagingViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			pagingViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			pagingViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
		])

		pagingViewController.menuBackgroundColor = #colorLiteral(red: 0.2349999994, green: 0.2349999994, blue: 0.2349999994, alpha: 1)
		pagingViewController.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.2349999994, blue: 0.2349999994, alpha: 1)
		pagingViewController.selectedBackgroundColor = #colorLiteral(red: 0.2349999994, green: 0.2349999994, blue: 0.2349999994, alpha: 1)
		pagingViewController.indicatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		pagingViewController.selectedTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		pagingViewController.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
	}


}


