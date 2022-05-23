//
//  TabBarController.swift
//  Swift_DiaryApp
//
//  Created by 양준식 on 2022/05/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let diaryViewController = UINavigationController(rootViewController: DiaryViewController())
        diaryViewController.tabBarItem = UITabBarItem(
            title: "일기장",
            image: UIImage(systemName: "folder"),
            selectedImage: UIImage(systemName: "folder.fill")
        )
        
        let starDiaryViewController = UINavigationController(rootViewController: StarDiaryViewController())
        starDiaryViewController.tabBarItem = UITabBarItem(
            title: "즐겨찾기",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        self.viewControllers = [ diaryViewController, starDiaryViewController ]
    }


}

