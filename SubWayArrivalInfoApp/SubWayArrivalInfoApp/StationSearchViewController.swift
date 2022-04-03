//
//  StationSearchViewController.swift
//  SubWayArrivalInfoApp
//
//  Created by 양준식 on 2022/04/03.
//

import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    
    private lazy tableView:

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        // UIsearchController와 그 안의 UISearchBar
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        
    }


}

