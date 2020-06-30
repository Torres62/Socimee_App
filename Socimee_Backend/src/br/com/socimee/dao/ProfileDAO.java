package br.com.socimee.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import br.com.socimee.factory.ConnectionFactory;
import br.com.socimee.model.Profile;

public class ProfileDAO extends ConnectionFactory{
	
	private static ProfileDAO instance;

    public static ProfileDAO getInstance(){
        if (instance ==  null)
            instance = new ProfileDAO();
        return instance;
    }

    public ArrayList<Profile> listAll(){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Profile> profiles = null;

        connection = createConnection();
        profiles = new ArrayList<Profile>();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM Profile ORDER BY Nome");
            rs = pstmt.executeQuery();

            while (rs.next()){

            	Profile profile = new Profile();

            	profile.setIdProfile(rs.getInt("ID_PROFILE"));
				profile.setNome(rs.getString("Nome"));
				profile.setSexo(rs.getString("Sexo"));
				profile.setDataNascimento(rs.getString("DataNascimento"));
				profile.setDistanciaMaxima(rs.getInt("DistanciaMaxima"));
				profile.setFaixaEtaria(rs.getInt("FaixaEtaria"));
				profile.setStatusPerfil(rs.getString("StatusPerfil"));
				profile.setDescricao(rs.getString("Descricao"));
				profile.setFilme(rs.getString("GeneroFilme"));
				profile.setMusica(rs.getString("GeneroMusica"));
				profile.setSerie(rs.getString("SerieFavorita"));
				profile.setAnime(rs.getString("AnimeFavorito"));
				profile.setOcupacao(rs.getString("Ocupacao"));
				profile.setIdPerfilFacebook(rs.getInt("PerfilFacebook_idPerfilFacebook"));
				profile.setIdUser(rs.getInt("Registro_idRegistro"));

                profiles.add(profile);
            }

        }catch (Exception e){
            System.out.println("Error listing all clients: " + e);
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return profiles;
    }
    
    public ArrayList<Profile> listUserProfiles(long idUser){
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Profile> profiles = null;

        connection = createConnection();
        profiles = new ArrayList<Profile>();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM Profile WHERE Registro_idRegistro = ? ORDER BY Nome");
            pstmt.setLong(1, idUser);
            rs = pstmt.executeQuery();

            while (rs.next()){

            	Profile profile = new Profile();

            	profile.setIdProfile(rs.getInt("ID_PROFILE"));
				profile.setNome(rs.getString("Nome"));
				profile.setSexo(rs.getString("Sexo"));
				profile.setDataNascimento(rs.getString("DataNascimento"));
				profile.setDistanciaMaxima(rs.getInt("DistanciaMaxima"));
				profile.setFaixaEtaria(rs.getInt("FaixaEtaria"));
				profile.setStatusPerfil(rs.getString("StatusPerfil"));
				profile.setDescricao(rs.getString("Descricao"));
				profile.setFilme(rs.getString("GeneroFilme"));
				profile.setMusica(rs.getString("GeneroMusica"));
				profile.setSerie(rs.getString("SerieFavorita"));
				profile.setAnime(rs.getString("AnimeFavorito"));
				profile.setOcupacao(rs.getString("Ocupacao"));
				profile.setIdPerfilFacebook(rs.getInt("PerfilFacebook_idPerfilFacebook"));
				profile.setIdUser(rs.getInt("Registro_idRegistro"));

                profiles.add(profile);
            }

        }catch (Exception e){
            System.out.println("Error listing all clients: " + e);
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return profiles;
    }
    
