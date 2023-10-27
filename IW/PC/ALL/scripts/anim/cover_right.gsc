/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\cover_right.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 279 ms
 * Timestamp: 10/27/2023 12:00:26 AM
*******************************************************************/

//Function Number: 1
func_950A()
{
}

//Function Number: 2
main()
{
	self.var_1F66 = [];
	self.var_1F66["hiding"]["stand"] = ::func_F2C0;
	self.var_1F66["hiding"]["crouch"] = ::func_F2B8;
	self endon("killanimscript");
	scripts\anim\utility::func_9832("cover_right");
	scripts\anim\corner::func_4661("right",-90);
}

//Function Number: 3
func_010B()
{
	scripts\anim\corner::func_62F3();
	scripts\anim\cover_behavior::func_10B("right");
}

//Function Number: 4
func_F2C0()
{
	self.var_8EDF = -90;
	self.var_1491.var_2274 = scripts\anim\utility::func_B028("cover_right_stand");
	if(isdefined(level.var_DC5B))
	{
		self.var_1491.var_2274["rambo90"] = level.var_DC5B.var_4744;
		self.var_1491.var_2274["rambo45"] = level.var_DC5B.var_4743;
		self.var_1491.var_2274["grenade_rambo"] = level.var_DC5B.var_4745;
	}
}

//Function Number: 5
func_F2B8()
{
	self.var_8EDF = -90;
	self.var_1491.var_2274 = scripts\anim\utility::func_B028("cover_right_crouch");
}