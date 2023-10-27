/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\assault_system_lifesupport.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 753 ms
 * Timestamp: 10/27/2023 12:12:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.var_23AB))
	{
		level.var_23AB = [];
	}

	var_00 = spawnstruct();
	level.var_23AB["lifesupport"] = var_00;
}

//Function Number: 2
func_FACA(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(var_01.size == 0)
	{
		return;
	}

	foreach(var_03 in var_01)
	{
		func_AC73(var_03);
	}
}

//Function Number: 3
func_AC73(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = getent(param_00.script_noteworthy,"targetname");
	}

	if(!isdefined(var_01))
	{
		var_01 = spawn("script_model",param_00.origin);
		var_01 setmodel("laptop_toughbook_open_on_iw6");
		var_01.angles = param_00.angles;
	}

	var_01.health = 99999;
	param_00.visuals = var_01;
	var_02 = scripts\mp\_gameobjects::func_4A2E("axis",param_00,[var_01],(0,0,64));
	var_02.label = "lifesupport_" + param_00.var_336;
	var_02.var_92B8 = "use";
	var_02 func_113A7(undefined);
	if(isdefined(param_00.target))
	{
		var_02.var_1157D = getent(param_00.target,"targetname");
	}

	return var_02;
}

//Function Number: 4
func_113A5(param_00)
{
}

//Function Number: 5
func_113A6(param_00,param_01,param_02)
{
}

//Function Number: 6
func_113A7(param_00)
{
	func_E27D(param_00);
	func_113AA();
	self notify("stop_trigger_monitor");
}

//Function Number: 7
func_113AB()
{
	scripts\mp\_gameobjects::func_1CAF("friendly");
	scripts\mp\_gameobjects::func_FB08(1);
	scripts\mp\_gameobjects::func_FB14(1);
	scripts\mp\_gameobjects::func_FB07(&"MP_BREACH_OPERATE_SYSTEM_ON_ACTION");
	scripts\mp\_gameobjects::func_FB06(&"MP_BREACH_OPERATE_LIFESUPPORT_ON");
	self.var_C4CB = ::func_113A5;
	self.var_C50D = ::func_113A6;
	self.var_C5BB = ::func_113A7;
}

//Function Number: 8
func_113A2(param_00)
{
}

//Function Number: 9
func_113A3(param_00,param_01,param_02)
{
}

//Function Number: 10
func_113A4(param_00)
{
	func_E27D(param_00);
	func_113AB();
	thread func_BA35();
}

//Function Number: 11
func_113AA()
{
	scripts\mp\_gameobjects::func_1CAF("enemy");
	scripts\mp\_gameobjects::func_FB08(2);
	scripts\mp\_gameobjects::func_FB14(1);
	scripts\mp\_gameobjects::func_FB07(&"MP_BREACH_OPERATE_SYSTEM_OFF_ACTION");
	scripts\mp\_gameobjects::func_FB06(&"MP_BREACH_OPERATE_LIFESUPPORT_OFF");
	self.var_C4CB = ::func_113A2;
	self.var_C50D = ::func_113A3;
	self.var_C5BB = ::func_113A4;
}

//Function Number: 12
func_E27D(param_00)
{
	if(isdefined(param_00))
	{
		param_00 setclientomnvar("ui_securing_progress",1);
		param_00 setclientomnvar("ui_securing",0);
		param_00.var_12B26 = undefined;
	}
}

//Function Number: 13
func_BA35()
{
	level endon("game_ended");
	self endon("stop_trigger_monitor");
	if(!isdefined(self.var_D41E))
	{
		self.var_D41E = [];
	}

	for(;;)
	{
		self.var_1157D waittill("trigger",var_00);
		var_01 = var_00 getentitynumber();
		if(!isdefined(self.var_D41E[var_01]))
		{
			self.var_D41E[var_01] = var_00;
			if(isdefined(self.var_C5B5))
			{
				[[ self.var_C5B5 ]](self,var_00);
			}

			if(self.var_D41E.size == 1)
			{
				thread func_12F4E(0.1);
			}
		}
	}
}

//Function Number: 14
func_12F4E(param_00)
{
	level endon("game_ended");
	self endon("stop_trigger_monitor");
	for(;;)
	{
		foreach(var_03, var_02 in self.var_D41E)
		{
			if(isdefined(var_02) && scripts\mp\_utility::func_9F19(var_02) && var_02 istouching(self.var_1157D))
			{
				if(isdefined(self.var_C5B8))
				{
					[[ self.var_C5B8 ]](self,var_02);
				}

				continue;
			}

			self.var_D41E[var_03] = undefined;
			if(isdefined(var_02))
			{
				if(isdefined(self.var_C5B6))
				{
					[[ self.var_C5B6 ]](self,var_02);
				}
			}
		}

		if(self.var_D41E.size == 0)
		{
			return;
		}
		else
		{
			wait(param_00);
		}
	}
}