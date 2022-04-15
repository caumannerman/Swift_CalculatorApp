//
//  ViewController.swift
//  Swift_Diary
//
//  Created by 양준식 on 2022/03/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var diaryList = [Diary](){
        didSet{
            //새로운 등록 혹은 삭제가 일어날 때마다 userDefaults와 동기화!
            self.saveDiaryList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadDiaryList()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        //contentsView 내부 view들의 간격 조정
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
      
    }
    
    //일기 작성 화면 이동을 segueway로 하였기 때문에, prepare로 받을 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViewController = segue.destination as? WriteDiaryViewController{
            writeDiaryViewController.delegate = self
        }
    }
    
    //userDefaults에 저장할 때는 Dictionary 형태로 만들어 보냄
    private func saveDiaryList() {
        let date = self.diaryList.map{
            [
                "title": $0.title,
                "contents": $0.contents,
                "date": $0.date,
                "isStar": $0.isStar
            
            ]
        }
        //userDefaults에 저장!!
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "diaryList")
    }
    //userDefaults에서 불러올 때는 , Dictionary형태에 고차함수를 사용해서 Diary 객체의 List로 받아온다.
    //앱 첫 실행시, 이전 데이터들을 userDefualts에서 불러와야하므로!!
    private func loadDiaryList() {
        let userDefaults = UserDefaults.standard
        //object메서드는 Any타입으로 리턴해주기 때문에 타입캐스팅 해줘야함
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else {return}
        self.diaryList = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil}
            return Diary(title: title, contents: contents, date: date, isStar: isStar)
        }
        //최신순으로 정렬 되도록
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        
    }
    
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        cell.titleLabel.text = self.diaryList[indexPath.row].title
        cell.dateLabel.text = self.dateToString(diaryList[indexPath.row].date)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width) / 2 - 20, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return  }
        
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}



extension ViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        //날짜  순 정렬 
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
}

