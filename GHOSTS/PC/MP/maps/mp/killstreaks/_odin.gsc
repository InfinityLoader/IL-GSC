/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_odin.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 842 ms
 * Timestamp: 10/27/2023 1:21:20 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["odin_support"] = ::func_8443;
	level.killstreakfuncs["odin_assault"] = ::func_8443;
	level._effect["odin_clouds"] = loadfx("vfx/gameplay/mp/killstreaks/odin/odin_parallax_clouds");
	level._effect["odin_fisheye"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_odin_fisheye");
	level._effect["odin_targeting"] = loadfx("vfx/gameplay/mp/killstreaks/odin/vfx_marker_odin_cyan");
	level.odinsettings = [];
	level.odinsettings["odin_support"] = spawnstruct();
	level.odinsettings["odin_support"].timeout = 60;
	level.odinsettings["odin_support"].streakname = "odin_support";
	level.odinsettings["odin_support"].vehicleinfo = "odin_mp";
	level.odinsettings["odin_support"].modelbase = "vehicle_odin_mp";
	level.odinsettings["odin_support"].teamsplash = "used_odin_support";
	level.odinsettings["odin_support"].votimedout = "odin_gone";
	level.odinsettings["odin_support"].vokillsingle = "odin_target_killed";
	level.odinsettings["odin_support"].vokillmulti = "odin_targets_killed";
	level.odinsettings["odin_support"].ui_num = 1;
	level.odinsettings["odin_support"].unavailable_string = &"KILLSTREAKS_ODIN_UNAVAILABLE";
	level.odinsettings["odin_support"].weapon["airdrop"] = spawnstruct();
	level.odinsettings["odin_support"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
	level.odinsettings["odin_support"].weapon["airdrop"].rumble = "smg_fire";
	level.odinsettings["odin_support"].weapon["airdrop"].ammoomnvar = "ui_odin_airdrop_ammo";
	level.odinsettings["odin_support"].weapon["airdrop"].airdroptype = "airdrop_support";
	level.odinsettings["odin_support"].weapon["airdrop"].reloadtimer = 20;
	level.odinsettings["odin_support"].weapon["airdrop"].ui_num_fired = -1;
	level.odinsettings["odin_support"].weapon["airdrop"].voairdrop = "odin_carepackage";
	level.odinsettings["odin_support"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
	level.odinsettings["odin_support"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";
	level.odinsettings["odin_support"].weapon["marking"] = spawnstruct();
	level.odinsettings["odin_support"].weapon["marking"].projectile = "odin_projectile_marking_mp";
	level.odinsettings["odin_support"].weapon["marking"].rumble = "heavygun_fire";
	level.odinsettings["odin_support"].weapon["marking"].ammoomnvar = "ui_odin_marking_ammo";
	level.odinsettings["odin_support"].weapon["marking"].reloadtimer = 4;
	level.odinsettings["odin_support"].weapon["marking"].ui_num_fired = -1;
	level.odinsettings["odin_support"].weapon["marking"].vomarking = "odin_marking";
	level.odinsettings["odin_support"].weapon["marking"].vomarkedsingle = "odin_marked";
	level.odinsettings["odin_support"].weapon["marking"].vomarkedmulti = "odin_m_marked";
	level.odinsettings["odin_support"].weapon["marking"].plr_ready_sound = "odin_flash_ready";
	level.odinsettings["odin_support"].weapon["marking"].plr_fire_sound = "odin_flash_launch";
	level.odinsettings["odin_support"].weapon["smoke"] = spawnstruct();
	level.odinsettings["odin_support"].weapon["smoke"].projectile = "odin_projectile_smoke_mp";
	level.odinsettings["odin_support"].weapon["smoke"].rumble = "smg_fire";
	level.odinsettings["odin_support"].weapon["smoke"].ammoomnvar = "ui_odin_smoke_ammo";
	level.odinsettings["odin_support"].weapon["smoke"].reloadtimer = 7;
	level.odinsettings["odin_support"].weapon["smoke"].ui_num_fired = -1;
	level.odinsettings["odin_support"].weapon["smoke"].vosmoke = "odin_smoke";
	level.odinsettings["odin_support"].weapon["smoke"].plr_ready_sound = "odin_smoke_ready";
	level.odinsettings["odin_support"].weapon["smoke"].plr_fire_sound = "odin_smoke_launch";
	level.odinsettings["odin_support"].weapon["juggernaut"] = spawnstruct();
	level.odinsettings["odin_support"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
	level.odinsettings["odin_support"].weapon["juggernaut"].rumble = "heavygun_fire";
	level.odinsettings["odin_support"].weapon["juggernaut"].ammoomnvar = "ui_odin_juggernaut_ammo";
	level.odinsettings["odin_support"].weapon["juggernaut"].juggtype = "juggernaut_recon";
	level.odinsettings["odin_support"].weapon["juggernaut"].reloadtimer = level.odinsettings["odin_support"].timeout;
	level.odinsettings["odin_support"].weapon["juggernaut"].ui_num_fired = -1;
	level.odinsettings["odin_support"].weapon["juggernaut"].ui_num_move = -2;
	level.odinsettings["odin_support"].weapon["juggernaut"].ui_num_dead = -3;
	level.odinsettings["odin_support"].weapon["juggernaut"].vojugg = "odin_moving";
	level.odinsettings["odin_support"].weapon["juggernaut"].plr_ready_sound = "null";
	level.odinsettings["odin_support"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";
	level.odinsettings["odin_assault"] = spawnstruct();
	level.odinsettings["odin_assault"].timeout = 60;
	level.odinsettings["odin_assault"].streakname = "odin_assault";
	level.odinsettings["odin_assault"].vehicleinfo = "odin_mp";
	level.odinsettings["odin_assault"].modelbase = "vehicle_odin_mp";
	level.odinsettings["odin_assault"].teamsplash = "used_odin_assault";
	level.odinsettings["odin_assault"].votimedout = "loki_gone";
	level.odinsettings["odin_assault"].vokillsingle = "odin_target_killed";
	level.odinsettings["odin_assault"].vokillmulti = "odin_targets_killed";
	level.odinsettings["odin_assault"].ui_num = 2;
	level.odinsettings["odin_assault"].unavailable_string = &"KILLSTREAKS_LOKI_UNAVAILABLE";
	level.odinsettings["odin_assault"].weapon["airdrop"] = spawnstruct();
	level.odinsettings["odin_assault"].weapon["airdrop"].projectile = "odin_projectile_airdrop_mp";
	level.odinsettings["odin_assault"].weapon["airdrop"].rumble = "smg_fire";
	level.odinsettings["odin_assault"].weapon["airdrop"].ammoomnvar = "ui_odin_airdrop_ammo";
	level.odinsettings["odin_assault"].weapon["airdrop"].airdroptype = "airdrop_assault";
	level.odinsettings["odin_assault"].weapon["airdrop"].reloadtimer = 20;
	level.odinsettings["odin_assault"].weapon["airdrop"].ui_num_fired = -1;
	level.odinsettings["odin_assault"].weapon["airdrop"].voairdrop = "odin_carepackage";
	level.odinsettings["odin_assault"].weapon["airdrop"].plr_ready_sound = "odin_carepack_ready";
	level.odinsettings["odin_assault"].weapon["airdrop"].plr_fire_sound = "odin_carepack_launch";
	level.odinsettings["odin_assault"].weapon["large_rod"] = spawnstruct();
	level.odinsettings["odin_assault"].weapon["large_rod"].projectile = "odin_projectile_large_rod_mp";
	level.odinsettings["odin_assault"].weapon["large_rod"].rumble = "heavygun_fire";
	level.odinsettings["odin_assault"].weapon["large_rod"].ammoomnvar = "ui_odin_marking_ammo";
	level.odinsettings["odin_assault"].weapon["large_rod"].reloadtimer = 4;
	level.odinsettings["odin_assault"].weapon["large_rod"].ui_num_fired = -2;
	level.odinsettings["odin_assault"].weapon["large_rod"].plr_ready_sound = "null";
	level.odinsettings["odin_assault"].weapon["large_rod"].plr_fire_sound = "ac130_105mm_fire";
	level.odinsettings["odin_assault"].weapon["large_rod"].npc_fire_sound = "ac130_105mm_fire_npc";
	level.odinsettings["odin_assault"].weapon["small_rod"] = spawnstruct();
	level.odinsettings["odin_assault"].weapon["small_rod"].projectile = "odin_projectile_small_rod_mp";
	level.odinsettings["odin_assault"].weapon["small_rod"].rumble = "smg_fire";
	level.odinsettings["odin_assault"].weapon["small_rod"].ammoomnvar = "ui_odin_smoke_ammo";
	level.odinsettings["odin_assault"].weapon["small_rod"].reloadtimer = 2;
	level.odinsettings["odin_assault"].weapon["small_rod"].ui_num_fired = -2;
	level.odinsettings["odin_assault"].weapon["small_rod"].plr_ready_sound = "null";
	level.odinsettings["odin_assault"].weapon["small_rod"].plr_fire_sound = "ac130_40mm_fire";
	level.odinsettings["odin_assault"].weapon["small_rod"].npc_fire_sound = "ac130_40mm_fire_npc";
	level.odinsettings["odin_assault"].weapon["juggernaut"] = spawnstruct();
	level.odinsettings["odin_assault"].weapon["juggernaut"].projectile = "odin_projectile_smoke_mp";
	level.odinsettings["odin_assault"].weapon["juggernaut"].rumble = "heavygun_fire";
	level.odinsettings["odin_assault"].weapon["juggernaut"].ammoomnvar = "ui_odin_juggernaut_ammo";
	level.odinsettings["odin_assault"].weapon["juggernaut"].juggtype = "juggernaut";
	level.odinsettings["odin_assault"].weapon["juggernaut"].reloadtimer = level.odinsettings["odin_assault"].timeout;
	level.odinsettings["odin_assault"].weapon["juggernaut"].ui_num_fired = -1;
	level.odinsettings["odin_assault"].weapon["juggernaut"].ui_num_move = -2;
	level.odinsettings["odin_assault"].weapon["juggernaut"].ui_num_dead = -3;
	level.odinsettings["odin_assault"].weapon["juggernaut"].vojugg = "odin_moving";
	level.odinsettings["odin_assault"].weapon["juggernaut"].plr_ready_sound = "null";
	level.odinsettings["odin_assault"].weapon["juggernaut"].plr_fire_sound = "odin_jugg_launch";
	if(!isdefined(level.heli_pilot_mesh))
	{
		level.heli_pilot_mesh = getent("heli_pilot_mesh","targetname");
		if(!isdefined(level.heli_pilot_mesh))
		{
		}
		else
		{
			level.heli_pilot_mesh.origin = level.heli_pilot_mesh.origin + maps\mp\_utility::gethelipilotmeshoffset();
		}
	}

	maps/mp/agents/_agents::func_8AB5();
	level.agent_funcs["odin_juggernaut"] = level.agent_funcs["player"];
	level.agent_funcs["odin_juggernaut"]["think"] = ::common_scripts\utility::empty_init_func;
	level.odin_marking_flash_radius_max = 800;
	level.odin_marking_flash_radius_min = 200;
	level.active_odin = [];
}

//Function Number: 2
func_8443(param_00,param_01)
{
	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}

	var_02 = param_01;
	var_03 = 1;
	if(maps\mp\_utility::func_21E7() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_03 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	if(isdefined(level.active_odin[var_02]))
	{
		self iprintlnbold(level.odinsettings[var_02].unavailable_string);
		return 0;
	}

	maps\mp\_utility::func_4487();
	var_04 = func_210D(var_02);
	if(!isdefined(var_04))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	var_05 = func_7AEA(var_04);
	if(!isdefined(var_05))
	{
		var_05 = 0;
	}

	return var_05;
}

//Function Number: 3
watchhostmigrationfinishedinit(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_00 endon("killstreak_disowned");
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("host_migration_end");
		param_00 setclientomnvar("ui_odin",level.odinsettings[self.odintype].ui_num);
		param_00 thermalvisionfofoverlayon();
		playfxontag(level._effect["odin_targeting"],self.targeting_marker,"tag_origin");
		self.targeting_marker showtoplayer(param_00);
	}
}

//Function Number: 4
func_210D(param_00)
{
	var_01 = self.origin * (1,1,0) + level.heli_pilot_mesh.origin - maps\mp\_utility::gethelipilotmeshoffset() * (0,0,1);
	var_02 = (0,0,0);
	var_03 = spawnhelicopter(self,var_01,var_02,level.odinsettings[param_00].vehicleinfo,level.odinsettings[param_00].modelbase);
	if(!isdefined(var_03))
	{
	}

	var_03.speed = 40;
	var_03.owner = self;
	var_03.team = self.team;
	var_03.odintype = param_00;
	level.active_odin[param_00] = 1;
	self.odin = var_03;
	var_03 thread func_583C();
	var_03 thread func_5843();
	var_03 thread func_583F();
	var_03 thread func_5841();
	var_03 thread func_5842();
	var_03 thread func_583D();
	var_03 thread odin_watchoutlines();
	var_03 thread func_5840();
	var_03 thread func_5800();
	var_03 thread func_5827();
	var_03.owner maps\mp\_matchdata::func_4F1D(level.odinsettings[param_00].streakname,var_01);
	return var_03;
}

//Function Number: 5
func_7AEA(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	self.restoreangles = vectortoangles(anglestoforward(self.angles));
	func_5832(param_00);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(0);
	}

	thread func_8CFB(param_00);
	maps\mp\_utility::func_350E(1);
	odin_zoom_up(param_00);
	thread maps\mp\killstreaks\_juggernaut::func_27B1();
	var_01 = maps\mp\killstreaks\_killstreaks::func_4649(param_00.odintype);
	if(var_01 != "success")
	{
		if(isdefined(self.disabledweapon) && self.disabledweapon)
		{
			common_scripts\utility::_enableweapon();
		}

		param_00 notify("death");
		return 0;
	}

	maps\mp\_utility::func_350E(0);
	self remotecontrolvehicle(param_00);
	param_00 thread watchhostmigrationfinishedinit(self);
	param_00.odin_overlay_ent = spawnfxforclient(level._effect["odin_fisheye"],self geteye(),self);
	triggerfx(param_00.odin_overlay_ent);
	param_00.odin_overlay_ent setfxkilldefondelete();
	level thread maps\mp\_utility::func_7FA0(level.odinsettings[param_00.odintype].teamsplash,self);
	self thermalvisionfofoverlayon();
	thread waitandoutlineowner(param_00);
	return 1;
}

//Function Number: 6
waitandoutlineowner(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	wait(1);
	var_01 = maps\mp\_utility::func_5A44(self,"cyan",self,0,"killstreak");
	param_00 thread func_65A4(var_01,self);
}

//Function Number: 7
odin_zoom_up(param_00)
{
	var_01 = spawn("script_model",param_00.origin + (0,0,3000));
	var_01.angles = vectortoangles((0,0,1));
	var_01 setmodel("tag_origin");
	var_01 thread func_8ACD(5);
	var_02 = "odin_zoom_up";
	var_03 = var_01 getentitynumber();
	var_04 = self getentitynumber();
	var_05 = bullettrace(self.origin,param_00.origin,0,self);
	if(var_05["surfacetype"] != "none")
	{
		var_02 = "odin_zoom_down";
		var_03 = param_00 getentitynumber();
		var_04 = var_01 getentitynumber();
	}

	var_06 = common_scripts\utility::array_add(maps\mp\_utility::func_3959(),self);
	foreach(var_08 in var_06)
	{
		var_08 setclientomnvar("cam_scene_name",var_02);
		var_08 setclientomnvar("cam_scene_lead",var_03);
		var_08 setclientomnvar("cam_scene_support",var_04);
		var_08 thread clouds();
	}
}

//Function Number: 8
func_8ACD(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	self delete();
}

//Function Number: 9
clouds()
{
	level endon("game_ended");
	var_00 = spawn("script_model",self.origin + (0,0,250));
	var_00.angles = vectortoangles((0,0,1));
	var_00 setmodel("tag_origin");
	var_00 thread func_8ACD(2);
	wait(0.1);
	playfxontagforclients(level._effect["odin_clouds"],var_00,"tag_origin",self);
}

//Function Number: 10
func_5832(param_00)
{
	maps\mp\_utility::func_720F(param_00.odintype);
	self.odin = param_00;
}

//Function Number: 11
odin_clear_using(param_00)
{
	param_00.odin_juggernautusetime = undefined;
	param_00.odin_markingusetime = undefined;
	param_00.odin_smokeusetime = undefined;
	param_00.odin_airdropusetime = undefined;
	param_00.odin_largerodusetime = undefined;
	param_00.odin_smallrodusetime = undefined;
	if(isdefined(self))
	{
		maps\mp\_utility::func_1D59();
		self.odin = undefined;
	}
}

//Function Number: 12
func_8CFB(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	param_00 endon("death");
	self waittill("intro_cleared");
	self setclientomnvar("ui_odin",level.odinsettings[param_00.odintype].ui_num);
	func_8CDE(param_00);
}

//Function Number: 13
odin_waitfordonefiring(param_00)
{
	while(isdefined(self.is_firing) && param_00 > 0)
	{
		wait(0.05);
		param_00 = param_00 - 0.05;
	}
}

//Function Number: 14
func_583C()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	if(isdefined(self.owner))
	{
		self.owner func_5804(self);
	}

	cleanup_ents();
	odin_waitfordonefiring(3);
	maps\mp\_utility::decrementfauxvehiclecount();
	level.active_odin[self.odintype] = undefined;
	self delete();
}

//Function Number: 15
func_5843()
{
	level endon("game_ended");
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	var_00 = level.odinsettings[self.odintype];
	var_01 = var_00.timeout;
	maps\mp\gametypes\_hostmigration::func_8B0D(var_01);
	thread odin_leave();
}

//Function Number: 16
func_583F()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::func_8B2A("disconnect","joined_team","joined_spectators");
	thread odin_leave();
}

//Function Number: 17
func_583D()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level waittill("objective_cam");
	thread odin_leave();
}

