/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _utility_dogs.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 254 ms
 * Timestamp: 4/22/2024 2:24:20 AM
*******************************************************************/

//Function Number: 1
init_dog_anims()
{
	if(isdefined(level.dog_anims_initialized))
	{
		return;
	}

	level.dog_anims_initialized = 1;
	level.scr_anim["generic"]["dog_sniff_idle"][0] = %iw6_dog_sniff_idle;
	level.scr_anim["generic"]["dog_sniff_walk"] = %iw6_dog_sniff_walk;
	level.scr_anim["generic"]["dog_sneak_idle"][0] = %iw6_dog_sneakidle;
	level.scr_anim["generic"]["dog_sneak_walk"] = %iw6_dog_sneak_walk_forward;
}

//Function Number: 2
dog_follow_path_func(param_00,param_01)
{
	init_dog_anims();
	if(self.type != "dog")
	{
		return;
	}

	switch(param_00)
	{
		case "enable_sniff":
			dyn_sniff_disable();
			enable_dog_sniff();
			break;

		case "disable_sniff":
			dyn_sniff_disable();
			disable_dog_sniff();
			break;

		case "enable_dyn_sniff":
			dyn_sniff_enable();
			break;

		case "disable_dyn_sniff":
			dyn_sniff_disable();
			break;

		case "enable_sneak":
			dyn_sniff_disable();
			enable_dog_sneak();
			break;

		case "disable_sneak":
			dyn_sniff_disable();
			disable_dog_sneak();
			break;
	}
}

//Function Number: 3
enable_dog_sniff()
{
	self.old_moveplaybackrate = self.moveplaybackrate;
	self.moveplaybackrate = 1;
	self.movementtype = "sniff";
	maps\_utility::disable_arrivals();
	self notify("stop_pant");
}

//Function Number: 4
disable_dog_sniff()
{
	if(isdefined(self.old_moveplaybackrate))
	{
		self.moveplaybackrate = self.old_moveplaybackrate;
	}

	self.movementtype = "run";
	maps\_utility::enable_arrivals();
}

//Function Number: 5
enable_dog_sneak()
{
	init_dog_anims();
	self.run_overridesound = undefined;
	self.customidlesound = undefined;
	self.old_moveplaybackrate = self.moveplaybackrate;
	self.moveplaybackrate = 1;
	self.script_noturnanim = 1;
	self.script_nostairs = 1;
	maps\_utility::disable_arrivals();
	maps\_utility::disable_exits();
	maps\_utility::set_generic_idle_anim("dog_sneak_idle");
	maps\_utility::set_generic_run_anim("dog_sneak_walk");
}

//Function Number: 6
disable_dog_sneak()
{
	if(isdefined(self.old_moveplaybackrate))
	{
		self.moveplaybackrate = self.old_moveplaybackrate;
	}

	self.run_overridesound = undefined;
	self.customidlesound = undefined;
	self.script_noturnanim = undefined;
	self.script_nostairs = undefined;
	maps\_utility::enable_arrivals();
	maps\_utility::enable_exits();
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::clear_generic_run_anim();
}

//Function Number: 7
dog_lower_camera(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.75;
	}

	self setanim(%camera,1,param_00,1);
	self setanimknob(%iw6_dog_camera_down_add,1,param_00,1);
}

//Function Number: 8
dog_raise_camera(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.75;
	}

	self setanim(%camera,1,param_00,1);
	self setanimknob(%iw6_dog_camera_up_add,1,param_00,1);
}

//Function Number: 9
dyn_sniff_enable(param_00,param_01)
{
	self endon("death");
	self endon("dynsniff_off");
	if(isdefined(self.dyn_sniff))
	{
		return;
	}

	self.dyn_sniff = 1;
	if(!isdefined(param_00))
	{
		param_00 = 400;
	}

	if(!isdefined(param_01))
	{
		param_01 = 200;
	}

	self.old_moveplaybackrate = self.moveplaybackrate;
	for(;;)
	{
		var_02 = player_is_behind_me();
		var_03 = distance(self.origin,level.player.origin);
		if(var_02 && var_03 > param_00)
		{
			enable_dog_sniff();
			wait(4);
			while(player_is_behind_me() && distance(self.origin,level.player.origin) > param_01)
			{
				wait(0.1);
			}

			disable_dog_sniff();
			wait(6);
		}

		wait(0.3);
	}
}

//Function Number: 10
dyn_sniff_disable()
{
	self notify("dynsniff_off");
	disable_dog_sniff();
	self.dyn_sniff = undefined;
}

//Function Number: 11
player_is_behind_me()
{
	var_00 = (self.angles[0],self.angles[1],0);
	var_01 = anglestoforward(var_00);
	var_02 = self.origin - (0,0,self.origin[2]);
	var_03 = level.player.origin - (0,0,level.player.origin[2]);
	var_04 = vectornormalize(var_03 - var_02);
	var_05 = vectordot(var_04,var_01);
	return var_05 < -0.1;
}

//Function Number: 12
dog_bark(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "anml_dog_bark_attention_npc";
	}

	self setanimrestart(%iw6_dog_attackidle_bark_add,1,0.1,1);
	maps\_utility::play_sound_on_entity(param_00);
}

//Function Number: 13
dog_pant_think()
{
	self notify("stop_panting");
	self endon("stop_panting");
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.run_overridesound) && !isdefined(self.customidlesound) && self.script != "dog_combat")
		{
			dog_pant();
		}

		wait(randomfloatrange(15,25));
	}
}

//Function Number: 14
dog_pant(param_00)
{
	self endon("stop_panting");
	self endon("stop_pant");
	self endon("death");
	var_01 = self isdogbeingdriven() || isdefined(self.controlling_dog);
	var_02 = undefined;
	if(self.script == "dog_stop")
	{
		if(var_01)
		{
			var_02 = "anml_dog_pants_med_plr";
		}
		else
		{
			var_02 = "anml_dog_pants_med";
		}
	}
	else
	{
		if(self.movemode == "walk" || isdefined(self.movementtype) && self.movementtype == "walk_fast" || self.movementtype == "sniff" || self.movementtype == "sneak")
		{
			var_02 = "anml_dog_pants_med";
		}
		else
		{
			var_02 = "anml_dog_pants_fast";
		}

		if(var_01)
		{
			var_02 = var_02 + "_plr";
		}
	}

	maps\_utility::play_sound_on_entity(var_02);
}

//Function Number: 15
enable_dog_walk(param_00)
{
	self.old_movementtype = self.movementtype;
	if(isdefined(param_00))
	{
		self.movementtype = "walk_fast";
		return;
	}

	self.movementtype = "walk";
}

//Function Number: 16
disable_dog_walk()
{
	self.movementtype = "run";
}