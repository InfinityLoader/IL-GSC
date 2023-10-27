/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_lights.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 622 ms
 * Timestamp: 10/27/2023 2:48:11 AM
*******************************************************************/

//Function Number: 1
init2()
{
	var_00 = getentarray("generic_flickering","targetname");
	var_01 = getentarray("generic_pulsing","targetname");
	var_02 = getentarray("generic_double_strobe","targetname");
	var_03 = getentarray("burning_trash_fire","targetname");
	var_04 = getentarray("scripted_light","targetname");
	common_scripts\utility::array_thread(var_00,::generic_flickering);
	common_scripts\utility::array_thread(var_01,::generic_pulsing);
	common_scripts\utility::array_thread(var_02,::generic_double_strobe);
	common_scripts\utility::array_thread(var_03,::burning_trash_fire);
	common_scripts\utility::array_thread(var_04,::init_scripted_light);
}

//Function Number: 2
is_light_entity(param_00)
{
	return param_00.classname == "light_spot" || param_00.classname == "light_omni" || param_00.classname == "light";
}

//Function Number: 3
flickerlight(param_00,param_01,param_02,param_03)
{
	self endon("kill_flicker");
	var_04 = param_00;
	var_05 = 0;
	maps\_utility::ent_flag_init("stop_flicker");
	for(;;)
	{
		if(maps\_utility::ent_flag("stop_flicker"))
		{
			wait(0.05);
			continue;
		}

		var_06 = var_04;
		var_04 = param_00 + param_01 - param_00 * randomfloat(1);
		if(param_02 != param_03)
		{
			var_05 = var_05 + randomfloatrange(param_02,param_03);
		}
		else
		{
			var_05 = var_05 + param_02;
		}

		if(var_05 == 0)
		{
			var_05 = var_05 + 1E-07;
		}

		var_07 = var_06 - var_04 * 1 / var_05;
		while(var_05 > 0 && !maps\_utility::ent_flag("stop_flicker"))
		{
			self setlightcolor(var_04 + var_07 * var_05);
			wait(0.05);
			var_05 = var_05 - 0.05;
		}
	}
}

//Function Number: 4
kill_flicker_when_damaged(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	var_02 = undefined;
	var_03 = 1E+08;
	foreach(var_05 in var_01)
	{
		var_06 = distance(self.origin,var_05.origin);
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	if(isdefined(var_02))
	{
		var_02 waittill("damage",var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E);
		self notify("kill_flicker");
		wait(0.05);
		self setlightcolor((0,0,0));
	}
}

//Function Number: 5
generic_pulsing()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self getlightintensity();
	var_01 = 0.05;
	var_02 = var_00;
	var_03 = 0.3;
	var_04 = 0.6;
	var_05 = var_00 - var_01 / var_03 / 0.05;
	var_06 = var_00 - var_01 / var_04 / 0.05;
	for(;;)
	{
		var_07 = 0;
		while(var_07 < var_04)
		{
			var_02 = var_02 - var_06;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(1);
		var_07 = 0;
		while(var_07 < var_03)
		{
			var_02 = var_02 + var_05;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(0.5);
	}
}

//Function Number: 6
generic_double_strobe()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self getlightintensity();
	var_01 = 0.05;
	var_02 = 0;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	var_06 = [];
	if(isdefined(self.script_noteworthy))
	{
		var_07 = getentarray(self.script_noteworthy,"targetname");
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(is_light_entity(var_07[var_08]))
			{
				var_05 = 1;
				var_06[var_06.size] = var_07[var_08];
			}

			if(var_07[var_08].classname == "script_model")
			{
				var_03 = var_07[var_08];
				var_04 = getent(var_03.target,"targetname");
				var_02 = 1;
			}
		}
	}

	for(;;)
	{
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.8);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.12);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
	}
}

//Function Number: 7
getclosests_flickering_model(param_00)
{
	var_01 = getentarray("light_flicker_model","targetname");
	var_02 = [];
	var_03 = common_scripts\utility::getclosest(param_00,var_01);
	if(isdefined(var_03))
	{
		var_02[0] = var_03;
	}

	return var_02;
}

