/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_scientist_s1_a.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 67 ms
 * Timestamp: 4/22/2024 1:57:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "civilian";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 100;
	self.grenadeweapon = "";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	character\character_civ_scientist_s1_a::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("neutral");
}

//Function Number: 3
precache()
{
	character\character_civ_scientist_s1_a::precache();
}