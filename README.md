# 🪐 코스믹레터 - CosmicLetter 
<p align="center">
  <img src="https://github.com/user-attachments/assets/8d4ff8b4-366d-4611-93f7-58a9a5b07146" alt="Group 726" width="200"/>
</p>

<p align="center">
  <a href="https://apps.apple.com/kr/app/%EC%BD%94%EC%8A%A4%EB%AF%B9%EB%A0%88%ED%84%B0-cosmicletter/id6736467201">
    <img src="https://img.shields.io/badge/App_Store-0D96F6?logo=app-store&logoColor=white" alt="App Store">
  </a>
</p>


## 프로젝트 소개
*" 별 처럼 반짝이는 순간들을 우주에 기록하세요! 당신의 이야기가 시간과 함께 빛나기를 바랍니다. "*
> 코스믹 레터는 사용자가 미래의 특정 날짜에 일기를 작성하고, 지정한 날짜가 되어야만 열람할 수 있는 우주 테마의 다이어리 앱 입니다.

<p align="center">
  <img src="https://github.com/user-attachments/assets/75b2c866-8ea3-43af-ad6c-32a376291c5b" width="200"/>
  <img src="https://github.com/user-attachments/assets/5fa8ef76-9d73-4b9d-b4b2-3b0432445139" width="200"/>
  <img src="https://github.com/user-attachments/assets/27f20630-ce21-41fc-9075-a0b199f8625e" width="200"/>
  <img src="https://github.com/user-attachments/assets/2d6cd91b-3247-4238-89a9-6ab4d4b5cc1b" width="200"/>
</p> 

## 프로젝트 목적

### 기획 의도

-   현재 내가 겪었던 일과 감정을 정리하고 기록할 수 있는 공간을 제공하여, 시간이 지나도 개인의 소중한 순간들을 간직할 수 있도록 돕고자 기획하게 되었습니다.
-   코스믹 레터는 단순한 일기 작성 기능을 넘어 타임캡슐 기능을 통해 사용자가 과거를 되돌아보고, 그때의 감정을 다시금 느낄 수 있는 기회를 제공했습니다.
-   특정 시점에 작성된 일기를 미래에 다시 읽어보며 성장과 변화의 과정을 확인하고, 자신을 돌아볼 수 있는 소중한 경험을 제공하도록 했습니다.

### 대상 사용자

-   코스믹 레터는 감정 표현과 기억을 남기고 싶어하는 경향을 가진 10대, 20대의 젊은 연령층을 타겟으로 구현했습니다.
-   꿈과 미래에 대해 고민하는 시기인 연령층에 맞춰 우주 탐사, 별, 타임캡슐 등과 관련된 콘텐츠를 중심으로 구현하여 미래 지향적이며, 신비롭고 흥미로운 매력을 줄 수 있도록 기획 했습니다.

### 주요 화면

-   사용자가 기록할 날짜를 선택하면, 해당 날짜에 작성된 일기와 메모를 손쉽게 확인할 수 있는 메인 캘린더 화면
-   지정한 날짜에 사진과 음성을 기록할 수 있는 일기 작성 화면
-   간단하게 기록할 수 있는 메모 작성 화면
-   지정한 날짜가 지나기 전에는 자물쇠 아이콘으로 표시되며, 해당 날짜가 되어야 작성한 일기를 확인할 수 있는 일기 화면
-   작성한 메모를 한 눈에 모아 볼 수 있는 메모 화면
-   작성한 일기의 사진을 모아볼 수 있는 앨범 화면

### 비전

-   단순한 기록이 아닌, 과거의 자신과 대화할 수 있는 소중한 공간이 될 수 있도록 했습니다.
-   미래를 향해 희망과 목표를 설정할 수 있도록 유도했습니다. 타임캡슐 기능을 통해 특정 시점에 자신에게 보내는 메세지로 동기부여를 할 수 있습니다.


## 프로젝트 개발 환경
- 개발 인원 :
  - 기획 + 디자인 + iOS 개발자 총 1명
- 개발 기간 :
  - 24.09.12 - 24.10.02 (약 3주)
- iOS 최소 버전 :
  - iOS 16.0

## 디렉토링 구조
```
ComsmicLetter
├── Application
│   └── TimetravelDiaryApp.swift
├── Base.lproj
│   └── AudioManager
├── Global
│   ├──  Resources
│   ├── Extensions
│   ├── FileManager
│   ├── Realm
│   └── Components
├── Network
│   ├── RequestModel
│   └── NetworkManager
├── Presentation
│   ├── Calendar
│   ├── Diary
│   ├── Memo
│   ├── Album
│   ├── Read
│   ├── Setting
│   └── TabBar
└── Info
```
## 주요 기술
> ### 아키텍쳐 (Architecture)
- MVVM 패턴을 적용해 View와 Business Logic을 분리
- Input Output 구조체를 통해 데이터 흐름을 정의하고, transform 메서드를 사용

<br/>

> ### AVAudioRecoder와 AVAudioPlayer을 활용한 음성 기록 기능
- AVAudioRecoder을 통해 음성 녹음을 기록해 FileManager와 Realm에 저장하고, AVAudioPlayer을 통해 저장된 음성 재생하는 기능 구현
- 리소스를 절약하기 위해 동시에 여러 파일을 재생할 수 없도록 기능을 구현

<br/>

