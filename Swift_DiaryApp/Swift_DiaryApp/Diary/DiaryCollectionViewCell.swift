//
//  DiaryCollectionViewCell.swift
//  Swift_DiaryApp
//
//  Created by 양준식 on 2022/05/23.
//

import UIKit
import SnapKit
class DiaryCollectionViewCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
  
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
//    private lazy var starButton: UIButton = {
//        let button = UIButton()
//
//        return button
//    }()
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        //지정해준 dateFormat대로 string을 반환
        return formatter.string(from: date)
    }
    
    func setup(with diary: Diary){
        setupLayouts()
        self.titleLabel.text = diary.title
        self.dateLabel.text = dateToString(diary.date)
    }
    
    func setupLayouts(){
        self.contentView.layer.cornerRadius = 13.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemMint.cgColor
        [titleLabel, dateLabel].forEach{
           addSubview($0)
        }
//        let starButtonWidth: CGFloat = 24.0
//        starButton.snp.makeConstraints{
//            $0.top.equalToSuperview().inset(6.0)
//            $0.right.equalToSuperview().inset(6.0)
//            $0.width.height.equalTo(starButtonWidth)
//        }
        titleLabel.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview().inset(12.0)
            $0.height.equalTo(140.0)
        }
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(12.0)
        }
    }
}
