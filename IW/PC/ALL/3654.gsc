/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3654.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 20 ms
 * Timestamp: 10/27/2023 12:30:59 AM
*******************************************************************/

//Function Number: 1
func_959B()
{
	setdvarifuninitialized("cursor_hint_debug",0);
	precacheshader("cursor_hint_circle");
	precacheshader("cursor_hint_x");
	precacheshader("cursor_hint_square");
	precacheshader("alien_dpad_none");
	precacheshader("hud_arrow_up");
	precacheshader("hud_interaction_prompt_center_ammo");
	precacheshader("hud_scrap_medium_icon_test");
	precacheshader("hud_interaction_prompt_center_heavy");
	precacheshader("hud_interaction_prompt_center_steel_dragon");
	level.var_4C21 = [];
	level.var_4C22 = 1;
}

//Function Number: 2
func_48C4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	var_0F = self;
	if(function_02A4(var_0F) || var_0F.classname == "script_origin" || isdefined(param_01))
	{
		var_0F = spawn("script_origin",self.origin);
		self.var_4C1F = var_0F;
		thread func_8FF7();
	}

	if(isdefined(param_01))
	{
		var_10 = "tag_origin";
		if(isdefined(param_00))
		{
			var_10 = param_00;
			var_0F.origin = self gettagorigin(var_10);
		}

		if(isdefined(self.model) && self.classname == "script_model" && scripts\sp\_utility::func_8C32(self.model,var_10))
		{
			var_0F linkto(self,var_10,param_01,(0,0,0));
		}
		else if(isdefined(param_00))
		{
			var_0F linkto(self,var_10,param_01,(0,0,0));
		}
		else if(isdefined(self.angles))
		{
			var_0F.origin = var_0F.origin + rotatevector(param_01,self.angles);
			if(function_02A6(self))
			{
				var_0F linkto(self);
			}
		}
		else
		{
			var_0F.origin = var_0F.origin + param_01;
			if(function_02A6(self))
			{
				var_0F linkto(self);
			}
		}
	}
	else if(isdefined(param_00))
	{
		var_0F method_84A7(param_00);
	}

	if(isdefined(param_08) && param_08)
	{
		var_0F setcursorhint("HINT_NOICON");
	}
	else
	{
		var_0F setcursorhint("HINT_BUTTON");
	}

	if(isdefined(param_02))
	{
		var_0F sethintstring(param_02);
	}

	var_11 = 360;
	if(isdefined(param_03))
	{
		var_11 = param_03;
	}

	var_0F method_84A6(var_11);
	var_12 = 65;
	if(isdefined(param_0E))
	{
		var_12 = param_0E;
	}

	var_0F method_84A5(var_12);
	var_13 = 500;
	if(isdefined(param_04))
	{
		var_13 = param_04;
	}

	var_0F method_84A4(var_13);
	var_14 = 80;
	if(isdefined(param_05))
	{
		var_14 = param_05;
	}

	var_0F method_84A2(var_14);
	if(isdefined(param_06) && param_06)
	{
		var_0F method_84A9("show");
	}
	else
	{
		var_0F method_84A9("hide");
	}

	if(isdefined(param_0A) && param_0A)
	{
		var_0F method_84A9("disable");
	}

	if(isdefined(param_07) && param_07)
	{
		var_0F method_84B8(param_07);
	}
	else if(isdefined(param_0B) && param_0B)
	{
		var_0F method_8560(param_0B);
	}
	else
	{
		thread func_8FF0();
	}

	if(isdefined(param_09))
	{
		var_0F method_852E(param_09);
	}

	if(isdefined(param_0C))
	{
		var_0F method_84A3(param_0C);
	}

	if(isdefined(param_0D))
	{
		var_0F method_8561(1);
	}
	else
	{
		var_0F method_8561(0);
	}

	var_0F makeusable();
}

//Function Number: 3
func_8FF7()
{
	self endon("death");
	self endon("hint_destroyed");
	self.var_4C1F waittill("trigger",var_00);
	self notify("trigger",var_00);
}

