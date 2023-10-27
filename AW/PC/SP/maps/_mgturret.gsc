/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_mgturret.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1293 ms
 * Timestamp: 10/27/2023 1:59:55 AM
*******************************************************************/

//Function Number: 1
init_mgturretsettings()
{
	level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
	level.mgturretsettings["easy"]["suppressionTime"] = 3;
	level.mgturretsettings["easy"]["accuracy"] = 0.38;
	level.mgturretsettings["easy"]["aiSpread"] = 2;
	level.mgturretsettings["easy"]["playerSpread"] = 0.5;
	level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
	level.mgturretsettings["medium"]["suppressionTime"] = 3;
	level.mgturretsettings["medium"]["accuracy"] = 0.38;
	level.mgturretsettings["medium"]["aiSpread"] = 2;
	level.mgturretsettings["medium"]["playerSpread"] = 0.5;
	level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
	level.mgturretsettings["hard"]["suppressionTime"] = 3;
	level.mgturretsettings["hard"]["accuracy"] = 0.38;
	level.mgturretsettings["hard"]["aiSpread"] = 2;
	level.mgturretsettings["hard"]["playerSpread"] = 0.5;
	level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
	level.mgturretsettings["fu"]["suppressionTime"] = 3;
	level.mgturretsettings["fu"]["accuracy"] = 0.38;
	level.mgturretsettings["fu"]["aiSpread"] = 2;
	level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

//Function Number: 2
main()
{
	if(getdvar("mg42") == "")
	{
		setdvar("mgTurret","off");
	}

	level.magic_distance = 24;
	var_00 = getentarray("turretInfo","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] delete();
	}
}

//Function Number: 3
portable_mg_behavior()
{
	self detach("weapon_mg42_carry","tag_origin");
	self endon("death");
	self.goalradius = level.default_goalradius;
	if(isdefined(self.target))
	{
		var_00 = getnode(self.target,"targetname");
		if(isdefined(var_00))
		{
			if(isdefined(var_00.radius))
			{
				self.goalradius = var_00.radius;
			}

			self setgoalnode(var_00);
		}
	}

	while(!isdefined(self.node))
	{
		wait(0.05);
	}

	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_00 = getnode(self.target,"targetname");
		var_01 = var_00;
	}

	if(!isdefined(var_01))
	{
		var_01 = self.node;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(var_01.type != "Turret")
	{
		return;
	}

	var_02 = gettakennodes();
	var_02[self.node.origin + ""] = undefined;
	if(isdefined(var_02[var_01.origin + ""]))
	{
		return;
	}

	var_03 = var_01.turret;
	if(isdefined(var_03.reserved))
	{
		return;
	}

	reserve_turret(var_03);
	if(var_03.issetup)
	{
		leave_gun_and_run_to_new_spot(var_03);
	}
	else
	{
		run_to_new_spot_and_setup_gun(var_03);
	}

	maps\_mg_penetration::gunner_think(var_01.turret);
}

//Function Number: 4
mg42_trigger()
{
	self waittill("trigger");
	level notify(self.targetname);
	level.mg42_trigger[self.targetname] = 1;
	self delete();
}

//Function Number: 5
mgturret_auto(param_00)
{
	param_00 waittill("trigger");
	var_01 = getaiarray("bad_guys");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(isdefined(var_01[var_02].script_mg42auto) && param_00.script_mg42auto == var_01[var_02].script_mg42auto)
		{
			var_01[var_02] notify("auto_ai");
		}
	}

	var_03 = getspawnerarray();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		if(isdefined(var_03[var_02].script_mg42auto) && param_00.script_mg42auto == var_03[var_02].script_mg42auto)
		{
			var_03[var_02].ai_mode = "auto_ai";
		}
	}

	maps\_spawner::kill_trigger(param_00);
}

//Function Number: 6
mg42_suppressionfire(param_00)
{
	self endon("death");
	self endon("stop_suppressionFire");
	if(!isdefined(self.suppresionfire))
	{
		self.suppresionfire = 1;
	}

	for(;;)
	{
		while(self.suppresionfire)
		{
			self settargetentity(param_00[randomint(param_00.size)]);
			wait(2 + randomfloat(2));
		}

		self cleartargetentity();
		while(!self.suppresionfire)
		{
			wait(1);
		}
	}
}

//Function Number: 7
manual_think(param_00)
{
	var_01 = self.origin;
	self waittill("auto_ai");
	param_00 notify("stopfiring");
	param_00 setmode("auto_ai");
	param_00 settargetentity(level.player);
}

//Function Number: 8
burst_fire_settings(param_00)
{
	if(param_00 == "delay")
	{
		return 0.2;
	}

	if(param_00 == "delay_range")
	{
		return 0.5;
	}

	if(param_00 == "burst")
	{
		return 0.5;
	}

	return 1.5;
}

//Function Number: 9
burst_fire_unmanned()
{
	self endon("death");
	self endon("stop_burst_fire_unmanned");
	if(isdefined(self.script_delay_min))
	{
		var_00 = self.script_delay_min;
	}
	else
	{
		var_00 = burst_fire_settings("delay");
	}

	if(isdefined(self.script_delay_max))
	{
		var_01 = self.script_delay_max - var_00;
	}
	else
	{
		var_01 = burst_fire_settings("delay_range");
	}

	if(isdefined(self.script_burst_min))
	{
		var_02 = self.script_burst_min;
	}
	else
	{
		var_02 = burst_fire_settings("burst");
	}

	if(isdefined(self.script_burst_max))
	{
		var_03 = self.script_burst_max - var_02;
	}
	else
	{
		var_03 = burst_fire_settings("burst_range");
	}

	var_04 = gettime();
	var_05 = "start";
	if(isdefined(self.shell_fx))
	{
		thread turret_shell_fx();
	}

	for(;;)
	{
		var_06 = var_04 - gettime() * 0.001;
		if(self isfiringturret() && var_06 <= 0)
		{
			if(var_05 != "fire")
			{
				var_05 = "fire";
				thread doshoot();
			}

			var_06 = var_02 + randomfloat(var_03);
			thread turrettimer(var_06);
			self waittill("turretstatechange");
			var_06 = var_00 + randomfloat(var_01);
			var_04 = gettime() + int(var_06 * 1000);
			continue;
		}

		if(var_05 != "aim")
		{
			var_05 = "aim";
		}

		thread turrettimer(var_06);
		self waittill("turretstatechange");
	}
}

