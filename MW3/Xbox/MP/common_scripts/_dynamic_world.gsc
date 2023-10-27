/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_dynamic_world.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 64
 * Decompile Time: 1055 ms
 * Timestamp: 10/27/2023 2:29:12 AM
*******************************************************************/

//Function Number: 1
init()
{
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_slow","targetname"),::fan_blade_rotate,"veryslow");
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate","targetname"),::fan_blade_rotate,"slow");
	common_scripts\utility::array_thread(getentarray("com_wall_fan_blade_rotate_fast","targetname"),::fan_blade_rotate,"fast");
	var_00 = [];
	func_18B7();
	foreach(var_04, var_02 in var_41)
	{
		var_03 = getentarray(var_04,"classname");
		common_scripts\utility::array_thread(var_03,::triggertouchthink);
		common_scripts\utility::array_thread(var_03,var_02);
	}

	common_scripts\utility::array_thread(getentarray("vending_machine","targetname"),::vending_machine);
	common_scripts\utility::array_thread(getentarray("toggle","targetname"),::use_toggle);
	level thread onplayerconnect();
	var_05 = getent("civilian_jet_origin","targetname");
	if(isdefined(var_05))
	{
		var_05 thread civilian_jet_flyby();
	}
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",var_00);
		var_00 thread movementtracker();
	}
}

//Function Number: 3
func_18B7()
{
	if(common_scripts\utility::issp())
	{
		foreach(var_01 in level.players)
		{
			var_01.touchtriggers = [];
			var_01 thread movementtracker();
		}
	}
}

//Function Number: 4
func_18B9()
{
	self.touchtriggers = [];
	thread movementtracker();
}

//Function Number: 5
civilian_jet_flyby()
{
	level endon("game_ended");
	func_18BB();
	level waittill("prematch_over");
	for(;;)
	{
		thread func_18C9();
		self waittill("start_flyby");
		thread jet_flyby();
		self waittill("flyby_done");
		jet_reset();
	}
}

//Function Number: 6
func_18BB()
{
	self.var_18BC = getentarray(self.target,"targetname");
	self.jet_flyto = getent("civilian_jet_flyto","targetname");
	self.engine_fxs = getentarray("engine_fx","targetname");
	self.var_18BF = getentarray("flash_fx","targetname");
	self.jet_engine_fx = loadfx("fire/jet_afterburner");
	self.jet_flash_fx_red = loadfx("misc/aircraft_light_wingtip_red");
	self.jet_flash_fx_green = loadfx("misc/aircraft_light_wingtip_green");
	self.jet_flash_fx_blink = loadfx("misc/aircraft_light_red_blink");
	level.civilianjetflyby = undefined;
	var_00 = vectornormalize(self.origin - self.jet_flyto.origin) * 20000;
	self.jet_flyto.origin = self.jet_flyto.origin - var_00;
	self.origin = self.origin + var_00;
	foreach(var_02 in self.var_18BC)
	{
		var_02.origin = var_02.origin + var_00;
		var_02.old_origin = var_02.origin;
		var_02 hide();
	}

	foreach(var_05 in self.engine_fxs)
	{
		var_05.origin = var_05.origin + var_00;
	}

	foreach(var_08 in self.var_18BF)
	{
		var_08.origin = var_08.origin + var_00;
	}

	var_0A = self.origin;
	var_0B = self.jet_flyto.origin;
	self.jet_fly_vec = var_0B - var_0A;
	var_0C = 2000;
	var_0D = abs(distance(var_0A,var_0B));
	self.var_18C7 = var_0D / var_0C;
}

//Function Number: 7
jet_reset()
{
	foreach(var_01 in self.var_18BC)
	{
		var_01.origin = var_01.old_origin;
		var_01 hide();
	}
}

//Function Number: 8
func_18C9()
{
	level endon("game_ended");
	var_00 = gettimeinterval();
	var_01 = max(10,var_00);
	var_01 = min(var_01,100);
	if(getdvar("jet_flyby_timer") != "")
	{
		level.civilianjetflyby_timer = 5 + getdvarint("jet_flyby_timer");
	}
	else
	{
		level.civilianjetflyby_timer = 0.25 + randomfloatrange(0.3,0.7) * 60 * var_01;
	}

	wait level.civilianjetflyby_timer;
	while(isdefined(level.airstrikeinprogress) || isdefined(level.ac130player) || isdefined(level.chopper) || isdefined(level.remotemissileinprogress))
	{
		wait 0.05;
	}

	self notify("start_flyby");
	level.civilianjetflyby = 1;
	self waittill("flyby_done");
	level.civilianjetflyby = undefined;
}

