
main()
{
	self setModel("c_zom_moon_tech_body_shirtguts_2");
	self.headModel = codescripts\character::randomElement(xmodelalias\c_zom_moon_heads_alias::main());
	self attach(self.headModel, "", true);
	self.hatModel = codescripts\character::randomElement(xmodelalias\c_zom_moon_tech_caps2_alias::main());
	self attach(self.hatModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
	self.torsoDmg1 = "c_zom_moon_tech_body_sg_g_upclean_2";
	self.torsoDmg2 = "c_zom_moon_tech_body_sg_g_rarmoff_2";
	self.torsoDmg3 = "c_zom_moon_tech_body_sg_g_larmoff_2";
	self.torsoDmg5 = "c_zom_moon_tech_body_sg_g_behead";
	self.legDmg1 = "c_zom_moon_tech_body_g_lowclean_2";
	self.legDmg2 = "c_zom_moon_tech_body_g_rlegoff_2";
	self.legDmg3 = "c_zom_moon_tech_body_g_llegoff_2";
	self.legDmg4 = "c_zom_moon_tech_body_g_legsoff_2";
	self.gibSpawn1 = "c_zom_moon_tech_body_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "c_zom_moon_tech_body_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "c_zom_moon_tech_body_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "c_zom_moon_tech_body_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	precacheModel("c_zom_moon_tech_body_shirtguts_2");
	codescripts\character::precacheModelArray(xmodelalias\c_zom_moon_heads_alias::main());
	codescripts\character::precacheModelArray(xmodelalias\c_zom_moon_tech_caps2_alias::main());
	precacheModel("c_zom_moon_tech_body_sg_g_upclean_2");
	precacheModel("c_zom_moon_tech_body_sg_g_rarmoff_2");
	precacheModel("c_zom_moon_tech_body_sg_g_larmoff_2");
	precacheModel("c_zom_moon_tech_body_sg_g_behead");
	precacheModel("c_zom_moon_tech_body_g_lowclean_2");
	precacheModel("c_zom_moon_tech_body_g_rlegoff_2");
	precacheModel("c_zom_moon_tech_body_g_llegoff_2");
	precacheModel("c_zom_moon_tech_body_g_legsoff_2");
	precacheModel("c_zom_moon_tech_body_g_rarmspawn");
	precacheModel("c_zom_moon_tech_body_g_larmspawn");
	precacheModel("c_zom_moon_tech_body_g_rlegspawn");
	precacheModel("c_zom_moon_tech_body_g_llegspawn");
	precacheModel("c_zom_moon_tech_body_sg_g_upclean_2");
	precacheModel("c_zom_moon_tech_body_sg_g_rarmoff_2");
	precacheModel("c_zom_moon_tech_body_sg_g_larmoff_2");
	precacheModel("c_zom_moon_tech_body_sg_g_behead");
	precacheModel("c_zom_moon_tech_body_g_lowclean_2");
	precacheModel("c_zom_moon_tech_body_g_rlegoff_2");
	precacheModel("c_zom_moon_tech_body_g_llegoff_2");
	precacheModel("c_zom_moon_tech_body_g_legsoff_2");
	precacheModel("c_zom_moon_tech_body_g_rarmspawn");
	precacheModel("c_zom_moon_tech_body_g_larmspawn");
	precacheModel("c_zom_moon_tech_body_g_rlegspawn");
	precacheModel("c_zom_moon_tech_body_g_llegspawn");
}
 