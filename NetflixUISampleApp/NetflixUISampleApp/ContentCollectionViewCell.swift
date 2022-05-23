//
//  ContentCollectionViewCell.swift
//  NetflixUISampleApp
//
//  Created by 양준식 on 2022/03/31.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    
}
