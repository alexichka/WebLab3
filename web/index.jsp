<%--
  Created by IntelliJ IDEA.
  User: пользователь
  Date: 04.06.2020
  Time: 2:31
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>

<%@ page import="java.sql.SQLException" %>
<%@ page import="classes.Customer" %>
<%@ page import="classes.ClassDB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
  <meta charset="UTF-8">

    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;500;531;600;700;800;900&display=swap"
          rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,700;1,700&display=swap" rel="stylesheet">
    <script src="//cdnjs.cloudflare.com/ajax/libs/less.js/3.9.0/less.min.js"></script>
  <title>Title</title>
</head>
<link rel="stylesheet" href="style.css" type="text/css">


<body>

<%
  HttpSession initialHttpSession = request.getSession();
  Customer customerInCookies = (Customer) initialHttpSession.getAttribute("customer");
  Customer customerInDB = null;
  if (customerInCookies != null) {
    try {
      customerInDB = new ClassDB().getCustomer(customerInCookies.getLogin(), customerInCookies.getPassword());
      if (customerInCookies.equals(customerInDB)) {
        response.sendRedirect("result.jsp");
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }
  }
%>

<h1>Points of delivery of our Store</h1>
<main>
  <form class="form">
    <h2 class="form_title">Welcome!</h2>
    <h4 class="form_title3">Sign in</h4>
    <div class="form_grup">
      <p><input requiredtype="text" placeholder="Login" class="form_input"></p>
    </div>
    <div>
      <p><input required type="text" placeholder="Password" class="form_input"></p>
    </div>
    <input class = "form_button" type="submit" formaction = "result.jsp" value="Enter" />
  </form>

  <%
    try {
      String login = request.getParameter("login");
      String password = request.getParameter("password");
      String submit = request.getParameter("submit");
      if (submit != null) {
        if (!login.equals("") && !password.equals("")) {
          Customer customer = new ClassDB().getCustomer(login, password);
          if (customer!= null) {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("customer", customer);
            response.sendRedirect("result.jsp");
          } else {
            out.println("<div class=\"login-error\">There is no such customer</div>");
          }
        } else {
          out.println("<div class=\"login-error\">Fill all the gaps, please</div>");
        }
      }
    } catch (SQLException | ClassNotFoundException e) {
      e.printStackTrace();
    }
  %>

</main>
</body>
</html>