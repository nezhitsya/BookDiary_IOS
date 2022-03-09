# Book Diary

## 코드 회고

- Collection View를 이용해 calendar를 직접 커스텀하여 사용할 수 있도록 제작
- MVVM Pattern
- Naver Book API를 사용해 Book 검색 기능 제공
- CocoaPods
- Library : SideMenu / Firebase

### [Naver Book API](https://developers.naver.com/docs/search/book/)

- 별도의 라이브러리를 사용하지 않고 API 추출 코드 구축
- query를 이용한 기본 검색으로 json 데이터 추출

> 검색 결과 개수 제한이 있어 10개로 설정하여 스크롤 시 추가로 10개씩 검색 결과 업데이트

> html 마크업언어가 함께 추출되어 utf8로 변경 수행

### MVVM 패턴

1. 사용자가 화면에서 Action을 취하면 Command Pattern으로 View → ViewModel로 전달
2. ViewModel이 Model에게 data를 요청
3. Model은 요청받은 data를 통해 update된 data를 ViewModel로 전달
4. ViewModel은 응답받은 데이터를 가공해서 저장
5. View는 ViewModel과의 Data Binding을 통해서 자동으로 갱신

### adjustsFontSizeToFitWidth

<img width="845" src="https://user-images.githubusercontent.com/60697742/156514786-4472dd3b-a3b9-4729-afee-9667433848ae.png">

- 한 줄로 표시하려는 label의 text가 그 길이를 초과하는 경우 크기에 맞추어 글꼴을 최소 크기로 축소

### Date()

- Android는 Date 값을 13자리 Long 타입으로 추출
- iOS는 Date형으로 받은 값을 직접 원하는 형식으로 변환해 주어야 한다.

1. 현재 시각을 Date() 함수로 받아온다.
2. 받아온 변수에 timeIntervalSince1970 프로퍼티를 사용하여 10자릿수와 소수점 6자릿수로 구성된 값을 추출한다.
3. Android와 마찬가지로 13자릿수로 구성하기 위해 1000을 곱한 후 Int() 형으로 변환해 나머지 3자리 소수점을 제거한다.

```swift
let time = Date()
let timeDouble = time.timeIntervalSince1970 // 10자릿수와 소수점 6자리로 추출됨
let timeInt = Int(timeLong * 1000) // 13자릿수로 변환하기 위해 1000을 곱하고 나머지 3자리의 소수점 제거
```

### Code to place Tableview inside Scrollview

- UIScrollView를 이용해 스크롤을 다 내린 후 UITableView의 스크롤을 움직이는 방식

> 안드로이드에서는 recyclerview를 이용해 제한 없이 comment 확인이 가능하기 때문에 추후 방식을 더 찾아봐야 할 듯
