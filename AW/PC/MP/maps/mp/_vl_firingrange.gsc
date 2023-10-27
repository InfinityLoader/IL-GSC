/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_vl_firingrange.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 1347 ms
 * Timestamp: 10/27/2023 1:46:48 AM
*******************************************************************/

//Function Number: 1
init_firingrange()
{
	var_00 = spawnstruct();
	var_00.fr_start = getent("firingrange_start","targetname");
	var_00.alltargetsarray = firing_range_setup_targets();
	var_00.allenvarray = firing_range_setup_env();
	var_00.transitionmeshes = [];
	var_00.transitionmeshesrev = [];
	var_00.alltriggerarray = firing_range_setup_triggers();
	var_00.alltargetmin = firing_range_setup_min_range();
	var_00.alltargetmax = firing_range_setup_max_range();
	var_00.allboothdisplays = firing_range_setup_booth_displays();
	var_00.alltargetlogicarray = firing_range_setup_target_logic();
	var_00.allfloorpannels = firing_range_setup_floor_panels();
	var_00.allvfx_struct = firing_range_setup_env_vfx();
	var_00.all3duiscreens = firing_range_setup_3dui_screens();
	var_00.audio_buzzer_struct = common_scripts\utility::getstruct("audio_buzzer_org","targetname");
	var_00.soundents = [];
	var_00.last_target = undefined;
	var_00.target_move_dist = 32;
	var_00.target_units_per_second = 256;
	var_00.pressedup = 0;
	var_00.presseddown = 0;
	var_00.roundnumber = undefined;
	var_00.minpoint = undefined;
	var_00.minpointmodpos = undefined;
	var_00.maxpoint = undefined;
	var_00.buttontimertotal = 0.55;
	var_00.buttontimer = 0;
	var_00.gracedisance = 24;
	var_00.damagedone = 0;
	var_00.rangeinmeters = 0;
	var_00.shotsfired = 0;
	var_00.shotshit = 0;
	var_00.percent = 0;
	var_00.shouldupdateluadisplay = 0;
	var_00.round_target_unit_per_second = 176;
	var_00.time = 0;
	var_00.groupdevider = 5;
	var_00.roundactive = 0;
	var_00.isshuttingdown = 0;
	var_00.vfxtargetspawn = loadfx("vfx/props/holo_target_red_spawn_in");
	var_00.vfxtargetspawnout = loadfx("vfx/props/holo_target_red_spawn_out");
	var_00.vfxholoedge = loadfx("vfx/beam/firing_range_edge_glow");
	common_scripts\utility::array_thread(var_00.alltriggerarray,::trigger_setup);
	level.target_center_off = (1.3,0,25);
	level.target_radius = 12;
	level.hit_off = 18;
	level.firingrange = var_00;
}

//Function Number: 2
firing_range_setup_floor_panels()
{
	var_00 = getentarray("holo_emitter_floor","targetname");
	foreach(var_02 in var_00)
	{
		var_02.og_position = var_02.origin;
		var_02.up_position = var_02.origin + (0,0,4);
	}

	return var_00;
}

//Function Number: 3
firing_range_setup_3dui_screens()
{
	var_00 = getentarray("display_3dui_mesh","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	return var_00;
}

//Function Number: 4
firing_range_setup_min_range()
{
	var_00 = common_scripts\utility::getstructarray("target_track_min","targetname");
	return var_00;
}

//Function Number: 5
firing_range_setup_max_range()
{
	var_00 = common_scripts\utility::getstructarray("target_track_max","targetname");
	return var_00;
}

//Function Number: 6
firing_range_setup_booth_displays()
{
	var_00 = common_scripts\utility::getstructarray("booth_display_01","targetname");
	var_01 = common_scripts\utility::getstructarray("booth_display_02","targetname");
	var_02 = common_scripts\utility::getstructarray("booth_display_03","targetname");
	var_03 = common_scripts\utility::getstructarray("booth_display_04","targetname");
	var_04 = common_scripts\utility::getstructarray("booth_display_05","targetname");
	var_05 = common_scripts\utility::getstructarray("booth_display_06","targetname");
	var_06 = [var_00,var_01,var_02,var_03,var_04,var_05];
	return var_06;
}

//Function Number: 7
trigger_setup()
{
	var_00 = self;
	var_00 thread common_scripts\_dynamic_world::triggertouchthink(::player_enter_round_trigger,::player_leave_round_trigger);
}

//Function Number: 8
player_enter_round_trigger(param_00)
{
	level endon("shutdown_hologram");
	while(level.firingrange.isshuttingdown == 1)
	{
		wait(0.1);
	}

	var_01 = self;
	if(!isdefined(param_00.script_index))
	{
		return;
	}

	var_02 = int(param_00.script_index);
	level.firingrange.roundnumber = var_02;
	if(!isdefined(level.firingrange.allenvarray[var_02]))
	{
		return;
	}

	var_01 thread startround(var_02);
}

//Function Number: 9
player_leave_round_trigger(param_00)
{
	var_01 = self;
	if(!isdefined(param_00.script_index))
	{
		return;
	}

	var_02 = int(param_00.script_index);
	level.firingrange.roundnumber = var_02;
	if(!isdefined(level.firingrange.allenvarray[var_02]))
	{
		return;
	}

	thread shutdownround(var_02,var_01);
}

//Function Number: 10
snd_play_linked_firingrange(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_origin",param_01.origin);
	var_04 vehicle_jetbikesethoverforcescale(param_01);
	var_04 thread maps\mp\_audio::sndx_play_linked_internal(param_00,param_01,param_02,param_03);
	if(!isdefined(level.firingrange.soundents))
	{
		level.firingrange.soundents = [];
	}
	else
	{
		level.firingrange.soundents = common_scripts\utility::add_to_array(level.firingrange.soundents,var_04);
	}

	return var_04;
}

//Function Number: 11
targetspreadshooting(param_00)
{
	level endon("shutdown_hologram");
	var_01 = self;
	var_02 = level.firingrange.alltargetsarray[param_00][0][0];
	var_02.alive = 1;
	thread maps\mp\_audio::snd_play_in_space("mp_shooting_range_panels_bell",level.firingrange.audio_buzzer_struct.origin);
	var_02 spawntarget();
	var_02 show();
	var_02 solid();
	var_02 setcandamage(1);
	var_02 setdamagecallbackon(1);
	var_02.damagecallback = ::monitordamagecallback;
	var_02.health = 9999;
	var_02.maxhealth = 9999;
	var_02 thermaldrawenable();
	foreach(var_04 in level.firingrange.alltargetmin)
	{
		if(var_04.script_index == level.firingrange.roundnumber)
		{
			level.firingrange.minpoint = var_04;
			break;
		}
	}

	foreach(var_04 in level.firingrange.alltargetmax)
	{
		if(var_04.script_index == level.firingrange.roundnumber)
		{
			level.firingrange.maxpoint = var_04;
			break;
		}
	}

	if(!isdefined(level.firingrange.minpoint) || !isdefined(level.firingrange.maxpoint))
	{
		thread shutdownround(param_00,var_01);
		return;
	}

	level.firingrange.minpointmodpos = level.firingrange.minpoint.origin + anglestoforward(level.firingrange.minpoint.angles) * -64;
	var_02 thread monitordistance(var_01,var_02,level.firingrange.minpoint);
	thread monitorshotsfired(var_01);
	thread monitorgrenades(var_01);
	thread monitorhitpercent(var_01);
	thread displayboothholo(var_01,param_00);
	var_01 thread notifytracker(var_02);
}

//Function Number: 12
monitordistance(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	self endon("death");
	var_03 = 0.0254;
	for(;;)
	{
		if(!isdefined(param_01) || !isdefined(param_02))
		{
			level.firingrange.rangeinmeters = 0;
			param_00 setclientomnvar("ui_vlobby_round_distance",level.firingrange.rangeinmeters);
		}
		else
		{
			var_04 = distance2d(param_01.origin,param_02.origin);
			var_05 = int(maps\mp\_utility::rounddecimalplaces(var_03 * var_04,0));
			if(var_05 != level.firingrange.rangeinmeters)
			{
				if(var_05 > 100)
				{
					var_05 = 100;
				}
				else if(var_05 < 0)
				{
					var_05 = 0;
				}

				level.firingrange.rangeinmeters = var_05;
				param_00 setclientomnvar("ui_vlobby_round_distance",level.firingrange.rangeinmeters);
			}
		}

		wait(0.05);
	}
}

//Function Number: 13
notifytracker(param_00)
{
	self endon("disconnect");
	level endon("shutdown_hologram");
	self notifyonplayercommand("toggled_up_pressed","+actionslot 1");
	self notifyonplayercommand("toggled_up_released","-actionslot 1");
	self notifyonplayercommand("toggled_down_pressed","+actionslot 2");
	self notifyonplayercommand("toggled_down_released","-actionslot 2");
	thread monitoruppressed(param_00);
	thread monitorupreleased(param_00);
	thread monitordownpressed(param_00);
	thread monitordownreleased(param_00);
	thread movestopper(param_00,self);
}

//Function Number: 14
monitoruppressed(param_00)
{
	self endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		self waittill("toggled_up_pressed");
		level.firingrange.buttontimer = level.firingrange.buttontimertotal;
		if(level.firingrange.pressedup == 0)
		{
			level.firingrange.pressedup = 1;
			level.firingrange.presseddown = 0;
			thread movelogic(level.firingrange.maxpoint.origin,param_00,self);
		}
	}
}