//Function Number: 10
doshoot()
{
	self endon("death");
	self endon("turretstatechange");
	for(;;)
	{
		self shootturret();
		self notify("turret_fire");
		wait(0.1);
	}
}

//Function Number: 11
turret_shell_fx()
{
	self endon("death");
	self endon("stop_burst_fire_unmanned");
	if(isdefined(self.shell_sound))
	{
		self.shell_sound_enabled = 1;
	}

	for(;;)
	{
		self waittill("turret_fire");
		playfxontag(self.shell_fx,self,"tag_origin");
		if(isdefined(self.shell_sound_enabled) && self.shell_sound_enabled)
		{
			thread turret_shell_sound();
		}
	}
}

//Function Number: 12
turret_shell_sound()
{
	self endon("death");
	self.shell_sound_enabled = 0;
	var_00 = self gettagorigin("tag_origin");
	var_01 = common_scripts\utility::drop_to_ground(var_00,-30);
	var_02 = var_00[2] - var_01[2];
	var_03 = var_02 / 300;
	wait(var_03);
	level thread common_scripts\utility::play_sound_in_space(self.shell_sound,var_01);
	wait(1);
	self.shell_sound_enabled = 1;
}

//Function Number: 13
turrettimer(param_00)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("turretstatechange");
	wait(param_00);
	if(isdefined(self))
	{
		self notify("turretstatechange");
	}
}

//Function Number: 14
random_spread(param_00)
{
	self endon("death");
	self notify("stop random_spread");
	self endon("stop random_spread");
	self endon("stopfiring");
	self settargetentity(param_00);
	for(;;)
	{
		if(isplayer(param_00))
		{
			param_00.origin = self.manual_target getorigin();
		}
		else
		{
			param_00.origin = self.manual_target.origin;
		}

		param_00.origin = param_00.origin + (20 - randomfloat(40),20 - randomfloat(40),20 - randomfloat(60));
		wait(0.2);
	}
}

//Function Number: 15
mg42_firing(param_00)
{
	self notify("stop_using_built_in_burst_fire");
	self endon("stop_using_built_in_burst_fire");
	param_00 stopfiring();
	for(;;)
	{
		param_00 waittill("startfiring");
		thread burst_fire(param_00);
		param_00 startfiring();
		param_00 waittill("stopfiring");
		param_00 stopfiring();
	}
}

//Function Number: 16
burst_fire(param_00,param_01)
{
	param_00 endon("stopfiring");
	self endon("stop_using_built_in_burst_fire");
	if(isdefined(param_00.script_delay_min))
	{
		var_02 = param_00.script_delay_min;
	}
	else
	{
		var_02 = burst_fire_settings("delay");
	}

	if(isdefined(param_00.script_delay_max))
	{
		var_03 = param_00.script_delay_max - var_02;
	}
	else
	{
		var_03 = burst_fire_settings("delay_range");
	}

	if(isdefined(param_00.script_burst_min))
	{
		var_04 = param_00.script_burst_min;
	}
	else
	{
		var_04 = burst_fire_settings("burst");
	}

	if(isdefined(param_00.script_burst_max))
	{
		var_05 = param_00.script_burst_max - var_04;
	}
	else
	{
		var_05 = burst_fire_settings("burst_range");
	}

	for(;;)
	{
		param_00 startfiring();
		if(isdefined(param_01))
		{
			param_00 thread random_spread(param_01);
		}

		wait(var_04 + randomfloat(var_05));
		param_00 stopfiring();
		wait(var_02 + randomfloat(var_03));
	}
}

//Function Number: 17
_spawner_mg42_think()
{
	if(!isdefined(self.flagged_for_use))
	{
		self.flagged_for_use = 0;
	}

	if(!isdefined(self.targetname))
	{
		return;
	}

	var_00 = getnode(self.targetname,"target");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.script_mg42))
	{
		return;
	}

	if(!isdefined(var_00.mg42_enabled))
	{
		var_00.mg42_enabled = 1;
	}

	self.script_mg42 = var_00.script_mg42;
	var_01 = 1;
	for(;;)
	{
		if(var_01)
		{
			var_01 = 0;
			if(isdefined(var_00.targetname) || self.flagged_for_use)
			{
				self waittill("get new user");
			}
		}

		if(!var_00.mg42_enabled)
		{
			var_00 waittill("enable mg42");
			var_00.mg42_enabled = 1;
		}

		var_02 = [];
		var_03 = getaiarray();
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = 1;
			if(isdefined(var_03[var_04].script_mg42) && var_03[var_04].script_mg42 == self.script_mg42)
			{
				var_05 = 0;
			}

			if(isdefined(var_03[var_04].used_an_mg42))
			{
				var_05 = 1;
			}

			if(var_05)
			{
				var_02[var_02.size] = var_03[var_04];
			}
		}

		if(var_02.size)
		{
			var_03 = maps\_utility::get_closest_ai_exclude(var_00.origin,undefined,var_02);
		}
		else
		{
			var_03 = maps\_utility::get_closest_ai(var_00.origin,undefined);
		}

		var_02 = undefined;
		if(isdefined(var_03))
		{
			var_03 notify("stop_going_to_node");
			var_03 thread maps\_spawner::go_to_node(var_00);
			var_03 waittill("death");
			continue;
		}

		self waittill("get new user");
	}
}

