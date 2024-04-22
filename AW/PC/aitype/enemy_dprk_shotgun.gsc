/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_dprk_shotgun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 200;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_vbr_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(3))
	{
		case 0:
			self.weapon = "iw5_maul_sp";
			break;

		case 1:
			self.weapon = "iw5_maul_sp_opticsreddot";
			break;

		case 2:
			self.weapon = "iw5_maul_sp_opticstargetenhancer";
			break;
	}

	character\character_dprk_shotgun::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_dprk_shotgun::precache();
	precacheitem("iw5_maul_sp");
	precacheitem("iw5_maul_sp_opticsreddot");
	precacheitem("iw5_maul_sp_opticstargetenhancer");
	precacheitem("iw5_vbr_sp");
	precacheitem("fraggrenade");
}