//Function Number: 18
func_5841()
{
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread odin_leave();
}

//Function Number: 19
odin_leave()
{
	self endon("death");
	self notify("leaving");
	var_00 = level.odinsettings[self.odintype];
	maps\mp\_utility::func_4D30(var_00.votimedout);
	if(isdefined(self.owner))
	{
		self.owner func_5804(self);
	}

	self notify("gone");
	cleanup_ents();
	odin_waitfordonefiring(3);
	maps\mp\_utility::decrementfauxvehiclecount();
	level.active_odin[self.odintype] = undefined;
	self delete();
}

//Function Number: 20
func_5804(param_00)
{
	if(isdefined(param_00))
	{
		self setclientomnvar("ui_odin",-1);
		param_00 notify("end_remote");
		self notify("odin_ride_ended");
		odin_clear_using(param_00);
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::func_70E6(1);
		}

		self thermalvisionfofoverlayoff();
		self remotecontrolvehicleoff(param_00);
		self setplayerangles(self.restoreangles);
		thread func_580F();
		self stoplocalsound("odin_negative_action");
		self stoplocalsound("odin_positive_action");
		foreach(var_02 in level.odinsettings[param_00.odintype].weapon)
		{
			if(isdefined(var_02.plr_ready_sound))
			{
				self stoplocalsound(var_02.plr_ready_sound);
			}

			if(isdefined(var_02.plr_fire_sound))
			{
				self stoplocalsound(var_02.plr_fire_sound);
			}
		}

		if(isdefined(param_00.juggernaut))
		{
			param_00.juggernaut maps/mp/bots/_bots_strategy::bot_guard_player(self,350);
		}
	}
}

