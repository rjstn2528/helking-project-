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

  <!-- 추천 -->
  <c:if test="${not empty sessionScope.loginUser}">
    <div class="reaction-section">
      <button id="agree-btn-${list.bno}" onclick="plusAgree(${list.bno})">추천 👍</button>
      <span id="agree-count">${list.agree}</span>
    </div>
  </c:if>
  <c:if test="${empty sessionScope.loginUser}">
    <p style="color: gray;">로그인한 사용자만 추천할 수 있습니다.</p>
  </c:if>

  <!-- 수정/삭제 버튼 (작성자 본인만 가능) -->
  <c:if test="${not empty sessionScope.loginUser 
                and sessionScope.loginUser.userId == list.userId}">
    <div class="button-group">
      <form action="localmodify" method="get">
        <input type="hidden" name="bno" value="${list.bno}">
        <button type="submit">수정</button>
      </form>
      <form action="localremove" method="post">
        <input type="hidden" name="bno" value="${list.bno}">
        <button type="submit">삭제</button>
      </form>
    </div>
  </c:if>

  <div class="divider"></div>

  <!-- 댓글 영역 -->
  <div class="comment-section">
    <h3>댓글</h3>

    <!-- 댓글 입력창 -->
    <c:if test="${not empty sessionScope.loginUser}">
      <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
        <input type="hidden" name="bno" value="${list.bno}" />
        <input type="text" name="username" value="${sessionScope.loginUser.username}" readonly />
        <textarea name="content" rows="3" placeholder="댓글을 입력하세요"></textarea>
        <button type="submit">댓글 등록</button>
      </form>
    </c:if>
    <c:if test="${empty sessionScope.loginUser}">
      <p style="color: gray;">로그인한 사용자만 댓글을 작성할 수 있습니다.</p>
    </c:if>

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
            <c:if test="${not empty sessionScope.loginUser}">
              <button type="button" class="reply-btn" data-cno="${comment.cno}">답글</button>
            </c:if>
          </div>
          <div class="right-actions">
            <c:if test="${not empty sessionScope.loginUser 
                          and sessionScope.loginUser.userId == comment.userId}">
              <button type="button" class="edit-btn" data-cno="${comment.cno}">수정</button>
              <form action="${pageContext.request.contextPath}/comment/delete" method="post">
                <input type="hidden" name="cno" value="${comment.cno}" />
                <input type="hidden" name="bno" value="${list.bno}" />
                <button type="submit">삭제</button>
              </form>
            </c:if>
          </div>
        </div>

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
// 추천 기능
function plusAgree(bno){
  fetch("${pageContext.request.contextPath}/board/localagree?bno=" + bno, {method: "POST"})
    .then(res => res.json())
    .then(data => {
      document.getElementById("agree-count").innerText = data;
    })
    .catch(err => alert("추천 실패"));
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
</script>
</body>
</html>