//Function Number: 18
mg42_think()
{
	if(!isdefined(self.ai_mode))
	{
		self.ai_mode = "manual_ai";
	}

	var_00 = getnode(self.target,"targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = getent(var_00.target,"targetname");
	var_01.org = var_00.origin;
	if(isdefined(var_01.target))
	{
		if(!isdefined(level.mg42_trigger) || !isdefined(level.mg42_trigger[var_01.target]))
		{
			level.mg42_trigger[var_01.target] = 0;
			getent(var_01.target,"targetname") thread mg42_trigger();
		}

		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	for(;;)
	{
		if(self.count == 0)
		{
			return;
		}

		var_03 = undefined;
		while(!isdefined(var_03))
		{
			var_03 = self dospawn();
			wait(1);
		}

		var_03 thread mg42_gunner_think(var_01,var_02,self.ai_mode);
		var_03 thread mg42_firing(var_01);
		var_03 waittill("death");
		if(isdefined(self.script_delay))
		{
			wait(self.script_delay);
			continue;
		}

		if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
		{
			wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
			continue;
		}

		wait(1);
	}
}

//Function Number: 19
kill_objects(param_00,param_01,param_02,param_03)
{
	param_00 waittill(param_01);
	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_03))
	{
		param_03 delete();
	}
}

//Function Number: 20
mg42_gunner_think(param_00,param_01,param_02)
{
	self endon("death");
	if(param_02 == "manual_ai")
	{
		for(;;)
		{
			thread mg42_gunner_manual_think(param_00,param_01);
			self waittill("auto_ai");
			move_use_turret(param_00,"auto_ai");
			self waittill("manual_ai");
		}

		return;
	}

	for(;;)
	{
		move_use_turret(param_00,"auto_ai",level.player);
		self waittill("manual_ai");
		thread mg42_gunner_manual_think(param_00,param_01);
		self waittill("auto_ai");
	}
}

//Function Number: 21
player_safe()
{
	if(!isdefined(level.player_covertrigger))
	{
		return 0;
	}

	if(level.player getstance() == "prone")
	{
		return 1;
	}

	if(level.player_covertype == "cow" && level.player getstance() == "crouch")
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
stance_num()
{
	if(level.player getstance() == "prone")
	{
		return (0,0,5);
	}
	else if(level.player getstance() == "crouch")
	{
		return (0,0,25);
	}

	return (0,0,50);
}

//Function Number: 23
mg42_gunner_manual_think(param_00,param_01)
{
	self endon("death");
	self endon("auto_ai");
	self.pacifist = 1;
	self setgoalpos(param_00.org);
	self.goalradius = level.magic_distance;
	self waittill("goal");
	if(param_01)
	{
		if(!level.mg42_trigger[param_00.target])
		{
			level waittill(param_00.target);
		}
	}

	self.pacifist = 0;
	param_00 setmode("auto_ai");
	param_00 cleartargetentity();
	var_02 = spawn("script_origin",(0,0,0));
	var_03 = spawn("script_model",(0,0,0));
	var_03.scale = 3;
	if(getdvar("mg42") != "off")
	{
		var_03 setmodel("temp");
	}

	var_03 thread temp_think(param_00,var_02);
	level thread kill_objects(self,"death",var_02,var_03);
	level thread kill_objects(self,"auto_ai",var_02,var_03);
	param_00.player_target = 0;
	var_04 = 0;
	var_05 = getentarray("mg42_target","targetname");
	if(var_05.size > 0)
	{
		var_06 = 1;
		var_07 = var_05[randomint(var_05.size)].origin;
		thread shoot_mg42_script_targets(var_05);
		move_use_turret(param_00);
		self.target_entity = var_02;
		param_00 setmode("manual_ai");
		param_00 settargetentity(var_02);
		param_00 notify("startfiring");
		var_08 = 15;
		var_09 = 0.08;
		var_0A = 0.05;
		var_02.origin = var_05[randomint(var_05.size)].origin;
		var_0B = 0;
		while(!isdefined(level.player_covertrigger))
		{
			var_07 = var_02.origin;
			if(distance(var_07,var_05[self.gun_targ].origin) > var_08)
			{
				var_0C = vectornormalize(var_05[self.gun_targ].origin - var_07);
				var_0C = var_0C * var_08;
				var_07 = var_07 + var_0C;
			}
			else
			{
				self notify("next_target");
			}

			var_02.origin = var_07;
			wait(0.1);
		}

		for(;;)
		{
			for(var_0D = 0;var_0D < 1;var_0D = var_0D + var_0A)
			{
				var_02.origin = var_07 * 1 - var_0D + level.player getorigin() + stance_num() * var_0D;
				if(player_safe())
				{
					var_0D = 2;
				}

				wait(var_09);
			}

			var_0E = level.player getorigin();
			while(!player_safe())
			{
				var_02.origin = level.player getorigin();
				var_0F = var_02.origin - var_0E;
				var_02.origin = var_02.origin + var_0F + stance_num();
				var_0E = level.player getorigin();
				wait(0.1);
			}

			if(player_safe())
			{
				var_0B = gettime() + 1500 + randomfloat(4000);
				while(player_safe() && isdefined(level.player_covertrigger.target) && gettime() < var_0B)
				{
					var_10 = getentarray(level.player_covertrigger.target,"targetname");
					var_10 = var_10[randomint(var_10.size)];
					var_02.origin = var_10.origin + (randomfloat(30) - 15,randomfloat(30) - 15,randomfloat(40) - 60);
					wait(0.1);
				}
			}

			self notify("next_target");
			while(player_safe())
			{
				var_07 = var_02.origin;
				if(distance(var_07,var_05[self.gun_targ].origin) > var_08)
				{
					var_0C = vectornormalize(var_05[self.gun_targ].origin - var_07);
					var_0C = var_0C * var_08;
					var_07 = var_07 + var_0C;
				}
				else
				{
					self notify("next_target");
				}

				var_02.origin = var_07;
				wait(0.1);
			}
		}

		return;
	}

	for(;;)
	{
		move_use_turret(param_00);
		while(!isdefined(level.player_covertrigger))
		{
			if(!param_00.player_target)
			{
				param_00 settargetentity(level.player);
				param_00.player_target = 1;
				var_03.targent = level.player;
			}

			wait(0.2);
		}

		param_00 setmode("manual_ai");
		move_use_turret(param_00);
		param_00 notify("startfiring");
		var_0B = gettime() + 1500 + randomfloat(4000);
		while(var_0B > gettime())
		{
			if(isdefined(level.player_covertrigger))
			{
				var_10 = getentarray(level.player_covertrigger.target,"targetname");
				var_10 = var_10[randomint(var_10.size)];
				var_02.origin = var_10.origin + (randomfloat(30) - 15,randomfloat(30) - 15,randomfloat(40) - 60);
				param_00 settargetentity(var_02);
				var_03.targent = var_02;
				wait(randomfloat(1));
				continue;
			}

			break;
		}

		param_00 notify("stopfiring");
		move_use_turret(param_00);
		if(param_00.player_target)
		{
			param_00 setmode("auto_ai");
			param_00 cleartargetentity();
			param_00.player_target = 0;
			var_03.targent = var_03;
			var_03.origin = (0,0,0);
		}

		while(isdefined(level.player_covertrigger))
		{
			wait(0.2);
		}

		wait(0.75 + randomfloat(0.2));
	}
}

//Function Number: 24
shoot_mg42_script_targets(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = [];
		for(var_02 = 0;var_02 < param_00.size;var_02++)
		{
			var_01[var_02] = 0;
		}

		for(var_02 = 0;var_02 < param_00.size;var_02++)
		{
			self.gun_targ = randomint(param_00.size);
			self waittill("next_target");
			while(var_01[self.gun_targ])
			{
				self.gun_targ++;
				if(self.gun_targ >= param_00.size)
				{
					self.gun_targ = 0;
				}
			}

			var_01[self.gun_targ] = 1;
		}
	}
}

