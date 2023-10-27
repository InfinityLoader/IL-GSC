/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_docks_gasmask_smg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 2:17:03 AM
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
	self.sidearm = "fnfiveseven";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	switch(lib_0144::func_1E68(6))
	{
		case 0:
			self.weapon = "p90";
			break;

		case 1:
			self.weapon = "p90_eotech";
			break;

		case 2:
			self.weapon = "p90_reflex";
			break;

		case 3:
			self.weapon = "pp90m1";
			break;

		case 4:
			self.weapon = "pp90m1_eotech";
			break;

		case 5:
			self.weapon = "pp90m1_reflex";
			break;
	}

	switch(lib_0144::func_1E63(10))
	{
		case 0:
			lib_05CC::main();
			break;

		case 1:
			lib_05CD::main();
			break;

		case 2:
			lib_05CE::main();
			break;

		case 3:
			lib_05CF::main();
			break;

		case 4:
			lib_05D0::main();
			break;

		case 5:
			lib_05D1::main();
			break;

		case 6:
			lib_05D2::main();
			break;

		case 7:
			lib_05D3::main();
			break;

		case 8:
			lib_05D4::main();
			break;

		case 9:
			lib_05D5::main();
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
	lib_05CD::precache();
	lib_05CE::precache();
	lib_05CF::precache();
	lib_05D0::precache();
	lib_05D1::precache();
	lib_05D2::precache();
	lib_05D3::precache();
	lib_05D4::precache();
	lib_05D5::precache();
	precacheitem("p90");
	precacheitem("p90_eotech");
	precacheitem("p90_reflex");
	precacheitem("pp90m1");
	precacheitem("pp90m1_eotech");
	precacheitem("pp90m1_reflex");
	precacheitem("fnfiveseven");
	precacheitem("fraggrenade");
}