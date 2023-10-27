/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_shg_common.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 82
 * Decompile Time: 1397 ms
 * Timestamp: 10/27/2023 2:34:53 AM
*******************************************************************/

//Function Number: 1
func_1232(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	level.player setorigin(var_01.origin);
	var_02 = undefined;
	if(isdefined(var_01.target))
	{
		var_02 = getent(var_01.target,"targetname");
	}

	if(isdefined(var_02))
	{
		level.player setplayerangles(vectortoangles(var_02.origin - var_01.origin));
		return;
	}

	level.player setplayerangles(var_01.angles);
}

//Function Number: 2
tank_fire_at_enemies(param_00)
{
	self endon("death");
	self endon("stop_random_tank_fire");
	var_01 = undefined;
	for(;;)
	{
		if(isdefined(var_01) && var_01.health > 0)
		{
			self setturrettargetent(var_01,(randomintrange(-64,64),randomintrange(-64,64),randomintrange(-16,100)));
			if(sighttracepassed(self.origin + (0,0,100),var_01.origin + (0,0,40),0,self))
			{
				self.var_1234++;
				self fireweapon();
				if(self.var_1234 >= 3)
				{
					if((!isdefined(var_01.damageshield) || var_01.damageshield == 0) && !isdefined(var_01.magic_bullet_shield) || var_01.magic_bullet_shield == 0)
					{
						var_01 notify("death");
					}
				}

				wait randomintrange(4,10);
			}
			else
			{
				var_01 = undefined;
				wait 1;
			}
		}
		else
		{
			if(!isalive(self))
			{
				break;
			}

			var_01 = get_tank_target_by_script_noteworthy(param_00);
			self.var_1234 = 0;
			wait 1;
		}

		wait randomfloatrange(0.05,0.5);
	}
}

//Function Number: 3
get_tank_target_by_script_noteworthy(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		var_02 = common_scripts\utility::random(var_01);
		if(isdefined(var_02) && !isspawner(var_02) && var_02.health > 0)
		{
			var_03 = var_02;
			self notify("new_target");
			return var_03;
		}
		else
		{
			return undefined;
		}
	}

	return undefined;
}

//Function Number: 4
func_1236(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_04 = getentarray(param_01,"script_noteworthy");
	var_05 = [];
	var_06 = 0;
	var_07 = [];
	foreach(var_09 in var_04)
	{
		if(isspawner(var_09))
		{
			var_05[var_05.size] = var_09;
		}
	}

	var_0B = common_scripts\utility::getstruct(param_00,"targetname");
	var_0C = 0;
	foreach(var_0E in var_05)
	{
		var_0F = var_0E maps\_utility::spawn_ai(1);
		if(param_02)
		{
			var_0F thread maps\_utility::replace_on_death();
		}

		var_0F forceteleport(var_0B.origin,var_0B.angles);
		var_0F setgoalpos(var_0F.origin);
		var_07 = maps\_utility::array_add(var_07,var_0F);
		var_0C++;
		if(isdefined(param_03) && var_0C >= param_03)
		{
			return var_07;
		}
	}

	return var_07;
}

//Function Number: 5
setupplayerforanimations()
{
	if(level.player isthrowinggrenade())
	{
		wait 1.2;
	}

	level.player allowmelee(0);
	level.player disableoffhandweapons();
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	if(level.player getstance() != "stand")
	{
		level.player setstance("stand");
		wait 0.4;
	}
}

//Function Number: 6
func_1239()
{
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player enableoffhandweapons();
	level.player allowmelee(1);
}

//Function Number: 7
forceplayerweapon_start(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	level.old_force_weapon = level.player getcurrentweapon();
	level.player giveweapon(level.force_weapon);
	level.player givemaxammo(level.force_weapon);
	level.player switchtoweaponimmediate(level.force_weapon);
	if(param_00)
	{
		level.player enableweapons();
	}

	level.player disableweaponswitch();
}

//Function Number: 8
forceplayerweapon_end(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	level.player takeweapon(level.force_weapon);
	if(isdefined(level.old_force_weapon))
	{
		level.player switchtoweapon(level.old_force_weapon);
	}

	if(param_00)
	{
		level.player enableweapons();
		level.player enableweaponswitch();
	}

	level.old_force_weapon = undefined;
}