//Function Number: 25
move_use_turret(param_00,param_01,param_02)
{
	self setgoalpos(param_00.org);
	self.goalradius = level.magic_distance;
	self waittill("goal");
	if(isdefined(param_01) && param_01 == "auto_ai")
	{
		param_00 setmode("auto_ai");
		if(isdefined(param_02))
		{
			param_00 settargetentity(param_02);
		}
		else
		{
			param_00 cleartargetentity();
		}
	}

	self useturret(param_00);
}

//Function Number: 26
temp_think(param_00,param_01)
{
	if(getdvar("mg42") == "off")
	{
		return;
	}

	self.targent = self;
	for(;;)
	{
		self.origin = param_01.origin;
		wait(0.1);
	}
}

//Function Number: 27
turret_think(param_00)
{
	var_01 = getent(param_00.auto_mg42_target,"targetname");
	var_02 = 0.5;
	if(isdefined(var_01.script_turret_reuse_min))
	{
		var_02 = var_01.script_turret_reuse_min;
	}

	var_03 = 2;
	if(isdefined(var_01.script_turret_reuse_max))
	{
		var_02 = var_01.script_turret_reuse_max;
	}

	for(;;)
	{
		var_01 waittill("turret_deactivate");
		wait(var_02 + randomfloat(var_03 - var_02));
		while(!isturretactive(var_01))
		{
			turret_find_user(param_00,var_01);
			wait(1);
		}
	}
}

//Function Number: 28
turret_find_user(param_00,param_01)
{
	var_02 = getaiarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] isingoal(param_00.origin) && var_02[var_03] canuseturret(param_01))
		{
			var_04 = var_02[var_03].keepclaimednodeifvalid;
			var_02[var_03].keepclaimednodeifvalid = 0;
			if(!var_02[var_03] usecovernode(param_00))
			{
				var_02[var_03].keepclaimednodeifvalid = var_04;
			}
		}
	}
}

