/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1442.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 80 ms
 * Timestamp: 10/27/2023 2:20:32 AM
*******************************************************************/

//Function Number: 1
func_166A(param_00)
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
func_166B(param_00)
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
				self.var_166C++;
				self fireweapon();
				if(self.var_166C >= 3)
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

			var_01 = func_166D(param_00);
			self.var_166C = 0;
			wait 1;
		}

		wait randomfloatrange(0.05,0.5);
	}
}

//Function Number: 3
func_166D(param_00)
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
func_166E(param_00,param_01,param_02,param_03)
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
func_1670()
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
func_1671()
{
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player enableoffhandweapons();
	level.player allowmelee(1);
}

//Function Number: 7
func_1672(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	level.var_1673 = level.player getcurrentweapon();
	level.player giveweapon(level.var_1674);
	level.player givemaxammo(level.var_1674);
	level.player switchtoweaponimmediate(level.var_1674);
	if(param_00)
	{
		level.player enableweapons();
	}

	level.player disableweaponswitch();
}

//Function Number: 8
func_1675(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	level.player takeweapon(level.var_1674);
	if(isdefined(level.var_1673))
	{
		level.player switchtoweapon(level.var_1673);
	}

	if(param_00)
	{
		level.player enableweapons();
		level.player enableweaponswitch();
	}

	level.var_1673 = undefined;
}

//Function Number: 9
func_1676()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.var_1678))
		{
			var_01.var_1678 = var_01 maps\_hud_util::createclientfontstring("default",1.75);
			var_01.var_1678.horzalign = "center";
			var_01.var_1678.vertalign = "top";
			var_01.var_1678.alignx = "center";
			var_01.var_1678.aligny = "top";
			var_01.var_1678.x = 0;
			var_01.var_1678.y = 20;
			var_01.var_1678 settext(&"VARIABLE_SCOPE_SNIPER_ZOOM");
			var_01.var_1678.alpha = 0;
			var_01.var_1678.sort = 0.5;
			var_01.var_1678.foreground = 1;
		}

		var_01.var_1679 = 1;
	}

	var_03 = 0;
	level.players[0].var_167A = "cg_playerFovScale0";
	if(level.players.size == 2)
	{
		level.players[1].var_167A = "cg_playerFovScale1";
	}

	foreach(var_01 in level.players)
	{
		var_01 thread func_1680();
		var_01 thread func_1681();
	}

	if(!isdefined(level.var_167B))
	{
		level.var_167B = [];
	}

	var_06 = undefined;
	var_07 = undefined;
	for(;;)
	{
		var_08 = 0;
		var_07 = var_06;
		var_06 = undefined;
		foreach(var_0A in level.var_167B)
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
				var_06 func_167E(var_03);
				var_03 = 1;
				if(isdefined(level.var_167D))
				{
					var_0E = undefined;
					var_0F = undefined;
					var_10 = anglestoforward(var_06 getplayerangles());
					var_11 = var_06.origin;
					foreach(var_13 in level.var_167D)
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
					var_06 func_167F();
				}

				setsaveddvar("sm_sunShadowCenter","0 0 0");
			}
		}
		else if(var_03)
		{
			var_03 = 0;
			if(isdefined(var_07))
			{
				var_07 func_167F();
			}

			setsaveddvar("sm_sunShadowCenter","0 0 0");
		}

		wait 0.05;
	}
}

//Function Number: 10
func_167E(param_00)
{
	self disableoffhandweapons();
	setsaveddvar(self.var_167A,self.var_1679);
	self.var_1678.alpha = 1;
	if(!param_00)
	{
		level notify("variable_sniper_hud_enter");
	}
}

//Function Number: 11
func_167F()
{
	level notify("variable_sniper_hud_exit");
	self enableoffhandweapons();
	setsaveddvar(self.var_167A,1);
	self.var_1678.alpha = 0;
}

//Function Number: 12
func_1680()
{
	notifyoncommand("mag_cycle","+melee_zoom");
	notifyoncommand("mag_cycle","+sprint_zoom");
	for(;;)
	{
		self waittill("mag_cycle");
		if(self.var_1678.alpha)
		{
			if(self.var_1679 == 0.5)
			{
				self.var_1679 = 1;
				continue;
			}

			self.var_1679 = 0.5;
		}
	}
}

