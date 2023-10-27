/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\ally_so_delta.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 2:17:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_3AA1 = "";
	self.var_3AA2 = "";
	self.team = "allies";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 100;
	self.secondaryweapon = "";
	self.sidearm = "";
	self.grenadeweapon = "";
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
			lib_060B::main();
			break;

		case 1:
			lib_060C::main();
			break;

		case 2:
			lib_060D::main();
			break;

		case 3:
			lib_06B9::main();
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
	lib_060B::precache();
	lib_060C::precache();
	lib_060D::precache();
	lib_06B9::precache();
}