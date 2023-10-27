/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3388.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:54 AM
*******************************************************************/

//Function Number: 1
func_9721()
{
	level.scrambletrapuses = 0;
	var_00 = undefined;
	var_01 = undefined;
	var_02 = scripts\common\utility::getstructarray("scrambler","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_04 thread func_EC9E();
		var_04.var_E5DE = [];
		var_05 = getentarray(var_04.target,"targetname");
		foreach(var_07 in var_05)
		{
			if(var_07.script_noteworthy == "scrambler_center")
			{
				var_04.var_2C09 = var_07;
				continue;
			}

			if(var_07.script_noteworthy == "scrambler_trig")
			{
				var_04.var_1270F = var_07;
				continue;
			}

			if(var_07.script_noteworthy == "scrambler_cars")
			{
				var_04.var_E5DE[var_04.var_E5DE.size] = var_07;
				continue;
			}

			if(var_07.script_noteworthy == "scrambler_clip")
			{
				var_04.clip = var_07;
			}
		}
	}

	var_02[0].var_1270F enablelinkto();
	var_02[0].var_1270F linkto(var_02[0].var_2C09);
	foreach(var_0B in var_02[0].var_E5DE)
	{
		var_0B linkto(var_02[0].var_2C09);
	}

	var_02[0].clip disconnectpaths();
}

//Function Number: 2
func_EC9E()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	var_01 = undefined;
	for(;;)
	{
		var_02 = "power_on";
		if(var_00)
		{
			var_02 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_02 != "power_off")
		{
			self.var_D776 = 1;
			level thread scripts\cp\_vo::func_1769("dj_traps_use_nag","zmb_dj_vo",60,15,2,1);
			var_03 = getent("escape_velocity_main_ride","targetname");
			var_03 setscriptablepartstate("model","on");
			var_03 setscriptablepartstate("fx","idle");
			scripts\common\utility::func_136F7();
			self.var_2C09 setmodel("zmb_escape_velocity_ride_center_activated");
			scripts\common\utility::func_136F7();
			foreach(var_05 in self.var_E5DE)
			{
				var_05 setmodel("zmb_escape_velocity_ride_car");
				scripts\common\utility::func_136F7();
			}

			scripts\common\utility::func_136F7();
			var_07 = getent("escape_velocity_top_lights","targetname");
			var_07 setscriptablepartstate("model","on");
		}
		else
		{
			self.var_D776 = 0;
		}

		wait(0.25);
	}
}

//Function Number: 3
func_1300B(param_00,param_01)
{
	playfx(level._effect["console_spark"],param_00.origin + (0,0,40));
	level.scrambletrapuses++;
	scripts\cp\_interaction::func_554F(param_00);
	param_00.clip connectpaths();
	scripts\common\utility::func_136F7();
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	param_00.var_126A4 = 0;
	param_00.var_126A5 = param_01;
	var_02 = getent("escape_velocity_main_ride","targetname");
	var_02 setscriptablepartstate("fx","active");
	var_02 setscriptablepartstate("model","active");
	param_00.var_2C09 setmodel("zmb_escape_velocity_ride_center_on");
	param_00.var_2C09 rotateyaw(3240,25,5,5);
	param_00 thread func_A631(param_00,param_01);
	param_00 thread func_6734();
	var_03 = 25;
	var_04 = gettime();
	var_05 = var_04 + var_03 * 1000;
	while(gettime() < var_05)
	{
		wait(1);
	}

	var_02 setscriptablepartstate("fx","idle");
	param_00.var_2C09 setmodel("zmb_escape_velocity_ride_center_activated");
	var_02 setscriptablepartstate("model","on");
	param_00 notify("stop_dmg");
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		param_01.var_1189F = param_00.var_126A4;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	scripts\common\utility::func_136F7();
	param_00.clip disconnectpaths();
	wait(3);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.scrambletrapuses * 45,45));
}

