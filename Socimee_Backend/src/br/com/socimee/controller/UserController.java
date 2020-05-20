package br.com.socimee.controller;

import br.com.socimee.dao.UserDAO;
import br.com.socimee.model.User;

import java.util.ArrayList;

public class UserController {

    public ArrayList<User> listAll(){
        return UserDAO.getInstance().listAll();
    }

    public User searchByID(long id){
        UserDAO dao = new UserDAO();
        User user = dao.getById(id);
        return user;
    }

    public boolean createUser(User user){
        return new UserDAO().insert(user);
    }

    public boolean updateUser(User user){
        return UserDAO.getInstance().update(user);
    }

    public boolean deleteUser(User user){
        return UserDAO.getInstance().delete(user);
    }
    
    public User logInUser(User user) {
    	return UserDAO.getInstance().logIn(user);
    }
    
    public User searchByEmail(User user) {
    	return UserDAO.getInstance().getByEmail(user);
    }
    
    public boolean updateEmail(User user) {
    	return UserDAO.getInstance().updateEmail(user);
    }
    
    public boolean changePassword(User user) {
    	return UserDAO.getInstance().changePassword(user);
    }
}