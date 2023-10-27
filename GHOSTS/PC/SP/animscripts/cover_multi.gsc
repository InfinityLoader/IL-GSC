/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_multi.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 295 ms
 * Timestamp: 10/27/2023 1:23:47 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(!isdefined(self.cover))
	{
		self.cover = spawnstruct();
	}

	self.cover.state = "none";
	self.cover.var_4CBE = 0;
	self.cover.var_4980 = 0;
	self.cover.var_420D = covermulti_choosehidestate();
	self.cover.fnoverlord = ::covermulti_think;
	self.var_1FCA = self.node;
	covermulti_think();
}

//Function Number: 2
end_script()
{
	covermulti_exitstate(self.cover.state);
	self.cover.fnoverlord = undefined;
	self.cover.var_4CBE = undefined;
	self.cover.var_4980 = undefined;
	animscripts/corner::end_script_corner();
	animscripts/cover_behavior::end_script("multi");
}

//Function Number: 3
covermulti_think()
{
	if(!isdefined(self.var_1FCA))
	{
	}

	var_00 = self.var_1FCA getvalidcoverpeekouts();
	if(isdefined(self.cover.arrivalnodetype))
	{
		if(covermulti_isvaliddir(self.cover.arrivalnodetype,var_00))
		{
			var_01 = func_1FC6(self.cover.arrivalnodetype);
			self.cover.arrivalnodetype = undefined;
		}
	}

	if(!isdefined(self.enemy))
	{
		func_1FC6(covermulti_getrandomvaliddir(var_01));
	}

	var_02 = self.var_1FCA.origin;
	var_03 = self.enemy.origin;
	var_04 = var_03 - var_02;
	var_05 = vectortoangles(var_04);
	var_06 = angleclamp180(var_05[1] - self.var_1FCA.angles[1]);
	var_07 = undefined;
	if(var_06 > 12)
	{
		var_08 = ["left","over","right"];
	}
	else if(var_07 < -12)
	{
		var_08 = ["right","over","left"];
	}
	else if(var_07 > 5)
	{
		var_08 = [["left","over"],"right"];
		var_07 = 15000;
	}
	else if(var_07 < -5)
	{
		var_08 = [["right","over"],"left"];
		var_07 = 15000;
	}
	else
	{
		var_08 = ["over",["right","left"]];
		var_07 = 15000;
	}

	var_09 = func_1FC1(var_08,var_01);
	var_01 = func_1FC6(var_09,var_07);
}

//Function Number: 4
covermulti_isvaliddir(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.node getvalidcoverpeekouts();
	}

	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_01[var_02] == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
func_1FC1(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.node getvalidcoverpeekouts();
	}

	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		if(!isarray(var_04))
		{
			var_02[var_02.size] = var_04;
			continue;
		}

		var_04 = common_scripts\utility::array_randomize(var_04);
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			var_02[var_02.size] = var_04[var_05];
		}
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(covermulti_isvaliddir(var_02[var_03],param_01))
		{
			return var_02[var_03];
		}
	}
}

//Function Number: 6
covermulti_getrandomvaliddir(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self.node getvalidcoverpeekouts();
	}

	var_01 = randomint(param_00.size);
	return param_00[var_01];
}

//Function Number: 7
covermulti_getnonrandomvaliddir(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self getvalidcoverpeekouts();
	}

	if(param_00[0] == "over")
	{
		if(self doesnodeallowstance("stand"))
		{
			return "stand";
		}
		else
		{
			return "crouch";
		}
	}

	return param_00[0];
}

//Function Number: 8
func_1FC6(param_00,param_01)
{
	if(param_00 == "over")
	{
		var_02 = self.node doesnodeallowstance("stand");
		var_03 = self.node doesnodeallowstance("crouch");
		if(var_02)
		{
			if(self.cover.state != "crouch" || !var_03)
			{
				covermulti_setstate("stand",param_01);
			}

			return 1;
		}
		else if(var_03)
		{
			if(self.cover.state != "stand" || !var_02)
			{
				covermulti_setstate("crouch",param_01);
			}

			return 1;
		}
		else
		{
		}
	}
	else
	{
		covermulti_setstate(var_02,var_03);
		return 1;
	}

	return 0;
}

//Function Number: 9
covermulti_setstate(param_00,param_01)
{
	if(self.cover.state == param_00)
	{
		return 0;
	}

	if(!isdefined(param_01) || param_01 < 0)
	{
		param_01 = 5000;
	}

	var_02 = gettime();
	if(self.cover.var_4CBE > 0 && var_02 - self.cover.var_4CBE < param_01)
	{
		return 0;
	}

	self.cover.var_4CBE = var_02;
	thread func_1FC8(param_00);
	return 1;
}

