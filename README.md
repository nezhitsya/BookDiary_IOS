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
