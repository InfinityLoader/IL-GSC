/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_coop_cloaked_static.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:12 AM
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
	self.health = 500;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 1;
	self.secondaryweapon = "";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	character\character_coop_cloaked_static::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_coop_cloaked_static::precache();
	precacheitem("fraggrenade");
}