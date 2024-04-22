/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_kva_hazmat_nohat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 1:58:19 AM
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
	self.health = 250;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45_sp";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	character\character_kva_hazmat_nohat::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_kva_hazmat_nohat::precache();
	precacheitem("iw5_titan45_sp");
	precacheitem("fraggrenade");
}