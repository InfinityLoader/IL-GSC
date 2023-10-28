/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zm_tomb_ffotd.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 6 ms
 * Timestamp: 10/28/2023 12:12:06 AM
*******************************************************************/

#include codescripts/struct;
#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_zonemgr;

//Function Number: 1
main_start()
{
	level thread spawned_collision_ffotd();
	level thread spawn_kill_brushes();
	level thread respawn_struct_fix();
	onplayerconnect_callback(::one_inch_punch_take_think);
}

//Function Number: 2
main_end()
{
	level thread player_spawn_fix();
	level thread update_charger_position();
	level thread traversal_blocker_disabler();
}

//Function Number: 3
update_charger_position()
{
	foreach(e_staff in level.a_elemental_staffs)
	{
		e_staff moveto(e_staff.charger.origin,0.05);
	}

	foreach(e_staff in level.a_elemental_staffs_upgraded)
	{
		e_staff moveto(e_staff.charger.origin,0.05);
	}
}

//Function Number: 4
spawned_collision_ffotd()
{
	precachemodel("collision_ai_64x64x10");
	precachemodel("collision_wall_256x256x10_standard");
	precachemodel("collision_wall_512x512x10_standard");
	precachemodel("collision_geo_256x256x10_standard");
	precachemodel("collision_geo_512x512x10_standard");
	precachemodel("collision_geo_ramp_standard");
	precachemodel("collision_player_512x512x512");
	precachemodel("collision_geo_32x32x128_standard");
	precachemodel("collision_geo_64x64x128_standard");
	precachemodel("collision_geo_64x64x256_standard");
	precachemodel("collision_player_wall_256x256x10");
	precachemodel("collision_player_wall_512x512x10");
	precachemodel("collision_player_wall_32x32x10");
	precachemodel("collision_geo_64x64x10_standard");
	precachemodel("collision_player_wall_128x128x10");
	precachemodel("p6_zm_tm_barbedwire_tube");
	precachemodel("p6_zm_tm_rubble_rebar_group");
	flag_wait("start_zombie_round_logic");
	m_disconnector = spawn("script_model",(-568,-956,160),1);
	m_disconnector setmodel("collision_ai_64x64x10");
	m_disconnector.angles = VectorScale((0,1,0));
	m_disconnector disconnectpaths();
	m_disconnector ghost();
	if(!(IsDefined(level.optimise_for_splitscreen) && level.optimise_for_splitscreen))
	{
		collision1a = spawn("script_model",(1128,-2664.25,122));
		collision1a setmodel("collision_player_wall_256x256x10");
		collision1a.angles = VectorScale((0,1,0));
		collision1a ghost();
		collision1b = spawn("script_model",(909.5,-2856.5,-6));
		collision1b setmodel("collision_player_wall_512x512x10");
		collision1b.angles = VectorScale((0,1,0));
		collision1b ghost();
		collision1c = spawn("script_model",(415,-2989,-6));
		collision1c setmodel("collision_player_wall_512x512x10");
		collision1c.angles = VectorScale((0,1,0));
		collision1c ghost();
		collision2a = spawn("script_model",(-6760,-6536,280));
		collision2a setmodel("collision_geo_512x512x10_standard");
		collision2a.angles = (0,0,0);
		collision2a ghost();
		collision2b = spawn("script_model",(-6224,-6536,280));
		collision2b setmodel("collision_geo_512x512x10_standard");
		collision2b.angles = (0,0,0);
		collision2b ghost();
		collision2c = spawn("script_model",(-5704,-6536,280));
		collision2c setmodel("collision_geo_512x512x10_standard");
		collision2c.angles = (0,0,0);
		collision2c ghost();
		collision3a = spawn("script_model",(1088,4216,-192));
		collision3a setmodel("collision_geo_256x256x10_standard");
		collision3a.angles = (0,0,0);
		collision3a ghost();
		collision4a = spawn("script_model",(545.36,-2382.3,404));
		collision4a setmodel("collision_wall_256x256x10_standard");
		collision4a.angles = (0,293.8,180);
		collision4a ghost();
		collision4b = spawn("script_model",(579.36,-2367.3,264));
		collision4b setmodel("collision_geo_ramp_standard");
		collision4b.angles = (0,293.8,180);
		collision4b ghost();
		collision5a = spawn("script_model",(67.87,-3193.25,504));
		collision5a setmodel("collision_player_512x512x512");
		collision5a.angles = VectorScale((0,1,0));
		collision5a ghost();
		collision5b = spawn("script_model",(292.5,-2865.5,286));
		collision5b setmodel("collision_geo_32x32x128_standard");
		collision5b.angles = (270,22.4,0);
		collision5b ghost();
		collision5c = spawn("script_model",(292.5,-2865.5,266));
		collision5c setmodel("collision_geo_32x32x128_standard");
		collision5c.angles = (270,22.4,0);
		collision5c ghost();
		collision5d = spawn("script_model",(339,-3024.5,280));
		collision5d setmodel("collision_geo_64x64x128_standard");
		collision5d.angles = (270,18.2,0);
		collision5d ghost();
		model5a = spawn("script_model",(248.15,-2917.26,351.01));
		model5a setmodel("p6_zm_tm_barbedwire_tube");
		model5a.angles = (6.00001,188,90);
		collision6a = spawn("script_model",(-227.25,4010.25,-96));
		collision6a setmodel("collision_player_wall_256x256x10");
		collision6a.angles = VectorScale((0,1,0));
		collision6a ghost();
		model6a = spawn("script_model",(-231.124,4093.08,-230.685));
		model6a setmodel("p6_zm_tm_rubble_rebar_group");
		model6a.angles = (25.883,2.13901,0.55601);
		collision7a = spawn("script_model",(599,-2478,184));
		collision7a setmodel("collision_geo_64x64x128_standard");
		collision7a.angles = (270,14.7,0);
		collision7a ghost();
		collision8a = spawn("script_model",(-3190,-555,-111));
		collision8a setmodel("collision_player_wall_512x512x10");
		collision8a.angles = VectorScale((0,1,0));
		collision8a ghost();
		collision11a = spawn("script_model",(812.812,-64.1434,384));
		collision11a setmodel("collision_player_wall_256x256x10");
		collision11a.angles = VectorScale((0,1,0));
		collision11a ghost();
		collision12a = spawn("script_model",(180,4128,40));
		collision12a setmodel("collision_player_wall_512x512x10");
		collision12a.angles = VectorScale((0,1,0));
		collision12a ghost();
		collision13a = spawn("script_model",(2088,588,240));
		collision13a setmodel("collision_player_wall_512x512x10");
		collision13a.angles = (0,0,0);
		collision13a ghost();
		collision14a = spawn("script_model",(-787,375,380));
		collision14a setmodel("collision_player_wall_256x256x10");
		collision14a.angles = (0,0,0);
		collision14a ghost();
		collision14b = spawn("script_model",(-899,375,236));
		collision14b setmodel("collision_player_wall_32x32x10");
		collision14b.angles = (0,0,0);
		collision14b ghost();
		collision15a = spawn("script_model",(1704,2969.34,-187.83));
		collision15a setmodel("collision_geo_64x64x10_standard");
		collision15a.angles = VectorScale((0,0,1));
		collision15a ghost();
		collision16a = spawn("script_model",(482,-2770,186));
		collision16a setmodel("collision_player_wall_128x128x10");
		collision16a.angles = VectorScale((0,1,0));
		collision16a ghost();
		collision16b = spawn("script_model",(480,-2760,186));
		collision16b setmodel("collision_player_wall_128x128x10");
		collision16b.angles = VectorScale((0,1,0));
		collision16b ghost();
		collision16c = spawn("script_model",(482,-2770,58));
		collision16c setmodel("collision_player_wall_128x128x10");
		collision16c.angles = VectorScale((0,1,0));
		collision16c ghost();
		collision16d = spawn("script_model",(480,-2760,58));
		collision16d setmodel("collision_player_wall_128x128x10");
		collision16d.angles = VectorScale((0,1,0));
		collision16d ghost();
		collision17a = spawn("script_model",(274.828,2521.87,-16));
		collision17a setmodel("collision_geo_64x64x256_standard");
		collision17a.angles = VectorScale((0,1,0));
		collision17a ghost();
	}
}

