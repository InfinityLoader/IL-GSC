/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\hero_elias_basic_yb.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 59 ms
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
	self.grenadeweapon = "";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.var_7544 = "";
	if(isai(self))
	{
		self method_823B(256,0);
		self method_823C(768,1024);
	}

	self.weapon = "none";
	character\character_elias_e::func_4FDD();
}

//Function Number: 2
spawner()
{
	self method_830F("allies");
}

//Function Number: 3
func_6101()
{
	character\character_elias_e::func_6101();
}