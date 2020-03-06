<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">     <!-- Tres enlaces con librerias de JS de Bootstrap -->
   <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
     <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     <link rel="stylesheet" href="login.css">
     <link rel="stylesheet" href="dentistCRUD.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dentist CRUD</title>
</head>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="org.owasp.html.HtmlPolicyBuilder"%>
<%@ page import="org.owasp.html.PolicyFactory"%>
<%@ page import="org.owasp.html.Sanitizers"%>    
<% Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/consultadeldentista"
,"selector", "Iwasthechosenone.");
PreparedStatement cookier = con.prepareStatement("SELECT username, cookie FROM cookie WHERE cookie = ?");
cookier.setString(1, request.getRequestedSessionId());
ResultSet chaser = cookier.executeQuery();
if (!chaser.next()) { 
String redirectURL = "http://localhost:8080/CRUDPabloMolinaBlanes12/login.html";
response.sendRedirect(redirectURL);
}
PreparedStatement nombreUsuario = con.prepareStatement("SELECT username FROM cookie WHERE cookie = ?");
nombreUsuario.setString(1, request.getRequestedSessionId());
// XSS is bad stuff, people, sanitize your inputs.
PolicyFactory sanitizer = Sanitizers.FORMATTING.and(Sanitizers.BLOCKS);
ResultSet name = nombreUsuario.executeQuery();
String cleanName = "";
// Sometimes I would get an exception telling me there was not any username stored for a cookie, 
//this piece of code is basically an error-handling condition, 
//it should not matter very much if you are already logged in.
if(name.next()) {
    cleanName = sanitizer.sanitize(name.getString("username"));
} else {
    cleanName = "error";
}
%>
<body>
<img class="mt-4" src="tooth.png" width="100" height="100">
<div class="userpanel">
<p class="right mr-2"> Welcome, <%= cleanName%>.</p>
<button type="button" class="btn el-right mr-2 btn-primary"><a href="/CRUDPabloMolinaBlanes12/signout.jsp" style="color:inherit">Log-out</a></button>
</div>
<br><br>
<h1>The Dentist Hut.</h1>
<button type="button" class="btn btn-primary"><a href="project.html" data-toggle="modal" data-target="#add" style="color:inherit">Add</a></button>
<button type="button" class="btn btn-primary"><a href="project.html" data-toggle="modal" data-target="#modify" style="color:inherit">Modify</a></button>
<button type="button" class="btn btn-primary"><a href="project.html" data-toggle="modal" data-target="#delete" style="color:inherit">Delete</a></button>
<table>
    <tr>
        <th>Nombre </th>
        <th>Fecha Nacimiento </th>
        <th>Fecha Licenciado </th>
    </tr>
