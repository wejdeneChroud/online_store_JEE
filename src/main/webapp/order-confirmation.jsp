<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Order, model.OrderDetail, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation de Commande</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="confirmation-container">
        <h1>Confirmation de Commande</h1>
        <p>Merci pour votre achat ! Votre commande a été passée avec succès.</p>

        <h3>Détails de la Commande</h3>
        <p><b>ID Commande :</b> <%= request.getAttribute("orderId") %></p>
        <p><b>Statut :</b> En cours</p>

    <%
        List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");
        double totalPrice = 0.0;

        if (orderDetails != null && !orderDetails.isEmpty()) {
    %>
        <table>
            <thead>
                <tr>
                    <th>ID Produit</th>
                    <th>Quantité</th>
                    <th>Prix par Unité (€)</th>
                    <th>Prix Total (€)</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderDetail detail : orderDetails) { 
                    totalPrice += detail.getTotalPrice();
                %>
                <tr>
                    <td><%= detail.getProductId() %></td>
                    <td><%= detail.getQuantity() %></td>
                    <td><%= detail.getTotalPrice() / detail.getQuantity() %></td>
                    <td><%= detail.getTotalPrice() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <h3 class="total-price">Prix Total : €<%= totalPrice %></h3>
    <% } else { %>
        <p>Aucun détail de commande disponible.</p>
    <% } %>

    <div class="return-home">
            <a href="HomeServlet" class="btn-primary">Retour à l'Accueil</a>
        </div>
    </div>
</body>
</html>