//Function Number: 4
func_A631(param_00,param_01)
{
	self endon("stop_dmg");
	var_02 = param_00.var_1270F;
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(!isplayer(var_03) && !scripts\cp\_utility::func_FF18(var_03,undefined,1) && isdefined(var_03.agent_type) && var_03.agent_type != "zombie_brute")
		{
			continue;
		}

		if(!isdefined(var_03.agent_type) && !isplayer(var_03))
		{
			continue;
		}

		if(isplayer(var_03))
		{
			var_03 dodamage(25,self.var_2C09.origin);
			var_03 setvelocity(vectornormalize(var_03.origin - self.var_2C09.origin) * 500);
			continue;
		}

		if(var_03.agent_type == "zombie_brute" || var_03.team == "allies")
		{
			if(var_03.agent_type == "zombie_brute")
			{
				var_03 notify("no_path_to_targets");
			}
			else
			{
				var_03 setvelocity(vectornormalize(var_03.origin - self.var_2C09.origin) * 500);
			}

			continue;
		}

		if(isdefined(var_03.flung))
		{
			continue;
		}

		var_04 = self.var_2C09;
		var_03.flung = 1;
		param_00.var_126A4 = param_00.var_126A4 + 2;
		if(isdefined(param_01))
		{
			if(!isdefined(param_01.trapkills["trap_spin"]))
			{
				param_01.trapkills["trap_spin"] = 1;
			}
			else
			{
				param_01.trapkills["trap_spin"]++;
			}

			var_05 = ["kill_trap_generic","kill_trap_spin"];
			param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo","highest",10,0,0,1,10);
		}

		if(scripts\common\utility::istrue(var_03.var_9CDD))
		{
			if(!isdefined(level.var_10A04))
			{
				level.var_10A04 = 0;
			}

			level.var_10A04++;
			var_03 dodamage(var_03.health + 1000,var_04.origin,param_01,param_01,"MOD_UNKNOWN","iw7_escapevelocity_zm");
			var_03 thread func_6F32(var_04,param_01);
		}
		else
		{
			var_03 dodamage(var_03.health + 1000,var_04.origin,param_01,param_01,"MOD_UNKNOWN","iw7_escapevelocity_zm");
			var_03 thread func_6F32(var_04,undefined);
		}
	}
}

//Function Number: 5
func_6F32(param_00,param_01)
{
	self endon("death");
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	playfx(level._effect["blackhole_trap_death"],self.origin,anglestoforward((-90,0,0)),anglestoup((-90,0,0)));
	wait(0.05);
	self setvelocity(vectornormalize(self.origin - param_00.origin) * 200 + (0,0,300));
	wait(0.1);
	if(!isdefined(level.var_10A04))
	{
		level.var_10A04 = 0;
	}

	level.var_10A04++;
	self dodamage(self.health + 1000,param_00.origin,param_01,param_01,"MOD_UNKNOWN","iw7_escapevelocity_zm");
}

//Function Number: 6
func_6734()
{
	self endon("stop_dmg");
	var_00 = scripts\common\utility::getstructarray("escape_velocity_attractors","targetname");
	var_01 = getent("escape_velocity_volume","targetname");
	for(;;)
	{
		var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_02 = scripts\common\utility::func_782F(self.var_2C09.origin,var_02);
		foreach(var_04 in var_02)
		{
			if(var_04 istouching(var_01))
			{
				if(!scripts\cp\_utility::func_FF18(var_04) || var_04.var_EF64)
				{
					continue;
				}

				var_04 thread func_8404(var_00,self);
				var_04 thread func_DF46(self);
				scripts\common\utility::func_136F7();
			}
		}

		wait(0.1);
	}
}

//Function Number: 7
func_8404(param_00,param_01)
{
	param_01 endon("stop_dmg");
	self endon("death");
	self.var_EF64 = 1;
	self.var_C37F = self.var_15C;
	self.var_15C = 32;
	self method_82EF(scripts\common\utility::getclosest(self.origin,param_00).origin);
	scripts\common\utility::waittill_any_3("goal","goal_reached");
	self.var_EF64 = 0;
}

//Function Number: 8
func_DF46(param_00)
{
	self endon("death");
	param_00 waittill("stop_dmg");
	if(isdefined(self.var_C37F))
	{
		self.var_15C = self.var_C37F;
	}

	self.var_C37F = undefined;
	self.var_EF64 = 0;
}