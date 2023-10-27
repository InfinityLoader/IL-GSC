/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_mech.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 69 ms
 * Timestamp: 10/27/2023 1:52:42 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "mech.csv";
	self.team = "allies";
	self.type = "mech";
	self.subclass = "mech";
	self.accuracy = 0.2;
	self.health = 3600;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "iw5_titan45_sp";
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(0,0);
		self setengagementmaxdist(256,1024);
	}

	self.weapon = "exo_minigun";
	character\character_mech::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_mech::precache();
	precacheitem("exo_minigun");
	precacheitem("iw5_titan45_sp");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
	maps\_mech::main();
}