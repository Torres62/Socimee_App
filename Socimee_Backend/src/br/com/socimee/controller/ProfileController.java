package br.com.socimee.controller;

import java.util.ArrayList;

import br.com.socimee.dao.ProfileDAO;
import br.com.socimee.model.Match;
import br.com.socimee.model.Profile;

public class ProfileController {
	
	public ArrayList<Profile> listAll(){
		System.out.println("Printing all profiles");
		return ProfileDAO.getInstance().listAll();
	}
	
	public ArrayList<Profile> listUserProfiles(int idUser){
		System.out.println("Printing all profiles");
		return ProfileDAO.getInstance().listUserProfiles(idUser);
	}
	
	public ArrayList<Profile> listUsersToMatchCurrentProfile(Integer idUser){
		System.out.println("Printing all profiles");
		return ProfileDAO.getInstance().listUsersToMatchCurrentProfile(idUser);
	}
	
	public Profile searchByID(long id) {
		System.out.println("Controller search byId" + id);
		ProfileDAO dao = new ProfileDAO();
		Profile profile = dao.getByID(id);
		
		return profile;
	}
	
	public boolean createProfile(Profile profile) {
		System.out.println("Inserting profile:  " + profile.getNome());
		return new ProfileDAO().insert(profile);
	}
	
	public boolean updateProfilePersonality(Profile profile) {
		System.out.println("Update profile with id: " + profile.getIdProfile());
		return new ProfileDAO().updateProfilePersonality(profile);
	}
	
	public boolean updateProfileDescription(Profile profile) {
		System.out.println("Update profile with id: " + profile.getIdProfile());
		return new ProfileDAO().updateProfileDescription(profile);
	}
	
	public int updateProfile(Profile profile) {
		System.out.println("Update profile with id: " + profile.getIdProfile());
		return new ProfileDAO().updateProfile(profile);
	}
	
	public boolean deleteProfile(String id) {
		System.out.println("Delete profile with id: " + id);
		return new ProfileDAO().delete(id);
	}

	public Profile searchLastCreatedID() {
		System.out.println("Searching last created id");
		return new ProfileDAO().searchLastCreatedID();
	}
	
	public boolean createLikeOrDeny(Match match) {
		System.out.println("Update profile with id: " + match.getIdProfile());
		return new ProfileDAO().createLikeOrDeny(match);
	}
}
