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
    
    
    var diary: Diary?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    private func configureView(){
        guard let diary = self.diary else { return }
        self.titleLabel.text = diary.title
        self.contentsTextView.text = diary.contents
        self.dateLabel.text = self.dateToString(diary.date)
    }
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    
    @IBAction func tapEditButton(_ sender: UIButton) {
        
    }
    @IBAction func tapDeleteButton(_ sender: UIButton) {
        
    }
    
    
}
