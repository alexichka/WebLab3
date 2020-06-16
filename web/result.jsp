<%--
  Created by IntelliJ IDEA.
  User: пользователь
  Date: 04.06.2020
  Time: 2:35
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.lang.reflect.InvocationTargetException" %>
<%@ page import="java.*" %>
<%@ page import="classes.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <link href="https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@400;500;531;600;700;800;900&display=swap"
          rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:ital,wght@0,700;1,700&display=swap" rel="stylesheet">
    <script src="//cdnjs.cloudflare.com/ajax/libs/less.js/3.9.0/less.min.js"></script>
    <title>Your's_cabinet</title>
</head>
<link rel="stylesheet" href="style.css" type="text/css">
<body class="body">
<%
    HttpSession httpSession = request.getSession();
    Customer customer = (Customer) httpSession.getAttribute("customer");
    List<Product> products = null;
    if (customer != null) {
        try {
            products = new ClassDB().getCustomersProductListProduct(customer);

%>
<h2>Welcome, <%=customer.getName()%>!
    <br/>Please, checked Your orders</h2>

<%
    if (request.getParameter("logout") != null) {
        httpSession.removeAttribute("customer");
        response.sendRedirect("index.jsp");
    }
%>

<a class="button_back" href="index.jsp">Log out</a>

<main>
    <div>
        <table >
            <h3> Your product: </h3>
            <tr>
                <th>Name</th>
                <th>Price</th>
                <th>Number</th>
                <th>Date_of_delivery</th>
            </tr>

            <tr>
                <%
                    for (Product prod : products) {
                %>
                <td><%=prod.getProductName()%>
                </td>
                <td><%=prod.getProductPrice()%>
                </td>
                <td><%=prod.getNumberOfProduct()%>
                </td>
                <td><%=prod.getDateOfDelivery()%>
                </td>
            </tr>

            <%
                }
            %>
        </table>
        <%
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IncorrectConstructorParameters incorrectConstructorParameters) {
                incorrectConstructorParameters.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>

    </div>

    <form action="result.xml" method="get">
        <input type="submit" value="See as XML">
    </form>
</main>

<%

    response.sendRedirect("index.jsp");
    } else {
%>

<p class="main-redirect">
    User not found<br>you will be redirected to the main page in 5 seconds
    <a href="index.jsp">return now</a>
</p>
<meta http-equiv="refresh" content="5; URL=index.jsp">
<%
    }
%>

</body>
</html>