//Function Number: 9
func_123E()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.sniper_zoom_hint_hud))
		{
			var_01.sniper_zoom_hint_hud = var_01 maps\_hud_util::createclientfontstring("default",1.75);
			var_01.sniper_zoom_hint_hud.horzalign = "center";
			var_01.sniper_zoom_hint_hud.vertalign = "top";
			var_01.sniper_zoom_hint_hud.alignx = "center";
			var_01.sniper_zoom_hint_hud.aligny = "top";
			var_01.sniper_zoom_hint_hud.x = 0;
			var_01.sniper_zoom_hint_hud.y = 20;
			var_01.sniper_zoom_hint_hud settext(&"VARIABLE_SCOPE_SNIPER_ZOOM");
			var_01.sniper_zoom_hint_hud.alpha = 0;
			var_01.sniper_zoom_hint_hud.sort = 0.5;
			var_01.sniper_zoom_hint_hud.foreground = 1;
		}

		var_01.var_1241 = 1;
	}

	var_03 = 0;
	level.players[0].sniper_dvar = "cg_playerFovScale0";
	if(level.players.size == 2)
	{
		level.players[1].sniper_dvar = "cg_playerFovScale1";
	}

	foreach(var_01 in level.players)
	{
		var_01 thread func_1248();
		var_01 thread func_1249();
	}

	if(!isdefined(level.variable_scope_weapons))
	{
		level.variable_scope_weapons = [];
	}

	var_06 = undefined;
	var_07 = undefined;
	for(;;)
	{
		var_08 = 0;
		var_07 = var_06;
		var_06 = undefined;
		foreach(var_0A in level.variable_scope_weapons)
		{
			foreach(var_01 in level.players)
			{
				if(var_01 getcurrentweapon() == var_0A && isalive(var_01))
				{
					var_08 = 1;
					var_06 = var_01;
					break;
				}
			}

			if(var_08)
			{
				break;
			}
		}

		if(var_08 && !var_06 isreloading() && !var_06 isswitchingweapon())
		{
			if(var_06 maps\_utility::isads() && var_06 adsbuttonpressed())
			{
				var_06 turnonvariablescopehud(var_03);
				var_03 = 1;
				if(isdefined(level.variable_scope_shadow_center))
				{
					var_0E = undefined;
					var_0F = undefined;
					var_10 = anglestoforward(var_06 getplayerangles());
					var_11 = var_06.origin;
					foreach(var_13 in level.variable_scope_shadow_center)
					{
						var_14 = anglestoforward(vectortoangles(var_13 - var_11));
						var_15 = vectordot(var_10,var_14);
						if(!isdefined(var_0E) || var_15 > var_0F)
						{
							var_0E = var_13;
							var_0F = var_15;
						}
					}

					if(isdefined(var_0E))
					{
						setsaveddvar("sm_sunShadowCenter",var_0E);
					}
				}
			}
			else if(var_03)
			{
				var_03 = 0;
				if(isdefined(var_06))
				{
					var_06 turnoffvariablescopehud();
				}

				setsaveddvar("sm_sunShadowCenter","0 0 0");
			}
		}
		else if(var_03)
		{
			var_03 = 0;
			if(isdefined(var_07))
			{
				var_07 turnoffvariablescopehud();
			}

			setsaveddvar("sm_sunShadowCenter","0 0 0");
		}

		wait 0.05;
	}
}

//Function Number: 10
turnonvariablescopehud(param_00)
{
	self disableoffhandweapons();
	setsaveddvar(self.sniper_dvar,self.var_1241);
	self.sniper_zoom_hint_hud.alpha = 1;
	if(!param_00)
	{
		level notify("variable_sniper_hud_enter");
	}
}

//Function Number: 11
turnoffvariablescopehud()
{
	level notify("variable_sniper_hud_exit");
	self enableoffhandweapons();
	setsaveddvar(self.sniper_dvar,1);
	self.sniper_zoom_hint_hud.alpha = 0;
}

//Function Number: 12
func_1248()
{
	notifyoncommand("mag_cycle","+melee_zoom");
	notifyoncommand("mag_cycle","+sprint_zoom");
	for(;;)
	{
		self waittill("mag_cycle");
		if(self.sniper_zoom_hint_hud.alpha)
		{
			if(self.var_1241 == 0.5)
			{
				self.var_1241 = 1;
				continue;
			}

			self.var_1241 = 0.5;
		}
	}
}

//Function Number: 13
func_1249()
{
	self waittill("death");
	turnoffvariablescopehud();
}

//Function Number: 14
convert_fov_string(param_00)
{
	if(param_00 == 0.5)
	{
		return 10;
	}

	if(param_00 == 1)
	{
		return 5;
	}

	return 5;
}

//Function Number: 15
worldtolocalcoords(param_00)
{
	var_01 = param_00 - self.origin;
	return (vectordot(var_01,anglestoforward(self.angles)),-1 * vectordot(var_01,anglestoright(self.angles)),vectordot(var_01,anglestoup(self.angles)));
}

//Function Number: 16
func_124C(param_00,param_01)
{
	return (param_00[1] * param_01[2] - param_00[2] * param_01[1],param_00[2] * param_01[0] - param_00[0] * param_01[2],param_00[0] * param_01[1] - param_00[1] * param_01[0]);
}

//Function Number: 17
createdebugtexthud(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 2;
	if(isdefined(param_05))
	{
		var_06 = param_05;
	}

	var_07 = level.player maps\_hud_util::createclientfontstring("default",var_06);
	var_07.x = param_01;
	var_07.y = param_02;
	var_07.sort = 1;
	var_07.horzalign = "fullscreen";
	var_07.vertalign = "fullscreen";
	var_07.alpha = 1;
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	var_07.color = param_03;
	if(isdefined(param_04))
	{
		var_07.label = param_04;
	}

	level.debug_text_hud[param_00] = var_07;
}

//Function Number: 18
printdebugtexthud(param_00,param_01)
{
	level.debug_text_hud[param_00] setvalue(param_01);
}

//Function Number: 19
printdebugtextstringhud(param_00,param_01)
{
	level.debug_text_hud[param_00] settext(param_01);
}

//Function Number: 20
func_1251(param_00,param_01)
{
	level.debug_text_hud[param_00].color = param_01;
}

//Function Number: 21
func_1252(param_00)
{
	level.debug_text_hud[param_00] destroy();
	level.debug_text_hud[param_00] = undefined;
}

//Function Number: 22
dialogue_reminder(param_00,param_01,param_02,param_03,param_04)
{
	level endon("stop_reminders");
	level endon("missionfailed");
	var_05 = undefined;
	if(!isdefined(param_03))
	{
		param_03 = 10;
	}

	if(!isdefined(param_04))
	{
		param_04 = 20;
	}

	while(!common_scripts\utility::flag(param_01))
	{
		var_06 = randomfloatrange(param_03,param_04);
		var_07 = common_scripts\utility::random(param_02);
		if(isdefined(var_05) && var_07 == var_05)
		{
			continue;
		}
		else
		{
			var_05 = var_07;
			wait var_06;
			if(!common_scripts\utility::flag(param_01))
			{
				if(isstring(param_00) && param_00 == "radio")
				{
					conversation_start();
					maps\_utility::func_DDF(var_07);
					conversation_stop();
					continue;
				}

				conversation_start();
				param_00 maps\_utility::dialogue_queue(var_07);
				conversation_stop();
			}
		}
	}
}