//Function Number: 15
monitorupreleased(param_00)
{
	self endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		self waittill("toggled_up_released");
		var_01 = distance2d(level.firingrange.maxpoint.origin,param_00.origin);
		if(var_01 <= 1)
		{
			param_00 moveto(param_00.origin,0.05);
		}
		else
		{
			var_02 = param_00.origin + anglestoforward(level.firingrange.alltargetmax[0].angles) * level.firingrange.gracedisance * -1;
			var_01 = distance2d(var_02,param_00.origin);
			var_03 = var_01 / level.firingrange.target_units_per_second;
			if(var_03 < 0.05)
			{
				var_03 = 0.05;
			}

			level.firingrange.buttontimer = var_03 + 0.05;
			thread movelogic(var_02,param_00,self);
		}

		param_00 waittill("movedone");
		level.firingrange.pressedup = 0;
	}
}

//Function Number: 16
monitordownpressed(param_00)
{
	self endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		self waittill("toggled_down_pressed");
		level.firingrange.buttontimer = level.firingrange.buttontimertotal;
		if(level.firingrange.presseddown == 0)
		{
			level.firingrange.presseddown = 1;
			level.firingrange.pressedup = 0;
			thread movelogic(level.firingrange.minpointmodpos,param_00,self);
		}
	}
}

//Function Number: 17
monitordownreleased(param_00)
{
	self endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		self waittill("toggled_down_released");
		var_01 = distance2d(level.firingrange.minpointmodpos,param_00.origin);
		if(var_01 <= 1)
		{
			param_00 moveto(param_00.origin,0.05);
		}
		else
		{
			var_02 = param_00.origin + anglestoforward(level.firingrange.alltargetmax[0].angles) * level.firingrange.gracedisance;
			var_01 = distance2d(var_02,param_00.origin);
			var_03 = var_01 / level.firingrange.target_units_per_second;
			if(var_03 < 0.05)
			{
				var_03 = 0.05;
			}

			level.firingrange.buttontimer = var_03 + 0.05;
			thread movelogic(var_02,param_00,self);
		}

		param_00 waittill("movedone");
		level.firingrange.presseddown = 0;
	}
}

//Function Number: 18
movelogic(param_00,param_01,param_02)
{
	var_03 = distance2d(param_00,param_01.origin);
	if(var_03 <= 1)
	{
		param_01 notify("movedone");
		return;
	}

	var_04 = var_03 / level.firingrange.target_units_per_second;
	if(var_04 < 0.05)
	{
		var_04 = 0.05;
	}

	param_01 moveto(param_00,var_04);
}

//Function Number: 19
movestopper(param_00,param_01)
{
	param_01 endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		wait(0.05);
		if(level.firingrange.presseddown == 1 || level.firingrange.pressedup == 1)
		{
			if(level.firingrange.buttontimer > 0)
			{
				level.firingrange.buttontimer = level.firingrange.buttontimer - 0.05;
				continue;
			}

			param_00 moveto(param_00.origin,0.05);
			level.firingrange.presseddown = 0;
			level.firingrange.pressedup = 0;
		}
	}
}

//Function Number: 20
monitordamage(param_00)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	var_01 = undefined;
	var_02 = param_00;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(level.firingrange.roundnumber == 7)
		{
			self.health = self.maxhealth;
		}

		var_0B = self gettagorigin("tag_chest");
		thread maps\mp\_audio::snd_play_in_space("mp_shooting_range_red_hit",var_0B);
		var_0C = getmodifier(var_0A,var_08,param_00);
		var_01 = maps\mp\_utility::rounddecimalplaces(float(var_01) * var_0C,0);
		var_01 = int(var_01);
		if(var_01 > 999)
		{
			var_01 = 999;
		}

		if(var_01 < 0)
		{
			var_01 = 0;
		}

		level.firingrange.damagedone = var_01;
		var_0D = level.firingrange.shotshit + 1;
		if(var_0D > 9999)
		{
			level.firingrange.shotshit = 0;
		}
		else if(var_0D < 0)
		{
			level.firingrange.shotshit = 0;
		}
		else
		{
			level.firingrange.shotshit = var_0D;
		}

		level.firingrange.shouldupdateluadisplay = 1;
	}
}

//Function Number: 21
monitordamagecallback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(self))
	{
		return;
	}

	if(level.firingrange.roundnumber == 7)
	{
		self.health = self.maxhealth;
	}

	var_0C = self gettagorigin("tag_chest");
	thread maps\mp\_audio::snd_play_in_space("mp_shooting_range_red_hit",var_0C);
	var_0D = 1;
	if(isdefined(param_01))
	{
		var_0D = getmodifier(param_05,param_0B,param_01);
	}

	param_02 = maps\mp\_utility::rounddecimalplaces(float(param_02) * var_0D,0);
	param_02 = int(param_02);
	if(param_02 > 999)
	{
		param_02 = 999;
	}

	if(param_02 < 0)
	{
		param_02 = 0;
	}

	level.firingrange.damagedone = param_02;
	if(isdefined(param_01))
	{
		if(isdefined(param_00) && param_00 != param_01)
		{
			if(!isdefined(param_00.damage_counted))
			{
				param_00.damage_counted = 1;
				var_0E = level.firingrange.shotshit + 1;
				if(var_0E > 9999)
				{
					level.firingrange.shotshit = 0;
				}
				else if(var_0E < 0)
				{
					level.firingrange.shotshit = 0;
				}
				else
				{
					level.firingrange.shotshit = var_0E;
				}

				level.firingrange.shouldupdateluadisplay = 1;
			}
		}
		else
		{
			param_01 thread countdamagingshots();
		}
	}

	level.firingrange.shouldupdateluadisplay = 1;
}

