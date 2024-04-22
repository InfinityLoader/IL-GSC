/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_atlas_elite_shotgun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 4/22/2024 1:58:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "elite";
	self.accuracy = 0.2;
	self.health = 1000;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45loot_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(4))
	{
		case 0:
			self.weapon = "iw5_uts19loot_sp";
			break;

		case 1:
			self.weapon = "iw5_uts19loot_sp_opticstargetenhancer";
			break;

		case 2:
			self.weapon = "iw5_uts19loot_sp_foregrip";
			break;

		case 3:
			self.weapon = "iw5_uts19loot_sp_opticsreddot";
			break;
	}

	character\character_atlas_elete::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_atlas_elete::precache();
	precacheitem("iw5_uts19loot_sp");
	precacheitem("iw5_uts19loot_sp_opticstargetenhancer");
	precacheitem("iw5_uts19loot_sp_foregrip");
	precacheitem("iw5_uts19loot_sp_opticsreddot");
	precacheitem("iw5_titan45loot_sp");
	precacheitem("fraggrenade");
}