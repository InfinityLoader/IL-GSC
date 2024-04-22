/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_prisoner_male.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 65 ms
 * Timestamp: 4/22/2024 1:57:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "team3";
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
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\character_civ_pris_afr_dark_male_lite::main();
			break;

		case 1:
			character\character_civ_pris_mde_male_lite::main();
			break;

		case 2:
			character\character_civ_pris_cau_male_lite::main();
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("team3");
}

//Function Number: 3
precache()
{
	character\character_civ_pris_afr_dark_male_lite::precache();
	character\character_civ_pris_mde_male_lite::precache();
	character\character_civ_pris_cau_male_lite::precache();
}