//Function Number: 4
func_8FF0()
{
	self endon("hint_destroyed");
	var_00 = self;
	if(isdefined(self.var_4C1F))
	{
		var_00 = self.var_4C1F;
	}

	hint_delete_on_trigger_waittill(var_00);
	thread func_DFE3();
}

//Function Number: 5
hint_delete_on_trigger_waittill(param_00)
{
	self endon("entitydeleted");
	param_00 waittill("trigger");
}

//Function Number: 6
func_DFE3()
{
	var_00 = self;
	if(isdefined(self.var_4C1F))
	{
		var_00 = self.var_4C1F;
		var_00 scripts\common\utility::delaycall(0.5,::delete);
	}

	if(isdefined(var_00) && !function_02A4(var_00))
	{
		var_00 makeunusable();
	}

	if(isdefined(self))
	{
		scripts\sp\_utility::func_C12D("hint_destroyed",0.05);
	}
}

//Function Number: 7
func_9016()
{
	var_00 = scripts\sp\_utility::func_B979(self,"stand");
	return var_00;
}

//Function Number: 8
func_48C5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	func_48C4(param_00,param_01,param_02,param_07,param_05,param_06,param_04,param_03);
}

//Function Number: 9
func_48C6(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = scripts\common\utility::spawn_tag_origin();
	var_08.origin = self.origin;
	var_08.angles = (0,0,0);
	if(isdefined(self.angles))
	{
		var_08.angles = self.angles;
	}

	var_08.var_13084 = self;
	self.var_4C1D = var_08;
	var_08 scripts\sp\_utility::func_65E0("hint_showing");
	var_08 scripts\sp\_utility::func_65E0("hint_usable");
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(function_02A6(self))
	{
		self makeunusable();
	}

	if(isdefined(param_00))
	{
		var_08 linkto(self,param_00,param_01,(0,0,0));
	}
	else if(isdefined(param_01))
	{
		if(isdefined(self.model) && self.classname == "script_model" && scripts\sp\_utility::func_8C32(self.model,"tag_origin"))
		{
			var_08 linkto(self,"tag_origin",param_01,(0,0,0));
		}
		else if(isdefined(self.angles))
		{
			var_08.origin = var_08.origin + rotatevector(param_01,self.angles);
		}
		else
		{
			var_08.origin = var_08.origin + param_01;
		}
	}
	else if(function_02A6(self))
	{
		var_08 linkto(self);
	}

	var_08.var_928E = [];
	var_09 = newhudelem();
	var_09.alpha = 0;
	var_09 setshader("cursor_hint_circle",1,1);
	var_09 setwaypoint(1,0,1);
	var_09 settargetent(var_08);
	var_09.sort = -1;
	var_09.var_1012F = 0;
	var_08.var_928E["circle"] = var_09;
	var_0A = newhudelem();
	var_0A.alpha = 0;
	if(level.var_DADC)
	{
		var_0A setshader("cursor_hint_square",1,1);
	}
	else
	{
		var_0A setshader("cursor_hint_x",1,1);
	}

	var_0A setwaypoint(0,0,1);
	var_0A settargetent(var_08);
	var_0A.sort = 1;
	var_0A.var_1012F = 0;
	var_08.var_928E["button"] = var_0A;
	var_08.hidden = 0;
	var_08.var_369 = 0;
	if(isdefined(param_02))
	{
		var_08.var_9075 = param_02 * 1000;
	}

	var_08.var_7345 = 0.85;
	if(isdefined(param_03))
	{
		var_08.var_7345 = cos(param_03);
	}

	var_08.var_13393 = 500;
	if(isdefined(param_04))
	{
		var_08.var_13393 = param_04;
	}

	var_08.var_13078 = 80;
	if(isdefined(param_05))
	{
		var_08.var_13078 = param_05;
	}

	var_08.var_11A8F = 1;
	if(isdefined(param_06))
	{
		var_08.var_11A8F = param_06;
	}

	var_08.var_8C4F = 0;
	if(isdefined(param_07))
	{
		if(isstring(param_07) || param_07 != 0)
		{
			var_08.var_C362 = "hud_arrow_up";
			if(isstring(param_07))
			{
				var_08.var_C362 = param_07;
			}

			var_08.var_8C4F = 1;
		}
	}

	var_08.priority = 0;
	if(isdefined(self.var_900A))
	{
		var_08.priority = self.var_900A;
	}

	var_0B = 0;
	if(level.var_4C21.size == 0)
	{
		var_0B = 1;
	}

	level.var_4C21 = scripts\common\utility::array_add(level.var_4C21,var_08);
	if(var_0B)
	{
		thread func_4C20();
	}
}

