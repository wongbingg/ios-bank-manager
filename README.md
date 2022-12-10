# 은행창구 매니저 [Refactoring]

> 야곰아카데미 `은행창구 매니저`를 리팩토링한 프로젝트 입니다. 이전 프로젝트는 [step4 브랜치](https://github.com/wongbingg/ios-bank-manager/tree/feature/step4) 에서 볼 수 있습니다.

## 📄 소개
- 은행에서 예금업무와 대출업무를 처리하는 일련의 과정을 나타낸 앱 입니다.
- 프로젝트 상에서 예금업무처리 은행원 2명, 대출업무처리 은행원 1명으로 제한을 두었습니다.  

## 📱 실행화면

<table>
    <tr>
        <td valign="top" width="30%" align="center" border="1">
            <strong>기본 화면</strong>
        </td>
        <td valign="top" width="30%" align="center">
            <strong>실행 화면</strong>
        </td>
        <td valign="top" width="30%" align="center" border="1">
            <strong>실행화면2</strong>
        </td>
    </tr>
    <tr>
        <td valign="top" width="30%">
            <img src="https://i.imgur.com/YXvyJRz.png"/>
        </td>
        <td valign="top" width="30%">
            <img src="https://i.imgur.com/x3r45iC.gif"/>
        </td>
        <td valign="top" width="30%">
            <img src="https://i.imgur.com/wwaLOWa.gif">
        </td>
    </tr>
</table>


## 🔭 시각 자료
### - UML Diagram
![](https://i.imgur.com/2jneZ2T.jpg)


### - File Tree
```
.
└── BankManagerUIApp
    ├── Entries
    │   ├── AppDelegate
    │   └── SceneDelegate
    ├── Helpers
    │   ├── Extensions
    │   │   └── UIStackView+Extension
    │   └── Protocols
    │       └── Workable
    ├── Model
    │   ├── Bank
    │   ├── Customer
    │   ├── Business
    │   ├── BankManager
    │   └── CustomerQueue
    │       ├── LinkedList
    │       │   ├── LinkedList
    │       │   └── Node
    │       ├── Contract
    │       │   ├── Queue
    │       │   └── Queue+Extension
    │       └── CustomerQueue
    ├── Controller
    │   └── ViewController
    ├── View
    │   └── MainView
    └── Supporting Files
        ├── Assets
        ├── LaunchScreen
        └── Info.plist
```
## ⚙️ 새롭게 적용한 기술

### ✅ OperationQueue


#### ☑️ OperationQueue 스레드 제한

<details>
    <summary>
        펼쳐보기
    </summary>

- 기존에 사용했던 `DispatchQueue`의 경우 
    ```swift
    DispatchSemaphore 를 이용하여 공유자원에
    접근할 수 있는 스레드의 갯수를 제한 해주었습니다.
    ```
- 새롭게 사용한 `OperationQueue` 의 경우
    ```swift
    OperationQueue의 maxConcurrentOperationCount
    프로퍼티를 통해 설정이 가능했습니다.
    ```

</details>

#### ☑️ OperationQueue 완료시점 파악

<details>
    <summary>
        펼쳐보기
    </summary>

- 기존에 사용했던 `DispatchQueue` 의 경우
    ```swift
    DispatchGroup 의 notify() 메서드를 통해 Queue 안의 작업이 모두 
    완료되면 알림을 주는 기능을 통해 완료시점을 파악할 수 있었습니다.
    ```
    
- 새롭게 사용한 `OperationQueue` 의 경우
    ```swift
    completionHandler 역할을 해줄 BlockOperation 객체를 만들어서
    BlockOperation의 addDependency() 메서드를 통해 각 작업을
    추가하여 작업이 끝나면 completionHandler가 실행되도록 구현 했습니다.
    ```
</details>

#### ☑️ OperationQueue 작업 취소

<details>
    <summary>
        펼쳐보기
    </summary>

- 기존에 사용했던 `DispatchQueue`의 경우 
    ```swift
    DispatchQueue 에 넣었던 작업들에 대한 중지를 시켜주지 못했습니다. 
    즉, `초기화` 버튼 기능구현을 하지 못했습니다.
    ```
- 새롭게 사용한 `OperationQueue` 의 경우
    ```swift
    OperationQueue 에서 제공하는 cancelAllOperations() 메서드를
    통해 큐에 쌓였던 작업들을 모두 취소시켜줄 수 있었습니다.
    ```
    <span style="background-color:lightpink">하지만, 취소를 요청한 시점에 이미 진행하고 있던 작업까지는 진행이 된 후 
        모든 작업이 취소된다는 것을 확인 했습니다.</span>

</details>

## 🛠 Trouble Shooting

## 🔗 참고자료
- 야곰아카데미 GCD 강의
- [Apple Docs - cancelAllOperations()](https://developer.apple.com/documentation/foundation/operationqueue/1417849-cancelalloperations)
- [Apple Docs - DispatchGroup](https://developer.apple.com/documentation/dispatch/dispatchgroup/)
