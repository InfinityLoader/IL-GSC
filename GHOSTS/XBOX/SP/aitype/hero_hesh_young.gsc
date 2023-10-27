/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\hero_hesh_young.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 66 ms
 * Timestamp: 10/27/2023 1:34:22 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "allies";
	self.type = "human";
	self.var_7D25 = "regular";
	self.accuracy = 0.2;
	self.health = 100;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.var_7544 = "m9a1";
	if(isai(self))
	{
		self method_823B(256,0);
		self method_823C(768,1024);
	}

	self.weapon = "none";
	character\character_hesh_young_a::func_4FDD();
}

//Function Number: 2
spawner()
{
	self method_830F("allies");
}

//Function Number: 3
func_6101()
{
	character\character_hesh_young_a::func_6101();
	precacheitem("m9a1");
	precacheitem("fraggrenade");
}