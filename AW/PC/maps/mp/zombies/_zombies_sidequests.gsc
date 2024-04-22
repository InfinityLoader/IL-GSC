/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_sidequests.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 815 ms
 * Timestamp: 4/22/2024 2:14:43 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level._sidequest_icons_base_x))
	{
		level._sidequest_icons_base_x = 110;
	}

	if(!isdefined(level._sidequest_icons_base_y))
	{
		level._sidequest_icons_base_y = -10;
	}

	if(!isdefined(level._sidequest_counter_base_x))
	{
		level._sidequest_counter_base_x = 40;
	}

	if(!isdefined(level._sidequest_counter_base_y))
	{
		level._sidequest_counter_base_y = -15;
	}

	if(!isdefined(level._zombie_sidequests))
	{
		level._zombie_sidequests = [];
	}
}

//Function Number: 2
sidequest_uses_teleportation(param_00)
{
	level._zombie_sidequests[param_00].uses_teleportation = 1;
}

//Function Number: 3
declare_sidequest_icon(param_00,param_01,param_02)
{
	var_03 = level._zombie_sidequests[param_00];
	var_03.icons[param_01] = param_02;
}

//Function Number: 4
create_icon(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(self);
	var_03.foreground = 1;
	var_03.sort = 2;
	var_03.hidewheninmenu = 0;
	var_03.alignx = "left";
	var_03.aligny = "bottom";
	var_03.horzalign = "left";
	var_03.vertalign = "bottom";
	var_03.x = param_01;
	var_03.y = param_02;
	var_03.alpha = 1;
	var_03 setshader(param_00,32,32);
	return var_03;
}

//Function Number: 5
create_counter_hud(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.foreground = 1;
	var_02.sort = 2;
	var_02.hidewheninmenu = 0;
	var_02.alignx = "left";
	var_02.aligny = "bottom";
	var_02.horzalign = "left";
	var_02.vertalign = "bottom";
	var_02.font = "small";
	var_02.fontscale = 1.5;
	var_02.x = level._sidequest_counter_base_x;
	var_02.y = level._sidequest_counter_base_y;
	var_02.alpha = 1;
	var_02 settext(param_00);
	var_02 setvalue(param_01);
	return var_02;
}

//Function Number: 6
create_text_hud(param_00)
{
	var_01 = newclienthudelem(self);
	var_01.foreground = 1;
	var_01.sort = 2;
	var_01.hidewheninmenu = 0;
	var_01.alignx = "left";
	var_01.aligny = "bottom";
	var_01.horzalign = "left";
	var_01.vertalign = "bottom";
	var_01.font = "small";
	var_01.fontscale = 1.5;
	var_01.x = level._sidequest_counter_base_x;
	var_01.y = level._sidequest_counter_base_y;
	var_01.alpha = 1;
	var_01 settext(param_00);
	return var_01;
}

//Function Number: 7
add_sidequest_icon(param_00,param_01)
{
	if(!isdefined(self.sidequest_icons))
	{
		self.sidequest_icons = [];
	}

	if(isdefined(self.sidequest_icons[param_01]))
	{
		return;
	}

	var_02 = level._zombie_sidequests[param_00];
	var_03 = level._sidequest_icons_base_x;
	if(isdefined(level._zombiemode_sidequest_icon_offset))
	{
		var_03 = var_03 + level._zombiemode_sidequest_icon_offset;
	}

	var_04 = level._sidequest_icons_base_y;
	self.sidequest_icons[param_01] = create_icon(var_02.icons[param_01],var_03 + self.sidequest_icons.size * 34,var_04);
}

