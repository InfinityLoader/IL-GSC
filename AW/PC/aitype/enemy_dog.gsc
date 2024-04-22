/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_dog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 58 ms
 * Timestamp: 4/22/2024 1:58:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "dog.atr";
	self.additionalassets = "common_dogs.csv";
	self.team = "axis";
	self.type = "dog";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 200;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "dog_bite";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "dog_bite";
	character\character_sp_doberman_dog::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("axis");
}

//Function Number: 3
precache()
{
	character\character_sp_doberman_dog::precache();
	precacheitem("dog_bite");
	precacheitem("dog_bite");
	precacheitem("fraggrenade");
	animscripts\dog\dog_init::initdoganimations();
}