//Function Number: 29
setdifficulty()
{
	init_mgturretsettings();
	var_00 = getentarray("misc_turret","code_classname");
	var_01 = maps\_utility::getdifficulty();
	var_02 = 0;
	if(var_02 < var_00.size)
	{
		if(isdefined(var_00[var_02].script_skilloverride))
		{
			switch(var_00[var_02].script_skilloverride)
			{
				case "easy":
					break;

				case "medium":
					break;

				case "hard":
					break;

				case "fu":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 30
mg42_setdifficulty(param_00,param_01)
{
	param_00.convergencetime = level.mgturretsettings[param_01]["convergenceTime"];
	param_00.suppressiontime = level.mgturretsettings[param_01]["suppressionTime"];
	param_00.accuracy = level.mgturretsettings[param_01]["accuracy"];
	param_00.aispread = level.mgturretsettings[param_01]["aiSpread"];
	param_00.playerspread = level.mgturretsettings[param_01]["playerSpread"];
}

//Function Number: 31
mg42_target_drones(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.88;
	}

	self endon("death");
	self notify("stop_mg42_target_drones");
	self endon("stop_mg42_target_drones");
	self.dronefailed = 0;
	if(!isdefined(self.script_fireondrones))
	{
		self.script_fireondrones = 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self setmode("manual_ai");
	var_03 = maps\_utility::getdifficulty();
	if(!isdefined(level.drones))
	{
		var_04 = 1;
	}
	else
	{
		var_04 = 0;
	}

	for(;;)
	{
		if(var_04)
		{
			if(isdefined(self.drones_targets_sets_to_default))
			{
				self setmode(self.defaultonmode);
			}
			else if(param_00)
			{
				self setmode("auto_nonai");
			}
			else
			{
				self setmode("auto_ai");
			}

			level waittill("new_drone");
		}

		if(!isdefined(self.oldconvergencetime))
		{
			self.oldconvergencetime = self.convergencetime;
		}

		self.convergencetime = 2;
		if(!param_00)
		{
			var_05 = self getturretowner();
			if(!isalive(var_05) || isplayer(var_05))
			{
				wait(0.05);
				continue;
			}
			else
			{
				param_01 = var_05.team;
			}
		}
		else
		{
			var_05 = undefined;
		}

		if(param_01 == "allies")
		{
			var_06 = "axis";
		}
		else
		{
			var_06 = "allies";
		}

		while(level.drones[var_06].lastindex)
		{
			common_scripts\utility::lock("mg42_drones");
			if(!level.drones[var_06].lastindex)
			{
				common_scripts\utility::unlock("mg42_drones");
				break;
			}

			var_07 = get_bestdrone(var_06,param_02);
			common_scripts\utility::unlock("mg42_drones");
			if(!isdefined(self.script_fireondrones) || !self.script_fireondrones)
			{
				wait(0.05);
				break;
			}

			if(!isdefined(var_07))
			{
				wait(0.05);
				break;
			}

			if(isdefined(self.anim_wait_func))
			{
				[[ self.anim_wait_func ]]();
			}

			if(param_00)
			{
				self setmode("manual");
			}
			else
			{
				self setmode("manual_ai");
			}

			self settargetentity(var_07,(0,0,32));
			drone_target(var_07,1,param_02);
			self cleartargetentity();
			self stopfiring();
			if(!param_00 && !isdefined(self getturretowner()) && self getturretowner() == var_05)
			{
				break;
			}
		}

		self.convergencetime = self.oldconvergencetime;
		self.oldconvergencetime = undefined;
		self cleartargetentity();
		self stopfiring();
		if(level.drones[var_06].lastindex)
		{
			var_04 = 0;
			continue;
		}

		var_04 = 1;
	}
}

//Function Number: 32
drone_target(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	var_03 = gettime() + param_01 * 1000;
	var_04 = 0;
	while(var_03 > gettime() || var_04)
	{
		common_scripts\utility::lock("mg42_drones_target_trace");
		var_05 = self getturrettarget(1);
		if(!bullettracepassed(self gettagorigin("tag_flash"),param_00.origin + (0,0,40),0,param_00))
		{
			common_scripts\utility::unlock("mg42_drones_target_trace");
			break;
		}
		else if(isdefined(var_05) && distance(var_05.origin,self.origin) < distance(self.origin,param_00.origin))
		{
			common_scripts\utility::unlock("mg42_drones_target_trace");
			break;
		}

		if(!var_04)
		{
			self startfiring();
			var_04 = 1;
		}

		common_scripts\utility::unlock_wait("mg42_drones_target_trace");
	}

	self stopfiring();
	maps\_utility::structarray_shuffle(level.drones[param_00.team],1);
}

//Function Number: 33
get_bestdrone(param_00,param_01)
{
	if(level.drones[param_00].lastindex < 1)
	{
		return;
	}

	var_02 = undefined;
	var_03 = anglestoforward(self.angles);
	for(var_04 = 0;var_04 < level.drones[param_00].lastindex;var_04++)
	{
		if(!isdefined(level.drones[param_00].array[var_04]))
		{
			continue;
		}

		var_05 = vectortoangles(level.drones[param_00].array[var_04].origin - self.origin);
		var_06 = anglestoforward(var_05);
		if(vectordot(var_03,var_06) < param_01)
		{
			continue;
		}

		var_02 = level.drones[param_00].array[var_04];
		if(!bullettracepassed(self gettagorigin("tag_flash"),var_02 getcentroid(),0,var_02))
		{
			var_02 = undefined;
			continue;
		}

		break;
	}

	var_07 = self getturrettarget(1);
	if(!isdefined(self.prefers_drones))
	{
		if(isdefined(var_02) && isdefined(var_07) && distancesquared(self.origin,var_07.origin) < distancesquared(self.origin,var_02.origin))
		{
			var_02 = undefined;
		}
	}

	return var_02;
}

//Function Number: 34
saw_mgturretlink(param_00)
{
	var_01 = getentarray("misc_turret","code_classname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(isdefined(var_01[var_03].targetname))
		{
			continue;
		}

		if(isdefined(var_01[var_03].isvehicleattached))
		{
			continue;
		}

		var_02[var_01[var_03].origin + ""] = var_01[var_03];
	}

	if(!var_02.size)
	{
		return;
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_05.type == "Path")
		{
			continue;
		}

		if(var_05.type == "Begin")
		{
			continue;
		}

		if(var_05.type == "End")
		{
			continue;
		}

		var_06 = anglestoforward((0,var_05.angles[1],0));
		foreach(var_0B, var_08 in var_02)
		{
			if(distance(var_05.origin,var_08.origin) > 50)
			{
				continue;
			}

			var_09 = anglestoforward((0,var_08.angles[1],0));
			var_0A = vectordot(var_06,var_09);
			if(var_0A < 0.9)
			{
				continue;
			}

			var_05.turretinfo = spawn("script_origin",var_08.origin);
			var_05.turretinfo.angles = var_08.angles;
			var_05.turretinfo.node = var_05;
			var_05.turretinfo.leftarc = 45;
			var_05.turretinfo.rightarc = 45;
			var_05.turretinfo.toparc = 15;
			var_05.turretinfo.bottomarc = 15;
			if(isdefined(var_08.leftarc))
			{
				var_05.turretinfo.leftarc = min(var_08.leftarc,45);
			}

			if(isdefined(var_08.rightarc))
			{
				var_05.turretinfo.rightarc = min(var_08.rightarc,45);
			}

			if(isdefined(var_08.toparc))
			{
				var_05.turretinfo.toparc = min(var_08.toparc,15);
			}

			if(isdefined(var_08.bottomarc))
			{
				var_05.turretinfo.bottomarc = min(var_08.bottomarc,15);
			}

			var_02[var_0B] = undefined;
			var_08 delete();
		}
	}
}

//Function Number: 35
auto_mgturretlink(param_00)
{
	var_01 = getentarray("misc_turret","code_classname");
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(!isdefined(var_01[var_03].targetname) || tolower(var_01[var_03].targetname) != "auto_mgturret")
		{
			continue;
		}

		if(!isdefined(var_01[var_03].export))
		{
			continue;
		}

		if(!isdefined(var_01[var_03].script_dont_link_turret))
		{
			var_02[var_01[var_03].origin + ""] = var_01[var_03];
		}
	}

	if(!var_02.size)
	{
		return;
	}

	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_05.type == "Path")
		{
			continue;
		}

		if(var_05.type == "Begin")
		{
			continue;
		}

		if(var_05.type == "End")
		{
			continue;
		}

		var_06 = anglestoforward((0,var_05.angles[1],0));
		var_07 = getarraykeys(var_02);
		for(var_03 = 0;var_03 < var_07.size;var_03++)
		{
			var_08 = var_02[var_07[var_03]];
			if(distance(var_05.origin,var_08.origin) > 70)
			{
				continue;
			}

			var_09 = anglestoforward((0,var_08.angles[1],0));
			var_0A = vectordot(var_06,var_09);
			if(var_0A < 0.9)
			{
				continue;
			}

			var_05.turret = var_08;
			var_08.node = var_05;
			var_08.issetup = 1;
			var_02[var_07[var_03]] = undefined;
		}
	}

	param_00 = undefined;
}

