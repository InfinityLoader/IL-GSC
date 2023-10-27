/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_sas_woodland_lmg_saw.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:42:37 AM
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

	self.weapon = "saw";
	switch(codescripts\character::get_random_character(5))
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sp_sas_woodland_mac::precache();
	character\character_sp_sas_woodland_zied::precache();
	character\character_sp_sas_woodland_peter::precache();
	character\character_sp_sas_woodland_hugh::precache();
	character\character_sp_sas_woodland_todd::precache();
	precacheitem("saw");
	precacheitem("usp");
	precacheitem("usp");
	precacheitem("fraggrenade");
}