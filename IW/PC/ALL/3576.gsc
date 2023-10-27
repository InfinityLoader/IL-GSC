/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3576.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:30:46 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["vfx_phase_shift_trail_friendly"] = loadfx("vfx/iw7/_requests/mp/vfx_phase_shift_body_fr.vfx");
	level._effect["vfx_phase_shift_trail_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_phase_shift_body_en.vfx");
	level._effect["vfx_screen_flash"] = loadfx("vfx/core/mp/core/vfx_screen_flash");
}

//Function Number: 2
func_E154(param_00)
{
	if(scripts\mp\_utility::func_9FB3(self.phaseshift_active))
	{
		if(!scripts\mp\_utility::func_9FB3(param_00))
		{
			if(scripts\mp\_utility::_hasperk("specialty_ftlslide"))
			{
				if(scripts\mp\_utility::func_9D46() && level.tactical)
				{
					self method_845A("assassin_mlgslide_mp_tactical");
				}
				else if(scripts\mp\_utility::func_9D46())
				{
					self method_845A("assassin_mlgslide_mp");
				}
				else if(level.tactical)
				{
					self method_845A("assassin_slide_mp_tactical");
				}
				else
				{
					self method_845A("assassin_slide_mp");
				}
			}
			else
			{
				self method_845A("assassin_mp");
			}

			if(scripts\mp\_utility::func_9FB3(self.phaseshift_removedtracker))
			{
				scripts\mp\_utility::func_8387("specialty_tracker");
			}

			scripts\mp\_utility::func_E150("specialty_blindeye");
			scripts\mp\_utility::func_E150("specialty_radarringresist");
			scripts\common\utility::func_1C58(1);
			scripts\common\utility::func_1C6E(1);
			scripts\mp\_utility::func_1C47(1);
			self.var_38ED = 1;
			self setscriptablepartstate("compassicon","defaulticon",0);
			scripts\mp\_utility::func_8ECC();
			self playlocalsound("ftl_phase_in");
			self playsound("ftl_phase_in_npc");
			self visionsetnakedforplayer("",0.1);
		}
		else
		{
			self visionsetnakedforplayer("",0);
		}

		self method_8070(0.1);
		func_F7E3(0);
		thread restartweaponvfx();
		self.phaseshift_active = undefined;
		self.phaseshift_removedtracker = undefined;
	}
}

//Function Number: 3
func_E88D()
{
	if(!scripts\mp\_utility::func_9FB3(self.phaseshift_active))
	{
		func_6626(0,4);
		return 1;
	}

	return 0;
}

//Function Number: 4
func_6626(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	self method_845A("assassin_mp_phase");
	self notify("phase_shift_start");
	thread func_4524(3);
	func_F7E3(1);
	thread restartweaponvfx();
	self visionsetnakedforplayer("phase_shift_mp",0.1);
	self playlocalsound("ftl_phase_out");
	self playsound("ftl_phase_out_npc");
	func_2A71(self,param_01);
	self method_82C0("phaseshift_mp_shock",0.1);
	scripts\common\utility::func_1C58(0);
	lib_0DF7::func_CA2A();
	self setscriptablepartstate("compassicon","hideIcon",0);
	scripts\mp\_utility::func_8ECD();
	scripts\mp\_utility::func_8387("specialty_blindeye");
	scripts\mp\_utility::func_8387("specialty_radarringresist");
	scripts\common\utility::func_1C6E(0);
	scripts\mp\_utility::func_1C47(0);
	self.var_38ED = 0;
	if(scripts\mp\_utility::_hasperk("specialty_tracker"))
	{
		scripts\mp\_utility::func_E150("specialty_tracker");
		self.phaseshift_removedtracker = 1;
	}

	self.phaseshift_active = 1;
}

//Function Number: 5
restartweaponvfx()
{
	self endon("death");
	self endon("disconnect");
	self notify("startWeaponVFX");
	self endon("restartWeaponVFX");
	var_00 = self getcurrentprimaryweapon();
	scripts\mp\_weapons::clearweaponscriptvfx(var_00,scripts\mp\_utility::func_9FB3(self method_8519(var_00)));
	scripts\common\utility::func_136F7();
	var_00 = self getcurrentprimaryweapon();
	scripts\mp\_weapons::runweaponscriptvfx(var_00,scripts\mp\_utility::func_9FB3(self method_8519(var_00)));
}

