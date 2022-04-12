# 1. Swift_CalculatorApp

구동 영상 : https://www.youtube.com/watch?v=SQm1Ms4QGJk

SingleView 계산기 App입니다.
IOS 학습에 중점을 두었기 때문에, 자료구조시간에 배우는 Stack을 사용한 연산자 우선순위 처리까지는 구현하지 않았고, 입력되는 순서대로 계산이 되도록 구현하였다.
RoundButton 클래스를 @IBDesignable, @IBInspectable annotation으로 작성하여 속성 Inspector에서 적용할 수 있게 하였고, didSet 프로퍼티 옵저버를 사용해 UIButton의 모양을 바꿔주었다.
소숫점 연산, Clear 등 아이폰 내장 계산기와 유사하게 구현하였다.
연산자 별 계산은 enum으로 정의해놓은 연산자 case와, 연산자를 인자로 받아 switch문으로 처리하는 operation함수로 정의하였다.
@IBAction함수, @IBOutlet 변수를 storyboard와 코드 상에서 연결하는 것이 핵심이었다.
didset과 위의 두 annotation들은 버튼의 모양을 둥글게 만드는 데 사용하였다.

### 프로퍼티 옵저버 
swift가 제공하는 프로퍼티 옵저버에는 willSet, didSet 두가지가 있다.
프로퍼티 옵저버는 property의 값 변화를 관찰하고 이에 응답한다.
조건에 따라 연산 프로퍼티에 적용 가능하나, 기본적으로 저장 프로퍼티 (Stored Property)에 적용된다.
저장 프로퍼티의 값이 변화하기 직전에 willSet -> 값 변화 -> 값이 변한 직후에 didSet 이 실행된다.

<img width="400" alt="스크린샷 2022-04-12 오후 10 49 28" src="https://user-images.githubusercontent.com/75043852/162977548-9438a3d7-dd6e-4bc1-996f-5456651807dc.png">

### @IBInspectable
annotation을 달아, 스토리보드에서 @IBInspectable이 달린 변수의 값을 변경할 수 있게 함. 즉 IB와 해당 변수가 연결되었다라는 것을 컴파일러에게 알리는 신호 @IBInspectable


### @IBDesignable
변경된 설정값을 스토리보드상에서 실시간으로 확인할 수 있도록 , 즉 런타임(시뮬레이터)이 아니라 컴파일타임에 확인할 수 있다.


<p>
<img width="200" alt="스크린샷 2022-03-06 오전 1 06 39" src="https://user-images.githubusercontent.com/75043852/156891174-b8ec6761-fbe4-4c93-b51a-afb4d78d25d0.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 12 26" src="https://user-images.githubusercontent.com/75043852/156891393-3d3fa7a9-bc43-4521-9349-520413f2109f.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 12 51" src="https://user-images.githubusercontent.com/75043852/156891398-ee6627bf-78c7-48af-965a-fc429078bf96.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 13 02" src="https://user-images.githubusercontent.com/75043852/156891401-61217d85-6b98-4603-a2d8-ded7b2c5078b.png">
</p>

# 2. Swift_ToDo_List

<p>
<img width="200" alt="스크린샷 2022-03-06 오전 3 13 17" src="https://user-images.githubusercontent.com/75043852/156895377-358c1164-4e6a-421d-9c2e-0fd99968b65d.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 13 55" src="https://user-images.githubusercontent.com/75043852/156895381-c1e2a26e-60ee-42d1-ba16-9b0eef560791.png">
 </p>
 <p>
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 15" src="https://user-images.githubusercontent.com/75043852/156895382-42a3749a-55d9-4b45-b0a7-6989bbd7b1c5.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 31" src="https://user-images.githubusercontent.com/75043852/156895384-394d75ff-7432-48a2-ade8-a36a5f5a2c47.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 51" src="https://user-images.githubusercontent.com/75043852/156895385-bf7ff2ed-7a34-42b4-ab10-18dfd5136458.png">
</p>

### 2-1. UIAlertController, UIAlertAction 

##### -> UIAlertController는 UIViewController프로토콜을 따르는 open class이다. 
##### -> UIAlertAction은 title, style( .cancel, .default...), handler(클로저 형태)를 담아 생성하고, UIAlertController에 addAction하여 포함시켰다.
##### -> self.present로써 '+' 버튼이 클릭된 경우에 해당 alert가 화면에 표시되도록 하였다. 그 이후의 action은 각 UIAlertAction의 핸들러에 구현된 대로 처리된다.
##### ==> 여기서 Class Instance와 클로저 사이의 강한 순환참조로 인해 Reference count가 서로 절대 0이 되지 않아 메모리 누수가 생기는 것을 방지하기 위해 weak self 를 