//Function Number: 21
func_580F()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	maps\mp\_utility::func_350E(1);
	wait(0.5);
	maps\mp\_utility::func_350E(0);
}

//Function Number: 22
func_5842()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = var_00 getvieworigin();
	var_02 = var_01 + anglestoforward(self gettagangles("tag_player")) * 10000;
	var_03 = bullettrace(var_01,var_02,0,self);
	var_04 = spawn("script_model",var_03["position"]);
	var_04.angles = vectortoangles((0,0,1));
	var_04 setmodel("tag_origin");
	self.targeting_marker = var_04;
	var_04 endon("death");
	var_05 = bullettrace(var_04.origin + (0,0,50),var_04.origin + (0,0,-100),0,var_04);
	var_04.origin = var_05["position"] + (0,0,50);
	var_04 hide();
	var_04 showtoplayer(var_00);
	var_04 childthread monitormarkervisibility(var_00);
	thread showfx();
	thread func_8CC3();
	thread func_8CFF();
	switch(self.odintype)
	{
		case "odin_support":
			thread watchsmokeuse();
			thread func_8D01();
			break;

		case "odin_assault":
			thread func_8D00();
			thread func_8D20();
			break;
	}

	self setotherent(var_04);
}

//Function Number: 23
monitormarkervisibility(param_00)
{
	wait(1.5);
	var_01 = [];
	for(;;)
	{
		var_02 = param_00 maps\mp\_utility::func_3959();
		foreach(var_04 in var_01)
		{
			if(!common_scripts\utility::array_contains(var_02,var_04))
			{
				var_01 = common_scripts\utility::array_remove(var_01,var_04);
				self hide();
				self showtoplayer(param_00);
			}
		}

		foreach(var_04 in var_02)
		{
			self showtoplayer(var_04);
			if(!common_scripts\utility::array_contains(var_01,var_04))
			{
				var_01 = common_scripts\utility::array_add(var_01,var_04);
				stopfxontag(level._effect["odin_targeting"],self,"tag_origin");
				wait(0.05);
				playfxontag(level._effect["odin_targeting"],self,"tag_origin");
			}
		}

		wait(0.25);
	}
}

