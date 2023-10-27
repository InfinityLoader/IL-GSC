/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_juggernaut_explosive.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 62 ms
 * Timestamp: 10/27/2023 2:17:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_3AA1 = "";
	self.var_3AA2 = "juggernaut.csv";
	self.team = "axis";
	self.type = "human";
	self.subclass = "juggernaut";
	self.accuracy = 0.2;
	self.health = 3600;
	self.secondaryweapon = "fnfiveseven";
	self.sidearm = "fnfiveseven";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(0,0);
		self setengagementmaxdist(256,1024);
	}

	self.weapon = "pecheneg";
	lib_05C9::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	lib_05C9::precache();
	precacheitem("pecheneg");
	precacheitem("fnfiveseven");
	precacheitem("fnfiveseven");
	precacheitem("fraggrenade");
	maps\_juggernaut::main();
}