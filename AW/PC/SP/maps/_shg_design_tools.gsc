/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_shg_design_tools.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 874 ms
 * Timestamp: 10/27/2023 2:00:24 AM
*******************************************************************/

//Function Number: 1
anim_simple(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isarray(param_00))
	{
		foreach(var_03 in param_00)
		{
			param_01 = var_03.animation;
			var_03 thread identify_and_play_anim(param_01,self);
		}

		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00.animation;
	}

	param_00 identify_and_play_anim(param_01,self);
}

//Function Number: 2
identify_and_play_anim(param_00,param_01)
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(isanimloop(param_00))
	{
		if(isalive(self) && self.var_567D == "generic")
		{
			param_01 maps\_anim::anim_generic_loop(self,param_00,"stop_loop");
		}
		else if(isalive(self))
		{
			param_01 maps\_anim::anim_loop_solo(self,param_00,"stop_loop");
		}
	}
	else if(isalive(self) && isdefined(self.animname) && self.animname != "generic")
	{
		param_01 maps\_anim::anim_single_solo(self,param_00);
	}
	else if(isalive(self))
	{
		param_01 maps\_anim::anim_generic(self,param_00);
	}

	self notify("anim_simple_done",param_00);
}

//Function Number: 3
isanimloop(param_00)
{
	if(isanimloop_animname(param_00,"generic"))
	{
		return 1;
	}
	else if(isdefined(self.animname) && isanimloop_animname(param_00,self.animname))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
isanimloop_animname(param_00,param_01)
{
	if(isarray(level.scr_anim[param_01]))
	{
		if(isarray(level.scr_anim[param_01][param_00]))
		{
			if(isdefined(level.scr_anim[param_01][param_00][0]))
			{
				self.var_567D = param_01;
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 5
notify_on_death(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		level notify(param_01);
		return;
	}

	if(isarray(param_00))
	{
		while(isdefined(param_00) && param_00.size > 0)
		{
			param_00 = maps\_utility::array_removedead_or_dying(param_00);
			param_00 = common_scripts\utility::array_removeundefined(param_00);
			wait 0.05;
		}
	}
	else
	{
		param_00 waittill("death");
	}

	level notify(param_01);
}

//Function Number: 6
gravity_drop(param_00,param_01,param_02)
{
	var_03 = gettime() * 0.001;
	while(self.origin[2] > param_01[2])
	{
		var_04 = param_02 * 0.5;
		var_05 = 1 * var_04 / 2;
		var_06 = gettime() * 0.001 - var_03;
		self.origin = self.origin + (0,0,var_05 * var_06 - 0.5 * var_04 * squared(var_06));
		wait 0.05;
	}
}

//Function Number: 7
gravity_point(param_00,param_01,param_02)
{
	var_03 = param_02 * 0.5;
	var_04 = 1;
	var_05 = gettime() * 0.001 - param_00;
	var_06 = var_04 * var_05 - 0.5 * var_03 * squared(var_05);
	return (0,0,var_06);
}

//Function Number: 8
gravity_arc(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05 = gettime() * 0.001;
	if(isdefined(self) && !isdefined(self.apex))
	{
		self.apex = 0;
	}

	while(isdefined(self) && gettime() * 0.001 <= var_05 + param_02)
	{
		self.last_z = self.origin[2];
		self.origin = arc_point(var_05,param_00,param_01,param_02,param_03,param_04);
		if(self.origin[2] < self.last_z)
		{
			self.apex = 1;
		}

		wait(0.05);
	}

	self notify("item_landed");
}

//Function Number: 9
arc_point(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = 386;
	}

	if(!isdefined(param_05))
	{
		param_05 = 386;
	}

	var_07 = param_04;
	if(self.apex)
	{
		var_07 = param_05;
	}

	var_08 = var_07 * 0.5;
	param_06 = param_03 * var_08 / 2;
	var_09 = gettime() * 0.001 - param_00;
	var_0A = param_06 * var_09 - 0.5 * var_08 * squared(var_09);
	var_0B = maps\_utility::linear_interpolate(var_09 / param_03,param_01,param_02) + (0,0,var_0A);
	return var_0B;
}

//Function Number: 10
anim_stop(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		param_00 maps\_utility::anim_stopanimscripted();
	}

	maps\_utility::anim_stopanimscripted();
	if(isdefined(param_00))
	{
		param_00 notify("stop_first_frame");
	}

	self notify("stop_first_frame");
	if(isdefined(param_02) && param_02 && isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 11
end_anim_loop(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = [self];
	}

	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.loops) && var_02.loops > 0)
		{
			var_02.loops = 0;
		}

		if(isdefined(var_02.loopanims) && var_02.loopanims.size > 0)
		{
			var_02.loopanims = [];
		}
	}
}