//Function Number: 8
generic_flickering()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	self endon("stop_dynamic_light_behavior");
	self endon("death");
	self.linked_models = 0;
	self.lit_models = undefined;
	self.unlit_models = undefined;
	self.linked_lights = 0;
	self.linked_light_ents = [];
	self.linked_prefab_ents = undefined;
	self.linked_things = [];
	if(isdefined(self.script_linkto))
	{
		self.linked_prefab_ents = common_scripts\utility::get_linked_ents();
		foreach(var_01 in self.linked_prefab_ents)
		{
			if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "on")
			{
				if(!isdefined(self.lit_models))
				{
					self.lit_models[0] = var_01;
				}
				else
				{
					self.lit_models[self.lit_models.size] = var_01;
				}

				continue;
			}

			if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "off")
			{
				if(!isdefined(self.unlit_models))
				{
					self.unlit_models[0] = var_01;
				}
				else
				{
					self.unlit_models[self.unlit_models.size] = var_01;
				}

				self.unlit_model = var_01;
				continue;
			}

			if(is_light_entity(var_01))
			{
				self.linked_lights = 1;
				self.linked_light_ents[self.linked_light_ents.size] = var_01;
			}
		}

		self.linked_models = 1;
	}

	if(isdefined(self.script_noteworthy))
	{
		self.linked_things = getentarray(self.script_noteworthy,"targetname");
	}

	if(!self.linked_things.size && !isdefined(self.linked_prefab_ents))
	{
		self.linked_things = getclosests_flickering_model(self.origin);
	}

	for(var_03 = 0;var_03 < self.linked_things.size;var_03++)
	{
		if(is_light_entity(self.linked_things[var_03]))
		{
			self.linked_lights = 1;
			self.linked_light_ents[self.linked_light_ents.size] = self.linked_things[var_03];
		}

		if(self.linked_things[var_03].classname == "script_model")
		{
			var_04 = self.linked_things[var_03];
			if(!isdefined(self.lit_models))
			{
				self.lit_models[0] = var_04;
			}
			else
			{
				self.lit_models[self.lit_models.size] = var_04;
			}

			if(!isdefined(self.unlit_models))
			{
				self.unlit_models[0] = getent(var_04.target,"targetname");
			}
			else
			{
				self.unlit_models[self.unlit_models.size] = getent(var_04.target,"targetname");
			}

			self.linked_models = 1;
		}
	}

	if(isdefined(self.lit_models))
	{
		foreach(var_04 in self.lit_models)
		{
			if(isdefined(var_04) && isdefined(var_04.script_fxid))
			{
				var_04.effect = common_scripts\utility::createoneshoteffect(var_04.script_fxid);
				var_06 = (0,0,0);
				var_07 = (0,0,0);
				if(isdefined(var_04.script_parameters))
				{
					var_08 = strtok(var_04.script_parameters,", ");
					if(var_08.size < 3)
					{
					}
					else if(var_08.size == 6)
					{
						var_09 = float(var_08[0]);
						var_0A = float(var_08[1]);
						var_0B = float(var_08[2]);
						var_06 = (var_09,var_0A,var_0B);
						var_09 = float(var_08[3]);
						var_0A = float(var_08[4]);
						var_0B = float(var_08[5]);
						var_07 = (var_09,var_0A,var_0B);
					}
					else
					{
						var_09 = float(var_0B[0]);
						var_0A = float(var_0A[1]);
						var_0B = float(var_09[2]);
						var_06 = (var_09,var_0A,var_0B);
					}
				}

				var_04.effect.v["origin"] = var_04.origin + var_06;
				var_04.effect.v["angles"] = var_04.angles + var_07;
			}
		}
	}

	thread generic_flicker_msg_watcher();
	thread generic_flicker();
}

//Function Number: 9
generic_flicker_msg_watcher()
{
	maps\_utility::ent_flag_init("flicker_on");
	if(isdefined(self.script_light_startnotify) && self.script_light_startnotify != "nil")
	{
		for(;;)
		{
			level waittill(self.script_light_startnotify);
			maps\_utility::ent_flag_set("flicker_on");
			if(isdefined(self.script_light_stopnotify) && self.script_light_stopnotify != "nil")
			{
				level waittill(self.script_light_stopnotify);
				maps\_utility::ent_flag_clear("flicker_on");
			}
		}

		return;
	}

	maps\_utility::ent_flag_set("flicker_on");
}