//Function Number: 24
func_8CC3()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = level.odinsettings[self.odintype].weapon["airdrop"];
	self.odin_airdropusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("airdrop_action","+smoke");
	}

	for(;;)
	{
		var_00 waittill("airdrop_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_airdropusetime)
		{
			if(level.teambased)
			{
				maps\mp\_utility::func_4D30(var_01.voairdrop,self.team);
			}
			else
			{
				var_00 maps\mp\_utility::func_4D35(var_01.voairdrop);
			}

			self.odin_airdropusetime = odin_fireweapon("airdrop");
			var_01 = level.odinsettings[self.odintype].weapon["airdrop"];
			level thread maps\mp\killstreaks\_airdrop::func_2896(var_00,self.targeting_marker.origin,randomfloat(360),var_01.airdroptype);
		}
		else
		{
			var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1);
	}
}

//Function Number: 25
watchsmokeuse()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = level.odinsettings[self.odintype].weapon["smoke"];
	self.odin_smokeusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("smoke_action","+speed_throw");
		var_00 notifyonplayercommand("smoke_action","+ads_akimbo_accessible");
		if(!level.console)
		{
			var_00 notifyonplayercommand("smoke_action","+toggleads_throw");
		}
	}

	for(;;)
	{
		var_00 waittill("smoke_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_smokeusetime)
		{
			if(level.teambased)
			{
				maps\mp\_utility::func_4D30(var_01.vosmoke,self.team);
			}
			else
			{
				var_00 maps\mp\_utility::func_4D35(var_01.vosmoke);
			}

			self.odin_smokeusetime = odin_fireweapon("smoke");
		}
		else
		{
			var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1);
	}
}

