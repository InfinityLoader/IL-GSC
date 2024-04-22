/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_slum_male.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 54 ms
 * Timestamp: 4/22/2024 1:57:51 AM
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
	self.health = 30;
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
	switch(codescripts\character::get_random_character(8))
	{
		case 0:
			character\character_civilian_slum_male_aa::main();
			break;

		case 1:
			character\character_civilian_slum_male_aa_wht::main();
			break;

		case 2:
			character\character_civilian_slum_male_ab::main();
			break;

		case 3:
			character\character_civilian_slum_male_ab_wht::main();
			break;

		case 4:
			character\character_civilian_slum_male_ba::main();
			break;

		case 5:
			character\character_civilian_slum_male_ba_wht::main();
			break;

		case 6:
			character\character_civilian_slum_male_bb::main();
			break;

		case 7:
			character\character_civilian_slum_male_bb_wht::main();
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
	character\character_civilian_slum_male_aa::precache();
	character\character_civilian_slum_male_aa_wht::precache();
	character\character_civilian_slum_male_ab::precache();
	character\character_civilian_slum_male_ab_wht::precache();
	character\character_civilian_slum_male_ba::precache();
	character\character_civilian_slum_male_ba_wht::precache();
	character\character_civilian_slum_male_bb::precache();
	character\character_civilian_slum_male_bb_wht::precache();
}