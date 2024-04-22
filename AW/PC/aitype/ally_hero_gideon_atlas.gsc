/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_hero_gideon_atlas.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 42 ms
 * Timestamp: 4/22/2024 1:57:06 AM
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

	self.weapon = "iw5_bal27_sp_variablereddot";
	character\character_hero_gideon_atlas::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_hero_gideon_atlas::precache();
	precacheitem("iw5_bal27_sp_variablereddot");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}