//Function Number: 13
func_1681()
{
	self waittill("death");
	func_167F();
}

//Function Number: 14
func_1682(param_00)
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
func_1683(param_00)
{
	var_01 = param_00 - self.origin;
	return (vectordot(var_01,anglestoforward(self.angles)),-1 * vectordot(var_01,anglestoright(self.angles)),vectordot(var_01,anglestoup(self.angles)));
}

//Function Number: 16
func_1684(param_00,param_01)
{
	return (param_00[1] * param_01[2] - param_00[2] * param_01[1],param_00[2] * param_01[0] - param_00[0] * param_01[2],param_00[0] * param_01[1] - param_00[1] * param_01[0]);
}

//Function Number: 17
func_1685(param_00,param_01,param_02,param_03,param_04,param_05)
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

	level.var_1686[param_00] = var_07;
}

//Function Number: 18
func_1687(param_00,param_01)
{
	level.var_1686[param_00] setvalue(param_01);
}

//Function Number: 19
func_1688(param_00,param_01)
{
	level.var_1686[param_00] settext(param_01);
}

//Function Number: 20
func_1689(param_00,param_01)
{
	level.var_1686[param_00].color = param_01;
}

//Function Number: 21
func_168A(param_00)
{
	level.var_1686[param_00] destroy();
	level.var_1686[param_00] = undefined;
}

//Function Number: 22
func_168B(param_00,param_01,param_02,param_03,param_04)
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
					func_168D();
					maps\_utility::radio_dialogue(var_07);
					func_168E();
					continue;
				}

				func_168D();
				param_00 maps\_utility::dialogue_queue(var_07);
				func_168E();
			}
		}
	}
}

//Function Number: 23
func_168D()
{
	if(!common_scripts\utility::flag_exist("flag_conversation_in_progress"))
	{
		common_scripts\utility::flag_init("flag_conversation_in_progress");
	}

	common_scripts\utility::flag_waitopen("flag_conversation_in_progress");
	common_scripts\utility::flag_set("flag_conversation_in_progress");
}

//Function Number: 24
func_168E()
{
	common_scripts\utility::flag_clear("flag_conversation_in_progress");
}

