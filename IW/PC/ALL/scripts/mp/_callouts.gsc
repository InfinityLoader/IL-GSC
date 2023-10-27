/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_callouts.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 511 ms
 * Timestamp: 10/27/2023 12:14:42 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_377C = spawnstruct();
	level.var_377C.var_3780 = "mp/map_callouts/" + level.var_B335 + "_callouts.csv";
	func_498F();
	level.var_377C.var_213C = getentarray("callout_area","targetname");
	foreach(var_01 in level.var_377C.var_213C)
	{
		var_01 thread func_377A();
	}

	thread func_BA04();
}

//Function Number: 2
func_498F()
{
	var_00 = level.var_377C;
	var_00.var_2138 = [];
	var_00.var_2138["none"] = -1;
	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow(level.var_377C.var_3780,var_01,0);
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		var_02 = int(var_02);
		var_03 = tablelookupbyrow(level.var_377C.var_3780,var_01,3);
		if(var_03 != "area")
		{
		}
		else
		{
			var_04 = tablelookupbyrow(level.var_377C.var_3780,var_01,1);
			var_00.var_2138[var_04] = var_02;
		}

		var_01++;
	}
}

//Function Number: 3
func_BA04()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 func_F7EF("none");
	}
}

//Function Number: 4
func_377A()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		var_00 func_F7EF(self.script_noteworthy,self);
	}
}

//Function Number: 5
func_F7EF(param_00,param_01)
{
	if(isdefined(self.var_3779) && self.var_3779 == param_00)
	{
		return;
	}

	if(isdefined(self.var_3779) && param_00 != "none" && self.var_3779 != "none")
	{
		return;
	}

	self.var_3779 = param_00;
	if(isdefined(param_01))
	{
		thread func_13B08(param_01,param_01.script_noteworthy);
	}

	var_02 = level.var_377C.var_2138[param_00];
	if(isdefined(var_02))
	{
		self setclientomnvar("ui_callout_area_id",var_02);
		var_03 = scripts\mp\_utility::func_7BC3(1,0);
		foreach(var_05 in var_03)
		{
			if(var_05 ismlgspectator())
			{
				var_05 setclientomnvar("ui_callout_area_id",var_02);
			}
		}

		return;
	}

	if(param_00 != "none")
	{
	}
}

//Function Number: 6
func_13B08(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	thread func_419F();
	for(;;)
	{
		if(self.var_3779 != param_01)
		{
			return;
		}

		if(!self istouching(param_00))
		{
			func_F7EF("none");
			return;
		}

		wait(0.5);
	}
}

//Function Number: 7
func_419F()
{
	self endon("disconnect");
	self waittill("death");
	func_F7EF("none");
}