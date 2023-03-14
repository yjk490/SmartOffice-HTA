# SmartOffice-HTA

# 목차
  - [프로젝트 소개](#소개)
  - [개발환경](#개발-환경)
  - [사용기술](#사용-기술)
  - [프로젝트 구조](#프로젝트-구조)
  - [실행 화면](#실행-화면)
  - [이슈](#이슈)
  - [리팩토링 및 업데이트 계획](#리팩토링-및-업데이트-계획)

## 소개
쪽지, 연락처 관리, 업무 관리, 자유 게시판 기능이 있는 그룹웨어입니다.   
Java와 Spring 프레임워크를 학습한 후, 실습을 위해 기획한 팀 프로젝트입니다.   
      
개발 기간 : 2023. 01. 30 ~ 2023. 03. 03   
개발 인원 : 4명

## 개발 환경
### OS   
+ window 10
### IDE   
+ Eclipse
### Version Control  
+ Git
### Communication
+ Notion

## 사용 기술
### FrontEnd   
+ HTNL5/CSS3
+ BootStrap 5.3
+ JSP
+ JavaScript
+ jQuery
### BackEnd  
+ Java 11
+ Spring Boot 2.6.7
+ Spring Security 5.6.3
+ Mybatis 3.5.11
### DataBase
+ Oracle 21c
### Build Tool
+ Maven 4.0.0   

## 프로젝트 구조
### E-R Diagram
### Usecase Diagram
### Package Structure

## 주요 기능
### 게시판   
**게시글 목록**   
+ 페이징 처리
+ 한번에 보여줄 게시글 수, 정렬 옵션, 검색 옵션   

**게시글 작성**   
+ 유효성 검사(제목 혹은 내용이 비어있는지 체크)
+ 태그를 입력한 후 엔터키 누르면 등록
+ 이미 존재하는 태그인 경우 입력되지 않음
+ 여러 개의 파일 업로드 후, 개별로 취소 가능   

**게시글 상세보기**   
+ 토글 버튼으로 추천 및 스크랩 (Ajax 요청)
+ 태그버튼 클릭 시, 해당 태그로 게시글 검색
+ 파일 다운로드   
+ 댓글 작성/수정/삭제 및 추천 (Ajax 요청)

**게시글 수정**   
+ 기존 태그 유지 및 변경
+ 기존에 업로드 된 파일 취소 및 새 파일 업로드   

**관리자 모드**   
+ 모든 게시글, 댓글 삭제 가능
+ 사용자 혹은 관리자가 삭제한 게시글 복원 및 영구삭제

## 실행 화면
### 공통
| ![로그인](https://user-images.githubusercontent.com/119988634/224609165-c1db1890-cfff-43de-aac5-17e8183d3db7.png) | ![홈](https://user-images.githubusercontent.com/119988634/224609217-c4be3132-9b7d-41ba-81c9-3f933ed5dc95.png) |
|:--------:|:-------------:|
| 로그인 | 메인 페이지 |

### 게시판
| ![게시글 목록](https://user-images.githubusercontent.com/119988634/224613420-dd76ab16-3833-46b8-9148-cf8e3b6dc56f.png) | ![게시글 작성(유효성 검사)](https://user-images.githubusercontent.com/119988634/224613440-8f920207-1ddb-45fe-9cfb-c45ae3cdf8d3.gif) | ![게시글 작성(태그 입력, 파일 업로드)](https://user-images.githubusercontent.com/119988634/224615052-97937b85-15fb-4557-a7fb-a872a667aec4.gif) |
|:-:|:-:|:-:|
| 게시글 목록 | 게시글 작성(유효성 검사) | 게시글 작성(태그 입력/파일 업로드) |
| ![게시글 상세보기(추천, 스크랩)](https://user-images.githubusercontent.com/119988634/224613664-eb7dbd37-859f-4751-9195-70895e7433ca.gif) | ![게시글 상세보기(태그,파일다운로드)](https://user-images.githubusercontent.com/119988634/224613673-4d730cdf-fed7-4357-bf85-d8fdbe441dc3.gif) | ![게시글 수정](https://user-images.githubusercontent.com/119988634/224613683-874993a9-d58e-438c-b035-0513803f48c5.gif) |
| 게시글 상세보기(추천/스크랩) | 게시글 상세보기(태그 클릭/파일 다운로드) | 게시글 수정 |
| ![댓글(작성,수정,삭제)](https://user-images.githubusercontent.com/119988634/224615352-d4507ba2-9b34-4637-bfb3-7a4fdba8e493.gif) | ![댓글(추천)](https://user-images.githubusercontent.com/119988634/224615360-b015645b-22c7-4d79-ad39-ae09fc97cb58.gif) | ![게시판 활동내역(알림)](https://user-images.githubusercontent.com/119988634/224615380-32cee5a8-9eb9-46a6-8f43-18dd8c27cb75.png) |
| 댓글(작성/수정/삭제) | 댓글(추천) | 게시판 활동내역(알림) |
| ![게시판  활동내역(내가 쓴 글)](https://user-images.githubusercontent.com/119988634/224615485-b8300670-17d9-48ce-91f3-1425a9c568c2.png) | ![게시판 활동내역(내가 쓴 댓글)](https://user-images.githubusercontent.com/119988634/224615498-d80e913f-c7ab-478c-a70b-28e97b4b57f9.png) | ![게시판 활동내역(스크랩)](https://user-images.githubusercontent.com/119988634/224615523-40a93ed4-a5b8-4f3f-92fc-ac7ec9b53058.png) |
| 게시판 활동내역(내가 쓴 글) | 게시판 활동내역(내가 쓴 댓글) | 게시판 활동내역(스크랩) |

### 게시판(관리자)
| ![게시글 상세보기(관리자모드)](https://user-images.githubusercontent.com/119988634/224618629-6659bddf-2de6-4a56-99ad-341f2122ac33.png) | ![게시글 복원 및 삭제(관리자모드)](https://user-images.githubusercontent.com/119988634/224617290-3449124b-9a1d-4839-9ef1-ce7c220fe5cf.png) |
|:-:|:-:|
| 게시글 상세보기 | 게시글 복원 및 영구삭제 |

## 이슈
### 1. 업로드된 파일의 중복 방지
+ **배경**   
  + 사용자가 업로드한 파일명이 서버에 이미 존재하는 파일명과 같다면, 새로 업로드한 파일이 기존 파일에 덮어씌워지는 문제가 있음.   
  
+ **해결 방법**   
  + 업로드 파일에 대한 컬럼을 사용자가 업로드한 파일명과 서버에 저장되는 파일명으로 구분 (POST_ORIGINAL_FILENAME, POST_SAVED_FILENAME)
  + Java의 UUID를 통해 파일명에 임의의 32자리 문자열을 추가해서 [서버에 업로드](https://github.com/yjk490/SmartOffice-HTA/blob/main/src/main/java/com/example/web/controller/PostController.java#L73)되도록 구현하고, DB에는 원래 파일명과 서버에 저장된 파일명 둘 다 저장
  + [파일을 다운로드](https://github.com/yjk490/SmartOffice-HTA/blob/main/src/main/java/com/example/web/view/FileDownloadView.java#L19)할 때는 UUID를 통해 생성한 문자열을 제거한 원래 파일명을 전달   
  
+ **아쉬운 점**
  + 업로드 파일 테이블의 기본키가 임의의 32자리 문자열을 포함한 파일명이기 때문에 서버에 저장된 파일이 증가하면 파일명 검색성능이 저하될 것으로 예상한다.     

### 2. 업로드된 파일 정보를 어떻게 DB까지 전달할 것인가?
+ **배경**  
  + 업로드된 파일 정보를 DB에 저장하기 위해서는 원래 파일명과 서버에 저장될 파일명 두 개 저장해야 한다.   
  + 이를 위해 브라우저로부터 작성된 게시글 정보를 받는 PostRegisterForm 클래스의 멤버 변수에 원래 파일명(originalFileName)과 저장될 파일명(savedFileName)을 저장하는 List 두 개를 정의했다.
  + 그러나 두 개의 파일명은 같은 파일을 표현하기 때문에 반드시 쌍으로 저장되어야 한다. 따라서 List를 사용하는 것은 프로그램의 안정성 측면에서 부적절하다고 판단했다.   
  
+ **해결 방법**   
  + 두 개의 파일명을 저장하기 위한 Map객체를 [PostRegisterForm](https://github.com/yjk490/SmartOffice-HTA/blob/main/src/main/java/com/example/web/request/PostRegisterForm.java#L16)클래스의 멤버변수로 정의
  + 중복 불가능한 savedFileName을 Key에 저장하고 originalFileName을 Value에 저장
  + [entrySet()을 통해](https://github.com/yjk490/SmartOffice-HTA/blob/main/src/main/java/com/example/service/PostService.java#L103) Key, Value 둘 다 조회해서 업로드 파일을 표현하는 VO클래스인 AttachedFile에 저장   
  
+ **DTO를 사용하지 않은 이유**   
  + PostRegisterForm클래스 내에 두 종류의 파일명을 멤버변수로 갖는 또 다른 DTO를 정의할 수도 있다. 그러나 DTO 내부에 또 DTO를 담는 것은 가독성과 유지보수 측면에서 부적절한다고 판단했기 때문이다.
  
+ **배운 점**
  + 그 동안 Map을 Key를 통해 Value를 조회하는 데에만 사용했으나, 이번 계기로 Map의 새로운 활용에 대해 깨달았다.

### 3. 브라우저에서 선택한 파일을 부분적으로 취소할 수 있도록 구현했으나 정상적으로 동작하지 않음
+ **배경 및 문제점**   
  + input태그의 file타입으로 업로드할 파일을 선택하는 경우, 기본적으로는 파일의 개별 취소가 불가능하다. 이러한 점은 사용자 경험에 좋지 않다고 생각하여 선택한 파일을 부분적으로 취소가 가능하도록 구현할 필요성을 느꼈다.   
  + 그러나 업로드 순서의 역순으로 취소할 때만 정상 동작하고, 순서가 뒤바뀌면 파일이 두 개 남았을 때부터 취소가 안 되었다.
  
+ **구현 방법**  
  + 업로드 된 파일의 인덱스를 html 태그의 data 속성에 저장
  + `<input type=file>` 요소의 files 속성으로 fileList객체를 조회하고 그 객체를 JavaScript의 배열로 변환
  + 삭제할 파일을 클릭하면 해당 태그의 data 속성에서 파일 인덱스 값을 가져오고 해당 파일을 배열에서 삭제
  + dataTransfer객체를 생성하고, 삭제 처리가 완료된 배열을 dataTransferItemList에 저장
  + dataTransferItemList를 다시 <input type=file>요소의 files 속성에 저장  
  
+ **원인**  
  + 삭제하려는 파일의 인덱스를 기반으로 새로운 파일 리스트를 생성하기 때문이다. 즉, 업로드 시점의 인덱스와 삭제 후 재생성된 파일 리스트의 인덱스가 다르기 때문이다.  
  + 예를 들어, [파일1, 파일2, 파일3] 을 차례로 업로드한 후, 파일2를 삭제한다고 가정하자. 그러면 파일2의 인덱스는 1이므로 파일 리스트가 재생성되면 파일1은 인덱스가 그대로 0이겠지만 파일3은 인덱스1을 부여받는다. 인덱스가 2에서 1로 바뀐 것이다.  그러나 파일을 삭제할 때 기준이되는 인덱스는 파일 최초 생성시 부여받은 인덱스를 html 태그의 data 속성에 저장해서 사용하므로 파일3을 삭제하려고 클릭하면 인덱스2가 전달된다. 그래서 파일3을 클릭해도 새로운 파일리스트에는 인덱스2가 없으므로 파일3이 삭제가 되지 않는 것이다.   
  
+ **해결 방법**   
  + html 태그의 data속성에 파일 리스트의 인덱스가 아니라 파일 이름을 저장한다.   

+ **배운 점**   
  + FileList 객체는 유사 배열 객체이기 때문에 JavaScript의 배열처럼 다룰 수 없다.
  + 또한 읽기 전용 객체이기 때문에 FileList에 저장된 파일정보를 조작할 수 없다.   
  
## 리팩토링 및 업데이트 계획   
1. 게시판 관련 로직 가독성 개선 및 중복코드 제거
2. 게시판을 제외한 나머지 기능에 대한 코드 파악
3. UserRole과 AdminRole을 고려하여 패키지 재정리
4. 미구현 기능 완성 및 오류 수정




