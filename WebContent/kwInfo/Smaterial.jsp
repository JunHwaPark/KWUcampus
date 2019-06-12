<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2019-05-31
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <%
    out.println("id : " + session.getAttribute("id"));
    out.println("<br>");
    out.println("name : " + session.getAttribute("name"));
  %>
  <a href="note.jsp">쪽지</a>
  </body>
</html>