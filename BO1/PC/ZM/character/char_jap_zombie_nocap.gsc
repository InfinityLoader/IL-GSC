
main()
{
	codescripts\character::setModelFromArray(xmodelalias\char_jap_impinf_zombiebody5alias::main());
	self.headModel = codescripts\character::randomElement(xmodelalias\char_jap_impinf2_zombieheadalias::main());
	self attach(self.headModel, "", true);
	self.voice = "american";
	self.skeleton = "base";
	self.torsoDmg1 = "char_jap_impinf_body5z_g_upclean";
	self.torsoDmg2 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_rarmoffalias::main());
	self.torsoDmg3 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_larmoffalias::main());
	self.torsoDmg4 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_torsoalias::main());
	self.torsoDmg5 = "char_jap_impinf_body5z_g_behead";
	self.legDmg1 = "char_jap_impinf_body5z_g_lowclean";
	self.legDmg2 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_rlegoffalias::main());
	self.legDmg3 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_llegoffalias::main());
	self.legDmg4 = codescripts\character::randomElement(xmodelalias\char_jap_impinf_mk_b5z_g_legsoffalias::main());
	self.gibSpawn1 = "char_jap_impinf_body5z_g_rarmspawn";
	self.gibSpawnTag1 = "J_Elbow_RI";
	self.gibSpawn2 = "char_jap_impinf_body5z_g_larmspawn";
	self.gibSpawnTag2 = "J_Elbow_LE";
	self.gibSpawn3 = "char_jap_impinf_body5z_g_rlegspawn";
	self.gibSpawnTag3 = "J_Knee_RI";
	self.gibSpawn4 = "char_jap_impinf_body5z_g_llegspawn";
	self.gibSpawnTag4 = "J_Knee_LE";
}
precache()
{
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_zombiebody5alias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf2_zombieheadalias::main());
	precacheModel("char_jap_impinf_body5z_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_torsoalias::main());
	precacheModel("char_jap_impinf_body5z_g_behead");
	precacheModel("char_jap_impinf_body5z_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_legsoffalias::main());
	precacheModel("char_jap_impinf_body5z_g_rarmspawn");
	precacheModel("char_jap_impinf_body5z_g_larmspawn");
	precacheModel("char_jap_impinf_body5z_g_rlegspawn");
	precacheModel("char_jap_impinf_body5z_g_llegspawn");
	precacheModel("char_jap_impinf_body5z_g_upclean");
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_rarmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_larmoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_torsoalias::main());
	precacheModel("char_jap_impinf_body5z_g_behead");
	precacheModel("char_jap_impinf_body5z_g_lowclean");
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_rlegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_llegoffalias::main());
	codescripts\character::precacheModelArray(xmodelalias\char_jap_impinf_mk_b5z_g_legsoffalias::main());
	precacheModel("char_jap_impinf_body5z_g_rarmspawn");
	precacheModel("char_jap_impinf_body5z_g_larmspawn");
	precacheModel("char_jap_impinf_body5z_g_rlegspawn");
	precacheModel("char_jap_impinf_body5z_g_llegspawn");
}
 