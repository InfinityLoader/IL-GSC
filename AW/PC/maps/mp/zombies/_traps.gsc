/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_traps.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 80
 * Decompile Time: 1252 ms
 * Timestamp: 4/22/2024 2:14:03 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["trap_ready"] = loadfx("vfx/test/zombies_light_orange");
	level._effect["trap_not_ready"] = loadfx("vfx/test/zombies_light_red");
	level._effect["barrel_explode"] = loadfx("vfx/explosion/explosive_drone_explosion");
	level.trap_state_models = [];
	level.trap_state_models["default"] = [];
	level.trap_state_func["no_power"] = ::trap_state_no_power;
	level.trap_state_func["ready"] = ::trap_state_ready;
	level.trap_state_func["active"] = ::trap_state_active;
	level.trap_state_func["cooldown"] = ::trap_state_cooldown;
	level.trap_state_func["deactivate"] = ::trap_state_deactivate;
	level.laser_alarm_started = 0;
	level.traps = common_scripts\utility::getstructarray("zombie_trap","targetname");
	common_scripts\utility::array_thread(level.traps,::trap_init);
}

//Function Number: 2
trap_init()
{
	if(isdefined(self.script_count))
	{
		self.cost = self.script_count;
	}
	else
	{
		self.cost = 500;
	}

	maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.cost));
	var_00 = getentarray(self.target,"targetname");
	var_01 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		switch(var_04.script_noteworthy)
		{
			case "activate_model":
				thread trap_activate_model(var_04);
				self.modelent = var_04;
				break;

			case "activate":
				thread trap_activate_trigger(var_04);
				thread trap_trigger_hint(var_04);
				break;

			case "laser":
				thread trap_laser(var_04);
				break;

			case "fx_ready":
				thread trap_fx_ready(var_04);
				break;

			case "damage":
				thread trap_damage_trigger(var_04,0);
				break;

			case "damage_over_time":
				thread trap_damage_trigger(var_04,1);
				break;

			case "fx_trap":
				thread trap_state_fx(var_04);
				break;

			case "fx_trap_move":
				thread trap_fx_move(var_04);
				break;

			case "distraction":
				thread trap_distraction(var_04);
				break;

			case "zomboni":
				thread trap_zomboni(var_04);
				break;

			default:
				break;
		}
	}

	self.state = "none";
	if(trap_requires_power())
	{
		trap_set_state("no_power");
		return;
	}

	trap_set_state("ready");
}

//Function Number: 3
register_trap_state_models(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = "default";
	}

	if(!isdefined(level.trap_state_models[param_04]))
	{
		level.trap_state_models[param_04] = [];
	}

	level.trap_state_models[param_04]["no_power"] = param_00;
	level.trap_state_models[param_04]["ready"] = param_01;
	level.trap_state_models[param_04]["active"] = param_02;
	level.trap_state_models[param_04]["cooldown"] = param_03;
	level.trap_state_models[param_04]["deactivate"] = param_00;
}

//Function Number: 4
get_trap_time()
{
	return 20;
}

//Function Number: 5
trap_requires_power()
{
	return isdefined(self.script_flag_true);
}

//Function Number: 6
trap_has_power()
{
	if(trap_requires_power())
	{
		return common_scripts\utility::flag(self.script_flag_true);
	}

	return 1;
}

//Function Number: 7
trap_set_state(param_00)
{
	thread _trap_set_state(param_00);
}

//Function Number: 8
_trap_set_state(param_00)
{
	self notify(param_00);
	if(param_00 != self.state)
	{
		self notify("trap_state_change",param_00);
	}

	self.state = param_00;
	self thread [[ level.trap_state_func[param_00] ]]();
}

//Function Number: 9
trap_state_no_power()
{
	self endon("trap_state_change");
	if(!trap_has_power())
	{
		common_scripts\utility::flag_wait(self.script_flag_true);
	}

	trap_set_state("ready");
}

//Function Number: 10
trap_state_deactivate()
{
	self endon("trap_state_change");
	self waittill("trap_reactivated");
	if(!trap_has_power())
	{
		common_scripts\utility::flag_wait(self.script_flag_true);
	}

	trap_set_state("ready");
}

//Function Number: 11
trap_state_ready()
{
	self endon("trap_state_change");
	for(;;)
	{
		self waittill("trap_trigger",var_00,var_01);
		if(var_01 == "token")
		{
			var_00 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
		}
		else
		{
			var_02 = self.cost;
			if(isdefined(level.penaltycostincrease))
			{
				for(var_03 = 0;var_03 < level.penaltycostincrease;var_03++)
				{
					var_02 = maps\mp\zombies\_util::getincreasedcost(var_02);
				}
			}

			if(!var_00 maps\mp\gametypes\zombies::attempttobuy(var_02))
			{
				var_00 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
				continue;
			}
		}

		var_00.trapuses++;
		var_00 thread maps\mp\zombies\_zombies_audio::moneyspend();
		trap_activate(var_00,0);
		break;
	}
}

//Function Number: 12
trap_activate(param_00,param_01)
{
	if(!param_01)
	{
		if(isdefined(level.zmaudiocustomtrapvo))
		{
			level thread [[ level.zmaudiocustomtrapvo ]](self,param_00);
		}
		else
		{
			level thread maps\mp\zombies\_zombies_audio_announcer::announcertrapstarteddialog(self.modelent.origin);
		}
	}

	self.owner = param_00;
	trap_set_state("active");
}

//Function Number: 13
trap_deactivate()
{
	self.deactivated = 1;
	trap_set_state("deactivate");
}

//Function Number: 14
trap_deactivate_all()
{
	foreach(var_01 in level.traps)
	{
		var_01 trap_deactivate();
	}
}

//Function Number: 15
trap_reactivate()
{
	self.deactivated = undefined;
	self notify("trap_reactivated");
}

//Function Number: 16
trap_reactivate_all()
{
	foreach(var_01 in level.traps)
	{
		var_01 trap_reactivate();
	}
}

//Function Number: 17
trap_state_active()
{
	self endon("trap_state_change");
	self endon("active");
	trap_state_active_wait();
	if(trap_has_power())
	{
		trap_set_state("cooldown");
		return;
	}

	trap_set_state("no_power");
}

//Function Number: 18
trap_state_active_wait()
{
	if(isdefined(self.trap_active_end_notify))
	{
		self waittill(self.trap_active_end_notify);
		return;
	}

	if(isdefined(self.script_duration))
	{
		var_00 = self.script_duration;
	}
	else
	{
		var_00 = get_trap_time();
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_00);
}

//Function Number: 19
trap_state_cooldown()
{
	self endon("trap_state_change");
	var_00 = 40;
	if(isdefined(level.trapcooldowntime))
	{
		var_00 = level.trapcooldowntime;
	}

	wait(var_00);
	if(trap_has_power())
	{
		trap_set_state("ready");
		return;
	}

	trap_set_state("no_power");
}

