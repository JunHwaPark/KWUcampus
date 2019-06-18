package dbPractice.note;

import java.sql.*;

public class Note_student {
	public static ResultSet getNoteList(Statement st, String Sid) throws SQLException {
		String query = "select Nno, CName, Pname from NOTE, COURSE, PROFESSOR "+ 
				"where note.Cid = COURSE.Cid and COURSE.Pid = PROFESSOR.Pid and Sid = \"" + Sid + "\";";
		System.out.println(query);
		//String query = "select * from student;";
		return st.executeQuery(query);
	}
	
	public static ResultSet getNoteContent(Statement st, String Sid, int Nno) throws SQLException {
		String query = "select Nno, Content, Pname from NOTE, COURSE, PROFESSOR " +
				"where note.Cid = COURSE.Cid and COURSE.Pid = PROFESSOR.Pid and Sid = \"" + Sid +
				"\" and Nno = " + Nno + ";";
		System.out.println(query);
		return st.executeQuery(query);
	}
}
