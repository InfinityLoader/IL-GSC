/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_marine_ar_m4grunt.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 1:52:42 AM
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
	self.secondaryweapon = "colt45";
	self.sidearm = "colt45";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "m4_grunt";
	switch(codescripts\character::get_random_character(7))
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
	character\character_sp_usmc_james::precache();
	character\character_sp_usmc_sami::precache();
	character\character_sp_usmc_at4::precache();
	character\character_sp_usmc_ryan::precache();
	character\character_sp_usmc_sami_goggles::precache();
	character\character_sp_usmc_zach::precache();
	character\character_sp_usmc_zach_goggles::precache();
	precacheitem("m4_grunt");
	precacheitem("colt45");
	precacheitem("colt45");
	precacheitem("fraggrenade");
}