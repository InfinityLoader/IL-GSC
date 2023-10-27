/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_us_army_casual.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 2:42:38 AM
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
	self.grenadeweapon = "";
	self.grenadeammo = 0;
	self.secondaryweapon = "beretta";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "m4_grunt";
	switch(codescripts\character::get_random_character(8))
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
	character\character_sp_sas_woodland_soldier2_a::precache();
	character\character_sp_sas_woodland_soldier2_b::precache();
	character\character_sp_sas_woodland_soldier2_c::precache();
	character\character_sp_sas_woodland_soldier2_d::precache();
	character\character_sp_sas_woodland_soldier2_e::precache();
	character\character_sp_sas_woodland_soldier2_f::precache();
	character\character_sp_sas_woodland_afro_01::precache();
	character\character_sp_sas_woodland_afro_02::precache();
	precacheitem("m4_grunt");
	precacheitem("beretta");
}