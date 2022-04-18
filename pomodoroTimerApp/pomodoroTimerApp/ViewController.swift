//
//  ViewController.swift
//  pomodoroTimerApp
//
//  Created by 양준식 on 2022/04/18.
//

import UIKit
import AudioToolbox

enum TimerStatus{
    case start
    case pause
    case end
}

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    //시작 시점의 총 시간 값
    var duration = 60
    //초기 상태는 .end로
    var timerStatus: TimerStatus = .end
    
    var timer: DispatchSourceTimer?
    //현재 countdown되고있는 시간
    var currentSeconds = 0
    
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
    
    //
    func startTimer(){
        if self.timer == nil{
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            //.now()로 즉시 실행되도록.. 3초 뒤에 하려면 .now() + 3
            //1초마다 반복되도록
            self.timer?.schedule(deadline: .now(), repeating: 1)
            //timer 동작 시마다 실행될 내용
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                //시,분,초 구하기
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.5, delay: 0, animations:{
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                //한 번 더 회전
                UIView.animate(withDuration: 0.5, delay: 0.5, animations:{
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })
                
                debugPrint(self.currentSeconds)
                
                if self.currentSeconds <= 0{
                    self.stopTimer()
                    //소리
                    AudioServicesPlaySystemSound(1005)
                    
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer(){
        // timer를 cancel()하기 전에 resume을 하라고 공식문서에 적혀있다 .
        if self.timerStatus == .pause{
            self.timer?.resume()
        }
        self.timerStatus = .end
        //진행중인 타이머가 없어지므로 "취소"버튼은 disable
        self.cancelButton.isEnabled = false
        
//        //다시 timer와 progressView를 숨겨줌
//        self.setTimerInfoViewVisible(isHidden: true)
//        //다시 datePicker는 보이도록
//        self.datePicker.isHidden = false
        UIView.animate(withDuration: 0.5, animations:{
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        })
        self.startButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
        
        switch self.timerStatus{
        case .start, .pause:
            
            self.stopTimer()
            
            
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
            self.currentSeconds = self.duration
            self.timerStatus = .start // 시작되었음 count가
//            self.setTimerInfoViewVisible(isHidden: false) // 나타나야하니까 isHidden은 false
//            self.datePicker.isHidden = true
            UIView.animate(withDuration: 0.5, animations:{
                self.timerLabel.alpha = 1
                self.progressView.alpha = 1
                self.datePicker.alpha = 0
            })
            self.startButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
            
            //진행 상태에서는 일시정지로
        case .start:
            self.timerStatus = .pause
            //다시 "시작" title을 갖게되도록 변경
            self.startButton.isSelected = false
            //일시정지
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.startButton.isSelected = true
            self.timer?.resume()
        }
    }
}

