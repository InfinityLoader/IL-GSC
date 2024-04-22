/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _microwave_grenade.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 301 ms
 * Timestamp: 4/22/2024 2:21:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_microwave_grenade();
}

//Function Number: 2
init_microwave_grenade()
{
	precacheitem("microwave_grenade");
	precacheshellshock("flashbang");
	precache_microwave_grenade_fx();
	precache_microwave_anims();
	start_monitor_microwave_grenades();
}

//Function Number: 3
precache_microwave_grenade_fx()
{
	level._effect["microwave_grenade"] = loadfx("vfx/explosion/microwave_grenade_exp");
	level._effect["microwave_grenade_sparks_1"] = loadfx("vfx/sparks/microwave_grenade_sparks_1");
	level._effect["microwave_grenade_sparks_char_1"] = loadfx("vfx/sparks/microwave_grenade_sparks_char_1");
}

//Function Number: 4
precache_microwave_anims()
{
	level.scr_anim["generic"]["microwave_react1"] = %teargas_react_1;
	level.scr_anim["generic"]["microwave_react2"] = %teargas_react_2;
	level.scr_anim["generic"]["microwave_react3"] = %teargas_react_3;
	level.scr_anim["generic"]["microwave_run1"][0] = %teargas_run_6;
	level.scr_anim["generic"]["microwave_run2"][0] = %teargas_run_7;
	level.scr_anim["generic"]["microwave_run3"][0] = %teargas_run_8;
}

//Function Number: 5
start_monitor_microwave_grenades()
{
	maps\_utility::add_global_spawn_function("axis",::monitor_microwave_grenades);
	maps\_utility::add_global_spawn_function("allies",::monitor_microwave_grenades);
	foreach(var_01 in level.players)
	{
		var_01 thread monitor_microwave_grenades();
	}
}

//Function Number: 6
monitor_microwave_grenades()
{
	self endon("death");
	for(;;)
	{
		var_00 = undefined;
		var_01 = undefined;
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00))
		{
			if(isdefined(var_01))
			{
				if(var_01 == "microwave_grenade")
				{
					var_00.team = self.team;
					var_00 thread microwave_grenade_explode_wait();
				}
			}
		}
	}
}

//Function Number: 7
microwave_grenade_explode_wait()
{
	self waittill("explode",var_00);
	if(isdefined(self.team))
	{
		maps\_dds::dds_notify("react_microwave",self.team != "allies");
	}
	else
	{
		maps\_dds::dds_notify("react_microwave",1);
	}

	thread soundscripts\_snd_common::aud_microwave_grenade();
	playfx(common_scripts\utility::getfx("microwave_grenade"),self.origin);
	thread play_microwave_sparkfx(self.origin);
	thread play_microwave_physics(self.origin);
	thread player_screen_flash(1.5);
	thread microwave_grenade_ai_flee_pulse();
}

//Function Number: 8
microwave_grenade_ai_flee_pulse()
{
	self endon("death");
	var_00 = 90000;
	badplace_cylinder("",7.5,self.origin,300,300,"axis","allies","neutral");
}