//Function Number: 25
func_168F(param_00,param_01)
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
func_1690(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(func_168F(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in param_01)
	{
		if(!isdefined(func_168F(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 27
func_1691(param_00)
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
func_1694(param_00)
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
func_1695(param_00)
{
	param_00 endon("remove_laser_targeting_device");
	param_00.var_1696 = undefined;
	param_00.var_1697 = 0;
	param_00 setweaponhudiconoverride("actionslot4","dpad_laser_designator");
	param_00 thread func_169C();
	param_00 notifyonplayercommand("use_laser","+actionslot 4");
	param_00 notifyonplayercommand("fired_laser","+attack");
	param_00 notifyonplayercommand("fired_laser","+attack_akimbo_accessible");
	param_00.var_1698 = 1;
	param_00.var_1699 = 20;
	param_00 childthread func_169D();
	for(;;)
	{
		param_00 waittill("use_laser");
		if(param_00.var_1697 || !param_00.var_1698 || param_00 func_169A())
		{
			param_00 notify("cancel_laser");
			param_00 laserforceoff();
			param_00.var_1697 = 0;
			param_00 allowads(1);
			wait 0.2;
			param_00 allowfire(1);
			continue;
		}

		param_00 laserforceon();
		param_00 allowfire(0);
		param_00.var_1697 = 1;
		param_00 allowads(0);
		param_00 thread func_169E();
	}
}

//Function Number: 30
func_169A()
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

	if(isdefined(level.var_169B) && isarray(level.var_169B))
	{
		foreach(var_02 in level.var_169B)
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
func_169C()
{
	self waittill("remove_laser_targeting_device");
	self setweaponhudiconoverride("actionslot4","none");
	self notify("cancel_laser");
	self laserforceoff();
	self.var_1697 = undefined;
	self allowfire(1);
	self allowads(1);
}

//Function Number: 32
func_169D()
{
	for(;;)
	{
		if(func_169A() && isdefined(self.var_1697) && self.var_1697)
		{
			self notify("use_laser");
			wait 2;
		}

		wait 0.05;
	}
}

//Function Number: 33
func_169E()
{
	self endon("cancel_laser");
	for(;;)
	{
		self waittill("fired_laser");
		var_00 = func_16A2();
		var_01 = var_00["position"];
		var_02 = var_00["entity"];
		level notify("laser_coordinates_received");
		var_03 = undefined;
		if(isdefined(level.var_169F) && isdefined(var_02) && maps\_utility::array_contains(level.var_169F,var_02))
		{
			var_03 = var_02;
			level.var_169F = common_scripts\utility::array_remove(level.var_169F,var_02);
		}
		else
		{
			var_03 = func_16A0(var_01);
		}

		if(isdefined(var_03))
		{
			thread func_16A3(var_03);
			level notify("laser_target_painted");
			wait 0.5;
			self notify("use_laser");
		}
	}
}

//Function Number: 34
func_16A0(param_00)
{
	if(!isdefined(level.var_16A1) || level.var_16A1.size == 0)
	{
		return undefined;
	}

	foreach(var_02 in level.var_16A1)
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
			level.var_16A1 = common_scripts\utility::array_remove(level.var_16A1,var_02);
			return getent(var_02.target,"script_noteworthy");
		}
	}

	return undefined;
}

//Function Number: 35
func_16A2()
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
func_16A3(param_00)
{
	level.player endon("remove_laser_targeting_device");
	level.player.var_1698 = 0;
	self setweaponhudiconoverride("actionslot4","dpad_killstreak_hellfire_missile_inactive");
	maps\_utility::flavorbursts_off("allies");
	var_01 = level.player;
	wait 2.5;
	if(!isdefined(param_00.script_index))
	{
		param_00.script_index = 99;
	}

	wait 1;
	if(isdefined(param_00.var_16A6))
	{
		var_02 = func_16A7("geo_before",param_00.var_16A6);
		if(var_02.size > 0)
		{
			common_scripts\utility::array_call(var_02,::hide);
		}

		var_03 = func_16A7("geo_after",param_00.var_16A6);
		if(var_03.size > 0)
		{
			common_scripts\utility::array_call(var_03,::show);
		}
	}

	wait level.player.var_1699;
	level.player.var_1698 = 1;
	self setweaponhudiconoverride("actionslot4","dpad_laser_designator");
}

//Function Number: 37
func_16A7(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.var_16A6) && var_05.var_16A6 == param_01)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 38
func_16A8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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
				thread func_16AD(param_00,param_04);
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
			thread func_16AB(param_00,param_06);
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
func_16AA(param_00,param_01,param_02,param_03)
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
	var_04 thread func_16AF();
	wait 2;
	var_04 notify("stop_blink");
	wait 0.05;
	var_04 destroy();
}

//Function Number: 40
func_16AB(param_00,param_01)
{
	func_16AA(param_00,param_01,::maps\_specialops::set_hud_red,"so_sample_not_collected");
}

//Function Number: 41
func_16AD(param_00,param_01)
{
	func_16AA(param_00,param_01,::maps\_specialops::set_hud_green,"arcademode_2x");
}

//Function Number: 42
func_16AF(param_00)
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
func_16B0()
{
	var_00 = getentarray("shg_vision_multiple_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_16B1();
	}
}

//Function Number: 44
func_16B1()
{
	var_00 = common_scripts\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_03 = vectornormalize(self.origin - var_02.origin);
		var_02.var_16B2 = var_03;
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
				var_0A = vectordot(var_06,var_02.var_16B2);
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
func_16B3(param_00)
{
	self setmodel(param_00);
	func_16B4(self.weapon);
}

//Function Number: 46
func_16B4(param_00,param_01)
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
func_16B5(param_00,param_01,param_02)
{
	if(issplitscreen())
	{
		if(self == level.player)
		{
			param_00 = param_00 + 2;
		}

		param_00 = param_00 / 2;
	}

	return maps\_specialops::so_create_hud_item(param_00,param_01,param_02,self);
}

//Function Number: 48
func_16B7(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.var_16B8 = "award_positive";
	level.var_16B9 = "award_positive";
	level.var_16BA = func_16BE(param_00,param_01,param_02);
	level.var_16BB = func_16BE(param_03,param_04,param_05);
	common_scripts\utility::array_thread(level.players,::func_16BF);
	level.var_16BC = 1;
	level.var_16BD = ::func_16C2;
	func_16D5();
}

//Function Number: 49
func_16BE(param_00,param_01,param_02)
{
	var_03 = [];
	if(isdefined(param_00))
	{
	}
	else
	{
		var_7B["max_successes"] = undefined;
	}

	return var_7B;
}

//Function Number: 50
func_16BF()
{
	if(!isdefined(self.var_16C0))
	{
		self.var_16C0 = 0;
	}

	if(!isdefined(self.var_16C1))
	{
		self.var_16C1 = 0;
	}
}

//Function Number: 51
func_16C2()
{
	if(issplitscreen())
	{
		setdvar("ui_hide_hint",1);
	}

	if(!level.missionfailed)
	{
		setdvar("ui_hide_hint",1);
	}

	level.challenge_time_limit = func_16CA();
	level.var_16C4 = 0;
	foreach(var_01 in level.players)
	{
		var_01.var_16C5 = func_16CD(var_01);
		level.var_16C4 = level.var_16C4 + var_01.var_16C5["kill_score"];
		level.var_16C4 = level.var_16C4 + var_01.var_16C5["challenge_1"];
		level.var_16C4 = level.var_16C4 + var_01.var_16C5["challenge_2"];
	}

	level.var_16C4 = level.var_16C4 + level.players[0].var_16C5["gameskill_score"];
	level.var_16C4 = level.var_16C4 + level.players[0].var_16C5["time_score"];
	level.var_16C4 = int(level.var_16C4);
	foreach(var_01 in level.players)
	{
		var_01 maps\_specialops::override_summary_score(level.var_16C4);
		if(maps\_utility::is_coop())
		{
			var_04 = maps\_utility::get_other_player(var_01);
			var_01 maps\_utility::add_custom_eog_summary_line("","@SPECIAL_OPS_PERFORMANCE_YOU","@SPECIAL_OPS_PERFORMANCE_PARTNER");
			var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY",var_01.var_16C5["difficulty"],var_04.var_16C5["difficulty"]);
			var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS",var_01.var_16C5["kills_num"],var_04.var_16C5["kills_num"]);
			var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BA["description"],var_01.var_16C5["ch_1_tally"],var_04.var_16C5["ch_1_tally"]);
			if(level.var_16BB["value"] > 0)
			{
				var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BB["description"],var_01.var_16C5["ch_2_tally"],var_04.var_16C5["ch_2_tally"]);
			}

			var_01 maps\_utility::add_custom_eog_summary_line(var_01.var_16C5["t_message"],"",var_04.var_16C5["time_string"]);
			if(level.var_16BB["value"] <= 0 || !issplitscreen())
			{
				var_01 maps\_utility::add_custom_eog_summary_line_blank();
			}

			if(!level.missionfailed)
			{
				var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_SCORE","",level.var_16C4);
			}

			continue;
		}

		if(!level.missionfailed)
		{
			var_01 maps\_utility::add_custom_eog_summary_line("","","@SPECIAL_OPS_POINTS");
			var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY",var_01.var_16C5["difficulty"],var_01.var_16C5["gameskill_score"]);
			var_01 maps\_utility::add_custom_eog_summary_line(var_01.var_16C5["t_message"],var_01.var_16C5["time_string"],var_01.var_16C5["time_score"]);
			var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS",var_01.var_16C5["kills_num"],var_01.var_16C5["kill_score"]);
			var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BA["description"],var_01.var_16C5["ch_1_tally"],var_01.var_16C5["challenge_1"]);
			if(level.var_16BB["value"] > 0)
			{
				var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BB["description"],var_01.var_16C5["ch_2_tally"],var_01.var_16C5["challenge_2"]);
			}

			if(level.var_16BB["value"] <= 0 || !issplitscreen())
			{
				var_01 maps\_utility::add_custom_eog_summary_line_blank();
			}

			var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_SCORE","               ",level.var_16C4);
			continue;
		}

		var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY","",var_01.var_16C5["difficulty"]);
		var_01 maps\_utility::add_custom_eog_summary_line(var_01.var_16C5["t_message"],"",var_01.var_16C5["time_string"]);
		var_01 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS","",var_01.var_16C5["kills_num"]);
		var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BA["description"],"",var_01.var_16C5["ch_1_tally"]);
		if(level.var_16BB["value"] > 0)
		{
			var_01 maps\_utility::add_custom_eog_summary_line(level.var_16BB["description"],"",var_01.var_16C5["ch_2_tally"]);
		}
	}
}