//Function Number: 23
conversation_start()
{
	if(!common_scripts\utility::flag_exist("flag_conversation_in_progress"))
	{
		common_scripts\utility::flag_init("flag_conversation_in_progress");
	}

	common_scripts\utility::flag_waitopen("flag_conversation_in_progress");
	common_scripts\utility::flag_set("flag_conversation_in_progress");
}

//Function Number: 24
conversation_stop()
{
	common_scripts\utility::flag_clear("flag_conversation_in_progress");
}

//Function Number: 25
array_find(param_00,param_01)
{
	foreach(var_04, var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 26
array_combine_unique(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(array_find(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in param_01)
	{
		if(!isdefined(array_find(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 27
func_1259(param_00)
{
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_flag) && common_scripts\utility::string_starts_with(var_03.script_flag,param_00))
		{
			var_03.script_specialops = 1;
		}
	}
}

//Function Number: 28
so_mark_class(param_00)
{
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.classname) && var_03.classname == param_00)
		{
			var_03.script_specialops = 1;
		}
	}
}

//Function Number: 29
laser_targeting_device(param_00)
{
	param_00 endon("remove_laser_targeting_device");
	param_00.var_125E = undefined;
	param_00.laserforceon = 0;
	param_00 setweaponhudiconoverride("actionslot4","dpad_laser_designator");
	param_00 thread cleanuplasertargetingdevice();
	param_00 notifyonplayercommand("use_laser","+actionslot 4");
	param_00 notifyonplayercommand("fired_laser","+attack");
	param_00 notifyonplayercommand("fired_laser","+attack_akimbo_accessible");
	param_00.laserallowed = 1;
	param_00.lasercooldownafterhit = 20;
	param_00 childthread monitorlaseroff();
	for(;;)
	{
		param_00 waittill("use_laser");
		if(param_00.laserforceon || !param_00.laserallowed || param_00 shouldforcedisablelaser())
		{
			param_00 notify("cancel_laser");
			param_00 laserforceoff();
			param_00.laserforceon = 0;
			param_00 allowads(1);
			wait 0.2;
			param_00 allowfire(1);
			continue;
		}

		param_00 laserforceon();
		param_00 allowfire(0);
		param_00.laserforceon = 1;
		param_00 allowads(0);
		param_00 thread laser_designate_target();
	}
}

//Function Number: 30
shouldforcedisablelaser()
{
	var_00 = self getcurrentweapon();
	if(var_00 == "rpg")
	{
		return 1;
	}

	if(common_scripts\utility::string_starts_with(var_00,"gl"))
	{
		return 1;
	}

	if(isdefined(level.laser_designator_disable_list) && isarray(level.laser_designator_disable_list))
	{
		foreach(var_02 in level.laser_designator_disable_list)
		{
			if(var_00 == var_02)
			{
				return 1;
			}
		}
	}

	if(self isreloading())
	{
		return 1;
	}

	if(self isthrowinggrenade())
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
cleanuplasertargetingdevice()
{
	self waittill("remove_laser_targeting_device");
	self setweaponhudiconoverride("actionslot4","none");
	self notify("cancel_laser");
	self laserforceoff();
	self.laserforceon = undefined;
	self allowfire(1);
	self allowads(1);
}

//Function Number: 32
monitorlaseroff()
{
	for(;;)
	{
		if(shouldforcedisablelaser() && isdefined(self.laserforceon) && self.laserforceon)
		{
			self notify("use_laser");
			wait 2;
		}

		wait 0.05;
	}
}

//Function Number: 33
laser_designate_target()
{
	self endon("cancel_laser");
	for(;;)
	{
		self waittill("fired_laser");
		var_00 = func_126A();
		var_01 = var_00["position"];
		var_02 = var_00["entity"];
		level notify("laser_coordinates_received");
		var_03 = undefined;
		if(isdefined(level.laser_targets) && isdefined(var_02) && maps\_utility::func_6E9(level.laser_targets,var_02))
		{
			var_03 = var_02;
			level.laser_targets = common_scripts\utility::array_remove(level.laser_targets,var_02);
		}
		else
		{
			var_03 = gettargettriggerhit(var_01);
		}

		if(isdefined(var_03))
		{
			thread laser_artillery(var_03);
			level notify("laser_target_painted");
			wait 0.5;
			self notify("use_laser");
		}
	}
}

//Function Number: 34
gettargettriggerhit(param_00)
{
	if(!isdefined(level.laser_triggers) || level.laser_triggers.size == 0)
	{
		return undefined;
	}

	foreach(var_02 in level.laser_triggers)
	{
		var_03 = distance2d(param_00,var_02.origin);
		var_04 = param_00[2] - var_02.origin[2];
		if(!isdefined(var_02.radius))
		{
			continue;
		}

		if(!isdefined(var_02.height))
		{
			continue;
		}

		if(var_03 <= var_02.radius && var_04 <= var_02.height && var_04 >= 0)
		{
			level.laser_triggers = common_scripts\utility::array_remove(level.laser_triggers,var_02);
			return getent(var_02.target,"script_noteworthy");
		}
	}

	return undefined;
}

//Function Number: 35
func_126A()
{
	var_00 = self geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 7000;
	var_04 = bullettrace(var_00,var_03,1,self);
	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		var_04["position"] = var_05.origin;
	}

	return var_04;
}

//Function Number: 36
laser_artillery(param_00)
{
	level.player endon("remove_laser_targeting_device");
	level.player.laserallowed = 0;
	self setweaponhudiconoverride("actionslot4","dpad_killstreak_hellfire_missile_inactive");
	maps\_utility::flavorbursts_off("allies");
	var_01 = level.player;
	wait 2.5;
	if(!isdefined(param_00.script_index))
	{
		param_00.script_index = 99;
	}

	wait 1;
	if(isdefined(param_00.script_group))
	{
		var_02 = get_geo_group("geo_before",param_00.script_group);
		if(var_02.size > 0)
		{
			common_scripts\utility::array_call(var_02,::hide);
		}

		var_03 = get_geo_group("geo_after",param_00.script_group);
		if(var_03.size > 0)
		{
			common_scripts\utility::array_call(var_03,::show);
		}
	}

	wait level.player.lasercooldownafterhit;
	level.player.laserallowed = 1;
	self setweaponhudiconoverride("actionslot4","dpad_laser_designator");
}

//Function Number: 37
get_geo_group(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.script_group) && var_05.script_group == param_01)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 38
func_1270(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(self.inuse) || self.inuse == 0)
	{
		self.inuse = 1;
	}
	else
	{
		wait 0.05;
		return 0;
	}

	var_08 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	var_09 = 57;
	var_0A = maps\_hud_util::createclientprogressbar(param_00,var_09);
	param_00 playerlinkto(self);
	param_00 playerlinkedoffsetenable();
	param_00 disableweapons();
	param_00 disableoffhandweapons();
	param_00 allowmelee(0);
	var_0B = undefined;
	if(isdefined(param_03))
	{
		var_0B = param_00 maps\_hud_util::createclientfontstring("default",1.2);
		var_0B maps\_hud_util::setpoint("CENTER",undefined,0,45);
		var_0B settext(param_03);
	}

	var_0C = 0;
	while(param_00 usebuttonpressed())
	{
		var_0A maps\_hud_util::updatebar(var_08 / param_02);
		wait 0.05;
		var_08 = var_08 + 0.05;
		if(var_08 > param_02)
		{
			if(isdefined(param_04))
			{
				thread func_1275(param_00,param_04);
			}

			if(isdefined(param_01))
			{
				[[ param_01 ]]();
			}

			var_0C = 1;
			break;
		}

		if(param_00.laststand == 1)
		{
			break;
		}

		if(isdefined(param_07) && common_scripts\utility::flag(param_07))
		{
			break;
		}

		if(common_scripts\utility::flag("missionfailed"))
		{
			break;
		}
	}

	if(!var_0C)
	{
		if(isdefined(param_06))
		{
			thread progress_bar_hud_failure(param_00,param_06);
		}

		if(isdefined(param_05))
		{
			[[ param_05 ]]();
		}
	}

	param_00 allowmelee(1);
	param_00 enableoffhandweapons();
	if(!isdefined(param_07) && param_07 == "dog_attack" && common_scripts\utility::flag("dog_attack"))
	{
		param_00 enableweapons();
		param_00 unlink();
	}

	self.inuse = 0;
	if(isdefined(var_0B))
	{
		var_0B maps\_hud_util::destroyelem();
	}

	var_0A maps\_hud_util::destroyelem();
	return var_0C;
}