//Function Number: 8
remove_sidequest_icon(param_00,param_01)
{
	if(!isdefined(self.sidequest_icons))
	{
		return;
	}

	if(!isdefined(self.sidequest_icons[param_01]))
	{
		return;
	}

	var_02 = self.sidequest_icons[param_01];
	var_03 = [];
	var_04 = getarraykeys(self.sidequest_icons);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(var_04[var_05] != param_01)
		{
			var_03[var_04[var_05]] = self.sidequest_icons[var_04[var_05]];
		}
	}

	self.sidequest_icons = var_03;
	var_02 destroy();
	var_04 = getarraykeys(self.sidequest_icons);
	var_06 = level._sidequest_icons_base_x;
	if(isdefined(level._zombiemode_sidequest_icon_offset))
	{
		var_06 = var_06 + level._zombiemode_sidequest_icon_offset;
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		self.sidequest_icons[var_04[var_05]].x = var_06 + var_05 * 34;
	}
}

//Function Number: 9
declare_sidequest(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(level._zombie_sidequests))
	{
		init();
	}

	var_07 = spawnstruct();
	var_07.name = param_00;
	var_07.stages = [];
	var_07.last_completed_stage = -1;
	var_07.active_stage = -1;
	var_07.sidequest_complete = 0;
	var_07.init_func = param_01;
	var_07.logic_func = param_02;
	var_07.complete_func = param_03;
	var_07.generic_stage_start_func = param_04;
	var_07.generic_stage_end_func = param_05;
	var_07.assets = [];
	var_07.uses_teleportation = 0;
	var_07.active_assets = [];
	var_07.icons = [];
	var_07.num_reps = 0;
	level._zombie_sidequests[param_00] = var_07;
}

//Function Number: 10
declare_sidequest_stage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.name = param_01;
	var_06.stage_number = level._zombie_sidequests[param_00].stages.size;
	var_06.assets = [];
	var_06.active_assets = [];
	var_06.logic_func = param_03;
	var_06.init_func = param_02;
	var_06.exit_func = param_04;
	var_06.completed = 0;
	var_06.time_limit = 0;
	level._zombie_sidequests[param_00].stages[param_01] = var_06;
}

//Function Number: 11
set_stage_time_limit(param_00,param_01,param_02,param_03)
{
	level._zombie_sidequests[param_00].stages[param_01].time_limit = param_02;
	level._zombie_sidequests[param_00].stages[param_01].time_limit_func = param_03;
}

//Function Number: 12
declare_stage_asset_from_struct(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = common_scripts\utility::getstructarray(param_02,"targetname");
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = spawnstruct();
		var_07.type = "struct";
		var_07.struct = var_05[var_06];
		var_07.thread_func = param_03;
		var_07.trigger_thread_func = param_04;
		level._zombie_sidequests[param_00].stages[param_01].assets[level._zombie_sidequests[param_00].stages[param_01].assets.size] = var_07;
	}
}

//Function Number: 13
declare_stage_asset(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_02,"targetname");
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_07 = spawnstruct();
		var_07.type = "entity";
		var_07.ent = var_05[var_06];
		var_07.thread_func = param_03;
		var_07.trigger_thread_func = param_04;
		level._zombie_sidequests[param_00].stages[param_01].assets[level._zombie_sidequests[param_00].stages[param_01].assets.size] = var_07;
	}
}

//Function Number: 14
declare_sidequest_asset(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_01,"targetname");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = spawnstruct();
		var_06.type = "entity";
		var_06.ent = var_04[var_05];
		var_06.thread_func = param_02;
		var_06.trigger_thread_func = param_03;
		var_06.ent.thread_func = param_02;
		var_06.ent.trigger_thread_func = param_03;
		level._zombie_sidequests[param_00].assets[level._zombie_sidequests[param_00].assets.size] = var_06;
	}
}

//Function Number: 15
declare_sidequest_asset_from_struct(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::getstructarray(param_01,"targetname");
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = spawnstruct();
		var_06.type = "struct";
		var_06.struct = var_04[var_05];
		var_06.thread_func = param_02;
		var_06.trigger_thread_func = param_03;
		level._zombie_sidequests[param_00].assets[level._zombie_sidequests[param_00].assets.size] = var_06;
	}
}

