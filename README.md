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

- Long 타입 Date 값을 원하는 형식으로 변환

```swift
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"
dateFormatter.locale = Locale(identifier:"ko_KR")

let dateInterval = Date(timeIntervalSince1970: TimeInterval(date / 1000)) // 13자릿수로 변환하기 위해 1000을 곱했기 때문에 1000을 나누어 변환
let convertDate = dateFormatter.string(from: dateInterval)
```

### Code to place Tableview inside Scrollview

- UIScrollView를 이용해 스크롤을 다 내린 후 UITableView의 스크롤을 움직이는 방식

> 안드로이드에서는 recyclerview를 이용해 제한 없이 comment 확인이 가능하기 때문에 추후 방식을 더 찾아봐야 할 듯

### 화면 간 데이터 전달 방법

1. 프로퍼티에 직접 접근하는 방식

```swift
let vc = self.storyboard!.instantiateViewController(withIdentifier: "Search")
vc.searchTitle = "검색화면"
self.navigationController?.pushViewController(vc, animated: true)
```

2. segue를 이용한 전달 방식

```swift
if segue.identifier == "search" {
    if let search = segue.destination as? SearchViewController {
        search.searchTitle = "상세정보 화면"
    }
}
```

3. delegate 패턴을 이용한 방식

> 프로토콜 생성 -> 프로토콜 채택 -> 위임 (delegate)

```swift
protocol SendDataDelegate {
    func recieveData(response : String)
}

class SearchViewController: UIViewController {
    var delegate : SendDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.recieveData(response: text)
    }
}

----------------------------------

class NextViewController: UIViewController, SendDataDelegate {
    func recieveData(response: String) {
        titleLabel.text = response
    }
}
```

4. closure를 이용한 방식

```swift
var completioHandler : ((String) -> (Void))?
completioHandler?(data ?? "")

----------------------------------

let vc = self.storyboard!.instantiateViewController(withIdentifier: "Search")
vc.completioHandler = { data in
    self.titleLabel = data
}
```

5. NotificationCenter와 Observer pattern을 이용한 방식

```swift
extension Notification.Name {
    static let titleInfo = Notification.Name("titleInfo")
}

----------------------------------

NotificationCenter.default.post(name: .titleInfo,
                                object: nil,
                                userInfo: ["title": title,
                                           "desc": desc])

----------------------------------

guard let notificationUserInfo = notification.titleInfo as? [String: String] else { return }
```

> ❗️ Observer가 메모리 상에 올라와 있어야 수신되는 형태로 post하는 controller에서 observer가 있는 controller로 **pushController**를 수행하면 데이터 전달 불가능

### userDefaults

- 데이터 저장소
- 사용자 기본 설정과 같은 단일 데이터 값 저장에 적합 (대량 데이터는 sqlite DB 등 사용이 적합)
- [데이터, 키(key)] 형태로 데이터 저장

```swift
UserDefaults.standard.set(components.year!, forKey: "year") // 값 저장하기
let year = UserDefaults.standard.value(forKey: "year") as! Int // 값 가져오기
```

### DatePicker

- DatePicker의 날짜를 커스텀 지정하는 방법

```swift
let calendar: NSCalendar = NSCalendar.current as NSCalendar
var components = calendar.components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: NSDate() as Date)
components.year = yearData
components.month = monthData
components.day = dayData
self.datePicker.setDate(calendar.date(from: components)!, animated: true)
```

> 시간을 변경하고 싶으면 year -> hour / month -> minute