> ### 이미지 로딩 최적화
- 현재 날짜와 작성된 일기 날짜를 비교해, 현재 날짜보다 이후에 작성한 일기는 이미지를 로드하지 않고, 자물쇠 아이콘으로 표시해 접근을 제한
- 불필요한 이미지를 로드하지 않도록 구현해 메모리 리소스 소모를 최소화

<br/>

> ### 앱 출시 유지보수 - 다국어 지원 기능
- 영어로 앱의 텍스트를 Localization해, 다양한 사용자 층이 앱을 원활하게 사용할 수 있도록 기능을 개선
- 사용자 설정에 따라 언어를 동적으로 변경할 수 있도록 구현

<br/>

## 트러블 슈팅

### **1. 이미지 선택 및 로드 문제**


  **문제 인식**:
    
   사용자가 PhotosPicker를 통해 이미지를 선택했을 때, 특정 이미지들이 로드되지 않거나 오류 메시지가 발생하는 문제가 있었습니다. 이 문제는 비동기 작업 중에 선택한 이미지의 데이터가 제대로 로드되지 않거나, 로드 도중 발생하는 에러를 처리하는 로직이 부족했기 때문에 발생했습니다. 이로 인해 사용자는 원하는 이미지를 로드하지 못하거나, 앱이 예기치 않게 중단 되는 경우가 있었습니다.


```swift
Task {
    for photoItem in selectedPhotos {
        do {
            // 선택한 사진의 데이터를 로드 (비동기)
            if let imageData = try await photoItem.loadTransferable(type: Data.self),
               let image = UIImage(data: imageData) {
                // 이미지 배열에 추가
                images.append(image)
            }
        } catch {
            // 오류가 발생했을 때의 처리가 미흡했음
            print("Failed to load image: \(error.localizedDescription)")
        }
    }
}
```

**고민 및 설계**:
 이 문제를 해결하기 위해 몇 가지 주요 사항을 고려했습니다.
1. 비동기 처리의 필요성
- 이미지 로드 과정은 시간이 걸리는 비동기 작업이므로, 메인 스레드를 차단하지 않고 동시에 여러 이미지를 처리할 수 있는 방법이 필요했습니다.
2. 에러 핸들링
- 이미지 로드 도중 발생할 수 있는 여러 가지 오류를 적절히 처리하여 사용자에게 명확한 피드백을 제공해야 했습니다. 이를 통해 사용자 경험을 개선할 수 있었습니다.
3. 코드 가독성
- 코드를 단순하게 유지하면서도 각 작업의 결과를 쉽게 처리할 수 있는 구조가 필요습니다.
    
-   **해결 방법**:
1. `TaskGroup` 
TaskGroup을 활용하여 각 이미지 로드 작업을 병렬로 처리했습니다. 이를 통해 여러 이미지를 동시에 로드할 수 있어 효율성이 높아졌습니다.
2.  `에러 핸들링 추가` 
각 이미지 로드 작업에서 발생할 수있는 오류를 do-catch 블록을 통해 처리 했습니다. 이미지 로드 중 오류가 발생하면, 해당 오류를 반환하고 작업을 계속 진행하도록 했습니다.
3.  `결과 처리` 
for await result in taskGroup 구문을 통해 각 작업의 결과를 수집하고, 만약 오류가 발생했다면 사용자에게 적절한 오류 메시지를 표시하도록 했습니다. 이미지가 성공적으로 로드된 경우에는 images 배열에 추가했습니다.


```swift
  Task {
            await withTaskGroup(of: (UIImage?, Error?).self) { taskGroup in
                for photoItem in selectedPhotos {
                    taskGroup.addTask {
                        do {
                            if let imageData = try await photoItem.loadTransferable(type: Data.self),
                               let image = UIImage(data: imageData) {
                                return (image, nil)
                            }
                            return (nil, nil)
                        } catch {
                            return (nil, error)
                        }
                    }
                }
                
                for await result in taskGroup {
                    if let error = result.1 {
                        errorMessage = "Failed to load one or more images."
                        break
                    } else if let image = result.0 {
                        images.append(image)
                    }
                }
            }
        }

```

### 2. 커스텀 토스트 메시지

-   **문제 인식**:

일관된 사용자 경험을 제공하기 위해 애플리케이션에서 토스트 메시지를 표시하고자 했습니다. 그러나 사용자가 특정 작업을 수행한 후 토스트 메시지가 시간이 지나도 사라지지 않거나, 이미 표시된 메시지가 다시 나타나지 않는 문제가 발생했습니다. 이로 인해 사용자는 메시지를 읽지 못하거나 필요한 정보를 놓치는 경우가 발생했습니다.

-   **해결 방법**:

이 문제를 해결하기 위해 DispatchQueue.main.asyncAfter를 사용하여 토스트 메시지가 2초 후에 자동으로 사라지도록 수정하고, 메시지가 다시 표시될 수 있도록 상태 변수를 초기화하여 재사용할 수 있도록 구현했습니다.

    
```swift
    
    private func showToast(message: String) {
        toastMessage = message
        isToastVisible = true
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isToastVisible = false
        }
    }
    
```


-   **결과**:

이 수정으로 인해 토스트 메시지는 설정된 시간(2초)이 지나면 자연스럽게 사라지며, 필요한 경우 사용자에게 메시지를 다시 표시할 수 있게 되었습니다. 이를 통해 사용자 경험이 개선되고, 정보 전달의 일관성이 유지되었습니다.


