<%@ page import="java.util.List, model.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chic</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <h1>Résultats de Recherche pour "<%= request.getAttribute("query") %>"</h1>

    <%
        List<Product> searchResults = (List<Product>) request.getAttribute("searchResults");
        if (searchResults != null && !searchResults.isEmpty()) {
    %>
        <div class="product-container">
            <% for (Product product : searchResults) { %>
                <div class="product-card">
                    <img src="<%= request.getContextPath() + "/" + product.getImagePath() %>" alt="<%= product.getName() %>" class="product-image">
                    <h3 class="product-name"><%= product.getName() %></h3>
                    <p class="product-description"><%= product.getDescription() %></p>
                    <p class="product-price">Price: €<%= product.getPrice() %></p>
                    <p class="product-stock">Stock: <%= product.getStock() %></p>
                    <form action="CartServlet?action=add&id=<%= product.getId() %>" method="post">
                        <button type="submit" class="btn-primary" <%= product.getStock() <= 0 ? "disabled" : "" %>>
		                    <%= product.getStock() <= 0 ? "Rupture de Stock" : "Ajouter au Panier" %>
		                </button>
                    </form>
                </div>
            <% } %>
        </div>
    <%
        } else {
    %>
        <p class="no-results">Aucun résultat trouvé pour "<%= request.getAttribute("query") %>".</p>
    <%
        }
    %>
</body>
</html>
