<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%!
    String server = "jdbc:mysql://localhost/"; // MySQL 서버 주소
    String database = "University"; // MySQL DATABASE 이름
    String user_name = "root"; //  MySQL 서버 아이디
    String password = ""; // MySQL 서버 비밀번호

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    String studentID = "1";   // Given by request or session(처음에 로그인 시 세션 등록)
%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[강의등록_추가 및 제거] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[강의등록_추가 및 제거] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[강의등록_추가 및 제거] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
    /*
    // 3.해제
    try {
        if(con != null)
            con.close();
    } catch (SQLException e) {}
    */
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
            rs = st.executeQuery(query);
            if(rs.next()){
                // 하나라도 이미 수강한 상태의 경우
                System.out.println("[강의등록_추가 : 강의 등록] 이미 수강중인 강의");
            }
            else{
                query = "insert into enroll values ('" + studentID + "','" + val + "')";
                st.executeUpdate(query);
                System.out.println("[강의등록_추가 : 강의 등록] 강의 동록 완료");
            }
        }
        response.sendRedirect("enroll.jsp");
    }
    else if(value == null && value2 != null){
        // 수강 포기 시
        for(String val : value2){
            query = "delete from enroll where Sid='" + studentID +"' AND Cid='" + val + "'";
            st.executeUpdate(query);
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
