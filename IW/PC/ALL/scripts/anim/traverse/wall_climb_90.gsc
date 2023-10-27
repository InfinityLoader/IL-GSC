/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\wall_climb_90.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 219 ms
 * Timestamp: 10/26/2023 11:59:44 PM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvarint("ai_iw7",0) == 0)
	{
		self.var_126E1 = 1;
		func_18D0(%traverse90,90);
		return;
	}

	self waittill("killanimscript");
}

//Function Number: 2
func_18D0(param_00,param_01)
{
	self.var_5270 = "crouch";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	var_02 = self method_8148();
	self method_8221("face angle",var_02.angles[1]);
	var_03 = var_02.var_126D4 - var_02.origin[2];
	thread scripts\anim\traverse\shared::func_11661(var_03 - param_01);
	self method_82E4("traverse",param_00,%body,1,0.15,1);
	var_04 = gettime();
	thread scripts\anim\notetracks::func_592D("traverse","no clear",::func_88CE);
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_04 = 1.23;
		var_05 = 0.2;
		wait(5.9);
		self method_83C4("gravity");
		wait(var_05);
		return;
	}

	self waittillmatch("gravity on","traverse");
	self method_83C4("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait(0.2);
		return;
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 3
func_88CE(param_00)
{
	if(param_00 != "traverse_death")
	{
		return;
	}

	self endon("killanimscript");
	if(self.health == 1)
	{
		self.var_1491.var_C043 = 1;
		if(self.var_126E1 > 1)
		{
			self method_82E3("deathanim",%traverse90_end_death,%body,1,0.2,1);
		}
		else
		{
			self method_82E3("deathanim",%traverse90_start_death,%body,1,0.2,1);
		}

		scripts\anim\face::func_EB83("death");
	}

	self.var_126E1++;
}