/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_urban_female_s1.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 64 ms
 * Timestamp: 4/22/2024 1:57:52 AM
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
	switch(codescripts\character::get_random_character(7))
	{
		case 0:
			character\character_civ_s1_female_a::main();
			break;

		case 1:
			character\character_civ_s1_female_b::main();
			break;

		case 2:
			character\character_civ_s1_female_c::main();
			break;

		case 3:
			character\character_civ_s1_female_d::main();
			break;

		case 4:
			character\character_civ_s1_female_e::main();
			break;

		case 5:
			character\character_civ_s1_female_f::main();
			break;

		case 6:
			character\character_civ_s1_female_g::main();
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
	character\character_civ_s1_female_a::precache();
	character\character_civ_s1_female_b::precache();
	character\character_civ_s1_female_c::precache();
	character\character_civ_s1_female_d::precache();
	character\character_civ_s1_female_e::precache();
	character\character_civ_s1_female_f::precache();
	character\character_civ_s1_female_g::precache();
}