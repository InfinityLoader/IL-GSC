/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: enemy_captured_doctor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 4/22/2024 1:58:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "human";
	self.subclass = "regular";
	self.accuracy = 0.2;
	self.health = 150;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.sidearm = "iw5_titan45pickup_sp_xmags";
	if(isai(self))
	{
		self setengagementmindist(256,0);
		self setengagementmaxdist(768,1024);
	}

	self.weapon = "iw5_sn6pickup_sp_xmags";
	character\character_doctor_cpt::main();
}

//Function Number: 2
spawner()
{
	self setspawnerteam("neutral");
}

//Function Number: 3
precache()
{
	character\character_doctor_cpt::precache();
	precacheitem("iw5_sn6pickup_sp_xmags");
	precacheitem("iw5_titan45pickup_sp_xmags");
	precacheitem("fraggrenade");
}