//Function Number: 10
generic_flicker_pause()
{
	var_00 = self getlightintensity();
	if(!maps\_utility::ent_flag("flicker_on"))
	{
		if(self.linked_models)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_02 in self.lit_models)
				{
					var_02 hide();
					if(isdefined(var_02.effect))
					{
						var_02.effect common_scripts\utility::pauseeffect();
					}
				}
			}

			if(isdefined(self.unlit_models))
			{
				foreach(var_05 in self.unlit_models)
				{
					var_05 show();
				}
			}
		}

		self setlightintensity(0);
		if(self.linked_lights)
		{
			for(var_07 = 0;var_07 < self.linked_light_ents.size;var_07++)
			{
				self.linked_light_ents[var_07] setlightintensity(0);
			}
		}

		maps\_utility::ent_flag_wait("flicker_on");
		self setlightintensity(var_00);
		if(self.linked_lights)
		{
			for(var_07 = 0;var_07 < self.linked_light_ents.size;var_07++)
			{
				self.linked_light_ents[var_07] setlightintensity(var_00);
			}
		}

		if(self.linked_models)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_02 in self.lit_models)
				{
					var_02 show();
					if(isdefined(var_02.effect))
					{
						var_02.effect maps\_utility::restarteffect();
					}
				}
			}

			if(isdefined(self.unlit_models))
			{
				foreach(var_05 in self.unlit_models)
				{
					var_05 hide();
				}

				return;
			}
		}
	}
}

//Function Number: 11
generic_flicker()
{
	self endon("stop_dynamic_light_behavior");
	self endon("death");
	var_00 = 0.2;
	var_01 = 1.5;
	var_02 = self getlightintensity();
	var_03 = 0;
	var_04 = var_02;
	var_05 = 0;
	while(isdefined(self))
	{
		generic_flicker_pause();
		for(var_05 = randomintrange(1,10);var_05;var_05--)
		{
			generic_flicker_pause();
			wait(randomfloatrange(0.05,0.1));
			if(var_04 > 0.2)
			{
				var_04 = randomfloatrange(0,0.3);
				if(self.linked_models)
				{
					foreach(var_07 in self.lit_models)
					{
						var_07 hide();
						if(isdefined(var_07.effect))
						{
							var_07.effect common_scripts\utility::pauseeffect();
						}
					}
				}

				if(isdefined(self.unlit_models))
				{
					foreach(var_0A in self.unlit_models)
					{
						var_0A show();
					}
				}
			}
			else
			{
				var_04 = var_02;
				if(self.linked_models)
				{
					if(isdefined(self.lit_models))
					{
						foreach(var_07 in self.lit_models)
						{
							var_07 show();
							if(isdefined(var_07.effect))
							{
								var_07.effect maps\_utility::restarteffect();
							}
						}
					}

					if(isdefined(self.unlit_models))
					{
						foreach(var_0A in self.unlit_models)
						{
							var_0A hide();
							soundscripts\_audio::deprecated_aud_send_msg("light_flicker_on",var_0A);
						}
					}
				}
			}

			self setlightintensity(var_04);
			if(self.linked_lights)
			{
				for(var_10 = 0;var_10 < self.linked_light_ents.size;var_10++)
				{
					self.linked_light_ents[var_10] setlightintensity(var_04);
				}
			}
		}

		generic_flicker_pause();
		self setlightintensity(var_02);
		if(self.linked_lights)
		{
			for(var_10 = 0;var_10 < self.linked_light_ents.size;var_10++)
			{
				self.linked_light_ents[var_10] setlightintensity(var_02);
			}
		}

		if(self.linked_models)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_07 in self.lit_models)
				{
					var_07 show();
					if(isdefined(var_07.effect))
					{
						var_07.effect maps\_utility::restarteffect();
					}
				}
			}

			if(isdefined(self.unlit_models))
			{
				foreach(var_0A in self.unlit_models)
				{
					var_0A hide();
				}
			}
		}

		wait(randomfloatrange(var_00,var_01));
	}
}

//Function Number: 12
generic_spot()
{
	wait 0.05;
}

//Function Number: 13
flickerlightintensity(param_00,param_01)
{
	var_02 = self getlightintensity();
	var_03 = 0;
	var_04 = var_02;
	var_05 = 0;
	for(;;)
	{
		for(var_05 = randomintrange(1,10);var_05;var_05--)
		{
			wait(randomfloatrange(0.05,0.1));
			if(var_04 > 0.2)
			{
				var_04 = randomfloatrange(0,0.3);
			}
			else
			{
				var_04 = var_02;
			}

			self setlightintensity(var_04);
		}

		self setlightintensity(var_02);
		wait(randomfloatrange(param_00,param_01));
	}
}

