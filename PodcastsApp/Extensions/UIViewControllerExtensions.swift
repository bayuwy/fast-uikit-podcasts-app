//
//  UIViewControllerExtensions.swift
//  PodcastsApp
//
//  Created by Bayu Yasaputro on 20/12/22.
//

import UIKit


// MARK: - Pop & Dismiss
extension UIViewController {
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - RegisterViewController

extension UIViewController {
    func showRegisterViewController(customValue: String = "SIGN UP") {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "register") as! RegisterViewController
        viewController.customValue = customValue
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - MainViewController

extension UIViewController {
    func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "main")
        
        let window: UIWindow?
        if #available(iOS 15.0, *) {
            window = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first
        }
        else {
            window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        }
        window?.rootViewController = viewController
    }
}
