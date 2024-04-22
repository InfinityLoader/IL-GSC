/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_urban_male_s1_ie.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 4/22/2024 1:57:56 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "human";
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
			character\character_civ_s1_male_b::main();
			break;

		case 1:
			character\character_civ_s1_male_c::main();
			break;

		case 2:
			character\character_civ_s1_male_d::main();
			break;

		case 3:
			character\character_civ_s1_male_e::main();
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
	character\character_civ_s1_male_b::precache();
	character\character_civ_s1_male_c::precache();
	character\character_civ_s1_male_d::precache();
	character\character_civ_s1_male_e::precache();
}