/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_atlas_lmg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:05 AM
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
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(6))
	{
		case 0:
			self.weapon = "iw5_asaw_sp";
			break;

		case 1:
			self.weapon = "iw5_asaw_sp_opticsacog2";
			break;

		case 2:
			self.weapon = "iw5_asaw_sp_opticsreddot";
			break;

		case 3:
			self.weapon = "iw5_asaw_sp_opticsthermal";
			break;

		case 4:
			self.weapon = "iw5_asaw_sp_variablereddot";
			break;

		case 5:
			self.weapon = "iw5_asaw_sp_opticstargetenhancer";
			break;
	}

	character\character_atlas_smg::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_atlas_smg::precache();
	precacheitem("iw5_asaw_sp");
	precacheitem("iw5_asaw_sp_opticsacog2");
	precacheitem("iw5_asaw_sp_opticsreddot");
	precacheitem("iw5_asaw_sp_opticsthermal");
	precacheitem("iw5_asaw_sp_variablereddot");
	precacheitem("iw5_asaw_sp_opticstargetenhancer");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}