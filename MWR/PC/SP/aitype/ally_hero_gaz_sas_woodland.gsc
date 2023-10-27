/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_hero_gaz_sas_woodland.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 67 ms
 * Timestamp: 10/27/2023 2:42:35 AM
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
	self.secondaryweapon = "usp_silencer";
	self.sidearm = "usp_silencer";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "g36c";
	character\character_sp_sas_woodland_gaz::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_woodland_gaz::precache();
	precacheitem("g36c");
	precacheitem("usp_silencer");
	precacheitem("usp_silencer");
	precacheitem("fraggrenade");
}