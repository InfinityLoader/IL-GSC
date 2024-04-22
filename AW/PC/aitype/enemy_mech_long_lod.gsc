/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_mech_long_lod.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 1:58:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "mech.csv";
	self.team = "axis";
	self.type = "mech";
	self.subclass = "mech";
	self.accuracy = 0.2;
	self.health = 4500;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(512,0);
		self setengagementmaxdist(2056,2056);
	}

	self.weapon = "exo_minigun";
	character\character_mech_long_lod::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_mech_long_lod::precache();
	precacheitem("exo_minigun");
	precacheitem("fraggrenade");
	maps\_mech::main();
}