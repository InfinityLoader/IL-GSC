/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_util.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 71
 * Decompile Time: 959 ms
 * Timestamp: 10/27/2023 1:37:00 AM
*******************************************************************/

//Function Number: 1
move_player_to_start_point(param_00)
{
	var_01 = getent(param_00,"targetname");
	level.player setorigin(var_01.origin);
	var_02 = undefined;
	if(isdefined(var_01.target))
	{
		var_02 = getent(var_01.target,"targetname");
	}

	if(isdefined(var_02))
	{
		level.player setangles(vectortoangles(var_02.origin - var_01.origin));
		return;
	}

	level.player setangles(var_01.angles);
}

//Function Number: 2
actor_teleport(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(isplayer(param_00))
	{
		param_00 setangles(var_02.angles);
		param_00 setorigin(var_02.origin);
	}

	if(isai(param_00))
	{
		param_00 method_81FA(var_02.origin,var_02.angles);
	}
}

//Function Number: 3
func_69DE(param_00)
{
	var_01 = getent(param_00,"targetname");
	if(!isdefined(var_01))
	{
	}

	var_01 notify("trigger");
	if(var_01.classname == "trigger_once" || isdefined(var_01.spawnflags) && var_01.spawnflags & 64)
	{
		var_01 delete();
	}
}

//Function Number: 4
func_69DD(param_00)
{
	var_01 = getent(param_00,"script_noteworthy");
	if(!isdefined(var_01))
	{
	}

	var_01 notify("trigger");
	if(var_01.classname == "trigger_once" || isdefined(var_01.spawnflags) && var_01.spawnflags & 64)
	{
		var_01 delete();
	}
}

//Function Number: 5
func_800F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		var_02 = ["ALLY_ALPHA","ALLY_BRAVO","ALLY_CHARLIE","ALLY_DELTA","ALLY_ECHO"];
	}
	else
	{
		var_02 = ["ALLY_ALPHA","ALLY_BRAVO","ALLY_CHARLIE"];
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		actor_teleport(level.squad[var_02[var_03]],var_02[var_03] + "_" + param_00 + "_teleport");
		var_04 = getnode(var_02[var_03] + "_" + param_00 + "_node","targetname");
		level.squad[var_02[var_03]] method_8224(var_04);
	}
}

//Function Number: 6
func_8010(param_00,param_01)
{
	actor_teleport(level.squad[param_01],param_01 + "_" + param_00 + "_teleport");
	var_02 = getnode(param_01 + "_" + param_00 + "_node","targetname");
	level.squad[param_01] method_8224(var_02);
}

//Function Number: 7
func_69D1(param_00)
{
	func_69CE(getentarray(param_00,"targetname"));
}

//Function Number: 8
func_69D0(param_00)
{
	func_69CE(getentarray(param_00,"script_noteworthy"));
}

//Function Number: 9
func_69CD(param_00)
{
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 10
func_69CE(param_00)
{
	foreach(var_02 in param_00)
	{
		func_69CD(var_02);
	}
}

//Function Number: 11
add_debug_dialogue(param_00,param_01,param_02)
{
	if(getdvarint("loc_warnings",0))
	{
	}

	if(!isdefined(level.var_23DC))
	{
		level.var_23DC = [];
	}

	var_03 = "^3";
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "red":
			case "r":
				var_03 = "^1";
				break;

			case "green":
			case "g":
				var_03 = "^2";
				break;

			case "yellow":
			case "y":
				var_03 = "^3";
				break;

			case "blue":
			case "b":
				var_03 = "^4";
				break;

			case "cyan":
			case "c":
				var_03 = "^5";
				break;

			case "purple":
			case "p":
				var_03 = "^6";
				break;

			case "white":
			case "w":
				var_03 = "^7";
				break;

			case "black":
			case "bl":
				var_03 = "^8";
				break;
		}
	}

	var_04 = maps\_hud_util::createfontstring("default",1.5);
	var_04.location = 0;
	var_04.alignx = "left";
	var_04.aligny = "top";
	var_04.foreground = 1;
	var_04.sort = 20;
	var_04.alpha = 0;
	var_04 fadeovertime(0.5);
	var_04.alpha = 1;
	var_04.x = 40;
	var_04.y = 325;
	var_04.label = " " + var_03 + "< " + param_00 + " > ^7" + param_01;
	var_04.color = (1,1,1);
	level.var_23DC = common_scripts\utility::array_insert(level.var_23DC,var_04,0);
	foreach(var_07, var_06 in level.var_23DC)
	{
		if(var_07 == 0)
		{
			continue;
		}

		if(isdefined(var_06))
		{
			var_06.y = 325 - var_07 * 18;
		}
	}

	wait(2);
	var_08 = 40;
	var_04 fadeovertime(3);
	var_04.alpha = 0;
	for(var_07 = 0;var_07 < var_08;var_07++)
	{
		var_04.color = (1,1,0 / var_08 - var_07);
		wait(0.05);
	}

	wait(4);
	var_04 destroy();
	common_scripts\utility::array_removeundefined(level.var_23DC);
}

//Function Number: 12
func_8014()
{
	var_00 = common_scripts\utility::func_39BD();
	if(!isdefined(var_00.angles))
	{
		var_00.angles = self.angles;
	}

	self method_81FA(var_00.origin,var_00.angles);
}

