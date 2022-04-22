//
//  CovidDetailTableViewController.swift
//  COVID19BoardApp
//
//  Created by 양준식 on 2022/04/22.
//

import UIKit
import Charts

class CovidDetailTableViewController: UITableViewController {

    let labelNameList: [String] = ["신규 확진자", "확진자", "완치자", "사망자", "발생률", "해외유입 신규 확진자", "지역발생 신규 확진자"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CovidDetailTableViewCell.self, forCellReuseIdentifier: "CovidDetailTableViewCell")
        //tableView.rowHeight = 150
    }


}

extension CovidDetailTableViewController{
    // 7개의 정적인 메뉴만 필요함
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CovidDetailTableViewCell", for: indexPath) as? CovidDetailTableViewCell else { return UITableViewCell()}
        
        cell.configure(title: labelNameList[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
