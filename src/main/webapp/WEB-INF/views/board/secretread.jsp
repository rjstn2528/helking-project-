<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

  <!-- 작성자 / 날짜 -->
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

  <!-- 추천 (익명도 가능) -->
  <div class="reaction-section">
    <button id="agree-btn-${list.bno}" onclick="plusAgree(${list.bno})">추천 👍</button>
    <span id="agree-count">${list.agree}</span>
  </div>

  <!-- 수정/삭제 버튼 (비밀번호 확인 필요) -->
  <div class="button-group">
    <button type="button" onclick="showPasswordForm('modify')">수정</button>
    <button type="button" onclick="showPasswordForm('remove')">삭제</button>
  </div>

  <!-- 비밀번호 확인 폼 (기본 숨김) -->
  <div id="password-check" style="display:none; margin-top:10px;">
    <form id="passwordForm" method="post">
      <input type="hidden" name="bno" value="${list.bno}">
      <input type="password" name="password" placeholder="비밀번호 입력" required>
      <button type="submit">확인</button>
    </form>
  </div>

  <div class="divider"></div>

  <!-- 댓글 영역 -->
  <div class="comment-section">
    <h3>댓글</h3>

    <!-- 댓글 입력창 (로그인 안 해도 가능) -->
    <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
      <input type="hidden" name="bno" value="${list.bno}" />
      <input type="text" name="username" placeholder="닉네임 입력" required />
      <textarea name="content" rows="3" placeholder="댓글을 입력하세요"></textarea>
      <button type="submit">댓글 등록</button>
    </form>

    <!-- 댓글 목록 -->
    <c:forEach var="comment" items="${comments}">
      <div class="comment-item depth-${comment.depth}">
        <div class="comment-meta">
          <b>${comment.username}</b>
          <span><fmt:formatDate value="${comment.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
        </div>

        <div class="comment-content" id="content-view-${comment.cno}">
          ${comment.content}
        </div>

        <div class="comment-actions">
          <div class="left-actions">
            <button type="button" class="reply-btn" data-cno="${comment.cno}">답글</button>
          </div>
          <div class="right-actions">
            <!-- 익명 댓글도 비밀번호 확인 후 수정/삭제 -->
            <button type="button" onclick="showPasswordForm('commentModify', ${comment.cno})">수정</button>
            <button type="button" onclick="showPasswordForm('commentRemove', ${comment.cno})">삭제</button>
          </div>
        </div>

        <!-- 답글 작성 폼 -->
        <form id="reply-form-${comment.cno}" class="reply-form"
              action="${pageContext.request.contextPath}/comment/reply" method="post" hidden>
          <input type="hidden" name="parentCno" value="${comment.cno}" />
          <input type="hidden" name="bno" value="${list.bno}" />
          <input type="text" name="username" placeholder="닉네임 입력" required />
          <textarea name="content" rows="3" placeholder="답글을 입력하세요"></textarea>
          <button type="submit">답글 등록</button>
        </form>
      </div>
    </c:forEach>

    <c:if test="${empty comments}">
      <p>아직 댓글이 없습니다.</p>
    </c:if>
  </div>
</div>

<script>
// 추천
function plusAgree(bno){
  fetch("${pageContext.request.contextPath}/board/secretagree?bno=" + bno, {method: "POST"})
    .then(res => res.json())
    .then(data => {
      document.getElementById("agree-count").innerText = data;
    })
    .catch(() => alert("추천 실패"));
}

// 답글 토글
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

// 비밀번호 확인 처리
function showPasswordForm(action, cno = null){
  const form = document.getElementById("passwordForm");
  if(action === 'modify'){
    form.action = "${pageContext.request.contextPath}/board/secretmodify";
  } else if(action === 'remove'){
    form.action = "${pageContext.request.contextPath}/board/secretremove";
  } else if(action === 'commentModify'){
    form.action = "${pageContext.request.contextPath}/comment/secretModify?cno=" + cno;
  } else if(action === 'commentRemove'){
    form.action = "${pageContext.request.contextPath}/comment/secretRemove?cno=" + cno;
  }
  document.getElementById("password-check").style.display = "block";
}
</script>
</body>
</html>
