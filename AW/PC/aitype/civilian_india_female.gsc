/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: civilian_india_female.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 1:57:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "civilian";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 30;
	self.grenadeweapon = "";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "none";
	switch(codescripts\character::get_random_character(2))
	{
		case 0:
			character\character_civilian_india_female_a::main();
			break;

		case 1:
			character\character_civilian_india_female_b::main();
			break;
	}
}

//Function Number: 2
spawner()
{
	self setspawnerteam("neutral");
}

//Function Number: 3
precache()
{
	character\character_civilian_india_female_a::precache();
	character\character_civilian_india_female_b::precache();
}