/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_atlas_elite_smg_captured.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 52 ms
 * Timestamp: 4/22/2024 1:58:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "elite";
	self.accuracy = 0.2;
	self.health = 1000;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45pickup_sp_xmags";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(codescripts\character::get_random_weapon(2))
	{
		case 0:
			self.weapon = "iw5_sn6pickup_sp_xmags";
			break;

		case 1:
			self.weapon = "iw5_hmr9pickup_sp_xmags";
			break;
	}

	character\character_atlas_elete::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_atlas_elete::precache();
	precacheitem("iw5_sn6pickup_sp_xmags");
	precacheitem("iw5_hmr9pickup_sp_xmags");
	precacheitem("iw5_titan45pickup_sp_xmags");
	precacheitem("fraggrenade");
}