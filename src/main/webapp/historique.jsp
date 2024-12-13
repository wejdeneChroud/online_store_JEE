<%@ page import="java.util.List, model.Order" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chic</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <h1>Votre Historique des Commandes</h1>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");
        if (orders != null && !orders.isEmpty()) {
    %>
        <table class="order-history-table">
            <thead>
                <tr>
                    <th>ID Commande</th>
                    <th>Date</th>
                    <th>Statut</th>
                    <th>Détails</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order order : orders) { %>
                <tr>
                    <td><%= order.getId() %></td>
                    <td><%= order.getDate() %></td>
                    <td><%= order.getStatus() %></td>
                    <td>
                        <a href="UserOrderServlet?action=viewOrder&id=<%= order.getId() %>" class="btn-link">Voir les Détails</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p class="no-orders">Vous n'avez aucune commande passée.</p>
    <% } %>

    <div class="return-home">
        <a href="HomeServlet" class="btn-primary">Retour à l'Accueil</a>
    </div>
</body>
</html>
