/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3617.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 12:30:56 AM
*******************************************************************/

//Function Number: 1
func_9527()
{
	precacheitem("antigrav");
	precachemodel("anti_grav_border_wm");
	level._effect["antigrav_detonate_dud"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_dud.vfx");
	level._effect["antigrav_caltrop_trail"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_trail.vfx");
	level._effect["antigrav_detonate"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate.vfx");
	level._effect["antigrav_detonate_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_cheap.vfx");
	level._effect["antigrav_caltrop_barrier"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier.vfx");
	level._effect["antigrav_caltrop_barrier_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_cheap.vfx");
	level._effect["antigrav_area_small"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small.vfx");
	level._effect["antigrav_area_small_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_cheap.vfx");
	level._effect["antigrav_detonate_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_upgrade.vfx");
	level._effect["antigrav_detonate_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_upgrade_cheap.vfx");
	level._effect["antigrav_caltrop_barrier_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_upgrade.vfx");
	level._effect["antigrav_caltrop_barrier_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_upgrade_cheap.vfx");
	level._effect["antigrav_area_small_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_upgrade.vfx");
	level._effect["antigrav_area_small_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_upgrade_cheap.vfx");
	scripts\common\utility::flag_init("antigrav_force_delete");
	level.player.var_D363 = [];
	level.player thread func_D0EB();
	level thread func_365A();
	level.var_2006 = spawnstruct();
	level.var_2006.var_A8C6 = undefined;
	level.var_2006.var_522B = [];
}

//Function Number: 2
func_2013(param_00)
{
	var_01 = self;
	var_02 = scripts\common\utility::spawn_tag_origin();
	var_02.origin = param_00.origin;
	var_02.var_15F = param_00;
	var_02 linkto(var_02.var_15F);
	level.var_2006.var_522B[level.var_2006.var_522B.size] = var_02;
	var_03 = var_02.var_15F func_201A();
	if(!isdefined(var_02.var_15F))
	{
		var_02 thread func_DFC5();
		return;
	}

	var_02 func_E057();
	var_02.var_85D2 = var_01 func_1294();
	var_02.var_5F36 = var_01 func_1293();
	var_02.var_112DF = var_03;
	if(isdefined(var_01) && isdefined(var_01.var_202A) && var_01.var_202A == 1)
	{
		var_02.var_5F37 = 1;
	}
	else
	{
		var_02.var_5F37 = 0;
	}

	if(isdefined(var_01) && isdefined(level.player) && var_01 == level.player)
	{
		var_02.var_D43A = 1;
	}
	else
	{
		var_02.var_D43A = 0;
	}

	var_02 thread func_200F();
}

//Function Number: 3
func_201A()
{
	self endon("entitydeleted");
	self endon("death");
	self waittill("missile_stuck",var_00,var_01,var_02);
	return var_02;
}

//Function Number: 4
func_FF4F(param_00,param_01)
{
	if(param_00 scripts\sp\_utility::isactorwallrunning())
	{
		return 0;
	}

	if(func_3CB0(param_00,param_01))
	{
		if(isdefined(param_00.var_1C78))
		{
			return param_00.var_1C78;
		}

		if(param_00 method_81A6())
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 5
func_200B()
{
	var_00 = scripts\common\utility::spawn_tag_origin();
	var_00.origin = self.origin;
	level.var_2006.var_522B[level.var_2006.var_522B.size] = var_00;
	var_00.var_85D2 = 156;
	var_00.var_5F36 = 7;
	var_00 thread func_200F();
}

//Function Number: 6
func_2017()
{
	self playsurfacesound("gravity_explode_default",self.var_112DF);
}

//Function Number: 7
func_200F()
{
	if(!isdefined(self.var_5F37))
	{
		self.var_5F37 = 0;
	}

	if(!isdefined(self.var_112DF))
	{
		self.var_112DF = "default";
	}

	self.angles = (0,0,0);
	self.var_132AA = [];
	thread func_2017();
	if(!self.var_5F37)
	{
		if(level.var_2006.var_522B.size > 1)
		{
			var_00 = "antigrav_detonate_cheap";
		}
		else
		{
			var_00 = "antigrav_detonate";
		}
	}
	else if(level.var_2006.var_522B.size > 1)
	{
		var_00 = "antigrav_detonate_up_cheap";
	}
	else
	{
		var_00 = "antigrav_detonate_up";
	}

	if(scripts\common\utility::func_6E34("in_vr_mode") && scripts\common\utility::flag("in_vr_mode"))
	{
		var_01 = spawnfx(level._effect[var_00],self.origin,(1,0,0),(0,0,1));
		triggerfx(var_01);
		self.var_132AA[self.var_132AA.size] = var_01;
	}
	else
	{
		playfx(level._effect[var_00],self.origin,(1,0,0),(0,0,1));
	}

	func_36E1();
	func_1066C();
	lib_0F18::func_10E8A("broadcast","attack",self.origin,1000);
	level scripts\common\utility::func_6E59("antigrav_force_delete",0.55);
	var_02 = [];
	foreach(var_04 in function_0072())
	{
		if(func_FF4F(var_04,self))
		{
			var_02[var_02.size] = var_04;
		}
	}

	thread scripts\common\utility::func_CD7F("gravity_field_lp");
	self.var_CB13 = func_4933();
	var_06 = 0;
	var_07 = 0;
	foreach(var_09 in self.var_378E)
	{
		if(var_09.var_5F15 == 1)
		{
			continue;
		}

		if(self.origin[2] - var_09.origin[2] > var_06)
		{
			var_06 = self.origin[2] - var_09.origin[2];
		}

		if(var_09.origin[2] - self.origin[2] > var_07)
		{
			var_07 = var_09.origin[2] - self.origin[2];
		}
	}

	var_0B = self.origin[2] - var_06 - 24;
	var_0C = self.origin[2] + var_07 + 72;
	var_0D = var_0C + var_0B * 0.5;
	if(var_0D < self.origin[2])
	{
		var_0E = self.origin;
		var_0F = self.origin[2] - var_0B;
	}
	else
	{
		var_0E = (self.origin[0],self.origin[1],var_0F);
		var_0F = var_0D - var_0C * 0.5;
	}

	func_4926(var_0E,var_0F);
	scripts\common\utility::array_thread(var_02,::func_197D,self);
	func_CF45();
	thread func_FB3E();
	level scripts\common\utility::func_6E59("antigrav_force_delete",self.var_5F36);
	thread func_DFC5();
}

//Function Number: 8
func_4926(param_00,param_01)
{
	var_02 = ["axis","allies","team3","neutral","bad_guys"];
	if(!isdefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0)
	{
		self.var_C2CA = function_0315(param_00,(self.var_85D2,self.var_85D2,param_01),(0,0,0));
		function_0277("antigrav" + self getentitynumber(),-1,param_00,self.var_85D2,1);
		return;
	}

	if(level.var_2006.var_5602.size > 0)
	{
		if(level.var_2006.var_5602[0] == "all")
		{
			return;
		}

		if(scripts\common\utility::func_2286(level.var_2006.var_5602,"allies") && scripts\common\utility::func_2286(level.var_2006.var_5602,"axis"))
		{
			self.var_C2CA = function_0315(param_00,(self.var_85D2,self.var_85D2,param_01),(0,0,0),"team3","neutral","bad_guys");
			function_0277("antigrav" + self getentitynumber(),-1,param_00,self.var_85D2,0,"team3","neutral","bad_guys");
			return;
		}

		if(scripts\common\utility::func_2286(level.var_2006.var_5602,"allies"))
		{
			self.var_C2CA = function_0315(param_00,(self.var_85D2,self.var_85D2,param_01),(0,0,0),"axis","team3","neutral","bad_guys");
			function_0277("antigrav" + self getentitynumber(),-1,param_00,self.var_85D2,0,"team3","neutral","bad_guys");
			return;
		}

		if(scripts\common\utility::func_2286(level.var_2006.var_5602,"axis"))
		{
			self.var_C2CA = function_0315(param_00,(self.var_85D2,self.var_85D2,param_01),(0,0,0),"allies","team3","neutral","bad_guys");
			function_0277("antigrav" + self getentitynumber(),-1,param_00,self.var_85D2,0,"team3","neutral","bad_guys");
			return;
		}

		return;
	}
}

//Function Number: 9
func_FB3E()
{
	level scripts\common\utility::func_6E59("antigrav_force_delete",self.var_5F36 - 0.4);
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_15F))
	{
		thread scripts\sp\_utility::func_CE2F("gravity_field_off");
	}

	thread scripts\common\utility::func_11018("gravity_field_lp");
}

//Function Number: 10
func_DFC5()
{
	if(!isdefined(self))
	{
		return;
	}

	level notify("antigrav_done");
	thread func_E057();
	if(scripts\common\utility::flag("antigrav_force_delete"))
	{
		scripts\common\utility::func_136F7();
	}

	thread scripts\common\utility::func_11018("gravity_field_lp");
	if(isdefined(self.var_BEFC))
	{
		func_D25C();
	}

	if(isdefined(self.var_CB13))
	{
		func_52B3(self.var_CB13);
	}

	if(isdefined(self.var_C2CA))
	{
		destroynavobstacle(self.var_C2CA);
		function_0278("antigrav" + self getentitynumber());
	}

	if(isdefined(self.var_132AA))
	{
		foreach(var_01 in self.var_132AA)
		{
			var_01 delete();
		}
	}

	if(isdefined(self.var_378D))
	{
		var_03 = self.var_378D;
		foreach(var_05 in var_03)
		{
			func_DFC4(var_05);
		}
	}

	level.var_2006.var_522B = scripts\common\utility::func_22A9(level.var_2006.var_522B,self);
	self delete();
}

//Function Number: 11
func_E057()
{
	if(isdefined(self.var_15F))
	{
		level.var_2006.var_A8C6 = self.var_15F.origin;
		self unlink();
		self.var_15F delete();
	}
}

//Function Number: 12
func_DFC4(param_00)
{
	if(isdefined(param_00.var_132AA))
	{
		foreach(var_02 in param_00.var_132AA)
		{
			var_02 delete();
		}
	}

	killfxontag(level._effect["antigrav_caltrop_trail"],param_00,"tag_origin");
	self.var_378D = scripts\common\utility::func_22A9(self.var_378D,param_00);
	param_00 delete();
}

//Function Number: 13
func_DFBA()
{
	level notify("removing_all_antigravs_instantly");
	level endon("removing_all_antigravs_instantly");
	scripts\common\utility::flag_set("antigrav_force_delete");
	foreach(var_01 in level.var_2006.var_522B)
	{
		var_01 thread func_E057();
	}

	for(;;)
	{
		if(level.var_2006.var_522B.size > 0)
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		break;
	}

	scripts\common\utility::func_6E2A("antigrav_force_delete");
}

//Function Number: 14
func_197D(param_00)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.var_1491) && isdefined(self.var_1491.var_58DA))
	{
		self method_81D0();
		return;
	}

	if(self.var_12BA4 == "c12")
	{
		return;
	}

	if(lib_0A1B::func_2938())
	{
		self method_83A1();
	}

	if(!isdefined(self.var_2023))
	{
		func_1978(param_00);
		lib_0A1A::func_237C("antigrav_rise");
		return;
	}

	if(self.var_2023 == "rise" || self.var_2023 == "float_idle")
	{
		self.var_201D = gettime() + param_00.var_5F36 + randomfloat(0.25) * 1000;
		return;
	}

	if(self.var_2023 == "fall")
	{
		self.var_201D = gettime() + param_00.var_5F36 + randomfloat(0.25) * 1000;
		self.var_2020 = 1;
		return;
	}

	func_1978(param_00);
	self.var_2020 = 1;
}

//Function Number: 15
func_1978(param_00)
{
	self.var_2022 = gettime();
	self.var_201D = self.var_2022 + param_00.var_5F36 + randomfloat(0.25) * 1000;
}

//Function Number: 16
func_CF45()
{
	self.var_BEFC = 1;
	level.player.var_D363[level.player.var_D363.size] = self;
	level.player notify("new_antigrav_gren_active");
	thread func_CF46();
}

//Function Number: 17
func_CF46()
{
	scripts\common\utility::func_6E59("antigrav_force_delete",0.1);
	self.var_BEFC = 0;
}

//Function Number: 18
func_D25C()
{
	level.player.var_D363 = scripts\common\utility::func_22A9(level.player.var_D363,self);
	level.player notify("removed_antigrav_gren");
}

//Function Number: 19
func_365A()
{
	for(;;)
	{
		waittillframeend;
		level.player.var_D363 = scripts\common\utility::func_22BC(level.player.var_D363);
		var_00 = function_0075("all","C12");
		foreach(var_02 in var_00)
		{
			if(!isalive(var_02))
			{
				continue;
			}

			if(!isdefined(var_02.var_93B5))
			{
				var_02.var_93B5 = 0;
			}

			var_03 = 0;
			foreach(var_05 in level.player.var_D363)
			{
				if(func_3CB0(var_02,var_05))
				{
					var_03 = 1;
					break;
				}
			}

			if(var_03)
			{
				if(!var_02.var_93B5)
				{
					var_02.var_2015 = var_02.var_BCD6;
					var_02.var_BCD6 = 0.2;
					var_02.var_93B5 = 1;
				}

				continue;
			}

			if(var_02.var_93B5)
			{
				var_02.var_BCD6 = var_02.var_2015;
				var_02.var_2015 = undefined;
				var_02.var_93B5 = 0;
			}
		}

		wait(0.05);
	}
}

//Function Number: 20
func_D0EB()
{
	self endon("death");
	self.var_93B5 = 0;
	for(;;)
	{
		waittillframeend;
		level.player.var_D363 = scripts\common\utility::func_22BC(level.player.var_D363);
		if(self.var_D363.size == 0)
		{
			if(self.var_93B5)
			{
				func_5567();
				self.var_93B5 = 0;
			}

			self waittill("new_antigrav_gren_active");
		}

		var_00 = 0;
		var_01 = 0;
		self.var_4B16 = undefined;
		if(!level.player scripts\sp\_utility::func_65DF("disable_antigrav_float") || !level.player scripts\sp\_utility::func_65DB("disable_antigrav_float"))
		{
			foreach(var_03 in self.var_D363)
			{
				if(func_3CB0(self,var_03))
				{
					var_00 = 1;
					self.var_4B16 = var_03;
					if(var_03.var_BEFC == 1)
					{
						var_01 = 1;
					}
				}
			}
		}

		if(!self.var_93B5 && var_00)
		{
			thread func_6228();
			self.var_93B5 = 1;
		}
		else if(self.var_93B5 && !var_00)
		{
			thread func_5567();
			self.var_93B5 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 21
func_6228()
{
	level.player notify("enable_player_antigrav_gren");
	level.player endon("disable_player_antigrav_gren");
	if(!isdefined(level.player.var_2028))
	{
		lib_0E4F::func_9755();
		level.player.var_2028 = 1;
		level.player.var_2024 = level.player getstance();
		if(level.player.var_2024 == "crouch")
		{
			function_01C5("player_spaceViewHeight",40);
			function_01C5("player_spaceCapsuleHeight",50);
		}
		else if(level.player.var_2024 == "prone")
		{
			function_01C5("player_spaceViewHeight",11);
			function_01C5("player_spaceCapsuleHeight",30);
		}
		else
		{
			function_01C5("player_spaceViewHeight",60);
			function_01C5("player_spaceCapsuleHeight",70);
		}
	}

	level.player scripts\common\utility::func_1C6E(0);
	level.player.var_C37D = getdvarint("player_death_animated",1);
	setdvar("player_death_animated",0);
	if(level.player scripts\sp\_utility::func_65DB("player_space_override_off"))
	{
		return;
	}

	if(level.player scripts\sp\_utility::func_9F59())
	{
		level.player notify("cancel_sliding");
		level.player scripts\sp\_utility::func_6389();
	}

	if(level.player isonground())
	{
		level.player playgestureviewmodel("ges_antigrav_reaction");
		level.player.var_D4AB = 1;
		thread func_CF65();
	}
	else
	{
		level.player playgestureviewmodel("ges_antigrav_reaction");
		level.player.var_D4AB = 1;
		thread func_CF65();
	}

	level.player.var_2A6.var_6F43 = 1;
	level.player scripts\sp\_utility::func_65E1("player_gravity_off");
	level.player thread func_CF64();
	level.player thread func_CF67();
}

//Function Number: 22
func_5567()
{
	level.player notify("disable_player_antigrav_gren");
	if(level.player scripts\sp\_utility::func_65DF("player_gravity_off"))
	{
		level.player scripts\sp\_utility::func_65DD("player_gravity_off");
	}

	level.player.var_D4AB = undefined;
	level.player scripts\common\utility::func_1C6E(1);
	setdvar("player_death_animated",level.player.var_C37D);
	level.player.var_C37D = undefined;
	thread func_5568();
}

//Function Number: 23
func_5568()
{
	level.player endon("enable_player_antigrav_gren");
	for(;;)
	{
		if(getdvarint("player_spaceEnabled") == 0)
		{
			break;
		}

		wait(0.05);
	}

	for(;;)
	{
		level.player setstance(level.player.var_2024);
		if(level.player getstance() == level.player.var_2024)
		{
			break;
		}

		wait(0.05);
	}

	level.player.var_2028 = undefined;
}

//Function Number: 24
func_CF64()
{
	self endon("death");
	self notify("crawlmeleegrab_antigrav");
	waittillframeend;
	self.var_2A6.var_6F43 = 1;
	self method_80D8(0.8,0.8);
	lib_0E4F::func_6251();
	lib_0E4F::func_621C();
	while(lib_0E4F::func_9C7B())
	{
		if(!isdefined(self.var_4B16))
		{
			break;
		}

		if(!level.player.var_D4AB)
		{
			level.player playgestureviewmodel("ges_antigrav_idle");
		}

		var_00 = level.player.origin[2] - self.var_4B16.origin[2];
		var_01 = clamp(100 - var_00 / 100,0,1);
		var_02 = 50 * var_01;
		var_03 = self getvelocity();
		var_04 = (0,0,1);
		var_05 = var_03 + var_04 * var_02;
		self setvelocity(var_05);
		wait(0.05);
	}

	level.player stopgestureviewmodel("ges_antigrav_reaction");
	level.player stopgestureviewmodel("ges_antigrav_idle");
	lib_0E4F::func_40A6();
	if(isdefined(level.player.var_9BF5))
	{
		while(level.player.var_9BF5 == 1)
		{
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 25
func_CF65()
{
	thread func_CF66();
	self endon("antigrav_reaction_think_timeout");
	self endon("death");
	for(;;)
	{
		level.player waittill("gesture_stopped",var_00);
		if(var_00 == "ges_antigrav_reaction")
		{
			break;
		}
	}

	if(isdefined(self.var_D4AB))
	{
		self.var_D4AB = 0;
	}
}

//Function Number: 26
func_CF66()
{
	self endon("death");
	wait(5);
	self notify("antigrav_reaction_think_timeout");
	if(isdefined(self.var_D4AB))
	{
		self.var_D4AB = 0;
	}
}

//Function Number: 27
func_CF67()
{
	level.player endon("death");
	level.player endon("disable_player_antigrav_gren");
	for(;;)
	{
		level waittill("ai_killed",var_00,var_01);
		if(isdefined(level.player.var_4B16) && isdefined(level.player.var_4B16.var_D43A) && level.player.var_4B16.var_D43A == 1)
		{
			if(isdefined(var_00) && isdefined(var_00.team) && var_00.team == "axis")
			{
				if(isdefined(var_01) && var_01 == level.player)
				{
					break;
				}
			}
		}
	}

	scripts\sp\_utility::func_834F("ANTI_GRAV_KILL");
}

//Function Number: 28
func_36E1()
{
	var_00 = self.origin;
	self.var_378E = [];
	for(var_01 = 0;var_01 < 12;var_01++)
	{
		var_02 = 30 * var_01;
		var_03 = self.var_85D2;
		var_04 = func_378C(var_00,var_02,var_03);
		if(isdefined(var_04))
		{
			var_05 = spawnstruct();
			var_05.origin = var_04;
			var_05.var_5F15 = 0;
			if(var_04[2] + 256 < var_00[2])
			{
				var_05.var_5F15 = 1;
			}

			self.var_378E[self.var_378E.size] = var_05;
		}
	}

	return self.var_378E;
}

//Function Number: 29
func_1066C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = self.origin;
	var_02 = [];
	self.var_378D = [];
	for(var_03 = 0;var_03 < self.var_378E.size;var_03++)
	{
		var_04 = 0;
		var_05 = 0;
		if(var_03 > 0)
		{
			var_05 = var_03 - 1;
		}
		else
		{
			var_05 = self.var_378E.size - 1;
		}

		if(var_03 < self.var_378E.size - 1)
		{
			var_04 = var_03 + 1;
		}
		else
		{
			var_04 = 0;
		}

		var_06 = self.var_378E[var_04].origin;
		var_07 = self.var_378E[var_05].origin;
		var_08 = scripts\common\utility::func_6EE6(vectornormalize(var_07 - var_06));
		var_09 = rotatevector(var_08,(0,-90,0));
		if(length(var_09) == 0)
		{
			var_09 = vectornormalize(var_01 - self.var_378E[var_03].origin);
			if(length(var_09) == 0)
			{
				var_09 = (0,0,1);
			}
		}

		if(param_00)
		{
			self.var_378E[var_03].var_5F15 = 1;
		}

		self.var_378D[self.var_378D.size] = func_1066B(var_01,self.var_378E[var_03].origin,var_09,self.var_378E[var_03].var_5F15);
	}

	if(!param_00)
	{
		if(!self.var_5F37)
		{
			if(level.var_2006.var_522B.size > 1)
			{
				var_0A = "antigrav_area_small_cheap";
			}
			else
			{
				var_0A = "antigrav_area_small";
			}
		}
		else if(level.var_2006.var_522B.size > 1)
		{
			var_0A = "antigrav_area_small_up_cheap";
		}
		else
		{
			var_0A = "antigrav_area_small_up";
		}

		if(scripts\common\utility::func_6E34("in_vr_mode") && scripts\common\utility::flag("in_vr_mode"))
		{
			var_0B = spawnfx(level._effect[var_0A],var_01,(1,0,0),(0,0,1));
			func_C0A7(0.55,::triggerfx,var_0B);
			self.var_132AA[self.var_132AA.size] = var_0B;
		}
		else
		{
			func_C0A7(0.55,::playfx,level._effect[var_0A],var_01,(1,0,0),(0,0,1));
		}

		var_0C = self.var_85D2 * 0.4;
		var_0D = 0;
		for(var_03 = 0;var_03 < self.var_378E.size;var_03++)
		{
			if(self.var_378E[var_03].var_5F15)
			{
				continue;
			}

			var_0E = distance(self.var_378E[var_03].origin,var_01);
			var_0F = vectornormalize(self.var_378E[var_03].origin - var_01);
			if(self.var_378E[var_03].origin[2] < var_01[2])
			{
				var_0F = scripts\common\utility::func_6EE6(var_0F);
			}

			var_10 = anglestoright(vectortoangles(var_0F));
			var_11 = var_0C;
			var_12 = [];
			var_13 = 0;
			while(var_11 < var_0E)
			{
				if(var_13 == 0 && !var_0D)
				{
					var_14 = 0;
					var_12[var_12.size] = scripts\common\utility::func_5D14(var_01 + rotatevector(var_0F,(0,var_14,0)) * var_11,12,-1000);
				}
				else if(var_13 == 1)
				{
					var_14 = 0;
					var_12[var_12.size] = scripts\common\utility::func_5D14(var_01 + rotatevector(var_0F,(0,var_14,0)) * var_11,12,-1000);
				}

				var_13++;
				var_11 = var_11 + var_0C;
			}

			foreach(var_16 in var_12)
			{
				var_17 = [0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4];
				var_18 = randomint(8);
				var_19 = 0.35 + var_17[var_18];
				var_1A = rotatevector((1,0,0),(0,randomfloat(360),0));
				if(scripts\common\utility::func_6E34("in_vr_mode") && scripts\common\utility::flag("in_vr_mode"))
				{
					var_0B = spawnfx(level._effect[var_0A],var_16 + (0,0,6),var_1A,(0,0,1));
					func_C0A7(var_19,::triggerfx,var_0B);
					self.var_132AA[self.var_132AA.size] = var_0B;
					continue;
				}

				func_C0A7(var_19,::playfx,level._effect[var_0A],var_16 + (0,0,6),var_1A,(0,0,1));
			}

			var_0D = !var_0D;
		}
	}
}

//Function Number: 30
func_378A(param_00,param_01,param_02)
{
	var_03 = anglestoforward((0,param_01,0));
	var_04 = scripts\common\trace::func_DCF1(param_00 + (0,0,48),param_00 + (0,0,48) + var_03 * param_02,undefined,scripts\common\trace::func_497D());
	return var_04;
}

//Function Number: 31
func_378C(param_00,param_01,param_02)
{
	var_03 = anglestoforward((0,param_01,0));
	var_04 = scripts\common\trace::func_DCED(param_00 + (0,0,48),param_00 + (0,0,48) + var_03 * param_02,undefined,scripts\common\trace::func_497D());
	if(var_04["fraction"] > 0.5)
	{
		var_05 = param_02 * var_04["fraction"] - 12;
		var_06 = param_00 + var_03 * var_05;
		var_07 = scripts\common\utility::func_5D14(var_06,50,-1000);
		return var_07;
	}

	return undefined;
}

//Function Number: 32
func_1066B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = vectornormalize(param_01 - param_00);
	var_05 = param_01;
	var_06 = param_00 + (0,0,2);
	var_07 = spawn("script_model",var_06);
	var_07.angles = (0,0,0);
	var_07.var_132AA = [];
	var_07 setmodel("anti_grav_border_wm");
	var_07 method_83D0(#animtree);
	playfxontag(level._effect["antigrav_caltrop_trail"],var_07,"tag_origin");
	var_08 = randomfloatrange(0.3,0.65);
	thread func_3789(var_07,var_06,var_05,var_08);
	if(!param_03)
	{
		if(!self.var_5F37)
		{
			if(level.var_2006.var_522B.size > 1)
			{
				var_09 = "antigrav_caltrop_barrier_cheap";
			}
			else
			{
				var_09 = "antigrav_caltrop_barrier";
			}
		}
		else if(level.var_2006.var_522B.size > 1)
		{
			var_09 = "antigrav_caltrop_barrier_up_cheap";
		}
		else
		{
			var_09 = "antigrav_caltrop_barrier_up";
		}

		if(scripts\common\utility::func_6E34("in_vr_mode") && scripts\common\utility::flag("in_vr_mode"))
		{
			var_0A = spawnfx(level._effect[var_09],param_01,param_02,(0,0,1));
			func_C0A7(var_08,::triggerfx,var_0A);
			var_07.var_132AA[var_07.var_132AA.size] = var_0A;
		}
		else
		{
			func_C0A7(var_08,::playfx,level._effect[var_09],param_01,param_02,(0,0,1));
		}
	}
	else
	{
		level func_5128(var_08,::func_378B,var_07,param_01,param_02);
	}

	return var_07;
}

//Function Number: 33
func_378B(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(scripts\common\utility::func_6E34("in_vr_mode") && scripts\common\utility::flag("in_vr_mode"))
	{
		var_03 = spawnfx(scripts\common\utility::getfx("antigrav_detonate_dud"),param_01,param_02,(0,0,1));
		triggerfx(var_03);
		param_00.var_132AA[param_00.var_132AA.size] = var_03;
		return;
	}

	playfx(scripts\common\utility::getfx("antigrav_detonate_dud"),param_01,param_02,(0,0,1));
}

//Function Number: 34
func_3789(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	var_04 = vectornormalize(param_02 - param_01);
	var_05 = distance(param_02,param_01);
	var_06 = param_01 + var_04 * var_05;
	var_07 = randomfloatrange(30,70);
	var_08 = param_01 + var_04 * var_05 * 0.15 + (0,0,var_07 * 0.75);
	var_09 = param_01 + var_04 * var_05 * 0.5 + (0,0,var_07);
	var_0A = param_01 + var_04 * var_05 * 0.85 + (0,0,var_07 * 0.75);
	var_0B = param_02;
	var_0C = 0;
	if(param_02[2] < param_01[2] - 50)
	{
		var_0C = 1;
	}

	param_00 method_8269((randomfloatrange(360,900),0,randomfloatrange(360,900)),param_03 - 0.05);
	param_00 moveto(var_08,param_03 / 4,0,0);
	wait(param_03 / 4);
	param_00 moveto(var_09,param_03 / 4,0,0);
	wait(param_03 / 4);
	param_00 moveto(var_0A,param_03 / 4,0,0);
	wait(param_03 / 4);
	param_00 moveto(var_0B,param_03 / 4,0,0);
	wait(param_03 / 4);
	var_0D = 0.2;
	var_0E = randomfloat(5);
	param_00 method_8269((randomfloatrange(-40,40),0,randomfloatrange(-40,40)),var_0D - 0.05);
	param_00 moveto(var_0B + var_04 * var_0E / 2 + (0,0,var_0E),var_0D / 2,0,var_0D / 2);
	wait(var_0D / 2);
	param_00 moveto(var_0B + var_04 * var_0E,var_0D / 2,var_0D / 2,0);
	wait(var_0D / 2);
	func_DFC4(param_00);
}

//Function Number: 35
func_3CB0(param_00,param_01)
{
	if(distance2d(param_00.origin,param_01.origin) <= param_01.var_85D2)
	{
		if(param_00.origin[2] + 256 > param_01.origin[2] && param_00.origin[2] - param_01.origin[2] <= 180)
		{
			var_02 = 48;
			var_03 = 24;
			var_04 = scripts\common\trace::func_DCF1(param_01.origin + (0,0,var_02),param_00.origin + (0,0,var_02),undefined,scripts\common\trace::func_497D());
			if(var_04)
			{
				return 1;
			}

			var_04 = scripts\common\trace::func_DCF1(param_01.origin + (0,0,var_03),param_00.origin + (0,0,var_03),undefined,scripts\common\trace::func_497D());
			if(var_04)
			{
				return 1;
			}

			var_05 = param_00.origin - param_01.origin;
			var_05 = (var_05[0],var_05[1],0);
			var_06 = param_01.origin + (0,0,var_02) + var_05;
			var_04 = scripts\common\trace::func_DCF1(param_01.origin + (0,0,var_02),var_06,undefined,scripts\common\trace::func_497D());
			if(var_04)
			{
				var_04 = scripts\common\trace::func_DCF1(var_06,param_00.origin + (0,0,var_02),undefined,scripts\common\trace::func_497D());
				if(var_04)
				{
					return 1;
				}
			}

			var_05 = param_00.origin - param_01.origin;
			var_05 = (var_05[0],var_05[1],0);
			var_06 = param_01.origin + (0,0,var_03) + var_05;
			var_04 = scripts\common\trace::func_DCF1(param_01.origin + (0,0,var_03),var_06,undefined,scripts\common\trace::func_497D());
			if(var_04)
			{
				var_04 = scripts\common\trace::func_DCF1(var_06,param_00.origin + (0,0,var_03),undefined,scripts\common\trace::func_497D());
				if(var_04)
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 36
func_4933()
{
	var_00 = physics_volumecreate(self.origin,self.var_85D2,180);
	var_00 method_8527(0);
	var_00 method_8529(1);
	var_00 method_8526(1);
	thread func_CB0A(var_00);
	return var_00;
}

//Function Number: 37
func_CB0A(param_00)
{
	param_00 endon("destroy_volume");
	var_01 = -0.15;
	param_00 method_852A(1,var_01);
	wait(0.2);
	param_00 method_852A(1,0);
}

//Function Number: 38
func_52B3(param_00)
{
	param_00 notify("destroy_volume");
	param_00 delete();
}

//Function Number: 39
func_1293()
{
	if(isdefined(self) && isdefined(self.var_202A))
	{
		return 11;
	}

	return 7;
}

//Function Number: 40
func_1294()
{
	if(isdefined(self) && isdefined(self.var_202B))
	{
		return 196;
	}

	return 148;
}

//Function Number: 41
func_C0A7(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_C0A8(param_01,param_00,param_02,param_03,param_04,param_05);
}

//Function Number: 42
func_C0A8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	scripts\common\utility::func_6E59("antigrav_force_delete",param_01);
	if(isdefined(param_05))
	{
		[[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		[[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		[[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		[[ param_00 ]](param_02);
		return;
	}

	[[ param_00 ]]();
}

//Function Number: 43
func_5128(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread scripts\common\utility::func_512D(param_01,param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 44
func_5129(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	self endon("stop_delay_thread");
	scripts\common\utility::func_6E59("antigrav_force_delete",param_01);
	if(isdefined(param_07))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06,param_07);
		return;
	}

	if(isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
		return;
	}

	if(isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	if(isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		thread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(isdefined(param_02))
	{
		thread [[ param_00 ]](param_02);
		return;
	}

	thread [[ param_00 ]]();
}

//Function Number: 45
func_CE2E(param_00)
{
	if(scripts\sp\_utility::func_9BB2())
	{
		return;
	}

	var_01 = spawn("script_origin",self.origin);
	var_01.origin = self.origin;
	var_01.angles = self.angles;
	var_01 linkto(self);
	var_01 playsound(param_00,"sounddone");
	var_01 scripts\common\utility::waittill_any_3("sounddone","antigrav_force_delete");
	var_01 delete();
}