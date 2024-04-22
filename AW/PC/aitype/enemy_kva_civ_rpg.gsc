/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_kva_civ_rpg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 200;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "iw5_ak12_sp";
	self.sidearm = "iw5_vbr_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "iw5_mahem_sp";
	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\character_kva_civ_a::main();
			break;

		case 1:
			character\character_kva_civ_b::main();
			break;

		case 2:
			character\character_kva_civ_c::main();
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_kva_civ_a::precache();
	character\character_kva_civ_b::precache();
	character\character_kva_civ_c::precache();
	precacheitem("iw5_mahem_sp");
	precacheitem("iw5_ak12_sp");
	precacheitem("iw5_vbr_sp");
	precacheitem("fraggrenade");
}