### 2-2. TableView

TableView는 섹션을 이용해 행을 그룹화하여 콘텐츠를 정렬하여 볼 수 있게 해준다. 
이를 사용하기 위해서는 UITableViewDelegate, UITableViewDataSource 총 두가지 프로토콜을 구현해야한다.
UITableViewDataSource에는 섹션 수, 섹션 당 행 수, 어떤 데이터를 표시할 것인지 
UITableViewDelegate에는 행의 높이, Action등을 정할 수 있다.

#### 2-2-1. UITableViewDataSource protocol

##### -> numberOfRowsInSection : 각 섹션에 표시할 행 갯수 설정 
##### -> cellForRowAt : 특정 Cell에 대한 정보를 전달하여 Cell을 반환해주는 메서드 ( 셀을 구성할 데이터를 구성하고 해당 메서드에 전달하면, 구성한 cell이 TableView에 표시된다 )

#### 2-2-2. UITableViewDelegate protocol

##### -> ViewController가 UITableViewDelegate 프로토콜을 준수하도록 extension을 달고 didSelectRowAt메서드를 구현하여, 셀 클릭 시에 할 일 완료여부가 바뀌도록 구현하였다.

### 2-3. UserDefaults
UserDefaults는 App 시작시 사용자의 기본 데이터베이스를 키-값 쌍으로 지속적으로 저장하는 인터페이스이다. 런타임 시 개체를 사용하여 App이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽기 때문에 값이 필요할 때마다 데이터베이스를 열 필요가 없어진다.
사용자의 정보라던가 게시물의 대한 정보처럼 대용량의 데이터를 저장할 때 사용하지 않고 자동로그인 여부, 아이디 저장, 환경설정에서 설정하는 설정 데이터 값같은 단일데이터 등을 UserDefaults로 담아서 보관한다.

이곳에 할 일 목록을 저장해, 앱이 종료되고 다시 시작되어도 데이터가 남아있도록 하였다.

# 3. CreditCardListApp (신용카드 추천 앱) using Firebase RealTime Database
<p>
<img width="200" alt="3" src="https://user-images.githubusercontent.com/75043852/160754227-13101c08-2a29-4d65-9c40-bd54350e6f4e.png">
 <img width="200" alt="6" src="https://user-images.githubusercontent.com/75043852/160754502-c8d37544-3bf2-4911-a5e7-94277e789c7a.PNG">
  <img width="200" alt="7" src="https://user-images.githubusercontent.com/75043852/160754591-2113ab7d-03c0-476c-b337-6f9b787372a0.PNG">
 <img width="200" alt="4" src="https://user-images.githubusercontent.com/75043852/160754382-abeeb832-a374-4fb4-adee-6f7b0f82e8af.PNG">
 <img width="200" alt="5" src="https://user-images.githubusercontent.com/75043852/160754467-235dfec6-910e-4130-b809-004622a5af02.PNG">
</p>
<img width="400" alt="1" src="https://user-images.githubusercontent.com/75043852/160754702-cee11c76-9bd4-4a2b-95b6-fbe87ec33999.png">
<img width="400" alt="2" src="https://user-images.githubusercontent.com/75043852/160754708-fed5fbca-afd1-4098-bf28-842dd6371fed.png">



# 4. 물마시기 알림 앱 

### 4-1. UNNotificationRequest (User Notification)

##### identifier 작성해주어야 함 .(UUID 와 같은)
##### UNMutableNotificationContent - 알림에 나타날 내용들을 정의  (ex. Content.title, Content.body ... 뱃지, 소리 등 ..)
##### Trigger( 어떤 조건에서 알림을 발생시킬지 ) - Calendar(날짜 기준), TimeInterval(시간 간격으로), Location(위치 기준)..

Request들은 UNNotificationCenter에 저장되어있다가, 조건에 부합하는 순간에 Trigger

### 4-2. UserDefaults 사용 ( Notification들을 저장 )

<img width="707" alt="스크린샷 2022-03-30 오후 5 45 36" src="https://user-images.githubusercontent.com/75043852/160790624-9d1f2ad9-8179-424d-95b8-7b447b676329.png">

##### -> UserDefaults는 싱글톤 패턴으로 설계되어, 앱 전체에서 "하나의 instance"만 존재한다!
##### -> 추가: UserDefaults.standard.set(~~, forkey: "key")와 같이
##### -> 가져오기: let year = UserDefaults.standard.integer(forKey: "year")
##### -> 삭제: UserDefaults.standard.removeObject(forKey: "age")