//Function Number: 9
gettimeinterval()
{
	if(common_scripts\utility::issp())
	{
		return 10;
	}

	if(isdefined(game["status"]) && game["status"] == "overtime")
	{
		return 1;
	}

	return func_18D0("timelimit");
}

//Function Number: 10
func_18D0(param_00)
{
	param_00 = "scr_" + level.gametype + "_" + param_00;
	if(isdefined(level.overridewatchdvars) && isdefined(level.overridewatchdvars[param_00]))
	{
		return level.overridewatchdvars[param_00];
	}

	return level.watchdvars[param_00].value;
}

//Function Number: 11
jet_flyby()
{
	foreach(var_01 in self.var_18BC)
	{
		var_01 show();
	}

	var_03 = [];
	var_04 = [];
	foreach(var_06 in self.engine_fxs)
	{
		var_07 = spawn("script_model",var_06.origin);
		var_07 setmodel("tag_origin");
		var_07.angles = var_06.angles;
		var_03[var_03.size] = var_07;
	}

	foreach(var_0A in self.var_18BF)
	{
		var_0B = spawn("script_model",var_0A.origin);
		var_0B setmodel("tag_origin");
		var_0B.color = var_0A.script_noteworthy;
		var_0B.angles = var_0A.angles;
		var_04[var_04.size] = var_0B;
	}

	thread jet_planesound(self.var_18BC[0],level.mapcenter);
	wait 0.05;
	foreach(var_07 in var_03)
	{
		playfxontag(self.jet_engine_fx,var_07,"tag_origin");
	}

	foreach(var_0B in var_04)
	{
		if(isdefined(var_0B.color) && var_0B.color == "blink")
		{
			playfxontag(self.jet_flash_fx_blink,var_0B,"tag_origin");
			continue;
		}

		if(isdefined(var_0B.color) && var_0B.color == "red")
		{
			playfxontag(self.jet_flash_fx_red,var_0B,"tag_origin");
			continue;
		}

		playfxontag(self.jet_flash_fx_green,var_0B,"tag_origin");
	}

	foreach(var_01 in self.var_18BC)
	{
		var_01 moveto(var_01.origin + self.jet_fly_vec,self.var_18C7);
	}

	foreach(var_07 in var_03)
	{
		var_07 moveto(var_07.origin + self.jet_fly_vec,self.var_18C7);
	}

	foreach(var_0B in var_04)
	{
		var_0B moveto(var_0B.origin + self.jet_fly_vec,self.var_18C7);
	}

	wait self.var_18C7 + 1;
	foreach(var_07 in var_03)
	{
		var_07 delete();
	}

	foreach(var_0B in var_04)
	{
		var_0B delete();
	}

	self notify("flyby_done");
}

//Function Number: 12
jet_planesound(param_00,param_01)
{
	param_00 thread func_18D9("veh_mig29_dist_loop");
	while(!func_18DB(param_00,param_01))
	{
		wait 0.05;
	}

	param_00 thread func_18D9("veh_mig29_close_loop");
	while(func_18DA(param_00,param_01))
	{
		wait 0.05;
	}

	wait 0.5;
	param_00 thread func_18D8("veh_mig29_sonic_boom");
	while(func_18DB(param_00,param_01))
	{
		wait 0.05;
	}

	param_00 notify("stop soundveh_mig29_close_loop");
	self waittill("flyby_done");
	param_00 notify("stop soundveh_mig29_dist_loop");
}

//Function Number: 13
func_18D8(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,1));
	var_03 hide();
	if(!isdefined(param_01))
	{
		param_01 = self.origin;
	}

	var_03.origin = param_01;
	if(isdefined(param_02) && param_02)
	{
		var_03 playsoundasmaster(param_00);
	}
	else
	{
		var_03 playsound(param_00);
	}

	wait 10;
	var_03 delete();
}

