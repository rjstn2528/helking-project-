<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="net.koreate.hellking.board.vo.BoardVO" %>
<%
  BoardVO vo = (BoardVO) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/readstyle.css">
  <meta charset="UTF-8">
  <title>${list.title}</title>
</head>
<body>
<div class="board-content">

  <!-- 제목 -->
  <h2 class="boardtitle">${list.title}</h2>

  <!-- 작성자/날짜 -->
  <div class="post-meta">
    <span class="nickname">${list.nickname}</span>
    <span class="regdate">
      <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.regdate}" />
    </span>
  </div>

  <!-- 본문 -->
  <div class="post-content">
    ${list.content}
  </div>

  <!-- 첨부파일 -->
  <c:if test="${not empty list.files}">
    <div class="file-section">
      <h3>첨부파일</h3>
      <ul class="file-list">
        <c:forEach var="file" items="${list.files}">
          <li>
            <a href="${pageContext.request.contextPath}/board/download?file=${file.savedName}&path=${file.uploadPath}">
              ${file.originalName}
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>
  </c:if>

	<!-- 추천 -->
	<div class="reaction-section">
	  <button id="agree-btn-${list.bno}" onclick="toggleAgree(${list.bno})">
	    추천 👍
	  </button>
	  <span id="agree-${list.bno}">${list.agree}</span>
	</div>
  <!-- 수정/삭제 -->
  <c:if test="${not empty sessionScope.loginUser 
                 and (sessionScope.loginUser.userId == list.userId
                  or sessionScope.loginUser.role == 'ADMIN')}">
	  <div class="button-group">
	    <button onclick="location.href='modify?bno=${list.bno}'">수정</button>
	    <button onclick="location.href='remove?bno=${list.bno}'">삭제</button>
	  </div>
	</c:if>
  <!-- 구분선 -->
  <div class="divider"></div>

  <!-- 댓글 영역 -->
  <div class="comment-section">
    <h3>댓글</h3>

    <!-- 댓글 입력 -->
    <c:if test="${not empty sessionScope.loginUser}">
    <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
      <input type="hidden" name="bno" value="${list.bno}" />
      <input type="text" name="username" value="${sessionScope.loginUser.username}" readonly />
      <textarea name="content" rows="3" placeholder="댓글을 입력하세요"></textarea>
      <button type="submit">댓글 등록</button>
    </form>
    </c:if>

<!-- 댓글 목록 (계층형) -->
<c:forEach var="comment" items="${comments}">
  <div class="comment-item depth-${comment.depth}">
    
    <!-- 작성자/날짜 -->
    <div class="comment-meta">
      <b>${comment.username}</b>
      <span><fmt:formatDate value="${comment.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
    </div>

    <!-- 댓글 내용 -->
    <div class="comment-content" id="content-view-${comment.cno}">
      ${comment.content}
    </div>

    <!-- 액션 버튼 -->
    <div class="comment-actions">
      <div class="left-actions">
        <button type="button" class="reply-btn" data-cno="${comment.cno}">답글</button>
      </div>
      <div class="right-actions">
        <button type="button" class="edit-btn" data-cno="${comment.cno}">수정</button>
        <form action="${pageContext.request.contextPath}/comment/delete" method="post">
          <input type="hidden" name="cno" value="${comment.cno}" />
          <input type="hidden" name="bno" value="${list.bno}" />
          <button type="submit">삭제</button>
        </form>
      </div>
    </div>
		<!-- 수정 폼 (기본 숨김) -->
		<form id="edit-form-${comment.cno}"
		      class="edit-form"
		      action="${pageContext.request.contextPath}/comment/update"
		      method="post"
		      style="display:none;">
		  <input type="hidden" name="cno" value="${comment.cno}" />
		  <input type="hidden" name="bno" value="${list.bno}" />
		  <textarea name="content" rows="3">${comment.content}</textarea>
		  <button type="submit">저장</button>
		  <button type="button" onclick="cancelEdit(${comment.cno}, '${comment.content}')">취소</button>
		</form>
    <!-- 답글 작성 폼 (기본 hidden) -->
    <form id="reply-form-${comment.cno}" 
          class="reply-form" 
          action="${pageContext.request.contextPath}/comment/reply" 
          method="post" hidden>
      <input type="hidden" name="parentCno" value="${comment.cno}" />
      <input type="hidden" name="bno" value="${list.bno}" />

      <div class="reply-form-inner">
        <input type="text" name="username" value="${sessionScope.loginUser.username}" readonly />
        <textarea name="content" rows="3" placeholder="답글을 입력하세요"></textarea>
        <button type="submit">답글 등록</button>
      </div>
    </form>
  </div>
</c:forEach>

    <c:if test="${empty comments}">
      <p>아직 댓글이 없습니다.</p>
    </c:if>
  </div>
</div>

<script>
// 추천 토글
function toggleAgree(bno){
  fetch("${pageContext.request.contextPath}/board/toggleAgree", {
    method: "POST",
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    body: "bno=" + bno
  })
  .then(res => res.json())
  .then(data => {
	    if(data.error){   // 서버에서 로그인 필요 전달한 경우
	        alert(data.error);
	        location.href = "${pageContext.request.contextPath}/user/login";
	        return;
	    }
    // data = { agreeCount: 숫자, liked: true/false }
    document.getElementById("agree-" + bno).innerText = data.agreeCount;

    const btn = document.getElementById("agree-btn-" + bno);
    if(data.liked){
      btn.innerText = "추천취소 👍";
      btn.style.backgroundColor = "#007BFF";
      btn.style.color = "#fff";
    }else{
      btn.innerText = "추천 👍";
      btn.style.backgroundColor = "";
      btn.style.color = "";
    }
  })
  .catch(err => {
    console.error(err);
    alert("추천 처리 실패! 로그인 하고 오세요 ☆");
  });
}

//답글 토글
document.querySelectorAll(".reply-btn").forEach(btn => {
  btn.addEventListener("click", function(){
    const cno = this.dataset.cno;
    const form = document.getElementById("reply-form-" + cno);
    if(form){
      form.style.display = (form.style.display === "none" || form.style.display === "") 
        ? "block" : "none";
    }
  });
});

//수정 버튼 클릭 시
document.querySelectorAll(".edit-btn").forEach(btn => {
  btn.addEventListener("click", function(){
    const cno = this.dataset.cno;

    // 댓글 내용 숨기기
    document.getElementById("content-view-" + cno).style.display = "none";

    // 수정 폼 보이기
    document.getElementById("edit-form-" + cno).style.display = "block";
  });
});

// 취소 버튼 눌렀을 때
function cancelEdit(cno, originalContent){
  document.getElementById("edit-form-" + cno).style.display = "none";
  const contentView = document.getElementById("content-view-" + cno);
  contentView.style.display = "block";
  contentView.innerText = originalContent;
}

</script>


</body>
</html>
