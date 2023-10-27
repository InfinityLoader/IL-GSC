/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_capture.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 631 ms
 * Timestamp: 10/27/2023 12:12:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_CB48 = 0.5;
	var_00.var_130ED = &"MP_RETURNING_FLAG";
	var_00.var_130EC = &"MP_GRABBING_FLAG";
	var_00.var_C569 = ::func_C562;
	var_00.var_C4FA = ::func_C560;
	var_00.var_C582 = ::func_C563;
	var_00.var_C4EF = ::func_C55F;
	var_00.var_CB43 = "waypoint_capture_take";
	var_00.var_51DD = 0.5;
	level.var_C2AF["ctf"] = var_00;
}

//Function Number: 2
func_4990(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.var_C2AF["ctf"];
	}

	var_03 = func_4993(param_00,param_01,param_02);
	var_04 = func_49D0(var_03.visuals[0].target,var_03,param_01,param_02);
	var_03.var_155 = var_04;
}

//Function Number: 3
func_4993(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03))
	{
		scripts\common\utility::func_66BD("No model named " + param_00 + " found!");
		return;
	}

	var_04 = spawn("trigger_radius",var_03.origin,0,96,120);
	var_05 = scripts\mp\_gameobjects::func_4993(param_01,var_04,[var_03],(0,0,85));
	var_05 scripts\mp\_gameobjects::func_F87D("friendly",param_02.var_CB48);
	var_05 scripts\mp\_gameobjects::func_F87D("enemy",param_02.var_CB48);
	var_05 scripts\mp\_gameobjects::func_F87C("enemy",param_02.var_130ED);
	var_05 scripts\mp\_gameobjects::func_F87C("friendly",param_02.var_130EC);
	var_05 scripts\mp\_gameobjects::func_1C7C("enemy");
	var_05 scripts\mp\_gameobjects::func_F283("enemy",param_02.var_CB43);
	var_05 scripts\mp\_gameobjects::func_F284("enemy",param_02.var_CB43);
	var_05 scripts\mp\_gameobjects::setvisibleteam("enemy");
	var_05.var_C2BE = 1;
	var_05.var_1CB3 = 1;
	var_05.var_C566 = param_02.var_C569;
	var_05.var_C567 = param_02.var_C568;
	var_05.var_C4F9 = param_02.var_C4FA;
	var_05.var_C581 = param_02.var_C582;
	var_05.var_F88D = param_02;
	if(!isdefined(param_02.var_3AF6))
	{
		param_02.var_3AF6 = var_03.model;
	}

	var_05 method_8317(1);
	var_05 method_8318(1);
	return var_05;
}

//Function Number: 4
func_49D0(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	if(!isdefined(var_04))
	{
		scripts\common\utility::func_66BD("No goal trigger named " + var_04 + " found!");
		return;
	}

	var_05 = scripts\mp\_gameobjects::func_4A2E(param_02,var_04,[],(0,0,85));
	var_05 scripts\mp\_gameobjects::func_1CAF("enemy");
	var_05 scripts\mp\_gameobjects::setvisibleteam("any");
	var_05 scripts\mp\_gameobjects::func_F283("friendly","waypoint_blitz_defend");
	var_05 scripts\mp\_gameobjects::func_F284("friendly","waypoint_blitz_defend");
	var_05 scripts\mp\_gameobjects::func_F283("enemy","waypoint_blitz_goal");
	var_05 scripts\mp\_gameobjects::func_F284("enemy","waypoint_blitz_goal");
	var_05 scripts\mp\_gameobjects::func_FB08(param_03.var_51DD);
	var_05 scripts\mp\_gameobjects::func_F76A(param_01);
	var_05.var_C5BB = param_03.var_C4EF;
	var_05.var_F88D = param_03;
	return var_05;
}

//Function Number: 5
func_C562(param_00)
{
	if(param_00.team == scripts\mp\_gameobjects::func_803E())
	{
		scripts\mp\_gameobjects::func_E472();
		return;
	}

	param_00 func_24A3(self.var_F88D.var_3AF6);
	scripts\mp\_gameobjects::setvisibleteam("any");
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_capture_kill");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_capture_kill");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_escort");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_escort");
}

//Function Number: 6
func_C560(param_00)
{
	scripts\mp\_gameobjects::func_1C7C("any");
	scripts\mp\_gameobjects::setvisibleteam("any");
	scripts\mp\_gameobjects::func_F283("friendly","waypoint_capture_recover");
	scripts\mp\_gameobjects::func_F284("friendly","waypoint_capture_recover");
	scripts\mp\_gameobjects::func_F283("enemy","waypoint_capture_take");
	scripts\mp\_gameobjects::func_F284("enemy","waypoint_capture_take");
}

//Function Number: 7
func_E46B()
{
	if(!isdefined(self.var_F88D.var_E479))
	{
		return;
	}

	self endon("picked_up");
	wait(self.var_F88D.var_E479);
	scripts\mp\_gameobjects::func_E472();
}

//Function Number: 8
func_C563()
{
}

//Function Number: 9
func_C55F(param_00)
{
	self.var_A5A0 scripts\mp\_gameobjects::func_1C7C("none");
	self.var_A5A0 scripts\mp\_gameobjects::setvisibleteam("none");
	param_00 func_5395();
	scripts\mp\_gameobjects::func_51DA();
}

//Function Number: 10
func_24A3(param_00)
{
	self attach(param_00,"j_spine4",1);
	self.var_3AA3 = param_00;
}

//Function Number: 11
func_5395()
{
	if(isdefined(self.var_3AA3))
	{
		self detach(self.var_3AA3,"j_spine4");
		self.var_3AA3 = undefined;
	}
}

//Function Number: 12
func_C577(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	func_5395();
}