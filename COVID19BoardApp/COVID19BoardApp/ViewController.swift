//
//  ViewController.swift
//  COVID19BoardApp
//
//  Created by 양준식 on 2022/04/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private lazy var domesticTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "국내 누적 확진자"
        label.textAlignment = .center
        label.backgroundColor = .blue
        
        return label
    }()
    private lazy var newDomesticTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "국내 신규 확진자"
        label.textAlignment = .center
        label.backgroundColor = .green
        
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [domesticTitleLabel, newDomesticTitleLabel])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var domesticInfectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "2512"
        label.backgroundColor = .red
        
        return label
    }()
    
   
    
    private lazy var newDomesticInfectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "90"
        label.backgroundColor = .yellow
        
        return label
    }()
    
    private lazy var pieChartView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubView()
       
    }


}

extension ViewController{
    func setupSubView(){
        [titleStackView, domesticInfectionLabel, newDomesticInfectionLabel, pieChartView].forEach{
            view.addSubview($0)
        }
        
        titleStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.trailing.equalToSuperview().inset(12.0)
        }
        
        
        
        domesticInfectionLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(12.0)
            $0.centerX.equalTo(domesticTitleLabel.snp.centerX)
        }
        
        
        newDomesticInfectionLabel.snp.makeConstraints{
            $0.top.equalTo(titleStackView.snp.bottom).offset(12.0)
            $0.centerX.equalTo(newDomesticTitleLabel.snp.centerX)
        }
        
        pieChartView.snp.makeConstraints{
            $0.top.equalTo(newDomesticInfectionLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(12.0)
        }
    }
}
