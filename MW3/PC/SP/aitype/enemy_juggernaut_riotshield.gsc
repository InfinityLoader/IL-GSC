/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_juggernaut_riotshield.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 62 ms
 * Timestamp: 10/27/2023 2:17:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_3AA1 = "";
	self.var_3AA2 = "juggernaut_riotshield.csv";
	self.team = "axis";
	self.type = "human";
	self.subclass = "riotshield";
	self.accuracy = 0.2;
	self.health = 3600;
	self.secondaryweapon = "iw5_riotshield_so";
	self.sidearm = "fnfiveseven";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(0,0);
		self setengagementmaxdist(256,1024);
	}

	self.weapon = "pecheneg";
	lib_05C7::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	lib_05C7::precache();
	precacheitem("pecheneg");
	precacheitem("iw5_riotshield_so");
	precacheitem("fnfiveseven");
	precacheitem("fraggrenade");
	maps\_riotshield::init_riotshield();
	maps\_juggernaut::main();
}