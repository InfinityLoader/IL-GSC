/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_so_chemical.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 2:17:06 AM
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
	switch(lib_0144::func_1E63(4))
	{
		case 0:
			lib_05CC::main();
			break;

		case 1:
			lib_05D1::main();
			break;

		case 2:
			lib_05DA::main();
			break;

		case 3:
			lib_05DB::main();
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
	lib_05CC::precache();
	lib_05D1::precache();
	lib_05DA::precache();
	lib_05DB::precache();
	precacheitem("fraggrenade");
}