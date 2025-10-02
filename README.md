 # Health King





-----------------------------------------------------------------------------------------------------------------

<br>

## 프로젝트 소개

📌 프로젝트 개요
헬킹은 “이기주의를 가장한 자기관리” 라는 트렌드를 기반으로,<br> 운동을 개인적 목표를 넘어 사회적 의식으로 확장할 수 있도록 돕는 웹 플랫폼입니다.<br>
현대 사회에서 운동은 단순히 체력 관리나 외모 관리 차원을 넘어<br>
자기 관리(self-care), 건강한 라이프스타일,<br>
공동체 속 긍정적 문화 형성의 매개체로 자리 잡고 있습니다.<br>
헬킹은 이러한 흐름을 반영하여, 운동 기록·루틴 관리·멘토링·커뮤니티 기능을 제공함으로써<br>
사용자가 개인의 발전을 넘어 타인과 경험을 공유하고 함께 성장할 수 있도록 설계되었습니다.



## 주요 기능

🏠 **메인 페이지**  
전국 어디서나 자유롭게 이용할 수 있는 헬킹 패스권과 가맹점 정보를 직관적으로 확인할 수 있습니다. <br>  

🌍 **전국 자유 이용**  
하나의 패스권으로 제휴된 전국 모든 헬스장을 자유롭게 이용할 수 있습니다. <br>  

📱 **QR 간편 입장**  
QR 코드 스캔만으로 빠르고 안전하게 입장할 수 있습니다. <br>  

⏰ **24시간 언제든지**  
제휴 헬스장은 24시간 운영되어 사용자의 라이프스타일에 맞게 운동할 수 있습니다. <br>  

🏢 **가맹점 소개**  
제휴 헬스장의 위치, 시설, 운영 정보 등을 제공하여 사용자가 원하는 운동 환경을 선택할 수 있습니다. <br>  

📍 **인근 가맹점 찾기**  
현재 위치를 기반으로 주변 헬스장을 검색하고 지도/리스트로 확인할 수 있습니다. <br>  

⭐ **리뷰 & 별점 시스템**  
사용자가 헬스장 및 멘토링 서비스를 평가하고 리뷰를 남길 수 있습니다. <br>  

<br>

-----------------------------------------------------------------------------------------------------------------

<br>

##  개발 환경   

 
## 🛠️ 개발환경

**개발 툴**  
![STS3](https://img.shields.io/badge/STS3-6DB33F?style=flat&logo=spring&logoColor=white)  
![SQL Developer](https://img.shields.io/badge/SQL_Developer-F80000?style=flat&logo=oracle&logoColor=white)  

**서버 & DB**  
![Apache Tomcat](https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=flat&logo=apachetomcat&logoColor=black)  
![Oracle DB](https://img.shields.io/badge/Oracle-FF0000?style=flat&logo=oracle&logoColor=white)  

**언어 / 웹 기술**  
![Java](https://img.shields.io/badge/Java-ED8B00?style=flat&logo=java&logoColor=white)  
![JSP](https://img.shields.io/badge/JSP-007396?style=flat&logo=jsp&logoColor=white)  
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)  
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white)  
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat&logo=javascript&logoColor=black)  

**도구 / 협업**  
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)  
![dbdiagram.io](https://img.shields.io/badge/dbdiagram.io-0D1117?style=flat&logo=dbdiagram&logoColor=white) (erd 그리는 사이트)



## 🗃 프로젝트 구조
```
📦HealthKing
 ┣ 📂src/📂main/📂java📂net📂koreate📂HealthKing
 ┣ 📂board/         # 게시판 기능           
 ┣ 📂chain/         # 가맹점 기능
 ┣ 📂common/     
 ┣ 📂disignbody/    # 디자인 바디 기능
 ┣ 📂pass/          # 패스권 기능
 ┣ 📂qr/            # qr 기능                  
 ┣ 📂review/        # 리뷰 기능
 ┗ 📂               # 로그인 로그아웃 기능 

```

---


---

## Helking Project 실행 가이드

### 1️⃣ 실행 전 준비사항

- 프로젝트 압축 파일 다운로드  
- 압축 해제 시 ✅ “압축파일명 하위 폴더에 압축해제” 옵션 체크  
- 압축 해제된 폴더를 VSCode로 드래그 앤 드롭하여 열기  

---

### 2️⃣ 패키지 설치 (Python 백엔드용)

VSCode 하단 터미널 또는 PowerShell에서 순서대로 입력:

```bash
pip install flask
pip install flask_cors
pip install selenium_stealth

cd "Python 프로젝트 경로"  # 예: C:\Users\YourName\helking-project\backend
py flask_transport_server.py

---
```
### 3️⃣ 프로젝트 디렉터리 이동 & 서버 실행

VSCode 하단 터미널 또는 PowerShell에서 아래 명령어를 입력:

```
cd "Python 프로젝트 경로"  # 예: C:\Users\YourName\helking-project\backend
py flask_transport_server.py

```
---

### 4️⃣ 성공 시 출력 예시

프로젝트가 정상 실행되면 터미널에 아래와 같이 출력됩니다

✅ selenium-stealth 패키지 로드 성공  

```
```
### 5️⃣ Spring 서버 실행 방법

Spring 서버를 실행하려면 아래 단계를 따라주세요:

Spring Tool Suite(STS) 실행

프로젝트 임포트 (spring_legacy 폴더 내 프로젝트)

SQL 파일 실행하여 DB 테이블 생성

톰캣 서버 실행

기본 서버 주소: http://localhost:8080

```
```

### 🔗 주요 API 예시 (Spring 서버 기준)

🚄 기차 검색
http://localhost:8080/search_trains?departure=서울&arrival=부산&date=20250924

🚌 버스 검색
http://localhost:8080/search_buses?departure_terminal=서울고속버스터미널&arrival_terminal=부산서부터미널&date=20250924

✈️ 항공 검색
http://localhost:8080/search_flights?departure_airport=ICN&arrival_airport=NRT&departure_date=2025-09-24

📋 역 목록 조회
http://localhost:8080/stations








