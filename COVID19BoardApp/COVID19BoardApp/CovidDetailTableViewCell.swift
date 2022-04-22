//
//  CovidDetailTableViewCell.swift
//  COVID19BoardApp
//
//  Created by 양준식 on 2022/04/22.
//

import UIKit
import SnapKit

class CovidDetailTableViewCell: UITableViewCell {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Detail", for: .normal)
        button.setTitleColor(.systemMint, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        
        return button
    }()

    //layoutSubviews 를 오버라이딩
    override func layoutSubviews() {
        super.layoutSubviews()

        
        [ titleLabel, detailButton].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(12.0)
        }
        
        detailButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12.0)
        }
    }
    
    func configure(title: String){
        titleLabel.text = title
    }

}
