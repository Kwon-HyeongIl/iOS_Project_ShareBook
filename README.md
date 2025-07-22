<p>
  <img src="https://github.com/user-attachments/assets/e5004fda-3af0-4508-8cae-5a4b94ad3e64" width="8%"><br>
  <img src="https://github.com/user-attachments/assets/4585e5d6-07b7-441d-83e3-88454de94704" width="17%"><br>
  <img src="https://github.com/user-attachments/assets/f9c8bc1f-163e-4407-91e5-20e05d4e9b28" width="24%">&nbsp;
  <img src="https://github.com/user-attachments/assets/ee76c77f-ccfa-4dc3-a794-32c6175a67ec" width="24%">&nbsp;
  <img src="https://github.com/user-attachments/assets/af866364-b9c4-44eb-9693-cc822eb7edf9" width="24%">&nbsp;
  <img src="https://github.com/user-attachments/assets/14bbcd31-921c-4db4-944b-f9ade1cad5e2" width="24%">
</p>

## 🙌 프로젝트 소개

- 여러분이 책에서 발견한 인상 깊은 구절을 기록하고 공유할 수 있어요

- 프로필에서 여러분이 작성한 글 중 가장 마음에 드는 글을 대표책으로 등록해서 다른 사람에게 본인의 인생책을 자랑할 수 있어요

- 이번주에 좋아요를 가장 많이 받은 책의 구절이 어떤 내용인지 확인할 수 있어요

- 특정 장르의 책에만 관심이 있다면 원하는 장르의 책 구절만 볼 수 있어요

- 다른 사람이 작성한 글에서 댓글로 글 작성자와 책에 대해 소통하고 원하는 사용자를 팔로우 할 수 있어요

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

## 🧩 아키텍처 패턴
<br>

- MVVM

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

## 📱 핵심 기능 (iOS 관련)

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
      - 앱 접속시 Firestore에 저장되어 있는 글 로드<br><br>
      - Firebase 쿼리를 사용하여 일주일 내의 글 중에서 가장 좋아요 숫자가 많은 글 8개 선별해서 로드
    </td>
  </tr>
</table>

<br>
<table>
  <tr>
    <td colspan="2" align="center"><b>로그인 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/ee76c77f-ccfa-4dc3-a794-32c6175a67ec">
    </td>
    <td>
      - Apple, Kakao 소셜 로그인 및 이메일 기반 로그인 방식 제공<br><br>
      - SignupViewModel을 Environment로 등록하여 회원가입 화면 전반에서 같은 ViewModel 사용
    </td>
  </tr>
</table>

<br>
<table>
  <tr>
    <td colspan="2" align="center"><b>책 검색 및 글 작성 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/af866364-b9c4-44eb-9693-cc822eb7edf9">
    </td>
    <td>
      - Naver Book API 연동을 통해 실시간 도서 검색 및 선택 후 콘텐츠 작성까지 연결되는 흐름 구축<br><br>
      - Alamofire에서 제공하는 Combine 로직으로 Naver Book API 통신<br><br>
      - 검색창에 Combine의 Debounce를 적용해서 사용자가 검색 버튼을 누르지 않고도 입력이 끝나면 자동으로 검색 요청
    </td>
  </tr>
</table>

<br>
<table>
  <tr>
    <td colspan="2" align="center"><b>프로필 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/14bbcd31-921c-4db4-944b-f9ade1cad5e2">
    </td>
    <td>
      - 사용자가 작성한 글을 Firestore에서 로드
    </td>
  </tr>
</table>

<br>
<table>
  <tr>
    <td colspan="2" align="center"><b>알림 설정 화면</b></td>
  </tr>
  <tr>
    <td>
      <img src="https://github.com/user-attachments/assets/382ee7f3-3bc2-4325-b8fa-f6a68497346b">
    </td>
    <td>
      - Firebase Cloud Messaging api(v1)을 사용하여 푸시 알림 시스템 구현<br><br>
      - 유저간 알림 송수신을 위해 Clound Functions에 구글 OAuth 인증 발급용 Node.js 함수를 등록<br><br>
      - 사용자 객체의 기능별 알림 수신 여부 필드를 기반하여 알림 송신시 수신자의 필드 체크 후 송신 여부 결정
    </td>
  </tr>
</table>

<br><br>

## 📅 개발 기간

<br>

- 2024.07~2024.11

<br><br>