    public ArrayList<Profile> listUsersToMatchCurrentProfile(Profile profile){
    	
    	String dataNascimento = profile.getDataNascimento();
    	dataNascimento = dataNascimento.substring(0, 4);
    	int dateOfBirth = Integer.parseInt(dataNascimento);
    	int ageRange = 2020 - dateOfBirth;
    	    	
		int distanciaMaxima = profile.getDistanciaMaxima();
		int faixaEtaria = ageRange;
		String statusPerfil = profile.getStatusPerfil();
		String descricao = profile.getDescricao();
		String filme = profile.getFilme();
		String musica = profile.getMusica();
		String serie = profile.getSerie();
		String anime = profile.getAnime();
		int idUser = profile.getIdUser();
    	
    	
        Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Profile> profiles = null;

        connection = createConnection();
        profiles = new ArrayList<Profile>();

        try {
            pstmt = connection.prepareStatement("SELECT * FROM Profile WHERE (Registro_idRegistro <> ? AND DistanciaMaxima <= ? AND"
            		+ " FaixaEtaria >= ? AND StatusPerfil = ?) AND (Descricao = ? OR GeneroFilme = ? OR "
            		+ " GeneroMusica = ? OR SerieFavorita = ? OR AnimeFavorito = ?) ORDER BY Nome");
            
            pstmt.setInt(1, idUser);
            pstmt.setInt(2, distanciaMaxima);
            pstmt.setInt(3, faixaEtaria);
            pstmt.setString(4, statusPerfil);
            pstmt.setString(5, descricao);
            pstmt.setString(6, filme);
            pstmt.setString(7, musica);
            pstmt.setString(8, serie);
            pstmt.setString(9, anime);
            
            rs = pstmt.executeQuery();

            while (rs.next()){

            	Profile profileToMatch = new Profile();

            	profileToMatch.setIdProfile(rs.getInt("ID_PROFILE"));
            	profileToMatch.setNome(rs.getString("Nome"));
            	profileToMatch.setSexo(rs.getString("Sexo"));
            	profileToMatch.setDataNascimento(rs.getString("DataNascimento"));
            	profileToMatch.setDistanciaMaxima(rs.getInt("DistanciaMaxima"));
            	profileToMatch.setFaixaEtaria(rs.getInt("FaixaEtaria"));
            	profileToMatch.setStatusPerfil(rs.getString("StatusPerfil"));
            	profileToMatch.setDescricao(rs.getString("Descricao"));
            	profileToMatch.setFilme(rs.getString("GeneroFilme"));
            	profileToMatch.setMusica(rs.getString("GeneroMusica"));
            	profileToMatch.setSerie(rs.getString("SerieFavorita"));
            	profileToMatch.setAnime(rs.getString("AnimeFavorito"));
            	profileToMatch.setOcupacao(rs.getString("Ocupacao"));
            	profileToMatch.setIdPerfilFacebook(rs.getInt("PerfilFacebook_idPerfilFacebook"));
            	profileToMatch.setIdUser(rs.getInt("Registro_idRegistro"));

                profiles.add(profileToMatch);
            }

        }catch (Exception e){
            System.out.println("Error listing all clients: " + e);
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return profiles;
    }
    
	public Profile getByID(long id) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Profile profile = null;
				
		connection = createConnection();
		
		try {
			pstmt = connection.prepareStatement("SELECT * FROM profile WHERE ID_PROFILE = ?");
			pstmt.setLong(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				profile = new Profile();
				
				profile.setIdProfile(rs.getInt("ID_PROFILE"));
				profile.setNome(rs.getString("Nome"));
				profile.setSexo(rs.getString("Sexo"));
				profile.setDataNascimento(rs.getString("DataNascimento"));
				profile.setDistanciaMaxima(rs.getInt("DistanciaMaxima"));
				profile.setFaixaEtaria(rs.getInt("FaixaEtaria"));
				profile.setStatusPerfil(rs.getString("StatusPerfil"));
				profile.setDescricao(rs.getString("Descricao"));
				profile.setFilme(rs.getString("GeneroFilme"));
				profile.setMusica(rs.getString("GeneroMusica"));
				profile.setSerie(rs.getString("SerieFavorita"));
				profile.setAnime(rs.getString("AnimeFavorito"));
				profile.setOcupacao(rs.getString("Ocupacao"));
				profile.setIdPerfilFacebook(rs.getInt("PerfilFacebook_idPerfilFacebook"));
				profile.setIdUser(rs.getInt("Registro_idRegistro"));
				
			}
		} catch (Exception e) {
			System.out.println("Error trying to search the profile with ID= " + id + "\n" + e);
            e.printStackTrace();
		} finally {
			closeConnection(connection, pstmt, rs);
		}
		
		return profile;
	}
	
	public boolean insert(Profile profile) {
		
		String nome = profile.getNome();
		String sexo = profile.getSexo();
		String dataNascimento = profile.getDataNascimento();
		int distanciaMaxima = profile.getDistanciaMaxima();
		int faixaEtaria = profile.getFaixaEtaria();
		String statusPerfil = profile.getStatusPerfil();
		String descricao = profile.getDescricao();
		String filme = profile.getFilme();
		String musica = profile.getMusica();
		String serie = profile.getSerie();
		String anime = profile.getAnime();
		String ocupacao = profile.getOcupacao();
		int idPerfilFacebook = profile.getIdPerfilFacebook();
		int iduser = profile.getIdUser();
				
		boolean isProfileCreated = false;
		
		PreparedStatement pstmt = null;
		Connection connection = createConnection();
		try {
			pstmt = connection.prepareStatement("INSERT INTO profile(Nome, Sexo, DataNascimento, DistanciaMaxima, FaixaEtaria,"
					+ " StatusPerfil, Descricao, GeneroFilme, GeneroMusica, SerieFavorita, AnimeFavorito, Ocupacao,"
					+ " PerfilFacebook_idPerfilFacebook, Registro_idRegistro)"
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, nome);
			pstmt.setString(2, sexo);
			pstmt.setString(3, dataNascimento);
			pstmt.setInt(4, distanciaMaxima);
			pstmt.setInt(5, faixaEtaria);
			pstmt.setString(6, statusPerfil);
			pstmt.setString(7, descricao);
			pstmt.setString(8, filme);
			pstmt.setString(9, musica);
			pstmt.setString(10, serie);
			pstmt.setString(11, anime);
			pstmt.setString(12, ocupacao);
			pstmt.setInt(13, idPerfilFacebook);
			pstmt.setInt(14, iduser);
			
			boolean execute = pstmt.execute();
			System.out.println(execute);
			isProfileCreated = true;
			
		} catch (SQLException e) {
			isProfileCreated = false;
			e.printStackTrace();
		}
		return isProfileCreated;
	}
	
