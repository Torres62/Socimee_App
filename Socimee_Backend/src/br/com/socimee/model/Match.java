package br.com.socimee.model;

public class Match {
	private String idProfile;
	private String idProfileToMatch;
	private String likeOrDeny;
	
	public String getIdProfile() {
		return idProfile;
	}
	public void setIdProfile(String idProfile) {
		this.idProfile = idProfile;
	}
	public String getIdProfileToMatch() {
		return idProfileToMatch;
	}
	public void setIdProfileToMatch(String idProfileToMatch) {
		this.idProfileToMatch = idProfileToMatch;
	}
	public String getLikeOrDeny() {
		return likeOrDeny;
	}
	public void setLikeOrDeny(String likeOrDeny) {
		this.likeOrDeny = likeOrDeny;
	}	
}
