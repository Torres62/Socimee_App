package br.com.socimee.service;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.core.Response;

import org.json.JSONArray;

import br.com.socimee.controller.ProfileController;
import br.com.socimee.model.Profile;


@Path("/profile")
public class ProfileService {
	
	@Path("/readAll")
	@GET
	@Produces("application/json")
	public Response readAllProfiles() {		
		ProfileController controller = new ProfileController();
		
		ArrayList<Profile> profiles = controller.listAll();		
		
		
		if(profiles.isEmpty()) {
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(profiles).build();
	}
	
	@Path("/read")
	@GET
	@Consumes("application/json")
	@Produces("application/json")
	public Response readProfile(Profile profile) {
		ProfileController controller = new ProfileController();
		
		Profile readedProfile = controller.searchByID(profile.getIdProfile());
		
		if (readedProfile == null) {
			return Response.status(404).entity(false).build();
		}
				
		return Response.status(200).entity(readedProfile).build();
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
			return Response.status(404).entity(false).build();
		}
		
		return Response.status(200).entity(lastCreatedProfile.getIdProfile()).build();
	}
	
	@Path("/updatePersonality")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response updateProfilePersonality(Profile profile) {
		ProfileController controller = new ProfileController();		
		
		boolean updatedProfile = controller.updateProfilePersonality(profile);
		
		if(updatedProfile == false) {
			return Response.status(404).entity(false).build();
		}
		return Response.status(200).entity(true).build();
	}
	
	@Path("/updateDescription")
	@PUT
	@Consumes("application/json")
	@Produces("application/json")
	public Response updateProfileDescription(Profile profile) {
		ProfileController controller = new ProfileController();
		
		boolean updatedProfile = controller.updateProfileDescription(profile);
		
		if(updatedProfile == false) {
			return Response.status(404).entity(false).build();
		}
		return Response.status(200).entity(true).build();
	}
	
	
	@Path("/delete")
	@DELETE
	@Consumes("application/json")
	@Produces("application/json")
	public Response deleteProfile(Profile profile) {
		ProfileController controller = new ProfileController();
		boolean isProfileDeleted = controller.deleteProfile(profile);
		
		if(isProfileDeleted == false) {
			return Response.status(404).entity(false).build();
		}
		return Response.status(200).entity(true).build();
		
	}	

}
