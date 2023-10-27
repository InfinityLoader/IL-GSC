/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_us_marine_shotgun_seo_lowlod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:52:47 AM
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
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(4))
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_us_marine_shotgun_lowlod::precache();
	precacheitem("iw5_uts19_sp");
	precacheitem("iw5_uts19_sp_opticstargetenhancer");
	precacheitem("iw5_uts19_sp");
	precacheitem("iw5_uts19_sp_opticsreddot");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}