//Function Number: 39
func_1272(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		self playsound(param_03,"sound_played",1);
	}

	var_04 = newclienthudelem(param_00);
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "center";
	var_04.vertalign = "middle";
	var_04.font = "hudsmall";
	var_04.foreground = 1;
	var_04.hidewheninmenu = 1;
	var_04.hidewhendead = 1;
	var_04.sort = 2;
	var_04.label = param_01;
	var_04 [[ param_02 ]]();
	var_04 thread hud_blink();
	wait 2;
	var_04 notify("stop_blink");
	wait 0.05;
	var_04 destroy();
}

//Function Number: 40
progress_bar_hud_failure(param_00,param_01)
{
	func_1272(param_00,param_01,::maps\_specialops::set_hud_red,"so_sample_not_collected");
}

//Function Number: 41
func_1275(param_00,param_01)
{
	func_1272(param_00,param_01,::maps\_specialops::set_hud_green,"arcademode_2x");
}

//Function Number: 42
hud_blink(param_00)
{
	self endon("stop_blink");
	self endon("death");
	var_01 = 0.1;
	var_02 = 0.5;
	for(;;)
	{
		self fadeovertime(var_01);
		self.alpha = 1;
		wait var_02;
		self fadeovertime(var_01);
		self.alpha = 0;
		wait var_02;
	}
}

//Function Number: 43
func_1278()
{
	var_00 = getentarray("shg_vision_multiple_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread vision_change_multiple_internal();
	}
}

//Function Number: 44
vision_change_multiple_internal()
{
	var_00 = common_scripts\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_03 = vectornormalize(self.origin - var_02.origin);
		var_02.forward_for_vision_change = var_03;
	}

	for(;;)
	{
		self waittill("trigger",var_05);
		if(isplayer(var_05))
		{
			var_06 = anglestoforward(var_05 getplayerangles());
			var_07 = undefined;
			var_08 = 0;
			foreach(var_02 in var_00)
			{
				var_0A = vectordot(var_06,var_02.forward_for_vision_change);
				if(!isdefined(var_07) || var_0A < var_08)
				{
					var_07 = var_02;
					var_08 = var_0A;
				}
			}

			var_0C = 1;
			if(isdefined(var_07.script_duration))
			{
				var_0C = var_07.script_duration;
			}

			var_07 maps\_lights::set_sun_shadow_params(var_0C);
			wait var_0C;
		}
	}
}

//Function Number: 45
change_character_model(param_00)
{
	self setmodel(param_00);
	update_weapon_tag_visibility(self.weapon);
}

//Function Number: 46
update_weapon_tag_visibility(param_00,param_01)
{
	if(isdefined(param_00) && param_00 != "none")
	{
		var_02 = getweaponhidetags(param_00);
		var_03 = 0;
		var_04 = getweaponmodel(param_00,var_03);
		if(isdefined(param_01))
		{
			var_04 = param_01;
		}

		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			self hidepart(var_02[var_05],var_04);
		}
	}
}

//Function Number: 47
func_127D(param_00,param_01,param_02)
{
	if(issplitscreen())
	{
		if(self == level.player)
		{
			param_00 = param_00 + 2;
		}

		param_00 = param_00 / 2;
	}

	return maps\_specialops::func_127E(param_00,param_01,param_02,self);
}

