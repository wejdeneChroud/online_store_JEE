<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chic Dashboard</title>
    <link rel="stylesheet" type="text/css" href="base.css">
</head>
<body>
	<!-- Include Navbar -->
	<%@ include file="admin-navbar.jsp" %>
	
    <h1>Commandes</h1>
    <table>
        <thead>
            <tr>
                <th>ID Commande</th>
                <th>ID Utilisateur</th>
                <th>Date</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
        %>
	        <tr>
	            <td><%= order.getId() %></td>
	            <td><%= order.getUserId() %></td>
	            <td><%= order.getDate() %></td>
	            <td><%= order.getStatus() %></td>
	            <td>
                    <form action="AdminOrderServlet" method="get">
                        <input type="hidden" name="id" value="<%= order.getId() %>">
                        <select name="action" onchange="this.form.submit()">
                            <option value="">Choisir une action</option>
                            <option value="view">Voir</option>
                            <% if (!"livre".equals(order.getStatus())) { %>
                                <option value="markAsDelivered">Marquer comme livré</option>
                            <% } %>
                        </select>
                    </form>
	            </td>
	        </tr>
        <%
                }
            } else {
        %>
	        <tr>
	            <td colspan="5" style="text-align: center;">Aucune commande trouvée.</td>
	        </tr>
        <%
            }
        %>
    	</tbody>
    </table>
</body>
</html>
