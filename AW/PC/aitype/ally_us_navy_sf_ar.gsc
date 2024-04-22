/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_us_navy_sf_ar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 87 ms
 * Timestamp: 4/22/2024 1:57:28 AM
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
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(15))
	{
		case 0:
			self.weapon = "iw5_bal27_sp";
			break;

		case 1:
			self.weapon = "iw5_bal27_sp_opticsacog2";
			break;

		case 2:
			self.weapon = "iw5_bal27_sp_opticsreddot";
			break;

		case 3:
			self.weapon = "iw5_bal27_sp_opticsthermal";
			break;

		case 4:
			self.weapon = "iw5_bal27_sp_variablereddot";
			break;

		case 5:
			self.weapon = "iw5_bal27_sp_opticstargetenhancer";
			break;

		case 6:
			self.weapon = "iw5_ak12_sp";
			break;

		case 7:
			self.weapon = "iw5_ak12_sp_opticsacog2";
			break;

		case 8:
			self.weapon = "iw5_ak12_sp_opticsreddot";
			break;

		case 9:
			self.weapon = "iw5_ak12_sp_opticsthermal";
			break;

		case 10:
			self.weapon = "iw5_ak12_sp_opticstargetenhancer";
			break;

		case 11:
			self.weapon = "iw5_lsat_sp";
			break;

		case 12:
			self.weapon = "iw5_lsat_sp_opticsacog2";
			break;

		case 13:
			self.weapon = "iw5_hbra3_sp";
			break;

		case 14:
			self.weapon = "iw5_hbra3_sp_opticsacog2";
			break;
	}

	switch(codescripts\character::get_random_character(3))
	{
		case 0:
			character\character_navy_sf_assault_a::main();
			break;

		case 1:
			character\character_navy_sf_assault_b::main();
			break;

		case 2:
			character\character_navy_sf_assault_c::main();
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
	character\character_navy_sf_assault_a::precache();
	character\character_navy_sf_assault_b::precache();
	character\character_navy_sf_assault_c::precache();
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_opticsacog2");
	precacheitem("iw5_bal27_sp_opticsreddot");
	precacheitem("iw5_bal27_sp_opticsthermal");
	precacheitem("iw5_bal27_sp_variablereddot");
	precacheitem("iw5_bal27_sp_opticstargetenhancer");
	precacheitem("iw5_ak12_sp");
	precacheitem("iw5_ak12_sp_opticsacog2");
	precacheitem("iw5_ak12_sp_opticsreddot");
	precacheitem("iw5_ak12_sp_opticsthermal");
	precacheitem("iw5_ak12_sp_opticstargetenhancer");
	precacheitem("iw5_lsat_sp");
	precacheitem("iw5_lsat_sp_opticsacog2");
	precacheitem("iw5_hbra3_sp");
	precacheitem("iw5_hbra3_sp_opticsacog2");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}