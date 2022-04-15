//
//  DiaryCell.swift
//  Swift_Diary
//
//  Created by 양준식 on 2022/03/26.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 13.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.systemMint.cgColor
    }
}
