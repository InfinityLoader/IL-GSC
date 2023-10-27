/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_mapselect.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 460 ms
 * Timestamp: 10/27/2023 12:29:03 AM
*******************************************************************/

//Function Number: 1
func_B337()
{
	level._effect["map_target_mark"] = loadfx("vfx/iw7/_requests/mp/vfx_marker_map_target");
}

//Function Number: 2
func_8112(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = 0;
	if(scripts\mp\_utility::func_9EAF(param_00))
	{
		var_03 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	thread func_13AC4();
	thread func_13AE7();
	var_04 = undefined;
	self setscriptablepartstate("killstreak","visor_active",0);
	self visionsetnakedforplayer("map_select_mp",0.5);
	var_04 = func_76F7(param_01,param_02);
	return var_04;
}

//Function Number: 3
func_76F7(param_00,param_01)
{
	var_02 = 1;
	if(param_00 <= 1)
	{
		self setclientomnvar("ui_map_select_uses",-1);
		var_02 = 0;
	}

	self.var_B338 = 0;
	self.var_D8AD = undefined;
	var_03 = [];
	thread func_13AC5();
	if(scripts\mp\_utility::func_9FB3(var_02))
	{
		self setclientomnvar("ui_map_select_uses",param_00);
		self setclientomnvar("ui_map_select_count",param_00);
	}

	while(self.var_B338 < param_00)
	{
		var_04 = func_1374C("confirm_location","cancel_location");
		if(!isdefined(var_04) || var_04.var_11145 == "cancel_location")
		{
			var_03 = undefined;
			break;
		}

		var_03[var_03.size] = var_04;
		self.var_B338++;
		if(scripts\mp\_utility::func_9FB3(var_02))
		{
			self setclientomnvar("ui_map_select_uses",param_00 - self.var_B338);
		}

		self playlocalsound("bombardment_killstreak_select");
	}

	self setclientomnvar("ui_map_select_count",-1);
	self notify("map_select_exit");
	self visionsetnakedforplayer("",0);
	if(scripts\mp\_utility::func_9FB3(level.var_C1BB) && !scripts\mp\_utility::func_9FB3(level.var_C1B2))
	{
		thread scripts\mp\killstreaks\_nuke::func_FB0F(0.05);
	}

	self setscriptablepartstate("killstreak","neutral",0);
	if(isdefined(var_03))
	{
		self.pers["startedMapSelect"] = 0;
	}

	return var_03;
}

//Function Number: 4
func_13AC5()
{
	self endon("map_select_exit");
	for(;;)
	{
		if(self getcurrentweapon() != "ks_remote_map_mp")
		{
			self notify("cancel_location");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 5
func_13AC4()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("map_select_exit");
	func_1107B();
}

//Function Number: 6
func_13AE7()
{
	self endon("disconnect");
	self endon("map_select_exit");
	level endon("game_ended");
	self setclientomnvar("ui_location_selection_countdown",gettime() + 30000);
	scripts\common\utility::waittill_any_timeout_1(30,"death");
	self notify("cancel_location");
}

//Function Number: 7
func_10DC2(param_00,param_01,param_02)
{
	if(!self.pers["startedMapSelect"])
	{
		function_0223(self);
		self.pers["startedMapSelect"] = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self method_8023(param_00,param_01,param_02,1);
}

//Function Number: 8
func_1107B()
{
	self method_80DE();
	self.var_B338 = undefined;
	self.var_B336 = undefined;
	self.var_D8AD = undefined;
	if(scripts\mp\_utility::func_9F19(self))
	{
		self notify("killstreak_finished_with_weapon_ks_remote_map_mp");
		return;
	}

	self.pers["startedMapSelect"] = 0;
}

//Function Number: 9
func_1374C(param_00,param_01,param_02)
{
	if((!isdefined(param_00) || param_00 != "death") && !isdefined(param_01) || param_01 != "death")
	{
		self endon("death");
	}

	var_03 = spawnstruct();
	if(isdefined(param_00))
	{
		childthread func_137F9(param_00,var_03);
	}

	if(isdefined(param_01))
	{
		childthread func_137F9(param_01,var_03);
	}

	if(isdefined(param_02))
	{
		childthread func_137F9(param_02,var_03);
	}

	var_03 waittill("returned",var_04,var_05,var_06);
	var_03 notify("die");
	var_07 = spawnstruct();
	var_07.var_AEC4 = var_04;
	var_07.angles = var_05;
	var_07.var_11145 = var_06;
	return var_07;
}

//Function Number: 10
func_137F9(param_00,param_01)
{
	if(param_00 != "death")
	{
		self endon("death");
	}

	param_01 endon("die");
	self waittill(param_00,var_02,var_03);
	param_01 notify("returned",var_02,var_03,param_00);
}