//Function Number: 13
func_7805(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_03[var_03.size] = var_05 func_7806(param_01);
	}

	return var_03;
}

//Function Number: 14
spawn_odin_actor_single(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = var_02 func_7806(param_01);
	return var_03;
}

//Function Number: 15
func_7806(param_00,param_01)
{
	if(!isdefined(self))
	{
		return undefined;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = maps\_utility::func_7766(param_01);
	if(maps\_utility::func_77BE(var_02))
	{
	}

	var_02 thread maps\_space_ai::enable_space();
	var_03 = common_scripts\utility::func_39BD();
	if(isdefined(var_03))
	{
		if(!isdefined(var_03.angles))
		{
			var_03.angles = self.angles;
		}

		var_02 method_81FA(var_03.origin,var_03.angles);
	}

	if(isdefined(var_03.target))
	{
		var_02.default_node = getnode(var_03.target,"targetname");
		if(isdefined(var_02.default_node))
		{
			var_02 method_8224(var_02.default_node);
			var_02.goalradius = 4;
		}
	}

	return var_02;
}

//Function Number: 16
add_light_to_actor(param_00)
{
	var_01 = common_scripts\utility::func_7836();
	var_02 = self gettagorigin("tag_eye");
	var_01.origin = var_02 + (-9,0,2);
	var_01 linkto(self,"tag_eye");
	var_03 = common_scripts\utility::func_3AB9("light_blue_steady_FX");
	if(param_00 == "ally")
	{
		var_03 = common_scripts\utility::func_3AB9("light_blue_steady_FX");
	}

	if(param_00 == "axis")
	{
		var_03 = common_scripts\utility::func_3AB9("amber_light_45_beacon_nolight_glow");
	}

	while(isalive(self))
	{
		playfxontag(var_03,var_01,"tag_origin");
		wait(0.2);
		stopfxontag(var_03,var_01,"tag_origin");
		wait(0.8);
	}

	var_01 delete();
}

//Function Number: 17
func_6F25()
{
	function_0168("cg_fov",level.odin_fov);
	if(!common_scripts\utility::flag("spin_start_exterior_dialogue"))
	{
		maps\_utility::func_4D7C(0.05,level.odin_fov);
	}

	common_scripts\utility::flag_wait("ally_gun_struggle_FOV_change");
	maps\_utility::func_4D7C(1,level.odin_fov + 10);
	common_scripts\utility::flag_wait("saved_ally");
	maps\_utility::func_4D7C(3,level.odin_fov);
	common_scripts\utility::flag_wait("start_transition_to_youngblood");
	maps\_utility::func_4D7C(5,65);
}

//Function Number: 18
func_5EBB()
{
	level endon("kickoff_player_finale");
	if(isdefined(level.player.var_5BE1) && level.player.var_5BE1)
	{
	}

	level.player.var_5BE1 = 1;
	var_00 = 0.15;
	var_01 = 64;
	for(;;)
	{
		if(common_scripts\utility::flag("player_spin_decomp_anim_done"))
		{
			var_00 = 0.2;
			var_01 = 96;
		}

		physicsexplosionsphere(level.player.origin,var_01,1,var_00);
		wait(0.05);
	}
}

//Function Number: 19
ally_physics_pulse()
{
	level endon("kickoff_player_finale");
	if(isdefined(level.ally.var_5BE1) && level.ally.var_5BE1)
	{
	}

	level.ally.var_5BE1 = 1;
	for(;;)
	{
		physicsexplosionsphere(level.ally.origin,45,32,0.15);
		wait(0.05);
	}
}

//Function Number: 20
npc_physics_pulse()
{
	self endon("death");
	if(isdefined(self.var_5BE1) && self.var_5BE1)
	{
	}

	self.var_5BE1 = 1;
	for(;;)
	{
		physicsexplosionsphere(self.origin,45,32,0.15);
		wait(0.05);
	}
}

//Function Number: 21
func_3432(param_00,param_01)
{
	var_02 = func_7805(param_00,1);
	foreach(var_04 in var_02)
	{
		var_04.var_5613 = 1;
		var_04.ignoreall = 1;
		var_04.ignoreme = 1;
		var_04.var_29AA = 1;
		var_04.team = "neutral";
		var_04.diequietly = 1;
		var_04.var_5629 = 1;
		var_04.var_563A = 1;
		var_04.forceragdollimmediate = 1;
		var_04.var_757F = 1;
	}

	wait(1);
	if(isdefined(param_01))
	{
		common_scripts\utility::flag_wait(param_01);
	}

	foreach(var_04 in var_02)
	{
		var_04 method_82E7();
	}
}

//Function Number: 22
load_transient(param_00)
{
	function_020B();
	devsetminimapdvarsettings(param_00);
}

//Function Number: 23
func_7E26()
{
	while(!function_020C())
	{
		wait(0.05);
	}
}

//Function Number: 24
func_54DA(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = getentarray(param_00,"script_noteworthy");
	foreach(var_06 in var_04)
	{
		if(var_06.script_parameters == "moving_object_origin")
		{
			var_03 = var_06;
		}
	}

	foreach(var_06 in var_04)
	{
		if(var_06.script_parameters == "moving_object")
		{
			var_06 linkto(var_03);
		}

		if(var_06.script_parameters == "path_connector")
		{
			var_06 linkto(var_03);
			var_03.var_1EBF = var_06;
		}

		if(var_06.script_parameters == "path_disconnector")
		{
			var_06 linkto(var_03);
			var_03.var_27CB = var_06;
		}
	}

	thread func_5B21(var_03.var_27CB,var_03.var_1EBF);
	return var_03;
}

//Function Number: 25
func_5B21(param_00,param_01)
{
	self endon("death");
	self endon("stop_scripts");
	var_02 = getentarray("moving_platform_path_trigger","targetname");
	var_03 = getentarray("path_connector","script_noteworthy");
	var_04 = getentarray("path_disconnector","script_noteworthy");
	for(;;)
	{
		param_00 solid();
		param_01 solid();
		param_00 disconnectpaths();
		param_01 connectpaths();
		param_00 notsolid();
		param_01 notsolid();
		wait(0.2);
	}
}

//Function Number: 26
create_sliding_space_door(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getentarray(param_00,"script_noteworthy");
	if(!isdefined(var_07) || var_07.size == 0)
	{
		iprintln("create_sliding_space_door failed. No parts");
	}

	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	foreach(var_0C in var_07)
	{
		if(var_0C.classname == "script_origin")
		{
			if(isdefined(var_0C.targetname))
			{
				if(var_0C.targetname == "door_closed_node")
				{
					var_08 = var_0C;
					continue;
				}

				if(var_0C.targetname == "door_node")
				{
					var_09 = var_0C;
					continue;
				}

				if(var_0C.targetname == "door_open_node")
				{
					var_0A = var_0C;
				}
			}
		}
	}

	var_08.door = var_09;
	var_08.var_29D0 = var_0A;
	var_08.time = param_01;
	var_08.accel = param_02;
	var_08.delay = param_03;
	var_08.var_11B6 = param_04;
	var_08.var_4ECE = param_05;
	var_08.unlock_flag = param_06;
	var_08.door_name = param_00;
	var_0E = getentarray(var_08.door.target,"targetname");
	var_08.parts = var_0E;
	foreach(var_0C in var_0E)
	{
		var_0C linkto(var_08.door);
	}

	var_08.trigger = spawn("trigger_radius",var_08.origin,3,var_08.radius,64);
	if(isdefined(param_04) && param_04 == 1)
	{
		var_08.trigger common_scripts\utility::func_837B();
		var_08 thread func_11B8();
	}
	else
	{
		var_08 thread func_75EB();
	}

	var_08 thread func_75EA();
	return var_08;
}

//Function Number: 27
func_11B8()
{
	self endon("death");
	level endon(self.var_4ECE);
	self.state = "open";
	self.trigger.var_83B7 = 0;
	self.trigger thread automatic_sliding_door_detector(self.var_4ECE);
	for(;;)
	{
		if(self.trigger.var_83B7)
		{
			if(isdefined(self.unlock_flag) && !common_scripts\utility::flag(self.unlock_flag))
			{
				wait(0.5);
				continue;
			}

			if(self.state == "closing" || self.state == "closed")
			{
				self.state = "open";
				if(self.delay > 0)
				{
					wait(self.delay);
				}

				self.door moveto(self.var_29D0.origin,self.time,self.accel);
				thread maps/odin_audio::func_72E1(self);
			}
		}
		else if(self.state == "opening" || self.state == "open")
		{
			self.state = "closed";
			if(self.delay > 0)
			{
				wait(self.delay);
			}

			self.door moveto(self.origin,self.time,self.accel);
			thread maps/odin_audio::func_72E0(self);
		}

		wait(0.1);
	}
}

//Function Number: 28
automatic_sliding_door_detector(param_00)
{
	self endon("death");
	level endon(param_00);
	for(;;)
	{
		self.var_83B7 = 0;
		self waittill("trigger");
		self.var_83B7 = 1;
		wait(0.5);
	}
}

//Function Number: 29
func_75EB()
{
	self endon("death");
	level endon(self.var_4ECE);
	if(isdefined(self.unlock_flag) && !common_scripts\utility::flag(self.unlock_flag))
	{
		self.state = "closed";
		self.door moveto(self.origin,0.1,self.accel);
		common_scripts\utility::flag_wait(self.unlock_flag);
		if(self.state == "closing" || self.state == "closed")
		{
			self.state = "open";
			if(self.delay > 0)
			{
				wait(self.delay);
			}

			self.door moveto(self.var_29D0.origin,self.time,self.accel);
			if(self.door_name == "post_z_door" || self.door_name == "escape_door_blocker")
			{
				thread maps/odin_audio::func_7290();
			}

			if(self.door_name == "spin_decomp_door")
			{
				thread maps/odin_audio::func_7277();
			}

			thread maps/odin_audio::func_72E1(self);
		}
	}
}

//Function Number: 30
func_75EA()
{
	level endon("start_transition_to_youngblood");
	self endon("death");
	level waittill(self.var_4ECE);
	self.state = "closed";
	if(self.delay > 0)
	{
		wait(self.delay);
	}

	self.door moveto(self.origin,self.time,self.accel);
	thread maps/odin_audio::func_72E0(self);
	if(isdefined(self.trigger))
	{
		self.trigger common_scripts\utility::trigger_off();
		self.trigger delete();
	}
}

//Function Number: 31
func_567D(param_00,param_01,param_02)
{
	if(param_02 > param_01)
	{
		return 1;
	}
	else if(param_02 < param_00)
	{
		return 0;
	}

	return param_02 - param_00 / param_01 - param_00;
}

//Function Number: 32
func_312A(param_00,param_01,param_02)
{
	return param_01 * param_02 + param_00 * 1 - param_02;
}

//Function Number: 33
func_1B49(param_00,param_01,param_02)
{
	var_03 = self method_8260(level.scr_anim[param_00][param_01]);
	if(var_03 >= param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
god_rays_from_moving_source(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	var_05 = maps\_utility::create_sunflare_setting("default");
	while(!common_scripts\utility::flag(param_02))
	{
		var_06 = param_00.origin;
		var_03 = atan(level.player.origin[2] - var_06[2] / sqrt(squared(level.player.origin[0] - var_06[0]) + squared(level.player.origin[1] - var_06[1])));
		if(level.player.origin[0] < var_06[0])
		{
			var_04 = atan(level.player.origin[1] - var_06[1] / level.player.origin[0] - var_06[0]);
		}
		else
		{
			var_04 = 180 + atan(level.player.origin[1] - var_06[1] / level.player.origin[0] - var_06[0]);
		}

		var_05.position = (var_03,var_04,0);
		maps\_art::func_7D49("default",0);
		wait(0.05);
	}
}

//Function Number: 35
func_461D()
{
	var_00 = func_6A53();
	var_01 = getent("sat_intro_initial_position","targetname");
	var_00 moveto(var_01.origin,0.1);
	var_00 rotateto(var_01.angles,0.1);
	var_00 waittill("movedone");
	wait(4);
	var_02 = [];
	var_02["odin_sat_section_04_pod_doorL_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_01"];
	var_02["odin_sat_section_04_pod_doorL_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_02"];
	var_02["odin_sat_section_04_pod_doorL_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_03"];
	var_02["odin_sat_section_04_pod_doorL_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorL_04"];
	var_02["odin_sat_section_04_pod_doorR_01"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_01"];
	var_02["odin_sat_section_04_pod_doorR_02"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_02"];
	var_02["odin_sat_section_04_pod_doorR_03"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_03"];
	var_02["odin_sat_section_04_pod_doorR_04"] = level.animated_sat_part["odin_sat_section_04_pod_doorR_04"];
	level thread maps\odin_fx::fx_sat_doors_close(var_02);
	level.var_57FB thread maps\_anim::anim_single(level.animated_sat_part,"sat_blossom_close");
}

//Function Number: 36
func_5561(param_00,param_01,param_02)
{
	level endon("stop_nag");
	level endon(param_01);
	var_03 = 8;
	var_04 = 20;
	var_05 = 0.5;
	var_06 = 1.5;
	if(!isdefined(param_00))
	{
		param_00 = randomizer_create(["factory_bkr_hurryuprook","factory_bkr_comeon","factory_bkr_theholdup"]);
	}
	else
	{
		param_00 = randomizer_create(param_00);
	}

	for(;;)
	{
		wait(var_03 + randomfloatrange(-2,2));
		var_07 = param_00 func_633C();
		if(isdefined(param_02))
		{
			maps\_utility::smart_radio_dialogue(var_07);
		}
		else
		{
			thread maps\_utility::func_7628(var_07);
		}

		if(var_03 < var_04)
		{
			var_03 = var_03 + randomfloatrange(var_05,var_06);
		}
	}
}

//Function Number: 37
randomizer_create(param_00)
{
	var_01 = addstruct();
	var_01.var_ED8 = param_00;
	return var_01;
}

//Function Number: 38
func_633C()
{
	var_00 = undefined;
	if(self.var_ED8.size > 1 && isdefined(self.var_4C06))
	{
		var_00 = randomint(self.var_ED8.size - 1);
		if(var_00 >= self.var_4C06)
		{
			var_00++;
		}
	}
	else
	{
		var_00 = randomint(self.var_ED8.size);
	}

	self.var_4C06 = var_00;
	return self.var_ED8[var_00];
}

//Function Number: 39
func_5562(param_00,param_01,param_02,param_03)
{
	level endon("stop_nag");
	self endon(param_01);
	var_04 = 10;
	var_05 = 20;
	var_06 = 0.5;
	var_07 = 1.5;
	param_00 = randomizer_create(param_00);
	for(;;)
	{
		wait(var_04 + randomfloatrange(-2,2));
		var_08 = param_00 func_633C();
		thread add_debug_dialogue(param_02,var_08,param_03);
		if(var_04 < var_05)
		{
			var_04 = var_04 + randomfloatrange(var_06,var_07);
		}
	}
}

//Function Number: 40
func_3407()
{
	var_00 = spawn("script_model",(0,0,0));
	var_00 setmodel("tag_origin");
	var_00 method_8021(self,"tag_flash",(0,0,0),(0,0,0),1);
	playfxontag(level._effect["flashlight"],var_00,"tag_origin");
}

//Function Number: 41
func_7D06(param_00)
{
	playfxontag(level._effect["flashlight"],param_00,"tag_light");
	common_scripts\utility::flag_wait("teleport_player_to_z_trans");
	wait(1);
	stopfxontag(level._effect["flashlight"],param_00,"tag_light");
}

//Function Number: 42
func_6A53()
{
	if(!isdefined(level.satellite_script_mover))
	{
		var_00 = getent("satellite_link_org","targetname");
		level.satellite_script_mover = var_00;
		func_7777(var_00);
		var_01 = getentarray("spacejump_sat","targetname");
		foreach(var_03 in var_01)
		{
			var_03 linkto(var_00);
			level.var_6A3F[level.var_6A3F.size] = var_03;
		}

		maps\odin_fx::func_3673();
	}

	return level.satellite_script_mover;
}

//Function Number: 43
func_7777(param_00)
{
	level.var_57FB = param_00;
	var_01 = getentarray("odin_satellite_animated","targetname");
	level.var_582F = getent("odin_sat_section_03_rot","script_noteworthy");
	level.var_6A3F[level.var_6A3F.size] = level.var_582F;
	level.var_582F.animname = "odin_sat_section_03_rot";
	level.var_582F maps\_utility::assign_animtree("odin_sat_section_03_rot");
	level.animated_sat_part = [];
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy != "odin_sat_section_03_rot")
		{
			var_03.animname = var_03.script_noteworthy;
			level.animated_sat_part[var_03.script_noteworthy] = var_03;
			level.animated_sat_part[var_03.script_noteworthy] maps\_utility::assign_animtree(var_03.script_noteworthy);
			var_03 linkto(level.var_57FB);
			level.var_6A3F[level.var_6A3F.size] = var_03;
		}
	}

	level.var_57FB maps\_anim::anim_first_frame(level.animated_sat_part,"sat_blossom_close");
	level.var_582F linkto(level.var_57FB);
	foreach(var_06 in level.animated_sat_part)
	{
		var_06 linkto(level.var_57FB);
	}

	level.var_57FB thread maps\_anim::anim_loop_solo(level.var_582F,"odin_sat_blossom_close_spin","stop_sat_loops");
	foreach(var_06 in level.animated_sat_part)
	{
		var_06 method_8252();
	}
}

//Function Number: 44
func_6A5A(param_00,param_01,param_02,param_03)
{
	var_04 = func_6A53();
	var_05 = getent(param_00,"targetname");
	if(isdefined(param_02))
	{
		var_04 moveto(var_05.origin,param_01,param_02,param_03);
	}

	var_04 moveto(var_05.origin,param_01);
}

//Function Number: 45
func_2BCF()
{
	if(!isdefined(level.var_2BD2))
	{
		var_00 = getentarray("spin_earth","targetname");
		var_01 = undefined;
		var_02 = undefined;
		foreach(var_04 in var_00)
		{
			if(var_04.classname == "script_origin")
			{
				var_01 = var_04;
				continue;
			}

			if(var_04.classname == "script_model")
			{
				var_02 = var_04;
			}
		}

		if(!isdefined(var_01))
		{
		}

		var_00 = common_scripts\utility::array_remove(var_00,var_01);
		if(isdefined(var_01.target))
		{
			foreach(var_04 in var_00)
			{
				var_04 linkto(var_01);
			}
		}

		level.var_2BD2 = var_01;
		level.var_2BD2.earth_model = var_02;
	}

	return level.var_2BD2;
}

//Function Number: 46
odin_control_player_speed()
{
	var_00 = 0;
	if(level.start_point != "default")
	{
		var_00 = 1;
	}

	switch(level.start_point)
	{
		case "default":
		case "odin_intro":
			level.var_773A = 15;
			level.var_7742 = 80;
			level.space_accel = 75;
			level.var_7748 = 65;
			level.var_7747 = 85;
			func_582E();
			common_scripts\utility::flag_wait("open_airlock_door");
			break;

		case "odin_ally":
			common_scripts\utility::flag_set("prologue_ready_for_thrusters");
			level.var_773A = 15;
			level.var_7742 = 46.66;
			level.space_accel = 75;
			level.var_7748 = 60;
			level.var_7747 = 75;
			func_582E();
			break;

		case "odin_escape":
			common_scripts\utility::flag_set("prologue_ready_for_thrusters");
			level.var_773A = 15;
			level.var_7742 = 46.66;
			level.space_accel = 75;
			level.var_7748 = 60;
			level.var_7747 = 75;
			func_582E();
			common_scripts\utility::flag_wait("ally_console_scene_done");
			level.var_7742 = 58;
			func_582E();
			common_scripts\utility::flag_wait("player_in_outside_spin");
			break;

		case "odin_spin":
			common_scripts\utility::flag_set("prologue_ready_for_thrusters");
			level.var_773A = 15;
			level.var_7742 = 70;
			level.space_accel = 75;
			level.var_7748 = 60;
			level.var_7747 = 75;
			func_582E();
			common_scripts\utility::flag_wait("spin_clear");
			break;

		case "odin_spacejump":
			common_scripts\utility::flag_set("prologue_ready_for_thrusters");
			level.var_773A = 15;
			level.var_7742 = 70;
			level.space_accel = 75;
			level.var_7748 = 60;
			level.var_7747 = 75;
			func_582E();
			common_scripts\utility::flag_wait("spacejump_clear");
			break;

		case "odin_satellite":
			common_scripts\utility::flag_set("prologue_ready_for_thrusters");
			level.var_773A = 15;
			level.var_7742 = 70;
			level.space_accel = 65;
			level.var_7748 = 55;
			level.var_7747 = 65;
			common_scripts\utility::flag_wait("triggered_finale");
			break;

		default:
			break;
	}
}

//Function Number: 47
func_582E()
{
	function_0168("player_swimFriction",level.var_773A);
	function_0168("player_swimAcceleration",level.space_accel);
	function_0168("player_swimVerticalSpeed",level.var_7748);
	function_0168("player_swimVerticalAcceleration",level.var_7747);
	function_0168("player_swimSpeed",level.var_7742);
}

//Function Number: 48
push_out_of_doorway(param_00,param_01,param_02,param_03)
{
	switch(param_00)
	{
		case "X":
		case "x":
			param_00 = 0;
			break;

		case "Y":
		case "y":
			param_00 = 1;
			break;

		default:
			break;
	}

	switch(param_01)
	{
		case ">":
			while(level.player.origin[param_00] - 32 >= level.ally.origin[param_00])
			{
				function_0168("player_swimSpeed",0);
				level.ally method_8222(0);
				function_0168("player_swimWaterCurrent",(param_02,param_03,0));
				wait(0.01);
			}
			break;

		case "<":
			while(level.player.origin[param_00] - 32 <= level.ally.origin[param_00])
			{
				function_0168("player_swimSpeed",0);
				level.ally method_8222(0);
				function_0168("player_swimWaterCurrent",(param_02,param_03,0));
				wait(0.01);
			}
			break;

		default:
			break;
	}

	function_0168("player_swimSpeed",level.var_7742);
	level.ally method_8222(1);
	wait(0.5);
	function_0168("player_swimWaterCurrent",(0,0,0));
}

//Function Number: 49
func_323C(param_00,param_01)
{
	common_scripts\utility::flag_wait("end_ally_loop_anims");
	if(isdefined(param_00))
	{
		param_00 notify("ender");
	}
}

//Function Number: 50
entity_counter()
{
	common_scripts\utility::create_dvar("entity_counter",1);
	for(var_00 = getdvarint("entity_counter");var_00;var_00 = getdvarint("entity_counter"))
	{
		iprintln("ENTS: " + getentarray().size);
		wait(1);
	}
}

//Function Number: 51
func_5F1A()
{
	wait(4);
	var_00 = level.player.origin;
	var_01 = level.player.origin;
	var_02 = 0;
	for(;;)
	{
		var_00 = level.player.origin;
		var_03 = distance(var_00,var_01);
		var_03 = var_03 * 3600;
		var_03 = var_03 / 12;
		var_03 = var_03 / 5280;
		if(var_02 < var_03)
		{
			var_02 = var_03;
		}

		iprintlnbold("MPH:  " + var_03 + "     Top:  " + var_02);
		var_01 = level.player.origin;
		wait(1);
	}
}

//Function Number: 52
odin_drop_weapon()
{
	level endon("stop_weapon_drop_scripts");
	if(!isdefined(level.odin_custom_weap_splash))
	{
		level.odin_dropped_weapons = [];
		thread custom_weap_splash();
	}

	level.odin_custom_weap_splash = 1;
	var_00 = self.a.var_8DB5["right"];
	if(var_00 != "none")
	{
		self.var_565D = 1;
		var_01 = create_world_model_from_ent_weapon(var_00);
		var_01 hide();
		var_01.origin = self gettagorigin("tag_weapon");
		var_01.angles = self gettagangles("tag_weapon");
		var_01 linkto(self,"tag_weapon");
		self waittill("death");
		var_02 = func_2076(var_01);
		var_01 show();
		animscripts/shared::placeweaponon(var_00,"none");
		if(common_scripts\utility::func_1DE9())
		{
			var_03 = randomintrange(-400,-100);
		}
		else
		{
			var_03 = randomintrange(100,400);
		}

		if(common_scripts\utility::func_1DE9())
		{
			var_04 = randomintrange(-400,-100);
		}
		else
		{
			var_04 = randomintrange(100,400);
		}

		var_01 physicslaunchserver(var_01.origin + (0,0,10),(var_03,0,0));
		var_01 thread func_5802(var_02);
	}
}

//Function Number: 53
custom_weap_splash()
{
	thread display_splash_func();
	level endon("player_has_shroud_now");
	for(;;)
	{
		common_scripts\utility::flag_wait("show_custom_weap_splash");
		create_qte_prompt(&"ODIN_SHROUD_PICKUP","hud_icon_microtar_space",1.25);
		common_scripts\utility::func_33A0("show_custom_weap_splash");
		func_2631();
	}
}

//Function Number: 54
display_splash_func()
{
	level endon("player_has_shroud_now");
	for(;;)
	{
		var_00 = 0;
		foreach(var_02 in level.odin_dropped_weapons)
		{
			if(isdefined(var_02))
			{
				var_03 = distance(level.player.origin,var_02.origin);
				if(var_03 <= 60)
				{
					var_00 = 1;
				}
			}
		}

		if(var_00 == 1)
		{
			common_scripts\utility::flag_set("show_custom_weap_splash");
		}
		else
		{
			common_scripts\utility::func_337C("show_custom_weap_splash");
		}

		wait(0.1);
	}
}

//Function Number: 55
func_2076(param_00)
{
	param_00 makeusable();
	thread wait_for_use_trigger_stop(param_00);
	thread odin_drop_weapon_trigger_use(param_00);
	level.odin_dropped_weapons[level.odin_dropped_weapons.size] = param_00;
}

//Function Number: 56
wait_for_use_trigger_stop(param_00)
{
	common_scripts\utility::flag_wait("player_has_shroud");
	level notify("player_has_shroud_now");
	if(!isdefined(param_00))
	{
	}

	func_2631();
	param_00 makeunusable();
	var_01 = spawn("trigger_radius",param_00.origin,0,20,20);
	var_01 enablelinkto();
	var_01 linkto(param_00);
	var_01 thread func_5803(param_00);
	return var_01;
}

//Function Number: 57
odin_drop_weapon_trigger_use(param_00)
{
	level endon("start_transition_to_youngblood");
	level endon("player_has_shroud_now");
	param_00 waittill("trigger");
	level.player takeallweapons();
	if(common_scripts\utility::flag("odin_start_spin_decomp_real"))
	{
		level.player giveweapon("microtar_space+acogsmg_sp+spaceshroud_sp");
		level.player switchtoweapon("microtar_space+acogsmg_sp+spaceshroud_sp");
	}
	else
	{
		level.player giveweapon("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
		level.player switchtoweapon("microtar_space_interior+acogsmg_sp+spaceshroud_sp");
	}

	level.player.var_8D96 = "microtar_space_interior+acogsmg_sp+spaceshroud_sp";
	level.player.var_8D95 = "microtar_space+acogsmg_sp+spaceshroud_sp";
	var_01 = level.player getcurrentprimaryweapon();
	var_02 = level.player getweaponammostock(var_01);
	level.player playsound("weap_pickup_large_plr");
	level.player setweaponammostock(var_01,var_02 + randomintrange(30,60));
	param_00 hidepart("tag_clip");
	param_00 hidepart("tag_silencer");
	level thread create_pushed_dropped_weapon(param_00.origin,param_00.angles,param_00.model,param_00.attachments,1);
	param_00 delete();
	common_scripts\utility::flag_set("player_has_shroud");
}

//Function Number: 58
create_pushed_dropped_weapon(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawn("script_model",param_00);
	var_05.angles = param_01;
	var_05 setmodel(param_02);
	var_05 hidepart("tag_clip");
	var_05.attachments = param_03;
	var_05 create_world_model_from_ent_weapon();
	if(isdefined(param_04))
	{
		var_05 hidepart("tag_silencer");
	}

	var_05 physicslaunchserver(var_05.origin,anglestoforward(level.player.angles) * 2500,500000,5);
	wait(0.5);
	if(!isdefined(var_05))
	{
	}

	var_05 thread func_5802(undefined,10);
}

//Function Number: 59
func_5803(param_00)
{
	level endon("start_transition_to_youngblood");
	self waittill("trigger");
	var_01 = level.player getcurrentprimaryweapon();
	var_02 = level.player getweaponammostock(var_01);
	level.player playsound("weap_pickup_large_plr");
	level.player setweaponammostock(var_01,var_02 + randomintrange(30,60));
	param_00 hidepart("tag_clip");
	thread func_2631();
	level thread create_pushed_dropped_weapon(param_00.origin,param_00.angles,param_00.model,param_00.attachments);
	param_00 delete();
	self delete();
}

//Function Number: 60
func_5802(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 45;
	}

	wait(param_01);
	while(maps\_utility::func_5E89(self.origin,0.4,1))
	{
		common_scripts\utility::func_8AFE();
	}

	if(isdefined(param_00) && isalive(param_00))
	{
		param_00 delete();
	}

	self delete();
}

//Function Number: 61
create_world_model_from_ent_weapon(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = getweaponmodel(param_00);
		var_02 = spawn("script_model",(0,0,-10000));
		var_02 setmodel(var_01);
		var_02.attachments = getweaponattachments(param_00);
	}
	else
	{
		var_02 = self;
		var_01 = self.model;
		var_02.attachments = self.attachments;
	}

	var_02 hidepart("tag_sight_on",var_01);
	var_02 attach("weapon_acog_iw6","tag_acog_2",1);
	var_02 attach("weapon_barrel_shroud_iw6","tag_silencer",1);
	return var_02;
}

//Function Number: 62
func_89A6(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\_utility::func_777F("player_rig");
	var_07.origin = level.player.origin - (0,0,60);
	var_07.angles = level.player getangles();
	wait(0.05);
	level.player playerlinktodelta(var_07,"tag_player",1,param_00,param_00,param_00,param_00,1);
	if(!isdefined(param_04) || param_04 > param_03)
	{
		param_04 = 0;
	}

	if(!isdefined(param_05) || param_05 > param_03)
	{
		param_05 = 0;
	}

	var_07 moveto(param_01,param_03,param_04,param_05);
	var_07 rotateto(param_02,param_03,param_04,param_05);
	wait(param_03);
	level.player playerlinktodelta(param_06,"tag_player",1,param_00,param_00,param_00,param_00,1);
	var_07 delete();
}

//Function Number: 63
func_2BAB()
{
	var_00 = [];
	var_00[0] = getent("odin_escape_ally_tp","targetname");
	var_00[1] = getent("player_escape_door_blocker_origin","targetname");
	var_00[2] = getent("final_dyn_push_dest","script_noteworthy");
	var_01 = common_scripts\utility::func_7836();
	var_01.origin = var_00[0].origin;
	thread func_624E(var_01);
	thread dynamic_repulsor(var_00[1]);
	var_01 moveto(var_00[1].origin,3,0,0);
	wait(3);
	var_01 notify("stop_pushing");
	common_scripts\utility::flag_wait("esc_combat_done");
	var_01 moveto(var_00[2].origin,3,0,0);
	wait(2);
	thread func_624E(var_01);
	wait(1);
	var_01 notify("stop_pushing");
	wait(1);
	var_01 delete();
}

//Function Number: 64
func_624E(param_00)
{
	param_00 endon("stop_pushing");
	for(;;)
	{
		physicsexplosionsphere(param_00.origin,96,1,0.03);
		wait(0.05);
	}
}

//Function Number: 65
dynamic_repulsor(param_00)
{
	var_01 = param_00.origin;
	while(!common_scripts\utility::flag("escape_blocker_door_trig"))
	{
		physicsexplosionsphere(var_01,32,1,0.03);
		wait(0.05);
	}
}

//Function Number: 66
func_3637()
{
	function_0168("cg_cinematicFullScreen","0");
	if(maps\_utility::func_47F6())
	{
		function_01C0("prologue_odin_monitor_ng");
	}
	else
	{
		function_01C0("prologue_odin_monitor");
	}

	thread fx_odin_monitor_bink_shutdown();
}

//Function Number: 67
fx_odin_monitor_bink_shutdown()
{
	if(level.start_point == "odin_escape")
	{
		function_01C2();
	}
	else
	{
		common_scripts\utility::flag_wait("player_second_z_turn");
		function_01C2();
	}

	common_scripts\utility::flag_wait("kyra_push_bag_anim");
	function_0168("cg_cinematicFullScreen","0");
	if(maps\_utility::func_47F6())
	{
		function_01C0("prologue_odin_monitor_ng");
	}
	else
	{
		function_01C0("prologue_odin_monitor");
	}

	common_scripts\utility::flag_wait("decomp_done");
	function_01C2();
}

//Function Number: 68
odin_breathing_func(param_00)
{
	switch(param_00)
	{
		case "breathing_better":
			self playlocalsound("breathing_better_space");
			break;

		case "breathing_hurt":
			self playlocalsound("breathing_hurt_space");
			break;

		default:
			break;
	}
}

//Function Number: 69
create_qte_prompt(param_00,param_01,param_02,param_03)
{
	var_04 = -3;
	if(!isdefined(param_03))
	{
		param_03 = 100;
	}

	var_05 = param_02;
	var_06 = 3;
	var_07 = 130;
	var_08 = [];
	var_09 = level.player maps\_hud_util::func_20D1("default",var_05);
	var_09.x = var_04 * -1;
	var_09.y = param_03;
	var_09.horzalign = "right";
	var_09.alignx = "right";
	var_09.alignx = "center";
	var_09.aligny = "middle";
	var_09.horzalign = "center";
	var_09.vertalign = "middle";
	var_09.hidewhendead = 1;
	var_09.hidewheninmenu = 1;
	var_09.sort = 205;
	var_09.foreground = 1;
	var_09.alpha = 1;
	var_09 settext(param_00);
	var_08["text"] = var_09;
	if(isdefined(param_01))
	{
		var_0A = maps\_hud_util::func_20FC(param_01,100,40);
		var_0A.x = var_06;
		var_0A.y = var_07;
		var_0A.alignx = "center";
		var_0A.aligny = "middle";
		var_0A.horzalign = "center";
		var_0A.vertalign = "middle";
		var_0A.hidewhendead = 1;
		var_0A.hidewheninmenu = 1;
		var_0A.sort = 205;
		var_0A.foreground = 1;
		var_0A.alpha = 1;
		var_08["icon"] = var_0A;
	}

	level.var_6263 = var_08;
}

//Function Number: 70
func_2631()
{
	if(!isdefined(level.var_6263))
	{
	}

	level notify("stop_blink");
	foreach(var_01 in level.var_6263)
	{
		if(isdefined(var_01))
		{
			var_01 destroy();
		}
	}
}

//Function Number: 71
dialogue_facial(param_00,param_01)
{
	if(!isdefined(self))
	{
	}

	maps\_utility_code::add_to_radio(param_00);
	self playsound(param_00);
	maps\_utility::bcs_scripted_dialogue_start();
	maps\_anim::anim_single_queue(self,param_01);
}