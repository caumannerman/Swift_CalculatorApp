//
//  WriteDiaryViewController.swift
//  Swift_DiaryApp
//
//  Created by 양준식 on 2022/05/23.
//

import UIKit
import SnapKit

enum DiaryEditMode{
    case new
    case edit(IndexPath, Diary)
}


class WriteDiaryViewController: UIViewController {
    //text입력 창들의 색
    private let borderColor = UIColor(red: 120/255, green: 220/255, blue: 210/255, alpha: 1.0)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = borderColor.cgColor
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 5.0
        return textView
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return label
    }()
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()

    //DatePicker 에서 선택하여 diaryDate에 Date저장
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    
    // DiaryViewController의 diaryList에 저장할 권한 위임받음
    weak var delegate: WriteDiaryDelegate?
    var diaryEditMode: DiaryEditMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupDatePicker()
        setupLayout()
        setupEditMode()
    }
    //빈 화면을 누르면 DatePicker/ 키보드 사라지도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // 등록 버튼 눌렀을 때, diary객체 생성, 메서드 파라미터에 생성된 다이어리 객체를 생성
    // edit모드일 때는 "수정"버튼
    @objc func didTapConfirmButton(){
        guard let title = self.titleTextField.text else { return }
        guard let contents = self.contentsTextView.text else { return }
        //만약, 날짜를 선택한 것이 아니라 textField에 임의로 글자를 적었다면, diaryDate에 아무 값이 없을 것이기 때문에 return될 것이다!!
        guard let date: Date = self.diaryDate else { return }
        
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


}

private extension WriteDiaryViewController {
    func setupNavigation(){
        self.navigationController?.title = "일기 작성"
        let rightBarButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(didTapConfirmButton))
        rightBarButton.title = "등록"
        switch self.diaryEditMode {
            case .edit:
                rightBarButton.title = "수정"
            default:
                break
        }
            
        navigationItem.rightBarButtonItem = rightBarButton
    }
    func setupDatePicker(){
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
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker){
        //날짜, text를 반환해주는 역할
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        // 다른 날짜를 선택해도,키보드로 텍스트를 입력받은 것이 아니기 때문에 dateTextFieldDidChange가 #selector에서 정상적으로 호출되지 않는다. 따라서 pick한 날짜가 변하면, .editingChanged 이벤트를 인위적으로 발생시켜준다.
        self.dateTextField.sendActions(for: .editingChanged)
    }
    func setupEditMode(){
        switch self.diaryEditMode {
            //받아온 diary 내용들을 일단 화면에 뿌리고, 수정할 수 있게 해야한다
        case let .edit(_, diary):
            self.titleTextField.text = diary.title
            self.contentsTextView.text = diary.contents
            self.dateTextField.text = self.dateToString(diary.date)
            self.diaryDate = diary.date
        default:
            break
        }
    }
    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    func setupLayout(){
        [titleLabel, titleTextField, contentsLabel, contentsTextView, dateLabel, dateTextField].forEach{
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
        titleTextField.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(34.0)
        }
        contentsLabel.snp.makeConstraints{
            $0.top.equalTo(titleTextField.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
        contentsTextView.snp.makeConstraints{
            $0.top.equalTo(contentsLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(100)
        }
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(contentsTextView.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
        dateTextField.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(34.0)
        }
    }
}