//Function Number: 5
spawn_kill_brushes()
{
	t_killbrush_1 = spawn("trigger_box",(1643,2168,96),0,256,1200,512);
	t_killbrush_1.script_noteworthy = "kill_brush";
	t_killbrush_2 = spawn("trigger_box",(-1277,892,184),0,148,88,128);
	t_killbrush_2.script_noteworthy = "kill_brush";
	t_killbrush_3 = spawn("trigger_box",(2053,537,248),0,758,78,256);
	t_killbrush_3.script_noteworthy = "kill_brush";
}

//Function Number: 6
one_inch_punch_take_think()
{
	self endon("disconnect");
	while(1)
	{
		self waittill("bled_out");
		self.one_inch_punch_flag_has_been_init = 0;
		if(self ent_flag_exist("melee_punch_cooldown"))
		{
			self.ent_flag["melee_punch_cooldown"] = undefined;
		}
	}
}

//Function Number: 7
player_spawn_fix()
{
	s_zone_nml_18 = level.zones["zone_nml_18"];
	s_zone_nml_18.adjacent_zones["zone_nml_19"] = undefined;
	s_zone_nml_19 = level.zones["zone_nml_19"];
	s_zone_nml_19.adjacent_zones["zone_nml_18"] = undefined;
	add_adjacent_zone("zone_nml_18","zone_nml_19","activate_zone_ruins");
}

//Function Number: 8
respawn_struct_fix()
{
	spawn1 = createstruct();
	spawn1.model = undefined;
	spawn1.origin = (2400,120,160);
	spawn1.targetname = "nml_11_spawn_points";
	spawn1.radius = 32;
	spawn1.script_int = 1;
	spawn2 = createstruct();
	spawn2.model = undefined;
	spawn2.origin = (2392,360,160);
	spawn2.targetname = "nml_11_spawn_points";
	spawn2.radius = 32;
	spawn2.script_int = 1;
	spawn3 = createstruct();
	spawn3.model = undefined;
	spawn3.origin = (2616,152,160);
	spawn3.targetname = "nml_11_spawn_points";
	spawn3.radius = 32;
	spawn3.script_int = 1;
}

//Function Number: 9
traversal_blocker_disabler()
{
	level endon("activate_zone_nml");
	pos1 = (-1509,3912,-168);
	pos2 = (672,3720,-179);
	b_too_close = 0;
	while(level.round_number < 10 && !b_too_close)
	{
		a_players = getplayers();
		foreach(player in a_players)
		{
			if(distancesquared(player.origin,pos1) < 4096 || distancesquared(player.origin,pos2) < 4096)
			{
				b_too_close = 1;
			}
		}

		wait(1);
	}

	m_traversal_blocker = getent("traversal_blocker","targetname");
	m_traversal_blocker.origin = 10000 + VectorScale((0,0,-1));
	m_traversal_blocker connectpaths();
}