//Function Number: 22
countdamagingshots()
{
	level endon("shutdown_hologram");
	self endon("disconnect");
	if(!isdefined(self.damagingshot))
	{
		self.damagingshot = 1;
		return;
	}

	self.damagingshot++;
}

//Function Number: 23
getmodifier(param_00,param_01,param_02)
{
	var_03 = "none";
	var_04 = 1;
	var_05 = strtok(param_00,"_");
	var_06 = var_05[0] + "_" + var_05[1];
	if(param_00 != "specialty_null" && param_00 != "none" && param_00 != "iw5_combatknife_mp")
	{
		if(maps\mp\gametypes\_class::isvalidprimary(var_06) || maps\mp\gametypes\_class::isvalidsecondary(var_06,0))
		{
			if(param_01 == "tag_head")
			{
				var_03 = "head";
			}
			else if(param_01 == "tag_chest")
			{
				var_03 = "torso_upper";
			}
			else if(param_01 == "tag_arms")
			{
				var_03 = "right_arm_upper";
			}
			else if(param_01 == "tag_legs")
			{
				var_03 = "torso_lower";
			}
			else
			{
				var_03 = "none";
			}

			var_04 = param_02 getweapondamagelocationmultiplier(var_06 + "_mp",var_03);
			return var_04;
		}

		return var_04;
	}

	return var_04;
}

//Function Number: 24
waitforweaponfired()
{
	self endon("disconnect");
	self endon("reload");
	self endon("weapon_change");
	var_00 = 0;
	var_01 = self getcurrentweaponclipammo("right");
	var_02 = self getcurrentweaponclipammo("left");
	self waittill("weapon_fired");
	var_00 = 1;
	var_03 = self getcurrentweaponclipammo("right");
	var_04 = self getcurrentweaponclipammo("left");
	var_05 = var_01 - var_03 + var_02 - var_04;
	if(var_05 > 0)
	{
		var_00 = var_05;
	}

	return var_00;
}

//Function Number: 25
monitorshotsfired(param_00)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		param_00.damagingshot = 0;
		var_01 = param_00 waitforweaponfired();
		if(isdefined(var_01))
		{
			var_02 = level.firingrange.shotsfired + var_01;
			if(var_02 > 9999)
			{
				level.firingrange.shotsfired = 0;
				level.firingrange.shotshit = 0;
				level.firingrange.percent = 0;
				param_00 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
				param_00 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
				param_00 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
			}
			else if(var_02 < 0)
			{
				level.firingrange.shotsfired = 0;
				level.firingrange.shotshit = 0;
				level.firingrange.percent = 0;
				param_00 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
				param_00 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
				param_00 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
			}
			else
			{
				level.firingrange.shouldupdateluadisplay = 1;
				level.firingrange.shotsfired = var_02;
			}

			if(isdefined(param_00.damagingshot))
			{
				var_03 = param_00.damagingshot;
				if(var_01 < param_00.damagingshot)
				{
					var_03 = var_01;
				}

				var_04 = level.firingrange.shotshit + var_03;
				if(var_04 > 9999)
				{
					level.firingrange.shotshit = 0;
				}
				else if(var_04 < 0)
				{
					level.firingrange.shotshit = 0;
				}
				else
				{
					level.firingrange.shotshit = var_04;
				}

				param_00.damagingshot = 0;
			}
		}
	}
}

//Function Number: 26
monitorgrenades(param_00)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		param_00 waittill("grenade_fire",var_01);
		if(isdefined(var_01))
		{
			waittillframeend;
			if(isdefined(var_01.recall) && var_01.recall)
			{
				continue;
			}

			var_02 = level.firingrange.shotsfired + 1;
			if(var_02 > 9999)
			{
				level.firingrange.shotsfired = 0;
				level.firingrange.shotshit = 0;
				level.firingrange.percent = 0;
				param_00 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
				param_00 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
				param_00 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
			}
			else if(var_02 < 0)
			{
				level.firingrange.shotsfired = 0;
				level.firingrange.shotshit = 0;
				level.firingrange.percent = 0;
				param_00 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
				param_00 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
				param_00 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
			}
			else
			{
				level.firingrange.shouldupdateluadisplay = 1;
				level.firingrange.shotsfired = var_02;
			}
		}
	}
}

//Function Number: 27
monitorhitpercent(param_00)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	for(;;)
	{
		if(level.firingrange.shotsfired > 0)
		{
			var_01 = level.firingrange.shotshit / level.firingrange.shotsfired * 100;
			var_01 = maps\mp\_utility::rounddecimalplaces(var_01,0);
			if(var_01 != level.firingrange.percent)
			{
				if(var_01 > 999)
				{
					var_01 = 999;
				}
				else if(var_01 < 0)
				{
					var_01 = 0;
				}

				level.firingrange.percent = int(var_01);
				level.firingrange.shouldupdateluadisplay = 1;
			}
		}

		wait(0.05);
	}
}

//Function Number: 28
displayboothholo(param_00,param_01)
{
	param_00 endon("disconnect");
	level endon("shutdown_hologram");
	var_02 = finddisplay(level.firingrange.all3duiscreens,param_01);
	if(isdefined(var_02))
	{
		var_02 show();
	}

	for(;;)
	{
		if(level.firingrange.shouldupdateluadisplay == 1)
		{
			param_00 setclientomnvar("ui_vlobby_round_damage",level.firingrange.damagedone);
			param_00 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
			param_00 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
			param_00 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
			level.firingrange.shouldupdateluadisplay = 0;
		}

		wait(0.2);
	}
}

//Function Number: 29
finddisplay(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.script_index) && var_03.script_index == param_01)
		{
			return var_03;
		}
	}
}

//Function Number: 30
startround(param_00)
{
	level endon("shutdown_hologram");
	level notify("start_round");
	level.firingrange.damagedone = 0;
	level.firingrange.rangeinmeters = 0;
	level.firingrange.time = 0;
	level.firingrange.roundactive = 1;
	level.firingrange.shouldupdateluadisplay = 1;
	self setclientomnvar("ui_vlobby_round_distance",level.firingrange.rangeinmeters);
	self setclientomnvar("ui_vlobby_round_damage",level.firingrange.damagedone);
	self setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
	self setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
	self setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
	foreach(var_02 in level.firingrange.alltargetsarray[param_00])
	{
		foreach(var_04 in var_02)
		{
			var_04.origin = var_04.original_position;
			var_04.angles = var_04.original_orientation;
		}
	}

	foreach(var_08 in level.firingrange.allfloorpannels)
	{
		var_08 thread movefloorpanelup();
	}

	thread snd_play_linked_firingrange("mp_shooting_range_panels_up",self);
	thread lerp_spot_intensity("lt_shootingrange_bounce",0.25,0.01);
	if(level.nextgen)
	{
		thread lerp_spot_intensity_array("lt_shootingrange",0.25,0.01);
		thread lerp_spot_intensity("lt_hologram_blue",0.25,3000);
	}
	else
	{
		thread lerp_spot_intensity("lt_hologram_blue",0.25,60000);
	}

	wait(0.5);
	var_0A = 0;
	foreach(var_0C in level.firingrange.allvfx_struct[param_00])
	{
		if(level.nextgen)
		{
			thread particlespawn(level.firingrange.vfxholoedge,var_0C.origin,var_0C.angles,undefined,1);
		}
		else if(var_0A % 2 == 0)
		{
			thread particlespawn(level.firingrange.vfxholoedge,var_0C.origin,var_0C.angles,undefined,1);
		}

		var_0A++;
	}

	if(level.nextgen)
	{
		showtransition(param_00);
		wait(0.1);
		flickertransmeshes(level.firingrange.transitionmeshes);
		wait(0.1);
		flickertransmeshes(level.firingrange.transitionmeshes);
		wait(0.1);
		showtransitionrev(level.firingrange.transitionmeshes);
		hidetransitionmeshes();
		wait(0.4);
		showroundmeshmesh(param_00);
		wait(0.1);
		deletetransrevmeshes();
	}
	else
	{
		var_0E = showtransition_cg(param_00);
		wait(0.1);
		flickertransmeshes(level.firingrange.allenvarray[param_00]);
		flickertransmeshes(level.firingrange.allenvarray[param_00]);
		wait(0.1);
		flickertransmeshes(level.firingrange.allenvarray[param_00]);
		wait(0.1);
		hidetransitionmeshes_cg(param_00,var_0E);
		wait(0.1);
		showroundmeshmesh(param_00);
	}

	thread snd_play_linked_firingrange("mp_shooting_range_appear",self);
	if(param_00 == 7)
	{
		self setclientomnvar("ui_vlobby_round_state",3);
		thread targetspreadshooting(param_00);
		return;
	}

	self setclientomnvar("ui_vlobby_round_state",1);
	thread activate_targets(param_00);
}

