//
//  CardListViewController.swift
//  CreditCardListApp
//
//  Created by 양준식 on 2022/03/29.
//

import UIKit
import Kingfisher // image URL을 사용가능하게 하기 위한 Open Source Library
import FirebaseDatabase

class CardListViewController: UITableViewController {
    var ref: DatabaseReference! // realtime database가져오는 reference값
    
    var creditCardList: [CreditCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        //즉, 따로따로 생성한 CardListCell을 이 TableView와 연결시켜주는 과정
        //빌드시 Xib가 Nib으로 바뀐다. 즉, 우리가 만들어준 ListCell  xib파일을 연결해주는 것이다.
        let nibName = UINib(nibName: "CardListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CardListCell")
        
        ref = Database.database().reference()
        
        //firebase database 가져오기
        ref.observe(.value) { snapshot in
                guard let value = snapshot.value as? [String: [String: Any]] else {return}
                
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let cardData = try JSONDecoder().decode([String: CreditCard].self, from: jsonData)
                let cardList = Array(cardData.values)
                self.creditCardList = cardList.sorted{ $0.rank < $1.rank}
                
                //tableView reload
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error JSON parsing \(error.localizedDescription)")
            }
            
            
        }
    }
    
    
    //우리는 단일 섹션 따라서 카드리스트 수 만큼 return하면 됨
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardList.count
    }
    
    //커스텀 셀, 그 셀에 전달될 데이터 지정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCell", for: indexPath) as? CardListCell else { return UITableViewCell() }
        
        cell.rankLabel.text = "\(creditCardList[indexPath.row].rank)위"
        cell.promotionLabel.text = "\(creditCardList[indexPath.row].promotionDetail.amount)만원 증정"
        cell.cardNameLabel.text = "\(creditCardList[indexPath.row].name)"
        
        let imageURL = URL(string: creditCardList[indexPath.row].cardImageURL)
        cell.cardImageView.kf.setImage(with: imageURL)
        
        
        return cell
    }
    //높이 지정 
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세 화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "CardDetailViewController") as? CardDetailViewController else {return }
        
        //선택한 cell 카드가 갖고있는 promotionDetail을 detailViewController로 전달하고, show
        detailViewController.promotionDetail = creditCardList[indexPath.row].promotionDetail
        self.show(detailViewController, sender: nil)
        
        //option1
         let cardID = creditCardList[indexPath.row].id
//        ref.child("Item\(cardID)/isSelected").setValue(true)
        
        //option2
//        ref.queryOrdered(byChild: "id").queryEqual(toValue: cardID).observe(.value){ [weak self] snapshot in
//            guard let self = self,
//                  let value = snapshot.value as? [String: [String: Any]],
//                  let key = value.keys.first else {return}
//
//
//            self.ref.child("\(key)/isSelected").setValue(true)
//        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                    let cardID = creditCardList[indexPath.row].id
            //firebase Realtime DB에서 삭제
                    ref.child("Item\(cardID)").removeValue()
            
            
        }
    }
    
}
