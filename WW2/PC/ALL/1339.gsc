/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1339.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 3:25:26 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	self.var_983B = 0;
	level.var_611["taunt_burst_aoe"] = loadfx("vfx/zombie/abilities_perks/zmb_storm_taunt_aoe");
	level.var_611["taunt_lure"] = loadfx("vfx/zombie/abilities_perks/zmb_storm_zmb_lure");
	level.var_611["zmb_moon_zmb_instakill"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_zmb_instakill");
	level.var_611["zmb_death_hand_to_hand_melee_hit"] = loadfx("vfx/zombie/abilities_perks/zmb_death_hand_to_hand_melee_hit");
}

//Function Number: 2
func_3662()
{
	maps\mp\zombies\_zombies_roles::func_6AB2("role_ability_taunt_zm");
	self.var_983B = 1;
	var_00 = self.var_116;
	var_01 = 0;
	playfx(common_scripts\utility::func_44F5("taunt_burst_aoe"),var_00 + (0,0,var_01));
	lib_0378::func_8D74("aud_taunt_use");
	var_02 = lib_0547::func_408F();
	foreach(var_04 in var_02)
	{
		thread func_983E(var_04);
	}

	if(lib_0547::func_4BA7("specialty_class_improvised_def_zm"))
	{
		var_06 = lib_0547::func_73E9() + 2;
		lib_0547::func_7454(int(min(var_06,3)));
	}

	if(lib_0547::func_4BA7("specialty_class_resilient_zm"))
	{
		self.var_98E1 = 1;
	}

	if(lib_0547::func_4BA7("specialty_class_team_effort_zm"))
	{
		foreach(var_08 in level.var_744A)
		{
			if(var_08 == self)
			{
				continue;
			}

			var_08 luinotifyeventextraplayer(&"add_teammate_mod_buffs",3,"specialty_class_team_effort_zm",0,self);
		}
	}

	thread func_A95A();
}

//Function Number: 3
func_2F9E()
{
	if(common_scripts\utility::func_562E(self.var_983B))
	{
		self notify("taunt_expired");
		self.var_983B = 0;
		if(lib_0547::func_4BA7("specialty_class_resilient_zm"))
		{
			self.var_98E1 = undefined;
		}

		if(lib_0547::func_4BA7("specialty_class_team_effort_zm"))
		{
			foreach(var_01 in level.var_744A)
			{
				if(var_01 == self)
				{
					continue;
				}

				var_01 luinotifyeventextraplayer(&"remove_teammate_mod_buffs",1,"specialty_class_team_effort_zm");
			}
		}
	}
}

//Function Number: 4
func_983E(param_00)
{
	if(common_scripts\utility::func_562E(param_00.var_57FD))
	{
		return;
	}

	param_00 endon("death");
	self endon("disconnect");
	thread handlezombietauntfx(param_00,"taunt_lure","J_Spine4",1.5);
	param_00 maps/mp/agents/humanoid/_humanoid_util::func_867E(self);
	param_00 notify("watchFavoriteEnemyDeath");
	if(!isdefined(param_00.var_983C))
	{
		param_00.var_983C = [];
	}

	param_00.var_983C = common_scripts\utility::func_F6F(param_00.var_983C,self);
	common_scripts\utility::knock_off_battery("taunt_expired","disconnect");
	param_00 maps/mp/agents/humanoid/_humanoid_util::func_867E(undefined);
	param_00.var_983C = common_scripts\utility::func_F93(param_00.var_983C,self);
}

//Function Number: 5
handlezombietauntfx(param_00,param_01,param_02,param_03)
{
	param_00 notify("taunt_fx_thread");
	self endon("disconnect");
	self endon("taunt_expired");
	param_00 endon("death");
	param_00 endon("taunt_fx_thread");
	for(;;)
	{
		var_04 = gettime() / 1000;
		if(isdefined(self.recenttauntfxtime) && var_04 - param_00.recenttauntfxtime < param_03)
		{
			wait(param_03 - var_04 - param_00.recenttauntfxtime);
		}

		playfxontag(common_scripts\utility::func_44F5(param_01),param_00,param_02);
		param_00.recenttauntfxtime = var_04;
		wait(param_03);
	}
}

//Function Number: 6
func_A95A()
{
	self endon("taunt_expired");
	for(;;)
	{
		level waittill("zombie_spawned",var_00);
		thread func_983E(var_00);
	}
}

//Function Number: 7
func_62A6(param_00,param_01,param_02)
{
	var_03 = 1;
	if(!common_scripts\utility::func_562E(self.var_57FD) && isdefined(self.var_983C))
	{
		foreach(var_05 in self.var_983C)
		{
			var_06 = 2;
			if(var_05 lib_0547::func_4BA7("specialty_class_counter_offensive_zm"))
			{
				var_06 = 3;
			}

			if(var_05 lib_0547::func_4BA7("specialty_class_team_effort_zm"))
			{
				var_03 = max(var_06,var_03);
			}

			if(var_05 == param_01)
			{
				var_03 = max(var_06,var_03);
			}
		}

		if(maps\mp\_utility::func_5755(param_02) && common_scripts\utility::func_562E(param_01.var_983B) && param_01 lib_0547::func_4BA7("specialty_class_come_get_zm"))
		{
			var_03 = var_03 * 4;
			thread play_crit_melee_effects();
			param_01 luinotifyeventextraplayer(&"trigger_mod_proc",1,"specialty_class_come_get_zm");
		}
	}

	if(isdefined(var_03))
	{
		param_00 = param_00 * var_03;
	}

	return param_00;
}

//Function Number: 8
play_crit_melee_effects()
{
	self waittill("body_spawned",var_00);
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = spawnlinkedfx(level.var_611["zmb_death_hand_to_hand_melee_hit"],var_00,"J_Head");
	triggerfx(var_01);
	wait(1);
	var_01 delete();
}

//Function Number: 9
func_6B73(param_00)
{
	if(isdefined(param_00) && isai(param_00) && common_scripts\utility::func_562E(self.var_983B) && lib_0547::func_4BA7("specialty_class_hit_em_hard_zm"))
	{
		playfx(level.var_611["zmb_moon_zmb_instakill"],param_00.var_116 + (0,0,40));
		var_01 = param_00.var_BC + 1;
		var_02 = 0;
		if(isdefined(param_00.var_A4B))
		{
			switch(param_00.var_A4B)
			{
				case "zombie_heavy":
				case "zombie_boss_village":
				case "zombie_fireman":
					var_02 = 1;
					break;
			}
		}

		if(common_scripts\utility::func_562E(param_00.var_55AB))
		{
			var_02 = 1;
		}

		if(var_02)
		{
			var_01 = maps/mp/gametypes/zombies::func_1E59(lib_0547::func_A51("zombie_generic"),level.var_A980);
		}

		param_00 thread func_AB11(0.1,var_01,param_00.var_116,self,undefined,undefined,"hitem_hard_zm");
		self luinotifyeventextraplayer(&"trigger_mod_proc",1,"specialty_class_hit_em_hard_zm");
	}
}

//Function Number: 10
func_AB11(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(!isdefined(param_00) || param_00 < 0.05)
	{
		param_00 = 1;
	}

	wait(param_00);
	self dodamage(param_01,param_02,param_03,param_04,param_05,param_06);
}