//Function Number: 52
func_16CA()
{
	if(!isdefined(level.var_16CB))
	{
		level.var_16CB = 420000;
	}

	if(!isdefined(level.var_4412))
	{
		level.var_4412 = 0;
	}

	if(!isdefined(level.challenge_time_limit))
	{
		level.var_16CC = 0;
		level.challenge_time_limit = level.var_16CB;
	}
	else
	{
		level.var_16CC = 1;
	}

	level.var_4413 = level.var_16CB - level.var_4412;
	return level.challenge_time_limit;
}

//Function Number: 53
func_16CD(param_00,param_01,param_02)
{
	param_00.var_16C5 = [];
	param_00.var_16C5["final_score"] = 0;
	param_00.var_16C5["level_time"] = level.challenge_end_time - level.challenge_start_time;
	if(level.challenge_time_limit > param_00.var_16C5["level_time"])
	{
		param_00.var_16C5["t_message"] = func_16D4("bonus");
		param_00.var_16C5["remaining_time"] = int(level.challenge_time_limit - param_00.var_16C5["level_time"]);
		if(!level.missionfailed)
		{
		}

		if(!level.var_16CC)
		{
			if(level.var_4412 <= param_00.var_16C5["level_time"])
			{
				param_00.var_16C5["time_percent"] = max(level.var_4413 - param_00.var_16C5["level_time"] - level.var_4412 / level.var_4413,0);
			}
			else
			{
				param_00.var_16C5["time_percent"] = 1;
			}
		}
		else if(level.var_4412 >= param_00.var_16C5["remaining_time"])
		{
			param_00.var_16C5["time_percent"] = max(param_00.var_16C5["remaining_time"] / level.var_4413,0);
		}
		else
		{
			param_00.var_16C5["time_percent"] = 1;
		}

		param_00.var_16C5["time_score"] = int(param_00.var_16C5["time_percent"] * 5000);
		if(level.var_16CC)
		{
			param_00.var_16C5["time_string"] = maps\_utility::convert_to_time_string(param_00.var_16C5["remaining_time"] * 0.001,1);
		}
		else
		{
			param_00.var_16C5["time_string"] = maps\_utility::convert_to_time_string(param_00.var_16C5["level_time"] * 0.001,1);
		}

		param_00.var_16C5["final_score"] = param_00.var_16C5["final_score"] + param_00.var_16C5["time_score"];
	}
	else
	{
		param_00.var_16C5["t_message"] = func_16D4("no_bonus");
		param_00.var_16C5["time_string"] = maps\_utility::convert_to_time_string(param_00.var_16C5["level_time"] * 0.001,1);
		param_00.var_16C5["time_score"] = 0;
	}

	param_00.var_16C5["gameskill_low"] = level.so_enable_wait_for_players;
	param_00.var_16C5["gameskill_score"] = max(10000 * param_00.var_16C5["gameskill_low"],0);
	param_00.var_16C5["final_score"] = param_00.var_16C5["final_score"] + param_00.var_16C5["gameskill_score"];
	if(isdefined(level.var_16BA["max_successes"]))
	{
		param_00.var_16C5["challenge_1"] = min(level.var_16BA["value"] * param_00.var_16C0,level.var_16BA["value"] * level.var_16BA["max_successes"]);
	}
	else
	{
		param_00.var_16C5["challenge_1"] = level.var_16BA["value"] * param_00.var_16C0;
	}

	if(isdefined(level.var_16BB["max_successes"]))
	{
		param_00.var_16C5["challenge_2"] = min(level.var_16BB["value"] * param_00.var_16C1,level.var_16BB["value"] * level.var_16BB["max_successes"]);
	}
	else
	{
		param_00.var_16C5["challenge_2"] = level.var_16BB["value"] * param_00.var_16C1;
	}

	param_00.var_16C5["final_score"] = param_00.var_16C5["final_score"] + param_00.var_16C5["challenge_1"] + param_00.var_16C5["challenge_2"];
	param_00.var_16C5["ch_1_tally"] = func_16D3(param_00.var_16C0,level.var_16BA["max_successes"]);
	param_00.var_16C5["ch_2_tally"] = func_16D3(param_00.var_16C1,level.var_16BB["max_successes"]);
	param_00.var_16C5["kills_num"] = param_00.stats["kills"];
	param_00.var_16C5["kill_score"] = min(param_00.stats["kills"] * 25,2500);
	param_00.var_16C5["final_score"] = param_00.var_16C5["final_score"] + param_00.var_16C5["kill_score"];
	param_00.var_16C5["final_score"] = func_16E0(param_00,param_00.var_16C5["final_score"],param_00.var_16C5["gameskill_score"]);
	param_00.var_16C5["difficulty"] = maps\_specialops::so_get_difficulty_menu_string(param_00.gameskill);
	return param_00.var_16C5;
}

