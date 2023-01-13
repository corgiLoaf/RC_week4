# Swift 로 구현한 고기 굽기 게임

## UIKit
- Timer
- DispatchQueue
- UIPanGestureRecognizer
- UITapGestureRecognizer

## 구조
- `Meat` 라는 `UIImageView` 의 서브 클래스인 커스텀 클래스를 만들어 게임의 오브젝트로 사용
    - 각 오브젝트가 공통으로 갖고 있어야 할 프로퍼티나 메소드 등
    - 오브젝트의 timer에 따라서 이미지 변화
- `ViewController` 에서 게임의 전체적인 로직을 구현
    - 게임의 전체 타이머
    - 각 오브젝트들이 불판 - `Gril View` 이나 접시 - `Submit Zone` 위로 드래그&드랍 되었을 때 해당하는 기능 구현
    - 점수
    - 타이머가 끝났을 때 재시작 화면
    

## 게임화면
![image](https://user-images.githubusercontent.com/103231425/212254776-e5b32ceb-097b-40b1-80eb-bfcd141f1877.png)

![image](https://user-images.githubusercontent.com/103231425/212255194-0ffa0e40-3e44-4c1b-8901-03b729395d33.png)
