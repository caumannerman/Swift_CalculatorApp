//
//  StarViewController.swift
//  Swift_Diary
//
//  Created by 양준식 on 2022/03/26.
//

import UIKit

class StarViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 즐겨찾기 된 다이어리 리스트
    private var diaryList = [Diary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //이 친구를 viewDidLoad가 아닌 viewWillAppear에 넣어준 이유는 ?
        // viewController의 생명주기에서 ,disappear 이후, 다시 해당 viewController로 돌아오게 되면
        // viewWillAppear로부터 함수가 시작된다. 따라서 지금과 같이 disappear 이후 다시 돌아올 때
        // 새롭게 갱신되어야할 함수는 viewWillAppear에 넣어주면 된다. 
        self.loadStaredDiaryList()
    }
    
    private func configureCollectionView(){
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func loadStaredDiaryList(){
        let userDefaults = UserDefaults.standard
        // UserDafaults에는 딕셔너리 형태로 저장을 해야했었다.
        guard let data = userDefaults.object(forKey: "diaryList") as? [[String: Any]] else { return }
        // 딕셔너리형태로 저장된 데이터를 가져와 Diary타입들로 바꾸어 diaryList에 담아준다
        self.diaryList = data.compactMap {
            guard let uuid = $0["uuid"] as? String else { return nil}
            guard let title = $0["title"] as? String else { return nil}
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil}
            guard let isStar = $0["isStar"] as? Bool else { return nil}
            return Diary(uuid: uuid, title: title, contents: contents, date: date, isStar: isStar)
        }.filter({
            // 즐겨찾기 된 것만 가져옴
            $0.isStar
        }).sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    private func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension StarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StarCell", for: indexPath) as? StarCell else { return UICollectionViewCell() }
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(diary.date)
        return cell
    }
}
extension StarViewController: UICollectionViewDelegateFlowLayout{
    //cell의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        debugPrint("width = ", UIScreen.main.bounds.size.width)
        return CGSize(width: UIScreen.main.bounds.size.width - 20 , height: 80 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