//Function Number: 16
build_asset_from_struct(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	if(isdefined(param_00.model))
	{
		var_02 setmodel(param_00.model);
	}

	if(isdefined(param_00.angles))
	{
		var_02.angles = param_00.angles;
	}

	var_02.script_noteworthy = param_00.script_noteworthy;
	var_02.type = "struct";
	var_02.radius = param_00.radius;
	var_02.thread_func = param_01.thread_func;
	var_02.trigger_thread_func = param_01.trigger_thread_func;
	var_02.script_vector = param_01.script_vector;
	param_00.trigger_thread_func = param_01.trigger_thread_func;
	param_00.script_vector = param_01.script_vector;
	var_02.target = param_00.target;
	var_02.script_float = param_00.script_float;
	var_02.script_int = param_00.script_int;
	var_02.script_trigger_spawnflags = param_00.script_trigger_spawnflags;
	var_02.targetname = param_00.targetname;
	return var_02;
}

//Function Number: 17
delete_stage_assets()
{
	for(var_00 = 0;var_00 < self.active_assets.size;var_00++)
	{
		var_01 = self.active_assets[var_00];
		switch(var_01.type)
		{
			case "struct":
				if(isdefined(var_01.trigger))
				{
					var_01.trigger delete();
					var_01.trigger = undefined;
				}
	
				var_01 delete();
				break;

			case "entity":
				if(isdefined(var_01.trigger))
				{
					var_01.trigger delete();
					var_01.trigger = undefined;
				}
				break;
		}
	}

	var_02 = [];
	for(var_00 = 0;var_00 < self.active_assets.size;var_00++)
	{
		if(isdefined(self.active_assets[var_00]))
		{
			var_02[var_02.size] = self.active_assets[var_00];
		}
	}

	self.active_assets = var_02;
}

//Function Number: 18
build_assets()
{
	for(var_00 = 0;var_00 < self.assets.size;var_00++)
	{
		var_01 = undefined;
		switch(self.assets[var_00].type)
		{
			case "struct":
				var_01 = self.assets[var_00].struct;
				self.active_assets[self.active_assets.size] = build_asset_from_struct(var_01,self.assets[var_00]);
				break;

			case "entity":
				for(var_02 = 0;var_02 < self.active_assets.size;var_02++)
				{
					if(self.active_assets[var_02] == self.assets[var_00].ent)
					{
						var_01 = self.active_assets[var_02];
						break;
					}
				}
	
				var_01 = self.assets[var_00].ent;
				var_01.type = "entity";
				self.active_assets[self.active_assets.size] = var_01;
				break;

			default:
				break;
		}

		if((isdefined(var_01.script_noteworthy) && self.assets[var_00].type == "entity" && !isdefined(var_01.trigger)) || isdefined(var_01.script_noteworthy))
		{
			var_03 = 15;
			var_04 = 72;
			if(isdefined(var_01.radius))
			{
				var_03 = var_01.radius;
			}

			if(isdefined(var_01.height))
			{
				var_04 = var_01.height;
			}

			var_05 = 0;
			if(isdefined(var_01.script_trigger_spawnflags))
			{
				var_05 = var_01.script_trigger_spawnflags;
			}

			var_06 = (0,0,0);
			if(isdefined(var_01.script_vector))
			{
				var_06 = var_01.script_vector;
			}

			switch(var_01.script_noteworthy)
			{
				case "trigger_radius_use":
					var_07 = spawn("trigger_radius_use",var_01.origin + var_06,var_05,var_03,var_04);
					var_07 setcursorhint("HINT_NOICON");
					if(isdefined(var_01.radius))
					{
						var_07.radius = var_01.radius;
					}
	
					var_07.owner_ent = self.active_assets[self.active_assets.size - 1];
					if(isdefined(var_01.trigger_thread_func))
					{
						var_07 thread [[ var_01.trigger_thread_func ]]();
					}
					else
					{
						var_07 thread use_trigger_thread();
					}
	
					self.active_assets[self.active_assets.size - 1].trigger = var_07;
					break;

				case "trigger_radius_damage":
					var_08 = spawn("trigger_damage",var_01.origin + var_06,var_05,var_03,var_04);
					if(isdefined(var_01.radius))
					{
						var_08.radius = var_01.radius;
					}
	
					var_08.owner_ent = self.active_assets[self.active_assets.size - 1];
					if(isdefined(var_01.trigger_thread_func))
					{
						var_08 thread [[ var_01.trigger_thread_func ]]();
					}
					else
					{
						var_08 thread damage_trigger_thread();
					}
	
					self.active_assets[self.active_assets.size - 1].trigger = var_08;
					break;

				case "trigger_radius":
					var_09 = spawn("trigger_radius",var_01.origin + var_06,var_05,var_03,var_04);
					if(isdefined(var_01.radius))
					{
						var_09.radius = var_01.radius;
					}
	
					var_09.owner_ent = self.active_assets[self.active_assets.size - 1];
					if(isdefined(var_01.trigger_thread_func))
					{
						var_09 thread [[ var_01.trigger_thread_func ]]();
					}
					else
					{
						var_09 thread radius_trigger_thread();
					}
	
					self.active_assets[self.active_assets.size - 1].trigger = var_09;
					break;
			}
		}

		if(isdefined(self.assets[var_00].thread_func) && !isdefined(self.active_assets[self.active_assets.size - 1].dont_rethread))
		{
			self.active_assets[self.active_assets.size - 1] thread [[ self.assets[var_00].thread_func ]]();
		}

		if(var_00 % 2 == 0)
		{
			maps\mp\zombies\_util::waitnetworkframe();
		}
	}
}

