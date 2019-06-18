<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String profID = null;
	profID = (String)session.getAttribute("id");
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
<form action="Pmaterial_add.jsp" method="post" enctype="Multipart/form-data">
    <p>제목 <input type="text" name="title" id="title"></p>
    <hr>
    <p>내용 <input type="textbox" name="content" id="content"></p>
    <hr>
    <p>첨부파일 : <input type="file" name="fileName" id="fileName"></p>
    <input type="hidden" id="courseID" name="courseID" value="<%=request.getParameter("cid")%>">
    <input type="submit" value="등록">
</form>
</body>
</html>