//Function Number: 26
func_8D01()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = level.odinsettings[self.odintype].weapon["marking"];
	self.odin_markingusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("marking_action","+attack");
		var_00 notifyonplayercommand("marking_action","+attack_akimbo_accessible");
	}

	for(;;)
	{
		var_00 waittill("marking_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_markingusetime)
		{
			self.odin_markingusetime = odin_fireweapon("marking");
			thread domarkingflash(self.targeting_marker.origin + (0,0,10));
		}
		else
		{
			var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1);
	}
}

//Function Number: 27
func_8CFF()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_00 endon("juggernaut_dead");
	var_01 = level.odinsettings[self.odintype].weapon["juggernaut"];
	self.odin_juggernautusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("juggernaut_action","+frag");
	}

	for(;;)
	{
		var_00 waittill("juggernaut_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_juggernautusetime)
		{
			var_02 = func_3AE2(self.targeting_marker.origin);
			if(isdefined(var_02))
			{
				self.odin_juggernautusetime = odin_fireweapon("juggernaut");
				thread func_8AD1(var_02);
			}
			else
			{
				var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
			}
		}
		else if(isdefined(self.juggernaut))
		{
			var_02 = func_3AE1(self.targeting_marker.origin);
			if(isdefined(var_02))
			{
				var_00 maps\mp\_utility::func_4D35(var_01.vojugg);
				var_00 maps\mp\_utility::_playlocalsound("odin_positive_action");
				var_00 playrumbleonentity("pistol_fire");
				self.juggernaut maps/mp/bots/_bots_strategy::bot_protect_point(var_02.origin,128);
				var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
			}
			else
			{
				var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
			}
		}

		wait(1.1);
		if(isdefined(self.juggernaut))
		{
			var_00 setclientomnvar(var_01.ammoomnvar,var_01.ui_num_move);
		}
	}
}

