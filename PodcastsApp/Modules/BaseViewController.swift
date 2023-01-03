//
//  BaseViewController.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 03/01/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.sizeToFit()
    }
}
