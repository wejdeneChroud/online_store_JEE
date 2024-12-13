package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import dao.ProductDAO;

/**
 * Servlet implementation class UserOrderServlet
 */
public class UserOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	public void init() {
        orderDAO = new OrderDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Redirect to login if user is not logged in
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "viewOrder";
        }

        try {
            switch (action) {
                case "viewOrder":
                    userViewOrder(request, response);
                    break;
                case "placeOrder":
                    placeOrder(request, response);
                    break;
                default:
                    response.sendRedirect("cart.jsp");
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void userViewOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);

        // Restrict users from viewing orders that don't belong to them
        if (order.getUserId() != user.getId()) {
            response.sendRedirect("UserOrderServlet");
            return;
        }

        List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderId);
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("user-order-details.jsp").forward(request, response);
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("blocked".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("error", "Your account is blocked and you cannot make purchases.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("CartServlet");
            return;
        }

        ProductDAO productDAO = new ProductDAO();
        List<OrderDetail> orderDetails = new ArrayList<>();
        double totalPrice = 0.0;

        for (CartItem cartItem : cart) {
        	Product product = productDAO.getProductById(cartItem.getProduct().getId());
            int quantity = cartItem.getQuantity();

            if (product.getStock() < quantity) {
                request.setAttribute("error", "Insufficient stock for product: " + product.getName());
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            productDAO.updateStock(product.getId(), product.getStock() - quantity);
        	
        	double itemTotalPrice = cartItem.getQuantity() * cartItem.getProduct().getPrice();
            totalPrice += itemTotalPrice;

            orderDetails.add(new OrderDetail(
                0,
                cartItem.getProduct().getId(),
                cartItem.getQuantity(),
                itemTotalPrice
            ));
        }

        int orderId = orderDAO.createOrder(user.getId(), "en cours");
        orderDAO.createOrderDetails(orderId, orderDetails);

        session.removeAttribute("cart");
        request.setAttribute("orderId", orderId);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