//Function Number: 28
func_8D00()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = level.odinsettings[self.odintype].weapon["large_rod"];
	self.odin_largerodusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("large_rod_action","+attack");
		var_00 notifyonplayercommand("large_rod_action","+attack_akimbo_accessible");
	}

	for(;;)
	{
		var_00 waittill("large_rod_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_largerodusetime)
		{
			self.odin_largerodusetime = odin_fireweapon("large_rod");
		}
		else
		{
			var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1);
	}
}

//Function Number: 29
func_8D20()
{
	self endon("death");
	level endon("game_ended");
	var_00 = self.owner;
	var_00 endon("disconnect");
	var_01 = level.odinsettings[self.odintype].weapon["small_rod"];
	self.odin_smallrodusetime = 0;
	var_00 setclientomnvar(var_01.ammoomnvar,level.odinsettings[self.odintype].ui_num);
	if(!isai(var_00))
	{
		var_00 notifyonplayercommand("small_rod_action","+speed_throw");
		var_00 notifyonplayercommand("small_rod_action","+ads_akimbo_accessible");
		if(!level.console)
		{
			var_00 notifyonplayercommand("small_rod_action","+toggleads_throw");
		}
	}

	for(;;)
	{
		var_00 waittill("small_rod_action");
		if(isdefined(level.hostmigrationtimer))
		{
			continue;
		}

		if(!isdefined(var_00.odin))
		{
		}

		if(gettime() >= self.odin_smallrodusetime)
		{
			self.odin_smallrodusetime = odin_fireweapon("small_rod");
		}
		else
		{
			var_00 maps\mp\_utility::_playlocalsound("odin_negative_action");
		}

		wait(1);
	}
}

//Function Number: 30
odin_fireweapon(param_00)
{
	self.is_firing = 1;
	var_01 = self.owner;
	var_02 = level.odinsettings[self.odintype].weapon[param_00];
	var_03 = anglestoforward(var_01 getplayerangles());
	var_04 = self.origin + var_03 * 100;
	var_01 setclientomnvar(var_02.ammoomnvar,var_02.ui_num_fired);
	thread func_8D13(var_02);
	var_05 = self.targeting_marker.origin;
	var_06 = gettime() + var_02.reloadtimer * 1000;
	if(param_00 == "large_rod")
	{
		wait(0.5);
		var_01 playrumbleonentity(var_02.rumble);
		earthquake(0.3,1.5,self.origin,1000);
		var_01 playsoundtoplayer(var_02.plr_fire_sound,var_01);
		playsoundatpos(self.origin,var_02.npc_fire_sound);
		wait(1.5);
	}
	else if(param_00 == "small_rod")
	{
		wait(0.5);
		var_01 playrumbleonentity(var_02.rumble);
		earthquake(0.2,1,self.origin,1000);
		var_01 playsoundtoplayer(var_02.plr_fire_sound,var_01);
		playsoundatpos(self.origin,var_02.npc_fire_sound);
		wait(0.3);
	}
	else
	{
		if(isdefined(var_02.plr_fire_sound))
		{
			var_01 playsoundtoplayer(var_02.plr_fire_sound,var_01);
		}

		if(isdefined(var_02.npc_fire_sound))
		{
			playsoundatpos(self.origin,var_02.npc_fire_sound);
		}

		var_01 playrumbleonentity(var_02.rumble);
	}

	var_07 = magicbullet(var_02.projectile,var_04,var_05,var_01);
	var_07.type = "odin";
	var_07 thread func_9595(param_00);
	if(param_00 == "smoke" || param_00 == "juggernaut" || param_00 == "large_rod")
	{
		level notify("smoke",var_07,var_02.projectile);
	}

	self.is_firing = undefined;
	return var_06;
}

