/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_blackkit_smg_mp5.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 74 ms
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

	self.weapon = "mp5";
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
	character\character_sp_sas_ct_benjamin::precache();
	character\character_sp_sas_ct_charles::precache();
	character\character_sp_sas_ct_mitchel::precache();
	character\character_sp_sas_ct_neal::precache();
	character\character_sp_sas_ct_william::precache();
	precacheitem("mp5");
	precacheitem("usp");
	precacheitem("usp");
	precacheitem("fraggrenade");
}