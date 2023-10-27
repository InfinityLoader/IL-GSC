/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_so_easy.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
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
	switch(lib_0144::func_1E63(3))
	{
		case 0:
			lib_05BD::main();
			break;

		case 1:
			lib_05BE::main();
			break;

		case 2:
			lib_05BF::main();
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
	lib_05BD::precache();
	lib_05BE::precache();
	lib_05BF::precache();
	precacheitem("fraggrenade");
}