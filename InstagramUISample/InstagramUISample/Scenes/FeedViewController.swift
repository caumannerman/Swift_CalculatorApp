//
//  FeedViewController.swift
//  InstagramUISample
//
//  Created by 양준식 on 2022/04/04.
//

import UIKit
import SnapKit


class FeedViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        setupNavigationBar()
        setupTableView()
    }


}

extension FeedViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        
        return cell
    }
    
}

private extension FeedViewController{
    
    func setupNavigationBar(){
        
        navigationItem.title = "InstagRAM"
        
        let uploadButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.app"),
            style: .plain,
            target: self,
            action: nil)
        
        navigationItem.rightBarButtonItem = uploadButton
        
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview()}
    }
}
