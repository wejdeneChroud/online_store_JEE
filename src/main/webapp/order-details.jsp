<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.Order, model.OrderDetail" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chic Dashboard</title>
    <link rel="stylesheet" type="text/css" href="base.css">
</head>
<body>
	<!-- Include Navbar -->
	<%@ include file="admin-navbar.jsp" %>
	
    <h1>Détails de la Commande</h1>
    <%
        Order order = (Order) request.getAttribute("order");
        List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
    %>
    <p>ID Commande : <%= order.getId() %></p>
    <p>ID Utilisateur : <%= order.getUserId() %></p>
    <p>Date: <%= order.getDate() %></p>
    <p>Statut : <%= order.getStatus() %></p>

    <h2>Produits dans la Commande</h2>
    <table>
        <thead>
            <tr>
                <th>ID Produit</th>
                <th>Quantité</th>
                <th>Prix Total</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (OrderDetail detail : orderDetails) {
        %>
	        <tr>
	            <td><%= detail.getProductId() %></td>
	            <td><%= detail.getQuantity() %></td>
	            <td><%= detail.getTotalPrice() %></td>
	        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <a class="btn-link" href="AdminOrderServlet">Retour aux Commandes</a>
</body>
</html>
