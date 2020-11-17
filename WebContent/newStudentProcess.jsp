<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Portal</title>
</head>
<body>
	<%
		boolean login = false;

	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "db1?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	String userId = "root";
	String password = "Database2019";

	Connection connection = null;
	Statement statement = null;

	try {

		Class.forName(driverName);
		connection = DriverManager.getConnection(connectionUrl + dbName, userId, password);

		PreparedStatement stmt = connection.prepareStatement("insert into student(id, password, name, department,  malay, english, math, science) values (?,?,?,?,?,?,?,?)");
		stmt.setString(1, request.getParameter("newid"));
		stmt.setString(2, request.getParameter("newpassword"));
		stmt.setString(3, request.getParameter("newname"));
		stmt.setString(4, request.getParameter("newdepartment"));
		stmt.setString(5, request.getParameter("malay"));
		stmt.setString(6, request.getParameter("english"));
		stmt.setString(7, request.getParameter("math"));
		stmt.setString(8, request.getParameter("science"));

		
		System.out.println(stmt);
		
		int row = stmt.executeUpdate();
		
		//if password is updated 1 or more
		if (row>0){
			out.println(row + " row(s) changed");
		}
		else{
			out.println("Failed to change row");
		}
		%>
		
		<p>New updated table: </p>
		
		<%
		statement = connection.createStatement();
		ResultSet rs = statement.executeQuery("select id, name, department, malay, english, math, science, avg_marks from student");
	%>
	<p></p>
	<a href="newStudent.jsp">
		<button type='edit'>Add New Student</button>
	</a>
	<p></p>
	<table id="students">
		<table border="1">
			<tr>
				<th>Student ID</th>
				<th>Name</th>
				<th>Department</th>
				<th>Malay</th>
				<th>English</th>
				<th>Science</th>
				<th>Math</th>
				<th>Average Marks</th>
			</tr>
			<%
				while (rs.next()) {
			%>
			
			<%
			
			double averageMarks = (rs.getDouble("malay") + rs.getDouble("english") + rs.getDouble("science") + rs.getDouble("math"))/4;
			
			%>

			<tr>
				<td><%=rs.getString("id")%></td>
				<td><%=rs.getString("name")%></td>
				<td><%=rs.getString("department")%></td>
				<td><%=rs.getString("malay")%></td>
				<td><%=rs.getString("english")%></td>
				<td><%=rs.getString("science")%></td>
				<td><%=rs.getString("math")%></td>
				<td><%=averageMarks%></td>
			<tr>

				<%
					}
				%>
			
		</table>

		<%
			} catch (Exception e) {
			out.println(e.getMessage());
		}
		
		%>
		
</body>
</html>
