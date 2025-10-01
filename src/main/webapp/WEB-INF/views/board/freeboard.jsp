<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
 String nickname = "";
  Object userObj = session.getAttribute("loginUser");
  if (userObj != null) {
    net.koreate.hellking.user.vo.UserVO user = (net.koreate.hellking.user.vo.UserVO) userObj;
    nickname = user.getUsername(); // 또는 getUsername() → 실제 닉네임 필드에 맞게
  } else {
  }
%>
<%
  boolean isLoginUser = (session.getAttribute("loginUser") != null);
%>
<script>
  function logincheck() {
    const isLoginUser = <%= isLoginUser %>;
    if (!isLoginUser) {
      alert("로그인한 사용자만 이용할 수 있습니다.");
      location.href = "<%=request.getContextPath()%>/user/login";
      return;
    }
    location.href = "<%=request.getContextPath()%>/board/register";
  }
</script>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
<div class="board-container">
  <!-- 좌측 카테고리 -->
  <div class="category">
    <aside class="category-menu">
      <ul>
        <li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
      </ul>
    </aside>
  </div>

  <!-- 우측 게시판 테이블 -->
  <div class="board-content">
    <table>
      <tr><th class="boardtitle">자유 게시판</th></tr>
      <tr><td>자유롭게 대화를 나눌수있는 게시판입니다.</td></tr>
      <tr>
      	<td colspan="6">
		  <form action="${pageContext.request.contextPath}/board/freeboard" method="get" class="search-form">
		  	<select name="searchType">
		    <option value="bno">글번호</option>
		    <option value="title">제목</option>
		    <option value="nickname">작성자</option>
		  	</select>
		  <input type="text" name="keyword" placeholder="검색어를 입력하세요" />
		  <button type="submit">검색</button>
		</form>
	   </td>
	 </tr>
      <tr class="standardboard">
		<th>글번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
		<th>추천수</th>
      </tr>
      <c:forEach items="${allList}" var="list">
        <tr>
          <td>${list.bno}</td>
          <td><a href="readPage?bno=${list.bno}">${list.title}</a></td>
          <td>${list.nickname}</td>
          <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
          <td>${list.viewcnt}</td>
          <td>${list.agree}</td>
        </tr>
      </c:forEach>
    </table>
    
    <c:if test="${not empty sessionScope.loginUser}">
    <button id="registbutton" onclick="logincheck()">게시물 작성</button>
    </c:if>
    
    <div class="pagination">
		<div class="pagination">
			<!-- 처음 -->
			<c:if test="${pm.first}">
			  <a href="?page=1&perPageNum=${pm.cri.perPageNum}">처음</a>
			</c:if>
			
			<!-- 이전 -->
			<c:if test="${pm.prev}">
			  <a href="?page=${pm.cri.page - 1}&perPageNum=${pm.cri.perPageNum}">이전</a>
			</c:if>
			
			<!-- 다음 -->
			<c:if test="${pm.next}">
			  <a href="?page=${pm.cri.page + 1}&perPageNum=${pm.cri.perPageNum}">다음</a>
			</c:if>
			
			<!-- 마지막 -->
			<c:if test="${pm.last}">
			  <a href="?page=${pm.maxPage}&perPageNum=${pm.cri.perPageNum}">마지막</a>
			</c:if>
		</div>
	   </div>
  </div>
</div>

</body>
</html>