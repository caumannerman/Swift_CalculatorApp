# 1. Swift_CalculatorApp

구동 영상 : https://www.youtube.com/watch?v=SQm1Ms4QGJk

SingleView 계산기 App입니다.
IOS 학습에 중점을 두었기 때문에, Stack을 사용한 연산자 우선순위 처리까지는 구현하지 않았고, 입력되는 순서대로 계산이 되도록 구현하였다.
RoundButton 클래스를 @IBDesignable, @IBInspectable annotation으로 작성하여 속성 Inspector에서 적용하 수 있게 하였고, didSet 프로퍼티 옵저버를 사용해 UIButton의 모양을 바꿔주었다.
소숫점연산, Clear 등 아이폰 내장 계산기와 유사하게 구현하였다.
연산자 별 계산은 enum으로 정의해놓은 연산자 case와, 연산자를 인자로 받아 switch문으로 처리하느 operation함수로 정의하였다.
@IBAction함수, @IBOutlet 변수를 storyboard와 코드 상에서 연결하는 것이 핵심이었다.

### 프로퍼티 옵저버 
willSet, didSet 두가지의 프로퍼티 옵저버가 있다.
조건에 따라 연산 프로퍼티에 적용 가능하나, 기본적으로 저장 프로퍼티 (Stored Property)에 적용된다.
저장 프로퍼티의 값이 변화하기 직전에 willSet -> 값 변화 -> 값이 변한 직후에 didSet 이 실행된다.




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

##### -> 
##### -> 

### 2-3. UserDefaults
UserDefaults는 App 시작시 사용자의 기본 데이터베이스를 키-값 쌍으로 지속적으로 저장하는 인터페이스이다. 런타임 시 개체를 사용하여 App이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽기 때문에 값이 필요할 때마다 데이터베이스를 열 필요가 없어진다.
사용자의 정보라던가 게시물의 대한 정보처럼 대용량의 데이터를 저장할 때 사용하지 않고 자동로그인 여부, 아이디 저장, 환경설정에서 설정하는 설정 데이터 값같은 단일데이터 등을 UserDefaults로 담아서 보관한다.

이곳에 할 일 목록을 저장해, 앱이 종료되고 다시 시작되어도 데이터가 남아있도록 하였다.

