package br.com.socimee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.socimee.factory.ConnectionFactory;
import br.com.socimee.model.User;

public class UserDAO extends ConnectionFactory {

    private static UserDAO instance;

    public static UserDAO getInstance(){
        if (instance ==  null)
            instance = new UserDAO();
        return instance;
    }

    public ArrayList<User> listAll(){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<User> users = null;

        connection = createConnection();
        users = new ArrayList<User>();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM User ORDER BY EMAIL");
            rs = pstmt.executeQuery();

            while (rs.next()){

                User user = new User();

                user.setId(rs.getInt("ID_USER"));
                user.setEmail(rs.getString("EMAIL"));
                user.setPassword(rs.getString("PASSWORD"));

                users.add(user);
            }

        }catch (Exception e){            
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return users;
    }

    public User getById(long id){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        connection = createConnection();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM User WHERE ID_USER = ?");
            pstmt.setLong(1, id);

            rs = pstmt.executeQuery();

            while (rs.next()){
                user = new User();
                user.setId(rs.getInt("ID_USER"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
            }

        } catch (Exception e){
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }

        return user;
    }

    public boolean insert(User user){
        String email = user.getEmail();
        String password = user.getPassword();

        boolean isCreated = false;

        PreparedStatement pstmt = null;
        Connection connection = createConnection();
        

        try {
            pstmt = connection.prepareStatement("INSERT INTO user(EMAIL, PASSWORD) VALUES(?, ?)");
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            boolean execute = pstmt.execute();
            isCreated = true;
            System.out.println("Insert response: " + execute);

        }catch (SQLException e){
            isCreated = false;
            e.printStackTrace();
        }
        return isCreated;
    }

    public boolean update(User user){
        long id = user.getId();
        String email = user.getEmail();
        String password = user.getPassword();

        boolean isUpdated = false;

        PreparedStatement pstmt = null;
        Connection connection = createConnection();

        try {
            pstmt = connection.prepareStatement("UPDATE User SET EMAIL = ?, PASSWORD = ? WHERE ID_USER = ?");
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            pstmt.setLong(3, id);

            int execute = pstmt.executeUpdate();
            isUpdated = true;
        } catch (SQLException e){
            isUpdated = false;
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, null);
        }
        return isUpdated;
    }

    public boolean delete(User user){
        boolean isDeleted = false;
        PreparedStatement pstmt = null;
        Connection connection = createConnection();
        try {
            pstmt = connection.prepareStatement("DELETE FROM User WHERE ID_USER = ?");
            pstmt.setInt(1, user.getId());

            boolean execute = pstmt.execute();
            isDeleted = true;
        } catch (SQLException e){
            isDeleted = false;
            e.printStackTrace();
        }finally {
            closeConnection(connection, pstmt, null);
        }
        return isDeleted;
    }
    
    public User logIn(User user){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;    

        connection = createConnection();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM User WHERE EMAIL = ? AND PASSWORD = ?");
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPassword());

            rs = pstmt.executeQuery();

            while (rs.next()){
                user.setId(rs.getInt("ID_USER"));
            }

        } catch (Exception e){           
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return user;
    }
    
    public User getByEmail(User user){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;    

        connection = createConnection();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM User WHERE EMAIL = ?");
            pstmt.setString(1, user.getEmail());

            rs = pstmt.executeQuery();

            while (rs.next()){
                user.setId(rs.getInt("ID_USER"));
            }

        } catch (Exception e){            
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return user;
    }

}