//Function Number: 14
burning_trash_fire()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self getlightintensity();
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.7,var_00 * 1.2);
		var_03 = randomfloatrange(0.3,0.6);
		var_03 = var_03 * 20;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 15
strobelight(param_00,param_01,param_02,param_03)
{
	var_04 = 360 / param_02;
	var_05 = 0;
	for(;;)
	{
		var_06 = sin(var_05 * var_04) * 0.5 + 0.5;
		self setlightintensity(param_00 + param_01 - param_00 * var_06);
		wait(0.05);
		var_05 = var_05 + 0.05;
		if(var_05 > param_02)
		{
			var_05 = var_05 - param_02;
		}

		if(isdefined(param_03))
		{
			if(common_scripts\utility::flag(param_03))
			{
				return;
			}
		}
	}
}

//Function Number: 16
changelightcolorto(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	thread changelightcolortoworkerthread(param_00,param_01,param_02,param_03);
}

//Function Number: 17
changelightcolortoworkerthread(param_00,param_01,param_02,param_03)
{
	var_04 = self getlightcolor();
	var_05 = 1 / param_01 * 2 - param_02 + param_03;
	var_06 = 0;
	if(var_06 < param_02)
	{
		var_07 = var_05 / param_02;
		while(var_06 < param_02)
		{
			var_08 = var_07 * var_06 * var_06;
			self setlightcolor(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 + 0.05;
		}
	}

	while(var_06 < param_01 - param_03)
	{
		var_08 = var_05 * 2 * var_06 - param_02;
		self setlightcolor(vectorlerp(var_04,param_00,var_08));
		wait(0.05);
		var_06 = var_06 + 0.05;
	}

	var_06 = param_01 - var_06;
	if(var_06 > 0)
	{
		var_07 = var_05 / param_03;
		while(var_06 > 0)
		{
			var_08 = 1 - var_07 * var_06 * var_06;
			self setlightcolor(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 - 0.05;
		}
	}

	self setlightcolor(param_00);
}

//Function Number: 18
television()
{
	thread tv_changes_intensity();
	thread tv_changes_color();
}

//Function Number: 19
tv_changes_intensity()
{
	self endon("light_off");
	var_00 = self getlightintensity();
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.7,var_00 * 1.2);
		var_03 = randomfloatrange(0.3,1.2);
		var_03 = var_03 * 20;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 20
tv_changes_color()
{
	self endon("light_off");
	var_00 = 0.5;
	var_01 = 0.5;
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_02[var_04] = 0;
		var_03[var_04] = 0;
	}

	for(;;)
	{
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			var_03[var_04] = var_02[var_04];
			var_02[var_04] = randomfloat(var_00) + var_01;
		}

		var_05 = randomfloatrange(0.3,1.2);
		var_05 = var_05 * 20;
		for(var_04 = 0;var_04 < var_05;var_04++)
		{
			var_06 = [];
			for(var_07 = 0;var_07 < var_02.size;var_07++)
			{
				var_06[var_07] = var_02[var_07] * var_04 / var_05 + var_03[var_07] * var_05 - var_04 / var_05;
			}

			self setlightcolor((var_06[0],var_06[1],var_06[2]));
			wait(0.05);
		}
	}
}

//Function Number: 21
sun_shadow_trigger(param_00)
{
	var_01 = 1;
	if(isdefined(param_00.script_duration))
	{
		var_01 = param_00.script_duration;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 set_sun_shadow_params(var_01);
		while(var_02 istouching(param_00))
		{
			wait(0.25);
		}
	}
}

//Function Number: 22
set_sun_shadow_params(param_00)
{
	var_01 = getdvarint("sm_sunenable",1);
	var_02 = getdvarfloat("sm_sunshadowscale",1);
	var_03 = getdvarint("sm_spotlimit",4);
	var_04 = getdvarfloat("sm_sunsamplesizenear",0.25);
	var_05 = getdvarfloat("sm_qualityspotshadow",1);
	if(isdefined(self.script_sunenable))
	{
		var_01 = self.script_sunenable;
	}

	if(isdefined(self.script_sunshadowscale))
	{
		var_02 = self.script_sunshadowscale;
	}

	if(isdefined(self.script_spotlimit))
	{
		var_03 = self.script_spotlimit;
	}

	if(isdefined(self.script_sunsamplesizenear))
	{
		var_04 = self.script_sunsamplesizenear;
	}

	var_04 = min(max(0.016,var_04),32);
	if(isdefined(self.script_qualityspotshadow))
	{
		var_05 = self.script_qualityspotshadow;
	}

	var_06 = getdvarint("sm_sunenable",1);
	var_07 = getdvarfloat("sm_sunshadowscale",1);
	var_08 = getdvarint("sm_spotlimit",4);
	var_09 = getdvarint("sm_qualityspotshadow",1);
	setsaveddvar("sm_sunenable",var_01);
	setsaveddvar("sm_sunshadowscale",var_02);
	setsaveddvar("sm_spotlimit",var_03);
	setsaveddvar("sm_qualityspotshadow",var_05);
	lerp_sunsamplesizenear_overtime(var_04,param_00);
}

