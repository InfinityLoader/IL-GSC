/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_hero_price_blackkit.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 70 ms
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

	self.weapon = "m4_silencer";
	character\character_sp_sas_ct_price::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_ct_price::precache();
	precacheitem("m4_silencer");
	precacheitem("usp_silencer");
	precacheitem("usp_silencer");
	precacheitem("fraggrenade");
}