//Function Number: 31
showroundmeshmesh(param_00)
{
	level endon("shutdown_hologram");
	var_01 = maps\mp\_utility::rounddecimalplaces(level.firingrange.allenvarray[param_00].size / level.firingrange.groupdevider,0,"up");
	var_02 = 0;
	foreach(var_04 in level.firingrange.allenvarray[param_00])
	{
		var_04 show();
		var_04 solid();
	}
}

//Function Number: 32
showtransitionrev(param_00)
{
	level endon("shutdown_hologram");
	level.firingrange.transitionmeshesrev = [];
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && !isremovedentity(var_02) && isdefined(var_02.classname) && var_02.classname == "script_model")
		{
			if(isdefined(var_02.model) && issubstr(var_02.model,"_trans"))
			{
				var_03 = var_02.model + "_rev";
				var_04 = spawn("script_model",var_02.origin);
				level.firingrange.transitionmeshesrev[level.firingrange.transitionmeshesrev.size] = var_04;
				if(isdefined(var_02.angles))
				{
					var_04.angles = var_02.angles;
				}
				else
				{
					var_04.angles = (0,0,0);
				}

				var_04 setmodel(var_03);
				var_04 notsolid();
			}
		}
	}
}

//Function Number: 33
showtransition(param_00)
{
	level endon("shutdown_hologram");
	level.firingrange.transitionmeshes = [];
	foreach(var_02 in level.firingrange.allenvarray[param_00])
	{
		if(isdefined(var_02.classname) && var_02.classname == "script_model")
		{
			if(isdefined(var_02.model) && issubstr(var_02.model,"rec_holo_range"))
			{
				var_03 = var_02.model + "_trans";
				var_04 = spawn("script_model",var_02.origin);
				level.firingrange.transitionmeshes[level.firingrange.transitionmeshes.size] = var_04;
				if(isdefined(var_02.angles))
				{
					var_04.angles = var_02.angles;
				}
				else
				{
					var_04.angles = (0,0,0);
				}

				var_04 setmodel(var_03);
				var_04 notsolid();
			}
		}
	}
}

//Function Number: 34
flickertransmeshes(param_00)
{
	level endon("shutdown_hologram");
	if(isdefined(param_00) && isarray(param_00))
	{
		hidemodels(param_00);
		wait(0.05);
		showmodels(param_00);
		wait(0.05);
	}
}

//Function Number: 35
showmodels(param_00)
{
	level endon("shutdown_hologram");
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && !isremovedentity(var_02))
		{
			var_02 show();
			var_02 notsolid();
		}
	}
}

//Function Number: 36
hidemodels(param_00)
{
	level endon("shutdown_hologram");
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02) && !isremovedentity(var_02))
		{
			var_02 hide();
			var_02 notsolid();
		}
	}
}

//Function Number: 37
hidetransitionmeshes()
{
	if(isarray(level.firingrange.transitionmeshes))
	{
		level.firingrange.transitionmeshes = common_scripts\utility::array_remove_duplicates(level.firingrange.transitionmeshes);
		foreach(var_01 in level.firingrange.transitionmeshes)
		{
			if(isdefined(var_01) && !isremovedentity(var_01))
			{
				var_01 hide();
				var_01 notsolid();
			}
		}
	}
}

//Function Number: 38
deletetransrevmeshes()
{
	if(isarray(level.firingrange.transitionmeshesrev))
	{
		level.firingrange.transitionmeshesrev = common_scripts\utility::array_remove_duplicates(level.firingrange.transitionmeshesrev);
		foreach(var_01 in level.firingrange.transitionmeshesrev)
		{
			if(isdefined(var_01) && !isremovedentity(var_01))
			{
				var_01 delete();
			}
		}
	}

	level.firingrange.transitionmeshesrev = [];
}

//Function Number: 39
removetransitionmeshes()
{
	if(isarray(level.firingrange.transitionmeshes))
	{
		var_00 = common_scripts\utility::array_remove_duplicates(level.firingrange.transitionmeshes);
		flickertransmeshes(var_00);
		flickertransmeshes(var_00);
		wait(0.1);
		flickertransmeshes(var_00);
		wait(0.1);
		flickertransmeshes(var_00);
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02) && !isremovedentity(var_02))
			{
				var_02 delete();
			}
		}
	}
}

