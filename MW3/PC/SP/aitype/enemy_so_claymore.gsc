/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_so_claymore.gsc
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
	self.var_3AA2 = "common_rambo_anims.csv";
	self.team = "axis";
	self.type = "human";
	self.subclass = "militia";
	self.accuracy = 0.2;
	self.health = 150;
	self.secondaryweapon = "";
	self.sidearm = "";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(0,0);
		self setengagementmaxdist(350,600);
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
	maps\_rambo::main();
}