//
//  CardDetailViewController.swift
//  CreditCardListApp
//
//  Created by 양준식 on 2022/03/29.
//

import UIKit
import Lottie

class CardDetailViewController: UIViewController{
    //firebase에서 받아온 해당 프로모션에 대한 detail 정보
    var promotionDetail: PromotionDetail?
    
    // lottie-ios 오픈소스를 사용하여, 움직이는 이미지를 띄워줄 수 있게 함
    @IBOutlet weak var lottieView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var benefitConditionLabel: UILabel!
    @IBOutlet weak var benefitDetailLabel: UILabel!
    @IBOutlet weak var benefitDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = AnimationView(name: "money") // json파일 파일명
        lottieView.contentMode = .scaleAspectFit
        lottieView.addSubview(animationView)
        //만들어놓은 view의 범위대로
        animationView.frame = lottieView.bounds
        // 단순반복
        animationView.loopMode = .loop
        animationView.play()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let detail = promotionDetail else { return }
        
        titleLabel.text = """
\(detail.companyName)카드쓰면
\(detail.amount)만원 드려요
"""
        
        periodLabel.text = detail.period
        conditionLabel.text = detail.condition
        benefitConditionLabel.text = detail.benefitCondition
        benefitDetailLabel.text = detail.benefitDetail
        benefitDateLabel.text = detail.benefitDate
        
    }
    
}