//Function Number: 19
damage_trigger_thread()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		self.owner_ent notify("triggered");
	}
}

//Function Number: 20
radius_trigger_thread()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		self.owner_ent notify("triggered");
		while(var_00 istouching(self))
		{
			wait(0.05);
		}

		self.owner_ent notify("untriggered");
	}
}

//Function Number: 21
thread_on_assets(param_00,param_01)
{
	for(var_02 = 0;var_02 < self.active_assets.size;var_02++)
	{
		if(self.active_assets[var_02].targetname == param_00)
		{
			self.active_assets[var_02] thread [[ param_01 ]]();
		}
	}
}

//Function Number: 22
stage_logic_func_wrapper(param_00,param_01)
{
	if(isdefined(param_01.logic_func))
	{
		level endon(param_00.name + "_" + param_01.name + "_over");
		param_01 [[ param_01.logic_func ]]();
	}
}

//Function Number: 23
sidequest_start(param_00)
{
	var_01 = level._zombie_sidequests[param_00];
	var_01 build_assets();
	if(isdefined(var_01.init_func))
	{
		var_01 [[ var_01.init_func ]]();
	}

	if(isdefined(var_01.logic_func))
	{
		var_01 thread [[ var_01.logic_func ]]();
	}
}

//Function Number: 24
stage_start(param_00,param_01)
{
	if(isstring(param_00))
	{
		param_00 = level._zombie_sidequests[param_00];
	}

	if(isstring(param_01))
	{
		param_01 = param_00.stages[param_01];
	}

	param_01 build_assets();
	param_00.active_stage = param_01.stage_number;
	level notify(param_00.name + "_" + param_01.name + "_started");
	param_01.completed = 0;
	if(isdefined(param_00.generic_stage_start_func))
	{
		param_01 [[ param_00.generic_stage_start_func ]]();
	}

	if(isdefined(param_01.init_func))
	{
		param_01 [[ param_01.init_func ]]();
	}

	level thread stage_logic_func_wrapper(param_00,param_01);
	if(param_01.time_limit > 0)
	{
		param_01 thread time_limited_stage(param_00);
	}

	if(isdefined(param_01.title))
	{
		param_01 thread display_stage_title(param_00.uses_teleportation);
	}
}

