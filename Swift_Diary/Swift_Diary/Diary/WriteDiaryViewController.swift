//
//  WriteDiaryViewController.swift
//  Swift_Diary
//
//  Created by 양준식 on 2022/03/26.
//

import UIKit

enum DiaryEditMode{
    case new
    case edit(IndexPath, Diary)
}

class WriteDiaryViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    //등록버튼
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    //DatePicker 에서 선택하여 diaryDate에 Date저장
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    // DiaryViewController의 diaryList에 저장할 권한 위임받음
    weak var delegate: WriteDiaryViewDelegate?
    var diaryEditMode: DiaryEditMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureContentsTextView()
        self.configureDatePicker()
        self.configureInputField()
        self.configureEditMode()
        //제목,내용, 날짜 모두 입력해야 활성화시킬 수 있도록
        self.confirmButton.isEnabled = false
    }
    
    //textView 모서리 색 설정
    //textField는 기본적으로 border가 적용. textView는 따로 설정해줘야함
    private func configureContentsTextView(){
        //모두 0~1사이의 값을 넣어줘야한다.
        let borderColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        // layer관련 color는 UIcolor가 아닌 cgColor로 설정해줘야함 따라서 cgColor 프로퍼티 사용
        self.contentsTextView.layer.borderColor = borderColor.cgColor
        self.contentsTextView.layer.borderWidth = 0.8
        //모서리 둥글게
        self.contentsTextView.layer.cornerRadius = 5.0
        self.titleTextField.layer.borderColor = borderColor.cgColor
        self.titleTextField.layer.borderWidth = 0.8
        self.titleTextField.layer.cornerRadius = 5.0
        self.dateTextField.layer.borderColor = borderColor.cgColor
        self.dateTextField.layer.borderWidth = 0.8
        self.dateTextField.layer.cornerRadius = 5.0
    }
    //DatePicker관련 설정
    private func configureDatePicker(){
        //날짜만 나오게 ( 시간 제외 )
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        //for에는 어떤 event가 일어났을 때 action에 정의한 메서드를 호출할 것인지
        // 첫 번째 parameter에는 target
        self.datePicker.addTarget(
            self,
            action: #selector(datePickerValueDidChange(_:)),
            for: .valueChanged
        )
        //연-월-일 순으로 + 한글
        self.datePicker.locale = Locale(identifier: "ko-KR")
        //dateTextField를 눌렀을 때, keyboard가 아닌 datePicker가 나오게 된다!
        self.dateTextField.inputView = self.datePicker
    }
    //datePicker 선택값이 달라지면 호출될 메서드
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.dateTextField.sendActions(for: .editingChanged)
    }
    private func configureInputField(){
        self.contentsTextView.delegate = self
        //입력된 text에  변화가 있을 때마다 등록버튼 활성화 여부 확인
        self.titleTextField.addTarget(
            self,
            action: #selector(titleTextFieldDidChange(_:)),
            for: .editingChanged
        )
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.dateTextField.addTarget(
            self,
            action: #selector(dateTextFieldDidChange(_:)),
            for: .editingChanged
        )
    }
    @objc private func titleTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField){
        self.validateInputField()
    }
    //제목, 내용,날짜 모두 작성이 되어있는지 확인 , 등록버튼 활성화
    private func validateInputField(){
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !self.contentsTextView.text.isEmpty
    }
    private func configureEditMode(){
        switch self.diaryEditMode {
            //받아온 diary 내용들을 일단 화면에 뿌리고, 수정할 수 있게 해야한다
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(diary.date)
            self.diaryDate = diary.date
            self.confirmButton.title = "수정"
        default:
            break
        }
    }
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    // 등록 버튼 눌렀을 때, diary객체 생성, 메서드 파라미터에 생성된 다이어리 객체를 생성
    // edit모드일 때는 "수정"버튼
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        //만약, 날짜를 선택한 것이 아니라 textField에 임의로 글자를 적었다면, diaryDate에 아무 값이 없을 것이기 때문에 return될 것이다!!
        guard let date = self.diaryDate else { return }
        
        switch self.diaryEditMode{
        // 새로이 일기를 등록하는 경우
        case .new:
            let diary = Diary(uuid: UUID().uuidString, title: title, contents: contents, date: date, isStar: false)
            //위임받은 권한으로 diary 신규 등록
            self.delegate?.didSelectRegister(diary: diary)
            
        case let .edit(indexPath, diary):
            // 이 부분으로 "수정"할 떄는 isStar가 유지되도록 해결
            let diary = Diary(uuid: diary.uuid, title: title, contents: contents, date: date, isStar: diary.isStar)
            NotificationCenter.default.post(
                name: NSNotification.Name("editDiary"),
                // 방금 만든 새로운 diary를 보내줌
                object: diary,
                userInfo: nil
            )
        }
        //이전 화면으로 이동 
        self.navigationController?.popViewController(animated: true)
    }
    //빈 화면을 누르면 DatePicker/ 키보드 사라지도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}

//UITextViewDelegate 프로토콜
extension WriteDiaryViewController: UITextViewDelegate{
    // 입력이 바뀔 때마다 체크하여 등록버튼 활성화 여부 변경
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
