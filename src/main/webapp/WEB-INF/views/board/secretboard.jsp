<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>익명 게시판</title>
</head>
<body>
<div class="board-container">
  <div class="category">
    <aside class="category-menu">
      <ul>
        <li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
      </ul>
    </aside>
  </div>

  <div class="board-content">
    <table>
      <tr><th class="boardtitle">익명 게시판</th></tr>
      <tr><td>로그인하지 않고도 자유롭게 이용할 수 있는 게시판입니다.</td></tr>
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
          <td><a href="secretreadPage?bno=${list.bno}">${list.title}</a></td>
          <td>${list.nickname}</td>
          <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
          <td>${list.viewcnt}</td>
          <td>${list.agree}</td>
        </tr>
      </c:forEach>
    </table>
    <button id="registbutton" onclick="location.href='secretregister';">게시물 작성</button>
  </div>
</div>
</body>
</html>
