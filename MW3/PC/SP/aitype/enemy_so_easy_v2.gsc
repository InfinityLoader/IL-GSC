/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_so_easy_v2.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 2:17:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_3AA1 = "";
	self.var_3AA2 = "";
	self.team = "axis";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 150;
	self.secondaryweapon = "";
	self.sidearm = "";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	lib_05D8::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	lib_05D8::precache();
	precacheitem("fraggrenade");
}