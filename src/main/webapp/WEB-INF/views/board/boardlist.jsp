<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
      <tr><th class="boardtitle">인기 게시글</th></tr>
      <tr><td>주간 최신 인기글을 만나보세요</td></tr>
      <tr class="standardboard">
        <th>실시간 인기글!!!</th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
        <th></th>
      </tr>
      <c:forEach items="${hotlist}" var="list">
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
  </div>
</div>

</body>
</html>