//Function Number: 9
microwave_claim_safe_node(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = getnodesinradius(param_00.origin,600,350);
	var_01 = sortbydistance(var_01,self.origin);
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.mw_claimed) || gettime() > var_03.mw_claimed)
		{
			var_03.mw_claimed = gettime() + 10000;
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 10
microwave_set_safe_goal(param_00)
{
	if(isdefined(param_00))
	{
		maps\_utility::set_goalradius(20);
		self setgoalnode(param_00);
		return;
	}

	maps\_utility::set_goalradius(50);
	self setgoalentity(level.player);
}

//Function Number: 11
ai_flee_from_microwave(param_00,param_01)
{
	self notify("ai_flee_from_microwave");
	self endon("ai_flee_from_microwave");
	self endon("death");
	if(isdefined(self) == 0 || isalive(self) == 0 || maps\_utility::doinglongdeath())
	{
		return;
	}

	maps\_utility::set_ignoresuppression(1);
	self.mw_old_goalradius = self.goalradius;
	self.mw_old_animname = self.animname;
	self.mw_grenade = param_00;
	self.animname = "generic";
	self clearenemy();
	self.mw_old_badplace_awareness = self.badplaceawareness;
	self.badplaceawareness = 0;
	self.ignoreall = 1;
	self.allowdeath = 1;
	self.disablearrivals = 1;
	self.disableexits = 1;
	self.a.disablepain = 1;
	self.script_forcegoal = 0;
	self.disabledamagefeedbacksnd = 1;
	thread handle_microwaved_ai(self);
	var_02 = "microwave_react" + 1 + randomint(3);
	if(check_melee_interaction_active())
	{
		cleanup_microwave_on_exit();
		return;
	}

	if(!isdefined(self.mech))
	{
		childthread maps\_anim::anim_custom_animmode_solo(self,"gravity",var_02);
	}

	if(check_melee_interaction_active())
	{
		cleanup_microwave_on_exit();
		return;
	}

	if(!isdefined(self.mech))
	{
		var_03 = "microwave_run" + 1 + randomint(3);
		maps\_utility::set_run_anim(var_03);
	}

	microwave_set_safe_goal(param_01);
	for(;;)
	{
		var_04 = common_scripts\utility::waittill_any_timeout(0.2,"goal");
		var_05 = gettime() - self.microwaved > 300;
		if(var_04 == "goal" || var_05)
		{
			if(var_05)
			{
				cleanup_microwave_on_exit();
				return;
			}
			else
			{
				var_06 = microwave_claim_safe_node(self.mw_grenade);
				microwave_set_safe_goal(var_06);
			}
		}
	}
}

//Function Number: 12
cleanup_microwave_on_exit()
{
	maps\_utility::clear_run_anim();
	self.ignoreall = 0;
	self.disablearrivals = 0;
	self.disableexits = 0;
	self.a.disablepain = 0;
	self.disabledamagefeedbacksnd = undefined;
	maps\_utility::set_goalradius(self.mw_old_goalradius);
	self.badplaceawareness = self.mw_old_badplace_awareness;
	maps\_utility::set_ignoresuppression(0);
	if(isdefined(self.animname) && self.animname == "generic")
	{
		self.animname = self.mw_old_animname;
	}

	self.microwaved = undefined;
	self.mw_grenade = undefined;
}

//Function Number: 13
check_melee_interaction_active()
{
	if(isdefined(self.dog_attacking_me) || isdefined(self.syncedmeleetarget) || isdefined(self.melee) && isdefined(self.melee.target))
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
handle_microwaved_ai(param_00)
{
	if(!isdefined(level.microwaveded_ai))
	{
		level.microwaveded_ai = [];
	}

	level.microwaveded_ai[level.microwaveded_ai.size] = param_00;
	param_00 waittill("death");
	level.microwaveded_ai = common_scripts\utility::array_remove(level.microwaveded_ai,param_00);
}

//Function Number: 15
play_microwave_sparkfx(param_00)
{
	var_01 = 7500;
	var_02 = 220;
	var_03 = gettime() + var_01 - 500;
	thread play_environment_microwave_sparks(var_01,var_02,param_00,var_03);
	thread play_character_microwave_sparks(param_00,var_02,var_03);
}

//Function Number: 16
play_environment_microwave_sparks(param_00,param_01,param_02,param_03)
{
	while(gettime() < param_03)
	{
		wait(0.1);
		var_04 = (randomfloat(2) - 1,randomfloat(2) - 1,randomfloat(1));
		var_05 = 32 * var_04 + param_02;
		var_06 = param_01 * var_04 + param_02;
		var_07 = bullettrace(var_05,var_06,0,undefined,0,0,1,0,0);
		if(isdefined(var_07) && var_07["surfacetype"] != "none")
		{
			if(distance(var_05,var_07["position"]) > 20)
			{
				playfx(common_scripts\utility::getfx("microwave_grenade_sparks_1"),var_07["position"],var_07["normal"]);
				thread soundscripts\_snd_common::aud_microwave_grenade_sparks_env(var_07["position"]);
			}
		}
	}
}

//Function Number: 17
play_character_microwave_sparks(param_00,param_01,param_02)
{
	var_03 = ["TAG_WEAPON_RIGHT","TAG_WEAPON_LEFT","J_Head","J_SpineLower"];
	while(gettime() < param_02)
	{
		wait(randomfloatrange(0.15,0.25));
		var_04 = getaiarray("axis","allies");
		var_05 = [];
		foreach(var_07 in var_04)
		{
			if(distancesquared(var_07.origin,param_00) < param_01 * param_01)
			{
				var_05[var_05.size] = var_07;
			}
		}

		if(var_05.size > 0)
		{
			foreach(var_0A in var_05)
			{
				if(randomint(2) == 1)
				{
					playfxontag(common_scripts\utility::getfx("microwave_grenade_sparks_char_1"),var_0A,var_03[randomint(var_03.size)]);
					thread soundscripts\_snd_common::aud_microwave_grenade_sparks_dude(var_0A);
				}
			}
		}
	}
}

//Function Number: 18
ismetalsurface(param_00)
{
	var_01 = ["metal_debris","metal_grate","metal_hollow","metal_solid","metal_vehicle","metal_thin","metal_wet"];
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
play_microwave_physics(param_00)
{
	var_01 = 0;
	while(var_01 <= 7.5)
	{
		physicsexplosionsphere(param_00,256,128,0.5,0);
		var_01 = var_01 + 0.5;
		wait(0.5);
	}
}

//Function Number: 20
player_screen_flash(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		while(isdefined(self) && isdefined(level.player))
		{
			var_01 = distance(self.origin,level.player.origin);
			if(var_01 >= 220)
			{
				continue;
			}

			level.player shellshock("flashbang",1.5);
			wait(param_00);
		}

		wait(0.05);
		return;
	}
}