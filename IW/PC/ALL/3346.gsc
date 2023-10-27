/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3346.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:26:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["vfx_phase_shift_start"] = loadfx("vfx/old/_requests/archetypes/vfx_phase_shift_start_volume");
	level._effect["vfx_phase_shift_end"] = loadfx("vfx/old/_requests/archetypes/vfx_phase_shift_start_volume");
	level._effect["vfx_phase_shift_start_friendly"] = loadfx("vfx/old/_requests/archetypes/vfx_phase_shift_start_volume_blue");
	level._effect["vfx_phase_shift_end_friendly"] = loadfx("vfx/old/_requests/archetypes/vfx_phase_shift_start_volume_blue");
	level._effect["vfx_phase_shift_trail_friendly"] = loadfx("vfx/iw7/_requests/mp/vfx_phase_shift_body_fr.vfx");
	level._effect["vfx_phase_shift_trail_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_phase_shift_body_en.vfx");
	level._effect["vfx_screen_flash"] = loadfx("vfx/core/mp/core/vfx_screen_flash");
	level._effect["vfx_phaseshift_fp_scrn"] = loadfx("vfx/iw7/_requests/mp/vfx_phase_shift_scrn_warp.vfx");
}

//Function Number: 2
func_E154()
{
	self notify("remove_phase_shift");
	if(func_9DDF(self))
	{
		func_6978(0);
	}
}

//Function Number: 3
func_E88D()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_phase_shift");
	var_00 = 5;
	self notify("phase_shift_power_activated");
	if(!func_9DDF(self))
	{
		func_6626(1,var_00);
	}

	scripts\cp\powers\coop_powers::func_4575(var_00,"powers_phase_shift_update","phaseshift_interrupted");
	func_6978();
	wait(0.1);
}

//Function Number: 4
func_6626(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = 5;
	}

	self notify("phase_shift_start");
	func_F7E3(1);
	scripts\cp\powers\coop_powers::func_160E("power_phaseShift");
	if(getdvarint("bg_thirdPerson") == 0)
	{
		self visionsetnakedforplayer("phase_shift_mp",scripts\common\utility::func_116D7(param_00,0.1,0));
		if(param_00)
		{
			thread func_5AA3();
		}

		thread func_1090A(param_01);
	}

	self playlocalsound("ftl_phase_out");
	self playsound("ftl_phase_out_npc");
	func_2A71(self,param_01);
	self method_82C0("phaseshift_mp_shock",0.1);
	thread func_13A57();
	scripts\cp\_utility::func_1C5C(1);
	if(!scripts\common\utility::istrue(level.var_C00B))
	{
		scripts\cp\powers\coop_powers::func_D740(0);
	}

	if(!scripts\common\utility::istrue(self.var_13DB4))
	{
		self method_80A8();
	}

	scripts\cp\_utility::func_1C5D(0);
	scripts\cp\powers\coop_powers::func_D728();
	self.var_8BAE = 1;
}

//Function Number: 5
func_6978(param_00)
{
	self notify("phase_shift_completed");
	self playanimscriptevent("power_exit","phaseshift");
	self playlocalsound("ftl_phase_in");
	self playsound("ftl_phase_in_npc");
	if(getdvarint("bg_thirdPerson") == 0)
	{
		if(!isdefined(param_00) || param_00)
		{
			func_5AA3();
		}
	}

	func_410A();
	self method_8070(0.1);
}

//Function Number: 6
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
	function_029A(scripts\common\utility::getfx(param_00),var_01,"tag_origin",scripts\cp\_utility::getotherteam(self.team));
	wait(0.15);
	var_01 delete();
}

//Function Number: 7
func_1090A(param_00)
{
	var_01 = function_01E1(scripts\common\utility::getfx("vfx_phaseshift_fp_scrn"),(0,0,0),self);
	var_01 method_82EC();
	triggerfx(var_01);
	scripts\common\utility::waittill_any_timeout_1(param_00,"death","phase_shift_completed");
	var_01 delete();
}

