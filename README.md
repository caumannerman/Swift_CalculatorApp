# 1. Swift_CalculatorApp

구동 영상 : https://www.youtube.com/watch?v=SQm1Ms4QGJk

SingleView 계산기 App입니다.
IOS 학습에 중점을 두었기 때문에, 자료구조시간에 배우는 Stack을 사용한 연산자 우선순위 처리까지는 구현하지 않았고, 입력되는 순서대로 계산이 되도록 구현하였다.
RoundButton 클래스를 @IBDesignable, @IBInspectable annotation으로 작성하여 속성 Inspector에서 적용할 수 있게 하였고, didSet 프로퍼티 옵저버를 사용해 UIButton의 모양을 바꿔주었다.
소숫점 연산, Clear 등 아이폰 내장 계산기와 유사하게 구현하였다.
연산자 별 계산은 enum으로 정의해놓은 연산자 case와, 연산자를 인자로 받아 switch문으로 처리하는 operation함수로 정의하였다.
@IBAction함수, @IBOutlet 변수를 storyboard와 코드 상에서 연결하는 것이 핵심이었다.
didset과 위의 두 annotation들은 버튼의 모양을 둥글게 만드는 데 사용하였다.

> ### 1.1 프로퍼티 옵저버 
swift가 제공하는 프로퍼티 옵저버에는 willSet, didSet 두가지가 있다.
프로퍼티 옵저버는 property의 값 변화를 관찰하고 이에 응답한다.
조건에 따라 연산 프로퍼티에 적용 가능하나, 기본적으로 저장 프로퍼티 (Stored Property)에 적용된다.
저장 프로퍼티의 값이 변화하기 직전에 willSet -> 값 변화 -> 값이 변한 직후에 didSet 이 실행된다.

<img width="400" alt="스크린샷 2022-04-12 오후 10 49 28" src="https://user-images.githubusercontent.com/75043852/162977548-9438a3d7-dd6e-4bc1-996f-5456651807dc.png">

> ### 1.2 @IBInspectable
annotation을 달아, 스토리보드에서 @IBInspectable이 달린 변수의 값을 변경할 수 있게 함. 즉 IB와 해당 변수가 연결되었다라는 것을 컴파일러에게 알리는 신호 @IBInspectable


> ### 1.3 @IBDesignable
변경된 설정값을 스토리보드상에서 실시간으로 확인할 수 있도록 , 즉 런타임(시뮬레이터)이 아니라 컴파일타임에 확인할 수 있다.


<p>
<img width="200" alt="스크린샷 2022-03-06 오전 1 06 39" src="https://user-images.githubusercontent.com/75043852/156891174-b8ec6761-fbe4-4c93-b51a-afb4d78d25d0.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 12 26" src="https://user-images.githubusercontent.com/75043852/156891393-3d3fa7a9-bc43-4521-9349-520413f2109f.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 12 51" src="https://user-images.githubusercontent.com/75043852/156891398-ee6627bf-78c7-48af-965a-fc429078bf96.png">
<img width="200" alt="스크린샷 2022-03-06 오전 1 13 02" src="https://user-images.githubusercontent.com/75043852/156891401-61217d85-6b98-4603-a2d8-ded7b2c5078b.png">
</p>

# 2. Swift_ToDo_List

구동영상 : https://www.youtube.com/watch?v=vRdMyQ-p1bw

 할 일 등록을 위해 UIAlertViewontroller와 UIAlertAction을 사용하여 할 일을 등록할 수 있도록하였다.
 등록된 할 일들을 표현하기 위해 UITableView와 Delegate, DataSource protocol을 사용하였고, 할 일들의 순서 변경, 삭제를 가능하게 프로토콜에 코드를 작성하였다.
 또한 할 일 구조체를 만들고 TableViewCell을 클릭 시, accessorytype을 바꾸어 완료된 할 일인지 아닌지 표시되도록 구현하였다. 이를 struct Tasks의 프로퍼티에 저장하였다.
 앱을 끄고 다시 켜게 되어도, 등록된 할 일들이 남아있도록 UserDefaults에 저장하였다.
 tasks배열이 바뀌면 UserDefaluts에 저장된 것과 동일한 상태로 유지하기 위해, tasks에 didSet 프로퍼티 옵저버를 달아, save해주었다.
 또한 할 일 목록의 순서 변경 혹은 할 일 제거와 같은 경우에는 TableView에 표시된 내용과 tasks배열을 같은 상태로 유지해주는 것이 중요했다.
 