//Function Number: 48
func_127F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.var_1280 = "award_positive";
	level.bonus_2_shader = "award_positive";
	level.challenge_1 = get_challenge_values(param_00,param_01,param_02);
	level.challenge_2 = get_challenge_values(param_03,param_04,param_05);
	common_scripts\utility::array_thread(level.players,::require_defined_bonuses);
	level.custom_eog_no_defaults = 1;
	level.eog_summary_callback = ::custom_eog_summary;
	handle_bonus_xp();
}

//Function Number: 49
get_challenge_values(param_00,param_01,param_02)
{
	var_03 = [];
	if(isdefined(param_00))
	{
	}
	else
	{
		var_41["max_successes"] = undefined;
	}

	return var_41;
}

//Function Number: 50
require_defined_bonuses()
{
	if(!isdefined(self.bonus_1))
	{
		self.bonus_1 = 0;
	}

	if(!isdefined(self.bonus_2))
	{
		self.bonus_2 = 0;
	}
}

//Function Number: 51
custom_eog_summary()
{
	if(issplitscreen())
	{
		setdvar("ui_hide_hint",1);
	}

	if(!level.var_1291)
	{
		setdvar("ui_hide_hint",1);
	}

	level.challenge_time_limit = func_1292();
	level.session_score = 0;
	foreach(var_01 in level.players)
	{
		var_01.final_summary = get_final_summary(var_01);
		level.session_score = level.session_score + var_01.final_summary["kill_score"];
		level.session_score = level.session_score + var_01.final_summary["challenge_1"];
		level.session_score = level.session_score + var_01.final_summary["challenge_2"];
	}

	level.session_score = level.session_score + level.players[0].final_summary["gameskill_score"];
	level.session_score = level.session_score + level.players[0].final_summary["time_score"];
	level.session_score = int(level.session_score);
	foreach(var_01 in level.players)
	{
		var_01 maps\_specialops::override_summary_score(level.session_score);
		if(maps\_utility::func_E89())
		{
			var_04 = maps\_utility::get_other_player(var_01);
			var_01 maps\_utility::func_128F("","@SPECIAL_OPS_PERFORMANCE_YOU","@SPECIAL_OPS_PERFORMANCE_PARTNER");
			var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_DIFFICULTY",var_01.final_summary["difficulty"],var_04.final_summary["difficulty"]);
			var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_KILLS",var_01.final_summary["kills_num"],var_04.final_summary["kills_num"]);
			var_01 maps\_utility::func_128F(level.challenge_1["description"],var_01.final_summary["ch_1_tally"],var_04.final_summary["ch_1_tally"]);
			if(level.challenge_2["value"] > 0)
			{
				var_01 maps\_utility::func_128F(level.challenge_2["description"],var_01.final_summary["ch_2_tally"],var_04.final_summary["ch_2_tally"]);
			}

			var_01 maps\_utility::func_128F(var_01.final_summary["t_message"],"",var_04.final_summary["time_string"]);
			if(level.challenge_2["value"] <= 0 || !issplitscreen())
			{
				var_01 maps\_utility::add_custom_eog_summary_line_blank();
			}

			if(!level.var_1291)
			{
				var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_SCORE","",level.session_score);
			}

			continue;
		}

		if(!level.var_1291)
		{
			var_01 maps\_utility::func_128F("","","@SPECIAL_OPS_POINTS");
			var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_DIFFICULTY",var_01.final_summary["difficulty"],var_01.final_summary["gameskill_score"]);
			var_01 maps\_utility::func_128F(var_01.final_summary["t_message"],var_01.final_summary["time_string"],var_01.final_summary["time_score"]);
			var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_KILLS",var_01.final_summary["kills_num"],var_01.final_summary["kill_score"]);
			var_01 maps\_utility::func_128F(level.challenge_1["description"],var_01.final_summary["ch_1_tally"],var_01.final_summary["challenge_1"]);
			if(level.challenge_2["value"] > 0)
			{
				var_01 maps\_utility::func_128F(level.challenge_2["description"],var_01.final_summary["ch_2_tally"],var_01.final_summary["challenge_2"]);
			}

			if(level.challenge_2["value"] <= 0 || !issplitscreen())
			{
				var_01 maps\_utility::add_custom_eog_summary_line_blank();
			}

			var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_SCORE","               ",level.session_score);
			continue;
		}

		var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_DIFFICULTY","",var_01.final_summary["difficulty"]);
		var_01 maps\_utility::func_128F(var_01.final_summary["t_message"],"",var_01.final_summary["time_string"]);
		var_01 maps\_utility::func_128F("@SPECIAL_OPS_UI_KILLS","",var_01.final_summary["kills_num"]);
		var_01 maps\_utility::func_128F(level.challenge_1["description"],"",var_01.final_summary["ch_1_tally"]);
		if(level.challenge_2["value"] > 0)
		{
			var_01 maps\_utility::func_128F(level.challenge_2["description"],"",var_01.final_summary["ch_2_tally"]);
		}
	}
}

//Function Number: 52
func_1292()
{
	if(!isdefined(level.so_mission_worst_time))
	{
		level.so_mission_worst_time = 420000;
	}

	if(!isdefined(level.so_mission_min_time))
	{
		level.so_mission_min_time = 0;
	}

	if(!isdefined(level.challenge_time_limit))
	{
		level.timed_mission = 0;
		level.challenge_time_limit = level.so_mission_worst_time;
	}
	else
	{
		level.timed_mission = 1;
	}

	level.var_3F17 = level.so_mission_worst_time - level.so_mission_min_time;
	return level.challenge_time_limit;
}

