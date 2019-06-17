<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="dbPractice.Connect.DBConnect" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	String studentID = (String)session.getAttribute("id");
%>
<html>
<head>
    <title>수강신청 및 포기</title>
    <meta charset="utf-8">
</head>
<%
    String[] value = request.getParameterValues("enroll");
    String[] value2 = request.getParameterValues("giveup");

    String query;

    if(value != null && value2 == null){
        // 수강 신청 시
        for(String val : value){
            query = "select * from enroll where Sid='" + studentID +"' AND Cid='" + val + "'";
            rs = stmt.executeQuery(query);
            if(rs.next()){
                // 하나라도 이미 수강한 상태의 경우
                System.out.println("[강의등록_추가 : 강의 등록] 이미 수강중인 강의");
            }
            else{
                query = "insert into enroll values ('" + studentID + "','" + val + "')";
                stmt.executeUpdate(query);
                System.out.println("[강의등록_추가 : 강의 등록] 강의 동록 완료");
            }
        }
        response.sendRedirect("enroll.jsp");
    }
    else if(value == null && value2 != null){
        // 수강 포기 시
        for(String val : value2){
            query = "delete from enroll where Sid='" + studentID +"' AND Cid='" + val + "'";
            stmt.executeUpdate(query);
            System.out.println("[강의등록_추가 : 강의 포기] 강의 동록 완료");
        }
        response.sendRedirect("enroll.jsp");
    }
    else{
        // 아무것도 선택하지 않은 경우
        System.out.println("[강의등록_추가 및 제거] 아무것도 선택하지 않음");
        response.sendRedirect("enroll.jsp");
    }
%>
</html>
