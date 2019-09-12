class Dog {
  int id;
  String nombre;
  String raza;
  int edad;
  String desc;
  String dueno;
  int fonoDueno;

  Dog(
      {this.id,
      this.nombre,
      this.raza,
      this.edad,
      this.desc,
      this.dueno,
      this.fonoDueno});

  Dog.fromJsonDB(Map<String, dynamic> json) {
    this.id = json["id"];
    this.nombre = json["nombre"];
    this.raza = json["raza"];
    this.edad = json["edad"];
    this.desc = json["desc"];
    this.dueno = json["dueno"];
    this.fonoDueno = json["fono_dueno"];
  }

  Map<String, dynamic> toJsonDB() => {
        "id": id,
        "nombre": nombre,
        "raza": raza,
        "edad": edad,
        "desc": desc,
        "dueno": dueno,
        "fono_dueno": fonoDueno
      };
}
