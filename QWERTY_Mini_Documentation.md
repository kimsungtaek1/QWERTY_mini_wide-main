# QWERTY Mini 앱 전체 구조 및 기능 문서

## 📋 목차
1. [프로젝트 개요](#프로젝트-개요)
2. [전체 아키텍처](#전체-아키텍처)
3. [메인 앱 구조](#메인-앱-구조)
4. [키보드 익스텐션 구조](#키보드-익스텐션-구조)
5. [핵심 기능](#핵심-기능)
6. [UI 컴포넌트](#ui-컴포넌트)
7. [변경 가능한 UI 요소](#변경-가능한-ui-요소)
8. [기술 스택](#기술-스택)

---

## 🎯 프로젝트 개요

**QWERTY Mini**는 한글 입력에 최적화된 iOS 커스텀 키보드 앱입니다. 기존의 천지인이나 나랏글 방식과 달리, QWERTY 배열에서 직관적으로 한글을 입력할 수 있는 혁신적인 입력 방식을 제공합니다.

### 주요 특징
- 🇰🇷 **한글 QWERTY 입력**: 표준 QWERTY 배열에서 한글 직접 입력
- 🔄 **다중/동시 탭 입력**: 효율적인 문자 입력 시스템
- 🌓 **다크모드 지원**: 시스템 테마 연동
- 📱 **반응형 디자인**: 모든 iPhone 크기 지원
- 🈳 **한자 변환**: 실시간 한자 변환 기능

---

## 🏗️ 전체 아키텍처

```
QWERTY_Mini_Project/
├── QWERTY_Mini/                 # 메인 앱
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── ViewController/
│   │   ├── Home/               # 홈 화면
│   │   └── Setting/            # 설정 화면
│   └── Info.plist
├── QWERTY_Keyboard/            # 키보드 익스텐션
│   ├── KeyboardViewController.swift
│   ├── KeyboardView.swift
│   ├── Model/                  # 데이터 모델
│   ├── View/                   # UI 컴포넌트
│   ├── HangulAutomata.swift    # 한글 조합 엔진
│   ├── InputManager.swift      # 입력 관리
│   └── Info.plist
├── Podfile                     # 의존성 관리
└── Package.swift
```

---

## 📱 메인 앱 구조

### 1. 홈 화면 (HomeController/HomeView)

#### UI 구성요소
```swift
// HomeView 주요 컴포넌트
- logo_img: UIImageView           // QWERTY 로고
- setting_Label: UILabel          // 안내 텍스트
- goToSetting_Btn: UIButton       // 설정 바로가기
- setting_Btn: UIButton           // 앱 설정
```

#### 기능
- **키보드 설정 안내**: 사용자에게 키보드 활성화 방법 안내
- **시스템 설정 연결**: iOS 설정 앱으로 직접 이동
- **앱 내 설정 접근**: 상세 설정 화면으로 이동

### 2. 설정 화면 (SettingViewController/SettingView)

#### UI 구성요소
```swift
// SettingView 주요 컴포넌트
- logo_img: UIImageView                    // 브랜드 로고
- howUseKeyboard_Btn: UIButton            // 사용법 안내
- previewKeyboard_Btn: UIButton           // 키보드 미리보기
- agree_SettingItemView: SettingBottomItemView    // 이용약관
- share_SettingItemView: SettingBottomItemView    // 앱 공유
- systemSetting_SettingItemView: SettingBottomItemView // 시스템 설정
```

#### 기능
- **사용법 안내**: 키보드 사용 방법 가이드
- **키보드 미리보기**: 실제 키보드 레이아웃 확인
- **앱 공유**: 네이티브 공유 시트를 통한 앱 추천
- **약관 및 개인정보**: 법적 고지사항 확인

---

## ⌨️ 키보드 익스텐션 구조

### 1. 키보드 컨트롤러 (KeyboardViewController)

#### 주요 역할
- 키보드 생명주기 관리
- 테마 변경 감지 및 적용
- 화면 회전 및 크기 변경 대응
- 텍스트 입력 세션 관리

#### 핵심 메서드
```swift
- updateTheme()                    // 테마 업데이트
- resetKeyboardState()             // 키보드 상태 초기화
- sizeChange()                     // 크기 변경 처리
- textWillChange/textDidChange     // 텍스트 변경 감지
```

### 2. 키보드 뷰 (KeyboardView)

#### UI 구조
```swift
KeyboardView
├── keyboardContainer              // 메인 컨테이너
│   ├── chnCollectionView         // 한자 변환 영역
│   ├── letterStackView           // 문자 키 영역
│   └── functionStackView         // 기능 키 영역
```

#### 주요 기능
- **동적 레이아웃**: 화면 크기에 따른 키 크기 조정
- **다중 터치 지원**: 동시 입력 감지
- **시각적 피드백**: 키 터치 시 하이라이트 효과

### 3. 한글 조합 엔진 (HangulAutomata)

#### 오토마타 상태
```swift
enum HangulStatus {
    case start          // 시작 상태
    case chosung        // 초성 입력
    case joongsung      // 중성 입력
    case dJoongsung     // 복합 중성
    case jongsung       // 종성 입력
    case dJongsung      // 복합 종성
    case endOne, endTwo // 종료 상태
}
```

#### 조합 테이블
- **초성 테이블**: 19개 초성 자음
- **중성 테이블**: 21개 중성 모음
- **종성 테이블**: 28개 종성 (공백 포함)
- **복합 조합 테이블**: 겹자음, 겹모음 규칙

### 4. 입력 관리자 (InputManager)

#### 입력 방식
- **단일 탭**: 기본 문자 입력
- **연속 탭**: 0.3초 내 같은 키 반복 → 보조 문자
- **동시 탭**: 두 키 동시 터치 → 특수 조합

#### 특수 조합 규칙
```swift
// 한글 경음 조합
ㅡ + ㅂ = ㅃ
ㅡ + ㅈ = ㅉ
ㅡ + ㄷ = ㄸ
ㅡ + ㄱ = ㄲ
ㅡ + ㅅ = ㅆ

// 한글 복합모음 조합
ㅁ + ㅗ = ㅛ
ㅁ + ㅏ = ㅑ
ㅁ + ㅜ = ㅠ
ㅁ + ㅓ = ㅕ
```

---

## 🔧 핵심 기능

### 1. 다중 언어 지원

#### 지원 모드
- **한글 모드**: 한글 입력 및 조합
- **영문 모드**: 영어 입력
- **숫자 모드**: 숫자 및 기본 특수문자
- **특수문자 모드**: 확장 특수문자 세트

### 2. Shift 기능

#### 동작 방식
- **단일 탭**: 한 글자만 대문자/겹자음 (onshift 상태)
- **0.5초 내 더블탭**: Shift Lock (lockshift 상태)
- **일반 탭**: Shift 해제

### 3. 한자 변환 시스템

#### 변환 프로세스
1. 한글 입력 완료
2. Chn 키 터치
3. 마지막 한글 단어 추출
4. HanjaManager에서 한자 후보 검색
5. 상단 컬렉션뷰에 후보 표시
6. 사용자 선택 시 한글→한자 대체

### 4. 동적 크기 조정

#### 화면 대응
```swift
// 키 크기 계산 로직
- iPhone 일반: 42pt 기준
- iPhone Pro Max: 44pt 기준
- 세로 모드: 화면 너비의 95%
- 가로 모드: 좌우 여백 40pt 제외
```

---

## 🎨 UI 컴포넌트

### 1. KeyView (개별 키 버튼)

#### 구성 요소
```swift
KeyView
├── keyButton: UIView              // 메인 버튼 영역
├── lt_Label: UILabel             // 좌상단 보조 문자
├── rt_Label: UILabel             // 우상단 표시
├── rb_Label: UILabel             // 우하단 보조 문자
├── _imageView: UIImageView       // 아이콘 (Shift 등)
└── blockview: UIView             // 터치 피드백 오버레이
```

#### 시각적 효과
- **그림자**: 키 버튼 하단 그림자 효과
- **터치 피드백**: 반투명 오버레이
- **테마 연동**: 라이트/다크 모드 자동 전환

### 2. KeyModel (키 데이터 모델)

#### 속성
```swift
class KeyModel {
    var keyType: KeyType              // 키 타입
    var main_txt: String              // 메인 텍스트
    var lt_txt: String                // 좌상단 텍스트
    var rt_txt: String                // 우상단 텍스트
    var rb_txt: String                // 우하단 텍스트
    var backgroundColor: UIColor      // 배경색
    var textColor: UIColor           // 텍스트 색상
    // ... 기타 스타일 속성
}
```

### 3. KeyLetter (키 레이아웃 관리자)

#### 레이아웃 생성 메서드
```swift
- getKorLetters()                 // 한글 키 배열
- getEngLetter()                  // 영문 키 배열
- getNumberLetter()               // 숫자 키 배열
- getSpecialLetter()              // 특수문자 키 배열
- getShiftLetter()                // Shift 상태 키 배열
```

---

## 🔄 변경 가능한 UI 요소

### 1. 색상 테마

#### 현재 색상 시스템
```swift
// 라이트 모드
backgroundColor = .white
function_bg = UIColor(hexString: "#a1aabc")
textColor = .black
subletter_Color = UIColor(hexString: "#808080")

// 다크 모드
backgroundColor = UIColor(red: 83/255, green: 83/255, blue: 83/255, alpha: 1.0)
function_bg = UIColor(hexString: "#464747")
textColor = .white
subletter_Color = .white
```

#### 변경 가능한 요소
- **키 배경색**: `backgroundColor` 변경
- **기능키 색상**: `function_bg` 변경
- **텍스트 색상**: `textColor`, `subletter_Color` 변경
- **키보드 컨테이너 색상**: `keyboardContainer.backgroundColor`

### 2. 키 크기 및 간격

#### 현재 크기 시스템
```swift
// 키 크기 (화면 크기별 동적 계산)
var key_width: Float              // 키 너비
var key_height: Int               // 키 높이 (60pt/46pt)
var fuctionwidth: Float           // 기능키 너비

// 간격
letterStackView.spacing = 13      // 행간 간격
functionStackView.spacing = 3     // 키간 간격
```

#### 변경 가능한 요소
- **키 크기 비율**: `calculateKeyboardWidth()` 함수 수정
- **키 간격**: StackView의 `spacing` 속성
- **키보드 여백**: 컨테이너 inset 값

### 3. 폰트 및 텍스트 크기

#### 현재 폰트 시스템
```swift
// 한글 관련
let korsubTextSize: Float = 15.0

// 영문 관련
let engSmallTextSize: Float = 25.0
let engLargeTextSize: Float = 19.0
let engTextSize: Float = 18

// 기타
let spaceTextSize: Float = 15
let return123TextSize: Float = 15
let specialFontSize: Float = 21
let numerSize: Float = 24
```

#### 변경 가능한 요소
- **메인 텍스트 크기**: `main_textsize` 속성
- **보조 텍스트 크기**: `lt_textsize`, `rb_textsize` 속성
- **폰트 굵기**: `UIFont.Weight` 설정

### 4. 키 레이아웃

#### 현재 레이아웃 구조
```swift
// 한글 키보드 (2행)
Row 1: ㅂ ㅈ ㄷ ㄱ ㅅ ㅗ ㅏ ㅣ [⌫]
Row 2: ㅁ ㄴ ㅇ ㄹ ㅎ ㅜ ㅓ ㅡ [Eng]

// 기능키 행 (1행)
[Shift] [123] [Space] [Return]
```

#### 변경 가능한 요소
- **키 배치**: `getKorLetters()` 등 메서드에서 배열 순서 변경
- **키 개수**: 행당 키 개수 조정
- **기능키 구성**: 기능키 종류 및 배치 변경

### 5. 한자 변환 UI

#### 현재 구조
```swift
chnCollectionView: UICollectionView {
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 16
    layout.estimatedItemSize = CGSize(width: 80, height: 40)
    backgroundColor = UIColor(hexString: "#F3F3F8")
}
```

#### 변경 가능한 요소
- **컬렉션뷰 높이**: `chnHeight` constraint
- **셀 크기**: `estimatedItemSize` 변경
- **배경색**: `backgroundColor` 변경
- **스크롤 방향**: `scrollDirection` 변경

### 6. 애니메이션 및 피드백

#### 현재 피드백 시스템
```swift
// 터치 피드백
blockview.isHidden = false        // 터치 시작
blockview.isHidden = true         // 터치 종료

// 그림자 효과
layer.shadowColor = UIColor.black.cgColor
layer.shadowOffset = CGSize(width: 0, height: 2)
layer.shadowOpacity = 1
layer.shadowRadius = 2
```

#### 변경 가능한 요소
- **터치 피드백 색상**: `blockview.backgroundColor`
- **그림자 설정**: shadow 관련 속성들
- **애니메이션 지속시간**: 터치 피드백 애니메이션
- **햅틱 피드백**: UIImpactFeedbackGenerator 추가 가능

---

## 🛠️ 기술 스택

### 개발 환경
- **언어**: Swift 6.0
- **플랫폼**: iOS (iPhone 전용)
- **아키텍처**: MVVM + RxSwift

### 주요 라이브러리
```ruby
# Podfile
pod 'RxSwift', '~> 6.9'          # 반응형 프로그래밍
pod 'RxCocoa', '~> 6.9'          # UI 바인딩
pod 'SnapKit'                    # Auto Layout
pod 'Kingfisher', '~> 7.0'       # 이미지 처리
pod 'Alamofire'                  # 네트워킹
pod 'SwiftSoup'                  # HTML 파싱
pod "Solar-dev", "~> 3.0"        # 다크모드 지원
```

### 아키텍처 패턴
- **MVVM**: Model-View-ViewModel 패턴
- **Reactive Programming**: RxSwift를 통한 데이터 바인딩
- **Singleton Pattern**: InputManager, KeyLetter 등
- **State Machine**: HangulAutomata의 상태 관리

---

## 📝 개발 가이드라인

### UI 수정 시 주의사항
1. **테마 일관성**: 라이트/다크 모드 모두 고려
2. **반응형 디자인**: 다양한 화면 크기 테스트
3. **접근성**: VoiceOver 등 접근성 기능 고려
4. **성능**: 키보드는 실시간 반응이 중요

### 기능 추가 시 고려사항
1. **메모리 효율성**: 키보드 익스텐션의 메모리 제한
2. **사용자 경험**: 직관적이고 일관된 인터페이스
3. **다국어 지원**: 현재 한글/영문 외 확장 가능성
4. **호환성**: iOS 버전별 호환성 확인

---

*이 문서는 QWERTY Mini 앱의 현재 구조를 기반으로 작성되었으며, 개발 진행에 따라 업데이트될 수 있습니다.*