//Function Number: 25
display_stage_title(param_00)
{
	if(param_00)
	{
		level waittill("teleport_done");
		wait(2);
	}

	var_01 = newhudelem();
	var_01.location = 0;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.foreground = 1;
	var_01.fontscale = 1.6;
	var_01.sort = 20;
	var_01.x = 320;
	var_01.y = 300;
	var_01.og_scale = 1;
	var_01.color = (128,0,0);
	var_01.alpha = 0;
	var_01.fontstyle3d = "shadowedmore";
	var_01 settext(self.title);
	var_01 fadeovertime(0.5);
	var_01.alpha = 1;
	wait(5);
	var_01 fadeovertime(1);
	var_01.alpha = 0;
	wait(1);
	var_01 destroy();
}

//Function Number: 26
time_limited_stage(param_00)
{
	level endon(param_00.name + "_" + self.name + "_over");
	level endon("suspend_timer");
	level endon("end_game");
	var_01 = undefined;
	if(isdefined(self.time_limit_func))
	{
		var_01 = [[ self.time_limit_func ]]() * 0.25;
	}
	else
	{
		var_01 = self.time_limit * 0.25;
	}

	wait(var_01);
	level notify("timed_stage_75_percent");
	wait(var_01);
	level notify("timed_stage_50_percent");
	wait(var_01);
	level notify("timed_stage_25_percent");
	wait(var_01 - 10);
	level notify("timed_stage_10_seconds_to_go");
	wait(10);
	stage_failed(param_00,self);
}

//Function Number: 27
sidequest_println(param_00)
{
}

//Function Number: 28
sidequest_iprintlnbold(param_00)
{
}

//Function Number: 29
sidequest_complete(param_00)
{
	return level._zombie_sidequests[param_00].sidequest_complete;
}

//Function Number: 30
stage_completed(param_00,param_01)
{
	var_02 = level._zombie_sidequests[param_00];
	var_03 = var_02.stages[param_01];
	level thread stage_completed_internal(var_02,var_03);
}

//Function Number: 31
stage_completed_internal(param_00,param_01)
{
	level notify(param_00.name + "_" + param_01.name + "_over");
	level notify(param_00.name + "_" + param_01.name + "_completed");
	if(isdefined(param_00.generic_stage_end_func))
	{
		param_01 [[ param_00.generic_stage_end_func ]]();
	}

	if(isdefined(param_01.exit_func))
	{
		param_01 [[ param_01.exit_func ]](1);
	}

	param_01.completed = 1;
	param_00.last_completed_stage = param_00.active_stage;
	param_00.active_stage = -1;
	param_01 delete_stage_assets();
	var_02 = 1;
	var_03 = getarraykeys(param_00.stages);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(param_00.stages[var_03[var_04]].completed == 0)
		{
			var_02 = 0;
			break;
		}
	}

	if(var_02 == 1)
	{
		if(isdefined(param_00.complete_func))
		{
			param_00 thread [[ param_00.complete_func ]]();
		}

		level notify("sidequest_" + param_00.name + "_complete");
		param_00.sidequest_completed = 1;
	}
}

//Function Number: 32
stage_failed_internal(param_00,param_01)
{
	level notify(param_00.name + "_" + param_01.name + "_over");
	level notify(param_00.name + "_" + param_01.name + "_failed");
	if(isdefined(param_00.generic_stage_end_func))
	{
		param_01 [[ param_00.generic_stage_end_func ]]();
	}

	if(isdefined(param_01.exit_func))
	{
		param_01 [[ param_01.exit_func ]](0);
	}

	param_00.active_stage = -1;
	param_01 delete_stage_assets();
}

