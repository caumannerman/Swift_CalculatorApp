//
//  ViewController.swift
//  TodoList
//
//  Created by 양준식 on 2022/03/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem?
    
    // 할 일 목록 저장할 Task 배열 
    var tasks = [Task]() {
        didSet {
            //할 일 목록에 추가/제거 혹은 완료 체크를 할 때마다 새롭게 UserDefaults에 저장됨
            self.saveTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector( doneButtonTap))//
        self.tableView.dataSource = self
        self.tableView.delegate = self
        //저장된 할 일들 불러옴
        self.loadTasks()
        // Do any additional setup after loading the view.
    }
// selector에 넘겨줘야하기 때문에 @objc를 붙여줘야함
    @objc func doneButtonTap(){
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
    }

    @IBAction func tabEditButton(_ sender: UIBarButtonItem) {
        //비어있다면 edit할 필요가 없기에 체크
        guard !self.tasks.isEmpty else { return }
        self.navigationItem.leftBarButtonItem = self.doneButton
        //기본 tableView의 메서드 true를 넘겨주면 edit모드가 됨
        self.tableView.setEditing(true, animated: true)
    }
    
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        //alert 해주는 함수 구현
        //preferredStyle: .alert -> 일반적으로 알고있는 모달 형태 /  .actoinSheet -> 아래서 올라옴
        // UIAlertController가 띄워지는 Alert 객체임
        
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        
        //버튼(Action을 위한)을 UIAlertAction객체로 생성 , 해당 버튼을 누르면 일어날 기능을 handler에 클로저로 넣어줌/ 아무 일도 안 일어날거면 nil
        let registerButton = UIAlertAction( title: "등록", style: .default, handler: { [weak self] _ in
            debugPrint("\( alert.textFields?[0].text )")
            
            //textFields는  title, message처럼 UIAlertController가 갖고있는 perperty임 ( UITextField의 배열)
            //여기서는 UITextField에 입력된 값이 있다면 tasks 배열에 추가하는 것
            guard let title = alert.textFields?[0].text else { return }
            //사용자가 입력하고 추가한 내용을 토대로  Task 구조체 인스턴스를 만든다
            let task = Task(title: title, done: false)
            // 뷰 컨트롤러가 갖고있는 tasks배열에 추가하고, tableView를 갱신한다.
            self?.tasks.append(task)
            self?.tableView.reloadData()
        } )
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)// 취소 버튼 클릭 시, 별다른 것 하지 않기때문에 handelr에 nil
        
        //addAction은 최대 두개까지 된다.
        alert.addAction(cancelButton)
        alert.addAction(registerButton)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요"
        })
      
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func saveTasks() {
        //tasks에 어떤 새로운 값이 들어왔다면 이를 다시 Dictionary<String, Bool> 형태로 바꾸어, userDefalut에 "tasks"라는 키에 해당하는 value로 새롭게 전달해준다.
        let data = self.tasks.map{
            [
                "title" : $0.title,
                "done": $0.done
            ]
        }
        //.standard는 공유된 기본값 객체를 반환해준다. 즉 접근하는 과정이라고 생각하면 됨
        let userDefaults = UserDefaults.standard
        // key-value 쌍으로 우리가 갖고있는 tasks 배열을 dictionary로 바꾼 data를 저장
        userDefaults.set( data, forKey: "tasks")
    }
    
    func loadTasks() {
        //UserDefaults에 접근
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        //배열형태로 가져오기
        self.tasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
    
}
//가독성을 위해 UITableViewDataSource프로토콜 관련 내용만 빼서 구현
extension ViewController: UITableViewDataSource{
    // 각 섹션에 표시할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용 식별자 indexPath위치에 cell을 재사용하기 위해 넘겨줌
        //indexPath는 tableView에서 cell위치를 나타내는 인덱스임. section과 row로 접근한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath)
        //위에서 우리는 하나의 section에 모든 tasks를 다 넣어줬으므로, indexPath.row만으로 접근할 수 있는 것.
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        //accessoryType으로 완료 여부 표시
        if task.done{
            cell.accessoryType = .checkmark
        } else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    //편집모드에서 삭제버튼 클릭시, 어떤 셀인지 알려주는 메서드
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        //tasks와 tableView가 동일한 상태가 되도록
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        //아래와 같이 reloadData()를 해줘도 된다! ( 비효율적이겠지만 )
        //tableView.reloadData()
        
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    }
    
    //할 일 순서 변경
    
    // 얘는 선언만 해줘도 됨
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //행의 원래 위치, 어디로 이동했는지 두개의 index 알려줌 
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        //원래 위치 값 삭제
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
    
    
}

extension ViewController: UITableViewDelegate {
    //셀을 선택했을 때, 어떤 셀이 선택되었는지 알려주는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexPath.row로 해당 셀에 접근
        var task = self.tasks[indexPath.row]
        task.done = !task.done
        self.tasks[indexPath.row] = task
        // at에 넣어준 cell들만 갱신할 수 있음
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
