//
//  RoundButton.swift
//  Swift_Calculator
//
//  Created by 양준식 on 2022/03/03.
//

import UIKit

// 변경된 설정값을 스토리보드상에서 실시간으로 확인할 수 있도록 , 즉 런타임(시뮬레이터)이 아니라 컴파일타임에 확인할 수 있다.
// 단점은 스토리보드가 버벅거린다...
//IB는 Interface Builder
@IBDesignable
class RoundButton: UIButton {
    // annotation으로 스토리보드에서도 isRound값을 변경할 수 있게 함. 즉 IB와 해당 변수가 연결되었다라는 것을 컴파일러에게 알리는 신호 @IBInspectable
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                // 정사각형 버튼이 원이 됨
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
