//
//  DiaryDetailViewController.swift
//  Swift_Diary
//
//  Created by 양준식 on 2022/03/26.
//

import UIKit



class DiaryDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    //weak var delegate: DiaryDeltailViewDelegate?
    var starButton: UIBarButtonItem?
    
    //일기 목록 viewController에서, didSelectItemAt 메서드를 override하며,
    // 선택한 IndexPath와 그 위치의 diary를 받아왔다.
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(starDiaryNotification(_:)),
            name: NSNotification.Name("starDiary"),
            object: nil)
    }
    //즐겨찾기 목록을 통해 들어왔든, 일기장 목록을 통해 들어왔든, 즐겨찾기 여부를 toggle하면, 양 쪽 화면의 sync를 맞춰주기 위해
    // view를 다시 그려준다.
    @objc func starDiaryNotification(_ notification: Notification){
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let uuid = starDiary["uuid"] as? String else { return }
        guard let diary = self.diary else {return }
        if diary.uuid == uuid{
            self.diary?.isStar = isStar
            self.configureView()
        }
    }
    
    private func configureView(){
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(diary.date)
        // diary의 즐겨찾기 여부에 따라 star이미지를 rightBarButton으로 등록 할지 말지 결정
        self.starButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(tapStarButton))
        self.starButton?.image = diary.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        self.starButton?.tintColor = .cyan
        self.navigationItem.rightBarButtonItem = self.starButton
    }
    
    @objc func tapStarButton(){
        guard let isStar = self.diary?.isStar else { return }
        if isStar {
            self.starButton?.image = UIImage(systemName:  "star")
        } else{
            self.starButton?.image = UIImage(systemName:  "star.fill")
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
    @IBAction func tapEditButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteDiaryViewController") as? WriteDiaryViewController else {return}
        guard let indexPath = self.indexPath else { return }
        guard let diary = self.diary else { return }
        // 현재 수정중인 것들을 전달해줌 
        viewController.diaryEditMode = .edit(indexPath, diary)
        
        // "editDiary"라는 이름의 event를 기다리다가, Notification Center에 해당 event가 들어오게 되면
        // selector에 넣어준 editDiaryNotification함수를 실행시킨다.
        
        //tapEditButton() 안에 있는 이유? -> 글을 수정하러 갈 때만 이것이 필요하기 때문.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(editDiaryNotification(_:)),
            name: NSNotification.Name("editDiary"),
            object: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    // WriteDiaryViewController에서 수정완료한 내용을 현재 페이지에 나타내주는 함수
    @objc func editDiaryNotification(_ notification: Notification){
        guard let diary = notification.object as? Diary else { return }
        //수정된 내용으로 화면을 다시 그려줌
        self.diary = diary
        self.configureView()
    }
    
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        //상세화면으로 올 때 넘겨받은 IndexPath
        guard let uuid = self.diary?.uuid else { return }
        //삭제하고 목록화면으로 돌아간다.
//        self.delegate?.didSelectDelete(indexPath: indexPath)
        // 일기 목록에서 detail로 왔을 때, 즐겨찾기 목록에서 detail로 왔을 때 모두 똑같이 삭제 연산을 수행해야한다
        //일기목록, 즐겨찾기 목록 두 viewController에서 각각 protocol을 만들어주고 여기서 사용하면
        // self.delegate1?.tapDelete~~;  self.delegate2?.tapDelete~~ 해도 되지만,
        // NotificationCenter를 사용해 한 번에 처리하는 것이 효율적이다!!
        NotificationCenter.default.post(
            name: NSNotification.Name("deleteDiary"),
            object: uuid,
            userInfo: nil
        )
        self.navigationController?.popViewController(animated: true)
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