//Function Number: 31
func_9595(param_00)
{
	self waittill("explode",var_01);
	if(param_00 == "small_rod")
	{
		playrumbleonposition("grenade_rumble",var_01);
		earthquake(0.7,1,var_01,1000);
	}

	if(param_00 == "large_rod")
	{
		playrumbleonposition("artillery_rumble",var_01);
		earthquake(1,1,var_01,2000);
	}
}

//Function Number: 32
func_3AE2(param_00)
{
	if(!isdefined(param_00))
	{
	}

	var_01 = getnodesinradiussorted(param_00,256,0,128,"Path");
	if(!isdefined(var_01[0]))
	{
	}

	return var_01[0];
}

//Function Number: 33
func_3AE1(param_00)
{
	if(!isdefined(param_00))
	{
	}

	var_01 = getnodesinradiussorted(param_00,128,0,64,"Path");
	if(!isdefined(var_01[0]))
	{
	}

	return var_01[0];
}

//Function Number: 34
func_8AD1(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = self.owner;
	var_01 endon("disconnect");
	var_02 = self.targeting_marker.origin;
	wait(3);
	var_03 = maps/mp/agents/_agents::add_humanoid_agent("odin_juggernaut",var_01.team,"class1",param_00.origin,vectortoangles(var_02 - param_00.origin),var_01,0,0,"veteran");
	if(isdefined(var_03))
	{
		var_04 = level.odinsettings[self.odintype].weapon["juggernaut"];
		var_03 thread maps\mp\killstreaks\_juggernaut::givejuggernaut(var_04.juggtype);
		var_03 thread maps\mp\killstreaks\_agent_killstreak::func_6D9C();
		var_03 maps/mp/bots/_bots_strategy::bot_protect_point(param_00.origin,128);
		self.juggernaut = var_03;
		thread func_8CFE();
		var_01 setclientomnvar(var_04.ammoomnvar,var_04.ui_num_move);
		var_05 = maps\mp\_utility::func_5A44(var_03,"cyan",self.owner,0,"killstreak");
		thread func_65A4(var_05,var_03);
		var_03 maps\mp\_utility::_setnameplatematerial("player_name_bg_green_agent","player_name_bg_red_agent");
	}

	var_01 iprintlnbold(&"KILLSTREAKS_AGENT_MAX");
}

//Function Number: 35
func_8CFE()
{
	self endon("death");
	level endon("game_ended");
	self.juggernaut waittill("death");
	self.owner notify("juggernaut_dead");
	var_00 = level.odinsettings[self.odintype].weapon["juggernaut"];
	self.owner setclientomnvar(var_00.ammoomnvar,var_00.ui_num_dead);
	self.juggernaut = undefined;
}

//Function Number: 36
showfx()
{
	self endon("death");
	wait(1);
	playfxontag(level._effect["odin_targeting"],self.targeting_marker,"tag_origin");
}

//Function Number: 37
func_8D13(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = self.owner;
	var_01 endon("disconnect");
	var_01 endon("odin_ride_ended");
	var_02 = param_00.ammoomnvar;
	var_03 = param_00.reloadtimer;
	var_04 = param_00.plr_ready_sound;
	var_05 = level.odinsettings[self.odintype].ui_num;
	wait(var_03);
	if(!isdefined(var_01.odin))
	{
	}

	if(isdefined(var_04))
	{
		var_01 maps\mp\_utility::_playlocalsound(var_04);
	}

	var_01 setclientomnvar(var_02,var_05);
}

