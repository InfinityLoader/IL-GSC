/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_sentinel_pilot.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:52:43 AM
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

	self.weapon = "iw5_hbra3_sp";
	character\character_hero_carter_pmc::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_hero_carter_pmc::precache();
	precacheitem("iw5_hbra3_sp");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}