//Function Number: 36
save_turret_sharing_info()
{
	self.shared_turrets = [];
	self.shared_turrets["connected"] = [];
	self.shared_turrets["ambush"] = [];
	if(!isdefined(self.export))
	{
		return;
	}

	level.shared_portable_turrets[self.export] = self;
	if(isdefined(self.script_turret_share))
	{
		var_00 = strtok(self.script_turret_share," ");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			self.shared_turrets["connected"][var_00[var_01]] = 1;
		}
	}

	if(isdefined(self.script_turret_ambush))
	{
		var_00 = strtok(self.script_turret_ambush," ");
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			self.shared_turrets["ambush"][var_00[var_01]] = 1;
		}
	}
}

//Function Number: 37
restoredefaultpitch()
{
	self notify("gun_placed_again");
	self endon("gun_placed_again");
	self waittill("restore_default_drop_pitch");
	wait(1);
	self restoredefaultdroppitch();
}

//Function Number: 38
dropturret()
{
	thread dropturretproc();
}

//Function Number: 39
dropturretproc()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00.origin = self gettagorigin(level.portable_mg_gun_tag);
	var_00.angles = self gettagangles(level.portable_mg_gun_tag);
	var_00 setmodel(self.turretmodel);
	var_01 = anglestoforward(self.angles);
	var_01 = var_01 * 100;
	var_00 movegravity(var_01,0.5);
	self detach(self.turretmodel,level.portable_mg_gun_tag);
	self.turretmodel = undefined;
	wait(0.7);
	var_00 delete();
}

//Function Number: 40
turretdeathdetacher()
{
	self endon("kill_turret_detach_thread");
	self endon("dropped_gun");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	dropturret();
}

//Function Number: 41
turretdetacher()
{
	self endon("death");
	self endon("kill_turret_detach_thread");
	self waittill("dropped_gun");
	self detach(self.turretmodel,level.portable_mg_gun_tag);
}

//Function Number: 42
restoredefaults()
{
	self.run_overrideanim = undefined;
	common_scripts\utility::set_all_exceptions(::animscripts\init::empty);
}

//Function Number: 43
restorepitch()
{
	self waittill("turret_deactivate");
	self restoredefaultdroppitch();
}

//Function Number: 44
update_enemy_target_pos_while_running(param_00)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	for(;;)
	{
		self waittill("saw_enemy");
		param_00.origin = self.last_enemy_sighting_position;
	}
}

//Function Number: 45
move_target_pos_to_new_turrets_visibility(param_00,param_01)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	var_02 = self.turret.origin + (0,0,16);
	var_03 = param_01.origin + (0,0,16);
	for(;;)
	{
		wait(0.05);
		if(sighttracepassed(param_00.origin,var_03,0,undefined))
		{
			continue;
		}

		var_04 = vectortoangles(var_02 - param_00.origin);
		var_05 = anglestoforward(var_04);
		var_05 = var_05 * 8;
		param_00.origin = param_00.origin + var_05;
	}
}

