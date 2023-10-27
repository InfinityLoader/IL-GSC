/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_dprk_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 1:52:52 AM
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
	self.secondaryweapon = "";
	self.sidearm = "iw5_vbr_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(5))
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
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
	character\character_dprk_smg::precache();
	precacheitem("iw5_kf5_sp");
	precacheitem("iw5_kf5_sp_opticsacog2");
	precacheitem("iw5_kf5_sp_opticsreddot");
	precacheitem("iw5_kf5_sp_opticstargetenhancer");
	precacheitem("iw5_kf5_sp_variablereddot");
	precacheitem("iw5_vbr_sp");
	precacheitem("fraggrenade");
}