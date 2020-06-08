# iOS 페어 개발 룰

1. 이슈하나당 커밋 하나 - 커밋은 기능의 한 단위를 의미한다. ex) 네트워크 연동, UI 구현
2. 가능한 올페어로 진행한다. (10:30 ~ 23:00)
3. 분업을 하는 경우는 상대에게 리뷰를 받는다.(리뷰어 지정)
4. 브랜치
```
dev - 화면 - 구성 
ex) dev - Login - IDInput - 기능(commit)
                - OAuth - 기능(commit)
```
#### MARK 순서
0. IBInspectable
1. IBOutlet
2. Properties
3. Lifecycle
4. Methods
5. IBAction
6. Objc

#### 프로퍼티 선언 순서
1. Stored Property
2. Computed Property

#### 접근 제어자 별 선언 순서
1. static
2. private
3. public

#### 기타
* 상속하지 않는 클래스는 final 명시
* 함수 내부 return 은 줄바꿈으로 구분해주기
* 전역 프로퍼티는 타입 명시
* 클래스, 구조체, 프로토콜 첫줄 띄우기
