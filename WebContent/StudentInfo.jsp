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

		PreparedStatement stmt = connection.prepareStatement("select name from student where id =? and password =?");
		stmt.setString(1, request.getParameter("id"));
		stmt.setString(2, request.getParameter("password"));

		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			login = true;
		}

	} catch (Exception e) {
		out.println(e.getMessage());
	}

	if (login) {
	%>
	<%
		out.println("Hello ");
	%>

	<%=request.getParameter("id")%>

	, your password is

	<%=request.getParameter("password")%>

	<%
		try {
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
		} else {
		%>
		<p>
			Login failed! <a href="StudentInfo.html">Login back?</a>
		</p>
		<%
			}
		%>
		</p>
</body>
</html>
