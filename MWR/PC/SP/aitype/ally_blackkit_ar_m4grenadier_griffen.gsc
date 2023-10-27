/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_blackkit_ar_m4grenadier_griffen.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 2:42:32 AM
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
	self.health = 150;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "usp";
	self.sidearm = "usp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "m4_grenadier";
	character\character_sp_sas_ct_william::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_ct_william::precache();
	precacheitem("m4_grenadier");
	precacheitem("m203_m4");
	precacheitem("usp");
	precacheitem("usp");
	precacheitem("fraggrenade");
}