<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<nav class="navbar">
    <!-- Logo -->
    <div class="navbar-left">
        <a href="#" class="navbar-logo">Chic Dashboard</a>
    </div>

    <!-- Center Links -->
    <div class="navbar-center">
        <a href="UserServlet" class="navbar-link">Users</a>
        <a href="ProductServlet" class="navbar-link">Products</a>
        <a href="AdminOrderServlet" class="navbar-link">Orders</a>
    </div>
    
    <!-- Right Icons -->
    <div class="navbar-right">
        <!-- User Dropdown Menu -->
		<div class="navbar-dropdown">
		    <span class="navbar-icon user-icon"><i class="fas fa-user"></i></span>
		    <div class="dropdown-content">
		        <a href="LogoutServlet">Logout</a>
		    </div>
		</div>
		<!-- Hamburger Menu Icon -->
        <span class="navbar-icon menu-icon" onclick="toggleSidebar()"><i class="fas fa-bars"></i></span>
    </div>
</nav>


<!-- Sidebar for Small Screens -->
<div class="sidebar" id="sidebar">
    <span class="close-btn" onclick="toggleSidebar()">&times;</span>
    <a href="UserServlet" class="navbar-link">Users</a>
    <a href="ProductServlet" class="navbar-link">Products</a>
    <a href="AdminOrderServlet" class="navbar-link">Orders</a>
    <a href="LogoutServlet">Logout</a>
</div>

<script>
function toggleSidebar() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar.style.left === "0px") {
        sidebar.style.left = "-250px"; 
    } else {
        sidebar.style.left = "0px";
    }
}
</script>
