/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_hero_gideon_captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 50 ms
 * Timestamp: 4/22/2024 1:57:08 AM
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
	self.grenadeweapon = "flash_grenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "iw5_hmr9_sp";
	character\character_hero_gideon_captured::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_hero_gideon_captured::precache();
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_titan45_sp");
	precacheitem("flash_grenade");
}