//Function Number: 6
func_6978(param_00)
{
}

//Function Number: 7
func_10918(param_00)
{
	var_01 = spawn("script_model",self.origin);
	var_01 setmodel("tag_origin");
	if(getdvarint("bg_thirdPerson") == 0)
	{
		var_01 method_8429(self);
	}

	wait(0.1);
	function_029A(scripts\common\utility::getfx(param_00 + "_friendly"),var_01,"tag_origin",self.team);
	function_029A(scripts\common\utility::getfx(param_00),var_01,"tag_origin",scripts\mp\_utility::getotherteam(self.team));
	wait(0.15);
	var_01 delete();
}

//Function Number: 8
func_108EE(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawn("script_model",param_01.origin);
	var_05.angles = param_01.angles;
	var_05 setmodel("tag_origin");
	var_05.var_222 = param_01;
	var_05.var_CACB = param_02;
	var_05.var_762C = param_00;
	wait(0.1);
	if(param_01 == param_02)
	{
		function_029A(param_00,var_05,"tag_origin",param_03);
		var_05 method_8429(param_02);
	}
	else
	{
		playfxontagforclients(param_00,var_05,"tag_origin",param_02);
	}

	var_05 thread func_12EEA(param_04);
}

//Function Number: 9
func_2A71(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.team == "allies")
	{
		var_02 = "axis";
	}
	else if(param_00.team == "axis")
	{
		var_02 = "allies";
	}
	else
	{
	}

	thread func_108EE(scripts\common\utility::getfx("vfx_phase_shift_trail_enemy"),param_00,param_00,var_02,param_01);
	var_03 = scripts\common\utility::func_116D7(level.teambased,scripts\common\utility::getfx("vfx_phase_shift_trail_friendly"),scripts\common\utility::getfx("vfx_phase_shift_trail_enemy"));
	thread func_108EE(var_03,param_00,param_00,param_00.team,param_01);
	foreach(var_05 in level.players)
	{
		if(var_05 == param_00)
		{
			continue;
		}

		var_06 = scripts\common\utility::func_116D7(level.teambased && var_05.team == param_00.team,scripts\common\utility::getfx("vfx_phase_shift_trail_friendly"),scripts\common\utility::getfx("vfx_phase_shift_trail_enemy"));
		thread func_108EE(var_06,var_05,param_00,param_00.team,param_01);
	}
}

//Function Number: 10
func_12EEA(param_00)
{
	var_01 = 0;
	var_02 = 0.15;
	for(;;)
	{
		if(!isdefined(self) || !isdefined(self.var_222) || !scripts\mp\_utility::func_9F19(self.var_222) || !isdefined(self.var_CACB) || !scripts\mp\_utility::func_9F19(self.var_CACB) || !func_9DDF(self.var_CACB) || var_01 > param_00)
		{
			self.origin = self.origin + (0,0,10000);
			wait(0.2);
			self delete();
			return;
		}

		var_01 = var_01 + var_02;
		if(self.var_CACB == self.var_222)
		{
			foreach(var_04 in level.players)
			{
				if(!func_213D(var_04,self.var_222))
				{
					self showtoplayer(var_04);
					continue;
				}

				self method_8429(var_04);
			}
		}
		else
		{
			foreach(var_04 in level.players)
			{
				if(!func_213D(var_04,self.var_222))
				{
					self showtoplayer(self.var_222);
					continue;
				}

				self method_8429(self.var_222);
			}
		}

		self moveto(self.var_222.origin,var_02);
		wait(var_02);
	}
}

//Function Number: 11
func_9DDF(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = (isplayer(param_00) || isagent(param_00)) && param_00 method_84D9();
	var_02 = isdefined(param_00.var_FF03) && param_00.var_FF03 == 1;
	return var_01 || var_02;
}

//Function Number: 12
func_213D(param_00,param_01)
{
	var_02 = func_9DDF(param_00);
	var_03 = func_9DDF(param_01);
	return (var_02 && var_03) || !var_03 && !var_02;
}

//Function Number: 13
func_F7E3(param_00)
{
	return self method_84D8(param_00);
}

//Function Number: 14
func_4524(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("confuseBotsOnTeleport");
	self endon("confuseBotsOnTeleport");
	scripts\mp\_utility::_enableignoreme();
	wait(param_00);
	scripts\mp\_utility::_disableignoreme();
}