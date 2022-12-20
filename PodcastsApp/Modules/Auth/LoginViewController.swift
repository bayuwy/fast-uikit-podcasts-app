//
//  LoginViewController.swift
//  PodcastApp
//
//  Created by Bayu Yasaputro on 16/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Helpers
    
    func setup() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        
        let attText: NSMutableAttributedString = NSMutableAttributedString(
            string: "SIGN",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 36, weight: .bold)
            ]
        )
        attText.append(
            NSAttributedString(
                string: " IN",
                attributes: [
                    .foregroundColor: UIColor(rgb: 0xFF0000), //UIColor(red: 203/255, green: 251/255, blue: 94/255, alpha: 1),
                    .font: UIFont.systemFont(ofSize: 36, weight: .bold)
                ]
            )
        )
        titleLabel.attributedText = attText
        
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        )
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ]
        )
        
        signInButton.layer.cornerRadius = 4
        signInButton.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    
    @IBAction func eyeButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        showRegisterViewController(customValue: "REGISTER")
    }
}
