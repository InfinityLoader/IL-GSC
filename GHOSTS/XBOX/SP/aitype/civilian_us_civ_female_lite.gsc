/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: aitype\civilian_us_civ_female_lite.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 1:34:20 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	self.animtree = "";
	self.additionalassets = "";
	self.team = "neutral";
	self.type = "human";
	self.var_7D25 = "regular";
	self.accuracy = 0.2;
	self.health = 30;
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
	switch(codescripts\character::func_3970(2))
	{
		case 0:
			character\character_us_civ_female_yb_a::func_4FDD();
			break;

		case 1:
			character\character_us_civ_female_yb_b::func_4FDD();
			break;
	}
}

//Function Number: 2
spawner()
{
	self method_830F("neutral");
}

//Function Number: 3
func_6101()
{
	character\character_us_civ_female_yb_a::func_6101();
	character\character_us_civ_female_yb_b::func_6101();
}