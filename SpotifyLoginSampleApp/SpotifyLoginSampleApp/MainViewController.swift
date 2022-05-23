//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 양준식 on 2022/03/29.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
   
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
         환영합니다.
         \(email)님
        """
        
    }
    //로그아웃 버튼 클릭시
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        //버튼 클릭 시, 첫 화면으로 (로그인) 넘어감
        
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
                    
        
    }
}
