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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width initial-scale=1">
    <link rel="stylesheet" href="css/bootstrap.css">
    <title>$Title$</title>
  </head>
  <body>
        <form method="post" action="loginAction.jsp">
          <h3 style="text-align: center">로그인 화면</h3>
          <div class="form-group">
            사용자 구분 <select name="user_code" id="user_code" tabindex="1">
            <option value="1" >학부생</option>
            <option value="2" >교수</option>
          </select>
          </div>
          <div class="form-group">
            <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
          </div>
          <div class="form-group">
            <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
          </div>
          <input type="submit" class="btn btn-primary form-control" value="로그인">

        </form>
      <script src="https://code.jquery.com/jquery-3.1.1.min.js">
      </script>
      <script src="js/bootstrap.js"></script>
  </body>
</html>