//Function Number: 33
stage_failed(param_00,param_01)
{
	if(isstring(param_00))
	{
		param_00 = level._zombie_sidequests[param_00];
	}

	if(isstring(param_01))
	{
		param_01 = param_00.stages[param_01];
	}

	level thread stage_failed_internal(param_00,param_01);
}

//Function Number: 34
get_sidequest_stage(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getarraykeys(param_00.stages);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(param_00.stages[var_03[var_04]].stage_number == param_01)
		{
			var_02 = param_00.stages[var_03[var_04]];
			break;
		}
	}

	return var_02;
}

//Function Number: 35
get_damage_trigger(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_damage",param_01,0,param_00,72);
	var_03 thread dam_trigger_thread(param_02);
	return var_03;
}

//Function Number: 36
dam_trigger_thread(param_00)
{
	self endon("death");
	var_01 = "NONE";
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		for(var_07 = 0;var_07 < param_00.size;var_07++)
		{
			if(var_06 == param_00[var_07])
			{
				self notify("triggered");
			}
		}
	}
}

//Function Number: 37
use_trigger_thread()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		self.owner_ent notify("triggered",var_00);
		wait(0.1);
	}
}

//Function Number: 38
sidequest_stage_active(param_00,param_01)
{
	var_02 = level._zombie_sidequests[param_00];
	var_03 = var_02.stages[param_01];
	if(var_02.active_stage == var_03.stage_number)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
sidequest_start_next_stage(param_00)
{
	var_01 = level._zombie_sidequests[param_00];
	if(var_01.sidequest_complete == 1)
	{
		return;
	}

	var_02 = var_01.last_completed_stage;
	if(var_02 == -1)
	{
		var_02 = 0;
	}
	else
	{
		var_02++;
	}

	var_03 = get_sidequest_stage(var_01,var_02);
	if(!isdefined(var_03))
	{
		return;
	}

	stage_start(var_01,var_03);
	return var_03;
}

//Function Number: 40
is_facing(param_00)
{
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = (var_02[0],var_02[1],0);
	var_04 = vectornormalize(var_03);
	var_05 = param_00.origin - self.origin;
	var_06 = (var_05[0],var_05[1],0);
	var_07 = vectornormalize(var_06);
	var_08 = vectordot(var_04,var_07);
	return var_08 > 0.9;
}

//Function Number: 41
is_facing_3d(param_00)
{
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = vectornormalize(var_02);
	var_04 = param_00.origin - self geteye();
	var_05 = vectornormalize(var_04);
	var_06 = vectordot(var_03,var_05);
	return var_06 > 0.9;
}

//Function Number: 42
fake_use(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_03))
	{
		level endon(param_03);
	}

	waittillframeend;
	if(!isdefined(param_04))
	{
		param_04 = 64;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = param_04 * param_04;
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		for(var_07 = 0;var_07 < level.players.size;var_07++)
		{
			if(distancesquared(self.origin,level.players[var_07].origin) < var_06 && (!param_05 && level.players[var_07] is_facing(self)) || param_05 && level.players[var_07] is_facing_3d(self))
			{
				if(level.players[var_07] usebuttonpressed())
				{
					var_08 = 1;
					if(isdefined(param_01) && isdefined(param_02))
					{
						var_08 = level.players[var_07] [[ param_01 ]](param_02);
					}
					else if(isdefined(param_01))
					{
						var_08 = level.players[var_07] [[ param_01 ]]();
					}

					if(var_08)
					{
						self notify(param_00,level.players[var_07]);
						return level.players[var_07];
					}
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 43
register_sidequest(param_00,param_01)
{
}

//Function Number: 44
is_sidequest_previously_completed(param_00)
{
	return maps\mp\zombies\_util::is_true(level.zombie_sidequest_previously_completed[param_00]);
}

//Function Number: 45
set_sidequest_completed(param_00)
{
}