<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%!
    String server = "jdbc:mysql://localhost/"; // MySQL 서버 주소
    String database = "University"; // MySQL DATABASE 이름
    String user_name = "root"; //  MySQL 서버 아이디
    String password = ""; // MySQL 서버 비밀번호

    Connection con = null;
    Statement st = null;
    ResultSet rs = null;

    String profID = "3456789012";   // Given by request ( or Session)
    String courseID;
    String materialNo;

    String title;
    String content;
    String date;
    String views;

    String attachment;

%>
<%
    // 1.드라이버 로딩
    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        System.err.println("[첨부파일 다운로드] Driver load 오류 : " + e.getMessage());
    }

    // 2.연결
    try {
        con = DriverManager.getConnection(server + database + "?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false", user_name, password);
        System.out.println("[첨부파일 다운로드] 데이터베이스 연결 완료.");
    } catch(SQLException e) {
        System.err.println("[첨부파일 다운로드] getConnection 오류 :" + e.getMessage());
    }
    st = con.createStatement();
%>
<%
    System.out.println("[첨부파일 다운로드] 시작 ==========");
    String fileName = request.getParameter("filename");
    System.out.println("[첨부파일 다운로드] 파일 이름 : " + fileName);

    ServletContext context = getServletConfig().getServletContext();
    String sDownPath = context.getRealPath("upload");

    String sFilePath = sDownPath + "/" + fileName;
    System.out.println("저장 Servlet 파일 경로 " + sDownPath + "/" + fileName);
    File oFile = new File(sFilePath);
    byte []b = new byte[30 * 1024 * 1024];

    FileInputStream in = new FileInputStream(oFile);
    String sMimeType = getServletConfig().getServletContext().getMimeType(sFilePath);
    System.out.println("유형 : " + sMimeType);

    // 지정되지 않은 유형 예외처리
    if(sMimeType == null){
        sMimeType = "application.octec-stream";
    }

    // 파일 다운로드 시작
    // 유형 지정
    response.setContentType(sMimeType); // text/html; charset=utf-8 대체

    String A = new String(fileName.getBytes("euc-kr"),"8859_1");
    String B = "utf-8";
    String sEncoding = URLEncoder.encode(A,B);

    // 헤더 설정
    String AA = "Content-Disposition";
    String BB = "attachment; filename=" + sEncoding;
    response.setHeader(AA,BB);

    // 브라우저에 쓰기
    ServletOutputStream out2 = response.getOutputStream();

    int numRead = 0;
    while((numRead = in.read(b,0,b.length)) != -1){
        out2.write(b, 0, numRead);
    }
    out2.flush();
    out2.close();
    in.close();

    System.out.println("[첨부파일 다운로드] 완료 ==========");
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
</body>
</html>