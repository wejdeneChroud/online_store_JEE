<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.List, model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chic</title>
    <link rel="stylesheet" href="base.css">
</head>
<body>
	<!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />
    
    <!-- Image Banner -->
    <div class="banner">
        <img src="<%= request.getContextPath() %>/uploads/imagebanner.jpg" alt="Bienvenue dans Notre Boutique" class="banner-image">
        
        <div class="banner-text">
            <h1>Bienvenue dans Notre Boutique</h1>
            <p>Découvrez nos catégories et trouvez votre produit préféré dès aujourd'hui !</p>
        </div>
    </div>

    <!-- Page Content -->
    <div class="categories-container">
        <% 
            Map<String, List<Product>> categoryProducts = (Map<String, List<Product>>) request.getAttribute("categoryProducts");
            if (categoryProducts != null) {
                for (Map.Entry<String, List<Product>> entry : categoryProducts.entrySet()) {
                    String category = entry.getKey();
                    List<Product> products = entry.getValue();
        %>
        <section class="category-section">
            <h2 class="category-title"><%= category %></h2>
            <div class="product-container">
                <% for (Product product : products) { %>
                    <div class="product-card">
                        <img src="<%= product.getImagePath() %>" alt="<%= product.getName() %>" class="product-image">
                        <h3 class="product-name"><%= product.getName() %></h3>
                        <p class="product-description"><%= product.getDescription() %></p>
                         <p class="product-price">Price: <%= product.getPrice() %>€</p>
                        <a href="CartServlet?action=add&id=<%= product.getId() %>" class="btn-link">Ajouter au Panier</a>
                    </div>
                <% } %>
            </div>
            <div class="view-all">
            	<a href="CategoryServlet?category=<%= category %>" class="btn-primary">Voir Tout</a>
        	</div>
        </section>
        <% 
                }
            }
        %>
    </div>
    <footer class="footer">
        <p>&copy; <%= java.time.LocalDate.now().getYear() %> Chic Boutique. Tous droits réservés.</p>
    </footer>
</body>
</html>