//Function Number: 53
get_final_summary(param_00,param_01,param_02)
{
	param_00.final_summary = [];
	param_00.final_summary["final_score"] = 0;
	param_00.final_summary["level_time"] = level.challenge_end_time - level.challenge_start_time;
	if(level.challenge_time_limit > param_00.final_summary["level_time"])
	{
		param_00.final_summary["t_message"] = get_time_message("bonus");
		param_00.final_summary["remaining_time"] = int(level.challenge_time_limit - param_00.final_summary["level_time"]);
		if(!level.var_1291)
		{
		}

		if(!level.timed_mission)
		{
			if(level.so_mission_min_time <= param_00.final_summary["level_time"])
			{
				param_00.final_summary["time_percent"] = max(level.var_3F17 - param_00.final_summary["level_time"] - level.so_mission_min_time / level.var_3F17,0);
			}
			else
			{
				param_00.final_summary["time_percent"] = 1;
			}
		}
		else if(level.so_mission_min_time >= param_00.final_summary["remaining_time"])
		{
			param_00.final_summary["time_percent"] = max(param_00.final_summary["remaining_time"] / level.var_3F17,0);
		}
		else
		{
			param_00.final_summary["time_percent"] = 1;
		}

		param_00.final_summary["time_score"] = int(param_00.final_summary["time_percent"] * 5000);
		if(level.timed_mission)
		{
			param_00.final_summary["time_string"] = maps\_utility::convert_to_time_string(param_00.final_summary["remaining_time"] * 0.001,1);
		}
		else
		{
			param_00.final_summary["time_string"] = maps\_utility::convert_to_time_string(param_00.final_summary["level_time"] * 0.001,1);
		}

		param_00.final_summary["final_score"] = param_00.final_summary["final_score"] + param_00.final_summary["time_score"];
	}
	else
	{
		param_00.final_summary["t_message"] = get_time_message("no_bonus");
		param_00.final_summary["time_string"] = maps\_utility::convert_to_time_string(param_00.final_summary["level_time"] * 0.001,1);
		param_00.final_summary["time_score"] = 0;
	}

	param_00.final_summary["gameskill_low"] = level.specops_reward_gameskill;
	param_00.final_summary["gameskill_score"] = max(10000 * param_00.final_summary["gameskill_low"],0);
	param_00.final_summary["final_score"] = param_00.final_summary["final_score"] + param_00.final_summary["gameskill_score"];
	if(isdefined(level.challenge_1["max_successes"]))
	{
		param_00.final_summary["challenge_1"] = min(level.challenge_1["value"] * param_00.bonus_1,level.challenge_1["value"] * level.challenge_1["max_successes"]);
	}
	else
	{
		param_00.final_summary["challenge_1"] = level.challenge_1["value"] * param_00.bonus_1;
	}

	if(isdefined(level.challenge_2["max_successes"]))
	{
		param_00.final_summary["challenge_2"] = min(level.challenge_2["value"] * param_00.bonus_2,level.challenge_2["value"] * level.challenge_2["max_successes"]);
	}
	else
	{
		param_00.final_summary["challenge_2"] = level.challenge_2["value"] * param_00.bonus_2;
	}

	param_00.final_summary["final_score"] = param_00.final_summary["final_score"] + param_00.final_summary["challenge_1"] + param_00.final_summary["challenge_2"];
	param_00.final_summary["ch_1_tally"] = get_tally_string(param_00.bonus_1,level.challenge_1["max_successes"]);
	param_00.final_summary["ch_2_tally"] = get_tally_string(param_00.bonus_2,level.challenge_2["max_successes"]);
	param_00.final_summary["kills_num"] = param_00.stats["kills"];
	param_00.final_summary["kill_score"] = min(param_00.stats["kills"] * 25,2500);
	param_00.final_summary["final_score"] = param_00.final_summary["final_score"] + param_00.final_summary["kill_score"];
	param_00.final_summary["final_score"] = func_12A8(param_00,param_00.final_summary["final_score"],param_00.final_summary["gameskill_score"]);
	param_00.final_summary["difficulty"] = maps\_specialops::so_get_difficulty_menu_string(param_00.gameskill);
	return param_00.final_summary;
}

//Function Number: 54
get_tally_string(param_00,param_01)
{
	if(!isdefined(param_01) && param_00 > 0)
	{
		return param_00;
	}

	if(!isdefined(param_01) && param_00 == 0)
	{
		return "@SPECIAL_OPS_UI_CHALLENGE_FAIL";
	}

	if(isdefined(param_01) && param_01 == 1 && param_00 >= 1)
	{
		return "@SPECIAL_OPS_UI_CHALLENGE_COMPLETE";
	}

	if(isdefined(param_01) && param_00 == 0)
	{
		return "@SPECIAL_OPS_UI_CHALLENGE_FAIL";
	}

	if(isdefined(param_01) && param_00 > param_01)
	{
		param_00 = param_01;
	}

	if(maps\_utility::func_E89())
	{
		return param_00;
	}

	return param_00 + " / " + param_01;
}

//Function Number: 55
get_time_message(param_00)
{
	if(param_00 == "bonus")
	{
		return "@SPECIAL_OPS_UI_TIME";
	}

	if(param_00 == "no_bonus")
	{
		return "@SPECIAL_OPS_UI_TIME";
	}
}

//Function Number: 56
handle_bonus_xp(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread give_xp_on_success(level.challenge_1["value"],level.challenge_2["value"]);
	}
}

//Function Number: 57
give_xp_on_success(param_00,param_01)
{
	self.ch_1 = func_12A3(1,level.challenge_1,level.var_1280,param_00,level.var_129F);
	self.var_12A2 = func_12A3(2,level.challenge_2,level.bonus_2_shader,param_01,level.var_12A1);
	thread func_12A7();
	thread bonus1_icon_text(self.ch_1);
	thread bonus2_icon_text(self.var_12A2);
	thread monitor_challenges();
}

//Function Number: 58
monitor_challenges(param_00)
{
	var_01 = self.bonus_1;
	var_02 = self.bonus_2;
	for(;;)
	{
		if(self.bonus_1 != var_01)
		{
			calculate_bonus(self.ch_1,var_01,1);
			var_01 = self.bonus_1;
		}

		if(self.bonus_2 != var_02)
		{
			calculate_bonus(self.var_12A2,var_02,2);
			var_02 = self.bonus_2;
		}

		wait 0.05;
	}
}