<%
// Yes, I am aware this is very hardly scalable, but I wanted to choose precise inputs over choosing unnecesary data for a dentist (really, who needs to know the ID of a medication if you are not modifying it?).
PreparedStatement dentista = con.prepareStatement("SELECT nomDentista, fecNac, fecLicenciado FROM Dentista");
PreparedStatement medicacion = con.prepareStatement("SELECT nomMedicacion FROM medicacion");
PreparedStatement paciente = con.prepareStatement("SELECT nomPaciente, fecNac FROM paciente");
PreparedStatement prescripcion = con.prepareStatement("SELECT inicioDosis, finDosis, miligramosPrescritos FROM prescripcion");
ResultSet dentistas = dentista.executeQuery();
ResultSet medicaciones = medicacion.executeQuery();
ResultSet pacientes = paciente.executeQuery();
ResultSet prescripciones = prescripcion.executeQuery();
ResultSetMetaData md = dentistas.getMetaData();
int count = md.getColumnCount();
int counterRow = 0;
while (dentistas.next()) {
    String cleanResults = sanitizer.sanitize(dentistas.getString("nomDentista"));
    out.println("<tr>" + "<br>" + "<td>" + cleanResults + "</td>" + "<td>" + dentistas.getString("fecNac") + "</td>" + "<td>" + dentistas.getString("fecLicenciado") + "</td>" + "</tr>" + "<br>");    
    counterRow++;
}
int countDentistas = counterRow;
counterRow = 0;
// I don't know why is this thing there in line 88.
out.println("</table>");
// From 90 to 142 line, this is table-creating code, it should give all well-formatted rows of all databases in the model (except for 'cookies').
out.println("<table>");
md = medicaciones.getMetaData();
count = md.getColumnCount();
out.print("<tr>");
for (int i=1; i<=count; i++) {
out.print("<th>");
out.print(md.getColumnName(i));
out.print("</th>");
}
out.print("</tr>");
while (medicaciones.next()) {
    String cleanResults = sanitizer.sanitize(medicaciones.getString("nomMedicacion"));
    out.println("<tr>" + "<br>" + "<td>" + cleanResults + "</td>" + "</tr>" + "<br>");    
    counterRow++;
}
int countMedicaciones = counterRow;
counterRow = 0;
out.println("</table>");
out.println("<table>");
md = pacientes.getMetaData();
count = md.getColumnCount();
out.print("<tr>");
for (int i=1; i<=count; i++) {
out.print("<th>");
out.print(md.getColumnName(i));
out.print("</th>");
}
out.print("</tr>");
while (pacientes.next()) {
    String cleanResults = sanitizer.sanitize(pacientes.getString("nomPaciente"));
    out.println("<tr>" + "<br>" + "<td>" + cleanResults + "</td>" + "<td>" + pacientes.getString("fecNac") + "</td>" + "</tr>" + "<br>");    
    counterRow++;
}
int countPacientes = counterRow;
counterRow = 0;
out.println("</table>");
out.println("<table>");
md = prescripciones.getMetaData();
count = md.getColumnCount();
out.print("<tr>");
for (int i=1; i<=count; i++) {
out.print("<th>");
out.print(md.getColumnName(i));
out.print("</th>");
}
out.print("</tr>");
while (prescripciones.next()) {
    out.println("<tr>" + "<br>" + "<td>" + prescripciones.getString("inicioDosis") + "</td>" + "<td>" + prescripciones.getString("finDosis") + "</td>" + "<td>" + prescripciones.getString("miligramosPrescritos") + "</td>" + "</tr>" + "<br>");    
    counterRow++;
}
int countPrescripciones = counterRow;
counterRow = 0;
out.println("</table>");
%>
<!-- Modal -->
<form action="/CRUDPabloMolinaBlanes12/AddDataDB.jsp" method="POST">
<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Choose which database to add data to.
        <select class="db" name="dbname">
            <option value="dentista" rows="<%= countDentistas%>">Dentista</option>
            <option value="usuario">Usuario (only admin)</option>
            <option value="medicacion" rows="<%= countMedicaciones%>">Medicacion</option>
            <option value="prescripcion" rows="<%= countPrescripciones%>">Prescripcion</option>
            <option value="paciente" rows="<%= countPacientes%>">Paciente</option>
            <option value="consulta" rows="<%= countDentistas%>">Consulta</option>
        </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input type="submit" value="Accept" class="btn btn-primary">

      </div>
    </div>
  </div>
</div>
</form>
        <form action="/CRUDPabloMolinaBlanes12/chooseDBModify.jsp" method="POST">

<div class="modal fade" id="modify" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modify</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Choose which database to modify data to.
        <select class="db" name="dbname">
            <option value="dentista" rows="<%= countDentistas%>">Dentista</option>
            <option value="usuario">Usuario (only admin)</option>
            <option value="medicacion" rows="<%= countMedicaciones%>">Medicacion</option>
            <option value="prescripcion" rows="<%= countPrescripciones%>">Prescripcion</option>
            <option value="paciente" rows="<%= countPacientes%>">Paciente</option>
            <option value="consulta" rows="<%= countDentistas%>">Consulta</option>
        </select>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <input type="submit" value="Accept" class="btn btn-primary">

      </div>
    </div>
  </div>
</div>
</form>
<form action="/CRUDPabloMolinaBlanes12/chooseDBDelete.jsp" method="POST">
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Delete</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Choose which database to delete data to.
        <select class="db" name="dbname">
            <option value="dentista" rows="<%= countDentistas%>">Dentista</option>
            <option value="usuario">Usuario (only admin)</option>
            <option value="medicacion" rows="<%= countMedicaciones%>">Medicacion</option>
            <option value="prescripcion" rows="<%= countPrescripciones%>">Prescripcion</option>
            <option value="paciente" rows="<%= countPacientes%>">Paciente</option>
            <option value="consulta" rows="<%= countDentistas%>">Consulta</option>
        </select>
      </div>
        
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <input type="submit" value="Accept" class="btn btn-primary">
      </div>
    </div>
  </div>
</div>
</form>
</body>
</html>