//Function Number: 54
func_16D3(param_00,param_01)
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

	if(maps\_utility::is_coop())
	{
		return param_00;
	}

	return param_00 + " / " + param_01;
}

//Function Number: 55
func_16D4(param_00)
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
func_16D5(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread func_16D6(level.var_16BA["value"],level.var_16BB["value"]);
	}
}

//Function Number: 57
func_16D6(param_00,param_01)
{
	self.var_16D8 = func_16DB(1,level.var_16BA,level.var_16B8,param_00,level.var_16D7);
	self.var_16DA = func_16DB(2,level.var_16BB,level.var_16B9,param_01,level.var_16D9);
	thread func_16DF();
	thread func_16E1(self.var_16D8);
	thread func_16E2(self.var_16DA);
	thread monitor_challenges();
}

//Function Number: 58
monitor_challenges(param_00)
{
	var_01 = self.var_16C0;
	var_02 = self.var_16C1;
	for(;;)
	{
		if(self.var_16C0 != var_01)
		{
			func_16DD(self.var_16D8,var_01,1);
			var_01 = self.var_16C0;
		}

		if(self.var_16C1 != var_02)
		{
			func_16DD(self.var_16DA,var_02,2);
			var_02 = self.var_16C1;
		}

		wait 0.05;
	}
}

