/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_atlas_sniper.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "sniper_glint.csv";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 200;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(768,700);
		self setengagementmaxdist(1450,2100);
	}

	switch(codescripts\character::get_random_weapon(3))
	{
		case 0:
			self.weapon = "iw5_thor_sp_thorscope";
			break;

		case 1:
			self.weapon = "iw5_thor_sp_thorscopevz";
			break;

		case 2:
			self.weapon = "iw5_thor_sp_thorstabilizer";
			break;
	}

	character\character_atlas_smg::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_atlas_smg::precache();
	precacheitem("iw5_thor_sp_thorscope");
	precacheitem("iw5_thor_sp_thorscopevz");
	precacheitem("iw5_thor_sp_thorstabilizer");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
	maps\_sniper_glint::main();
}