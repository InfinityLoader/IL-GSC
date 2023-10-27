/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_ambient.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 343 ms
 * Timestamp: 10/27/2023 2:45:35 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.ambient_zones = [];
	add_zone("ac130");
	add_zone("alley");
	add_zone("bunker");
	add_zone("city");
	add_zone("container");
	add_zone("exterior");
	add_zone("exterior1");
	add_zone("exterior2");
	add_zone("exterior3");
	add_zone("exterior4");
	add_zone("exterior5");
	add_zone("forrest");
	add_zone("hangar");
	add_zone("interior");
	add_zone("interior_metal");
	add_zone("interior_stone");
	add_zone("interior_vehicle");
	add_zone("interior_wood");
	add_zone("mountains");
	add_zone("pipe");
	add_zone("shanty");
	add_zone("tunnel");
	add_zone("underpass");
	if(!isdefined(level.ambient_reverb))
	{
		level.ambient_reverb = [];
	}

	if(!isdefined(level.ambient_eq))
	{
		level.ambient_eq = [];
	}

	if(!isdefined(level.fxfireloopmod))
	{
		level.fxfireloopmod = 1;
	}

	level.eq_main_track = 0;
	level.eq_mix_track = 1;
	level.eq_track[level.eq_main_track] = "";
	level.eq_track[level.eq_mix_track] = "";
	level.ambient_modifier["interior"] = "";
	level.ambient_modifier["exterior"] = "";
	level.ambient_modifier["rain"] = "";
	maps\_equalizer::loadpresets();
}

//Function Number: 2
activateambient(param_00)
{
	level.ambient = param_00;
	if(level.ambient == "exterior")
	{
		param_00 = param_00 + level.ambient_modifier["exterior"];
	}

	if(level.ambient == "interior")
	{
		param_00 = param_00 + level.ambient_modifier["interior"];
	}

	ambientplay(level.ambient_track[param_00 + level.ambient_modifier["rain"]],1);
	thread ambienteventstart(param_00 + level.ambient_modifier["rain"]);
}

//Function Number: 3
ambientvolume()
{
	for(;;)
	{
		self waittill("trigger");
		activateambient("interior");
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		activateambient("exterior");
	}
}

//Function Number: 4
ambientdelay(param_00,param_01,param_02)
{
	if(!isdefined(level.ambienteventent))
	{
		level.ambienteventent[param_00] = spawnstruct();
	}
	else if(!isdefined(level.ambienteventent[param_00]))
	{
		level.ambienteventent[param_00] = spawnstruct();
	}

	level.ambienteventent[param_00].min = param_01;
	level.ambienteventent[param_00].range = param_02 - param_01;
}

//Function Number: 5
ambientevent(param_00,param_01,param_02)
{
	if(!isdefined(level.ambienteventent[param_00].event_alias))
	{
		var_03 = 0;
	}
	else
	{
		var_03 = level.ambienteventent[param_01].event_alias.size;
	}

	level.ambienteventent[param_00].event_alias[var_03] = param_01;
	level.ambienteventent[param_00].event_weight[var_03] = param_02;
}

//Function Number: 6
ambientreverb(param_00)
{
	level.player setreverb(level.ambient_reverb[param_00]["priority"],level.ambient_reverb[param_00]["roomtype"],level.ambient_reverb[param_00]["drylevel"],level.ambient_reverb[param_00]["wetlevel"],level.ambient_reverb[param_00]["fadetime"]);
	level waittill("new ambient event track");
	level.player deactivatereverb(level.ambient_reverb[param_00]["priority"],2);
}

//Function Number: 7
setupeq(param_00,param_01,param_02)
{
	if(!isdefined(level.ambient_eq[param_00]))
	{
		level.ambient_eq[param_00] = [];
	}

	level.ambient_eq[param_00][param_01] = param_02;
}

//Function Number: 8
setup_eq_channels(param_00,param_01)
{
	level.eq_track[param_01] = "exterior";
	if(!isdefined(level.ambient_eq) || !isdefined(level.ambient_eq[param_00]))
	{
		deactivate_index(param_01);
		return;
	}

	level.eq_track[param_01] = param_00;
	var_02 = getarraykeys(level.ambient_eq[param_00]);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		var_05 = maps\_equalizer::getfilter(level.ambient_eq[param_00][var_04]);
		if(!isdefined(var_05))
		{
			continue;
		}

		for(var_06 = 0;var_06 < 3;var_06++)
		{
			if(isdefined(var_05["type"][var_06]))
			{
				level.player seteq(var_04,param_01,var_06,var_05["type"][var_06],var_05["gain"][var_06],var_05["freq"][var_06],var_05["q"][var_06]);
				continue;
			}

			level.player deactivateeq(param_01,var_04,var_06);
		}
	}
}