//Function Number: 14
func_18D9(param_00,param_01)
{
	var_02 = spawn("script_origin",(0,0,0));
	var_02 hide();
	var_02 endon("death");
	thread common_scripts\utility::delete_on_death(var_02);
	if(isdefined(param_01))
	{
		var_02.origin = self.origin + param_01;
		var_02.angles = self.angles;
		var_02 linkto(self);
	}
	else
	{
		var_02.origin = self.origin;
		var_02.angles = self.angles;
		var_02 linkto(self);
	}

	var_02 playloopsound(param_00);
	self waittill("stop sound" + param_00);
	var_02 stoploopsound(param_00);
	var_02 delete();
}

//Function Number: 15
func_18DA(param_00,param_01)
{
	var_02 = anglestoforward(common_scripts\utility::flat_angle(param_00.angles));
	var_03 = vectornormalize(common_scripts\utility::flat_origin(param_01) - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_18DB(param_00,param_01)
{
	var_02 = func_18DA(param_00,param_01);
	if(var_02)
	{
		var_03 = 1;
	}
	else
	{
		var_03 = -1;
	}

	var_04 = common_scripts\utility::flat_origin(param_00.origin);
	var_05 = var_04 + anglestoforward(common_scripts\utility::flat_angle(param_00.angles)) * var_03 * 100000;
	var_06 = pointonsegmentnearesttopoint(var_04,var_05,param_01);
	var_07 = distance(var_04,var_06);
	if(var_07 < 3000)
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
vending_machine()
{
	level endon("game_ended");
	self endon("death");
	self setcursorhint("HINT_ACTIVATE");
	self.vm_normal = getent(self.target,"targetname");
	var_00 = getent(self.vm_normal.target,"targetname");
	var_01 = getent(var_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	self.var_18DE = var_02.origin;
	var_03 = getent(var_02.target,"targetname");
	self.var_18DF = var_03.origin;
	if(isdefined(var_03.target))
	{
		self.vm_fx_loc = getent(var_03.target,"targetname").origin;
	}

	self.vm_normal setcandamage(1);
	self.vm_normal_model = self.vm_normal.model;
	self.vm_damaged_model = self.vm_normal.script_noteworthy;
	self.vm_soda_model = var_00.model;
	self.vm_soda_start_pos = var_00.origin;
	self.vm_soda_start_angle = var_00.angles;
	self.var_18E6 = var_01.origin;
	self.vm_soda_stop_angle = var_01.angles;
	precachemodel(self.vm_damaged_model);
	var_00 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
	self.soda_array = [];
	self.soda_count = 12;
	self.var_18EA = undefined;
	self.hp = 400;
	thread func_18EC(self.vm_normal);
	self playloopsound("vending_machine_hum");
	for(;;)
	{
		self waittill("trigger",var_04);
		self playsound("vending_machine_button_press");
		if(!self.soda_count)
		{
			continue;
		}

		if(isdefined(self.var_18EA))
		{
			soda_can_eject();
		}

		soda_can_drop(spawn_soda());
		wait 0.05;
	}
}

//Function Number: 18
func_18EC(param_00)
{
	level endon("game_ended");
	var_01 = "mod_grenade mod_projectile mod_explosive mod_grenade_splash mod_projectile_splash splash";
	var_02 = loadfx("explosions/tv_explosion");
	for(;;)
	{
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
		param_00 waittill("damage",var_03,var_04,var_05,var_06,var_07);
		if(isdefined(var_07))
		{
			if(issubstr(var_01,tolower(var_07)))
			{
				var_03 = var_03 * 3;
			}

			self.hp = self.hp - var_03;
			if(self.hp > 0)
			{
				continue;
			}

			self notify("death");
			self.origin = self.origin + (0,0,10000);
			if(!isdefined(self.vm_fx_loc))
			{
				var_08 = self.vm_normal.origin + (37,-31,52);
			}
			else
			{
				var_08 = self.vm_fx_loc;
			}

			playfx(var_02,var_08);
			self.vm_normal setmodel(self.vm_damaged_model);
			while(self.soda_count > 0)
			{
				if(isdefined(self.var_18EA))
				{
					soda_can_eject();
				}

				soda_can_drop(spawn_soda());
				wait 0.05;
			}

			self stoploopsound("vending_machine_hum");
			return;
		}
	}
}

//Function Number: 19
spawn_soda()
{
	var_00 = spawn("script_model",self.vm_soda_start_pos);
	var_00 setmodel(self.vm_soda_model);
	var_00.origin = self.vm_soda_start_pos;
	var_00.angles = self.vm_soda_start_angle;
	return var_00;
}

//Function Number: 20
soda_can_drop(param_00)
{
	param_00 moveto(self.var_18E6,0.2);
	param_00 playsound("vending_machine_soda_drop");
	wait 0.2;
	self.var_18EA = param_00;
	self.soda_count--;
}

//Function Number: 21
soda_can_eject()
{
	self endon("death");
	if(isdefined(self.var_18EA.var_18F0) && self.var_18EA.var_18F0 == 1)
	{
		return;
	}

	var_00 = 1;
	var_01 = var_00 * -999;
	var_02 = int(-25536);
	var_03 = (int(var_02 / 2),int(var_02 / 2),0) - (randomint(var_02),randomint(var_02),0);
	var_04 = vectornormalize(self.var_18DF - self.var_18DE + var_03);
	var_05 = var_04 * randomfloatrange(var_01,var_00);
	self.var_18EA physicslaunchclient(self.var_18DE,var_05);
	self.var_18EA.var_18F0 = 1;
}

//Function Number: 22
freefall()
{
	level endon("game_ended");
	var_00 = "briefcase_bomb_mp";
	precacheitem(var_00);
	for(;;)
	{
		self waittill("trigger_enter",var_01);
		if(!var_01 hasweapon(var_00))
		{
			var_01 playsound("freefall_death");
			var_01 giveweapon(var_00);
			var_01 setweaponammostock(var_00,0);
			var_01 setweaponammoclip(var_00,0);
			var_01 switchtoweapon(var_00);
		}
	}
}

//Function Number: 23
metal_detector()
{
	level endon("game_ended");
	var_00 = getent(self.target,"targetname");
	var_00 enablegrenadetouchdamage();
	var_01 = getent(var_00.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	var_03 = getent(var_02.target,"targetname");
	var_04 = getent(var_03.target,"targetname");
	var_05 = [];
	var_06 = min(var_01.origin[0],var_02.origin[0]);
	var_05[0] = var_06;
	var_07 = max(var_01.origin[0],var_02.origin[0]);
	var_05[1] = var_07;
	var_08 = min(var_01.origin[1],var_02.origin[1]);
	var_05[2] = var_08;
	var_09 = max(var_01.origin[1],var_02.origin[1]);
	var_05[3] = var_09;
	var_0A = min(var_01.origin[2],var_02.origin[2]);
	var_05[4] = var_0A;
	var_0B = max(var_01.origin[2],var_02.origin[2]);
	var_05[5] = var_0B;
	var_01 delete();
	var_02 delete();
	if(!common_scripts\utility::issp())
	{
		self.var_18F3 = 7;
	}
	else
	{
		self.var_18F3 = 2;
	}

	self.alarm_playing = 0;
	self.alarm_annoyance = 0;
	self.tolerance = 0;
	thread metal_detector_dmg_monitor(var_00);
	thread metal_detector_touch_monitor();
	thread metal_detector_weapons(var_05,"weapon_claymore","weapon_c4");
	var_0C = (var_03.origin[0],var_03.origin[1],var_0B);
	var_0D = (var_04.origin[0],var_04.origin[1],var_0B);
	var_0E = loadfx("props/metal_detector_light");
	for(;;)
	{
		common_scripts\utility::waittill_any("dmg_triggered","touch_triggered","weapon_triggered");
		thread func_18F7("alarm_metal_detector",var_0E,var_0C,var_0D);
	}
}

//Function Number: 24
func_18F7(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(!self.alarm_playing)
	{
		self.alarm_playing = 1;
		thread func_18F8();
		if(!self.alarm_annoyance)
		{
			self playsound(param_00);
		}

		playfx(param_01,param_02);
		playfx(param_01,param_03);
		wait self.var_18F3;
		self.alarm_playing = 0;
	}
}

//Function Number: 25
func_18F8()
{
	level endon("game_ended");
	if(!self.tolerance)
	{
		return;
	}

	var_00 = self.var_18F3 + 0.15;
	if(self.tolerance)
	{
		self.tolerance--;
	}
	else
	{
		self.alarm_annoyance = 1;
	}

	var_01 = gettime();
	var_02 = 7;
	if(common_scripts\utility::issp())
	{
		var_02 = 2;
	}

	waittill_any_or_timeout("dmg_triggered","touch_triggered","weapon_triggered",var_02 + 2);
	var_03 = gettime() - var_01;
	if(var_03 > var_02 * 1000 + 1150)
	{
		self.alarm_annoyance = 0;
		self.tolerance = 0;
	}
}

//Function Number: 26
waittill_any_or_timeout(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	self endon(param_00);
	self endon(param_01);
	self endon(param_02);
	wait param_03;
}

//Function Number: 27
metal_detector_weapons(param_00,param_01,param_02)
{
	level endon("game_ended");
	for(;;)
	{
		waittill_weapon_placed();
		var_03 = getentarray("grenade","classname");
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.model) && var_05.model == param_01 || var_05.model == param_02)
			{
				if(isinbound(var_05,param_00))
				{
					thread weapon_notify_loop(var_05,param_00);
				}
			}
		}
	}
}

//Function Number: 28
waittill_weapon_placed()
{
	level endon("game_ended");
	self endon("dmg_triggered");
	self waittill("touch_triggered");
}

//Function Number: 29
weapon_notify_loop(param_00,param_01)
{
	param_00 endon("death");
	while(isinbound(param_00,param_01))
	{
		self notify("weapon_triggered");
		wait self.var_18F3;
	}
}

//Function Number: 30
isinbound(param_00,param_01)
{
	var_02 = param_01[0];
	var_03 = param_01[1];
	var_04 = param_01[2];
	var_05 = param_01[3];
	var_06 = param_01[4];
	var_07 = param_01[5];
	var_08 = param_00.origin[0];
	var_09 = param_00.origin[1];
	var_0A = param_00.origin[2];
	if(isinbound_single(var_08,var_02,var_03))
	{
		if(isinbound_single(var_09,var_04,var_05))
		{
			if(isinbound_single(var_0A,var_06,var_07))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 31
isinbound_single(param_00,param_01,param_02)
{
	if(param_00 > param_01 && param_00 < param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 32
metal_detector_dmg_monitor(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05);
		if(isdefined(var_05) && alarm_validate_damage(var_05))
		{
			self notify("dmg_triggered");
		}
	}
}

//Function Number: 33
metal_detector_touch_monitor()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter");
		while(func_1930(self))
		{
			self notify("touch_triggered");
			wait self.var_18F3;
		}
	}
}

//Function Number: 34
alarm_validate_damage(param_00)
{
	var_01 = "mod_melee melee mod_grenade mod_projectile mod_explosive mod_impact";
	var_02 = strtok(var_01," ");
	foreach(var_04 in var_02)
	{
		if(tolower(var_04) == tolower(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
func_1901()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger_enter",var_00);
		var_00 thread func_1902(self);
	}
}

//Function Number: 36
func_1902(param_00)
{
	self endon("disconnect");
	self endon("death");
	self playsound("step_walk_plr_woodcreak_on");
	for(;;)
	{
		self waittill("trigger_leave",var_01);
		if(param_00 != var_01)
		{
			continue;
		}

		self playsound("step_walk_plr_woodcreak_off");
	}
}

//Function Number: 37
motion_light()
{
	level endon("game_ended");
	self.movetracker = 1;
	self.var_1905 = 0;
	var_00 = getentarray(self.target,"targetname");
	precachemodel("com_two_light_fixture_off");
	precachemodel("com_two_light_fixture_on");
	foreach(var_02 in var_00)
	{
		var_02.lightrigs = [];
		var_03 = getent(var_02.target,"targetname");
		if(!isdefined(var_03.target))
		{
			continue;
		}

		var_02.lightrigs = getentarray(var_03.target,"targetname");
	}

	for(;;)
	{
		self waittill("trigger_enter");
		while(func_1930(self))
		{
			var_05 = 0;
			foreach(var_07 in self.touchlist)
			{
				if(isdefined(var_07.distmoved) && var_07.distmoved > 5)
				{
					var_05 = 1;
				}
			}

			if(var_05)
			{
				if(!self.var_1905)
				{
					self.var_1905 = 1;
					var_00[0] playsound("switch_auto_lights_on");
					foreach(var_02 in var_00)
					{
						var_02 setlightintensity(1);
						if(isdefined(var_02.lightrigs))
						{
							foreach(var_0B in var_02.lightrigs)
							{
								var_0B setmodel("com_two_light_fixture_on");
							}
						}
					}
				}

				thread motion_light_timeout(var_00,10);
			}

			wait 0.05;
		}
	}
}

//Function Number: 38
motion_light_timeout(param_00,param_01)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait param_01;
	foreach(var_03 in param_00)
	{
		var_03 setlightintensity(0);
		if(isdefined(var_03.lightrigs))
		{
			foreach(var_05 in var_03.lightrigs)
			{
				var_05 setmodel("com_two_light_fixture_off");
			}
		}
	}

	param_00[0] playsound("switch_auto_lights_off");
	self.var_1905 = 0;
}

//Function Number: 39
outdoor_motion_dlight()
{
	if(!isdefined(level.var_190B))
	{
		level.var_190B = loadfx("misc/outdoor_motion_light");
	}

	level endon("game_ended");
	self.movetracker = 1;
	self.var_1905 = 0;
	var_00 = getent(self.target,"targetname");
	var_01 = getentarray(var_00.target,"targetname");
	precachemodel("com_two_light_fixture_off");
	precachemodel("com_two_light_fixture_on");
	for(;;)
	{
		self waittill("trigger_enter");
		while(func_1930(self))
		{
			var_02 = 0;
			foreach(var_04 in self.touchlist)
			{
				if(isdefined(var_04.distmoved) && var_04.distmoved > 5)
				{
					var_02 = 1;
				}
			}

			if(var_02)
			{
				if(!self.var_1905)
				{
					self.var_1905 = 1;
					var_00 playsound("switch_auto_lights_on");
					var_00 setmodel("com_two_light_fixture_on");
					foreach(var_07 in var_01)
					{
						var_07.lightent = spawn("script_model",var_07.origin);
						var_07.lightent setmodel("tag_origin");
						playfxontag(level.var_190B,var_07.lightent,"tag_origin");
					}
				}

				thread outdoor_motion_dlight_timeout(var_00,var_01,10);
			}

			wait 0.05;
		}
	}
}

//Function Number: 40
outdoor_motion_dlight_timeout(param_00,param_01,param_02)
{
	self notify("motion_light_timeout");
	self endon("motion_light_timeout");
	wait param_02;
	foreach(var_04 in param_01)
	{
		var_04.lightent delete();
	}

	param_00 playsound("switch_auto_lights_off");
	param_00 setmodel("com_two_light_fixture_off");
	self.var_1905 = 0;
}

//Function Number: 41
dog_bark()
{
	level endon("game_ended");
	self.movetracker = 1;
	var_00 = getent(self.target,"targetname");
	for(;;)
	{
		self waittill("trigger_enter",var_01);
		while(func_1930(self))
		{
			var_02 = 0;
			foreach(var_04 in self.touchlist)
			{
				if(isdefined(var_04.distmoved) && var_04.distmoved > var_02)
				{
					var_02 = var_04.distmoved;
				}
			}

			if(var_02 > 6)
			{
				var_00 playsound("dyn_anml_dog_bark");
				wait randomfloatrange(16 / var_02,16 / var_02 + randomfloat(1));
				continue;
			}

			wait 0.05;
		}
	}
}

//Function Number: 42
trigger_door()
{
	var_00 = getent(self.target,"targetname");
	self.var_1910 = var_00;
	self.doorangle = getvectorrightangle(vectornormalize(self getorigin() - var_00 getorigin()));
	var_00.baseyaw = var_00.angles[1];
	var_01 = 1;
	for(;;)
	{
		self waittill("trigger_enter",var_02);
		var_00 thread func_1913(var_01,func_1915(var_02));
		if(func_1930(self))
		{
			self waittill("trigger_empty");
		}

		wait 3;
		if(func_1930(self))
		{
			self waittill("trigger_empty");
		}

		var_00 thread func_1914(var_01);
	}
}

//Function Number: 43
func_1913(param_00,param_01)
{
	if(param_01)
	{
		self rotateto((0,self.baseyaw + 90,1),param_00,0.1,0.75);
	}
	else
	{
		self rotateto((0,self.baseyaw - 90,1),param_00,0.1,0.75);
	}

	self playsound("door_generic_house_open");
	wait param_00 + 0.05;
}

//Function Number: 44
func_1914(param_00)
{
	self rotateto((0,self.baseyaw,1),param_00);
	self playsound("door_generic_house_close");
	wait param_00 + 0.05;
}

//Function Number: 45
func_1915(param_00)
{
	return vectordot(self.doorangle,vectornormalize(param_00.origin - self.var_1910 getorigin())) > 0;
}

//Function Number: 46
getvectorrightangle(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 47
use_toggle()
{
	if(self.classname != "trigger_use_touch")
	{
		return;
	}

	var_00 = getentarray(self.target,"targetname");
	self.var_1905 = 1;
	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(1.5 * self.var_1905);
	}

	for(;;)
	{
		self waittill("trigger");
		self.var_1905 = !self.var_1905;
		if(self.var_1905)
		{
			foreach(var_02 in var_00)
			{
				var_02 setlightintensity(1.5);
			}

			self playsound("switch_auto_lights_on");
			continue;
		}

		foreach(var_02 in var_00)
		{
			var_02 setlightintensity(0);
		}

		self playsound("switch_auto_lights_off");
	}
}

//Function Number: 48
bird_startle()
{
}

//Function Number: 49
func_1918(param_00)
{
	self.copier = get_photo_copier(param_00);
	var_01 = getent(self.copier.target,"targetname");
	var_02 = getent(var_01.target,"targetname");
	var_02.intensity = var_02 getlightintensity();
	var_02 setlightintensity(0);
	param_00.copy_bar = var_01;
	param_00.var_191B = var_01.origin;
	param_00.light = var_02;
	var_03 = self.copier.angles + (0,90,0);
	var_04 = anglestoforward(var_03);
	param_00.end_pos = param_00.var_191B + var_04 * 30;
}

//Function Number: 50
get_photo_copier(param_00)
{
	if(!isdefined(param_00.target))
	{
		var_01 = getentarray("destructible_toy","targetname");
		var_02 = var_01[0];
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04.destructible_type) && var_04.destructible_type == "toy_copier")
			{
				if(distance(param_00.origin,var_02.origin) > distance(param_00.origin,var_04.origin))
				{
					var_02 = var_04;
				}
			}
		}
	}
	else
	{
		var_02 = getent(var_02.target,"targetname");
		var_02 setcandamage(1);
	}

	return var_02;
}

//Function Number: 51
waittill_copier_copies()
{
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	self waittill("trigger_enter");
}

//Function Number: 52
photo_copier()
{
	level endon("game_ended");
	func_1918(self);
	self.copier endon("FX_State_Change0");
	thread func_1925();
	for(;;)
	{
		waittill_copier_copies();
		self playsound("mach_copier_run");
		if(isdefined(self.copy_bar))
		{
			reset_copier(self);
			thread photo_copier_copy_bar_goes();
			thread photo_copier_light_on();
		}

		wait 3;
	}
}

//Function Number: 53
photo_copier_no_light()
{
	level endon("game_ended");
	self endon("death");
	if(common_scripts\utility::get_template_level() == "hamburg")
	{
		return;
	}

	self.copier = get_photo_copier(self);
	self.copier endon("FX_State_Change0");
	for(;;)
	{
		waittill_copier_copies();
		self playsound("mach_copier_run");
		wait 3;
	}
}

//Function Number: 54
reset_copier(param_00)
{
	param_00.copy_bar moveto(param_00.var_191B,0.2);
	param_00.light setlightintensity(0);
}

//Function Number: 55
photo_copier_copy_bar_goes()
{
	self.copier notify("bar_goes");
	self.copier endon("bar_goes");
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	var_00 = self.copy_bar;
	wait 2;
	var_00 moveto(self.end_pos,1.6);
	wait 1.8;
	var_00 moveto(self.var_191B,1.6);
	wait 1.6;
	var_01 = self.light;
	var_02 = 0.2;
	var_03 = var_02 / 0.05;
	for(var_04 = 0;var_04 < var_03;var_04++)
	{
		var_05 = var_04 * 0.05;
		var_05 = var_05 / var_02;
		var_05 = 1 - var_05 * var_01.intensity;
		if(var_05 > 0)
		{
			var_01 setlightintensity(var_05);
		}

		wait 0.05;
	}
}

//Function Number: 56
photo_copier_light_on()
{
	self.copier notify("light_on");
	self.copier endon("light_on");
	self.copier endon("FX_State_Change0");
	self.copier endon("death");
	var_00 = self.light;
	var_01 = 0.2;
	var_02 = var_01 / 0.05;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_03 * 0.05;
		var_04 = var_04 / var_01;
		var_00 setlightintensity(var_04 * var_00.intensity);
		wait 0.05;
	}

	photo_light_flicker(var_00);
}

