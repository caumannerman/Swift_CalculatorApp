//
//  ViewController.swift
//  pomodoroTimerApp
//
//  Created by 양준식 on 2022/04/18.
//

import UIKit

enum TimerStatus{
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    var duration = 60
    //초기 상태는 .end로
    var timerStatus: TimerStatus = .end
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStartButton()
        
    }
    
    //시작 / 일시정지 등 상태에 따라 hidden여부 변경
    func setTimerInfoViewVisible(isHidden: Bool){
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    //버튼 title 변경 등
    func configureStartButton(){
        self.startButton.setTitle("시작", for: .normal)
        self.startButton.setTitle("일시정지", for: .selected)
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
        
        switch self.timerStatus{
        case .start, .pause:
            self.timerStatus = .end
            //진행중인 타이머가 없어지므로 "취소"버튼은 disable
            self.cancelButton.isEnabled = false
            //다시 timer와 progressView를 숨겨줌
            self.setTimerInfoViewVisible(isHidden: true)
            //다시 datePicker는 보이도록
            self.datePicker.isHidden = false
            self.startButton.isSelected = false
        default:
            break
            
        }
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        //설정한 시간을 "초 단위" 로 가져올 수 있음
        self.duration = Int(self.datePicker.countDownDuration)
        debugPrint(self.duration)
        
        //시작 버튼 누르면 이제 시작이 될테니,
        switch self.timerStatus{
        case .end:
            self.timerStatus = .start // 시작되었음 count가
            self.setTimerInfoViewVisible(isHidden: false) // 나타나야하니까 isHidden은 false
            self.datePicker.isHidden = true
            self.startButton.isSelected = true
            self.cancelButton.isEnabled = true
            
            //진행 상태에서는 일시정지로
        case .start:
            self.timerStatus = .pause
            //다시 "시작" title을 갖게되도록 변경
            self.startButton.isSelected = false
            
        case .pause:
            self.timerStatus = .start
            self.startButton.isSelected = true
        }
    }
}