//Function Number: 23
lerp_sunsamplesizenear_overtime(param_00,param_01)
{
	level notify("changing_sunsamplesizenear");
	level endon("changing_sunsamplesizenear");
	var_02 = getdvarfloat("sm_sunSampleSizeNear",0.25);
	if(param_00 == var_02)
	{
		return;
	}

	var_03 = param_00 - var_02;
	var_04 = param_01 / 0.05;
	if(var_04 > 0)
	{
		var_05 = var_03 / var_04;
		var_06 = var_02;
		for(var_07 = 0;var_07 < var_04;var_07++)
		{
			var_06 = var_06 + var_05;
			setsaveddvar("sm_sunSampleSizeNear",var_06);
			wait(0.05);
		}
	}

	setsaveddvar("sm_sunSampleSizeNear",param_00);
}

//Function Number: 24
init_scripted_light()
{
	init_linked_ents();
	init_light_def();
}

//Function Number: 25
init_linked_ents()
{
	self.lit_models = [];
	self.unlit_models = [];
	self.linked_lights = [];
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
		if(var_00.size == 0)
		{
			return;
		}

		foreach(var_02 in var_00)
		{
			if(is_light_entity(var_02))
			{
				self.linked_lights[self.linked_lights.size] = var_02;
				var_02 init_linked_ents();
				continue;
			}

			var_03 = 1;
			if(isdefined(var_02.script_noteworthy))
			{
				if(var_02.script_noteworthy == "on")
				{
					var_03 = 0;
					init_lit_model(var_02);
				}
				else if(var_02.script_noteworthy == "off")
				{
					var_03 = 0;
					self.unlit_models[self.unlit_models.size] = var_02;
				}
			}

			if(var_03)
			{
				init_lit_model(var_02);
				var_04 = getentarray(var_02.target,"targetname");
				foreach(var_06 in var_04)
				{
					self.unlit_models[self.unlit_models.size] = var_06;
				}
			}
		}

		foreach(var_02 in self.lit_models)
		{
			var_02.visible = 1;
		}

		foreach(var_02 in self.unlit_models)
		{
			var_02.visible = 0;
			var_02 hide();
		}
	}
}

//Function Number: 26
init_lit_model(param_00)
{
	self.lit_models[self.lit_models.size] = param_00;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(param_00.script_fxid))
	{
		var_01 = self.script_fxid;
		var_02 = param_00.origin;
		var_03 = param_00.angles;
	}
	else if(isdefined(param_00.target))
	{
		var_04 = common_scripts\utility::getstruct(param_00.target,"targetname");
		if(isdefined(var_04) && isdefined(var_04.script_fxid))
		{
			var_01 = var_04.script_fxid;
			var_02 = var_04.origin;
			var_03 = (0,0,0);
			if(isdefined(var_04.angles))
			{
				var_03 = var_04.angles;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.effect = common_scripts\utility::createoneshoteffect(var_01);
		param_00.effect.v["origin"] = var_02;
		param_00.effect.v["angles"] = var_03;
	}
}

//Function Number: 27
pulse_think()
{
	self endon("stop_scripted_light");
	self endon("death");
	for(;;)
	{
		maps\_utility::script_wait();
		var_00 = self.script_intensity_min;
		var_01 = self.script_intensity_min + self.script_intensity_max - self.script_intensity_min * 0.4;
		var_02 = self.script_intensity_max - self.script_intensity_max - self.script_intensity_min * 0.4;
		var_03 = self.script_intensity_max;
		var_04 = randomintrange(self.script_count_min,self.script_count_max);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			var_06 = randomfloatrange(var_00,var_01);
			lerp_intensity(var_06,get_delay());
			maps\_utility::script_delay();
			var_06 = randomfloatrange(var_02,var_03);
			lerp_intensity(var_06,get_delay());
		}

		lerp_intensity(self.script_intensity_max,get_delay());
	}
}