//Function Number: 12
remove_hint()
{
	if(isdefined(level.current_hint))
	{
		level.current_hint destroy();
	}
}

//Function Number: 13
hide_display_hint()
{
	if(isdefined(level.current_hint))
	{
		level.current_hint.alpha = 0;
	}
}

//Function Number: 14
anim_simple_notify(param_00,param_01,param_02)
{
	level waittill(param_02);
	if(isdefined(param_00.animname) && param_00.animname != "generic")
	{
		param_00 maps\_anim::setanimtree();
	}

	anim_simple(param_00,param_01);
}

//Function Number: 15
isvehiclealive(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.health < 1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
white_out(param_00,param_01,param_02)
{
	var_03 = self;
	if(!isplayer(var_03))
	{
		var_03 = level.player;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_04 = newclienthudelem(var_03);
	var_04 setshader("white",1280,720);
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.alpha = param_02;
	wait(param_00);
	var_04 fadeovertime(param_01);
	var_04.alpha = 0;
}

//Function Number: 17
fade_to_black(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(!isplayer(var_04))
	{
		var_04 = level.player;
	}

	var_04.auxillary_hud = newclienthudelem(var_04);
	var_04.auxillary_hud setshader("black",1280,720);
	var_04.auxillary_hud.horzalign = "fullscreen";
	var_04.auxillary_hud.vertalign = "fullscreen";
	var_04.auxillary_hud.alpha = param_02;
	wait(param_00);
	var_04.auxillary_hud fadeovertime(param_01);
	var_04.auxillary_hud.alpha = param_03;
}

//Function Number: 18
create_pulsing_text(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(issplitscreen())
	{
		param_00 = param_00 + 2;
	}

	var_07 = undefined;
	if(isdefined(param_03))
	{
		var_07 = get_pulsing_hud(-60,undefined,param_03,1,param_04,param_05);
	}
	else
	{
		var_07 = get_pulsing_hud(-60,undefined,undefined,1,param_04,param_05);
	}

	var_08 = var_07 huddata(param_00,param_01);
	var_08.label = param_02;
	return var_08;
}

//Function Number: 19
get_pulsing_hud(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_06 = undefined;
	if(!level.console)
	{
		var_06 = -250;
	}
	else if(!isdefined(param_00))
	{
		var_06 = -225;
	}
	else
	{
		var_06 = param_00;
	}

	if(param_03)
	{
		var_06 = param_00;
	}

	if(!isdefined(param_01))
	{
		var_07 = 100;
	}
	else
	{
		var_07 = param_02;
	}

	if(isdefined(param_02))
	{
		var_08 = newclienthudelem(param_02);
	}
	else
	{
		var_08 = newhudelem();
	}

	if(!isdefined(param_04))
	{
		param_04 = (0.8,1,0.8);
	}

	if(!isdefined(param_05))
	{
		param_05 = (0.3,0.6,0.3);
	}

	var_08.alignx = "left";
	var_08.aligny = "middle";
	var_08.horzalign = "right";
	var_08.vertalign = "top";
	var_08.x = var_06;
	var_08.y = var_07;
	var_08.fontscale = 1.6;
	var_08.color = param_04;
	var_08.font = "objective";
	var_08.glowcolor = param_05;
	var_08.glowalpha = 1;
	var_08.foreground = 1;
	var_08.hidewheninmenu = 0;
	var_08.hidewhendead = 1;
	return var_08;
}

//Function Number: 20
huddata(param_00,param_01)
{
	self.alignx = "center";
	self.aligny = "top";
	self.horzalign = "center";
	self.vertalign = "middle";
	self.x = param_01;
	self.y = -160 + 15 * param_00;
	self.font = "objective";
	self.foreground = 1;
	self.hidewheninmenu = 1;
	self.hidewhendead = 1;
	self.sort = 2;
	self.fontscale = 1.15;
	return self;
}

//Function Number: 21
spawn_tag_origin_monitor(param_00)
{
	if(!isdefined(level.monitored_tag_origins))
	{
		level.monitored_tag_origins = [];
	}

	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 angles_and_origin(self);
	if(isdefined(param_00))
	{
		var_01.tag_idx = param_00;
	}

	level.monitored_tag_origins[level.monitored_tag_origins.size] = var_01;
	level.monitored_tag_origins = common_scripts\utility::array_removeundefined(level.monitored_tag_origins);
	iprintln(level.monitored_tag_origins.size);
	return var_01;
}

//Function Number: 22
remove_monitored_tags(param_00)
{
	if(isdefined(level.monitored_tag_origins))
	{
		var_01 = 0;
		foreach(var_03 in level.monitored_tag_origins)
		{
			if(isdefined(var_03.tag_idx) && var_03.tag_idx == param_00)
			{
				var_03 delete();
				var_01++;
			}
		}

		iprintln(var_01);
	}
}

//Function Number: 23
angles_and_origin(param_00)
{
	if(isdefined(param_00.origin))
	{
		self.origin = param_00.origin;
	}

	if(isdefined(param_00.angles))
	{
		self.angles = param_00.angles;
	}
}

//Function Number: 24
array_combine_multiple(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = common_scripts\utility::array_combine(param_00,param_01);
	if(isdefined(param_02))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_02);
	}

	if(isdefined(param_03))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_03);
	}

	if(isdefined(param_04))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_04);
	}

	if(isdefined(param_05))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_05);
	}

	if(isdefined(param_06))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_06);
	}

	if(isdefined(param_07))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_07);
	}

	if(isdefined(param_08))
	{
		var_09 = common_scripts\utility::array_combine(var_09,param_08);
	}

	return var_09;
}

