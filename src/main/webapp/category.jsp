<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List, model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("category") %> Produits</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
	<!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />

    <!-- Page Content -->
    <h1>Produits dans <%= request.getAttribute("category") %></h1>
    <div class="product-container">
        <% List<Product> products = (List<Product>) request.getAttribute("products");
           if (products != null) {
               for (Product product : products) { %>
                   <div class="product-card">
                       <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>" class="product-image">
			            <h3 class="product-name"><%= product.getName() %></h3>
			            <p class="product-description"><%= product.getDescription() %></p>
			            <p class="product-price">Prix : <%= product.getPrice() %>€</p>
			            <a href="CartServlet?action=add&id=<%= product.getId() %>" class="btn-link">Ajouter au Panier</a>
			        </div>
        <%     }
           } else { %>
               <p class="no-products">Aucun produit disponible dans cette catégorie.</p>
        <% } %>
    </div>
</body>
</html>