//Function Number: 8
func_410A()
{
	self visionsetnakedforplayer("",0);
	self.var_8BAE = 0;
	if(!scripts\common\utility::istrue(level.var_C00B) || scripts\cp\_utility::func_9BA0("grenade_cooldown"))
	{
		scripts\cp\powers\coop_powers::func_D74E();
	}

	if(scripts\cp\_utility::func_9E3A())
	{
		scripts\cp\_utility::func_1C5C(0);
	}

	scripts\cp\powers\coop_powers::func_4DE0("power_phaseShift");
	if(!scripts\cp\_utility::func_213E())
	{
		scripts\cp\_utility::func_1C5D(1);
	}

	self method_80DA();
	scripts\cp\powers\coop_powers::func_D72E();
	func_F7E3(0);
}

//Function Number: 9
func_13A57()
{
	self endon("disconnect");
	self endon("phase_shift_completed");
	scripts\common\utility::waittill_any_3("death","remove_phase_shift");
	func_410A();
}

//Function Number: 10
func_108EE(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawn("script_model",param_01.origin);
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

//Function Number: 11
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

//Function Number: 12
func_12EEA(param_00)
{
	var_01 = 0;
	var_02 = 0.15;
	for(;;)
	{
		if(!isdefined(self) || !isdefined(self.var_222) || !scripts\cp\_utility::func_9F19(self.var_222) || !isdefined(self.var_CACB) || !scripts\cp\_utility::func_9F19(self.var_CACB) || !func_9DDF(self.var_CACB) || var_01 > param_00)
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

//Function Number: 13
func_5AA3()
{
	scripts\common\utility::func_136F7();
	if(isdefined(self))
	{
		playfxontagforclients(scripts\common\utility::getfx("vfx_screen_flash"),self,"tag_eye",self);
	}
}

//Function Number: 14
func_9DDF(param_00)
{
	return isdefined(param_00) && isplayer(param_00) || isagent(param_00) && param_00 method_84D9();
}

//Function Number: 15
func_213D(param_00,param_01)
{
	var_02 = func_9DDF(param_00);
	var_03 = func_9DDF(param_01);
	return (var_02 && var_03) || !var_03 && !var_02;
}

//Function Number: 16
func_F7E3(param_00)
{
	return self method_84D8(param_00);
}

//Function Number: 17
func_C771()
{
	self endon("disconnect");
	level endon("game_ended");
	while(func_9DDF(self))
	{
		var_00 = scripts\cp\_agent_utils::func_7DB0("axis");
		foreach(var_03, var_02 in var_00)
		{
			if(!isalive(var_02))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.var_CA80))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(level.var_A71C) && var_02 == level.var_A71C)
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.agent_type) && var_02.agent_type == "kraken_tentacle")
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.agent_type) && var_02.agent_type == "spawn_tentacle")
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.agent_type) && var_02.agent_type == "spider")
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.var_4D32))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.var_B36D))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.var_B36A))
			{
				scripts\cp\_outline::func_6220(var_02,self,1,0,0,"high");
				wait(0.2);
				continue;
			}

			if(isdefined(var_02.var_6BD4))
			{
				wait(0.2);
				continue;
			}

			if(func_9DDF(self))
			{
				scripts\cp\_outline::func_6220(var_02,self,2,0,0,"high");
				wait(0.2);
				continue;
			}

			if(isdefined(self.var_9DF2) && self.var_9DF2 == 1)
			{
				wait(0.2);
				continue;
			}

			if(var_03 % 2 == 0)
			{
				wait(0.05);
			}
		}

		wait(0.25);
	}

	scripts\cp\_outline::func_12C01();
}

//Function Number: 18
func_135FA()
{
	self endon("death");
	self endon("disconnect");
	self endon("exit_phase_shift");
	for(;;)
	{
		if(!isdefined(self))
		{
			wait(1);
			break;
		}

		self waittill("power_secondary_used");
		break;
	}

	self notify("exit_phase_shift");
}

//Function Number: 19
func_E830()
{
	var_00 = self getcurrentweapon();
	scripts\common\utility::func_1C76(0);
	scripts\cp\_utility::func_12C6("phaseshift_activation_mp");
	self method_83B6("phaseshift_activation_mp");
	scripts\common\utility::func_136F7();
	self switchtoweapon(var_00);
	wait(0.2);
	scripts\common\utility::func_1C76(1);
	self takeweapon("phaseshift_activation_mp");
}