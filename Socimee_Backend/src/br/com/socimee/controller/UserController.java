package br.com.socimee.controller;

import br.com.socimee.dao.UserDAO;
import br.com.socimee.model.User;

import java.util.ArrayList;

public class UserController {

    public ArrayList<User> listAll(){
        System.out.println("Controller listAll");
        return UserDAO.getInstance().listAll();
    }

    public User searchByID(long id){
        System.out.println("Controller searchByID - " + id);
        UserDAO dao = new UserDAO();
        User user = dao.getById(id);
        return user;
    }

    public boolean createUser(User user){
        System.out.println("Controller: createUser" + user.getEmail());
        return new UserDAO().insert(user);
    }

    public boolean updateUser(User user){
        System.out.println("Controller: updateUser" + user.getEmail());
        return UserDAO.getInstance().update(user);
    }

    public boolean deleteUser(User user){
        System.out.println("Controller: deleteUser" + user.getEmail());
        return UserDAO.getInstance().delete(user);
    }
    
    public User logInUser(User user) {
    	System.out.println("Controller: logInUser" + user.getEmail());
    	return UserDAO.getInstance().logIn(user);
    }
    
    public User searchByEmail(User user) {
    	System.out.println("Controller: Email" + user.getEmail());
    	return UserDAO.getInstance().getByEmail(user);
    }
}