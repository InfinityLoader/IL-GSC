/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_dog.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 2:17:03 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.var_3AA1 = "dog.atr";
	self.var_3AA2 = "common_dogs.csv";
	self.team = "axis";
	self.type = "dog";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 200;
	self.secondaryweapon = "dog_bite";
	self.sidearm = "";
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "dog_bite";
	lib_060E::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	lib_060E::precache();
	precacheitem("dog_bite");
	precacheitem("dog_bite");
	precacheitem("fraggrenade");
	animscripts/dog/dog_init::func_3AF2();
}