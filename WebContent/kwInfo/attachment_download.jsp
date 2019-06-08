<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="dbPractice.Connect.DBConnect" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	conn = DBConnect.getConnection();
	stmt = conn.createStatement();

	String profID = null;
	String courseID;
	String materialNo;
	profID = (String)session.getAttribute("id");

	String title;
	String content;
	String date;
	String views;

	String attachment;
	
    System.out.println("[첨부파일 다운로드] 시작 ==========");
    String fileName = request.getParameter("filename");
    System.out.println("[첨부파일 다운로드] 파일 이름 : " + fileName);

    ServletContext context = getServletConfig().getServletContext();
    String sDownPath = context.getRealPath("upload");

    String sFilePath = sDownPath + "/" + fileName;
    System.out.println("저장 Servlet 파일 경로 " + sDownPath + "\\" + fileName);
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
    
	//DB사용 후 close() 필수!
	stmt.close();
	rs.close();
	conn.close();
%>
<html>
<head>
    <meta charset="utf-8">
</head>
<body>
</body>
</html>