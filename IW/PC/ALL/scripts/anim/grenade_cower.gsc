/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\grenade_cower.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 189 ms
 * Timestamp: 10/27/2023 12:00:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		lib_0A1A::func_232F("grenade response","avoid");
		self endon("killanimscript");
		self endon("death");
		self waittill("killanimscript");
	}

	self endon("killanimscript");
	scripts\anim\utility::func_9832("grenadecower");
	if(isdefined(self.var_85B6))
	{
		self [[ self.var_85B6 ]]();
		return;
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		scripts\anim\stop::main();
		return;
	}

	self method_8016("zonly_physics");
	self method_8221("face angle",self.angles[1]);
	var_00 = 0;
	if(isdefined(self.var_15F))
	{
		var_00 = angleclamp180(vectortoangles(self.var_15F.origin - self.origin)[1] - self.angles[1]);
	}
	else
	{
		var_00 = self.angles[1];
	}

	if(self.var_1491.var_D6A5 == "stand")
	{
		if(isdefined(self.var_15F) && func_12895(var_00))
		{
			return;
		}

		self method_82E4("cowerstart",scripts\anim\utility::func_B027("grenade","cower_squat"),%body,1,0.2);
		scripts\anim\shared::func_592B("cowerstart");
	}

	self.var_1491.var_D6A5 = "crouch";
	self.var_1491.var_BCC8 = "stop";
	self method_82E4("cower",scripts\anim\utility::func_B027("grenade","cower_squat_idle"),%body,1,0.2);
	scripts\anim\shared::func_592B("cower");
	self waittill("never");
}

//Function Number: 2
func_010B()
{
	self.var_272 = 1;
}

//Function Number: 3
func_12895(param_00)
{
	if(randomint(2) == 0)
	{
		return 0;
	}

	if(self.var_2C0 != "none")
	{
		return 0;
	}

	var_01 = undefined;
	if(abs(param_00) > 90)
	{
		var_01 = scripts\anim\utility::func_B027("grenade","cower_dive_back");
	}
	else
	{
		var_01 = scripts\anim\utility::func_B027("grenade","cower_dive_front");
	}

	var_02 = getmovedelta(var_01,0,0.5);
	var_03 = self method_81E7(var_02);
	if(!self method_8200(var_03))
	{
		return 0;
	}

	self.var_272 = 0;
	self method_82E4("cowerstart",var_01,%body,1,0.2);
	scripts\anim\shared::func_592B("cowerstart");
	self.var_272 = 1;
	return 1;
}