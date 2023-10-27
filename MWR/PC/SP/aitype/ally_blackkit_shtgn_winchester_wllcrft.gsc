/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_blackkit_shtgn_winchester_wllcrft.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 2:42:33 AM
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

	self.weapon = "winchester1200";
	character\character_sp_sas_ct_charles::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_ct_charles::precache();
	precacheitem("winchester1200");
	precacheitem("usp");
	precacheitem("usp");
	precacheitem("fraggrenade");
}