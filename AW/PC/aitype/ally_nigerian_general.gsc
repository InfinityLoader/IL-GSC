/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: ally_nigerian_general.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 1:57:16 AM
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

	switch(codescripts\character::get_random_weapon(2))
	{
		case 0:
			self.weapon = "iw5_ak12_sp";
			break;

		case 1:
			self.weapon = "iw5_ak12_sp_opticsacog2";
			break;
	}

	character\character_nigerian_general::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("allies");
}

//Function Number: 3
precache()
{
	character\character_nigerian_general::precache();
	precacheitem("iw5_ak12_sp");
	precacheitem("iw5_ak12_sp_opticsacog2");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}