//Function Number: 20
trap_activate_model(param_00)
{
	var_01 = "default";
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		var_03 = level.trap_state_models[var_01][var_02];
		if(isdefined(var_03))
		{
			param_00 setmodel(var_03);
		}
	}
}

//Function Number: 21
trap_activate_trigger(param_00)
{
	for(;;)
	{
		var_01 = param_00 maps\mp\zombies\_util::waittilltriggerortokenuse();
		var_02 = var_01[0];
		var_03 = var_01[1];
		self notify("trap_trigger",var_02,var_03);
	}
}

//Function Number: 22
trap_trigger_hint(param_00)
{
	for(;;)
	{
		self waittill("trap_state_change",var_01);
		switch(var_01)
		{
			case "no_power":
				param_00 sethintstring(&"ZOMBIES_REQUIRES_POWER");
				param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
				param_00 maps\mp\zombies\_util::tokenhintstring(0);
				break;
	
			case "active":
				param_00 sethintstring(&"ZOMBIES_EMPTY_STRING");
				param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
				param_00 maps\mp\zombies\_util::tokenhintstring(0);
				break;
	
			case "cooldown":
				if(isdefined(self.hint_strings))
				{
					param_00 sethintstring(self.hint_strings["hint_cooldown"]);
				}
				else
				{
					param_00 sethintstring(&"ZOMBIES_TRAP_COOLDOWN");
				}
		
				param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
				param_00 maps\mp\zombies\_util::tokenhintstring(0);
				break;
	
			case "ready":
				if(isdefined(self.hint_strings))
				{
					param_00 sethintstring(self.hint_strings["hint_ready"]);
				}
				else
				{
					param_00 sethintstring(&"ZOMBIES_TRAP_READY");
				}
		
				var_02 = self.cost;
				if(isdefined(level.penaltycostincrease))
				{
					for(var_03 = 0;var_03 < level.penaltycostincrease;var_03++)
					{
						var_02 = maps\mp\zombies\_util::getincreasedcost(var_02);
					}
				}
		
				param_00 setsecondaryhintstring(maps\mp\zombies\_util::getcoststring(var_02));
				param_00 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_02));
				param_00 maps\mp\zombies\_util::tokenhintstring(1);
				break;
	
			case "deactivate":
				param_00 sethintstring(&"ZOMBIES_REQUIRES_POWER");
				param_00 setsecondaryhintstring(&"ZOMBIES_EMPTY_STRING");
				param_00 maps\mp\zombies\_util::tokenhintstring(0);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 23
trap_fx_move(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = param_00.angles;
	var_01.start_origin = var_01.origin;
	var_01.start_angles = var_01.angles;
	var_01 setmodel("tag_origin");
	var_01.movelist = [];
	var_02 = [];
	if(isdefined(param_00.target))
	{
		var_03 = getentarray(param_00.target,"targetname");
		var_04 = common_scripts\utility::getstructarray(param_00.target,"targetname");
		var_02 = common_scripts\utility::array_combine(var_03,var_04);
	}

	foreach(var_06 in var_02)
	{
		if(!isdefined(var_06.script_noteworthy))
		{
			continue;
		}

		switch(var_06.script_noteworthy)
		{
			case "damage_over_time":
			case "damage":
				var_06 enablelinkto();
				var_06 linkto(var_01);
				thread trap_damage_trigger(var_06,var_06.script_noteworthy == "damage_over_time","fx_trap_move");
				break;

			case "moveto":
				var_01 trap_laser_move_list(var_06);
				break;

			default:
				break;
		}
	}

	for(;;)
	{
		self waittill("trap_state_change",var_08);
		thread trap_play_fx(var_01,var_08,param_00);
		switch(var_08)
		{
			case "active":
				thread trap_laser_move(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 24
trap_play_fx(param_00,param_01,param_02)
{
	if(isdefined(param_00.currentfx))
	{
		maps\mp\zombies\_util::stopfxontagnetwork(param_00.currentfx,param_00,"tag_origin");
		param_00.currentfx = undefined;
		wait(0.5);
	}

	var_03 = param_02.script_parameters + "_" + param_01;
	if(common_scripts\utility::fxexists(var_03))
	{
		param_00.currentfx = common_scripts\utility::getfx(var_03);
	}

	if(isdefined(param_00.currentfx))
	{
		maps\mp\zombies\_util::playfxontagnetwork(param_00.currentfx,param_00,"tag_origin");
	}
}

//Function Number: 25
trap_laser_move_list(param_00)
{
	while(isdefined(param_00))
	{
		self.movelist[self.movelist.size] = param_00;
		if(isdefined(param_00.target))
		{
			param_00 = common_scripts\utility::getstruct(param_00.target,"targetname");
			continue;
		}

		param_00 = undefined;
	}
}

//Function Number: 26
trap_laser(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = param_00.angles;
	var_01.start_origin = var_01.origin;
	var_01.start_angles = var_01.angles;
	var_01 setmodel("tag_laser");
	var_01.movelist = [];
	var_02 = [];
	if(isdefined(param_00.target))
	{
		var_03 = getentarray(param_00.target,"targetname");
		var_04 = common_scripts\utility::getstructarray(param_00.target,"targetname");
		var_02 = common_scripts\utility::array_combine(var_03,var_04);
	}

	foreach(var_06 in var_02)
	{
		if(!isdefined(var_06.script_noteworthy))
		{
			continue;
		}

		switch(var_06.script_noteworthy)
		{
			case "damage_over_time":
			case "damage":
				var_06 enablelinkto();
				var_06 linkto(var_01);
				thread trap_damage_trigger(var_06,var_06.script_noteworthy == "damage_over_time","laser");
				break;

			case "moveto":
				var_01 trap_laser_move_list(var_06);
				break;

			default:
				break;
		}
	}

	for(;;)
	{
		self waittill("trap_state_change",var_08);
		switch(var_08)
		{
			case "cooldown":
			case "no_power":
			case "deactivate":
				var_09 = "trap_laser_loop";
				if(isdefined(level.zmblasertrapsoundloop))
				{
					var_09 = level.zmblasertrapsoundloop;
				}
		
				var_01 stoploopsound(var_09);
				var_0A = "trap_laser_stop";
				if(isdefined(level.zmblasertrapsoundstop))
				{
					var_0A = level.zmblasertrapsoundstop;
				}
		
				var_01 playsound(var_0A);
				var_01 laseroff();
				break;
	
			case "active":
				thread trap_laser_move(var_01);
				thread trap_laser_color(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 27
trap_laser_color(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = "trap_warning_zm";
	if(isdefined(level.zmblasertrapwarningcustom))
	{
		var_01 = level.zmblasertrapwarningcustom;
	}

	var_02 = "trap_zm";
	if(isdefined(level.zmblasertrapcustom))
	{
		var_02 = level.zmblasertrapcustom;
	}

	param_00 laseron(var_01);
	var_03 = spawn("script_origin",param_00.origin);
	thread trap_laser_alarm_start(var_03);
	wait(3);
	thread trap_laser_alarm_stop(var_03);
	param_00 laseron(var_02);
	var_04 = "trap_laser_start";
	if(isdefined(level.zmblasertrapsoundstart))
	{
		var_04 = level.zmblasertrapsoundstart;
	}

	param_00 playsound(var_04);
	var_05 = "trap_laser_loop";
	if(isdefined(level.zmblasertrapsoundloop))
	{
		var_05 = level.zmblasertrapsoundloop;
	}

	param_00 playloopsound(var_05);
}

//Function Number: 28
trap_laser_alarm_start(param_00)
{
	if(level.laser_alarm_started == 0)
	{
		level.laser_alarm_started = 1;
		if(isdefined(param_00))
		{
			param_00 playloopsound("trap_laser_alarm");
			return;
		}
	}
}

//Function Number: 29
trap_laser_alarm_stop(param_00)
{
	level.laser_alarm_started = 0;
	if(isdefined(param_00))
	{
		param_00 stoploopsound("trap_laser_alarm");
		param_00 delete();
	}
}

//Function Number: 30
trap_laser_move(param_00)
{
	self endon("trap_state_change");
	if(!param_00.movelist.size)
	{
		return;
	}

	var_01 = 60;
	var_02 = 15;
	param_00.origin = param_00.start_origin;
	param_00.angles = param_00.start_angles;
	var_03 = 0;
	for(;;)
	{
		var_04 = param_00.movelist[var_03];
		var_05 = 0;
		var_06 = distance(param_00.origin,var_04.origin);
		if(var_06 > 0)
		{
			var_05 = var_06 / var_01;
		}

		var_07 = 0;
		if(isdefined(var_04.angles))
		{
			for(var_08 = 0;var_08 < 3;var_08++)
			{
				var_09 = abs(angleclamp(param_00.angles[var_08]) - angleclamp(var_04.angles[var_08])) > 0.01;
				if(var_09)
				{
					var_07 = 0.5 * anglesdelta(param_00.angles,var_04.angles);
					break;
				}
			}
		}

		if(!var_05 && var_07)
		{
			var_05 = var_07 / var_02;
		}

		if(var_06 > 0)
		{
			param_00 moveto(var_04.origin,var_05);
		}

		if(var_07 > 0)
		{
			param_00 rotateto(var_04.angles,var_05);
		}

		if(var_05 > 0)
		{
			wait(var_05);
		}

		var_03++;
		var_03 = var_03 % param_00.movelist.size;
	}
}

//Function Number: 31
trap_fx_ready(param_00)
{
	var_01 = undefined;
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		switch(var_02)
		{
			case "no_power":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
				break;
	
			case "deactivate":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
				break;
	
			case "ready":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
		
				var_01 = spawnfx(common_scripts\utility::getfx("trap_ready"),param_00.origin);
				triggerfx(var_01);
				break;
	
			case "active":
				if(isdefined(var_01))
				{
					var_01 delete();
				}
		
				var_01 = spawnfx(common_scripts\utility::getfx("trap_not_ready"),param_00.origin);
				triggerfx(var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 32
trap_damage_trigger(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "default";
	}

	for(;;)
	{
		self waittill("active");
		trap_damage_trigger_watch(param_00,param_01,param_02);
	}
}

//Function Number: 33
trap_damage_trigger_watch(param_00,param_01,param_02)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("ready");
	self endon("deactivate");
	var_03 = 1;
	var_04 = 5;
	if(param_02 == "fx_trap_move")
	{
		var_04 = 3;
	}

	var_05 = var_04 / var_03;
	if(isdefined(param_00.script_count))
	{
		var_05 = var_05 * param_00.script_count;
	}

	var_06 = 20;
	if(isdefined(param_00.script_count))
	{
		var_06 = var_06 / param_00.script_count;
	}

	if(level.currentgen)
	{
		if(isdefined(param_00.script_multiplier))
		{
			var_06 = var_06 * param_00.script_multiplier;
			var_05 = int(var_05 / param_00.script_multiplier);
		}
	}

	var_07 = gettime();
	var_08 = "trap_zm_mp";
	if(isdefined(level.zmcustomdamagetriggerweapon))
	{
		var_08 = self [[ level.zmcustomdamagetriggerweapon ]](param_00,param_01,param_02);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_09);
		var_0A = (var_09.origin[0],var_09.origin[1],param_00.origin[2]);
		if(isplayer(var_09))
		{
			if(isdefined(param_00.script_parameters) && param_00.script_parameters == "no_player_damage")
			{
				continue;
			}

			if(isdefined(var_09.nexttrapdamage) && var_09.nexttrapdamage > gettime())
			{
				continue;
			}

			if(var_07 + 3000 > gettime())
			{
				continue;
			}

			var_09.nexttrapdamage = gettime() + 200;
			if(isdefined(level.modplayertrapdmg) && isdefined(param_00.script_count))
			{
				var_09.nexttrapdamage = gettime() + 200 * param_00.script_count;
			}

			var_09 dodamage(var_06,var_09.origin,undefined,undefined,"MOD_TRIGGER_HURT");
			continue;
		}

		if(isdefined(var_09.agentteam) && var_09.agentteam == level.playerteam)
		{
			if(isdefined(param_00.script_parameters) && param_00.script_parameters == "no_player_damage")
			{
				continue;
			}

			if(isdefined(var_09.nexttrapdamage) && var_09.nexttrapdamage > gettime())
			{
				continue;
			}

			if(var_07 + 3000 > gettime())
			{
				continue;
			}

			var_09.nexttrapdamage = gettime() + 200;
			var_09 dodamage(var_06 * 0.5,var_09.origin);
			continue;
		}

		var_0B = trap_damage_trigger_location(var_09,var_0A);
		if(param_01)
		{
			if(!isdefined(var_09.maxhealth))
			{
				continue;
			}

			if(isdefined(var_09.nexttrapdot) && var_09.nexttrapdot > gettime())
			{
				continue;
			}

			var_09.nexttrapdot = gettime() + int(1000 / var_04);
			var_0C = "MOD_TRIGGER_HURT";
			if(isdefined(param_00.script_count))
			{
				var_0C = "MOD_IMPACT";
			}

			var_0D = int(var_09.maxhealth / var_05);
			if(var_09 maps\mp\zombies\_util::istrapresistant())
			{
				var_0D = var_0D * 0.1;
			}

			var_09 dodamage(var_0D,var_0A,self.owner,self.owner,var_0C,var_08,var_0B);
		}
		else
		{
			var_0D = var_0A.health;
			if(var_09 maps\mp\zombies\_util::istrapresistant())
			{
				var_0D = var_0D * 0.2;
			}

			var_09 dodamage(var_0D,var_0A,self.owner,self.owner,"MOD_TRIGGER_HURT",var_08,var_0B);
		}
	}
}

//Function Number: 34
trap_damage_trigger_location(param_00,param_01)
{
	var_02 = param_01[2] - param_00.origin[2];
	if(var_02 < 32)
	{
		return common_scripts\utility::random(["right_leg_upper","left_leg_upper"]);
	}

	if(var_02 < 60)
	{
		return common_scripts\utility::random(["left_arm_upper","right_arm_upper"]);
	}

	return common_scripts\utility::random(["head","neck"]);
}

//Function Number: 35
isexplosivetrap(param_00)
{
	return isdefined(param_00) && param_00 == "zombie_trap_barrel";
}

//Function Number: 36
trap_state_fx(param_00)
{
	var_01 = undefined;
	for(;;)
	{
		self waittill("trap_state_change",var_02);
		if(isdefined(var_01))
		{
			var_01 delete();
		}

		var_03 = param_00.script_parameters + "_" + var_02;
		if(common_scripts\utility::fxexists(var_03))
		{
			var_01 = common_scripts\utility::getfx(var_03);
		}

		if(isdefined(var_01))
		{
			var_01 = spawnfx(var_01,param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
			triggerfx(var_01);
		}

		thread audio_trap_fx(var_03,var_01,param_00.origin);
	}
}

//Function Number: 37
trap_setup_custom_hints(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.hint_strings))
		{
			var_05.hint_strings = [];
		}

		var_05.hint_strings["hint_ready"] = param_01;
		var_05.hint_strings["hint_cooldown"] = param_02;
	}
}

//Function Number: 38
trap_setup_custom_function(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_05 in var_03)
	{
		var_05 thread trap_custom_function_think(param_01,param_02);
	}
}

//Function Number: 39
trap_custom_function_think(param_00,param_01)
{
	var_02 = self;
	for(;;)
	{
		var_02 waittill("trap_state_change",var_03);
		if(var_03 == param_00)
		{
			thread [[ param_01 ]](var_02);
		}
	}
}

//Function Number: 40
trap_distraction(param_00)
{
	for(;;)
	{
		self waittill("active");
		var_01 = spawn("script_model",param_00.origin);
		var_01.groundpos = var_01.origin;
		var_01.team = level.playerteam;
		if(isdefined(param_00.script_count))
		{
			var_01.maxcount = param_00.script_count;
		}

		var_01.istrap = 1;
		var_01.agentcount = 0;
		level notify("distraction_drone_activated",var_01);
		level.zdd_active[level.zdd_active.size] = var_01;
		common_scripts\utility::waittill_any("cooldown","no_power","ready","deactivate");
		if(!isdefined(var_01))
		{
			continue;
		}

		level.zdd_active = common_scripts\utility::array_remove(level.zdd_active,var_01);
		var_01 delete();
	}
}

//Function Number: 41
audio_trap_fx(param_00,param_01,param_02)
{
	var_03 = param_00;
	if(isdefined(var_03) && soundexists(var_03))
	{
		if(isdefined(param_01) && maps\mp\zombies\_util::getzombieslevelnum() > 2)
		{
			playsoundatpos(param_01.origin,var_03);
		}
		else if(isdefined(param_01))
		{
			maps\mp\_audio::snd_play_linked(var_03,param_01);
		}
		else
		{
			maps\mp\_audio::snd_play_in_space(var_03,param_02);
		}
	}

	var_04 = param_00 + "_lp";
	if(isdefined(var_04) && soundexists(var_04))
	{
		if(isdefined(param_01))
		{
			maps\mp\_audio::snd_play_linked_loop(var_04,param_01,0.25);
		}
	}
}

//Function Number: 42
trap_zomboni_track_last_safe_origin()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread player_track_last_safe_origin();
	}
}

//Function Number: 43
player_track_last_safe_origin()
{
	self endon("disconnect");
	thread player_track_last_unresolved_collision_time();
	for(;;)
	{
		if(self.last_unresolved_collision_time < gettime())
		{
			self.last_safe_origin = self.origin;
		}

		wait 0.05;
	}
}

//Function Number: 44
player_track_last_unresolved_collision_time()
{
	self.last_unresolved_collision_time = 0;
	for(;;)
	{
		self waittill("unresolved_collision");
		self.last_unresolved_collision_time = gettime();
	}
}

//Function Number: 45
trap_zomboni(param_00)
{
	if(!isdefined(level.zomboni_init))
	{
		precachempanim("zombie_ark_zomboni_trap");
		level.zomboni_init = 1;
		createthreatbiasgroup("zomboni");
		level._effect["chompy_churn"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_churn");
		level._effect["chompy_lights"] = loadfx("vfx/gameplay/mp/zombie/dlc_chompy_lights");
		level thread trap_zomboni_track_last_safe_origin();
	}

	self.trap_active_end_notify = "zomboni_done";
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("vehicle_ind_zomboni_ai");
	var_01.angles = param_00.angles;
	var_01.linegunignore = 1;
	var_01.noturretplacement = 1;
	var_01 makeentitysentient(level.playerteam);
	var_01 setthreatbiasgroup("zomboni");
	var_01.canbetargetedby = ::trap_zomboni_can_be_targeted_by;
	if(!isdefined(level.npcs))
	{
		level.npcs = [];
	}

	level.npcs[level.npcs.size] = var_01;
	var_01.attack_locs = [];
	var_02 = 40;
	var_03 = 150;
	var_04 = 50;
	var_05 = [["tag_zom_attach_1","left"],["tag_zom_attach_2","right"],["tag_zom_attach_3","rear"]];
	foreach(var_0C, var_07 in var_05)
	{
		var_08 = var_07[0];
		var_09 = var_07[1];
		var_0A = var_01 gettagorigin(var_08);
		var_0B = spawn("script_model",var_0A);
		var_0B.angles = var_01 gettagangles(var_08);
		var_0B setmodel("tag_origin");
		var_0B linkto(var_01,var_08);
		var_0B.grab_radius = var_02;
		var_0B.jump_radius = var_03;
		var_0B.attack_radius = var_04;
		var_0B.attack_name = var_09;
		var_0B.anim_index = var_0C;
		var_01.attack_locs[var_01.attack_locs.size] = var_0B;
		thread trap_zomboni_attack_ent_debug(var_0B);
	}

	var_01.iszomboni = 1;
	var_0D = getentarray(param_00.target,"targetname");
	var_0E = common_scripts\utility::getstructarray(param_00.target,"targetname");
	var_0F = common_scripts\utility::array_combine(var_0D,var_0E);
	var_01.doors = [];
	foreach(var_11 in var_0F)
	{
		if(!isdefined(var_11.script_noteworthy))
		{
			continue;
		}

		switch(var_11.script_noteworthy)
		{
			case "clip":
				var_11.unresolved_collision_func = ::trap_zomboni_unresolved_collision;
				var_11.zomboni = var_01;
				var_11.noturretplacement = 1;
				var_01.clip = var_11;
				var_11 linkto(var_01);
				break;

			case "mantle":
				var_01.mantle = var_11;
				var_01.mantle hide();
				var_01.mantlecontents = var_01.mantle setcontents(0);
				var_11 linkto(var_01);
				break;

			case "kill_trigger":
				var_11 enablelinkto();
				var_11 linkto(var_01);
				var_01.killtrigger = var_11;
				break;

			case "door":
				var_11.close_origin = var_11.origin;
				var_11.open_origin = var_11.close_origin + (0,0,60);
				var_01.doors[var_01.doors.size] = var_11;
				break;

			default:
				break;
		}
	}

	while(!threatbiasgroupexists("zombies"))
	{
		wait 0.05;
	}

	setthreatbias("zomboni","zombies",2000);
	for(;;)
	{
		var_01.ignoreme = 1;
		self waittill("active");
		var_01.isstopped = 0;
		playfxontag(common_scripts\utility::getfx("chompy_lights"),var_01,"tag_fx_lights");
		var_01 playsound("chompy_engine_start");
		var_01 playloopsound("chompy_engine_loop");
		var_01 scriptmodelplayanimdeltamotionfrompos("zombie_ark_zomboni_trap",param_00.origin,param_00.angles,"zomboni_anim");
		thread trap_zomboni_notetracks(var_01);
		thread trap_zomboni_zombies_attack(var_01);
		thread trap_zomboni_enable_targeting_after_zone_enabled(var_01);
		thread trap_zomboni_kill_zone(var_01);
		var_01 waittill("end");
		self notify("zomboni_done");
		var_01 stoploopsound();
		var_01 playsound("chompy_engine_stop");
		killfxontag(common_scripts\utility::getfx("chompy_lights"),var_01,"tag_fx_lights");
		var_01 scriptmodelclearanim();
		var_01.origin = param_00.origin;
		var_01.angles = param_00.angles;
	}
}

//Function Number: 46
trap_zomboni_enable_targeting_after_zone_enabled(param_00)
{
	self endon("zomboni_done");
	while(!maps\mp\zombies\_zombies_zone_manager::iszoneenabled("cargo_bay"))
	{
		wait(0.05);
	}

	param_00.ignoreme = 0;
	for(;;)
	{
		var_01 = param_00 maps\mp\zombies\_util::getenemyagents();
		foreach(var_03 in var_01)
		{
			var_04 = var_03 maps\mp\zombies\_zombies_zone_manager::getzombiezone();
			if(isdefined(var_04))
			{
				if(param_00 trap_zomboni_zombie_in_zone_allowed_to_target(var_03,var_04))
				{
					var_03 getenemyinfo(param_00);
				}
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 47
trap_zomboni_can_be_targeted_by(param_00)
{
	if(self.ignoreme)
	{
		return 0;
	}

	var_01 = param_00 maps\mp\zombies\_zombies_zone_manager::getzombiezone();
	if(!isdefined(var_01))
	{
		return 1;
	}

	return trap_zomboni_zombie_in_zone_allowed_to_target(param_00,var_01);
}

//Function Number: 48
trap_zomboni_zombie_in_zone_allowed_to_target(param_00,param_01)
{
	if(param_01 == "cargo_bay")
	{
		return 1;
	}
	else if((param_01 == "biomed" && common_scripts\utility::flag("biomed_to_cargo_bay")) || param_01 == "cargo_elevator" && common_scripts\utility::flag("cargo_elevator_to_cargo_bay"))
	{
		var_02 = distancesquared(param_00.origin,self.origin);
		if(var_02 < squared(1900))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 49
trap_zomboni_show_unresoloved_collision_locs(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		var_01 = trap_zomboni_get_unresolved_collision_locs(param_00);
		foreach(var_03 in var_01)
		{
		}

		wait 0.05;
	}
}

//Function Number: 50
trap_zomboni_get_unresolved_collision_locs(param_00,param_01)
{
	var_02 = [];
	var_03 = [(-16,16,56),(0,16,56),(18,16,56),(-16,-22,56),(0,-22,56),(18,-22,56),(-16,-60,56),(0,-60,56),(18,-60,56)];
	var_04 = getent("zomboni_room_volume","targetname");
	var_05 = param_00 gettagorigin("body_animate_jnt");
	var_05 = (var_05[0],var_05[1],param_00.origin[2]);
	foreach(var_07 in var_03)
	{
		var_08 = spawnstruct();
		var_08.origin = var_05 + rotatevector(var_07,param_00.angles + (0,-90,0));
		if(!isdefined(var_04) || !ispointinvolume(var_08.origin,var_04))
		{
			var_02[var_02.size] = var_08;
		}
	}

	var_0A = getnodesinradius(var_05,200,0,100);
	var_0B = anglestoforward(param_00.angles);
	foreach(var_0D in var_0A)
	{
		var_0E = vectornormalize(var_0D.origin - var_05);
		if(vectordot(var_0B,var_0E) < 0)
		{
			var_02[var_02.size] = var_0D;
		}
	}

	if(isdefined(param_01))
	{
		var_08 = spawnstruct();
		var_08.origin = param_01.last_safe_origin;
		var_02[var_02.size] = var_08;
	}

	return var_02;
}

//Function Number: 51
trap_zomboni_unresolved_collision(param_00)
{
	self.unresolved_collision_nodes = trap_zomboni_get_unresolved_collision_locs(self.zomboni,param_00);
	maps\mp\_movers::unresolved_collision_nearest_node(param_00,0);
}

//Function Number: 52
trap_zomboni_attack_ent_debug(param_00)
{
	level.trap_zomboni_attack_ent_debug = 0;
	for(;;)
	{
		wait 0.05;
		if(!maps\mp\zombies\_util::is_true(level.trap_zomboni_attack_ent_debug))
		{
			continue;
		}

		var_01 = param_00.attacker;
		var_02 = (1,1,0);
		var_03 = (1,1,1);
		if(isdefined(var_01))
		{
			var_02 = (1,0,0);
			var_03 = (1,0,0);
		}

		maps\mp\bots\_bots_util::bot_draw_circle(param_00.origin,param_00.grab_radius,var_02,0,16);
		maps\mp\bots\_bots_util::bot_draw_circle(param_00.origin,param_00.jump_radius,var_03,0,16);
	}
}

//Function Number: 53
trap_zomboni_stop(param_00)
{
	self endon("zomboni_done");
	if(!isdefined(param_00.clip))
	{
		return;
	}

	for(;;)
	{
		var_01 = 0;
		foreach(var_03 in level.players)
		{
			var_04 = var_03 getgroundentity();
			if(isdefined(var_04) && var_04 == param_00.clip)
			{
				var_01 = 1;
				break;
			}
		}

		if(var_01 && !param_00.isstopped)
		{
			param_00 scriptmodelpauseanim(1);
			param_00.isstopped = 1;
		}
		else if(!var_01 && param_00.isstopped)
		{
			param_00 scriptmodelpauseanim(0);
			param_00.isstopped = 0;
		}

		wait 0.05;
	}
}

//Function Number: 54
trap_zomboni_is_any_player_on_zomboni(param_00)
{
	foreach(var_02 in level.players)
	{
		if(trap_zomboni_is_player_on_zomboni(var_02,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 55
trap_zomboni_is_player_on_zomboni(param_00,param_01)
{
	var_02 = param_00 getgroundentity();
	if(!isdefined(var_02))
	{
		return 0;
	}

	return var_02 == param_01.clip;
}

//Function Number: 56
trap_zomboni_zombies_attack(param_00)
{
	self endon("zomboni_done");
	param_00.jumpon_enabled = 0;
	foreach(var_02 in param_00.attack_locs)
	{
		var_02.attacker = undefined;
		var_02.nexttimer = 0;
	}

	param_00.jumpon_next = 0;
	for(;;)
	{
		wait 0.05;
		if(!param_00.jumpon_enabled)
		{
			continue;
		}

		if(param_00.jumpon_next > gettime())
		{
			continue;
		}

		foreach(var_05 in level.characters)
		{
			if(isdefined(var_05.nextzombonijumpontime) && var_05.nextzombonijumpontime > gettime())
			{
				continue;
			}

			var_05.nextzombonijumpontime = gettime() + randomintrange(1,5) * 50;
			if(!isalive(var_05))
			{
				continue;
			}

			if(isplayer(var_05))
			{
				continue;
			}

			if(!var_05 maps\mp\zombies\_util::has_entered_game())
			{
				continue;
			}

			if(!isscriptedagent(var_05) || var_05.agent_type == "zombie_dog")
			{
				continue;
			}

			if(var_05 maps\mp\zombies\_util::istrapresistant())
			{
				continue;
			}

			if(var_05 maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
			{
				continue;
			}

			if(var_05 maps\mp\agents\humanoid\_humanoid_util::iscrawling())
			{
				continue;
			}

			if(!isdefined(var_05.enemy))
			{
				continue;
			}

			if(var_05.enemy != param_00)
			{
				if(!isplayer(var_05.enemy))
				{
					continue;
				}

				if(!trap_zomboni_is_player_on_zomboni(var_05.enemy,param_00))
				{
					continue;
				}
			}

			var_06 = undefined;
			var_07 = undefined;
			foreach(var_02 in param_00.attack_locs)
			{
				if(isdefined(var_02.attacker))
				{
					continue;
				}

				if(var_02.nexttimer > gettime())
				{
					continue;
				}

				var_09 = anglestoforward(var_02.angles);
				var_0A = var_02.jump_radius * var_02.jump_radius;
				var_0B = anglestoforward(var_05.angles);
				if(vectordot(var_0B,var_09) < 0.1)
				{
					continue;
				}

				var_0C = vectornormalize(param_00.origin - var_05.origin);
				if(vectordot(var_0C,var_0B) < 0.1)
				{
					continue;
				}

				var_0D = distancesquared(var_02.origin,var_05.origin);
				if(var_0D < var_0A)
				{
					if(!isdefined(var_06) || var_0D < var_07)
					{
						var_06 = var_02;
						var_07 = var_0D;
					}
				}
			}

			if(isdefined(var_06))
			{
				param_00.jumpon_next = gettime() + randomintrange(3000,5000);
				thread trap_zomboni_zombie_attack(param_00,var_05,var_06);
			}
		}
	}
}

//Function Number: 57
trap_zomboni_assign_attack_ent(param_00,param_01,param_02)
{
	param_01.attacker = param_02;
	common_scripts\utility::waittill_any_ents(self,"zomboni_done",param_02,"death");
	param_01.nexttimer = gettime() + randomintrange(1000,3000);
	param_01.attacker = undefined;
}

//Function Number: 58
trap_zomboni_zombie_attack(param_00,param_01,param_02)
{
	param_01 endon("death");
	thread trap_zomboni_assign_attack_ent(param_00,param_02,param_01);
	param_01 scragentsetscripted(1);
	param_01 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"AttackZomboni");
	param_01 scragentsetphysicsmode("noclip");
	trap_zomboni_zombie_attack_anims(param_00,param_01,param_02);
	param_01 scragentsetscripted(0);
	param_01 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"AttackZomboni");
}

//Function Number: 59
trap_zomboni_zombie_attack_anims(param_00,param_01,param_02)
{
	self endon("zomboni_done");
	param_01.zomboni = param_00;
	param_01.attack_ent = param_02;
	var_03 = "zomboni_attack_get_on";
	var_04 = 0.67;
	var_05 = distance(param_01.origin,param_02.origin);
	if(var_05 > param_02.grab_radius)
	{
		var_03 = "zomboni_attack_leap_on";
	}

	var_06 = param_02.anim_index;
	param_01 scragentsetanimscale(0,1);
	param_01 scragentsynchronizeanims(var_04,var_04,param_02,"tag_origin");
	param_01 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_06,1,"scripted_anim");
	param_01 scragentsetanimscale(1,1);
	for(;;)
	{
		var_03 = "zomboni_attack_zomboni";
		if(trap_zomboni_is_any_player_on_zomboni(param_00))
		{
			var_03 = "zomboni_attack_player";
		}

		var_06 = param_02.anim_index;
		param_01 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(var_03,var_06,1,"scripted_anim",undefined,::trap_zomboni_zombie_attack_notetracks);
		var_03 = "zomboni_attack_idle";
		var_06 = param_02.anim_index;
		param_01 maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_03,var_06,1);
		wait(randomfloatrange(1,2.5));
	}
}

//Function Number: 60
trap_zomboni_zombie_attack_notetracks(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "hit":
			var_04 = [];
			foreach(var_06 in level.players)
			{
				var_07 = var_06 getgroundentity();
				if(isdefined(var_07) && var_07 == self.zomboni.clip)
				{
					var_08 = distance2d(self.attack_ent.origin,var_06.origin);
					var_09 = self.attack_ent.attack_radius;
					if(var_06 getstance() == "prone")
					{
						var_09 = var_09 + 40;
					}
	
					if(var_08 < var_09)
					{
						var_04[var_04.size] = var_06;
					}
				}
			}
	
			foreach(var_06 in var_04)
			{
				self notify("attack_hit",var_06,var_06.origin);
				var_0C = 0;
				if(isdefined(self.meleedamage))
				{
					var_0C = self.meleedamage;
				}
	
				if(isalive(var_06))
				{
					maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_06,var_0C,"MOD_IMPACT");
				}
			}
			break;

		default:
			break;
	}
}

//Function Number: 61
trap_zomboni_notetracks(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_00 waittill("zomboni_anim",var_01);
		switch(var_01)
		{
			case "door_open":
				foreach(var_03 in param_00.doors)
				{
					trap_zomboni_door_open(var_03,1);
				}
				break;
	
			case "door_close":
				foreach(var_03 in param_00.doors)
				{
					trap_zomboni_door_close(var_03,1);
				}
				break;
	
			case "tag_hood_left":
				self notify("tag_hood_left");
				break;
	
			case "end":
				param_00 notify("end");
				break;
	
			case "enable_jumpon":
				if(isdefined(param_00.mantle))
				{
					param_00.mantle setcontents(param_00.mantlecontents);
					param_00.mantle show();
				}
		
				param_00.jumpon_enabled = 1;
				foreach(var_08 in param_00.attack_locs)
				{
					var_08.nexttimer = gettime() + randomintrange(0,2000);
				}
				break;
	
			case "disable_jumpon":
				if(isdefined(param_00.mantle))
				{
					param_00.mantle setcontents(0);
					param_00.mantle hide();
				}
		
				param_00.jumpon_enabled = 0;
				break;
	
			case "damage_rear":
			case "damage_left":
			case "damage_right":
			case "damage_sides":
				thread trap_zomboni_damage_jumpons(param_00,var_01);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 62
trap_zomboni_damage_jumpons(param_00,param_01)
{
	var_02 = [];
	var_02["damage_left"] = ["left"];
	var_02["damage_right"] = ["right"];
	var_02["damage_rear"] = ["rear"];
	var_02["damage_sides"] = ["left","right"];
	var_03 = var_02[param_01];
	foreach(var_05 in var_03)
	{
		foreach(var_07 in param_00.attack_locs)
		{
			if(isdefined(var_07.attacker) && var_07.attack_name == var_05)
			{
				var_08 = var_07.attacker;
				var_09 = self.owner;
				if(isremovedentity(var_09))
				{
					var_09 = undefined;
				}

				var_08 dodamage(var_08.health,var_08.origin,var_09,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
			}
		}
	}
}

//Function Number: 63
trap_zomboni_animated_distraction_update(param_00)
{
	self endon("zomboni_done");
	self endon("tag_hood_left");
	wait(2);
	for(;;)
	{
		var_01 = param_00 gettagorigin("tag_hood");
		thread trap_zomboni_animated_distraction(var_01,7);
		wait(3);
	}
}

//Function Number: 64
trap_zomboni_animated_distraction(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02.groundpos = param_00;
	var_02.team = level.playerteam;
	var_02.maxdistsqr = 640000;
	var_02.maxcount = 6;
	var_02.istrap = 1;
	var_02.agentcount = 0;
	var_02.active = 1;
	level notify("distraction_drone_activated",var_02);
	level.zdd_active[level.zdd_active.size] = var_02;
	wait(param_01);
	level.zdd_active = common_scripts\utility::array_remove(level.zdd_active,var_02);
	var_02.active = 0;
	var_02 notify("stop");
}

//Function Number: 65
trap_zomboni_door_open(param_00,param_01)
{
	param_00 playsound("chompy_hatch");
	param_00 moveto(param_00.open_origin,param_01);
}

//Function Number: 66
trap_zomboni_door_close(param_00,param_01)
{
	param_00 moveto(param_00.close_origin,param_01);
}

//Function Number: 67
trap_zomboni_kill_zone(param_00)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_00.killtrigger waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\zombies\_util::istrapresistant())
		{
			continue;
		}

		if(isdefined(var_01.nexttrapdamage) && var_01.nexttrapdamage > gettime())
		{
			continue;
		}

		if(param_00.isstopped)
		{
			continue;
		}

		var_01.nexttrapdamage = gettime() + 200;
		if(isplayer(var_01))
		{
			var_01 dodamage(10,var_01.origin,undefined,param_00);
			continue;
		}

		thread trap_zomboni_play_churn_fx(param_00);
		if(!isscriptedagent(var_01) || var_01.agent_type == "zombie_dog" || !trap_zomboni_try_zombie_death_anim(param_00,var_01))
		{
			var_02 = self.owner;
			if(isremovedentity(var_02))
			{
				var_02 = undefined;
			}

			var_01 dodamage(var_01.health,var_01.origin,var_02,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
			if(isalive(var_01))
			{
				var_01 suicide();
			}
		}
	}
}

//Function Number: 68
trap_zomboni_play_churn_fx(param_00)
{
	param_00 notify("play_churn_fx");
	param_00 endon("play_churn_fx");
	if(!maps\mp\zombies\_util::is_true(param_00.churn_fx))
	{
		playfxontag(common_scripts\utility::getfx("chompy_churn"),param_00,"body_animate_jnt");
	}

	param_00.churn_fx = 1;
	wait(5);
	param_00.churn_fx = 0;
	stopfxontag(common_scripts\utility::getfx("chompy_churn"),param_00,"body_animate_jnt");
}

//Function Number: 69
trap_zomboni_try_zombie_death_anim(param_00,param_01)
{
	if(maps\mp\zombies\_util::is_true(param_01.zomboni_death))
	{
		return 1;
	}

	if(param_01 maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return 0;
	}

	thread trap_zomboni_zombie_death_anim(param_00,param_01);
	return 1;
}

//Function Number: 70
trap_zomboni_zombie_death_anim(param_00,param_01)
{
	param_01 notify("killanimscript");
	param_01.zomboni_death = 1;
	param_01 scragentsetanimmode("anim deltas");
	param_01 scragentsetanimscale(1,1);
	param_01 scragentsetphysicsmode("noclip");
	var_02 = angleclamp180(param_00.angles[1] - param_01.angles[1]);
	var_03 = "zomboni_trap_victim";
	var_04 = param_01 getanimentrycount(var_03);
	var_05 = 0;
	if(abs(var_02) < 45)
	{
		var_05 = 3;
		if(var_04 > 3 && common_scripts\utility::cointoss())
		{
			var_05 = 4;
		}
	}
	else if(var_02 < 135)
	{
		var_05 = 2;
	}
	else if(var_02 > -135)
	{
		var_05 = 1;
	}

	var_06 = undefined;
	var_07 = undefined;
	var_08 = ["tag_zom_align_center","tag_zom_align_right","tag_zom_align_left"];
	foreach(var_0A in var_08)
	{
		var_0B = param_00 gettagorigin(var_0A);
		var_0C = distance2d(var_0B,param_01.origin);
		if(!isdefined(var_06) || var_0C < var_07)
		{
			var_06 = var_0A;
			var_07 = var_0C;
		}
	}

	param_01 playsoundonmovingent("chompy_chomp");
	param_01.godmode = 1;
	param_01 scragentsetscripted(1);
	param_01 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"SynchronizedAnim");
	param_01 scragentsetphysicsmode("noclip");
	param_01 scragentsynchronizeanims(0.5,0.5,param_00,var_06);
	trap_zomboni_zombie_death_anim_wait(param_01,var_03,var_05);
	param_01.godmode = 0;
	param_01.bypasscorpse = 1;
	var_0E = self.owner;
	if(isremovedentity(var_0E))
	{
		var_0E = undefined;
	}

	param_01 dodamage(param_01.health,param_01.origin,var_0E,param_00,"MOD_TRIGGER_HURT","trap_zm_mp");
	if(isalive(param_01))
	{
		param_01 suicide();
	}
}

//Function Number: 71
trap_zomboni_zombie_death_anim_wait(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("trap_zomboni_zombie_death_anim_timeout");
	param_00 thread trap_zomboni_zombie_death_anim_timeout(param_01,param_02);
	param_00 maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(param_01,param_02,1,"scripted_anim",undefined,::trap_zomboni_zombie_death_notetracks);
	param_00 notify("end_trap_zomboni_zombie_death_anim_timeout");
}

//Function Number: 72
trap_zomboni_zombie_death_anim_timeout(param_00,param_01)
{
	self endon("death");
	self endon("end_trap_zomboni_zombie_death_anim_timeout");
	var_02 = 3;
	if(isdefined(param_01))
	{
		var_02 = getanimlength(self getanimentry(param_00,param_01));
	}
	else
	{
		var_02 = getanimlength(self getanimentry(param_00,0));
	}

	wait(var_02 + 0.05);
	self notify("trap_zomboni_zombie_death_anim_timeout");
}

//Function Number: 73
trap_zomboni_zombie_death_notetracks(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "remove_head":
			var_04 = maps\mp\zombies\_mutators::locationtobodypart("head");
			maps\mp\zombies\_mutators::mutilate(self.missingbodyparts | var_04,1,1,(0,0,1),0);
			break;

		case "remove_arms":
			var_05 = maps\mp\zombies\_mutators::locationtobodypart("right_arm_lower");
			var_06 = maps\mp\zombies\_mutators::locationtobodypart("left_arm_lower");
			var_07 = common_scripts\utility::random([var_05,var_06,var_05 | var_06]);
			maps\mp\zombies\_mutators::mutilate(self.missingbodyparts | var_07,1,1,(0,0,1),0);
			break;

		case "remove_legs":
			var_08 = maps\mp\zombies\_mutators::locationtobodypart("right_leg_lower");
			var_09 = maps\mp\zombies\_mutators::locationtobodypart("left_leg_lower");
			var_0A = common_scripts\utility::random([var_08,var_09,var_08 | var_09]);
			maps\mp\zombies\_mutators::mutilate(self.missingbodyparts | var_0A,1,1,(0,0,1),0);
			break;

		default:
			break;
	}
}

//Function Number: 74
trap_zomboni_process_path(param_00,param_01)
{
	param_00.path_nodes = [];
	param_00.notify_path_nodes = [];
	var_02 = param_01.origin;
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0;
	var_06 = undefined;
	while(isdefined(param_01))
	{
		var_07 = trap_zomboni_path_get_linked_ents(param_01);
		foreach(var_09 in var_07)
		{
			if(!isdefined(var_09.script_noteworthy))
			{
				continue;
			}

			switch(var_09.script_noteworthy)
			{
				case "door":
					var_09.close_origin = var_09.origin;
					var_09.open_origin = var_09.close_origin + (0,0,60);
					break;

				case "distraction":
					var_09.active = 0;
					break;

				default:
					break;
			}
		}

		var_0B = param_00 getattachpos(param_01)[0];
		if((!isdefined(var_04) || distance(var_04.origin,var_0B) > 400) && distance(var_02,var_0B) > 300)
		{
			param_01.distraction = spawnstruct();
			param_01.distraction.origin = var_0B;
			var_04 = param_01.distraction;
		}

		if(isdefined(var_06))
		{
			var_05 = var_05 + distance(param_01.origin,var_06.origin);
		}

		param_01.pathdist = var_05;
		param_00.path_nodes[param_00.path_nodes.size] = param_01;
		if(isdefined(param_01.script_noteworthy))
		{
			param_01.notes = strtok(param_01.script_noteworthy,",");
			param_00.notify_path_nodes[param_00.notify_path_nodes.size] = param_01;
			foreach(var_0D in param_01.notes)
			{
				switch(var_0D)
				{
					case "door_close":
						var_03 = !var_03;
						break;

					default:
						break;
				}
			}
		}

		if(isdefined(param_01.target))
		{
			var_06 = param_01;
			param_01 = getvehiclenode(param_01.target,"targetname");
			continue;
		}

		break;
	}

	param_00.pathdist = var_05;
}

//Function Number: 75
trap_zomboni_path_node_passed(param_00,param_01)
{
	self endon("zomboni_done");
	param_01 waittill("trigger");
	param_01 notify("passed",param_00);
	param_00 notify("passed_node",param_01);
	param_01.passed = 1;
}

//Function Number: 76
trap_zomboni_path_notify(param_00,param_01)
{
	self endon("zomboni_done");
	for(;;)
	{
		param_01 waittill("trigger");
		foreach(var_03 in param_01.notes)
		{
			switch(var_03)
			{
				case "door_open":
					var_04 = 1;
					param_00 zomboni_stop();
					var_05 = trap_zomboni_path_get_linked_ents(param_01,"door");
					foreach(var_07 in var_05)
					{
						thread trap_zomboni_door_open(var_07,var_04);
					}
		
					wait(var_04);
					param_00 zomboni_resume();
					break;
	
				case "door_close":
					var_09 = 1;
					var_05 = trap_zomboni_path_get_linked_ents(param_01,"door");
					foreach(var_07 in var_05)
					{
						thread trap_zomboni_door_close(var_07,var_09);
					}
					break;
	
				case "end":
					param_00 notify("end");
					break;
	
				default:
					break;
			}
		}
	}
}

//Function Number: 77
trap_zomboni_distraction(param_00,param_01)
{
	var_02 = 2000;
	if(param_00.pathdist > var_02)
	{
		for(;;)
		{
			param_01 waittill("passed_node",var_03);
			if(param_00.pathdist - var_03.pathdist < var_02)
			{
				break;
			}
		}
	}

	self.groundpos = self.origin;
	self.team = level.playerteam;
	self.maxdistsqr = 640000;
	self.maxcount = 6;
	self.istrap = 1;
	self.agentcount = 0;
	self.active = 1;
	level notify("distraction_drone_activated",self);
	level.zdd_active[level.zdd_active.size] = self;
	param_00 waittill("passed");
	level.zdd_active = common_scripts\utility::array_remove(level.zdd_active,self);
	self.active = 0;
	self notify("stop");
}

//Function Number: 78
trap_zomboni_path_get_linked_ents(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.script_linkto))
	{
		var_03 = strtok(param_00.script_linkto," ");
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			var_05 = getent(var_03[var_04],"script_linkname");
			if(isdefined(var_05))
			{
				if(!isdefined(param_01) || isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == param_01)
				{
					var_02[var_02.size] = var_05;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 79
zomboni_stop()
{
	self vehicle_setspeed(0,100,100);
}

//Function Number: 80
zomboni_resume()
{
	self resumespeed(100);
}