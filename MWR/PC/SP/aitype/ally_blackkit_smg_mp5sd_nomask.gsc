/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_blackkit_smg_mp5sd_nomask.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 68 ms
 * Timestamp: 10/27/2023 2:42:34 AM
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
	self.secondaryweapon = "usp_silencer";
	self.sidearm = "usp_silencer";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "mp5_silencer";
	character\character_sp_sas_ct_mitchel_nomask::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_ct_mitchel_nomask::precache();
	precacheitem("mp5_silencer");
	precacheitem("usp_silencer");
	precacheitem("usp_silencer");
	precacheitem("fraggrenade");
}