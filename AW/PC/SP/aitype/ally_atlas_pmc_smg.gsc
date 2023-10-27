/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_atlas_pmc_smg.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:52:37 AM
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
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		case 9:
			break;

		case 10:
			break;

		case 11:
			break;

		case 12:
			break;

		case 13:
			break;

		case 14:
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
	character\character_pmc_smg::precache();
	character\character_pmc_smg_asi::precache();
	precacheitem("iw5_sn6_sp");
	precacheitem("iw5_sn6_sp_opticsacog2");
	precacheitem("iw5_sn6_sp_opticsreddot");
	precacheitem("iw5_sn6_sp_variablereddot");
	precacheitem("iw5_sn6_sp_opticstargetenhancer");
	precacheitem("iw5_asm1_sp");
	precacheitem("iw5_asm1_sp_opticsacog2");
	precacheitem("iw5_asm1_sp_opticsreddot");
	precacheitem("iw5_asm1_sp_variablereddot");
	precacheitem("iw5_asm1_sp_opticstargetenhancer");
	precacheitem("iw5_hmr9_sp");
	precacheitem("iw5_hmr9_sp_opticsacog2");
	precacheitem("iw5_hmr9_sp_opticsreddot");
	precacheitem("iw5_hmr9_sp_variablereddot");
	precacheitem("iw5_hmr9_sp_opticstargetenhancer");
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}