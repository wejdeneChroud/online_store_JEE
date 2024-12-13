<%@ page import="java.util.List, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Chic Dashboard</title>
    <link rel="stylesheet" type="text/css" href="base.css">
    <script>
        function handleProductAction(selectElement, productId) {
            const action = selectElement.value;
            if (action === "edit") {
                window.location.href = "ProductServlet?action=edit&id=" + productId;
            } else if (action === "delete") {
                if (confirm("Êtes-vous sûr de vouloir supprimer ce produit ?")) {
                    window.location.href = "ProductServlet?action=delete&id=" + productId;
                }
            }
            // Réinitialiser la liste déroulante
            selectElement.selectedIndex = 0;
        }
    </script>
</head>
<body>
	<!-- Include Navbar -->
	<%@ include file="admin-navbar.jsp" %>
	
    <h1>Liste des Produits</h1>
    <a class="btn-link" href="ProductServlet?action=new">Ajouter un Nouveau Produit</a>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Description</th>
                <th>Prix</th>
                <th>Stock</th>
                <th>Catégorie</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
            %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getName() %></td>
                <td><%= product.getDescription() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getStock() %></td>
                <td><%= product.getCategory() %></td>
                <td>
                    <img src="<%=request.getContextPath()%>/<%= product.getImagePath() %>" alt="Image du produit" width="200">
                </td>
                <td>
                    <select onchange="handleProductAction(this, <%= product.getId() %>)">
                        <option value="" selected disabled>Choisir une action</option>
                        <option value="edit">Modifier</option>
                        <option value="delete">Supprimer</option>
                    </select>
               	</td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7" style="text-align:center;">Aucun produit disponible.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
