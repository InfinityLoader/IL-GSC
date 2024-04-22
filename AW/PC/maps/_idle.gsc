/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _idle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 276 ms
 * Timestamp: 4/22/2024 2:21:31 AM
*******************************************************************/

//Function Number: 1
create_animation_list()
{
	var_00 = [];
	var_00[var_00.size] = "phone";
	var_00[var_00.size] = "smoke";
	var_00[var_00.size] = "lean_smoke";
	var_00[var_00.size] = "coffee";
	var_00[var_00.size] = "sleep";
	var_00[var_00.size] = "sit_load_ak";
	var_00[var_00.size] = "smoke_balcony";
	if(isdefined(level.idle_animation_list_func))
	{
		var_00 = [[ level.idle_animation_list_func ]](var_00);
	}

	return var_00;
}

//Function Number: 2
idle_main()
{
	level.global_callbacks["_idle_call_idle_func"] = ::idle;
}

//Function Number: 3
idle()
{
	waittillframeend;
	if(!isalive(self))
	{
		return;
	}

	var_00 = undefined;
	if(!isdefined(self.target))
	{
		var_00 = self;
	}
	else
	{
		var_00 = getnode(self.target,"targetname");
		var_01 = getent(self.target,"targetname");
		var_02 = common_scripts\utility::getstruct(self.target,"targetname");
		var_03 = undefined;
		if(isdefined(var_00))
		{
			var_03 = ::get_node;
		}
		else if(isdefined(var_01))
		{
			var_03 = ::get_ent;
		}
		else if(isdefined(var_02))
		{
			var_03 = ::common_scripts\utility::getstruct;
		}

		var_00 = [[ var_03 ]](self.target,"targetname");
		while(isdefined(var_00.target))
		{
			var_00 = [[ var_03 ]](var_00.target,"targetname");
		}
	}

	var_04 = var_00.script_animation;
	if(!isdefined(var_04))
	{
		var_04 = "random";
	}

	if(!check_animation(var_04,var_00))
	{
		return;
	}

	if(var_04 == "random")
	{
		var_04 = create_random_animation();
		var_00.script_animation = var_04;
	}

	var_05 = var_04 + "_idle";
	var_06 = var_04 + "_into_idle";
	var_07 = var_04 + "_react";
	var_08 = var_04 + "_death";
	thread idle_proc(var_00,var_06,var_05,var_07,var_08);
}

//Function Number: 4
idle_reach_node(param_00,param_01)
{
	self endon("death");
	self endon("stop_idle_proc");
	if(isdefined(self._stealth))
	{
		level maps\_utility::add_wait(::common_scripts\utility::flag_wait,maps\_stealth_utility::stealth_get_group_spotted_flag());
		if(isdefined(self._stealth.plugins.corpse))
		{
			level maps\_utility::add_wait(::common_scripts\utility::flag_wait,maps\_stealth_utility::stealth_get_group_corpse_flag());
			maps\_utility::add_wait(::maps\_utility::ent_flag_wait,"_stealth_saw_corpse");
		}
	}
	else
	{
		maps\_utility::add_wait(::maps\_utility::waittill_msg,"enemy");
	}

	maps\_utility::add_func(::maps\_utility::send_notify,"stop_idle_proc");
	thread maps\_utility::do_wait_any();
	if(isdefined(self.script_patroller))
	{
		self waittill("_patrol_reached_path_end");
		return;
	}

	param_00 maps\_anim::anim_generic_reach(self,param_01);
}

