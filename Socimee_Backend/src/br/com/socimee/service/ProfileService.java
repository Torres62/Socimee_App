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

import br.com.socimee.controller.ProfileController;
import br.com.socimee.model.Profile;


@Path("/profile")
public class ProfileService {
	
	final static Logger logger = Logger.getLogger(ProfileService.class);
	
	@Path("/readAll")
	@GET
	@Produces("application/json")
	public Response readAllProfiles() {					
		ProfileController controller = new ProfileController();
			
		ArrayList<Profile> profiles = controller.listAll();
		
		if (profiles == null) {
			logger.error("Error trying to search all profiles in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(profiles).build();
		}				
	}
	
	@Path("/readUserProfiles/{id}")
	@GET
	@Produces("application/json")
	public Response readUserProfiles(@PathParam("id") String id) {					
		ProfileController controller = new ProfileController();
		
		int idUser = Integer.parseInt(id);	
		
		ArrayList<Profile> profiles = controller.listUserProfiles(idUser);
		
		if (profiles == null) {
			logger.error("Error trying to search all profiles in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(profiles).build();
		}				
	}
	
	@Path("/read")
	@GET
	@Consumes("application/json")
	@Produces("application/json")
	public Response readProfile(Profile profile) {
		ProfileController controller = new ProfileController();
		
		Profile readedProfile = controller.searchByID(profile.getIdProfile());
		
		if (readedProfile == null) {
			logger.error("Error trying to search a profile in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(readedProfile).build();
		}
	}
	
	@Path("/create")
	@POST
	@Consumes("application/json")
	@Produces("application/json")
	public Response createProfile(Profile profile) {
		ProfileController controller = new ProfileController();
		
		boolean isProfileCreated = controller.createProfile(profile);
		Profile lastCreatedProfile = controller.searchLastCreatedID();
		
		if(isProfileCreated == false) {
			logger.error("Error trying to create a profile in the database");			
			return Response.status(404).entity(false).build();
		} else {		
			return Response.status(200).entity(lastCreatedProfile).build();
		}
	}
	
	@Path("/updatePersonality")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response updateProfilePersonality(Profile profile) {
		ProfileController controller = new ProfileController();		
		
		boolean updatedProfile = controller.updateProfilePersonality(profile);
		
		if(updatedProfile == false) {
			logger.error("Error trying to update a profile row in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(true).build();
		}
	}
	
	@Path("/updateDescription")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response updateProfileDescription(Profile profile) {
		ProfileController controller = new ProfileController();
		
		boolean updatedProfile = controller.updateProfileDescription(profile);
		
		if(updatedProfile == false) {
			logger.error("Error trying to update a profile description in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(true).build();
		}
	}
	
	
	@Path("/delete")
	@DELETE
	@Consumes("application/json")
	@Produces("application/json")
	public Response deleteProfile(Profile profile) {
		ProfileController controller = new ProfileController();
		boolean isProfileDeleted = controller.deleteProfile(profile);
		
		if(isProfileDeleted == false) {
			logger.error("Error trying to delete a profile in the database");
			return Response.status(404).entity(false).build();
		} else {
			return Response.status(200).entity(true).build();
		}		
	}
	
}