//Function Number: 59
func_16DB(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	return var_7B;
}

//Function Number: 60
func_16DC(param_00)
{
	if(param_00 == 1)
	{
		return self.var_16C0;
	}

	if(param_00 == 2)
	{
		return self.var_16C1;
	}
}

//Function Number: 61
func_16DD(param_00,param_01,param_02)
{
	var_03 = func_16DC(param_02);
	if(isdefined(param_00["max"]) && var_03 < param_00["max"])
	{
		func_16DE(param_00,param_01,param_02);
		return;
	}

	if(!isdefined(param_00["max"]))
	{
		func_16DE(param_00,param_01,param_02);
	}
}

//Function Number: 62
func_16DE(param_00,param_01,param_02)
{
	var_03 = func_16DC(param_02);
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
func_16DF()
{
	for(;;)
	{
		self waittill("bonus_achieved");
		thread common_scripts\utility::play_sound_in_space("arcademode_2x",self geteye());
		wait 0.5;
	}
}

//Function Number: 64
func_16E0(param_00,param_01,param_02)
{
	var_03 = param_02 + 29999;
	param_01 = int(min(param_01,var_03));
	return param_01;
}

//Function Number: 65
func_16E1(param_00)
{
	for(;;)
	{
		self waittill("bonus1_achieved");
		func_16E3(150,115,1,param_00);
	}
}

//Function Number: 66
func_16E2(param_00)
{
	for(;;)
	{
		self waittill("bonus2_achieved");
		func_16E3(170,135,2,param_00);
	}
}

//Function Number: 67
func_16E3(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03["text"]))
	{
		var_04["bar"] = func_16E6(59,param_00,"right",0);
		var_04["bar"] func_16E5(18);
		var_05 = [];
		var_7B["text"] settext(var_04["text"]);
		var_7B["text"] thread func_16E4();
		var_7B["num"] thread func_16E4();
		var_06 = func_16DC(param_03);
		for(var_07 = 0;var_07 < 90;var_07++ = var_7B["num"])
		{
			var_08 = func_16DC(param_03);
			var_09 = func_16D3(var_08,var_04["max"]);
			var_7B["num"] settext(" " + var_09);
			if(var_06 != var_08)
			{
				var_06 = var_08;
				var_7B["num"] thread func_16E4();
			}

			wait 0.05;
		}

		if(isdefined(var_05["bar"]))
		{
			var_05["bar"] destroy();
		}

		if(isdefined(var_7B["text"]))
		{
			var_7B["text"] destroy();
		}

		if(isdefined(var_7B["num"]))
		{
			var_7B["num"] destroy();
		}
	}
}