//Function Number: 5
do_into_idle_anim(param_00)
{
	if(isdefined(param_00) && isdefined(level.scr_anim["generic"][param_00]))
	{
		var_01 = level.scr_anim["generic"][param_00];
		self._animmode = "gravity";
		self._tag_entity = self;
		self._anime = param_00;
		self._animname = "generic";
		self._custom_anim_loop = 0;
		self animcustom(::animscripts\animmode::main);
		var_02 = 0;
		if(isdefined(self.patrol_walk_anim) && isdefined(level.scr_anim["generic"][self.patrol_walk_anim]))
		{
			var_03 = self getanimtime(level.scr_anim["generic"][self.patrol_walk_anim]);
			if(var_03 > 0.6666667)
			{
				var_02 = 3 * var_03 - 0.6666667;
			}
			else if(var_03 > 0.3333333)
			{
				var_02 = 3 * var_03 - 0.3333333;
			}
			else
			{
				var_02 = 3 * var_03;
			}

			self setanimtime(var_01,var_02);
		}

		var_04 = getanimlength(var_01);
		var_05 = 1 - var_02 * var_04;
		wait(var_05);
	}
}

//Function Number: 6
idle_proc(param_00,param_01,param_02,param_03,param_04)
{
	self.allowdeath = 1;
	self endon("death");
	if(isdefined(self.script_idlereach))
	{
		self endon("stop_idle_proc");
		if(isdefined(param_01) && isdefined(level.scr_anim["generic"][param_01]))
		{
			idle_reach_node(param_00,param_01);
		}
		else
		{
			idle_reach_node(param_00,param_02);
		}
	}

	if(isdefined(self.script_idlereach))
	{
		self.script_animation = param_00.script_animation;
		param_00 = self;
	}

	if(param_00.script_animation == "sit_load_ak")
	{
		var_05 = maps\_utility::spawn_anim_model("chair_ak");
		self.has_delta = 1;
		self.anim_props = maps\_utility::make_array(var_05);
		param_00 thread maps\_anim::anim_first_frame_solo(var_05,"sit_load_ak_react");
	}

	if(param_00.script_animation == "lean_smoke" || param_00.script_animation == "smoke_balcony")
	{
		thread maps\_props::attach_cig_self();
	}

	if(param_00.script_animation == "smoke_balcony")
	{
		thread special_death_proc(param_00,param_04);
	}

	if(param_00.script_animation == "sleep")
	{
		var_05 = maps\_utility::spawn_anim_model("chair");
		self.has_delta = 1;
		self.anim_props = maps\_utility::make_array(var_05);
		param_00 thread maps\_anim::anim_first_frame_solo(var_05,"sleep_react");
		thread reaction_sleep();
	}

	if(isdefined(level.idle_proc_func))
	{
		self [[ level.idle_proc_func ]](param_00,param_02,param_03,param_04);
	}

	param_00 maps\_utility::script_delay();
	self.deathanim = level.scr_anim["generic"][param_04];
	if(isdefined(self._stealth))
	{
		self._stealth.debug_state = "idling";
		var_06 = undefined;
		if(param_00.script_animation == "smoke_balcony")
		{
			var_06 = 1;
		}

		do_into_idle_anim(param_01);
		param_00 maps\_stealth_utility::stealth_ai_idle_and_react(self,param_02,param_03,undefined,var_06);
		param_00 common_scripts\utility::waittill_either("stop_loop","stop_idle_proc");
		maps\_utility::clear_deathanim();
		return;
	}

	do_into_idle_anim(param_02);
	var_07 = "stop_loop";
	param_01 thread maps\_anim::anim_generic_loop(self,param_03,var_07);
	thread animate_props_on_death(param_01,param_04);
	thread reaction_proc(param_01,var_07,param_04);
}

//Function Number: 7
reaction_sleep()
{
	self endon("death");
	self.ignoreall = 1;
	reaction_sleep_wait_wakeup();
	self.ignoreall = 0;
}

//Function Number: 8
reaction_sleep_wait_wakeup()
{
	self endon("death");
	if(isdefined(self._stealth))
	{
		thread maps\_stealth_utility::stealth_enemy_endon_alert();
		self endon("stealth_enemy_endon_alert");
	}

	var_00 = 70;
	common_scripts\utility::array_thread(level.players,::reaction_sleep_wait_wakeup_dist,self,var_00);
	self waittill("_idle_reaction");
}