//Function Number: 59
func_12A3(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	return var_41;
}

//Function Number: 60
get_bonus_number(param_00)
{
	if(param_00 == 1)
	{
		return self.bonus_1;
	}

	if(param_00 == 2)
	{
		return self.bonus_2;
	}
}

//Function Number: 61
calculate_bonus(param_00,param_01,param_02)
{
	var_03 = get_bonus_number(param_02);
	if(isdefined(param_00["max"]) && var_03 < param_00["max"])
	{
		give_bonus(param_00,param_01,param_02);
		return;
	}

	if(!isdefined(param_00["max"]))
	{
		give_bonus(param_00,param_01,param_02);
	}
}

//Function Number: 62
give_bonus(param_00,param_01,param_02)
{
	var_03 = get_bonus_number(param_02);
	for(var_04 = 0;var_04 < var_03 - param_01;var_04++)
	{
		if(param_02 == 1)
		{
			self notify("bonus1_achieved");
		}
		else
		{
			self notify("bonus2_achieved");
		}

		self notify("bonus_achieved");
	}
}

//Function Number: 63
func_12A7()
{
	for(;;)
	{
		self waittill("bonus_achieved");
		thread common_scripts\utility::play_sound_in_space("arcademode_2x",self geteye());
		wait 0.5;
	}
}

//Function Number: 64
func_12A8(param_00,param_01,param_02)
{
	var_03 = param_02 + 29999;
	param_01 = int(min(param_01,var_03));
	return param_01;
}

//Function Number: 65
bonus1_icon_text(param_00)
{
	for(;;)
	{
		self waittill("bonus1_achieved");
		func_12AB(150,115,1,param_00);
	}
}

//Function Number: 66
bonus2_icon_text(param_00)
{
	for(;;)
	{
		self waittill("bonus2_achieved");
		func_12AB(170,135,2,param_00);
	}
}

//Function Number: 67
func_12AB(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03["text"]))
	{
		var_04["bar"] = make_bar_get_basic_placement(59,param_00,"right",0);
		var_04["bar"] move_bonus(18);
		var_05 = [];
		var_41["text"] settext(var_04["text"]);
		var_41["text"] thread flash_text();
		var_41["num"] thread flash_text();
		var_06 = get_bonus_number(param_03);
		for(var_07 = 0;var_07 < 90;var_07++ = var_41["num"])
		{
			var_08 = get_bonus_number(param_03);
			var_09 = get_tally_string(var_08,var_04["max"]);
			var_41["num"] settext(" " + var_09);
			if(var_06 != var_08)
			{
				var_06 = var_08;
				var_41["num"] thread flash_text();
			}

			wait 0.05;
		}

		if(isdefined(var_05["bar"]))
		{
			var_05["bar"] destroy();
		}

		if(isdefined(var_41["text"]))
		{
			var_41["text"] destroy();
		}

		if(isdefined(var_41["num"]))
		{
			var_41["num"] destroy();
		}
	}
}

//Function Number: 68
flash_text()
{
	for(var_00 = 0;var_00 < 2;var_00++)
	{
		if(isdefined(self))
		{
			self changefontscaleovertime(0.25);
			self.fontscale = 0.9;
			self.color = (0.65,1,0.65);
			wait 0.25;
		}

		if(isdefined(self))
		{
			self changefontscaleovertime(0.25);
			self.fontscale = 0.75;
			self.color = (1,1,1);
			wait 0.25;
		}
	}
}

//Function Number: 69
move_bonus(param_00)
{
	self scaleovertime(0.25,100,param_00);
	wait 0.25;
}

//Function Number: 70
make_bar_get_basic_placement(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04 = get_basic_placement(var_04,59,param_01,"right",0);
	var_04 setshader("hud_white_box",100,1);
	var_04.alpha = 0.5;
	var_04.color = (0.7,0.8,0.7);
	return var_04;
}

//Function Number: 71
make_text_get_basic_placement(param_00,param_01,param_02,param_03)
{
	var_04 = maps\_hud_util::createclientfontstring("hudsmall",0.75);
	var_04 = get_basic_placement(var_04,76,param_01,param_02,2);
	return var_04;
}

//Function Number: 72
get_basic_placement(param_00,param_01,param_02,param_03,param_04)
{
	param_00.x = param_01;
	param_00.y = param_02;
	param_00.alignx = param_03;
	param_00.aligny = "middle";
	param_00.foreground = 1;
	param_00.font = "hudsmall";
	param_00.hidewheninmenu = 1;
	param_00.hidewhendead = 1;
	param_00.sort = param_04;
	return param_00;
}

//Function Number: 73
multiple_dialogue_queue(param_00)
{
	maps\_utility::bcs_scripted_dialogue_start();
	if(isdefined(self.last_queue_time))
	{
		maps\_utility::wait_for_buffer_time_to_pass(self.last_queue_time,0.5);
	}

	var_01 = [];
	maps\_utility::func_E1D(::func_12B3,var_41,var_01);
	if(isalive(self))
	{
		self.last_queue_time = gettime();
	}
}