//Function Number: 68
func_16E4()
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
func_16E5(param_00)
{
	self scaleovertime(0.25,100,param_00);
	wait 0.25;
}

//Function Number: 70
func_16E6(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04 = func_16E8(var_04,59,param_01,"right",0);
	var_04 setshader("hud_white_box",100,1);
	var_04.alpha = 0.5;
	var_04.color = (0.7,0.8,0.7);
	return var_04;
}

//Function Number: 71
func_16E7(param_00,param_01,param_02,param_03)
{
	var_04 = maps\_hud_util::createclientfontstring("hudsmall",0.75);
	var_04 = func_16E8(var_04,76,param_01,param_02,2);
	return var_04;
}

//Function Number: 72
func_16E8(param_00,param_01,param_02,param_03,param_04)
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
func_16E9(param_00)
{
	maps\_utility::bcs_scripted_dialogue_start();
	if(isdefined(self.last_queue_time))
	{
		maps\_utility::wait_for_buffer_time_to_pass(self.last_queue_time,0.5);
	}

	var_01 = [];
	maps\_utility::function_stack(::func_16EB,var_7B,var_01);
	if(isalive(self))
	{
		self.last_queue_time = gettime();
	}
}

//Function Number: 74
func_16EB(param_00,param_01,param_02)
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
					var_09 thread func_16F0(param_01,var_12,var_16,level.scr_face[var_18][param_01]);
				}

				thread maps\_anim::anim_facialanim(var_09,param_01,level.scr_face[var_18][param_01]);
			}
			else if(isai(var_09))
			{
				if(var_14)
				{
					var_09 animscripts/face::func_C46(var_17,var_16,1);
				}
				else
				{
					var_09 thread maps\_anim::anim_facialfiller("single dialogue");
					var_09 animscripts/face::func_C46(var_17,var_16,1,"single dialogue");
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
			var_0F thread func_16EC(var_09,param_01);
			var_0F thread func_16EF(var_09,param_01,var_1B,param_00[var_07][1]);
			var_10++;
			continue;
		}

		if(var_12)
		{
			var_0F thread func_16EC(var_09,param_01);
			var_0F thread func_16ED(var_09,param_01,var_17);
			var_10++;
			continue;
		}

		if(var_13)
		{
			var_0F thread func_16EC(var_09,param_01);
			var_0F thread func_16EE(var_09,param_01);
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
func_16EC(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("death");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 76
func_16ED(param_00,param_01,param_02)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	var_03 = getanimlength(param_02);
	wait var_03;
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 77
func_16EE(param_00,param_01)
{
	param_00 endon("kill_anim_end_notify_" + param_01);
	param_00 waittill("single dialogue");
	self notify(param_01,param_00);
	param_00 notify("kill_anim_end_notify_" + param_01);
}

//Function Number: 78
func_16EF(param_00,param_01,param_02,param_03)
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
func_16F0(param_00,param_01,param_02,param_03)
{
	if(param_01)
	{
		thread func_16F1(param_00);
		thread func_16F2(param_00);
		thread func_16F3(param_00);
		var_04 = [];
		if(!isarray(param_02))
		{
		}
		else
		{
			var_7B = param_03;
		}

		foreach(var_06 in var_7B)
		{
			self waittillmatch(param_02,var_7B[0],"dialogue_line","face_done_" + param_01);
			animscripts/face::func_C46(undefined,var_06,1);
		}

		self notify("all_facial_lines_done");
		return;
	}

	animscripts/face::func_C46(undefined,param_03,1,"single dialogue");
}

//Function Number: 80
func_16F1(param_00)
{
	self endon("death");
	self waittillmatch("end","face_done_" + param_00);
	self notify("facial_anim_end_" + param_00);
}

//Function Number: 81
func_16F2(param_00)
{
	self endon("death");
	self endon("all_facial_lines_done");
	self waittill("facial_anim_end_" + param_00);
}

//Function Number: 82
func_16F3(param_00)
{
	self endon("death");
	self endon("facial_anim_end_" + param_00);
	self waittill("all_facial_lines_done");
	self waittillmatch("dialogue_line","face_done_" + param_00);
}