//Function Number: 9
deactivate_index(param_00)
{
	level.player deactivateeq(param_00);
}

//Function Number: 10
ambienteventstart(param_00)
{
	set_ambience_single(param_00);
}

//Function Number: 11
start_ambient_event(param_00)
{
	level notify("new ambient event track");
	level endon("new ambient event track");
	if(!isdefined(level.player.soundent))
	{
		level.player.soundent = spawn("script_origin",(0,0,0));
		level.player.soundent.playingsound = 0;
	}
	else if(level.player.soundent.playingsound)
	{
		level.player.soundent waittill("sounddone");
	}

	var_01 = level.player.soundent;
	var_02 = level.ambienteventent[param_00].min;
	var_03 = level.ambienteventent[param_00].range;
	var_04 = 0;
	var_05 = 0;
	if(isdefined(level.ambient_reverb[param_00]))
	{
		thread ambientreverb(param_00);
	}

	for(;;)
	{
		wait(var_02 + randomfloat(var_03));
		while(var_05 == var_04)
		{
			var_05 = ambientweight(param_00);
		}

		var_04 = var_05;
		var_01.origin = level.player.origin;
		var_01 linkto(level.player);
		var_01 playsound(level.ambienteventent[param_00].event_alias[var_05],"sounddone");
		var_01.playingsound = 1;
		var_01 waittill("sounddone");
		var_01.playingsound = 0;
	}
}

