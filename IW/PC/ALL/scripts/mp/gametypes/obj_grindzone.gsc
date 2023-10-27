/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_grindzone.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 909 ms
 * Timestamp: 10/27/2023 12:12:57 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_FAC5();
}

//Function Number: 2
func_FAC5()
{
	level.var_92B0 = "waypoint_bank";
	level.var_92AF = "waypoint_bank";
	level.var_929A = "waypoint_scoring_foe";
	level.var_9299 = "waypoint_scoring_foe";
	level.var_92A0 = "waypoint_scoring_friend";
	level.var_929F = "waypoint_scoring_friend";
	level.var_92A7 = "waypoint_contested";
	level.var_92A6 = "waypoint_contested";
	level.var_92AA = "waypoint_contested";
	level.var_92AB = "waypoint_contested";
}

//Function Number: 3
func_FAD5(param_00)
{
	var_01 = level.var_C2A8[param_00];
	if(isdefined(var_01.target))
	{
		var_02[0] = getent(var_01.target,"targetname");
	}
	else
	{
		param_00[0] = spawn("script_model",var_02.origin);
		var_02[0].angles = var_01.angles;
	}

	var_03 = spawn("trigger_radius",var_01.origin,0,90,128);
	var_03.script_label = var_01.script_label;
	var_01 = var_03;
	var_04 = scripts\mp\_gameobjects::func_4A2E("neutral",var_01,var_02,(0,0,90));
	var_04 scripts\mp\_gameobjects::func_1CAF("enemy");
	var_04 scripts\mp\_gameobjects::func_FB08(level.var_280F);
	var_04 scripts\mp\_gameobjects::setvisibleteam("any");
	var_04 scripts\mp\_gameobjects::cancontestclaim(1);
	var_04 scripts\mp\_gameobjects::mustmaintainclaim(1);
	var_04 scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
	var_05 = var_04 scripts\mp\_gameobjects::getlabel();
	var_04.label = var_05;
	var_04.var_C4CB = ::func_13FB7;
	var_04.var_C5C8 = ::func_13FB8;
	var_04.var_C50D = ::zone_onuseend;
	var_04.var_C5BB = ::func_13FB6;
	var_04.var_C5BA = ::func_13FB5;
	var_04.var_C4D9 = ::func_13FB3;
	var_04.var_C5B9 = ::func_13FB4;
	var_04.var_92B8 = "domFlag";
	var_04.var_3FF7 = level.var_280F * 1000;
	var_06 = var_02[0].origin + (0,0,32);
	var_07 = var_02[0].origin + (0,0,-32);
	var_08 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_09 = [];
	var_0A = scripts\common\trace::func_DCED(var_06,var_07,var_09,var_08);
	var_04.var_289D = var_0A["position"];
	var_0B = vectortoangles(var_0A["normal"]);
	var_04.var_289C = anglestoforward(var_0B);
	var_0C = spawn("script_model",var_04.var_289D);
	var_0C setmodel("grind_flag_scriptable");
	var_0C.angles = function_02D7(var_04.var_289C,var_0C.angles);
	var_04.var_289 = var_0C;
	var_04 scripts\common\utility::func_5127(1,::func_F7AD);
	return var_04;
}

//Function Number: 4
func_F7AD()
{
	scripts\mp\_gameobjects::func_F7D4("neutral");
	func_F7AE();
	updateflagstate("idle",0);
}

//Function Number: 5
func_13FB7(param_00)
{
	self.var_54C5 = 0;
	thread scripts\mp\_gameobjects::func_130AE(param_00.team);
}

//Function Number: 6
func_13FB8(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_gameobjects::func_803E();
	if(param_01 > 0.05 && param_02 && !self.var_54C5)
	{
		if(!isagent(param_03))
		{
			updateflagcapturestate(param_00);
		}

		self.var_54C5 = 1;
	}
}

//Function Number: 7
zone_onuseend(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_gameobjects::func_803E();
	if(var_03 == "neutral")
	{
		func_F7AE();
		updateflagstate("idle",0);
		return;
	}

	func_F878();
	updateflagstate(var_03,0);
}

//Function Number: 8
func_13FB6(param_00)
{
	var_01 = param_00.team;
	var_02 = scripts\mp\_gameobjects::func_803E();
	var_03 = scripts\mp\_utility::getotherteam(var_01);
	var_04 = gettime();
	func_F878();
	updateflagstate(var_01,0);
	scripts\mp\_gameobjects::func_F7D4(var_01);
}

//Function Number: 9
func_13FB5()
{
	func_F7AE();
	func_F7AD();
}

//Function Number: 10
func_13FB3()
{
	func_F69F();
	updateflagstate("contested",0);
}

//Function Number: 11
func_13FB4(param_00)
{
	var_01 = scripts\mp\_gameobjects::func_803E();
	if(param_00 == "none" || var_01 == "neutral")
	{
		func_F7AE();
	}
	else
	{
		func_F878();
	}

	var_02 = scripts\common\utility::func_116D7(var_01 == "neutral","idle",var_01);
	updateflagstate(var_02,0);
}

//Function Number: 12
func_F6AA(param_00)
{
	if(isdefined(level.var_112C0) && level.var_112C0 && isdefined(param_00.var_47ED) && param_00.var_47ED)
	{
		param_00 scripts\mp\_utility::func_F6A8("assist");
	}
}

//Function Number: 13
func_F7AE()
{
	scripts\mp\_gameobjects::func_F283("friendly",level.var_92AF + self.label);
	scripts\mp\_gameobjects::func_F284("friendly",level.var_92B0 + self.label);
	scripts\mp\_gameobjects::func_F283("enemy",level.var_92AF + self.label);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_92B0 + self.label);
}

//Function Number: 14
func_F878()
{
	scripts\mp\_gameobjects::func_F283("friendly",level.var_929F + self.label);
	scripts\mp\_gameobjects::func_F284("friendly",level.var_92A0 + self.label);
	scripts\mp\_gameobjects::func_F283("enemy",level.var_9299 + self.label);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_929A + self.label);
}

//Function Number: 15
func_F69F()
{
	scripts\mp\_gameobjects::func_F283("friendly",level.var_92AA + self.label);
	scripts\mp\_gameobjects::func_F284("friendly",level.var_92AB + self.label);
	scripts\mp\_gameobjects::func_F283("enemy",level.var_92A6 + self.label);
	scripts\mp\_gameobjects::func_F284("enemy",level.var_92A7 + self.label);
}

//Function Number: 16
updateflagstate(param_00,param_01)
{
	self.var_289 setscriptablepartstate("flag",param_00);
	if(!scripts\mp\_utility::func_9FB3(param_01))
	{
		self.var_289 setscriptablepartstate("pulse","off");
	}
}

//Function Number: 17
updateflagcapturestate(param_00)
{
	self.var_289 setscriptablepartstate("pulse",param_00);
}