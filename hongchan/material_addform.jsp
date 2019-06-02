<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%!
    String profID = "3456789012";   // Given by request ( or Session)
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
<%
    // 여기서는 데이터베이스 연동 x, add.jsp에서만 연동
    // 제목, 내용, 강의 아이디 보내기 /// 등록일 = 시간 가져오기, 조회수 = 0, 밑에 작성한 게시글 번호 계산
    // 보낼 때 hidden 타입으로 value만 보내기
%>
<form action="material_add.jsp" method="get">
    <p>제목 <input type="text" name="title" id="title"></p>
    <hr>
    <p>내용 <input type="textbox" name="content" id="content"></p>
    <hr>
    <p>첨부파일 <input type="text" name="attachment" id="attachment"></p>
    <input type="hidden" id="courseID" name="courseID" value="<%=request.getParameter("cid")%>">
    <input type="submit" value="등록">
</form>
</body>
</html>