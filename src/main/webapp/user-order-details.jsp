<%@ page import="java.util.List, model.OrderDetail, model.Order" %>
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

    <h1>Order Details</h1>

    <%
        Order order = (Order) request.getAttribute("order");
        List<OrderDetail> orderDetails = (List<OrderDetail>) request.getAttribute("orderDetails");

        if (order != null) {
    %>
        <h2>Order ID: <%= order.getId() %></h2>
        <p>Date: <%= order.getDate() %></p>
        <p>Status: <%= order.getStatus() %></p>

        <h3>Items in Order:</h3>
        <table border="1">
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderDetail detail : orderDetails) { %>
                <tr>
                    <td><%= detail.getProductId() %></td>
                    <td><%= detail.getQuantity() %></td>
                    <td>$<%= detail.getTotalPrice() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No order details available.</p>
    <% } %>
</body>
</html>
