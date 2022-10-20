class HeartDiseaseFormModel {
  final int? age;
  final int? sex;
  final int? cigs;
  final int? chol;
  final int? sBP;
  final int? dia;
  final int? dBP;
  final int? gluc;
  final int? hRate;

  HeartDiseaseFormModel({
    this.age,
    this.sex,
    this.cigs,
    this.chol,
    this.sBP,
    this.dia,
    this.dBP,
    this.gluc,
    this.hRate,
  });

  Map<String, dynamic> toJson() => {
        'age': age,
        'sex': sex,
        'cigs': cigs,
        'chol': chol,
        'sBP': sBP,
        'dia': dia,
        'dBP': dBP,
        'gluc': gluc,
        'hRate': hRate,
      };
}
