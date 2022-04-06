import Foundation
import RxSwift
import Dispatch


print("---Just---")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    }
    ) // 제대로 작동하는지

print("---Of---")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })
// 순서대로 내뿜는 observable Sequence가 생성됨

print("---of2---")
Observable.of([1,2,3,4,5])
    .subscribe(onNext: {
        print($0)
    })

print("---From---")
Observable.from([1,2,3,4,5]) // from은 array형태만 받는다 . 하나씩 꺼내서 방출함
    .subscribe(onNext: {
        print($0)
    })

print("-----subsribe-----")
Observable.of(1,2,3)
    .subscribe{
        print($0)
    }

print("-----subscribe2-----")
Observable.of(1,2,3)
    .subscribe{
        print("kkk")
        if let element = $0.element{
            print(element)
        }
    }

print("-----subscribe3-----")
Observable.of(1,2,3)
    .subscribe(onNext:{
        print($0)
    })

print("----empty----")
Observable.empty() // 요소를 하나도 가지지 않는 count = 0인 옵저버블 만들 때 사용
    .subscribe{
        print($0)
    }


print("-----never-----")
Observable<Void>.never()
    .debug("never")
    .subscribe(onNext: {
        print($0)
        
    }, onCompleted: {
        print("Completed")
    }
)


print("-----range-----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext:{
        print("2*\($0)=\(2*$0)")
    })


print("-----dispose-----")
Observable.of(1,2,3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("----disposeBag-----")
let disposeBag = DisposeBag()

Observable.of(1,2,3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

print("----create1-----")

Observable.create{ observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted() // 여기서 종료
    observer.onNext(2) // 얘는 방출되지 않음
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("-----create2====")
enum MyError: Error {
    case anError
}

Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.onError(MyError.anError)
//    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(onNext:{
    print($0)
},
           onError: {
    print($0.localizedDescription)
},
           onCompleted: {
    print("completed")
},
           onDisposed:{
    print("disposed")
})
.disposed(by: disposeBag)

print("----deffered-----")
Observable.deferred{
    Observable.of(1,2,3)
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)


