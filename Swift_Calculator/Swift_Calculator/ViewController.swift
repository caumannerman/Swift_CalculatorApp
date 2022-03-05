//
//  ViewController.swift
//  Swift_Calculator
//
//  Created by 양준식 on 2022/03/01.
//

import UIKit

enum Operation {
    case Add
    case Subtract
    case Divide
    case Multiply
    case Unknown
}

class ViewController: UIViewController {

    
    @IBOutlet weak var numberOutputLabel: UILabel!
    //계산중인, 즉 가지고있는 값 말고 입력중인 보여지는 숫자를 저장할 변수
    var displayNumber: String = ""
    var firstOperand: String = ""
    var secondOperand: String = ""
    // 계산중인 값 저장할 변수
    var result: String = ""
    var currentOperation: Operation = .Unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 0~9의 숫자를 클릭했을 시 이곳에서 처리됨
    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else {
            return
        }
        //9자리 수까지 입력받고, 입력창에 띄워주는 것 까지
        if self.displayNumber.count < 9 {
            //항상 갖고있는 값, 화면에 보여지는 값 두가지 모두 함께 처리해줘야함
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    
    }
    //AC버튼 클릭 처리
    @IBAction func tapClearButton(_ sender: UIButton) {
        //"0"으로 안해주는 이유는, 새로이 숫자를 입력받아서 뒷쪽에 append해줘야하니깐...
        //즉, 사용자에게 보여주는 화면에는 0을 보여줘야하지만, 실제 갖고있는 문자열 값에는 "" 빈 문자열
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .Unknown
        self.numberOutputLabel.text = "0"
    }
    
    
    @IBAction func tapDotButton(_ sender: UIButton) {
        // 8자리 미만의 길이를 현재 가지고있고, 소숫점이 찍히지 않았어야만 소숫점을 찍을 수 있도록
        if self.displayNumber.count < 8 && !self.displayNumber.contains("."){
            // 화면 상 숫자가 0일 때, 즉, displayNumber는 ""상태일 때 "0."으로 넣어줘야함
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = displayNumber
        }
    }
    
    @IBAction func tapDivideButton(_ sender: UIButton) {
        self.operation(.Divide)
    }
    
    @IBAction func tapMultiplyButton(_ sender: UIButton) {
        self.operation(.Multiply)
    }
    
    @IBAction func tapSubtractButton(_ sender: UIButton) {
        self.operation(.Subtract)
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        self.operation(.Add)
    }
    
    @IBAction func tapEqualButton(_ sender: UIButton) {
        self.operation(self.currentOperation)
    }
    
    
    func operation(_ operation: Operation) -> Void {
        if self.currentOperation != .Unknown {
            if !self.displayNumber.isEmpty {
                self.secondOperand = self.displayNumber
                //화면에 변화는 없으나, 뒷 연산자를 입력받기 위해 비워줌
                self.displayNumber = ""
                
                // 계산을 위해 String형태의 자료들을 Double로 바꿔준다
                guard let firstOperand = Double(self.firstOperand) else { return }
                guard let secondOperand = Double(self.secondOperand) else { return }
                
                
                switch self.currentOperation {
                case .Add:
                    self.result = "\(firstOperand + secondOperand)"
                    
                case .Subtract:
                    self.result = "\(firstOperand - secondOperand)"
                case .Divide:
                    self.result = "\(firstOperand / secondOperand )"
                case .Multiply:
                    self.result = "\(firstOperand * secondOperand)"
                default:
                    break
                }
                //정수라면, 소숫점 제거
                if let result = Double(self.result), result.truncatingRemainder(dividingBy: 1) == 0 {
                    self.result = "\(Int(result))"
                }
                //다음 연산을 위해, firstOperand에 결과를 넣어주고, 화면에 표시
                self.firstOperand = self.result
                self.numberOutputLabel.text = self.result
            }
            //계산한 적이 있어서, firstOperand에서 기다리는 수가 있음을 알기 위함 
            self.currentOperation = operation
        } else { // 계산기가 초기화된 상태
            self.firstOperand = self.displayNumber
            self.currentOperation = operation
            self.displayNumber = ""
        }
        
    }
}

