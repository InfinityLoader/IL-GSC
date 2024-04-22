/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_kva_sniper.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 4/22/2024 1:58:23 AM
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
	self.sidearm = "iw5_vbr_sp";
	if(isai(self))
	{
		self setengagementmindist(1250,1024);
		self setengagementmaxdist(1600,2400);
	}

	switch(codescripts\character::get_random_weapon(5))
	{
		case 0:
			self.weapon = "iw5_m990_sp_m990scope";
			break;

		case 1:
			self.weapon = "iw5_m990_sp_m990scopevz";
			break;

		case 2:
			self.weapon = "iw5_m990_sp_m990stabilizer";
			break;

		case 3:
			self.weapon = "iw5_m990_sp_opticsacog2";
			break;

		case 4:
			self.weapon = "iw5_m990_sp_opticsthermal";
			break;
	}

	character\character_kva_ar::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_kva_ar::precache();
	precacheitem("iw5_m990_sp_m990scope");
	precacheitem("iw5_m990_sp_m990scopevz");
	precacheitem("iw5_m990_sp_m990stabilizer");
	precacheitem("iw5_m990_sp_opticsacog2");
	precacheitem("iw5_m990_sp_opticsthermal");
	precacheitem("iw5_vbr_sp");
	precacheitem("fraggrenade");
	maps\_sniper_glint::main();
}