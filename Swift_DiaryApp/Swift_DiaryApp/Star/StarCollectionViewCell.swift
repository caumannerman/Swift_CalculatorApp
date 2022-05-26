//
//  StarCollectionViewCell.swift
//  Swift_DiaryApp
//
//  Created by 양준식 on 2022/05/23.
//

import UIKit
import SnapKit

class StarCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        label.numberOfLines = 1
        return label
    }()

    func setup(_ title: String, _ date: String){
        //받아온 title과 date로 표현 
        titleLabel.text = title
        dateLabel.text = date
        setupLayout()
        self.contentView.layer.cornerRadius = 13.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemCyan.cgColor
    }
}

private extension StarCollectionViewCell {
    func setupLayout(){
        [titleLabel, dateLabel].forEach{
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.leading.equalToSuperview().inset(12.0)
        }
        
        dateLabel.snp.makeConstraints{
            $0.bottom.leading.equalToSuperview().inset(12.0)
        }
    }
}
