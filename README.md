<img src="https://github.com/user-attachments/assets/61dbc6b4-47b7-4a09-a332-68ecc92e1e65" height=200 width=200>

<br>

## 🙌 프로젝트 소개

- 여러분이 책에서 발견한 인상 깊은 구절을 기록하고 공유할 수 있어요

- 프로필에서 여러분이 작성한 글 중 가장 마음에 드는 글을 대표책으로 등록해서 다른 사람에게 본인의 인생책을 자랑할 수 있어요

- 이번주에 좋아요를 가장 많이 받은 책의 구절이 어떤 내용인지 확인할 수 있어요

- 특정 장르의 책에만 관심이 있다면 원하는 장르의 책 구절만 볼 수 있어요

- 다른 사람이 작성한 글에서 댓글로 글 작성자와 책에 대해 소통할 수 있어요

<br><br>

## 👥 팀원 구성
<br>
<div align="center">
  
| **권형일** |
| :------: |
| <img src="https://github.com/user-attachments/assets/f21d71fe-ce7b-4be8-99ed-65d24529dcdf" height=150 width=150> |
| iOS 개발 |

</div>

<br><br>

## 🎨 개발 환경

- **클라이언트** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/3e6d384d-7236-464c-92f0-242e52c7e4cd" height=50 width=50> &nbsp; Swift, &nbsp; <img src="https://github.com/user-attachments/assets/34ae1446-2e29-4099-878e-e5ced09f5ad1" height=50 width=50> &nbsp;SwiftUI, &nbsp; <img src="https://github.com/user-attachments/assets/f6ea23db-3f7e-4a01-9569-f4c71262be7c" height=50 width=50> &nbsp;Combine

- **백엔드** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/c396eca8-b46d-4c30-bf19-29ab9e03213a" height=40 width=30> &nbsp; Firebase, &nbsp; <img src="https://github.com/user-attachments/assets/68311341-bb6f-4b19-8c4c-a75c9f142ae7" height=40 width=40> &nbsp; Cloud Functions

- **데이터베이스** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/7f696449-6dba-4390-96cf-46620035385d" height=40 width=35> &nbsp; Firebase Firestore, &nbsp; <img src="https://github.com/user-attachments/assets/137f9843-1b0c-42e7-a592-5e31bef334d7" height=42 width=42> &nbsp; Firebase Storage

- **알림 서비스** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/e4385433-ad7b-4950-afa5-548a827b05b0" height=45 width=45> &nbsp; Firebase Cloud Messaging API(V1)

- **버전 및 이슈 관리** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/1188196c-7469-4301-9592-ad1c9c029a09" height=40 width=40> &nbsp; Github, &nbsp; <img src="https://github.com/user-attachments/assets/1a7e3c68-90ac-442a-ae95-14f88c1dd0a0" height=40 width=40> &nbsp; Github Issue

- **기록** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/4e88ece5-cc26-4130-a05a-c6dc401e7bdd" height=40 width=40> &nbsp; Notion

- **배포** <br><br>
: &nbsp;&nbsp; <img src="https://github.com/user-attachments/assets/46f120e7-8fb4-46ef-9200-b7578eb66daa" height=40 width=40> &nbsp; AppStore

<br><br>

## 📱 핵심 기능

<br>

<table>
  <tr>
    <td colspan="2" align="center"><b>메인 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/f9c8bc1f-163e-4407-91e5-20e05d4e9b28">
    </td>
    <td>
      - 앱 접속시 Firestore에 저장되어 있는 글 로드
      - Firebase 쿼리를 사용하여 일주일 내의 글 중에서 가장 좋아요 숫자가 많은 글 8개 선별해서 로드
    </td>
  </tr>
</table>

<br>
<!--
<table>
  <tr>
    <td colspan="2" align="center"><b>로그인 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/0e3392c3-3e77-4535-a9a7-1fe0c55f509e">
    </td>
    <td>
      - 로그인을 수행한 이후부터 데이터를 SwiftData가 아닌 Firebase Firestore에 저장<br><br>
      - Apple, Google, Kakao 소셜 로그인 및 이메일 기반 로그인 방식도 제공
    </td>
  </tr>
</table>

<br>
<!--
<table>
  <tr>
    <td colspan="2" align="center"><b>경제 강의</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/72f40fc2-52c9-442c-bafe-7334a21754dd">
    </td>
    <td>
      - Lottie를 활용하여 애니메이션 기반 인터랙티브 UI 경제 강의 구현<br><br>
      - 로그인 여부에 따라 강의 진행 기록을 SwiftData와 Firebase Firestore에 분기하여 저장<br><br>
      - 프로젝트 네비게이션 전역을 관리하는 경로 클래스를 활용하여 특정 페이지부터 이어서 학습 가능<br><br>
      - 뷰 내부의 요소에 id를 붙여 특정 요소로 자동 스크롤
    </td>
  </tr>
</table>

<br>
<!--
<table>
  <tr>
    <td colspan="2" align="center"><b>경제 뉴스</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/45e0274e-14fc-4c74-889f-8e220212d5fa">
    </td>
    <td>
      - 가상의 경제 뉴스를 기반으로 경제 내용 분석 및 퀴즈 제공<br><br>
      - 로그인 여부에 따라 강의 진행 기록을 SwiftData와 Firebase Firestore에 분기하여 저장<br><br>
      - 프로젝트 네비게이션 전역을 관리하는 경로 클래스를 활용하여 특정 페이지부터 이어서 학습 가능<br><br>
      - 뷰 내부의 요소에 id를 붙여 특정 요소로 자동 스크롤
    </td>
  </tr>
</table>

<br>
<!--
<table>
  <tr>
    <td colspan="2" align="center"><b>AI 서비스</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/767ff12c-adc7-48b0-bfb2-99322bf93e36">
    </td>
    <td>
      - GoogleGenerativeAI SDK를 통해 Gemini-1.5-flash 모델을 사용하여 챗봇 구성<br><br>
      - 챗봇 모델 생성시 초기값을 주입하여 경제 관련 답변만 하도록 챗봇 튜닝<br><br>
      - history 방식을 사용하여 연속적인 질의에도 맥락을 이어갈 수 있도록 구현
    </td>
  </tr>
</table>

<br>
<!--
<table>
  <tr>
    <td colspan="2" align="center"><b>알림 서비스</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/8d57ada5-41af-42c4-9f86-74df81c3ec65">
    </td>
    <td>
      - Firebase Cloud Messaging api(v1)을 사용하여 푸시 알림 시스템 구현<br><br>
      - Topic 구독 상태에 따라 알림 수신 여부를 제어하도록, 내부적으로 Topic 구독 및 해제 기능 구현
    </td>
  </tr>
</table>

<br><br>

## 📅 개발 기간


<br><br>
