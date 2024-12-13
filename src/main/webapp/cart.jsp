<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chic</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
	<jsp:include page="navbar.jsp" />

    <h1>Votre Panier</h1>
    
    <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    
    <%
        List<CartItem> cart = (List<CartItem>) request.getAttribute("cart");
        double totalPrice = 0.0;

        if (cart != null && !cart.isEmpty()) {
    %>
        <table>
            <thead>
                <tr>
                    <th>Produit</th>
                    <th>Prix</th>
                    <th>Quantité</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (CartItem item : cart) { 
                    totalPrice += item.getTotalPrice();
                %>
                <tr>
                    <td><%= item.getProduct().getName() %></td>
                    <td><%= item.getProduct().getPrice() %>€</td>
                    <td>
                        <form action="CartServlet?action=update&id=<%= item.getProduct().getId() %>" method="post">
                            <div class="form-group"><input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" required></div>
                            <button type="submit" class="btn-primary">Mettre à jour</button>
                        </form>
                    </td>
                    <td><%= item.getTotalPrice() %>€</td>
                    <td>
                        <a href="CartServlet?action=remove&id=<%= item.getProduct().getId() %>" class="btn-link">Supprimer</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <h2>Prix Total : <%= totalPrice %>€</h2>
        <a href="UserOrderServlet?action=placeOrder" class="btn-primary">Passer à la Caisse</a>
    <% } else { %>
        <p>Votre panier est vide.</p>
    <% } %>
</body>
</html>