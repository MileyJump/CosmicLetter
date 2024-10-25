# 프로젝트 소개
*" 별 처럼 반짝이는 순간들을 우주에 기록하세요! 당신의 이야기가 시간과 함께 빛나기를 바랍니다. "*
> 코스믹 레터는 사용자가 미래의 특정 날짜에 일기를 작성하고, 지정한 날짜가 되어야만 열람할 수 있는 우주 테마의 다이어리 앱 입니다.

<p align="center">
  <img src="https://github.com/user-attachments/assets/75b2c866-8ea3-43af-ad6c-32a376291c5b" width="200"/>
  <img src="https://github.com/user-attachments/assets/5fa8ef76-9d73-4b9d-b4b2-3b0432445139" width="200"/>
  <img src="https://github.com/user-attachments/assets/27f20630-ce21-41fc-9075-a0b199f8625e" width="200"/>
  <img src="https://github.com/user-attachments/assets/2d6cd91b-3247-4238-89a9-6ab4d4b5cc1b" width="200"/>
</p> 

# 프로젝트 목적

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


# 프로젝트 개발 환경
- 개발 인원 :
  - 기획 + 디자인 + iOS 개발자 총 1명
- 개발 기간 :
  - 24.09.12 - 24.10.02 (약 3주)
- iOS 최소 버전 :
  - iOS 16.0

# 디렉토링 구조
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
# 주요 기술

-   **iOS** : Swift 5.1, Xcode 15.4, SwiftUI (Minimum version 16.0)
    
-   **UI** : Codebase UI, Shufflelt
    
-   **Architecture** : MVVM
    
-   **Reactive** : Combine
    
-   **Network** : Alamofire

-   **DataBase** :  RealmSwift
    
-   **Utility** : FileManager, AVFoundation
 
    

# 트러블 슈팅

### **1. 이미지 선택 및 로드 문제**

-   **문제**:
    
    사용자가 PhotosPicker를 통해 선택한 이미지를 로드하는 과정에서 특정 사진들이 로드되지 않거나 오류 메시지가 발생하는 문제가 있었습니다. 이 문제는 선택한 이미지의 데이터가 제대로 로드되지 않는 경우 발생했으며, 비동기 작업 중 에러를 처리하는 부분이 부족했습니다.
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
-   **해결 방법**: `TaskGroup`을 사용해 비동기 이미지 로드를 병렬 처리하고, 각 이미지 로드에 대한 에러 핸들링을 추가했습니다. 이를 통해 이미지 로드 중 오류가 발생해도 앱이 중단되지 않고 오류 메시지를 표시하도록 수정했습니다.
-   **적용 코드**:

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

-   **문제**: 일관된 사용자 경험을 위해 토스트 메시지를 표시할 때, 시간이 지나도 사라지지 않거나 한 번 표시된 후 다시 표시되지 않는 경우가 발생했습니다.
    
-   **해결 방법**: `DispatchQueue.main.asyncAfter`를 사용해 토스트 메시지가 2초 후에 자동으로 사라지도록 수정하고, 다시 메시지를 표시할 수 있도록 상태를 초기화했습니다.
    
-   **적용 코드**:
    
    ```swift
    swift
    코드 복사
    private func showToast(message: String) {
        toastMessage = message
        isToastVisible = true
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isToastVisible = false
        }
    }
    
    
    ```
-   **결과**: 토스트 메시지가 설정된 시간 이후에 자연스럽게 사라지며, 필요한 경우 재사용할 수 있게 되었습니다.