//Function Number: 9
reaction_sleep_wait_wakeup_dist(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("_idle_reaction");
	self endon("death");
	param_00 endon("enemy");
	var_02 = param_01 * param_01;
	for(;;)
	{
		while(distancesquared(self.origin,param_00.origin) > var_02)
		{
			wait(0.1);
		}

		param_00.ignoreall = 0;
		while(distancesquared(self.origin,param_00.origin) <= var_02)
		{
			wait(0.1);
		}

		param_00.ignoreall = 1;
	}
}

//Function Number: 10
reaction_proc(param_00,param_01,param_02,param_03)
{
	self endon("death");
	thread reaction_wait("enemy");
	thread reaction_wait("stop_idle_proc");
	thread reaction_wait("react");
	thread reaction_wait("doFlashBanged");
	thread reaction_wait("explode");
	var_04 = undefined;
	self waittill("_idle_reaction",var_04);
	maps\_utility::clear_deathanim();
	param_00 notify(param_01);
	if(isdefined(self.anim_props))
	{
		self.anim_props_animated = 1;
		param_00 thread maps\_anim::anim_single(self.anim_props,param_02);
	}

	if(var_04 == "stop_idle_proc")
	{
		maps\_utility::anim_stopanimscripted();
		return;
	}

	if(var_04 != "doFlashBanged")
	{
		if(isdefined(param_03) || isdefined(self.has_delta))
		{
			param_00 maps\_anim::anim_generic(self,param_02,param_03);
			return;
		}

		param_00 maps\_anim::anim_generic_custom_animmode(self,"gravity",param_02);
	}
}

//Function Number: 11
reaction_wait(param_00)
{
	self waittill(param_00);
	self notify("_idle_reaction",param_00);
}

//Function Number: 12
special_death_proc(param_00,param_01)
{
	thread maps\_utility::deletable_magic_bullet_shield();
	thread clear_bulletshield_on_alert(param_00);
	self waittill("damage");
	if(isdefined(self.deathanim))
	{
		if(isdefined(self._stealth))
		{
			maps\_stealth_utility::disable_stealth_for_ai();
		}

		param_00 maps\_anim::anim_generic(self,param_01);
		self delete();
	}
}

//Function Number: 13
clear_bulletshield_on_alert(param_00)
{
	self endon("death");
	if(!isdefined(self._stealth))
	{
		self waittill("_idle_reaction");
	}
	else
	{
		param_00 common_scripts\utility::waittill_either("stop_loop","stop_idle_proc");
	}

	maps\_utility::clear_deathanim();
	if(isdefined(self.magic_bullet_shield) && self.magic_bullet_shield)
	{
		maps\_utility::stop_magic_bullet_shield();
	}
}

//Function Number: 14
animate_props_on_death(param_00,param_01)
{
	if(!isdefined(self.anim_props))
	{
		return;
	}

	var_02 = self.anim_props;
	self waittill("death");
	if(isdefined(self.anim_props_animated))
	{
		return;
	}

	param_00 thread maps\_anim::anim_single(var_02,param_01);
}

//Function Number: 15
create_random_animation()
{
	var_00 = create_animation_list();
	return var_00[randomint(2)];
}

//Function Number: 16
check_animation(param_00,param_01)
{
	var_02 = create_animation_list();
	if(param_00 == "random")
	{
		var_03 = [];
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			if(!isdefined(level.scr_anim["generic"][var_02[var_04] + "_react"]))
			{
				var_03[var_03.size] = var_02[var_04];
			}
		}

		if(!var_03.size)
		{
			return 1;
		}

		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
		}

		return 0;
	}

	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(var_03[var_04] == param_01)
		{
			if(!isdefined(level.scr_anim["generic"][param_01 + "_react"]))
			{
				return 0;
			}

			return 1;
		}
	}

	var_05 = "";
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_05 + var_03[var_04] + ", ";
	}

	var_05 = var_05 + "and random.";
	return 0;
}

//Function Number: 17
get_ent(param_00,param_01)
{
	return getent(param_00,param_01);
}

//Function Number: 18
get_node(param_00,param_01)
{
	return getnode(param_00,param_01);
}