//Function Number: 28
lerp_intensity(param_00,param_01)
{
	var_02 = int(param_01 * 20);
	var_03 = self getlightintensity();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		thread handle_linked_ents(param_00);
		self setlightintensity(var_03 + var_05 * var_04);
		wait(0.05);
	}

	var_06[0] = self;
	if(isdefined(self.linked_lights))
	{
		var_06 = common_scripts\utility::array_combine(var_06,self.linked_lights);
	}

	foreach(var_08 in var_06)
	{
		var_08 thread handle_linked_ents(param_00);
		var_08 setlightintensity(param_00);
	}
}

//Function Number: 29
handle_linked_ents(param_00)
{
	var_01 = param_00 > self.script_threshold;
	foreach(var_03 in self.lit_models)
	{
		if(var_01 && !var_03.visible)
		{
			var_03.visible = var_01;
			var_03 show();
			if(isdefined(var_03.effect))
			{
				var_03.effect thread maps\_utility::restarteffect();
			}

			continue;
		}

		if(!var_01 && var_03.visible)
		{
			var_03.visible = var_01;
			var_03 hide();
			if(isdefined(var_03.effect))
			{
				var_03.effect thread common_scripts\utility::pauseeffect();
			}
		}
	}

	foreach(var_03 in self.unlit_models)
	{
		if(!var_01 && !var_03.visible)
		{
			var_03.visible = 1;
			var_03 show();
			continue;
		}

		if(var_01 && var_03.visible)
		{
			var_03.visible = 0;
			var_03 hide();
		}
	}
}

//Function Number: 30
get_delay()
{
	return randomfloatrange(self.script_delay_min,self.script_delay_max);
}

//Function Number: 31
init_light_def()
{
	var_00["pulse"] = ::def_pulse;
	var_00["neon"] = ::def_neon;
	var_00["fire"] = ::def_fire;
	[[ var_00[self.script_light] ]]();
}

//Function Number: 32
def_pulse()
{
	set_delays(0.1,0.2);
	set_waits(1,4);
	set_counts(3,6);
	set_threshold(0.5);
	var_00 = self getlightintensity();
	set_intensities(var_00 * 0.25,var_00);
	thread pulse_think();
}

//Function Number: 33
def_neon()
{
	set_delays(0.05,0.1);
	set_waits(2,5);
	set_counts(1,3);
	set_threshold(0.5);
	var_00 = self getlightintensity();
	set_intensities(var_00 * 0.1,var_00);
	thread pulse_think();
}

//Function Number: 34
def_fire()
{
	set_delays(0.05,0.1);
	set_waits(0.05,0.1);
	set_counts(1,2);
	set_threshold(0.5);
	var_00 = self getlightintensity();
	set_intensities(var_00 * 0.75,var_00);
	thread pulse_think();
}

//Function Number: 35
set_threshold(param_00)
{
	if(!isdefined(self.script_threshold))
	{
		self.script_threshold = param_00;
	}

	foreach(var_02 in self.linked_lights)
	{
		if(!isdefined(var_02.script_threshold))
		{
			var_02.script_threshold = self.script_threshold;
		}
	}
}

//Function Number: 36
set_delays(param_00,param_01)
{
	if(!isdefined(self.script_delay_min))
	{
		self.script_delay_min = param_00;
	}

	if(!isdefined(self.script_delay_max))
	{
		self.script_delay_max = param_01;
	}
}

//Function Number: 37
set_waits(param_00,param_01)
{
	if(!isdefined(self.script_wait_min))
	{
		self.script_wait_min = param_00;
	}

	if(!isdefined(self.script_wait_max))
	{
		self.script_wait_max = param_01;
	}
}

//Function Number: 38
set_counts(param_00,param_01)
{
	if(!isdefined(self.script_count_min))
	{
		self.script_count_min = param_00;
	}

	if(!isdefined(self.script_count_max))
	{
		self.script_count_max = param_01;
	}
}

//Function Number: 39
set_intensities(param_00,param_01)
{
	if(!isdefined(self.script_intensity_min))
	{
		self.script_intensity_min = param_00;
	}

	if(!isdefined(self.script_intensity_max))
	{
		self.script_intensity_max = param_01;
	}
}