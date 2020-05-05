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

import br.com.socimee.controller.UserController;
import br.com.socimee.model.User;
 
@Path("/user")
public class UserService {
 
	@Path("/login")
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	public Response loginUser(User user) {		
		UserController controller = new UserController();
		
		User loggedUser = controller.logInUser(user);
		
		if(loggedUser.getId() == null) {
			return Response.status(404).entity(loggedUser.getId()).build();	
		}
		return Response.status(200).entity(loggedUser.getId()).build();				
	}
	
	@Path("/readAll")
	@GET
	@Produces("application/json")
	public Response realAllUsers() {
		UserController controller = new UserController();
		
		ArrayList<User> users = controller.listAll();
		
		if(users.isEmpty()) {
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
		
		//Verifico se existe um email ja cadastrado, caso exista eu retorno uma string do email
		if(emailExists.getId() != null) {
			return Response.status(404).entity(emailExists.getEmail()).build();
		}
		
		boolean isCreateUser = controller.createUser(user);

		//Procuro o usuario que acabou de ser registrado, com o inuito de retornar o id dele
		User createdUser = controller.searchByEmail(user);
		
		//Verifico se foi criado e se nao foi retorno um false
		if(isCreateUser == false) {
			return Response.status(404).entity(isCreateUser).build();
		}
		return Response.status(200).entity(createdUser.getId()).build();
	}
	
	@Path("/update")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response alterUser(User user) {
		UserController controller = new UserController();
		boolean updatedUser = controller.updateUser(user);
		
		if(updatedUser == false) {
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
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(true).build();
	}
 
}








