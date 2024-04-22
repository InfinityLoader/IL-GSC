/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_sentinel_shotgun.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 45 ms
 * Timestamp: 4/22/2024 1:57:20 AM
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

	switch(codescripts\character::get_random_weapon(3))
	{
		case 0:
			self.weapon = "iw5_rhino_sp";
			break;

		case 1:
			self.weapon = "iw5_rhino_sp_opticsreddot";
			break;

		case 2:
			self.weapon = "iw5_rhino_sp_opticstargetenhancer";
			break;
	}

	character\character_sentinel::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_sentinel::precache();
	precacheitem("iw5_rhino_sp");
	precacheitem("iw5_rhino_sp_opticsreddot");
	precacheitem("iw5_rhino_sp_opticstargetenhancer");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}