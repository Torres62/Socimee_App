class Profile {
  int _idProfile;
  String _nome;
  String _sexo;
  String _dataNascimento;
  int _distanciaMaxima;
  int _faixaEtaria;
  String _statusPerfil;
  String _descricao;
  String _filme;
  String _musica;
  String _serie;
  String _anime;
  String _ocupacao;
  int _idPerfilFacebook;
  int _idUser;

  Profile(
      {int idProfile,
      String nome,
      String sexo,
      String dataNascimento,
      int distanciaMaxima,
      int faixaEtaria,
      String statusPerfil,
      String descricao,
      String filme,
      String musica,
      String serie,
      String anime,
      String ocupacao,
      int idPerfilFacebook,
      int idUser}) {
    this._idProfile = idProfile;
    this._nome = nome;
    this._sexo = sexo;
    this._dataNascimento = dataNascimento;
    this._distanciaMaxima = distanciaMaxima;
    this._faixaEtaria = faixaEtaria;
    this._statusPerfil = statusPerfil;
    this._descricao = descricao;
    this._filme = filme;
    this._musica = musica;
    this._serie = serie;
    this._anime = anime;
    this._ocupacao = ocupacao;
    this._idPerfilFacebook = idPerfilFacebook;
    this._idUser = idUser;
  }

  int get idProfile => _idProfile;
  set idProfile(int idProfile) => _idProfile = idProfile;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get sexo => _sexo;
  set sexo(String sexo) => _sexo = sexo;
  String get dataNascimento => _dataNascimento;
  set dataNascimento(String dataNascimento) => _dataNascimento = dataNascimento;
  int get distanciaMaxima => _distanciaMaxima;
  set distanciaMaxima(int distanciaMaxima) =>
      _distanciaMaxima = distanciaMaxima;
  int get faixaEtaria => _faixaEtaria;
  set faixaEtaria(int faixaEtaria) => _faixaEtaria = faixaEtaria;
  String get statusPerfil => _statusPerfil;
  set statusPerfil(String statusPerfil) => _statusPerfil = statusPerfil;
  String get descricao => _descricao;
  set descricao(String descricao) => _descricao = descricao;
  String get filme => _filme;
  set filme(String filme) => _filme = filme;
  String get musica => _musica;
  set musica(String musica) => _musica = musica;
  String get serie => _serie;
  set serie(String serie) => _serie = serie;
  String get anime => _anime;
  set anime(String anime) => _anime = anime;
  String get ocupacao => _ocupacao;
  set ocupacao(String ocupacao) => _ocupacao = ocupacao;
  int get idPerfilFacebook => _idPerfilFacebook;
  set idPerfilFacebook(int idPerfilFacebook) =>
      _idPerfilFacebook = idPerfilFacebook;
  int get idUser => _idUser;
  set idUser(int idUser) => _idUser = idUser;

  Profile.fromJson(Map<String, dynamic> json) {
    _idProfile = json['idProfile'];
    _nome = json['nome'];
    _sexo = json['sexo'];
    _dataNascimento = json['dataNascimento'];
    _distanciaMaxima = json['distanciaMaxima'];
    _faixaEtaria = json['faixaEtaria'];
    _statusPerfil = json['statusPerfil'];
    _descricao = json['descricao'];
    _filme = json['filme'];
    _musica = json['musica'];
    _serie = json['serie'];
    _anime = json['anime'];
    _ocupacao = json['ocupacao'];
    _idPerfilFacebook = json['idPerfilFacebook'];
    _idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProfile'] = this._idProfile;
    data['nome'] = this._nome;
    data['sexo'] = this._sexo;
    data['dataNascimento'] = this._dataNascimento;
    data['distanciaMaxima'] = this._distanciaMaxima;
    data['faixaEtaria'] = this._faixaEtaria;
    data['statusPerfil'] = this._statusPerfil;
    data['descricao'] = this._descricao;
    data['filme'] = this._filme;
    data['musica'] = this._musica;
    data['serie'] = this._serie;
    data['anime'] = this._anime;
    data['ocupacao'] = this._ocupacao;
    data['idPerfilFacebook'] = this._idPerfilFacebook;
    data['idUser'] = this._idUser;
    return data;
  }
}