//Function Number: 10
func_DFE4()
{
	if(!isdefined(self.var_4C1D))
	{
		return;
	}

	var_00 = self.var_4C1D;
	level.var_4C21 = scripts\common\utility::func_22A9(level.var_4C21,var_00);
	var_00.var_928E["circle"] destroy();
	var_00.var_928E["button"] destroy();
	if(var_00.var_8C4F)
	{
		var_00 func_8E9B();
	}

	var_00 delete();
	self.var_4C1D = undefined;
	self notify("hint_destroyed");
}

//Function Number: 11
func_4C20()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = scripts\common\trace::func_48BC(1,1,1,1,1,1);
	for(;;)
	{
		if(level.var_4C21.size == 0)
		{
			break;
		}

		var_05 = func_10424();
		scripts\common\utility::array_thread(var_05["not_viewable"],::func_8E8E);
		scripts\common\utility::array_thread(var_05["not_viewable"],::func_C360);
		var_06 = var_05["viewable"];
		if(var_06.size == 0)
		{
			var_00 = undefined;
			var_01 = undefined;
		}
		else
		{
			var_07 = func_10426(var_06,var_04);
			scripts\common\utility::array_thread(var_07["remove"],::func_8E8E);
			var_08 = func_10425(var_07["viewable"]);
			var_09 = func_10425(var_07["useable"]);
			var_0A = scripts\common\utility::array_combine(var_09,var_08);
			var_0B = undefined;
			foreach(var_0E, var_0D in var_0A)
			{
				if(var_0E >= level.var_4C22)
				{
					var_0D func_8E8E();
					continue;
				}

				if(var_0D.var_369 && !isdefined(var_0B))
				{
					var_0B = var_0D;
					var_0D func_100E9();
					continue;
				}

				var_0D func_8E8E();
				var_0D func_100E9("circle");
			}

			if(!isdefined(var_0B))
			{
			}
			else if(level.player usebuttonpressed())
			{
				if(isdefined(var_0B.var_9075))
				{
					var_0F = 0;
					if(!isdefined(var_03))
					{
						var_03 = func_D9DC();
					}

					if(!isdefined(var_00) || var_0B == var_00)
					{
						if(!isdefined(var_02))
						{
							var_02 = gettime();
						}

						if(gettime() - var_02 >= 100)
						{
							var_01 = undefined;
						}

						var_02 = gettime();
						if(!isdefined(var_01))
						{
							var_01 = gettime();
						}

						var_10 = gettime() - var_01;
						if(var_10 >= var_0B.var_9075)
						{
							var_01 = undefined;
							var_0F = 1;
							var_03 func_D9DB();
						}
						else
						{
							var_03 func_D9DE(var_10,var_0B.var_9075);
						}
					}

					var_00 = var_0B;
					if(!var_0F)
					{
					}
					else
					{
						var_0B notify("trigger",level.player);
						var_0B.var_13084 notify("trigger",level.player);
						var_0B func_408B();
						wait(0.4);
					}
					else
					{
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
func_10424()
{
	var_00 = [];
	var_00["viewable"] = [];
	var_00["not_viewable"] = [];
	foreach(var_02 in level.var_4C21)
	{
		if(level.player scripts\sp\_utility::func_65DF("viper_initiated") && level.player scripts\sp\_utility::func_65DB("viper_initiated"))
		{
			var_03 = combineangles(level.var_133EC.var_D267.angles,level.player getplayerangles());
			var_04 = func_79CE(level.player geteye(),var_03,var_02.origin);
		}
		else
		{
			var_04 = func_79CE(level.player geteye(),level.player getplayerangles(),var_02.origin);
		}

		var_02.var_4BEC = var_04;
		if(var_04 < var_02.var_7345)
		{
			var_00["not_viewable"] = scripts\common\utility::array_add(var_00["not_viewable"],var_02);
			continue;
		}
		else
		{
			var_00["viewable"] = scripts\common\utility::array_add(var_00["viewable"],var_02);
		}

		if(getdvarint("cursor_hint_debug"))
		{
			var_02 func_4C1E();
		}
	}

	return var_00;
}

//Function Number: 13
func_10426(param_00,param_01)
{
	var_02 = [];
	var_02["viewable"] = [];
	var_02["useable"] = [];
	var_02["remove"] = [];
	foreach(var_04 in param_00)
	{
		var_04.var_369 = 0;
		var_04.var_9035 = 0;
		var_05 = level.player;
		if(isdefined(var_04.var_13084.classname) && function_02A6(var_04.var_13084))
		{
			var_05 = [level.player,var_04.var_13084];
		}

		var_06 = scripts\common\trace::func_DCED(level.player geteye(),var_04.origin,var_05,param_01);
		if(var_04.var_11A8F && var_06["fraction"] < 1)
		{
			var_07 = 1;
			if(isdefined(var_06["entity"]) && isai(var_06["entity"]))
			{
				param_01 = scripts\common\trace::func_48BC(0,1,1,1,1,1);
				if(scripts\common\trace::func_DCF1(level.player geteye(),var_04.origin,var_05,param_01))
				{
					var_04.var_9035 = 1;
					var_07 = 0;
				}
			}

			if(var_07)
			{
				var_02["remove"] = scripts\common\utility::array_add(var_02["remove"],var_04);
				continue;
			}
		}

		var_08 = distancesquared(var_04.origin,level.player.origin);
		if(var_08 > squared(var_04.var_13393))
		{
			var_02["remove"] = scripts\common\utility::array_add(var_02["remove"],var_04);
			continue;
		}

		if(var_08 > squared(var_04.var_13078) || var_04.var_9035)
		{
			var_02["viewable"] = scripts\common\utility::array_add(var_02["viewable"],var_04);
			continue;
		}

		var_02["useable"] = scripts\common\utility::array_add(var_02["useable"],var_04);
		var_04.var_369 = 1;
	}

	return var_02;
}

//Function Number: 14
func_10425(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		foreach(var_06, var_05 in var_01)
		{
			if(var_03.priority == var_05.priority)
			{
				var_06++;
			}
			else if(var_03.priority < var_05.priority)
			{
				continue;
			}

			break;
		}

		if(!isdefined(var_06))
		{
			var_06 = 0;
		}

		var_01 = scripts\common\utility::func_229C(var_01,var_03,var_06);
	}

	if(var_01.size <= 1)
	{
		return var_01;
	}

	var_08 = [];
	foreach(var_03 in var_01)
	{
		if(var_03.var_4BEC >= 0.95)
		{
			var_0A = 0;
			foreach(var_06, var_0C in var_08)
			{
				if(var_03.var_4BEC > var_0C.var_4BEC)
				{
					var_0A = 1;
					var_08 = scripts\common\utility::func_229C(var_08,var_03,var_06);
					break;
				}
			}

			if(!var_0A)
			{
				var_08 = scripts\common\utility::array_add(var_08,var_03);
			}

			continue;
		}

		var_08 = scripts\common\utility::array_add(var_08,var_03);
	}

	return var_08;
}

//Function Number: 15
func_100E9(param_00)
{
	if(!isdefined(param_00))
	{
		foreach(var_02 in self.var_928E)
		{
			if(var_02.var_1012F)
			{
				continue;
			}

			var_03 = 1;
			if(var_02 != self.var_928E["button"])
			{
				var_02 fadeovertime(0.2);
				var_03 = 0.7;
				if(self.var_9035)
				{
					var_03 = 0.2;
				}
			}

			var_02.alpha = var_03;
			var_02.var_1012F = 1;
		}

		scripts\sp\_utility::func_65E1("hint_showing");
		scripts\sp\_utility::func_65E1("hint_usable");
		return;
	}

	if(!self.var_928E[param_00].var_1012F)
	{
		var_03 = 1;
		if(param_00 != "button")
		{
			self.var_928E[param_00] fadeovertime(0.2);
			var_03 = 0.7;
			if(self.var_9035)
			{
				var_03 = 0.2;
			}

			scripts\sp\_utility::func_65E1("hint_usable");
		}
		else
		{
			scripts\sp\_utility::func_65E1("hint_showing");
		}

		self.var_928E[param_00].alpha = var_03;
		self.var_928E[param_00].var_1012F = 1;
	}
}

//Function Number: 16
func_8E8E(param_00)
{
	if(!isdefined(param_00))
	{
		foreach(var_02 in self.var_928E)
		{
			if(!var_02.var_1012F)
			{
				continue;
			}

			if(var_02 != self.var_928E["button"])
			{
				var_02 fadeovertime(0.2);
			}

			var_02.alpha = 0;
			var_02.var_1012F = 0;
		}

		scripts\sp\_utility::func_65DD("hint_showing");
		scripts\sp\_utility::func_65DD("hint_usable");
		return;
	}

	if(self.var_928E[param_00].var_1012F)
	{
		if(param_00 != "button")
		{
			self.var_928E[param_00] fadeovertime(0.2);
			scripts\sp\_utility::func_65DD("hint_usable");
		}
		else
		{
			scripts\sp\_utility::func_65DD("hint_showing");
		}

		self.var_928E[param_00].alpha = 0;
		self.var_928E[param_00].var_1012F = 0;
	}
}

//Function Number: 17
func_C360()
{
	if(!self.var_8C4F)
	{
		return;
	}

	var_00 = distancesquared(self.origin,level.player.origin);
	if(var_00 > squared(self.var_13393))
	{
		func_8E9B();
		return;
	}

	func_100F1();
}

//Function Number: 18
func_100F1()
{
	if(function_0209(self))
	{
		return;
	}

	function_020B(self);
	function_0214(self,"alien_dpad_none");
	function_0212(self,self.var_C362);
}

//Function Number: 19
func_8E9B()
{
	if(!function_0209(self))
	{
		return;
	}

	function_020A(self);
}

//Function Number: 20
func_408B()
{
	foreach(var_01 in self.var_928E)
	{
		var_01 destroy();
	}

	level.var_4C21 = scripts\common\utility::func_22A9(level.var_4C21,self);
	self delete();
}

//Function Number: 21
func_D9DC()
{
	var_00 = level.player scripts\sp\_hud_util::func_4997("white","black",100,12);
	var_00 scripts\sp\_hud_util::setpoint("CENTER",undefined,0,150);
	var_00 scripts\sp\_hud_util::updatebar(0);
	var_00.sort = 2;
	var_00.bar.sort = 2.1;
	return var_00;
}

//Function Number: 22
func_D9DE(param_00,param_01)
{
	var_02 = param_00 / param_01;
	scripts\sp\_hud_util::updatebar(var_02);
	thread func_D9DD();
}

//Function Number: 23
func_D9DD()
{
	self notify("timeout_check");
	self endon("timeout_check");
	self endon("death");
	wait(0.1);
	func_D9DB();
}

//Function Number: 24
func_D9DB()
{
	self.bar destroy();
	self destroy();
}

//Function Number: 25
func_79CE(param_00,param_01,param_02)
{
	var_03 = vectornormalize(param_02 - param_00);
	var_04 = anglestoforward(param_01);
	var_05 = vectordot(var_04,var_03);
	return var_05;
}

//Function Number: 26
func_4C1E()
{
	var_00 = anglestoup(self.angles);
	var_01 = self.origin + var_00 * 5;
	var_02 = self.origin;
	thread scripts\sp\_utility::func_5B29(self.origin,self.var_13393,(0,1,0),1,0,1);
	thread scripts\sp\_utility::func_5B29(self.origin,self.var_13078,(1,0,0),1,0,1);
}