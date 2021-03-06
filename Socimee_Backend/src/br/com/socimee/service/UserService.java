package br.com.socimee.service;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import br.com.socimee.controller.UserController;
import br.com.socimee.model.User;
 
@Path("/user")
public class UserService {
	
	final static Logger logger = Logger.getLogger(UserService.class);
 
	@Path("/login")
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	public Response loginUser(User user) {		
		UserController controller = new UserController();
		
		User loggedUser = controller.logInUser(user);
		
		if(loggedUser.getId() == null) {
			logger.error("Error trying to login a user");
			return Response.status(404).entity(loggedUser).build();	
		}
		return Response.status(200).entity(loggedUser).build();				
	}
	
	@Path("/readAll")
	@GET
	@Produces("application/json")
	public Response realAllUsers() {
		UserController controller = new UserController();
		
		ArrayList<User> users = controller.listAll();
		
		if(users.isEmpty()) {
			logger.error("Error trying to search all users in the database");
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(users).build();
	}
	
	@Path("/read/{id}")
	@GET
	@Produces("application/json")
	public Response readUser(@PathParam("id") String id) {
		UserController controller = new UserController();
		int idUser = Integer.parseInt(id);
		
		User readedUser = controller.searchByID(idUser);
		
		if(readedUser == null) {
			logger.error("Error trying to read a user in the database");
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(readedUser).build();
	}
	
	@Path("/create")
	@POST
	@Consumes("application/json")
	@Produces("application/json")	
	public Response createUser(User user) {		
		UserController controller = new UserController();		
		User emailExists = controller.searchByEmail(user);
		
		//Verifico se existe um email ja cadastrado, caso exista eu retorno um false
		if(emailExists.getId() != null) {
			logger.error("Email already exists");
			User notLoggedUser = new User();
			notLoggedUser.setId(null);
			return Response.status(404).entity(notLoggedUser).build();
		}
		
		boolean isCreateUser = controller.createUser(user);

		//Procuro o usuario que acabou de ser registrado, com o inuito de retornar o id dele
		User createdUser = controller.searchByEmail(user);
		
		//Verifico se foi criado e se nao foi retorno um false
		if(isCreateUser == false) {
			logger.error("Error trying to create a user in the database");
			return Response.status(404).entity(isCreateUser).build();
		} else {
			return Response.status(200).entity(createdUser).build();
		}
	}
	
	@Path("/update")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response alterUser(User user) {
		UserController controller = new UserController();		
		boolean updatedUser = controller.updateUser(user);
		
		if(updatedUser == false) {
			logger.error("Error trying to update a user in the database");
			return Response.status(404).entity(false).build();
		} else {		
			return Response.status(200).entity(true).build();
		}
	}
	
	@Path("/updateEmail")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response alterEmail(User user) {
		UserController controller = new UserController();
		boolean updatedUser = controller.updateEmail(user);
		
		if(updatedUser == false) {
			logger.error("Error trying to update a user in the database");
			return Response.status(404).entity(false).build();
		} else {		
			return Response.status(200).entity(true).build();
		}
	}
	
	@Path("/changePassword")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response changePassword(User user) {
		UserController controller = new UserController();
		boolean updatedUser = controller.changePassword(user);
		
		if(updatedUser == false) {
			logger.error("Error trying to change a users password in the database");
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(true).build();
	}
	
	@Path("/delete/{id}")
	@DELETE
	@Produces("application/json")
	public Response deleteUser(@PathParam("id") String id) {
		UserController controller = new UserController();
		User user = new User();		
		user.setId(Integer.parseInt(id));
		
		boolean deletedUser = controller.deleteUser(user);
		
		if(deletedUser == false) {
			logger.error("Error trying to delete a user in the database");
			return Response.status(404).entity(false).build();
		} else {		
			return Response.status(200).entity(true).build();
		}
	}
 
}








