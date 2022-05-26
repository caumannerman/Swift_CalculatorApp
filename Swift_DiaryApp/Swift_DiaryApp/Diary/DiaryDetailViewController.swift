//
//  DiaryDetailViewController.swift
//  Swift_DiaryApp
//
//  Created by 양준식 on 2022/05/23.
//

import UIKit

final class DiaryDetailViewController: UIViewController {
    private var diary: Diary?
    private var indexPath: IndexPath?
    
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
        textField.font = .systemFont(ofSize: 14.0, weight: .medium)
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
        
        textView.font = .systemFont(ofSize: 14.0, weight: .medium)
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
        textField.font = .systemFont(ofSize: 14.0, weight: .medium)
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5.0
        return textField
    }()
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        button.image = self.diary!.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        button.tintColor = .cyan
        return button
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.cyan.cgColor
        
        //button.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.red, for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.red.cgColor
       // button.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapStarButton(){
        guard let isStar = self.diary?.isStar else { return }
        if isStar {
            self.starButton.image = UIImage(systemName:  "star")
        } else{
            self.starButton.image = UIImage(systemName:  "star.fill")
        }
        // 반대로 저장
        self.diary?.isStar = !isStar
        // 일반 일기장 목록에서 Detail
        //self.delegate?.didSelectStar(indexPath: indexPath, isStar: self.diary?.isStar ?? false)
        // 일기 목록에서 detail로 왔을 때, 즐겨찾기 목록에서 detail로 왔을 때 모두 똑같이 삭제 연산을 수행해야한다
        // 일기목록, 즐겨찾기 목록 두 viewController에서 각각 protocol을 만들어주고 여기서 사용하면
        // self.delegate1?.tapDelete~~;  self.delegate2?.tapDelete~~ 해도 되지만,
        // NotificationCenter를 사용해 한 번에 처리하는 것이 효율적이다!!
        NotificationCenter.default.post(
            name: NSNotification.Name("starDiary"),
            object: [
                "isStar": self.diary?.isStar ?? false,
                "indexPath": indexPath,
                "uuid": self.diary?.uuid
            ],
            userInfo: nil)
    }
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureView()
    }
    
    func configureDiary(_ diary: Diary, _ indexPath: IndexPath){
        self.diary = diary
        self.indexPath = indexPath
    }
    private func configureView(){
        guard let diary = self.diary else { return }
        self.titleTextField.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateTextField.text = self.dateToString(diary.date)
        // diary의 즐겨찾기 여부에 따라 star이미지를 rightBarButton으로 등록 할지 말지 결정
        
    }
}

extension DiaryDetailViewController {
    func setupLayout(){
        //수정, 삭제 버튼 StackView로 묶음
        let buttonStackView = UIStackView(arrangedSubviews: [editButton, deleteButton])
        buttonStackView.spacing = 4.0
        buttonStackView.distribution = .fillEqually
        //두 버튼 사이 간격 조정
        buttonStackView.spacing = 50
        
        [titleLabel, titleTextField, contentsLabel, contentsTextView, dateLabel, dateTextField, buttonStackView].forEach{
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
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(dateTextField.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(view.frame.width / 4)
            
        }
    }
}
