/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\enemy_fed_space_smg.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 1:34:21 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "axis";
	self.type = "human";
	self.var_7D25 = "regular";
	self.accuracy = 0.2;
	self.health = 50;
	self.grenadeweapon = "fraggrenade";
	self.grenadeammo = 0;
	self.secondaryweapon = "";
	self.var_7544 = "";
	if(isai(self))
	{
		self method_823B(256,0);
		self method_823C(768,1024);
	}

	self.weapon = "microtar_space_interior+acogsmg_sp+spaceshroud_sp";
	character\character_fed_space_assault_a::func_4FDD();
}

//Function Number: 2
spawner()
{
	self method_830F("axis");
}

//Function Number: 3
func_6101()
{
	character\character_fed_space_assault_a::func_6101();
	precacheitem("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
	precacheitem("fraggrenade");
}