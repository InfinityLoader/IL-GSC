/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_sas_woodland_ar_m4_light_gear.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 68 ms
 * Timestamp: 10/27/2023 2:42:36 AM
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

	self.weapon = "m16_basic";
	switch(codescripts\character::get_random_character(12))
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

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		case 9:
			break;

		case 10:
			break;

		case 11:
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
	character\character_sp_sas_woodland_colon_a::precache();
	character\character_sp_sas_woodland_colon_b::precache();
	character\character_sp_sas_woodland_colon_c::precache();
	character\character_sp_sas_woodland_colon_d::precache();
	character\character_sp_sas_woodland_colon_e::precache();
	character\character_sp_sas_woodland_colon_f::precache();
	character\character_sp_sas_woodland_golden_a::precache();
	character\character_sp_sas_woodland_golden_b::precache();
	character\character_sp_sas_woodland_golden_c::precache();
	character\character_sp_sas_woodland_golden_d::precache();
	character\character_sp_sas_woodland_golden_e::precache();
	character\character_sp_sas_woodland_golden_f::precache();
	precacheitem("m16_basic");
	precacheitem("usp");
	precacheitem("usp");
	precacheitem("fraggrenade");
}