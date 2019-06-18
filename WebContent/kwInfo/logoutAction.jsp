<%@ page import="java.sql.*"%>
<%--
<%@ page import="java.sql.DriverManager" %>
  Created by IntelliJ IDEA.
  User: User
  Date: 2019-05-31
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>$Title$</title>
  </head>
  <body>
<%
    session.invalidate(); // 현재 생성된 세션 무효화
%>
  <script>
      location.href = "index.jsp"; // 시작 페이지로 이동
  </script>

  </body>
</html>