//Function Number: 25
lerp_to_position(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = distance(param_00,self.origin);
	var_05 = 0;
	var_06 = self.origin;
	while(var_05 < var_04)
	{
		var_07 = getlerpfraction(self.origin,param_00,param_01,param_02);
		if(var_07 == 0)
		{
			break;
		}

		self.origin = vectorlerp(self.origin,param_00,var_07);
		if(isdefined(param_03))
		{
			self.angles = self.angles + param_03;
		}

		var_05 = distance(self.origin,var_06);
		wait 0.05;
	}

	self notify("lerp_complete");
}

//Function Number: 26
getlerpfraction(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00,param_01);
	if(param_02 == 0 || var_04 == 0)
	{
		return 0;
	}

	var_05 = param_02 / var_04 * 0.05;
	if(var_05 > 0)
	{
		return var_05;
	}

	return 0;
}

//Function Number: 27
getperlinovertime(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		var_05 = 10;
		var_06 = 20;
		var_07 = 30;
	}
	else
	{
		var_05 = var_07;
		var_06 = var_06 + 10;
		var_07 = var_05 + 20;
	}

	var_08 = (perlinnoise2d(gettime() * 0.001 * 0.05,var_05,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,var_06,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,var_07,param_00,param_01,param_02) * param_03);
	return var_08;
}

//Function Number: 28
angles_origin(param_00)
{
	if(isdefined(param_00.origin))
	{
		self.origin = param_00.origin;
	}

	if(isdefined(param_00.angles))
	{
		self.angles = param_00.angles;
	}
}

//Function Number: 29
delete_at_goal()
{
	self waittill("goal");
	self delete();
}

