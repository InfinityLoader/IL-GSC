/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_hero_cormack_sentinel_arctic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 1:57:05 AM
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

	switch(codescripts\character::get_random_weapon(5))
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
			self.weapon = "iw5_bal27_sp_variablereddot";
			break;

		case 4:
			self.weapon = "iw5_bal27_sp_opticstargetenhancer";
			break;
	}

	character\character_hero_cormack_sentinel_arctic::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_hero_cormack_sentinel_arctic::precache();
	precacheitem("iw5_bal27_sp");
	precacheitem("iw5_bal27_sp_opticsacog2");
	precacheitem("iw5_bal27_sp_opticsreddot");
	precacheitem("iw5_bal27_sp_variablereddot");
	precacheitem("iw5_bal27_sp_opticstargetenhancer");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}