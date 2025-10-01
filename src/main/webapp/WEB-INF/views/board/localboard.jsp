<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/localboardstyle.css">
  <meta charset="UTF-8">
  <title>지역 게시판</title>
</head>
<body>
<div class="board-container">

  <!-- 좌측 카테고리 -->
  <div class="category">
    <aside class="category-menu">
      <ul>
        <li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
        <li><a href="${pageContext.request.contextPath}/board/localboard" class="active">지역게시판</a></li>
      </ul>
    </aside>
  </div>

  <!-- 우측 게시판 영역 -->
  <div class="board-content">
    <h2 class="boardtitle">지역 게시판</h2>
    <p class="board-desc">지역별로 카테고리를 나누어 소통할 수 있는 게시판입니다.</p>

    <!-- 검색/지역 선택 -->
    <form action="${pageContext.request.contextPath}/board/localboard" method="get" class="search-form">
      <select name="categoryId">
        <option value="0" ${pm.cri.categoryId == 0 ? 'selected' : ''}>전체</option>
        <option value="1">서울</option>
        <option value="2">부산</option>
        <option value="3">대구</option>
        <option value="4">인천</option>
        <option value="5">광주</option>
        <option value="6">대전</option>
        <option value="7">울산</option>
        <option value="8">수원</option>
        <option value="9">성남</option>
        <option value="10">청주</option>
        <option value="11">천안</option>
        <option value="12">전주</option>
        <option value="13">군산</option>
        <option value="14">순천</option>
        <option value="15">목포</option>
      </select>

      <!-- 🔎 검색 카테고리 확장 -->
      <select name="searchType">
        <option value="bno">글번호</option>
        <option value="title">제목</option>
        <option value="nickname">작성자</option>
      </select>

      <input type="text" name="keyword" placeholder="검색어 입력" />
      <button type="submit">검색</button>
    </form>

    <!-- 게시글 목록 -->
    <table>
      <thead>
        <tr class="standardboard">
          <th>글번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회수</th>
          <th>추천수</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${allList}" var="list">
          <tr>
            <td>${list.bno}</td>
            <td><a href="localreadPage?bno=${list.bno}">${list.title}</a></td>
            <td>${list.nickname}</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
            <td>${list.viewcnt}</td>
            <td>${list.agree}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>

    <button id="registbutton" onclick="location.href='localregister';">게시물 작성</button>

    <!-- 페이지네이션 -->
    <div class="pagination">
      <c:if test="${pm.prev}">
        <a href="?page=${pm.cri.page - 1}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}">이전</a>
      </c:if>
      <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="p">
        <a href="?page=${p}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}" 
           class="${pm.cri.page == p ? 'active' : ''}">${p}</a>
      </c:forEach>
      <c:if test="${pm.next}">
        <a href="?page=${pm.cri.page + 1}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}">다음</a>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>
