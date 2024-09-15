class AppSizes{
  static bool isTab=false;
  static double scrX=10, scrY=10; //DO NOT CHANGE THIS VALUE
  static double padDefault=10;
  static double padDefaultMin=0;
  static double padDefaultMicro=0;
  static double szFontTitle=36;
  static double szFontTitleLargest=36;
  static double szFontTitleLarger=36;
  static double szFontTitleLarge=36;
  static double szFontLargeText=36;
  static double szFontLabel=36;
  static double szFontNormalText=36;
  static double szFontMiniText=36;
  static double szFontMicroText=36;
  static double szFontMicroMiniText=36;
  static double buttonHeightDefault=36;
  static double buttonRadiusDefault=36;
  static double buttonRadiusMini=36;
  static double buttonRadiusMicro=36;
  static double iconSizeTextField=36;
  static double defaultIconSize=0;
  static double defaultRadius=5;
  static double bottomNavHeight=5;

  static updateSizes({required double width, required double height}){
    scrX = width;
    scrY = height;
    padDefault = isTab?(AppSizes.scrX>AppSizes.scrY? height/15: width / 10):(AppSizes.scrX>AppSizes.scrY? height/15: width / 10);
    padDefaultMin = isTab?(AppSizes.scrX>AppSizes.scrY? height/25: width / 15):(AppSizes.scrX>AppSizes.scrY? height/25: width / 15);
    padDefaultMicro = isTab?(AppSizes.scrX>AppSizes.scrY? height/40: width / 30):(AppSizes.scrX>AppSizes.scrY? height/40: width / 30);
    szFontTitleLargest = isTab?(AppSizes.scrX>AppSizes.scrY? height/10: width / 10):(AppSizes.scrX>AppSizes.scrY? height/8: width / 8);
    szFontTitleLarger = isTab?(AppSizes.scrX>AppSizes.scrY? height/12: width / 12):(AppSizes.scrX>AppSizes.scrY? height/10: width / 10);
    szFontTitleLarge = isTab?(AppSizes.scrX>AppSizes.scrY? height/15: width / 15):(AppSizes.scrX>AppSizes.scrY? height/13: width / 13);
    szFontTitle = isTab?(AppSizes.scrX>AppSizes.scrY? height/20: width / 20):(AppSizes.scrX>AppSizes.scrY? height/18: width / 18);
    szFontLabel = isTab?(AppSizes.scrX>AppSizes.scrY? height/25: width / 25):(AppSizes.scrX>AppSizes.scrY? height/23: width / 23);
    szFontLargeText = isTab?(AppSizes.scrX>AppSizes.scrY? height/30: width / 30):(AppSizes.scrX>AppSizes.scrY? height/27: width / 27);
    szFontNormalText = isTab?(AppSizes.scrX>AppSizes.scrY? height/35: width / 35):(AppSizes.scrX>AppSizes.scrY? height/33: width / 33);
    szFontMiniText = isTab?(AppSizes.scrX>AppSizes.scrY? height/45: width / 45):(AppSizes.scrX>AppSizes.scrY? height/38: width / 38);
    szFontMicroText = isTab?(AppSizes.scrX>AppSizes.scrY? height/55: width / 55):(AppSizes.scrX>AppSizes.scrY? height/43: width / 43);
    szFontMicroMiniText = isTab?(AppSizes.scrX>AppSizes.scrY? height/55: width / 55):(AppSizes.scrX>AppSizes.scrY? height/45: width / 45);
    buttonHeightDefault = isTab?(AppSizes.scrX>AppSizes.scrY? height/10: width/10):(AppSizes.scrX>AppSizes.scrY? height/10: width / 7);
    buttonRadiusDefault = isTab?(AppSizes.scrX>AppSizes.scrY? height/15: width / 15):(AppSizes.scrX>AppSizes.scrY? height/15: width / 15);
    buttonRadiusMini = isTab?(AppSizes.scrX>AppSizes.scrY? height/25: width / 25):(AppSizes.scrX>AppSizes.scrY? height/25: width / 25);
    buttonRadiusMicro = isTab?(AppSizes.scrX>AppSizes.scrY? height/40: width / 40):(AppSizes.scrX>AppSizes.scrY? height/40: width / 40);
    iconSizeTextField = isTab?(AppSizes.scrX>AppSizes.scrY? height/25: width / 25):(AppSizes.scrX>AppSizes.scrY? height/25: width / 25);
    defaultIconSize=isTab?(scrX>scrY?scrX/30:scrX/20):(scrX>scrY?scrY/20:scrX/14);
    defaultRadius = isTab?(AppSizes.scrX>AppSizes.scrY? height/100: width / 100):(AppSizes.scrX>AppSizes.scrY? height/150: width / 150);
    bottomNavHeight=AppSizes.scrX/7;
  }
}