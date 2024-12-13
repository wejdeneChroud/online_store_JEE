package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.ProductDAO;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;

    public void init() {
        productDAO = new ProductDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // Retrieve the cart from the session, or create a new one if it doesn't exist
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "add":
                addToCart(request, response, cart);
                break;
            case "remove":
                removeFromCart(request, response, cart);
                break;
            case "update":
                updateCart(request, response, cart);
                break;
            default:
                viewCart(request, response, cart);
                break;
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) throws IOException, ServletException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);

        if (product.getStock() <= 0) {
            request.setAttribute("error", "Product '" + product.getName() + "' is out of stock.");
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        boolean productExists = false;
        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
            	if (item.getQuantity() + 1 > product.getStock()) {
                    request.setAttribute("error", "Only " + product.getStock() + " units of '" + product.getName() + "' are available.");
                    request.setAttribute("cart", cart);
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                    return;
                }

                // Increment quantity if stock is sufficient
                item.setQuantity(item.getQuantity() + 1);
                productExists = true;
                break;
            }
        }

        if (!productExists) {
            cart.add(new CartItem(product, 1)); // Add new product to cart
        }

        response.sendRedirect("CartServlet");
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) throws IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        cart.removeIf(item -> item.getProduct().getId() == productId); // Remove the product from the cart
        response.sendRedirect("CartServlet");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) throws IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Product product = productDAO.getProductById(productId);

        if (quantity > product.getStock()) {
            request.setAttribute("error", "Insufficient stock for: " + product.getName());
            response.sendRedirect("cart.jsp");
            return;
        }

        for (CartItem item : cart) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(quantity); // Update the quantity
                break;
            }
        }

        response.sendRedirect("CartServlet");
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response, List<CartItem> cart) throws ServletException, IOException {
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
