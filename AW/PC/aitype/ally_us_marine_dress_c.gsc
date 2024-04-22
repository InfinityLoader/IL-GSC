/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_us_marine_dress_c.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 55 ms
 * Timestamp: 4/22/2024 1:57:24 AM
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

	self.weapon = "none";
	character\character_us_marine_dress_c::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_us_marine_dress_c::precache();
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}