	public int updateProfile(Profile profile) {
		
		String nome = profile.getNome();
		String sexo = profile.getSexo();
		String dataNascimento = profile.getDataNascimento();
		int distanciaMaxima = profile.getDistanciaMaxima();
		int faixaEtaria = profile.getFaixaEtaria();
		String statusPerfil = profile.getStatusPerfil();
		String descricao = profile.getDescricao();
		String filme = profile.getFilme();
		String musica = profile.getMusica();
		String serie = profile.getSerie();
		String anime = profile.getAnime();
		String ocupacao = profile.getOcupacao();
		int idUser = profile.getIdUser();
		int idProfile = profile.getIdProfile();
				
		int isProfileUpdated = 2;
		
		PreparedStatement pstmt = null;
		Connection connection = createConnection();
		try {
			pstmt = connection.prepareStatement("UPDATE profile set Nome = ?,  Sexo = ?, DataNascimento = ?, DistanciaMaxima = ?, FaixaEtaria = ?,"
					+ " StatusPerfil = ?, Descricao = ?, GeneroFilme = ?, GeneroMusica = ?, SerieFavorita = ?, AnimeFavorito = ?, Ocupacao = ?,"
					+ " PerfilFacebook_idPerfilFacebook = ?, Registro_idRegistro = ? WHERE ID_PROFILE = ?");
			pstmt.setString(1, nome);
			pstmt.setString(2, sexo);
			pstmt.setString(3, dataNascimento);
			pstmt.setInt(4, distanciaMaxima);
			pstmt.setInt(5, faixaEtaria);
			pstmt.setString(6, statusPerfil);
			pstmt.setString(7, descricao);
			pstmt.setString(8, filme);
			pstmt.setString(9, musica);
			pstmt.setString(10, serie);
			pstmt.setString(11, anime);
			pstmt.setString(12, ocupacao);
			pstmt.setInt(13, 1);
			pstmt.setInt(14, idUser);
			pstmt.setInt(15, idProfile);
			
			isProfileUpdated = pstmt.executeUpdate();					
		} catch (SQLException e) {
			isProfileUpdated = 0;
			e.printStackTrace();
		}
		return isProfileUpdated;
	}
	
	public boolean updateProfilePersonality(Profile profile) {
		int idProfile = profile.getIdProfile();
		String filme = profile.getFilme();
		String musica = profile.getMusica();
		String serie = profile.getSerie();
		String anime = profile.getAnime();
				
		boolean isProfileUpdated = false;
		
		PreparedStatement pstmt = null;
		Connection connection = createConnection();
		try {
			pstmt = connection.prepareStatement("UPDATE profile SET GeneroFilme = ?, GeneroMusica = ?, "
					+ " SerieFavorita = ?, AnimeFavorito = ?" 
					+ " WHERE ID_PROFILE = ?");
			pstmt.setString(1, filme);
			pstmt.setString(2, musica);
			pstmt.setString(3, serie);
			pstmt.setString(4, anime);
			pstmt.setInt(5, idProfile);
			
			isProfileUpdated = pstmt.execute();			
			isProfileUpdated = true;
		} catch (SQLException e) {
			isProfileUpdated = false;
			e.printStackTrace();
		} finally {
			closeConnection(connection, pstmt, null);
		}
		System.out.println(isProfileUpdated);
		return isProfileUpdated;
	}
	