<p>
<img width="200" alt="스크린샷 2022-03-06 오전 3 13 17" src="https://user-images.githubusercontent.com/75043852/156895377-358c1164-4e6a-421d-9c2e-0fd99968b65d.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 13 55" src="https://user-images.githubusercontent.com/75043852/156895381-c1e2a26e-60ee-42d1-ba16-9b0eef560791.png">
 </p>
 <p>
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 15" src="https://user-images.githubusercontent.com/75043852/156895382-42a3749a-55d9-4b45-b0a7-6989bbd7b1c5.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 31" src="https://user-images.githubusercontent.com/75043852/156895384-394d75ff-7432-48a2-ade8-a36a5f5a2c47.png">
<img width="200" alt="스크린샷 2022-03-06 오전 3 14 51" src="https://user-images.githubusercontent.com/75043852/156895385-bf7ff2ed-7a34-42b4-ab10-18dfd5136458.png">
</p>

> ### 2.1 UIAlertController, UIAlertAction 

##### -> UIAlertController는 UIViewController프로토콜을 따르는 open class이다.  UIAlertController에 UIAlertAction을 addAction하여 등록함.
##### -> UIAlertAction은 title, style( .cancel, .default...), handler(클로저 형태)를 담아 생성하고, UIAlertController에 addAction하여 포함시켰다.
##### -> self.present로써 '+' 버튼이 클릭된 경우에 해당 alert가 화면에 표시되도록 하였다. 그 이후의 action은 각 UIAlertAction의 핸들러에 구현된 대로 처리된다.
##### ==> 여기서 Class Instance와 클로저 사이의 강한 순환참조로 인해 Reference count가 서로 절대 0이 되지 않아 메모리 누수가 생기는 것을 방지하기 위해 weak self 를 