//Function Number: 46
record_bread_crumbs_for_ambush(param_00)
{
	self endon("death");
	self endon("end_mg_behavior");
	self endon("stop_updating_enemy_target_pos");
	param_00.bread_crumbs = [];
	for(;;)
	{
		param_00.bread_crumbs[param_00.bread_crumbs.size] = self.origin + (0,0,50);
		wait(0.35);
	}
}

//Function Number: 47
aim_turret_at_ambush_point_or_visible_enemy(param_00,param_01)
{
	if(!isalive(self.current_enemy) && self cansee(self.current_enemy))
	{
		param_01.origin = self.last_enemy_sighting_position;
		return;
	}

	var_02 = anglestoforward(param_00.angles);
	for(var_03 = param_01.bread_crumbs.size - 3;var_03 >= 0;var_03--)
	{
		var_04 = param_01.bread_crumbs[var_03];
		var_05 = vectornormalize(var_04 - param_00.origin);
		var_06 = vectordot(var_02,var_05);
		if(var_06 < 0.75)
		{
			continue;
		}

		param_01.origin = var_04;
		if(sighttracepassed(param_00.origin,var_04,0,undefined))
		{
			continue;
		}

		break;
	}
}

//Function Number: 48
find_a_new_turret_spot(param_00)
{
	var_01 = get_portable_mg_spot(param_00);
	var_02 = var_01["spot"];
	var_03 = var_01["type"];
	if(!isdefined(var_02))
	{
		return;
	}

	reserve_turret(var_02);
	thread update_enemy_target_pos_while_running(param_00);
	thread move_target_pos_to_new_turrets_visibility(param_00,var_02);
	if(var_03 == "ambush")
	{
		thread record_bread_crumbs_for_ambush(param_00);
	}

	if(var_02.issetup)
	{
		leave_gun_and_run_to_new_spot(var_02);
	}
	else
	{
		pickup_gun(var_02);
		run_to_new_spot_and_setup_gun(var_02);
	}

	self notify("stop_updating_enemy_target_pos");
	if(var_03 == "ambush")
	{
		aim_turret_at_ambush_point_or_visible_enemy(var_02,param_00);
	}

	var_02 settargetentity(param_00);
}

//Function Number: 49
snap_lock_turret_onto_target(param_00)
{
	param_00 setmode("manual");
	wait(0.5);
	param_00 setmode("manual_ai");
}

//Function Number: 50
leave_gun_and_run_to_new_spot(param_00)
{
	self stopuseturret();
	animscripts\shared::placeweaponon(self.primaryweapon,"none");
	var_01 = get_turret_setup_anim(param_00);
	var_02 = getstartorigin(param_00.origin,param_00.angles,var_01);
	self setruntopos(var_02);
	self waittill("runto_arrived");
	use_the_turret(param_00);
}

//Function Number: 51
pickup_gun(param_00)
{
	self stopuseturret();
	self.turret hide_turret();
}

//Function Number: 52
get_turret_setup_anim(param_00)
{
	var_01 = [];
	var_01["saw_bipod_stand"] = level.mg_animmg["bipod_stand_setup"];
	var_01["saw_bipod_crouch"] = level.mg_animmg["bipod_crouch_setup"];
	var_01["saw_bipod_prone"] = level.mg_animmg["bipod_prone_setup"];
	return var_01[param_00.weaponinfo];
}

//Function Number: 53
run_to_new_spot_and_setup_gun(param_00)
{
	var_01 = self.health;
	param_00 endon("turret_deactivate");
	self.mg42 = param_00;
	self endon("death");
	self endon("dropped_gun");
	var_02 = get_turret_setup_anim(param_00);
	self.turretmodel = "weapon_mg42_carry";
	self notify("kill_get_gun_back_on_killanimscript_thread");
	animscripts\shared::placeweaponon(self.weapon,"none");
	if(self isbadguy())
	{
		self.health = 1;
	}

	self.run_overrideanim = %saw_gunner_run_fast;
	self.crouchrun_combatanim = %saw_gunner_run_fast;
	self attach(self.turretmodel,level.portable_mg_gun_tag);
	thread turretdeathdetacher();
	var_03 = getstartorigin(param_00.origin,param_00.angles,var_02);
	self setruntopos(var_03);
	wait(0.05);
	common_scripts\utility::set_all_exceptions(::animscripts\combat::exception_exposed_mg42_portable);
	common_scripts\utility::clear_exception("move");
	common_scripts\utility::set_exception("cover_crouch",::hold_indefintely);
	while(distance(self.origin,var_03) > 16)
	{
		self setruntopos(var_03);
		wait(0.05);
	}

	self notify("kill_turret_detach_thread");
	if(self isbadguy())
	{
		self.health = var_01;
	}

	if(soundexists("weapon_setup"))
	{
		thread common_scripts\utility::play_sound_in_space("weapon_setup");
	}

	self animscripted("setup_done",param_00.origin,param_00.angles,var_02);
	restoredefaults();
	self waittillmatch("end","setup_done");
	param_00 notify("restore_default_drop_pitch");
	param_00 show_turret();
	animscripts\shared::placeweaponon(self.primaryweapon,"right");
	use_the_turret(param_00);
	self detach(self.turretmodel,level.portable_mg_gun_tag);
	common_scripts\utility::set_all_exceptions(::animscripts\init::empty);
	self notify("bcs_portable_turret_setup");
}

//Function Number: 54
move_to_run_pos()
{
	self setruntopos(self.runpos);
}

//Function Number: 55
hold_indefintely()
{
	self endon("killanimscript");
	self waittill("death");
}

//Function Number: 56
using_a_turret()
{
	if(!isdefined(self.turret))
	{
		return 0;
	}

	return self.turret.owner == self;
}

