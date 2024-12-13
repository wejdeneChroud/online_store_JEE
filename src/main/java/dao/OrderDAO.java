package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Order;
import model.OrderDetail;

public class OrderDAO {
	private String jdbcURL = "jdbc:postgresql://localhost:5432/projetjee";
    private String jdbcUsername = "postgres";
    private String jdbcPassword = "wej2003";

    private static final String SELECT_ALL_ORDERS = "SELECT * FROM orders;";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM orders WHERE id = ?;";
    private static final String SELECT_ORDER_DETAILS = "SELECT * FROM order_details WHERE commande_ID = ?;";
    private static final String INSERT_ORDER = "INSERT INTO orders (utilisateur_id, date, statut) VALUES (?, CURRENT_DATE, ?) RETURNING id;";
    private static final String INSERT_ORDER_DETAILS = "INSERT INTO order_details (commande_id, produit_id, quantite, prix_total) VALUES (?, ?, ?, ?);";
    private static final String UPDATE_ORDER_STATUS = "UPDATE orders SET statut = ? WHERE id = ?;";
    private static final String SELECT_ORDERS_BY_USER_ID = "SELECT * FROM orders WHERE utilisateur_id = ? ORDER BY date DESC;";
    
    
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<Order> selectAllOrders() {
    	List<Order> orders = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ORDERS);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("utilisateur_ID"),
                    rs.getDate("date"),
                    rs.getString("statut")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order getOrderById(int id) throws SQLException {
        Order order = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDER_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                order = new Order(
                    rs.getInt("id"),
                    rs.getInt("utilisateur_ID"),
                    rs.getDate("date"),
                    rs.getString("statut")
                );
            }
        }
        return order;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException {
        List<OrderDetail> details = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDER_DETAILS)) {
            preparedStatement.setInt(1, orderId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                details.add(new OrderDetail(
                    rs.getInt("id"),
                    rs.getInt("commande_ID"),
                    rs.getInt("produit_ID"),
                    rs.getInt("quantite"),
                    rs.getDouble("prix_total")
                ));
            }
        }catch (SQLException e) {
            System.out.println("Error while fetching order details: " + e.getMessage());
        }
        return details;
    }
    
    // Insert a new order and return its ID
    public int createOrder(int userId, String status) throws SQLException {
        int orderId = 0;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER)) {
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, status);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                orderId = rs.getInt(1); // Retrieve the generated ID
            }
        } catch (SQLException e) {
            System.out.println("Error while creating order: " + e.getMessage());
        }
        return orderId;
    }

    // Insert order details
    public void createOrderDetails(int orderId, List<OrderDetail> orderDetails) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_DETAILS)) {
            for (OrderDetail detail : orderDetails) {
                preparedStatement.setInt(1, orderId);
                preparedStatement.setInt(2, detail.getProductId());
                preparedStatement.setInt(3, detail.getQuantity());
                preparedStatement.setDouble(4, detail.getTotalPrice());
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
        } catch (SQLException e) {
            System.out.println("Error while creating order details: " + e.getMessage());
        }
    }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_STATUS)) {
            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error while updating order status: " + e.getMessage());
        }
    }
    
    // Fetch orders for a specific user
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ORDERS_BY_USER_ID)) {
            preparedStatement.setInt(1, userId);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                orders.add(new Order(
                    rs.getInt("id"),
                    rs.getInt("utilisateur_id"),
                    rs.getDate("date"),
                    rs.getString("statut")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