![IMG_22B008D28433-1](https://user-images.githubusercontent.com/75043852/163108216-a92e855d-a638-435c-87de-9cfd5281d860.jpeg)


> ### 2.2 TableView

TableView는 섹션을 이용해 행을 그룹화하여 콘텐츠를 정렬하여 볼 수 있게 해준다. 
이를 사용하기 위해서는 UITableViewDelegate, UITableViewDataSource 총 두가지 프로토콜을 구현해야한다.

>> #### 2.2.1 UITableViewDataSource 
=> 필수 : numberOfRowsInSection, cellForRowAt 
/ 이외에 numberOfSections, titleForHeaderInSection, canEditRowAt, canMoveRowAt 등이 있다.


<img width="1100" alt="스크린샷 2022-04-12 오후 11 42 58" src="https://user-images.githubusercontent.com/75043852/162988844-f5988b4e-1673-4550-ac76-f230353bb9f1.png">

>> #### 2.2.2 UITableViewDelegate
시각적인 부분, 액션 관리 등
=> 모두 optional


<img width="1100" alt="스크린샷 2022-04-12 오후 11 42 40" src="https://user-images.githubusercontent.com/75043852/162988861-b6f74702-3a4b-4e8d-9f44-e02741faa78f.png">


>> #### 2.2.3. 본 프로젝트에서 사용한 메서드 

* UITableViewDataSource protocol
>>> numberOfRowsInSection : 각 섹션에 표시할 행 갯수 설정 

>>> cellForRowAt : 특정 Cell에 대한 정보를 전달하여 Cell을 반환해주는 메서드 ( 셀을 구성할 데이터를 구성하고 해당 메서드에 전달하면, 구성한 cell이 TableView에 표시된다 )

* UITableViewDelegate protocol
>>> ViewController가 UITableViewDelegate 프로토콜을 준수하도록 extension을 달고 didSelectRowAt메서드를 구현하여, 셀 클릭 시에 할 일 완료여부가 바뀌도록 구현하였다.
>>> 또한 tableView.reloadRows()메서드를 사용하여 특정 셀들만 reload할 수 있게 하였다.

> ### 2-3. UserDefaults
UserDefaults는 App 시작시 사용자의 기본 데이터베이스를 키-값 쌍으로 지속적으로 저장하는 인터페이스이다. 런타임 시 개체를 사용하여 App이 사용자의 기본 데이터베이스에서 사용하는 기본값을 읽기 때문에 값이 필요할 때마다 데이터베이스를 열 필요가 없어진다.
사용자의 정보라던가 게시물의 대한 정보처럼 대용량의 데이터를 저장할 때 사용하지 않고 자동로그인 여부, 아이디 저장, 환경설정에서 설정하는 설정 데이터 값같은 단일데이터 등을 UserDefaults로 담아서 보관한다.

이곳에 할 일 목록을 저장해, 앱이 종료되고 다시 시작되어도 데이터가 남아있도록 하였다.
* UserDefaults.standard로 싱글톤 패턴으로 생성된 단 하나의 UserDefaults객체를 불러와 사용할 수 있고,
* UserDefaults.object로 저장된 value를 key값을 입력하여 불러올 수 있다.


# 3. Swift_Diary ( 일기장 앱) 

> TabBarController - UIViewController를 상속받음
> UICollectionView - UIScrollView를 상속받음 , 다양한 layout



# 4. Pomodoro 타이머 앱 

구동영상: https://www.youtube.com/watch?v=Tw7JH1ln1ZA
- 1. enum 타입으로 TimerStatus를 start, pause, end 세가지로 정의하여, 상태에 따른 버튼 변화, 타이머 실행등을 수행하였다.
- 1. datePicker에서 시간 설정 후, "시작" 버튼을 누르면 실행되는 tapStartButton(), "취소"버튼을 누르면 실행되는 tapCancelButton(), 크게 두 함수로만 이루어진 간단한 앱
- 1. datePicker와 progressView& 남은 시간을 나타내주는 Label을 겹쳐서 배치하고, 상황에 따라 alpha = 1 혹은 0으로 서로 바꾸며 animation효과 적용



<p>
<img width="220" alt="스크린샷 2022-04-27 오전 10 45 01" src="https://user-images.githubusercontent.com/75043852/165421780-6b039e5f-e67d-4634-bfab-71d19602ffe7.png">
<img width="220" alt="스크린샷 2022-04-27 오전 10 45 15" src="https://user-images.githubusercontent.com/75043852/165421790-afbcf1a1-51dc-4bb6-8d80-2e2f492b23ff.png">
<img width="220" alt="스크린샷 2022-04-27 오전 10 45 52" src="https://user-images.githubusercontent.com/75043852/165421796-6f1d6838-4d36-401c-9a95-8c6f4808f983.png">
</p>

## 4.1 DatePicker 
- 1. preferred Style = Wheels, Mode = CountDownTimer로 설정하여 시간 선택, countdown 수행 
- 1. datePicker.countDownDuration으로 설정한 시간을 "초" 단위로 가져와 사용하였다. 

## 4.2 DispatchSourceTimer
- 1. DispatchSource.makeTimerSource(flags:[], queue: .main)으로 설정해주어 Timer가 돌아가며 view를 업데이트할 수 있게 하였다.
- 1. DispatchSource.schedule( deadline: .now(), repeating: 1)로 즉시 실행하며, 1초마다 handler 클로저 내의 코드가 실행되도록 하였다.
- 1. handler 내부에 guard let self = self else { return }으로 일시적으로 strong reference가 되도록 하였다.
- 1. DispatchSource.setEventHandler의 handler 내부에서 남은시간을 저장하고있는 변수를 갱신하고, timeLabel에 남은 시간을 update하여 표시하고 progressView를 갱신하며,
남은 시간이 0이 되었을 때는 timer 를 정지시켰다.
- 1. DispatchSourceTimer를 정지시킬 때, 타이머가 pause되어있던 상태일 때는, 공식문서의 설명에 따라 resume() 후에 DispatchSourceTimer.cancel()하고, 메모리 누수를 방지하기 위해 self.timer = nil로 메모리 해제를 하였다.

## 4.3 tapStartButton()
- 1. viewController에 정의했고, 변수로 갖고있는 timerStatus값 ( .end, .start, .pause)에 따라 시작/일시정지/재시작이 되도록 구현
( DispatchSourceTimer.suspend(), DispatchSourceTimer.resume() )

## 4.4 tapCancelButton()
- 1. timer가 pause()되어있는 상태라면 resume()해준 후, timer.cancel() & self.timer = nil 하여 timer를 정지, 메모리 할당해제시켜주었다.

# 5. 날씨 앱

>> 이 앱에서는 URLSession을 사용하여 http통신을 진행하였고, OpenWeatherAPI를 사용하여 날씨 정보를 GET 하였다.
<img width="400" alt="스크린샷 2022-05-01 오후 9 15 06" src="https://user-images.githubusercontent.com/75043852/166145420-cb81fc2a-69c6-4767-97b8-1e5d2205a8b5.png">
>> OpenWeatherAPI에서 받아올 수 있는 json 구조에 맞게 Weather구조체를 만들고, URLSession을 default Session형태로 사용하여 통신

<p>
<img width="200" alt="스크린샷 2022-05-01 오후 9 39 43" src="https://user-images.githubusercontent.com/75043852/166146447-882de72c-7b3d-41c5-a522-ff6de07cd6ec.png">
<img width="200" alt="스크린샷 2022-05-01 오후 9 39 57" src="https://user-images.githubusercontent.com/75043852/166146451-d32ad9dd-f9f7-4d91-870e-ca74302700b9.png">
<img width="200" alt="스크린샷 2022-05-01 오후 9 40 09" src="https://user-images.githubusercontent.com/75043852/166146452-2c865912-3751-4949-933a-e4cd2184e2ef.png">
</p>

> http 통신
- 요청과 응답으로 구성 
- http통신은 응답이 끝나면 연결이 끊긴다 (계속  연결되어있지 않다.)
<img width="500" alt="스크린샷 2022-04-29 오전 1 53 15" src="https://user-images.githubusercontent.com/75043852/165804523-d79b6445-6230-493b-8cc1-e21d553f1a53.png">
<img width="500" alt="스크린샷 2022-04-29 오전 1 53 23" src="https://user-images.githubusercontent.com/75043852/165804538-475d4a6d-0b58-43f4-b69f-7fdd026e621a.png">

## 5.1 URLSession

- 1. URLSession은 URLSessionconfiguration으로 생성할 수 있다.
<img width="300" alt="스크린샷 2022-05-01 오후 9 17 30" src="https://user-images.githubusercontent.com/75043852/166145495-5ae8d6e6-9d22-4ba2-a5de-1bd280a4981a.png">
- 1. 이렇게 생성된 URLSession을 통해 1개 이상의 URLSessionTask를 만들 수 있다.

> URLSession의 종류

>> - 1. 공유세션(Shared Session) URLSession.shared()
>>> 싱글톤으로 사용가능 
>>> 맞춤설정을 할 수는 없지만 간편하게 사용

>> - 2. 기본세션(Default Session) URLSession(configuration: .default)
>>> 공유세션과 유사 / 원하는 설정 가능 
>>> 캐시,쿠키인증 등 disk에 저장
>>> 순차적으로 처리하기 위해 delegate 지정 가능

>> - 3. 임시세션(Ephemeral Session) URLSession(configuration: .ephemeral)
>>> Default Session과 유사하나, 캐시/쿠키/사용자 인증정보를 저장하지 않음
>>> Memory에 올려서 연결, 세션 만료시 삭제됨 

>> - 4. 백그라운드세션(Background Session) URLSession(configuration: .background)
>>> 앱이 실행되지 않는 동안 백그라운드에서 통신 가능 

> URLSessionTask 종류
<img width="500" alt="스크린샷 2022-04-29 오전 1 54 48" src="https://user-images.githubusercontent.com/75043852/165804737-c89e3143-683b-4620-a9e2-b8ff2ba4d4e1.png">

> URLSession의 Life Cycle
<img width="500" alt="스크린샷 2022-04-29 오전 1 54 58" src="https://user-images.githubusercontent.com/75043852/165804755-334bdf99-6f6e-42ae-b5de-c83758ce37e3.png">