//Function Number: 30
delete_auto()
{
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 31
percentchance(param_00)
{
	if(randomint(100) <= param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
actual_spawn(param_00)
{
	if(!isdefined(self.count) || self.count < 1)
	{
		self.count = 1;
	}

	var_01 = maps\_utility::spawn_ai(1);
	maps\_utility::spawn_failed(var_01);
	if(isdefined(param_00))
	{
		while(!isdefined(var_01))
		{
			self.count = 1;
			var_01 = maps\_utility::spawn_ai(1);
			maps\_utility::spawn_failed(var_01);
			wait 0.05;
		}
	}

	return var_01;
}

//Function Number: 33
spawn_enemy_group(param_00,param_01,param_02)
{
	if(isarray(param_01))
	{
		var_03 = param_01;
	}
	else
	{
		param_00[0] = param_02;
	}

	var_04 = [];
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		var_06 = common_scripts\utility::random(var_03);
		var_07 = var_06 actual_spawn();
		if(!isdefined(var_07))
		{
			continue;
		}

		if(isdefined(param_02))
		{
			var_07 setgoalvolumeauto(param_02);
		}

		var_04[var_04.size] = var_07;
		wait(0.1);
	}

	return var_04;
}

//Function Number: 34
trigger_to_notify(param_00,param_01)
{
	waittill_trigger_with_name(param_00);
	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	level notify(param_01);
}

//Function Number: 35
stopfxonnotify(param_00,param_01,param_02,param_03)
{
	self waittill(param_03);
	if(isdefined(param_01))
	{
		stopfxontag(param_00,param_01,param_02);
	}
}

//Function Number: 36
stopfxontagdelay(param_00,param_01,param_02,param_03)
{
	wait(param_03);
	if(isdefined(param_01))
	{
		stopfxontag(param_00,param_01,param_02);
	}
}

//Function Number: 37
waittill_trigger_with_name(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
		var_01 = getent(param_00,"script_noteworthy");
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 waittill("trigger");
}

//Function Number: 38
impulse_wave(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 300;
	}

	var_04 = [];
	foreach(var_06 in param_00)
	{
		if(distance(var_06.origin,param_02) < param_01)
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(var_04.size <= 0)
	{
		return;
	}

	var_04 = sortbydistance(var_04,param_02);
	var_08 = param_02;
	foreach(var_06 in var_04)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		if(var_06 maps\_vehicle::isvehicle())
		{
			var_06 dodamage(var_06.health * 2,param_02);
			continue;
		}

		var_0A = distance(var_08,var_06.origin);
		var_0B = var_0A / param_03 * 0.05;
		wait(var_0B);
		var_08 = var_06.origin;
		var_0C = vectornormalize(var_06 gettagorigin("tag_eye") - param_02);
		var_0C = vectornormalize(var_0C + (0,0,0.2));
		var_06 startragdollfromimpact("torso_lower",var_0C * 7000);
		var_06 thread common_scripts\utility::delaycall(2,::kill);
	}
}

//Function Number: 39
sortbydistanceauto(param_00,param_01)
{
	return sortbydistance(param_00,param_01,0,1);
}

//Function Number: 40
set_entflag_on_notify(param_00)
{
	if(!maps\_utility::ent_flag_exist(param_00))
	{
		maps\_utility::ent_flag_init(param_00);
	}

	self waittill(param_00);
	maps\_utility::ent_flag(param_00);
}

//Function Number: 41
trigger_to_flag(param_00,param_01)
{
	if(!common_scripts\utility::flag_exist(param_01))
	{
		common_scripts\utility::flag_init(param_01);
	}

	var_02 = getentarray(param_00,"targetname");
	var_02[0] waittill("trigger");
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 42
flag_wait_either_timeout(param_00,param_01)
{
	var_02 = randomfloat(1000);
	var_03 = "flag_or_timeout" + var_02;
	level endon(var_03);
	level thread maps\_utility::notify_delay(var_03,param_01);
	common_scripts\utility::flag_wait(param_00);
}

//Function Number: 43
killonbadpath()
{
	self endon("death");
	self waittill("bad_path");
	if(!isdefined(self.deletable_magic_bullet_shield) || !self.deletable_magic_bullet_shield)
	{
		self kill();
	}
}

//Function Number: 44
offset_position_from_tag(param_00,param_01,param_02)
{
	var_03 = self gettagangles(param_01);
	var_04 = self gettagorigin(param_01);
	if(param_00 == "up")
	{
		return var_04 + anglestoup(var_03) * param_02;
	}

	if(param_00 == "down")
	{
		return var_04 + anglestoup(var_03) * param_02 * -1;
	}

	if(param_00 == "right")
	{
		return var_04 + anglestoright(var_03) * param_02;
	}

	if(param_00 == "left")
	{
		return var_04 + anglestoright(var_03) * param_02 * -1;
	}

	if(param_00 == "forward")
	{
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "backward")
	{
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "forwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * 1;
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "forwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02;
	}
}

//Function Number: 45
getclosestauto(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = distance(var_05.origin,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_05;
	}

	return var_03;
}

//Function Number: 46
getthing(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	var_02 = common_scripts\utility::getstruct(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	var_02 = getnode(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	var_02 = getvehiclenode(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}
}

//Function Number: 47
getthingarray(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	if(var_02.size > 0)
	{
		return var_02;
	}

	var_02 = common_scripts\utility::getstructarray(param_00,param_01);
	if(var_02.size > 0)
	{
		return var_02;
	}

	var_02 = getnodearray(param_00,param_01);
	if(var_02.size > 0)
	{
		return var_02;
	}

	var_02 = getvehiclenodearray(param_00,param_01);
	if(var_02.size > 0)
	{
		return var_02;
	}
}

//Function Number: 48
make_deaddrone(param_00)
{
	var_01 = maps\_spawner::spawner_dronespawn(param_00);
	var_01.animname = "generic";
	var_01 maps\_utility::gun_remove();
	return var_01;
}

//Function Number: 49
iprintlnsubtitles(param_00,param_01)
{
	if(!isdefined(level.player.subtitles))
	{
		level.player.subtitles = [];
		level.subtitle_entry_num = 0;
	}

	var_02 = newclienthudelem(level.player);
	var_02.x = 320;
	var_02.y = 325;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.fontscale = 1.5;
	var_02 settext(param_00);
	var_02.alpha = 0;
	var_02.color = (1,1,1);
	var_02.glowcolor = (0.6,0.6,0.9);
	var_02.glowalpha = 0.4;
	var_02.sort = -10;
	var_02.font = "objective";
	level.player.subtitles[level.player.subtitles.size] = var_02;
	level notify("new_subtitle_created");
	level.player thread delete_subtitle_in(10,var_02,level.subtitle_entry_num);
	level.player thread show_subtitles(var_02,level.subtitle_entry_num);
	level.subtitle_entry_num = level.subtitle_entry_num + 1 % 10;
	if(isdefined(param_01))
	{
		wait(param_01);
	}
}

//Function Number: 50
show_subtitles(param_00,param_01)
{
	var_02 = "delete_subtitle_hud" + param_01;
	var_03 = 0;
	var_04 = 19;
	param_00 fadeovertime(0.5);
	param_00.alpha = 1;
	level endon(var_02);
	while(isdefined(param_00))
	{
		level waittill("new_subtitle_created");
		var_03++;
		if(!isdefined(param_00))
		{
			break;
		}

		param_00 moveovertime(0.35);
		param_00.y = 325 + var_03 * var_04;
		param_00.color = (1,1,1);
		param_00.glowalpha = 0;
		param_00.alpha = 0.9 - var_03 / 5;
		wait 0.05;
	}
}

//Function Number: 51
delete_subtitle_in(param_00,param_01,param_02)
{
	var_03 = "delete_subtitle_hud" + param_02;
	level thread maps\_utility::notify_delay(var_03,param_00);
	level waittill(var_03);
	self.subtitles = common_scripts\utility::array_remove(self.subtitles,param_01);
	param_01 destroy();
}

//Function Number: 52
convert_8bit_color(param_00)
{
	return param_00 / 255;
}

//Function Number: 53
get_standard_glow_text(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = param_00;
	var_0B = param_05 * param_02 + param_01;
	if(!isdefined(param_06))
	{
		param_06 = (0.8,1,0.8);
	}

	if(!isdefined(param_07))
	{
		param_07 = (param_06[0] / 2,param_06[1] / 2,param_06[2] / 2);
	}

	if(!isdefined(param_03))
	{
		param_03 = "center";
	}

	if(!isdefined(param_04))
	{
		param_04 = "middle";
	}

	if(!isdefined(param_08))
	{
		param_08 = "center";
	}

	if(!isdefined(param_09))
	{
		param_09 = "middle";
	}

	var_0C = newclienthudelem(level.player);
	var_0C.alignx = param_03;
	var_0C.aligny = param_04;
	var_0C.horzalign = param_08;
	var_0C.vertalign = param_09;
	var_0C.x = var_0A;
	var_0C.y = var_0B;
	var_0C.fontscale = 1.6;
	var_0C.color = param_06;
	var_0C.font = "objective";
	var_0C.glowcolor = param_07;
	var_0C.glowalpha = 1;
	var_0C.foreground = 1;
	var_0C.hidewheninmenu = 1;
	var_0C.hidewhendead = 1;
	return var_0C;
}

//Function Number: 54
notify_relay(param_00,param_01,param_02,param_03)
{
	param_00 waittill(param_01);
	param_02 notify(param_03);
}