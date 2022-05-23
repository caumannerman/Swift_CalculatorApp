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
    //현재 countdown되고있는, 남은 시간을 의미
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureStartButton()
    }
    
    //버튼 title 변경 등
    func configureStartButton(){
        self.startButton.setTitle("시작", for: .normal)
        self.startButton.setTitle("일시정지", for: .selected)
    }
    
    //
    func startTimer(){
        if self.timer == nil{
            //우리는 Timer가 돌면서, progressView, 남은 시간 view도 업데이트 해줘야함.
            //따라서 main 스레드에서 반복될 수 있도록 설정
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            //.now()로 즉시 실행되도록.. 3초 뒤에 하려면 .now() + 3
            //1초마다 반복되도록
            self.timer?.schedule(deadline: .now(), repeating: 1)
            //timer 동작 시마다 실행될 내용
            self.timer?.setEventHandler(handler: { [weak self] in
                // *** 일시적으로 self가 strong reference가 되도록 해준다!!!
                guard let self = self else { return }
                self.currentSeconds -= 1
                //시,분,초 구하기
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                //현재 남은 시간으로 시간 라벨 업데이트
                self.timerLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                //현재 남은 시간으로 progressView 업데이트
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                //180도 회전
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
        // 즉, suspend()된 타이머에 바로 nil을 넣어주면 에러가뜬다.
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
        //메모리에서 해제!! 화면을 벗어나도 계속 동작하여 메모리 누수 발생 가능하므로
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
            //일시정지
            self.timer?.suspend()
            self.timerStatus = .pause
            //다시 "시작" title을 갖게되도록 변경
            self.startButton.isSelected = false
        // 다시 이어서 시작
        case .pause:
            self.timer?.resume()
            self.timerStatus = .start
            self.startButton.isSelected = true
        }
    }
}