//Function Number: 57
func_1925()
{
	self.copier waittill("FX_State_Change0");
	self.copier endon("death");
	reset_copier(self);
}

//Function Number: 58
photo_light_flicker(param_00)
{
	param_00 setlightintensity(1);
	wait 0.05;
	param_00 setlightintensity(0);
	wait 0.1;
	param_00 setlightintensity(1);
	wait 0.05;
	param_00 setlightintensity(0);
	wait 0.1;
	param_00 setlightintensity(1);
}

//Function Number: 59
fan_blade_rotate(param_00)
{
	var_01 = 0;
	var_02 = 20000;
	var_03 = 1;
	if(isdefined(self.speed))
	{
		var_03 = self.speed;
	}

	if(param_00 == "slow")
	{
		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed")
		{
			var_01 = 180;
		}
		else
		{
			var_01 = randomfloatrange(100 * var_03,360 * var_03);
		}
	}
	else if(param_00 == "fast")
	{
		var_01 = randomfloatrange(720 * var_03,1000 * var_03);
	}
	else if(param_00 == "veryslow")
	{
		var_01 = randomfloatrange(1 * var_03,2 * var_03);
	}
	else
	{
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "lockedspeed")
	{
		wait 0;
	}
	else
	{
		wait randomfloatrange(0,1);
	}

	var_04 = self.angles;
	var_05 = anglestoright(self.angles) * 100;
	var_05 = vectornormalize(var_05);
	for(;;)
	{
		var_06 = abs(vectordot(var_05,(1,0,0)));
		var_07 = abs(vectordot(var_05,(0,1,0)));
		var_08 = abs(vectordot(var_05,(0,0,1)));
		if(var_06 > 0.9)
		{
			self rotatevelocity((var_01,0,0),var_02);
		}
		else if(var_07 > 0.9)
		{
			self rotatevelocity((var_01,0,0),var_02);
		}
		else if(var_08 > 0.9)
		{
			self rotatevelocity((0,var_01,0),var_02);
		}
		else
		{
			self rotatevelocity((0,var_01,0),var_02);
		}

		wait var_02;
	}
}