//Function Number: 38
domarkingflash(param_00)
{
	level endon("game_ended");
	var_01 = self.owner;
	var_02 = level.odin_marking_flash_radius_max * level.odin_marking_flash_radius_max;
	var_03 = level.odin_marking_flash_radius_min * level.odin_marking_flash_radius_min;
	var_04 = 60;
	var_05 = 40;
	var_06 = 11;
	var_07 = 0;
	foreach(var_09 in level.participants)
	{
		if(!maps\mp\_utility::func_4945(var_09) || var_09.sessionstate != "playing")
		{
			continue;
		}

		if(level.teambased && var_09.team == self.team)
		{
			continue;
		}

		var_0A = distancesquared(param_00,var_09.origin);
		if(var_0A > var_02)
		{
			continue;
		}

		var_0B = var_09 getstance();
		var_0C = var_09.origin;
		switch(var_0B)
		{
			case "stand":
				var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_04);
				break;

			case "crouch":
				var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_05);
				break;

			case "prone":
				var_0C = (var_0C[0],var_0C[1],var_0C[2] + var_06);
				break;
		}

		if(!bullettracepassed(param_00,var_0C,0,var_09))
		{
			continue;
		}

		if(var_0A <= var_03)
		{
			var_0D = 1;
		}
		else
		{
			var_0D = 1 - var_0A - var_03 / var_02 - var_03;
		}

		var_0E = anglestoforward(var_09 getplayerangles());
		var_0F = param_00 - var_0C;
		var_0F = vectornormalize(var_0F);
		var_10 = 0.5 * 1 + vectordot(var_0E,var_0F);
		var_11 = 1;
		var_09 notify("flashbang",param_00,var_0D,var_10,var_01,var_11);
		var_07++;
		if(!func_2F28(var_09))
		{
			if(level.teambased)
			{
				var_12 = maps\mp\_utility::func_5A45(var_09,"orange",self.team,0,"killstreak");
			}
			else
			{
				var_12 = maps\mp\_utility::func_5A44(var_0A,"orange",self.owner,0,"killstreak");
			}

			thread func_65A4(var_12,var_09,3);
		}
	}

	var_14 = level.odinsettings[self.odintype].weapon["marking"];
	if(var_07 == 1)
	{
		if(level.teambased)
		{
			maps\mp\_utility::func_4D30(var_14.vomarkedsingle,self.team);
		}
		else
		{
			var_01 maps\mp\_utility::func_4D35(var_14.vomarkedsingle);
		}
	}
	else if(var_07 > 1)
	{
		if(level.teambased)
		{
			maps\mp\_utility::func_4D30(var_14.vomarkedmulti,self.team);
		}
		else
		{
			var_01 maps\mp\_utility::func_4D35(var_14.vomarkedmulti);
		}
	}

	var_15 = maps\mp\gametypes\_weapons::getempdamageents(param_00,512,0);
	foreach(var_17 in var_15)
	{
		if(isdefined(var_17.owner) && !maps\mp\gametypes\_weapons::func_357F(self.owner,var_17.owner))
		{
			continue;
		}

		var_17 notify("emp_damage",self.owner,8);
	}
}

//Function Number: 39
applyoutline(param_00)
{
	if(level.teambased && param_00.team == self.team)
	{
	}
	else if(!level.teambased && param_00 == self.owner)
	{
	}

	if(func_2F28(param_00))
	{
	}

	var_01 = maps\mp\_utility::func_5A44(param_00,"orange",self.owner,1,"killstreak");
	thread func_65A4(var_01,param_00);
}

//Function Number: 40
func_2F28(param_00)
{
	return param_00 maps\mp\_utility::_hasperk("specialty_noplayertarget");
}

//Function Number: 41
func_65A4(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	level endon("game_ended");
	var_03 = ["leave","death"];
	if(isdefined(param_02))
	{
		common_scripts\utility::waittill_any_in_array_or_timeout_no_endon_death(var_03,param_02);
	}
	else
	{
		common_scripts\utility::waittill_any_in_array_return_no_endon_death(var_03);
	}

	if(isdefined(param_01))
	{
		maps\mp\_utility::func_5A40(param_00,param_01);
	}
}

//Function Number: 42
odin_watchoutlines()
{
	self endon("death");
	level endon("game_ended");
	foreach(var_01 in level.participants)
	{
		applyoutline(var_01);
	}
}

//Function Number: 43
func_5840()
{
	self endon("death");
	level endon("game_ended");
	self.enemieskilledintimewindow = 0;
	for(;;)
	{
		level waittill("odin_killed_player",var_00);
		self.enemieskilledintimewindow++;
		self notify("odin_enemy_killed");
	}
}

//Function Number: 44
func_5800(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = level.odinsettings[self.odintype];
	var_02 = 1;
	for(;;)
	{
		self waittill("odin_enemy_killed");
		wait(var_02);
		if(self.enemieskilledintimewindow > 1)
		{
			self.owner maps\mp\_utility::func_4D35(var_01.vokillmulti);
		}
		else
		{
			self.owner maps\mp\_utility::func_4D35(var_01.vokillsingle);
		}

		self.enemieskilledintimewindow = 0;
	}
}

//Function Number: 45
func_5827()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_5828(self);
	}
}

//Function Number: 46
func_5828(param_00)
{
	self endon("disconnect");
	self waittill("spawned_player");
	param_00 applyoutline(self);
}

//Function Number: 47
cleanup_ents()
{
	if(isdefined(self.targeting_marker))
	{
		self.targeting_marker delete();
	}

	if(isdefined(self.odin_overlay_ent))
	{
		self.odin_overlay_ent delete();
	}
}

//Function Number: 48
func_8CDE(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 thread maps\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit();
	param_00 waittill("killstreakExit");
	var_01 = level.odinsettings[param_00.odintype];
	maps\mp\_utility::func_4D30(var_01.votimedout);
	param_00 notify("death");
}