//Function Number: 57
turret_user_moves()
{
	if(!using_a_turret())
	{
		common_scripts\utility::clear_exception("move");
		return;
	}

	var_00 = find_connected_turrets("connected");
	var_01 = var_00["spots"];
	if(!var_01.size)
	{
		common_scripts\utility::clear_exception("move");
		return;
	}

	var_02 = self.node;
	if(!isdefined(var_02) || !maps\_utility::is_in_array(var_01,var_02))
	{
		var_03 = gettakennodes();
		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			var_02 = common_scripts\utility::random(var_01);
			if(isdefined(var_03[var_02.origin + ""]))
			{
				return;
			}
		}
	}

	var_05 = var_02.turret;
	if(isdefined(var_05.reserved))
	{
		return;
	}

	reserve_turret(var_05);
	if(var_05.issetup)
	{
		leave_gun_and_run_to_new_spot(var_05);
	}
	else
	{
		run_to_new_spot_and_setup_gun(var_05);
	}

	maps\_mg_penetration::gunner_think(var_02.turret);
}

//Function Number: 58
use_the_turret(param_00)
{
	var_01 = self useturret(param_00);
	if(var_01)
	{
		common_scripts\utility::set_exception("move",::turret_user_moves);
		self.turret = param_00;
		thread mg42_firing(param_00);
		param_00 setmode("manual_ai");
		param_00 thread restorepitch();
		self.turret = param_00;
		param_00.owner = self;
		return 1;
	}

	param_00 restoredefaultdroppitch();
	return 0;
}

//Function Number: 59
get_portable_mg_spot(param_00)
{
	var_01 = [];
	var_01[var_01.size] = ::find_different_way_to_attack_last_seen_position;
	var_01[var_01.size] = ::find_good_ambush_spot;
	var_01 = common_scripts\utility::array_randomize(var_01);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = [[ var_01[var_02] ]](param_00);
		if(!isdefined(var_03["spots"]))
		{
			continue;
		}

		var_03["spot"] = common_scripts\utility::random(var_03["spots"]);
		return var_03;
	}
}

//Function Number: 60
gettakennodes()
{
	var_00 = [];
	var_01 = getaiarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(!isdefined(var_01[var_02].node))
		{
			continue;
		}

		var_00[var_01[var_02].node.origin + ""] = 1;
	}

	return var_00;
}

//Function Number: 61
find_connected_turrets(param_00)
{
	var_01 = level.shared_portable_turrets;
	var_02 = [];
	var_03 = getarraykeys(var_01);
	var_04 = gettakennodes();
	var_04[self.node.origin + ""] = undefined;
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		if(var_01[var_06] == self.turret)
		{
			continue;
		}

		var_07 = getarraykeys(self.turret.shared_turrets[param_00]);
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(var_01[var_06].export + "" != var_07[var_08])
			{
				continue;
			}

			if(isdefined(var_01[var_06].reserved))
			{
				continue;
			}

			if(isdefined(var_04[var_01[var_06].node.origin + ""]))
			{
				continue;
			}

			if(distance(self.goalpos,var_01[var_06].origin) > self.goalradius)
			{
				continue;
			}

			var_02[var_02.size] = var_01[var_06];
		}
	}

	var_09 = [];
	var_09["type"] = param_00;
	var_09["spots"] = var_02;
	return var_09;
}

//Function Number: 62
find_good_ambush_spot(param_00)
{
	return find_connected_turrets("ambush");
}

//Function Number: 63
find_different_way_to_attack_last_seen_position(param_00)
{
	var_01 = find_connected_turrets("connected");
	var_02 = var_01["spots"];
	if(!var_02.size)
	{
		return;
	}

	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		if(!common_scripts\utility::within_fov(var_02[var_04].origin,var_02[var_04].angles,param_00.origin,0.75))
		{
			continue;
		}

		if(!sighttracepassed(param_00.origin,var_02[var_04].origin + (0,0,16),0,undefined))
		{
			continue;
		}

		var_03[var_03.size] = var_02[var_04];
	}

	var_01["spots"] = var_03;
	return var_01;
}

//Function Number: 64
portable_mg_spot()
{
	save_turret_sharing_info();
	var_00 = 1;
	self.issetup = 1;
	self.reserved = undefined;
	if(isdefined(self.isvehicleattached))
	{
		return;
	}

	if(self.spawnflags & var_00)
	{
		return;
	}

	hide_turret();
}

//Function Number: 65
hide_turret()
{
	self notify("stop_checking_for_flanking");
	self.issetup = 0;
	self hide();
	self.solid = 0;
	self makeunusable();
	self setdefaultdroppitch(0);
	thread restoredefaultpitch();
}

//Function Number: 66
show_turret()
{
	self show();
	self.solid = 1;
	self makeusable();
	self.issetup = 1;
	thread stop_mg_behavior_if_flanked();
}

//Function Number: 67
stop_mg_behavior_if_flanked()
{
	self endon("stop_checking_for_flanking");
	self waittill("turret_deactivate");
	if(isalive(self.owner))
	{
		self.owner notify("end_mg_behavior");
	}
}

//Function Number: 68
turret_is_mine(param_00)
{
	var_01 = param_00 getturretowner();
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01 == self;
}

//Function Number: 69
end_turret_reservation(param_00)
{
	waittill_turret_is_released(param_00);
	param_00.reserved = undefined;
}

//Function Number: 70
waittill_turret_is_released(param_00)
{
	param_00 endon("turret_deactivate");
	self endon("death");
	self waittill("end_mg_behavior");
}

//Function Number: 71
reserve_turret(param_00)
{
	param_00.reserved = self;
	thread end_turret_reservation(param_00);
}