//Function Number: 60
triggertouchthink(param_00,param_01)
{
	level endon("game_ended");
	self.entnum = self getentitynumber();
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02) && !isdefined(var_02.var_1929))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.touchtriggers[self.entnum]))
		{
			var_02 thread playertouchtriggerthink(self,param_00,param_01);
		}
	}
}

//Function Number: 61
playertouchtriggerthink(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		self endon("death");
	}

	if(!common_scripts\utility::issp())
	{
		var_03 = self.guid;
	}
	else
	{
		var_03 = "player" + gettime();
	}

	param_00.touchlist[var_03] = self;
	if(isdefined(param_00.movetracker))
	{
		self.movetrackers++;
	}

	param_00 notify("trigger_enter",self);
	self notify("trigger_enter",param_00);
	if(isdefined(param_01))
	{
		self thread [[ param_01 ]](param_00);
	}

	self.touchtriggers[param_00.entnum] = param_00;
	while(isalive(self) && self istouching(param_00) && common_scripts\utility::issp() || !level.gameended)
	{
		wait 0.05;
	}

	if(isdefined(self))
	{
		self.touchtriggers[param_00.entnum] = undefined;
		if(isdefined(param_00.movetracker))
		{
			self.movetrackers--;
		}

		self notify("trigger_leave",param_00);
		if(isdefined(param_02))
		{
			self thread [[ param_02 ]](param_00);
		}
	}

	if(!common_scripts\utility::issp() && level.gameended)
	{
		return;
	}

	param_00.touchlist[var_03] = undefined;
	param_00 notify("trigger_leave",self);
	if(!func_1930(param_00))
	{
		param_00 notify("trigger_empty");
	}
}

//Function Number: 62
movementtracker()
{
	if(isdefined(level.disablemovementtracker))
	{
		return;
	}

	self endon("disconnect");
	if(!isplayer(self))
	{
		self endon("death");
	}

	self.movetrackers = 0;
	self.distmoved = 0;
	for(;;)
	{
		self waittill("trigger_enter");
		var_00 = self.origin;
		while(self.movetrackers)
		{
			self.distmoved = distance(var_00,self.origin);
			var_00 = self.origin;
			wait 0.05;
		}

		self.distmoved = 0;
	}
}

//Function Number: 63
func_1930(param_00)
{
	return param_00.touchlist.size;
}

//Function Number: 64
func_1931(param_00,param_01)
{
	return isdefined(param_00.touchtriggers[param_01.entnum]);
}