//Function Number: 74
func_12B3(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = [];
	foreach(var_07, var_06 in param_00)
	{
		var_04[var_07] = var_06[0];
	}

	foreach(var_09 in var_04)
	{
		if(!isdefined(var_09))
		{
			continue;
		}

		if(!isdefined(var_09._animactive))
		{
			var_09._animactive = 0;
		}

		var_09._animactive++;
	}

	var_0B = maps\_anim::get_anim_position(param_02);
	var_0C = var_0B["origin"];
	var_0D = var_0B["angles"];
	var_0E = "single anim";
	var_0F = spawnstruct();
	var_10 = 0;
	foreach(var_07, var_09 in var_04)
	{
		var_12 = 0;
		var_13 = 0;
		var_14 = 0;
		var_15 = 0;
		var_16 = undefined;
		var_17 = undefined;
		var_18 = var_09.animname;
		if(isdefined(level.scr_face[var_18]) && isdefined(level.scr_face[var_18][param_01]))
		{
			var_12 = 1;
			var_17 = level.scr_face[var_18][param_01];
		}

		if(isdefined(level.scr_sound[var_18]) && isdefined(level.scr_sound[var_18][param_01]))
		{
			var_13 = 1;
			var_16 = level.scr_sound[var_18][param_01];
		}

		if(isdefined(level.scr_anim[var_18]) && isdefined(level.scr_anim[var_18][param_01]) && !isai(var_09) || !var_09 maps\_utility::doinglongdeath())
		{
			var_14 = 1;
		}

		if(isdefined(level.scr_animsound[var_18]) && isdefined(level.scr_animsound[var_18][param_01]))
		{
			var_09 playsound(level.scr_animsound[var_18][param_01]);
		}

		if(var_14)
		{
			var_09 maps\_anim::last_anim_time_check();
			if(isplayer(var_09))
			{
				var_19 = level.scr_anim[var_18]["root"];
				var_09 setanim(var_19,0,0.2);
				var_1A = level.scr_anim[var_18][param_01];
				var_09 setflaggedanim(var_0E,var_1A,1,0.2);
			}
			else if(var_09.code_classname == "misc_turret")
			{
				var_1A = level.scr_anim[var_18][param_01];
				var_09 setflaggedanim(var_0E,var_1A,1,0.2);
			}
			else
			{
				var_09 animscripted(var_0E,var_0C,var_0D,level.scr_anim[var_18][param_01]);
			}

			thread maps\_anim::start_notetrack_wait(var_09,var_0E,param_01,var_18);
			thread maps\_anim::animscriptdonotetracksthread(var_09,var_0E,param_01);
		}

		if(var_12 || var_13)
		{
			if(var_12)
			{
				if(var_13)
				{
					var_09 thread func_12B8(param_01,var_12,var_16,level.scr_face[var_18][param_01]);
				}

				thread maps\_anim::func_E31(var_09,param_01,level.scr_face[var_18][param_01]);
			}
			else if(isai(var_09))
			{
				if(var_14)
				{
					var_09 animscripts/face::sayspecificdialogue(var_17,var_16,1);
				}
				else
				{
					var_09 thread maps\_anim::anim_facialfiller("single dialogue");
					var_09 animscripts/face::sayspecificdialogue(var_17,var_16,1,"single dialogue");
				}
			}
			else
			{
				var_09 thread maps\_utility::play_sound_on_entity(var_16,"single dialogue");
			}
		}

		if(var_14)
		{
			var_1B = getanimlength(level.scr_anim[var_18][param_01]);
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_animationendnotify(var_09,param_01,var_1B,param_00[var_07][1]);
			var_10++;
			continue;
		}

		if(var_12)
		{
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_facialendnotify(var_09,param_01,var_17);
			var_10++;
			continue;
		}

		if(var_13)
		{
			var_0F thread anim_end_early_deathnotify(var_09,param_01);
			var_0F thread anim_end_early_dialogueendnotify(var_09,param_01);
			var_10++;
		}
	}

	while(var_10 > 0)
	{
		var_0F waittill(param_01,var_09);
		var_10--;
		if(!isdefined(var_09))
		{
			continue;
		}

		if(isplayer(var_09))
		{
			var_18 = var_09.animname;
			if(isdefined(level.scr_anim[var_18][param_01]))
			{
				var_19 = level.scr_anim[var_18]["root"];
				var_09 setanim(var_19,1,0.2);
				var_1A = level.scr_anim[var_18][param_01];
				var_09 clearanim(var_1A,0.2);
			}
		}

		var_09._animactive--;
		var_09._lastanimtime = gettime();
	}

	self notify(param_01);
}

//Function Number: 75
anim_end_early_deathnotify(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("death");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 76
anim_end_early_facialendnotify(param_00,param_01,param_02)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	var_03 = getanimlength(param_02);
	wait var_03;
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 77
anim_end_early_dialogueendnotify(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("single dialogue");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 78
anim_end_early_animationendnotify(param_00,param_01,param_02,param_03)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_02 = param_02 - param_03;
	if(param_03 > 0 && param_02 > 0)
	{
		param_00 maps\_utility::waittill_match_or_timeout("single anim","end",param_02);
		param_00 stopanimscripted();
	}
	else
	{
		param_00 waittillmatch("end","single anim");
	}

	param_00 notify("anim_ended");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 79
func_12B8(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		thread func_12B9(param_00);
		thread warn_facial_dialogue_unspoken(param_00);
		thread warn_facial_dialogue_too_many(param_00);
		var_04 = [];
		if(!isarray(param_02))
		{
		}
		else
		{
			var_41 = param_03;
		}

		foreach(var_06 in var_41)
		{
			self waittillmatch(param_02,var_41[0],"dialogue_line","face_done_" + param_01);
			animscripts/face::sayspecificdialogue(undefined,var_06,1);
		}

		self notify("all_facial_lines_done");
		return;
	}

	animscripts/face::sayspecificdialogue(undefined,param_03,1,"single dialogue");
}

//Function Number: 80
func_12B9(param_00)
{
	self endon("death");
	self waittillmatch("end","face_done_" + param_00);
	self notify("facial_anim_end_" + param_00);
}

//Function Number: 81
warn_facial_dialogue_unspoken(param_00)
{
	self endon("death");
	self endon("all_facial_lines_done");
	self waittill("facial_anim_end_" + param_00);
}

//Function Number: 82
warn_facial_dialogue_too_many(param_00)
{
	self endon("death");
	self endon("facial_anim_end_" + param_00);
	self waittill("all_facial_lines_done");
	self waittillmatch("dialogue_line","face_done_" + param_00);
}