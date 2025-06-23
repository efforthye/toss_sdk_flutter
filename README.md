# toss_sdk_flutter

Flutter project for testing Toss SDK integration

## 📱 프로젝트 소개

토스 SDK를 Flutter와 연동하여 테스트하는 프로젝트입니다.

## 🚀 시작하기

### 사전 요구사항
- Flutter SDK (3.10.0 이상)
- Dart SDK (3.0.0 이상)
- Android Studio / VS Code
- iOS 개발 시 Xcode 필요

### 설치 및 실행

1. 레포지토리 클론
```bash
git clone https://github.com/efforthye/toss_sdk_flutter.git
cd toss_sdk_flutter
```

2. 의존성 설치
```bash
flutter pub get
```

3. 환경 변수 설정
```bash
cp .env.example .env
# .env 파일에서 필요한 값들을 설정하세요
```

4. 앱 실행
```bash
flutter run
```

## 📁 프로젝트 구조

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── utils/
│   └── theme/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── providers/
└── domain/
    ├── entities/
    └── usecases/
```

## 🛠 사용 기술

- **Framework**: Flutter
- **상태관리**: Provider
- **HTTP 통신**: Dio
- **보안 저장소**: Flutter Secure Storage
- **환경 변수**: Flutter Dotenv

## 📝 커밋 컨벤션

```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷팅, 세미콜론 누락 등
refactor: 코드 리팩토링
test: 테스트 코드 추가/수정
chore: 빌드 과정 또는 보조 기능 수정
```

예시:
```
feat: toss payment integration
fix: payment validation error
docs: update README with setup instructions
```

## 📄 라이센스

MIT License