//Function Number: 40
removerevnmeshes()
{
	if(isarray(level.firingrange.scanlinemeshes))
	{
		level.firingrange.scanlinemeshes = common_scripts\utility::array_remove_duplicates(level.firingrange.scanlinemeshes);
		foreach(var_01 in level.firingrange.scanlinemeshes)
		{
			if(isdefined(var_01) && !isremovedentity(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 41
movefloorpanelup()
{
	level endon("shutdown_hologram");
	var_00 = randomfloatrange(0,1);
	wait(var_00);
	self setmodel("rec_holo_emitter_floor_on");
	self moveto(self.up_position,0.25,0.1,0.1);
}

//Function Number: 42
movefloorpaneldown()
{
	level endon("start_round");
	self setmodel("rec_holo_emitter_floor_off");
	var_00 = randomfloatrange(0,1);
	wait(var_00);
	self moveto(self.og_position,0.25,0.1,0.1);
}

//Function Number: 43
shutdownround(param_00,param_01)
{
	level notify("shutdown_hologram");
	level.firingrange.isshuttingdown = 1;
	param_01 setclientomnvar("ui_vlobby_round_state",0);
	param_01 setclientomnvar("ui_vlobby_round_timer",0);
	param_01 setclientomnvar("ui_vlobby_round_damage",0);
	param_01 setclientomnvar("ui_vlobby_round_distance",0);
	param_01 setclientomnvar("ui_vlobby_round_hits",0);
	param_01 setclientomnvar("ui_vlobby_round_fired",0);
	param_01 setclientomnvar("ui_vlobby_round_accuracy",0);
	param_01 thread grenadecleanup(1);
	thread removetransitionmeshes();
	thread deletetransrevmeshes();
	thread snd_play_linked_firingrange("mp_shooting_range_disappear",param_01);
	foreach(var_03 in level.firingrange.allfloorpannels)
	{
		var_03 thread movefloorpaneldown();
	}

	thread snd_play_linked_firingrange("mp_shooting_range_panels_up",param_01);
	foreach(var_06 in level.firingrange.allenvarray[param_00])
	{
		var_06 hide();
		var_06 notsolid();
	}

	if(level.nextgen)
	{
		thread lerp_spot_intensity_array("lt_shootingrange",0.25,6000);
	}

	thread lerp_spot_intensity("lt_shootingrange_bounce",0.25,3000);
	thread lerp_spot_intensity("lt_hologram_blue",0.25,0.01);
	foreach(var_09 in level.firingrange.alltargetsarray[param_00])
	{
		foreach(var_0B in var_09)
		{
			if(var_0B.alive == 1)
			{
				var_0C = var_0B.origin;
				var_0D = var_0B.angles;
				thread particlespawn(level.firingrange.vfxtargetspawnout,var_0C,var_0D,3);
			}

			var_0B dontinterpolate();
			var_0B.aimassist_target disableaimassist();
			var_0B.origin = var_0B.original_position;
			var_0B.angles = var_0B.original_orientation;
			var_0B.aimassist_target hide();
			var_0B.aimassist_target notsolid();
			var_0B hide();
			var_0B notsolid();
			var_0B thermaldrawdisable();
			var_0B.alive = 0;
		}
	}

	foreach(var_11 in level.firingrange.all3duiscreens)
	{
		var_11 hide();
	}

	level.firingrange.minpoint = undefined;
	level.firingrange.maxpoint = undefined;
	level.firingrange.minpointmodpos = undefined;
	level.firingrange.presseddown = 0;
	level.firingrange.pressedup = 0;
	level.firingrange.damagedone = 0;
	level.firingrange.rangeinmeters = 0;
	level.firingrange.shotsfired = 0;
	level.firingrange.shotshit = 0;
	level.firingrange.percent = 0;
	level.firingrange.roundactive = 0;
	level.firingrange.shouldupdateluadisplay = 1;
	param_01 setclientomnvar("ui_vlobby_round_distance",level.firingrange.rangeinmeters);
	param_01 setclientomnvar("ui_vlobby_round_damage",level.firingrange.damagedone);
	param_01 setclientomnvar("ui_vlobby_round_hits",level.firingrange.shotshit);
	param_01 setclientomnvar("ui_vlobby_round_fired",level.firingrange.shotsfired);
	param_01 setclientomnvar("ui_vlobby_round_accuracy",level.firingrange.percent);
	level.firingrange.isshuttingdown = 0;
}

//Function Number: 44
spawntarget()
{
	level endon("shutdown_hologram");
	var_00 = self.origin;
	var_01 = self.angles;
	thread particlespawn(level.firingrange.vfxtargetspawn,var_00,var_01,3);
	thread snd_play_linked_firingrange("mp_shooting_range_red_appear",self);
	wait(0.05);
	self show();
	self solid();
	self thermaldrawenable();
}

//Function Number: 45
scalesoundsonexit()
{
	level notify("ScaleSoundsOnExit");
	level endon("ScaleSoundsOnExit");
	if(isdefined(level.in_firingrange))
	{
		for(;;)
		{
			wait(0.05);
			if(level.in_firingrange == 1 || getdvarint("virtualLobbyInFiringRange",0) == 1)
			{
				continue;
			}
			else
			{
				level.firingrange.soundents = common_scripts\utility::array_remove_duplicates(level.firingrange.soundents);
				foreach(var_01 in level.firingrange.soundents)
				{
					var_01 scalevolume(0,0.5);
				}
			}
		}
	}
}

//Function Number: 46
enter_firingrange(param_00)
{
	level.in_firingrange = 1;
	thread wait_start_firingrange(0.4,param_00);
}

//Function Number: 47
wait_start_firingrange(param_00,param_01)
{
	param_01 endon("enter_lobby");
	wait(param_00);
	param_01 setclientomnvar("ui_vlobby_round_state",0);
	param_01 setclientomnvar("ui_vlobby_round_timer",0);
	param_01 setclientomnvar("ui_vlobby_round_damage",0);
	param_01 setclientomnvar("ui_vlobby_round_distance",0);
	param_01 setclientomnvar("ui_vlobby_round_hits",0);
	param_01 setclientomnvar("ui_vlobby_round_fired",0);
	param_01 setclientomnvar("ui_vlobby_round_accuracy",0);
	param_01 unlink();
	param_01 cameraunlink();
	var_02 = getgroundposition(level.firingrange.fr_start.origin,20,512,120);
	param_01 dontinterpolate();
	param_01 setorigin(var_02);
	param_01 setplayerangles(level.firingrange.fr_start.angles);
	param_01 setclientdvar("cg_fovscale","1.0");
	level.firingrange.isshuttingdown = 0;
	maps\mp\_vl_camera::virtual_lobby_set_class(0,"lobby" + param_01.currentselectedclass + 1,1,1);
	param_01 chargebattery(param_01.loadoutoffhand);
	param_01 chargebattery(param_01.loadoutequipment);
	maps\mp\_utility::updatesessionstate("playing");
	param_01 setclienttriggervisionset("mp_virtual_lobby_fr",0);
	param_01 lightsetforplayer("mp_vl_firingrange");
	param_01 thread maps\mp\_vl_base::enable_player_controls();
	level.firingrange.soundents = [];
	param_01 thread scalesoundsonexit();
	if(!param_01 maps\mp\_utility::_hasperk("specialty_wildcard_dualtacticals") && maps\mp\gametypes\_class::isvalidequipment(param_01.loadoutequipment,0) && !isbadequipment(param_01.loadoutequipment))
	{
		param_01 thread monitor_grenade_count(param_01.loadoutequipment,0);
	}

	if(param_01 maps\mp\_utility::_hasperk("specialty_wildcard_duallethals") && maps\mp\gametypes\_class::isvalidequipment(param_01.loadoutoffhand,0) && !isbadequipment(param_01.loadoutoffhand))
	{
		param_01 thread monitor_grenade_count(param_01.loadoutoffhand,1);
	}

	if(param_01.primaryweapon != "specialty_null" && param_01.primaryweapon != "none" && param_01.primaryweapon != "iw5_combatknife_mp" && !issubstr(param_01.primaryweapon,"em1") && !issubstr(param_01.primaryweapon,"epm3") && !issubstr(param_01.primaryweapon,"dlcgun1_mp") && !issubstr(param_01.primaryweapon,"dlcgun1loot") && !issubstr(param_01.primaryweapon,"dlcgun9loot6") && !issubstr(param_01.primaryweapon,"dlcgun10loot4") && !issubstr(param_01.primaryweapon,"dlcgun10loot6"))
	{
		param_01 thread monitor_weapon_ammo_count(param_01.primaryweapon);
		if(issubstr(param_01.primaryweapon,"_gl"))
		{
			param_01 thread monitor_weapon_ammo_count("alt_" + param_01.primaryweapon);
		}
	}

	if(param_01.secondaryweapon != "specialty_null" && param_01.secondaryweapon != "none" && param_01.secondaryweapon != "iw5_combatknife_mp" && !issubstr(param_01.secondaryweapon,"em1") && !issubstr(param_01.secondaryweapon,"epm3") && !issubstr(param_01.primaryweapon,"dlcgun1_mp") && !issubstr(param_01.primaryweapon,"dlcgun1loot") && !issubstr(param_01.primaryweapon,"dlcgun9loot6") && !issubstr(param_01.primaryweapon,"dlcgun10loot4") && !issubstr(param_01.primaryweapon,"dlcgun10loot6"))
	{
		param_01 thread monitor_weapon_ammo_count(param_01.secondaryweapon);
		if(issubstr(param_01.secondaryweapon,"_gl"))
		{
			param_01 thread monitor_weapon_ammo_count("alt_" + param_01.secondaryweapon);
		}
	}
}

//Function Number: 48
chargebattery(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	if(var_01 != "none" && var_01 != "specialty_null" && maps\mp\gametypes\_class::isvalidoffhand(var_01,0))
	{
		self batteryfullrecharge(var_01);
		self batterysetdischargescale(var_01,1);
	}
}

//Function Number: 49
isbadequipment(param_00)
{
	switch(param_00)
	{
		case "exoknife_mp_lefthand":
		case "exoknife_mp":
		case "specialty_null":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 50
giveplayerconroldelayed()
{
	self endon("enter_lobby");
	wait(2);
	var_00 = getdvarint("virtualLobbyInFiringRange",0);
	if(var_00 == 1 && level.in_firingrange == 1)
	{
		self allowfire(1);
	}
}

//Function Number: 51
activate_targets(param_00)
{
	level endon("shutdown_hologram");
	var_01 = self;
	level.firingrange.last_target = undefined;
	thread monitortime(var_01);
	thread monitorshotsfired(var_01);
	thread monitorhitpercent(var_01);
	foreach(var_03 in level.firingrange.alltargetsarray[param_00])
	{
		foreach(var_05 in var_03)
		{
			var_05 thread monitordamage(var_01);
		}
	}

	thread displayboothholo(var_01,param_00);
	var_08 = level.firingrange.alltargetsarray[param_00].size;
	var_09 = level.firingrange.alltargetsarray[param_00];
	for(var_0A = 0;var_0A < var_08;var_0A++)
	{
		thread startwave(var_09[var_0A],var_01);
		level waittill("wave_done");
		wait(0.05);
	}

	level notify("round_done");
	thread maps\mp\_audio::snd_play_in_space("mp_shooting_range_panels_bell",level.firingrange.audio_buzzer_struct.origin);
	level.firingrange.roundactive = 0;
	var_01 setclientomnvar("ui_vlobby_round_state",2);
}

//Function Number: 52
monitortime(param_00)
{
	level endon("shutdown_hologram");
	level endon("round_done");
	var_01 = maps\mp\_utility::gettimepassed();
	for(;;)
	{
		var_02 = maps\mp\_utility::gettimepassed();
		var_03 = var_02 - var_01;
		var_04 = maps\mp\_utility::rounddecimalplaces(var_03 / 1000,1);
		if(var_04 > 9999.9)
		{
			level.firingrange.time = 0;
			param_00 setclientomnvar("ui_vlobby_round_timer",level.firingrange.time);
			param_00 setclientomnvar("ui_vlobby_round_state",0);
			thread shutdownround(level.firingrange.roundnumber,param_00);
			return;
		}
		else if(var_04 < 0)
		{
			level.firingrange.time = 0;
			param_00 setclientomnvar("ui_vlobby_round_timer",level.firingrange.time);
			param_00 setclientomnvar("ui_vlobby_round_state",0);
			thread shutdownround(level.firingrange.roundnumber,param_00);
			return;
		}
		else
		{
			level.firingrange.time = var_04;
			param_00 setclientomnvar("ui_vlobby_round_timer",level.firingrange.time);
		}

		wait(0.05);
	}
}

//Function Number: 53
startwave(param_00,param_01)
{
	level endon("shutdown_hologram");
	var_02 = 0;
	thread maps\mp\_audio::snd_play_in_space("mp_shooting_range_panels_bell",level.firingrange.audio_buzzer_struct.origin);
	foreach(var_04 in param_00)
	{
		var_04 thread target_lifetime(param_01);
	}

	for(;;)
	{
		level waittill("target_died");
		var_02++;
		if(var_02 == param_00.size)
		{
			level notify("wave_done");
			return;
		}
	}
}

//Function Number: 54
target_lifetime(param_00)
{
	level endon("shutdown_hologram");
	self.original_position = self.origin;
	self.original_orientation = self.angles;
	self.alive = 1;
	spawntarget();
	thread target_handler(param_00);
	thread target_logic();
	thread target_handle_death();
	thread target_handle_stop();
}

//Function Number: 55
particlespawn(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	var_05 = spawnfx(param_00,param_01,anglestoforward(param_02),anglestoup(param_02));
	if(isdefined(param_04))
	{
		setfxkillondelete(var_05,param_04);
	}

	triggerfx(var_05);
	if(isdefined(param_03))
	{
		wait(param_03);
		if(isdefined(var_05) && !isremovedentity(var_05))
		{
			var_05 delete();
			return;
		}

		return;
	}

	level waittill("shutdown_hologram");
	if(isdefined(var_05) && !isremovedentity(var_05))
	{
		var_05 delete();
	}
}

//Function Number: 56
target_logic()
{
	level endon("shutdown_hologram");
	self endon("death");
	if(isdefined(self.script_parameters))
	{
		var_00 = self.script_parameters;
		movetargettodest();
		switch(var_00)
		{
			case "stand":
				break;

			case "cover":
				break;

			case "move":
				break;
		}
	}
}

//Function Number: 57
movetargettodest()
{
	level endon("shutdown_hologram");
	self endon("death");
	if(!isdefined(level.firingrange.roundnumber))
	{
		return;
	}

	var_00 = level.firingrange.roundnumber;
	var_01 = common_scripts\utility::getclosest(self.origin,level.firingrange.alltargetlogicarray[var_00]);
	self.current_ent = var_01;
	self.last_ent = self.current_ent;
	for(;;)
	{
		if(isdefined(self))
		{
			var_02 = distance(self.current_ent.origin,self.origin);
			var_03 = var_02 / level.firingrange.round_target_unit_per_second;
			if(isdefined(self.current_ent.script_noteworthy) && self.current_ent.script_noteworthy == "jump")
			{
				self moveto(self.current_ent.origin,var_03 * 0.5,0,0.1);
			}
			else if(isdefined(self.last_ent.script_noteworthy) && self.last_ent.script_noteworthy == "jump")
			{
				self moveto(self.current_ent.origin,var_03 * 0.5,0.1,0);
			}
			else
			{
				self moveto(self.current_ent.origin,var_03);
			}

			self waittill("movedone");
			if(isdefined(self.current_ent.target))
			{
				var_04 = getent(self.current_ent.target,"targetname");
				self.last_ent = self.current_ent;
				self.current_ent = var_04;
			}
			else
			{
				return;
			}

			continue;
		}
	}
}

//Function Number: 58
popinpopout()
{
	level endon("shutdown_hologram");
	self endon("death");
	var_00 = 4;
	var_01 = 1;
	var_02 = self.current_ent.origin;
	var_03 = self.last_ent.origin;
	if(self.current_ent == self.last_ent)
	{
		var_03 = self.original_position;
	}

	wait(var_00);
	for(;;)
	{
		if(isdefined(self))
		{
			var_04 = distance(var_03,var_02);
			var_05 = var_04 / level.firingrange.round_target_unit_per_second;
			self moveto(var_03,var_05);
			self waittill("movedone");
			wait(var_01);
			var_04 = distance(var_03,var_02);
			var_05 = var_04 / level.firingrange.round_target_unit_per_second;
			self moveto(var_02,var_05);
			self waittill("movedone");
			wait(var_00);
		}
	}
}

//Function Number: 59
movebackforth()
{
	level endon("shutdown_hologram");
	self endon("death");
	var_00 = undefined;
	var_01 = undefined;
	if(isdefined(self.last_ent.script_noteworthy) && self.last_ent.script_noteworthy == "jump")
	{
		var_00 = self.last_ent;
		var_01 = var_00.origin;
		self.last_ent = getent(var_00.targetname,"target");
	}

	var_02 = self.current_ent.origin;
	var_03 = self.last_ent.origin;
	if(self.current_ent == self.last_ent)
	{
		var_03 = self.original_position;
	}

	for(;;)
	{
		if(isdefined(self))
		{
			if(isdefined(var_01))
			{
				wait(2);
				var_04 = distance(var_01,var_02);
				var_05 = var_04 / level.firingrange.round_target_unit_per_second;
				self moveto(var_01,var_05 * 0.5,0,0.1);
				self waittill("movedone");
				var_04 = distance(var_01,var_03);
				var_05 = var_04 / level.firingrange.round_target_unit_per_second;
				self moveto(var_03,var_05 * 0.5,0.1,0);
				self waittill("movedone");
				wait(2);
				var_04 = distance(var_01,var_03);
				var_05 = var_04 / level.firingrange.round_target_unit_per_second;
				self moveto(var_01,var_05 * 0.5,0,0.1);
				self waittill("movedone");
				var_04 = distance(var_01,var_02);
				var_05 = var_04 / level.firingrange.round_target_unit_per_second;
				self moveto(var_02,var_05 * 0.5,0.1,0);
				self waittill("movedone");
			}
			else
			{
				var_04 = distance(var_05,var_04);
				var_05 = var_05 / level.firingrange.round_target_unit_per_second;
				self moveto(var_03,var_05);
				self waittill("movedone");
				var_04 = distance(var_02,var_03);
				var_05 = var_04 / level.firingrange.round_target_unit_per_second;
				self moveto(var_02,var_05);
				self waittill("movedone");
			}
		}
	}
}

//Function Number: 60
score_handler()
{
	level endon("shutdown_hologram");
	for(;;)
	{
		var_00 = [];
		for(var_01 = 0;var_01 < self.hits.size;var_01++)
		{
			self.hits[var_01].time = self.hits[var_01].time - 1;
			if(self.hits[var_01].time > 0)
			{
				var_00[var_00.size] = self.hits[var_01];
			}
		}

		self.hits = var_00;
		foreach(var_03 in self.hits)
		{
		}

		wait(0.05);
	}
}

//Function Number: 61
target_handler(param_00)
{
	level endon("shutdown_hologram");
	self.hits = [];
	self.aimassist_target.health = 9999;
	self.aimassist_target.maxhealth = 9999;
	self.maxhealth = 9999;
	self.health = self.maxhealth;
	self.fakehealth = 100;
	self setcandamage(1);
	self.aimassist_target show();
	self.aimassist_target solid();
	self.aimassist_target enableaimassist();
	while(self.health > 0)
	{
		var_01 = undefined;
		var_02 = undefined;
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		var_0B = getmodifier(var_0A,var_08,param_00);
		var_0C = self gettagorigin("tag_head");
		var_0D = self gettagorigin("tag_chest");
		self.health = self.maxhealth;
		var_0E = self.fakehealth;
		var_0E = float(var_0E) - float(var_01) * var_0B;
		var_0E = maps\mp\_utility::rounddecimalplaces(var_0E,0);
		self.fakehealth = int(var_0E);
		if(self.fakehealth <= 0)
		{
			thread targetplaydeath(var_0D);
			self.health = 0;
			if(isdefined(var_02))
			{
				if(isdefined(var_08))
				{
					if(var_08 == "tag_head")
					{
						var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("killshot_headshot");
					}
					else if(var_08 == "tag_chest")
					{
						var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("mp_hit_kill");
					}
				}
			}

			self notify("death");
			continue;
		}

		if(isdefined(var_02))
		{
			if(isdefined(var_08) && var_08 == "tag_head")
			{
				var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("headshot");
				continue;
			}

			var_02 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("standard");
		}
	}
}

//Function Number: 62
targetplaydeath(param_00)
{
	playfx(level._effect["recovery_scoring_target_shutter_enemy"],param_00);
}

//Function Number: 63
deactivate_targets()
{
	level notify("shutdown_hologram");
}

//Function Number: 64
firing_range_setup_triggers()
{
	var_00 = getentarray("firing_range_round_trigger","targetname");
	return var_00;
}

//Function Number: 65
firing_range_setup_target_logic()
{
	var_00 = getentarray("target_logic_point","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.script_index))
		{
			var_04 = int(var_03.script_index);
			if(!isarray(var_01[var_04]))
			{
				var_05 = [var_03];
				var_01[var_04] = var_05;
			}
			else
			{
				var_01[var_04] = common_scripts\utility::add_to_array(var_01[var_04],var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 66
firing_range_setup_env()
{
	var_00 = getentarray("round_environment","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_03 hide();
		var_03 notsolid();
		var_04 = undefined;
		if(isdefined(var_03.script_index))
		{
			var_04 = int(var_03.script_index);
		}

		if(isdefined(var_04))
		{
			if(!isarray(var_01[var_04]))
			{
				var_05 = [var_03];
				var_01[var_04] = var_05;
				continue;
			}

			var_01[var_04] = common_scripts\utility::add_to_array(var_01[var_04],var_03);
		}
	}

	return var_01;
}

//Function Number: 67
firing_range_setup_env_vfx()
{
	var_00 = common_scripts\utility::getstructarray("round_environment","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = undefined;
		if(isdefined(var_03.script_index))
		{
			var_04 = int(var_03.script_index);
		}

		if(isdefined(var_04))
		{
			if(!isarray(var_01[var_04]))
			{
				var_05 = [var_03];
				var_01[var_04] = var_05;
				continue;
			}

			var_01[var_04] = common_scripts\utility::add_to_array(var_01[var_04],var_03);
		}
	}

	return var_01;
}

//Function Number: 68
firing_range_setup_targets()
{
	var_00 = getentarray("target_enemy","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_03.alive = 0;
		var_03.pers["team"] = "axis";
		var_03.team = "axis";
		var_03.origin_ent = getent(var_03.target,"targetname");
		var_03.aimassist_target = getent(var_03.origin_ent.target,"targetname");
		var_03.aimassist_target vehicle_jetbikesethoverforcescale(var_03);
		var_03.aimassist_target.pers["team"] = "axis";
		var_03.aimassist_target.team = "axis";
		var_03.original_position = var_03.origin;
		var_03.original_orientation = var_03.angles;
		var_03.aimassist_target hide();
		var_03.aimassist_target notsolid();
		var_03 hide();
		var_03 notsolid();
		if(isdefined(var_03.script_index))
		{
			var_04 = int(var_03.script_index);
			if(!isarray(var_01[var_04]))
			{
				var_05 = [];
				var_01[var_04] = var_05;
			}

			if(isdefined(var_03.script_group))
			{
				var_06 = int(var_03.script_group);
				if(!isarray(var_01[var_04][var_06]))
				{
					var_07 = [var_03];
					var_01[var_04][var_06] = var_07;
				}
				else
				{
					var_01[var_04][var_06] = common_scripts\utility::add_to_array(var_01[var_04][var_06],var_03);
				}
			}
		}
	}

	return var_01;
}

//Function Number: 69
target_handle_death()
{
	level endon("shutdown_hologram");
	self waittill("death");
	level notify("target_died");
	target_reset();
}

//Function Number: 70
target_handle_stop()
{
	self endon("death");
	level waittill("shutdown_hologram");
	target_reset();
}

//Function Number: 71
target_reset()
{
	self setcandamage(0);
	self hide();
	self notsolid();
	self.alive = 0;
	if(isdefined(self.aimassist_target))
	{
		self.aimassist_target disableaimassist();
	}
}

//Function Number: 72
lerp_spot_intensity(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	if(level.currentgen && isdefined(var_03) == 0)
	{
		return;
	}

	var_04 = var_03 getlightintensity();
	var_03.endintensity = param_02;
	var_05 = 0;
	while(var_05 < param_01)
	{
		var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
		var_05 = var_05 + 0.05;
		var_03 setlightintensity(var_06);
		wait(0.05);
	}

	var_03 setlightintensity(param_02);
}

//Function Number: 73
lerp_spot_intensity_array(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = var_05 getlightintensity();
		var_05.endintensity = param_02;
		var_07 = 0;
		while(var_07 < param_01)
		{
			var_08 = var_06 + param_02 - var_06 * var_07 / param_01;
			var_07 = var_07 + 0.05;
			var_05 setlightintensity(var_08);
			wait(0.05);
		}

		var_05 setlightintensity(param_02);
	}
}

//Function Number: 74
monitor_weapon_ammo_count(param_00)
{
	self endon("enter_lobby");
	while(level.in_firingrange == 1)
	{
		var_01 = self getfractionmaxammo(param_00);
		if(var_01 <= 0.25)
		{
			self givemaxammo(param_00);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 75
riotshieldcleanup()
{
	if(isdefined(self.riotshieldentity))
	{
		self.riotshieldentity thread maps\mp\_riotshield::damagethendestroyriotshield();
	}
}

//Function Number: 76
grenadecleanup(param_00)
{
	if(isdefined(level.grenades) && isarray(level.grenades))
	{
		foreach(var_02 in level.grenades)
		{
			if(isdefined(var_02) && !isremovedentity(var_02))
			{
				if(!isdefined(self) || !isdefined(var_02.owner) || isremovedentity(var_02.owner))
				{
					if(!isdefined(var_02.weaponname))
					{
						continue;
					}
					else if(maps\mp\_utility::strip_suffix(var_02.weaponname,"_lefthand") == "explosive_drone_mp")
					{
						var_02 thread maps\mp\_explosive_drone::explosivegrenadedeath();
					}
					else
					{
						var_02 notify("death");
						var_02 thread delaydelete();
					}

					continue;
				}

				if(var_02.owner == self)
				{
					if(!isdefined(var_02.weaponname))
					{
						continue;
					}
					else
					{
						if(maps\mp\_utility::strip_suffix(var_02.weaponname,"_lefthand") == "explosive_drone_mp")
						{
							var_02 thread maps\mp\_explosive_drone::explosivegrenadedeath();
							continue;
						}

						if(maps\mp\_utility::strip_suffix(var_02.weaponname,"_lefthand") == "exoknife_mp")
						{
							if(isdefined(param_00) && param_00 == 1)
							{
								var_03 = getdvarint("virtualLobbyInFiringRange",0);
								if(var_03 == 1 && level.in_firingrange == 1)
								{
									var_02 maps\mp\_exoknife::exo_knife_restock();
								}
							}
							else
							{
								var_02 notify("death");
								var_02 thread delaydelete();
							}

							continue;
						}

						var_02 notify("death");
						var_02 thread delaydelete();
					}
				}
			}
		}
	}

	thread dronecleanup();
}

//Function Number: 77
dronecleanup()
{
	if(isdefined(level.trackingdrones) && isarray(level.trackingdrones))
	{
		foreach(var_01 in level.trackingdrones)
		{
			if(isdefined(var_01) && !isremovedentity(var_01))
			{
				if(!isdefined(self) || !isdefined(var_01.owner) || isremovedentity(var_01.owner))
				{
					var_01 thread maps\mp\_tracking_drone::trackingdroneexplode();
					continue;
				}

				if(var_01.owner == self)
				{
					var_01 thread maps\mp\_tracking_drone::trackingdroneexplode();
				}
			}
		}
	}
}

//Function Number: 78
delaydelete()
{
	wait(0.05);
	if(isdefined(self) && !isremovedentity(self))
	{
		self delete();
	}
}

//Function Number: 79
monitor_grenade_count(param_00,param_01)
{
	self endon("enter_lobby");
	var_02 = 0;
	var_03 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	if(var_03 == "smoke_grenade_var_mp" || var_03 == "stun_grenade_var_mp" || var_03 == "emp_grenade_var_mp" || var_03 == "paint_grenade_var_mp")
	{
		var_02 = 1;
	}

	if(var_03 == "explosive_drone_mp")
	{
		thread enforceexplosivedronelimit();
	}

	while(level.in_firingrange == 1)
	{
		if(var_02 == 1)
		{
			wait(1.5);
			if(!param_01)
			{
				var_04 = self getammocount("paint_grenade_var_mp");
				var_05 = self getammocount("smoke_grenade_var_mp");
				var_06 = self getammocount("emp_grenade_var_mp");
				var_07 = self getammocount("stun_grenade_var_mp");
				if(var_04 == 0 && var_05 == 0 && var_06 == 0 && var_07 == 0)
				{
					self givestartammo("paint_grenade_var_mp");
					self givestartammo("smoke_grenade_var_mp");
					self givestartammo("emp_grenade_var_mp");
					self givestartammo("stun_grenade_var_mp");
				}
			}
			else
			{
				var_08 = self getammocount("paint_grenade_var_mp_lefthand");
				var_09 = self getammocount("smoke_grenade_var_mp_lefthand");
				var_0A = self getammocount("emp_grenade_var_mp_lefthand");
				var_0B = self getammocount("stun_grenade_var_mp_lefthand");
				if(var_08 == 0 && var_09 == 0 && var_0A == 0 && var_0B == 0)
				{
					self givestartammo("paint_grenade_var_mp_lefthand");
					self givestartammo("smoke_grenade_var_mp_lefthand");
					self givestartammo("emp_grenade_var_mp_lefthand");
					self givestartammo("stun_grenade_var_mp_lefthand");
				}
			}

			continue;
		}
		else
		{
			wait(1.5);
			var_0C = self getammocount(param_00);
			if(var_0C == 0)
			{
				maps\mp\gametypes\_class::giveoffhand(param_00);
				continue;
			}
		}

		wait(0.5);
	}
}

//Function Number: 80
enforceexplosivedronelimit()
{
	self endon("enter_lobby");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "explosive_drone_mp")
		{
			if(isdefined(level.grenades) && isarray(level.grenades))
			{
				foreach(var_00 in level.grenades)
				{
					if(isdefined(var_00) && !isremovedentity(var_00) && isdefined(self) && isdefined(var_00.owner) && isdefined(var_00.weaponname))
					{
						if(maps\mp\_utility::strip_suffix(var_00.weaponname,"_lefthand") == "explosive_drone_mp" && var_00.owner == self)
						{
							if(isdefined(var_00.explosivedrone))
							{
								var_00.explosivedrone thread maps\mp\_explosive_drone::explosiveheaddeath();
								continue;
							}

							var_00 thread maps\mp\_explosive_drone::explosivegrenadedeath();
						}
					}
				}
			}
		}
	}
}

//Function Number: 81
showtransition_cg(param_00)
{
	level endon("shutdown_hologram");
	var_01 = 0;
	var_02 = [];
	foreach(var_04 in level.firingrange.allenvarray[param_00])
	{
		if(isdefined(var_04.classname) && var_04.classname == "script_model")
		{
			if(isdefined(var_04.model) && issubstr(var_04.model,"rec_holo_range"))
			{
				var_02[var_01] = var_04.model;
				if(!issubstr(var_04.model,"trans"))
				{
					var_05 = var_04.model + "_trans";
					var_04 setmodel(var_05);
				}

				var_04 show();
			}
			else
			{
				var_02[var_01] = undefined;
			}
		}

		var_01++;
	}

	return var_02;
}

//Function Number: 82
hidetransitionmeshes_cg(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.firingrange.allenvarray[param_00])
	{
		if(isdefined(var_04.classname) && var_04.classname == "script_model")
		{
			if(isdefined(var_04.model) && issubstr(var_04.model,"rec_holo_range"))
			{
				if(isstring(param_01[var_02]))
				{
					var_04 hide();
					var_04 setmodel(param_01[var_02]);
				}
			}
		}

		var_02++;
	}
}