/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_african_male.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 64 ms
 * Timestamp: 4/22/2024 1:57:29 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "civilian";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 100;
	self.grenadeweapon = "";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	switch(codescripts\character::get_random_character(4))
	{
		case 0:
			character\character_civ_afr_dark_male_casual::main();
			break;

		case 1:
			character\character_civ_afr_dark_male_dress::main();
			break;

		case 2:
			character\character_civ_afr_light_male_casual::main();
			break;

		case 3:
			character\character_civ_mde_male_casual::main();
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("neutral");
}

//Function Number: 3
precache()
{
	character\character_civ_afr_dark_male_casual::precache();
	character\character_civ_afr_dark_male_dress::precache();
	character\character_civ_afr_light_male_casual::precache();
	character\character_civ_mde_male_casual::precache();
}