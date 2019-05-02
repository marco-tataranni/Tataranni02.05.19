<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*,java.text.*"%>
<!DOCTYPE html>
<html>
<head>
    <title></title>
</head>
<body>
    <%
        String connectionUrl = "jdbc:sqlserver://213.140.22.237\\SQLEXPRESS:1433;databaseName=XFactor;user=tataranni.marco;password=xxx123#";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        Connection connection = DriverManager.getConnection(connectionUrl);
       
        String sql = "SELECT * FROM Cittadino where Username=? and Password=?";
		PreparedStatement st = connection.prepareStatement(sql);
    	st.setString(1, request.getParameter("user"));
    	st.setString(2, request.getParameter("psw"));
    	ResultSet rs = st.executeQuery(); 	
		
		
		if (rs.next())
		{
		   String sql1="SELECT Evento.* From ((Comunicazione INNER JOIN Evento on Evento.ID=Comunicazione.IDE)INNER JOIN Cittadino on Cittadino.ID=Comunicazione.IDC)WHERE Cittadino.ID=?";
		   PreparedStatement st1 = connection.prepareStatement(sql1);
    	   st1.setInt(1, rs.getInt("ID"));
  
    	   ResultSet rs1 = st.executeQuery();		
    	   out.print("<table>");
			
		   out.print("<tr><th align=left>Titolo</th><th align=left>Descrizione</th><th align=left>Data</th>");
			
    	   while(rs1.next()){

			  String Nome = rs1.getString("nome");
			  String Descrizione = rs1.getString("descrizione");
    		  String Data = rs1.getString("data");
    		  
                
                out.print("<tr><td>" + Nome + "</td><td>" + Descrizione + "</td><td>" + Data + "</td></tr>");
	       }
	        
	     out.print("</table>");
	        
		 rs1.close();
    	}else
		{
		    out.print("Utente non riconosciuto");
		}
		
		 rs.close();
	        
	     connection.close();
    %>

</body>
</html>