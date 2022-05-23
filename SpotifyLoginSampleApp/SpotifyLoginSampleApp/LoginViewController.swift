//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 양준식 on 2022/03/28.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    let signInConfig = GIDConfiguration.init(clientID: "460573119879-jjjsrot52r6adn33bkn47ht8mbl18bd8.apps.googleusercontent.com")
    @IBOutlet weak var emailLoginButton: UIButton!
    
    
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
       
        
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig, presenting: self) { user, error in
            guard error == nil else {return }
        }
    }
    
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
    }
}