	public boolean updateProfileDescription(Profile profile) {
		int idProfile = profile.getIdProfile();
		String descricao = profile.getDescricao();
		String ocupacao = profile.getOcupacao();
				
		boolean isProfileUpdated = false;
		
		PreparedStatement pstmt = null;
		Connection connection = createConnection();
		try {
			pstmt = connection.prepareStatement("UPDATE profile SET Descricao = ?, Ocupacao = ?,  FaixaEtaria = ?,"
					+ "StatusPerfil = ? WHERE ID_PROFILE = ?");
			pstmt.setString(1, descricao);
			pstmt.setString(2, ocupacao);
			pstmt.setInt(3, 18);
			pstmt.setString(4, "T");
			pstmt.setInt(5, idProfile);
			
			isProfileUpdated = pstmt.execute();
			isProfileUpdated = true;
		} catch (SQLException e) {
			isProfileUpdated = false;
			e.printStackTrace();
		} finally {
			closeConnection(connection, pstmt, null);
		}
		return isProfileUpdated;
	}
	
	public boolean delete(String id) {
		boolean isProfileDeleted = false;
		PreparedStatement pstmt = null;
		Connection connection = createConnection();
		
		Integer idProfile = Integer.parseInt(id);
		try {
			pstmt = connection.prepareStatement("DELETE FROM profile WHERE ID_PROFILE = ?");
			pstmt.setInt(1, idProfile);
			
			boolean execute = pstmt.execute();
			isProfileDeleted = true;
			
			System.out.println("The Profile was deleted: " + execute);
		 } catch (SQLException e){
			 isProfileDeleted = false;
	            e.printStackTrace();
	        }finally {
	            closeConnection(connection, pstmt, null);
	        }
		return isProfileDeleted;
	}
	
	public Profile searchLastCreatedID() {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Profile profile = null;
				
		connection = createConnection();
		
		try {
			pstmt = connection.prepareStatement("SELECT * FROM profile ORDER BY ID_PROFILE DESC LIMIT 1");		
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				profile = new Profile();
				
				profile.setIdProfile(rs.getInt("ID_PROFILE"));
				
			}
		} catch (Exception e) {
			System.out.println("Error trying to search the last created ID " + e);
            e.printStackTrace();
		} finally {
			closeConnection(connection, pstmt, rs);
		}
		
		return profile;
	}
	
	public ArrayList<Profile> listProfilesToMatch(Profile profile){
		Connection connection = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ArrayList<Profile> profiles = null;

        connection = createConnection();
        profiles = new ArrayList<Profile>();
        
        int idUser = profile.getIdUser();
        int distanciaMaxima = profile.getDistanciaMaxima();
		String descricao = profile.getDescricao();
		String filme = profile.getFilme();
		String musica = profile.getMusica();
		String serie = profile.getSerie();
		String anime = profile.getAnime();
		String ocupacao = profile.getOcupacao(); 

        try {
            pstmt = connection.prepareStatement("SELECT * FROM Profile WHERE DistanciaMaxima = ? OR "
            		+ "OR Descricao = ? OR GeneroFilme = ? OR GeneroMusica = ? OR SerieFavorita = ? OR "
            		+ "AnimeFavorito = ? OR Ocupacao = ? AND Registro_idRegistro = ? ORDER BY Nome");
            
            pstmt.setInt(1, distanciaMaxima);
			pstmt.setString(2, descricao);
			pstmt.setString(3, filme);
			pstmt.setString(4, musica);
			pstmt.setString(5, serie);
			pstmt.setString(6, anime);
			pstmt.setString(7, ocupacao);
			pstmt.setInt(8, idUser);
			
            rs = pstmt.executeQuery();

            while (rs.next()){

            	Profile profileToMatch = new Profile();

            	profileToMatch.setIdProfile(rs.getInt("ID_PROFILE"));
            	profileToMatch.setNome(rs.getString("Nome"));
            	profileToMatch.setSexo(rs.getString("Sexo"));
            	profileToMatch.setDataNascimento(rs.getString("DataNascimento"));
            	profileToMatch.setDistanciaMaxima(rs.getInt("DistanciaMaxima"));
            	profileToMatch.setFaixaEtaria(rs.getInt("FaixaEtaria"));
            	profileToMatch.setStatusPerfil(rs.getString("StatusPerfil"));
            	profileToMatch.setDescricao(rs.getString("Descricao"));
            	profileToMatch.setFilme(rs.getString("GeneroFilme"));
            	profileToMatch.setMusica(rs.getString("GeneroMusica"));
            	profileToMatch.setSerie(rs.getString("SerieFavorita"));
            	profileToMatch.setAnime(rs.getString("AnimeFavorito"));
            	profileToMatch.setOcupacao(rs.getString("Ocupacao"));
            	profileToMatch.setIdPerfilFacebook(rs.getInt("PerfilFacebook_idPerfilFacebook"));
            	profileToMatch.setIdUser(rs.getInt("Registro_idRegistro"));

                profiles.add(profileToMatch);
            }

        }catch (Exception e){
            System.out.println("Error listing all clients: " + e);
            e.printStackTrace();
        } finally {
            closeConnection(connection, pstmt, rs);
        }
        return profiles;
	}
	

}