//Function Number: 10
func_1FC8(param_00)
{
	self notify("killanimscript");
	var_01 = covermulti_choosehidestate();
	covermulti_dotransition(self.cover.state,self.a.var_60B1,self.cover.var_420D,param_00,self.a.var_60B1,var_01);
	covermulti_exitstate(self.cover.state);
	self.cover.state = param_00;
	self.cover.var_420D = var_01;
	covermulti_enterstate(self.cover.state);
}

//Function Number: 11
covermulti_enterstate(param_00)
{
	if(param_00 == "left")
	{
		animscripts/cover_left::func_4FDD();
	}

	if(param_00 == "right")
	{
		animscripts/cover_right::func_4FDD();
	}

	if(param_00 == "stand")
	{
		animscripts/cover_stand::func_4FDD();
	}

	if(param_00 == "crouch")
	{
		animscripts/cover_crouch::func_4FDD();
	}
}

//Function Number: 12
covermulti_exitstate(param_00)
{
	switch(param_00)
	{
		case "left":
			animscripts/cover_left::end_script();
			break;

		case "right":
			animscripts/cover_right::end_script();
			break;

		case "stand":
			animscripts/cover_stand::end_script();
			break;

		case "crouch":
			animscripts/cover_crouch::end_script();
			break;
	}
}

//Function Number: 13
covermulti_dotransition(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("killanimscript");
	if(param_00 == "none" || param_03 == "none")
	{
	}

	var_06 = covermulti_getanimtransition(param_00,param_01,param_02,param_03,param_04,param_05);
	if(!isdefined(var_06))
	{
	}

	self setflaggedanimknoball("cover_multi_trans",var_06,%body,1,0.2,1);
	animscripts/shared::func_2986("cover_multi_trans");
}

//Function Number: 14
covermulti_choosehidestate()
{
	if(!isdefined(self.a.var_ED8) || !isdefined(self.a.var_ED8["alert_idle_back"]))
	{
		return "forward";
	}

	if(common_scripts\utility::func_1DE9())
	{
		return "forward";
	}

	return "back";
}

//Function Number: 15
covermulti_getstatefromdir(param_00,param_01)
{
	if(param_01 == "left" || param_01 == "right")
	{
		return param_01;
	}

	if(param_00 doesnodeallowstance("stand"))
	{
		return "stand";
	}

	return "crouch";
}

//Function Number: 16
covermulti_getanimtransition(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_02 == "back")
	{
		var_06 = param_01 + "_back";
	}
	else if(param_01 == "stand" || param_01 == "crouch")
	{
		var_06 = param_01 + "_forward";
	}
	else
	{
		var_06 = param_01 + "_" + param_02;
	}

	var_06 = var_06 + "_to_";
	if(param_05 == "back")
	{
		var_06 = var_06 + param_04 + "_back";
	}
	else if(param_03 == "stand" || param_03 == "crouch")
	{
		var_06 = var_06 + param_03 + "_forward";
	}
	else
	{
		var_06 = var_06 + param_03 + "_" + param_04;
	}

	var_07 = self.var_DC4;
	if(!isdefined(var_07) || !isdefined(level.archetypes[var_07]["cover_multi"]))
	{
		var_07 = "soldier";
	}

	return level.archetypes[var_07]["cover_multi"][var_06];
}

//Function Number: 17
init_animset_cover_multi()
{
	var_00 = [];
	var_00["stand"] = [];
	var_00["stand"]["trans"] = [];
	var_00["stand"]["trans"]["left_stand"] = [];
	var_00["stand"]["trans"]["left_crouch"] = [];
	var_00["stand"]["trans"]["right_stand"] = [];
	var_00["stand"]["trans"]["right_crouch"] = [];
	var_00["stand"]["trans"]["front_stand"] = [];
	var_00["stand"]["trans"]["front_crouch"] = [];
	var_00["stand"]["trans"]["back_stand"] = [];
	var_00["stand"]["trans"]["back_crouch"] = [];
	var_00["left_stand_to_right_stand"] = undefined;
	var_00["left_stand_to_right_crouch"] = undefined;
	var_00["left_stand_to_stand_back"] = undefined;
	var_00["left_stand_to_stand_forward"] = undefined;
	var_00["left_stand_to_crouch_back"] = undefined;
	var_00["left_stand_to_crouch_forward"] = undefined;
	var_00["left_crouch_to_right_stand"] = undefined;
	var_00["left_crouch_to_right_crouch"] = undefined;
	var_00["left_crouch_to_stand_back"] = undefined;
	var_00["left_crouch_to_stand_forward"] = undefined;
	var_00["left_crouch_to_crouch_back"] = undefined;
	var_00["left_crouch_to_crouch_forward"] = undefined;
	var_00["crouch"] = [];
	level.archetypes["soldier"]["cover_multi"] = var_00;
}