//Function Number: 12
ambientweight(param_00)
{
	var_01 = level.ambienteventent[param_00].event_alias.size;
	var_02 = randomint(var_01);
	if(var_01 > 1)
	{
		var_03 = 0;
		var_04 = 0;
		for(var_05 = 0;var_05 < var_01;var_05++)
		{
			var_03++;
			var_04 = var_04 + level.ambienteventent[param_00].event_weight[var_05];
		}

		if(var_03 == var_01)
		{
			var_06 = randomfloat(var_04);
			var_04 = 0;
			for(var_05 = 0;var_05 < var_01;var_05++)
			{
				var_04 = var_04 + level.ambienteventent[param_00].event_weight[var_05];
				if(var_06 < var_04)
				{
					var_02 = var_05;
					break;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 13
add_zone(param_00)
{
	level.ambient_zones[param_00] = 1;
}

//Function Number: 14
check_ambience(param_00)
{
}

//Function Number: 15
ambient_trigger()
{
	var_00 = strtok(self.ambient," ");
	if(var_00.size == 1)
	{
		var_01 = var_00[0];
		for(;;)
		{
			self waittill("trigger",var_02);
			set_ambience_single(var_01);
		}
	}

	var_03 = getent(self.target,"targetname");
	var_04 = var_03.origin;
	var_05 = undefined;
	if(isdefined(var_03.target))
	{
		var_06 = getent(var_03.target,"targetname");
		var_05 = var_06.origin;
	}
	else
	{
		var_05 = var_04;
	}

	var_07 = distance(var_04,var_05);
	var_08 = var_00[0];
	var_09 = var_00[1];
	var_0A = 0.5;
	if(isdefined(self.targetname) && self.targetname == "ambient_exit")
	{
		var_0A = 0;
	}

	for(;;)
	{
		self waittill("trigger",var_02);
		var_0B = undefined;
		while(level.player istouching(self))
		{
			var_0B = maps\_utility::get_progress(var_04,var_05,level.player.origin,var_07);
			if(var_0B < 0)
			{
				var_0B = 0;
			}

			if(var_0B > 1)
			{
				var_0B = 1;
			}

			set_ambience_blend(var_0B,var_08,var_09);
			wait(0.05);
		}

		if(var_0B > var_0A)
		{
			var_0B = 1;
		}
		else
		{
			var_0B = 0;
		}

		set_ambience_blend(var_0B,var_08,var_09);
	}
}

//Function Number: 16
ambient_end_trigger_think(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_05);
		ambient_trigger_sets_ambience_levels(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 17
ambient_trigger_sets_ambience_levels(param_00,param_01,param_02,param_03,param_04)
{
	level notify("trigger_ambience_touched");
	level endon("trigger_ambience_touched");
	for(;;)
	{
		var_05 = maps\_utility::get_progress(param_00,param_01,level.player.origin,param_02);
		if(var_05 < 0)
		{
			var_05 = 0;
			set_ambience_single(param_03);
			break;
		}

		if(var_05 >= 1)
		{
			set_ambience_single(param_04);
			break;
		}

		set_ambience_blend(var_05,param_03,param_04);
		wait(0.05);
	}
}

//Function Number: 18
set_ambience_blend(param_00,param_01,param_02)
{
	if(level.eq_track[level.eq_main_track] != param_02)
	{
		setup_eq_channels(param_02,level.eq_main_track);
	}

	if(level.eq_track[level.eq_mix_track] != param_01)
	{
		setup_eq_channels(param_01,level.eq_mix_track);
	}

	level.player seteqlerp(param_00,level.eq_main_track);
	if(param_00 == 1 || param_00 == 0)
	{
		level.nextmsg = 0;
	}

	if(!isdefined(level.nextmsg))
	{
		level.nextmsg = 0;
	}

	if(gettime() < level.nextmsg)
	{
		return;
	}

	level.nextmsg = gettime() + 200;
}

//Function Number: 19
set_ambience_single(param_00)
{
	if(isdefined(level.ambienteventent[param_00]))
	{
		thread start_ambient_event(param_00);
	}

	if(level.eq_track[level.eq_main_track] != param_00)
	{
		setup_eq_channels(param_00,level.eq_main_track);
	}

	level.player seteqlerp(1,level.eq_main_track);
}

//Function Number: 20
ambience_hud(param_00,param_01,param_02)
{
	if(getdvar("loc_warnings") == "1")
	{
		return;
	}

	if(getdvar("debug_hud") != "")
	{
		return;
	}

	if(!isdefined(level.amb_hud))
	{
		var_03 = -40;
		var_04 = 460;
		level.amb_hud = [];
		var_05 = newhudelem();
		var_05.alignx = "left";
		var_05.aligny = "bottom";
		var_05.x = var_03 + 22;
		var_05.y = var_04 + 10;
		var_05.color = (0.4,0.9,0.6);
		level.amb_hud["inner"] = var_05;
		var_05 = newhudelem();
		var_05.alignx = "left";
		var_05.aligny = "bottom";
		var_05.x = var_03;
		var_05.y = var_04 + 10;
		var_05.color = (0.4,0.9,0.6);
		level.amb_hud["frac_inner"] = var_05;
		var_05 = newhudelem();
		var_05.alignx = "left";
		var_05.aligny = "bottom";
		var_05.x = var_03 + 22;
		var_05.y = var_04;
		var_05.color = (0.4,0.9,0.6);
		level.amb_hud["outer"] = var_05;
		var_05 = newhudelem();
		var_05.alignx = "left";
		var_05.aligny = "bottom";
		var_05.x = var_03;
		var_05.y = var_04;
		var_05.color = (0.4,0.9,0.6);
		level.amb_hud["frac_outer"] = var_05;
	}

	if(isdefined(param_02))
	{
		level.amb_hud["frac_outer"].label = int(100 * 1 - param_00);
		level.amb_hud["frac_outer"].alpha = 1;
		level.amb_hud["outer"].label = param_02;
		level.amb_hud["outer"].alpha = 1;
	}
	else
	{
		level.amb_hud["outer"].alpha = 0;
		level.amb_hud["frac_outer"].alpha = 0;
	}

	level.amb_hud["outer"] fadeovertime(0.5);
	level.amb_hud["frac_outer"] fadeovertime(0.5);
	level.amb_hud["frac_inner"].label = int(100 * param_00);
	level.amb_hud["frac_inner"].alpha = 1;
	level.amb_hud["frac_inner"] fadeovertime(0.5);
	level.amb_hud["inner"] settext(param_01);
	level.amb_hud["inner"].alpha = 1;
	level.amb_hud["inner"] fadeovertime(0.5);
}

//Function Number: 21
set_ambience_blend_over_time(param_00,param_01,param_02)
{
	if(param_00 == 0)
	{
		set_ambience_blend(1,param_01,param_02);
		return;
	}

	var_03 = 0;
	var_04 = 0.05;
	var_05 = 1 / param_00 / var_04;
	for(;;)
	{
		var_03 = var_03 + var_05;
		if(var_03 >= 1)
		{
			set_ambience_single(param_02);
			break;
		}

		set_ambience_blend(var_03,param_01,param_02);
		wait(var_04);
	}
}