/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_hero_ilana_sentinel_ie.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:57:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "allies";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 100;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_pbwsingleshot_sp_silencerpistol";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(5))
	{
		case 0:
			self.weapon = "iw5_kf5fullauto_sp_silencer01";
			break;

		case 1:
			self.weapon = "iw5_kf5fullauto_sp_opticsacog2_silencer01";
			break;

		case 2:
			self.weapon = "iw5_kf5fullauto_sp_opticstargetenhancer_silencer01";
			break;

		case 3:
			self.weapon = "iw5_kf5fullauto_sp_opticsreddot_silencer01";
			break;

		case 4:
			self.weapon = "iw5_kf5fullauto_sp_silencer01_variablereddot";
			break;
	}

	character\character_hero_ilana_sentinel_udt_b::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_hero_ilana_sentinel_udt_b::precache();
	precacheitem("iw5_kf5fullauto_sp_silencer01");
	precacheitem("iw5_kf5fullauto_sp_opticsacog2_silencer01");
	precacheitem("iw5_kf5fullauto_sp_opticstargetenhancer_silencer01");
	precacheitem("iw5_kf5fullauto_sp_opticsreddot_silencer01");
	precacheitem("iw5_kf5fullauto_sp_silencer01_variablereddot");
	precacheitem("iw5_pbwsingleshot_sp_silencerpistol");
	precacheitem("fraggrenade");
}