/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_marine_ar_m4grunt.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:57:15 AM
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
			character\character_sp_usmc_james::main();
			break;

		case 1:
			character\character_sp_usmc_sami::main();
			break;

		case 2:
			character\character_sp_usmc_at4::main();
			break;

		case 3:
			character\character_sp_usmc_ryan::main();
			break;

		case 4:
			character\character_sp_usmc_sami_goggles::main();
			break;

		case 5:
			character\character_sp_usmc_zach::main();
			break;

		case 6:
			character\character_sp_usmc_zach_goggles::main();
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