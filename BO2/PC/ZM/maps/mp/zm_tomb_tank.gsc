/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zm_tomb_tank.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 272 ms
 * Timestamp: 10/27/2023 3:03:51 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hud;
#include maps/mp/zm_tomb_amb;
#include maps/mp/zm_tomb_utility;
#include maps/mp/zm_tomb_vo;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_craftables;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weap_staff_fire;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_zonemgr;

#using_animtree( "zm_tomb_tank" );

//Function Number: 1
tank_precache()
{
}

//Function Number: 2
init()
{
	registerclientfield("vehicle","tank_tread_fx",14000,1,"int");
	registerclientfield("vehicle","tank_flamethrower_fx",14000,2,"int");
	registerclientfield("vehicle","tank_cooldown_fx",14000,2,"int");
	tank_precache();
	onplayerconnect_callback(::onplayerconnect);
	level.enemy_location_override_func = ::enemy_location_override;
	level.adjust_enemyoverride_func = ::adjust_enemyoverride;
	level.zm_mantle_over_40_move_speed_override = ::zm_mantle_over_40_move_speed_override;
	level.vh_tank = getent("tank","targetname");
	level.vh_tank tank_setup();
	level.vh_tank thread tankuseanimtree();
	level.vh_tank thread tank_discovery_vo();
	level thread maps/mp/zm_tomb_vo::watch_occasional_line("tank","tank_flame_zombie","vo_tank_flame_zombie");
	level thread maps/mp/zm_tomb_vo::watch_occasional_line("tank","tank_leave","vo_tank_leave");
	level thread maps/mp/zm_tomb_vo::watch_occasional_line("tank","tank_cooling","vo_tank_cooling");
}

//Function Number: 3
onplayerconnect()
{
	self thread onplayerspawned();
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.b_already_on_tank = 0;
	}
}

//Function Number: 5
tank_discovery_vo()
{
	max_dist_sq = 640000;
	flag_wait("activate_zone_village_0");
	while(1)
	{
		a_players = getplayers();
		foreach(e_player in a_players)
		{
			dist_sq = distance2dsquared(level.vh_tank.origin,e_player.origin);
			height_diff = Abs(level.vh_tank.origin[2] - e_player.origin[2]);
			if(dist_sq < max_dist_sq && height_diff < 150 && !IsDefined(e_player.isspeaking) && e_player.isspeaking)
			{
				e_player maps/mp/zombies/_zm_audio::create_and_play_dialog("tank","discover_tank");
				return;
			}
		}

		wait(0.1);
	}
}

//Function Number: 6
tank_drop_powerups()
{
	flag_wait("start_zombie_round_logic");
	a_drop_nodes = [];
	for(i = 0;i < 3;i++)
	{
		drop_num = i + 1;
		a_drop_nodes[i] = getvehiclenode("tank_powerup_drop_" + drop_num,"script_noteworthy");
		a_drop_nodes[i].next_drop_round = level.round_number + i;
		s_drop = getstruct("tank_powerup_drop_" + drop_num,"targetname");
		a_drop_nodes[i].drop_pos = s_drop.origin;
	}

	a_possible_powerups = array("nuke","full_ammo","zombie_blood","insta_kill","fire_sale","double_points");
	while(1)
	{
		self ent_flag_wait("tank_moving");
		foreach(node in a_drop_nodes)
		{
			dist_sq = distance2dsquared(node.origin,self.origin);
			if(dist_sq < 250000)
			{
				a_players = get_players_on_tank(1);
				if(a_players.size > 0)
				{
					if(level.staff_part_count["elemental_staff_lightning"] == 0 && level.round_number >= node.next_drop_round)
					{
						str_powerup = random(a_possible_powerups);
						level thread maps/mp/zombies/_zm_powerups::specific_powerup_drop(str_powerup,node.drop_pos);
						node.next_drop_round = level.round_number + randomintrange(8,12);
					}
					else
					{
						level notify("sam_clue_tank",self);
					}
				}
			}
		}

		wait(2);
	}
}

//Function Number: 7
zm_mantle_over_40_move_speed_override()
{
	traversealias = "barrier_walk";
	switch(self.zombie_move_speed)
	{
		case "chase_bus":
			traversealias = "barrier_sprint";
			break;

		default:
	/#
			assertmsg("Zombie move speed of \'" + self.zombie_move_speed + "\' is not supported for mantle_over_40.");
	#/
			break;
	}

	return traversealias;
}

//Function Number: 8
init_animtree()
{
	scriptmodelsuseanimtree(-1);
}

//Function Number: 9
tankuseanimtree()
{
	self useanimtree(-1);
}

//Function Number: 10
drawtag(tag,opcolor)
{
/#
	org = self gettagorigin(tag);
	ang = self gettagangles(tag);
	box(org,VectorScale((-1,-1,0)),8,VectorScale((1,1,1)),8,ang[1],opcolor,1);
0
1
#/
}

//Function Number: 11
draw_tank_tag(tag,opcolor)
{
/#
	self endon("death");
	for(;;)
	{
		drawtag(tag.str_tag,VectorScale((0,1,0)));
		drawtag(tag.str_tag,VectorScale((1,0,0)));
		wait(0.05);
	}
(self tank_tag_is_valid(tag)) ? 255 : 255
#/
}

//Function Number: 12
tank_debug_tags()
{
/#
	setdvar("debug_tank","off");
	adddebugcommand("devgui_cmd \"Zombies:2/Tomb:1/Tank Debug:5\" \"debug_tank on\"\n");
	flag_wait("start_zombie_round_logic");
	a_spots = getstructarray("tank_jump_down_spots","script_noteworthy");
	for(;;)
	{
		_a224 = self.a_tank_tags;
		_k224 = FirstArrayKey(_a224);
		for(;;)
		{
			s_tag = _a224[_k224];
			self thread draw_tank_tag(s_tag);
			_k224 = NextArrayKey(_a224);
		}
		self.tags_drawing = 1;
		ang = self.angles;
		_a232 = a_spots;
		_k232 = FirstArrayKey(_a232);
		for(;;)
		{
			s_spot = _a232[_k232];
			org = self tank_get_jump_down_offset(s_spot);
			box(org,VectorScale((-1,-1,0)),4,VectorScale((1,1,1)),4,ang[1],VectorScale((1,1,0)),128);
			_k232 = NextArrayKey(_a232);
		}
		a_zombies = get_round_enemy_array();
		_a239 = a_zombies;
		_k239 = FirstArrayKey(_a239);
		for(;;)
		{
			e_zombie = _a239[_k239];
			print3d(60 + VectorScale((0,0,1)),e_zombie.origin,e_zombie.tank_state,VectorScale((1,0,0)));
			_k239 = NextArrayKey(_a239);
		}
		wait(0.05);
	}
_k239
255
1
IsDefined(e_zombie.tank_state)
IsDefined(_k239)
_k232
1
0
1
IsDefined(_k232)
_k224
IsDefined(_k224)
IsDefined(self.tags_drawing) && self.tags_drawing
GetDvar(#"55B41FB9") == "on"
1
#/
}

//Function Number: 13
tank_jump_down_store_offset(s_pos)
{
	v_up = AnglesToUp(self.angles);
	v_right = AnglesToRight(self.angles);
	v_fwd = AnglesToForward(self.angles);
	offset = s_pos.origin - self.origin;
	s_pos.tank_offset = (vectordot(v_fwd,offset),vectordot(v_right,offset),vectordot(v_up,offset));
}

//Function Number: 14
tank_get_jump_down_offset(s_pos)
{
	v_up = AnglesToUp(self.angles);
	v_right = AnglesToRight(self.angles);
	v_fwd = AnglesToForward(self.angles);
	v_offset = s_pos.tank_offset;
	return self.origin + v_offset[0] * v_fwd + v_offset[1] * v_right + v_offset[2] * v_up;
}

//Function Number: 15
tank_setup()
{
	self ent_flag_init("tank_moving");
	self ent_flag_init("tank_activated");
	self ent_flag_init("tank_cooldown");
	level.tank_boxes_enabled = 0;
	self.tag_occupied = [];
	self.health = 1000;
	self.n_players_on = 0;
	self.chase_pos_time = 0;
	self hidepart("tag_flamethrower");
	self setmovingplatformenabled(1);
	self.e_roof = getent("vol_on_tank_watch","targetname");
	self.e_roof enablelinkto();
	self.e_roof linkto(self);
	self.e_roof_extra = spawn("trigger_box",(-8192,-4010,52),0,160,70,16);
	self.e_roof_extra enablelinkto();
	self.e_roof_extra linkto(self);
	self.t_use = getent("trig_use_tank","targetname");
	self.t_use enablelinkto();
	self.t_use linkto(self);
	self.t_use sethintstring(&"ZM_TOMB_X2AT",500);
	self.t_kill = spawn("trigger_box",(-8192,-4300,36),0,200,150,80);
	self.t_kill enablelinkto();
	self.t_kill linkto(self);
	self.t_rear_tread[0] = spawn("trigger_box",(-8280,-3960,112),0,64,32,96);
	self.t_rear_tread[0].angles = VectorScale((0,1,0));
	self.t_rear_tread[0] enablelinkto();
	self.t_rear_tread[0] linkto(self);
	self.t_rear_tread[1] = spawn("trigger_box",(-8104,-3960,112),0,64,32,96);
	self.t_rear_tread[1].angles = VectorScale((0,1,0));
	self.t_rear_tread[1] enablelinkto();
	self.t_rear_tread[1] linkto(self);
	m_tank_path_blocker = getent("tank_path_blocker","targetname");
	m_tank_path_blocker delete();
	a_tank_jump_down_spots = getstructarray("tank_jump_down_spots","script_noteworthy");
	foreach(s_spot in a_tank_jump_down_spots)
	{
		self tank_jump_down_store_offset(s_spot);
	}

	self thread players_on_tank_update();
	self thread zombies_watch_tank();
	self thread tank_station();
	self thread tank_run_flamethrowers();
	self thread do_treadfx();
	self thread do_cooldown_fx();
	self thread tank_drop_powerups();
/#
	self thread tank_debug_tags();
#/
	self playloopsound("zmb_tank_idle",0.5);
}

//Function Number: 16
do_cooldown_fx()
{
	self endon("death");
	flag_wait("start_zombie_round_logic");
	while(1)
	{
		self setclientfield("tank_cooldown_fx",2);
		self ent_flag_wait("tank_moving");
		self setclientfield("tank_cooldown_fx",0);
		self ent_flag_wait("tank_cooldown");
		self setclientfield("tank_cooldown_fx",1);
		self ent_flag_waitopen("tank_cooldown");
	}
}

//Function Number: 17
do_treadfx()
{
	self endon("death");
	while(1)
	{
		self ent_flag_wait("tank_moving");
		self setclientfield("tank_tread_fx",1);
		self ent_flag_waitopen("tank_moving");
		self setclientfield("tank_tread_fx",0);
	}
}

//Function Number: 18
disconnect_reconnect_paths(vh_tank)
{
	self endon("death");
	while(1)
	{
		self disconnectpaths();
		wait(1);
		while(vh_tank getspeedmph() < 1)
		{
			wait(0.05);
		}

		self connectpaths();
		wait(0.5);
	}
}

//Function Number: 19
tank_rumble_update()
{
	while(self.b_already_on_tank)
	{
		if(level.vh_tank ent_flag("tank_moving"))
		{
			self setclientfieldtoplayer("player_rumble_and_shake",6);
		}
		else
		{
			self setclientfieldtoplayer("player_rumble_and_shake",0);
		}

		wait(1);
	}

	self setclientfieldtoplayer("player_rumble_and_shake",0);
}

//Function Number: 20
players_on_tank_update()
{
	flag_wait("start_zombie_round_logic");
	self thread tank_disconnect_paths();
	while(1)
	{
		a_players = getplayers();
		foreach(e_player in a_players)
		{
			if(is_player_valid(e_player))
			{
				if(IsDefined(e_player.b_already_on_tank) && !e_player.b_already_on_tank && e_player entity_on_tank())
				{
					e_player.b_already_on_tank = 1;
					self.n_players_on++;
					if(self ent_flag("tank_cooldown"))
					{
						level notify("vo_tank_cooling",e_player);
					}

					e_player thread tank_rumble_update();
					e_player thread tank_rides_around_map_achievement_watcher();
					e_player thread tank_force_crouch_from_prone_after_on_tank();
					foreach(trig in self.t_rear_tread)
					{
						e_player thread tank_push_player_off_edge(trig);
					}

					e_player allowcrouch(1);
					e_player allowprone(0);
				}
				else if(IsDefined(e_player.b_already_on_tank) && e_player.b_already_on_tank && !e_player entity_on_tank())
				{
					e_player.b_already_on_tank = 0;
					self.n_players_on--;
					level notify("vo_tank_leave",e_player,_k458);
					e_player notify("player_jumped_off_tank");
					e_player setclientfieldtoplayer("player_rumble_and_shake",0);
					e_player allowprone(1);
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
tank_force_crouch_from_prone_after_on_tank()
{
	self endon("disconnect");
	self endon("bled_out");
	wait(1);
	if("prone" == self getstance())
	{
		self setstance("crouch");
	}
}

//Function Number: 22
tank_push_player_off_edge(trig)
{
	self endon("player_jumped_off_tank");
	while(self.b_already_on_tank)
	{
		trig waittill("trigger",player);
		if(player == self && self isonground())
		{
			v_push = AnglesToForward(trig.angles) * 150;
			self setvelocity(v_push);
		}

		wait(0.05);
	}
}

//Function Number: 23
tank_rides_around_map_achievement_watcher()
{
	self endon("death_or_disconnect");
	self endon("player_jumped_off_tank");
	if(level.vh_tank ent_flag("tank_moving"))
	{
		level.vh_tank ent_flag_waitopen("tank_moving");
	}

	str_starting_location = level.vh_tank.str_location_current;
	level.vh_tank ent_flag_wait("tank_moving");
	level.vh_tank ent_flag_waitopen("tank_moving");
	if(!(str_starting_location != level.vh_tank.str_location_current))
	{
	}

	self notify("rode_tank_around_map");
}

//Function Number: 24
entity_on_tank()
{
	if(self istouching(level.vh_tank.e_roof) || self istouching(level.vh_tank.e_roof_extra))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
tank_station()
{
	self thread tank_watch_use();
	self thread tank_movement();
	a_call_boxes = getentarray("trig_tank_station_call","targetname");
	foreach(t_call_box in a_call_boxes)
	{
		t_call_box thread tank_call_box();
	}

	self.t_use waittill(_k563,"trigger");
	level.tank_boxes_enabled = 1;
}

//Function Number: 26
tank_left_behind()
{
	wait(4);
	n_valid_dist_sq = 1000000;
	a_riders = get_players_on_tank(1);
	if(a_riders.size == 0)
	{
		return;
	}

	e_rider = random(a_riders);
	a_players = getplayers();
	a_victims = [];
	v_tank_fwd = AnglesToForward(self.angles);
	foreach(e_player in a_players)
	{
		if(IsDefined(e_player.b_already_on_tank) && e_player.b_already_on_tank)
		{
		}
		else if(distance2dsquared(e_player.origin,self.origin) > n_valid_dist_sq)
		{
		}
		else
		{
			v_to_tank = self.origin - e_player.origin;
			v_to_tank = vectornormalize(v_to_tank);
			if(vectordot(v_to_tank,v_tank_fwd) < 0)
			{
			}
			else
			{
				v_player_fwd = AnglesToForward(e_player.angles);
				if(vectordot(v_player_fwd,v_to_tank) < 0)
				{
				}
				else
				{
					a_victims[a_victims.size] = e_player;
				}
			}
		}
	}

	if(a_victims.size == 0)
	{
		return;
	}

	e_victim = random(a_victims);
	maps/mp/zm_tomb_vo::tank_left_behind_vo(e_victim,e_rider);
}

//Function Number: 27
tank_watch_use()
{
	while(1)
	{
		self.t_use waittill("trigger",e_player);
		level thread maps/mp/zm_tomb_amb::sndplaystingerwithoverride("mus_event_tank_ride",70);
		cooling_down = self ent_flag("tank_cooldown");
		if(is_player_valid(e_player) && e_player.score >= 500 && !cooling_down)
		{
			self ent_flag_set("tank_activated");
			self ent_flag_set("tank_moving");
			e_player thread maps/mp/zombies/_zm_audio::create_and_play_dialog("tank","tank_buy");
			self thread tank_left_behind();
			e_player maps/mp/zombies/_zm_score::minus_to_player_score(500);
			self waittill("tank_stop");
			self playsound("zmb_tank_stop");
			self stoploopsound(1.5);
			if(IsDefined(self.b_call_box_used) && self.b_call_box_used)
			{
				self.b_call_box_used = 0;
				self activate_tank_wait_with_no_cost();
			}
		}
	}
}

//Function Number: 28
activate_tank_wait_with_no_cost()
{
	self endon("call_box_used");
	self.b_no_cost = 1;
	wait(0.05);
	self ent_flag_waitopen("tank_cooldown");
	self.t_use waittill("trigger",e_player);
	self ent_flag_set("tank_activated");
	self ent_flag_set("tank_moving");
	self.b_no_cost = 0;
}

//Function Number: 29
tank_call_box()
{
	while(1)
	{
		self waittill("trigger",e_player);
		cooling_down = level.vh_tank ent_flag("tank_cooldown");
		if(!level.vh_tank ent_flag("tank_activated") && e_player.score >= 500 && !cooling_down)
		{
			level.vh_tank notify("call_box_used");
			level.vh_tank.b_call_box_used = 1;
			e_switch = getent(self.target,"targetname");
			self setinvisibletoall();
			wait(0.05);
			e_switch rotatepitch(-180,0.5);
			e_switch waittill("rotatedone");
			e_switch rotatepitch(180,0.5);
			level.vh_tank.t_use useby(e_player);
			level.vh_tank waittill("tank_stop");
		}
	}
}

//Function Number: 30
tank_call_boxes_update()
{
	str_loc = level.vh_tank.str_location_current;
	a_trigs = getentarray("trig_tank_station_call","targetname");
	moving = level.vh_tank ent_flag("tank_moving");
	cooling = level.vh_tank ent_flag("tank_cooldown");
	foreach(trig in a_trigs)
	{
		at_this_station = trig.script_noteworthy == "call_box_" + str_loc;
		if(moving)
		{
			trig setvisibletoall();
			trig sethintstring(&"ZM_TOMB_TNKM");
		}
		else if(!level.tank_boxes_enabled || at_this_station)
		{
			trig setinvisibletoall();
		}
		else if(cooling)
		{
			trig setvisibletoall();
			trig sethintstring(&"ZM_TOMB_TNKC");
		}
		else
		{
			trig setvisibletoall();
			trig sethintstring(&"ZM_TOMB_X2CT",500);
		}
	}
}

//Function Number: 31
tank_movement()
{
	n_path_start = getvehiclenode("tank_start","targetname");
	self attachpath(n_path_start);
	self startpath();
	self thread follow_path(n_path_start);
	self setspeedimmediate(0);
	self.a_locations = array("village","bunkers");
	n_location_index = 0;
	self.str_location_current = self.a_locations[n_location_index];
	tank_call_boxes_update();
	while(1)
	{
		self ent_flag_wait("tank_activated");
/#
		iprintln("The tank is moving.");
#/
		self thread tank_connect_paths();
		self playsound("evt_tank_call");
		self setspeedimmediate(8);
		self.t_use setinvisibletoall();
		tank_call_boxes_update();
		self thread tank_kill_players();
		self thread tank_cooldown_timer();
		self waittill("tank_stop");
		self ent_flag_set("tank_cooldown");
		self.t_use setvisibletoall();
		self.t_use sethintstring(&"ZM_TOMB_TNKC");
		self ent_flag_clear("tank_moving");
		self thread tank_disconnect_paths();
		self setspeedimmediate(0);
		n_location_index++;
		if(n_location_index == self.a_locations.size)
		{
			n_location_index = 0;
		}

		self.str_location_current = self.a_locations[n_location_index];
		tank_call_boxes_update();
		self wait_for_tank_cooldown();
		self ent_flag_clear("tank_cooldown");
		if(IsDefined(self.b_no_cost) && self.b_no_cost)
		{
			self.t_use sethintstring(&"ZM_TOMB_X2ATF");
		}
		else
		{
			self.t_use sethintstring(&"ZM_TOMB_X2AT",500);
		}

		self ent_flag_clear("tank_activated");
		tank_call_boxes_update();
	}
}

//Function Number: 32
tank_disconnect_paths()
{
	self endon("death");
	while(self getspeedmph() > 0)
	{
		wait(0.05);
	}

	self disconnectpaths();
}

//Function Number: 33
tank_connect_paths()
{
	self endon("death");
	self connectpaths();
}

//Function Number: 34
tank_kill_players()
{
	self endon("tank_cooldown");
	while(1)
	{
		self.t_kill waittill("trigger",player);
		if(!(IsDefined(player.b_tank_ran_me_over) && player.b_tank_ran_me_over))
		{
			player thread tank_ran_me_over();
			wait(0.05);
		}
	}
}

//Function Number: 35
tank_ran_me_over()
{
	self.b_tank_ran_me_over = 1;
	self disableinvulnerability();
	self dodamage(self.health + 1000,self.origin);
	a_nodes = getnodesinradiussorted(self.origin,256,0,72,"path",15);
	foreach(node in a_nodes)
	{
		str_zone = maps/mp/zombies/_zm_zonemgr::get_zone_from_position(node.origin);
		if(!(IsDefined(str_zone)))
		{
		}
		else if(!(IsDefined(node.b_player_downed_here) && node.b_player_downed_here))
		{
			start_wait = 0;
			black_screen_wait = 4;
			fade_in_time = 0.01;
			fade_out_time = 0.2;
			self thread maps/mp/gametypes_zm/_hud::fadetoblackforxsec(start_wait,black_screen_wait,fade_in_time,fade_out_time,"black");
			node.b_player_downed_here = 1;
			e_linker = spawn("script_origin",self.origin);
			self playerlinkto(e_linker);
			e_linker moveto(8 + VectorScale((0,0,1)),node.origin);
			e_linker wait_to_unlink(self);
			node.b_player_downed_here = undefined;
			e_linker delete();
			self.b_tank_ran_me_over = undefined;
			return;
		}
	}

	self.b_tank_ran_me_over = undefined;
}

//Function Number: 36
wait_to_unlink(player)
{
	player endon("disconnect");
	wait(4);
	self unlink();
}

//Function Number: 37
tank_cooldown_timer()
{
	self.n_cooldown_timer = 0;
	str_location_original = self.str_location_current;
	self playsound("zmb_tank_start");
	self stoploopsound(0.4);
	wait(0.4);
	self playloopsound("zmb_tank_loop",1);
	while(str_location_original == self.str_location_current)
	{
		self.n_cooldown_timer = self.n_cooldown_timer + self.n_players_on * 0.05;
		wait(0.05);
	}
}

//Function Number: 38
wait_for_tank_cooldown()
{
	self thread snd_fuel();
	if(self.n_cooldown_timer < 2)
	{
		self.n_cooldown_timer = 2;
	}
	else if(self.n_cooldown_timer > 120)
	{
		self.n_cooldown_timer = 120;
	}

	wait(self.n_cooldown_timer);
	level notify("stp_cd");
	self playsound("zmb_tank_ready");
	self playloopsound("zmb_tank_idle");
}

//Function Number: 39
snd_fuel()
{
	snd_cd_ent = spawn("script_origin",self.origin);
	snd_cd_ent linkto(self);
	wait(4);
	snd_cd_ent playsound("zmb_tank_fuel_start");
	wait(0.5);
	snd_cd_ent playloopsound("zmb_tank_fuel_loop");
	level waittill("stp_cd");
	snd_cd_ent stoploopsound(0.5);
	snd_cd_ent playsound("zmb_tank_fuel_end");
	wait(2);
	snd_cd_ent delete();
}

//Function Number: 40
follow_path(n_path_start)
{
	self endon("death");
/#
	assert(IsDefined(n_path_start),"vehicle_path() called without a path");
#/
	self notify("newpath");
	self endon("newpath");
	n_next_point = n_path_start;
	while(IsDefined(n_next_point))
	{
		self.n_next_node = getvehiclenode(n_next_point.target,"targetname");
		self waittill("reached_node",n_next_point);
		self.n_current = n_next_point;
		n_next_point notify("trigger",self);
		if(IsDefined(n_next_point.script_noteworthy))
		{
			self notify(n_next_point.script_noteworthy);
			self notify("noteworthy",n_next_point.script_noteworthy,n_next_point);
		}

		waittillframeend;
	}
}

//Function Number: 41
tank_tag_array_setup()
{
	a_tank_tags = [];
	a_tank_tags[0] = spawnstruct();
	a_tank_tags[0].str_tag = "window_left_1_jmp_jnt";
	a_tank_tags[0].disabled_at_bunker = 1;
	a_tank_tags[0].disabled_at_church = 1;
	a_tank_tags[0].side = "left";
	a_tank_tags[1] = spawnstruct();
	a_tank_tags[1].str_tag = "window_left_2_jmp_jnt";
	a_tank_tags[1].disabled_at_bunker = 1;
	a_tank_tags[1].disabled_at_church = 1;
	a_tank_tags[1].side = "left";
	a_tank_tags[2] = spawnstruct();
	a_tank_tags[2].str_tag = "window_left_3_jmp_jnt";
	a_tank_tags[2].disabled_at_bunker = 1;
	a_tank_tags[2].disabled_at_church = 1;
	a_tank_tags[2].side = "left";
	a_tank_tags[3] = spawnstruct();
	a_tank_tags[3].str_tag = "window_right_front_jmp_jnt";
	a_tank_tags[3].side = "front";
	a_tank_tags[4] = spawnstruct();
	a_tank_tags[4].str_tag = "window_right_1_jmp_jnt";
	a_tank_tags[4].side = "right";
	a_tank_tags[5] = spawnstruct();
	a_tank_tags[5].str_tag = "window_right_2_jmp_jnt";
	a_tank_tags[5].disabled_at_church = 1;
	a_tank_tags[5].side = "right";
	a_tank_tags[6] = spawnstruct();
	a_tank_tags[6].str_tag = "window_right_3_jmp_jnt";
	a_tank_tags[6].disabled_at_church = 1;
	a_tank_tags[6].side = "right";
	a_tank_tags[7] = spawnstruct();
	a_tank_tags[7].str_tag = "window_left_rear_jmp_jnt";
	a_tank_tags[7].side = "rear";
	return a_tank_tags;
}

//Function Number: 42
get_players_on_tank(valid_targets_only)
{
	if(!(IsDefined(valid_targets_only)))
	{
		valid_targets_only = 0;
	}

	a_players_on_tank = [];
	a_players = getplayers();
	foreach(e_player in a_players)
	{
		if(is_player_valid(e_player) && IsDefined(e_player.b_already_on_tank) && e_player.b_already_on_tank)
		{
			if(!valid_targets_only || !IsDefined(e_player.ignoreme) && e_player.ignoreme && is_player_valid(e_player))
			{
				a_players_on_tank[a_players_on_tank.size] = e_player;
			}
		}
	}

	return a_players_on_tank;
}

//Function Number: 43
mechz_tag_array_setup()
{
	a_mechz_tags = [];
	a_mechz_tags[0] = spawnstruct();
	a_mechz_tags[0].str_tag = "tag_mechz_1";
	a_mechz_tags[0].in_use = 0;
	a_mechz_tags[0].in_use_by = undefined;
	a_mechz_tags[1] = spawnstruct();
	a_mechz_tags[1].str_tag = "tag_mechz_2";
	a_mechz_tags[1].in_use = 0;
	a_mechz_tags[1].in_use_by = undefined;
	a_mechz_tags[2] = spawnstruct();
	a_mechz_tags[2].str_tag = "tag_mechz_3";
	a_mechz_tags[2].in_use = 0;
	a_mechz_tags[2].in_use_by = undefined;
	a_mechz_tags[3] = spawnstruct();
	a_mechz_tags[3].str_tag = "tag_mechz_4";
	a_mechz_tags[3].in_use = 0;
	a_mechz_tags[3].in_use_by = undefined;
	return a_mechz_tags;
}

//Function Number: 44
mechz_tag_in_use_cleanup(mechz,tag_struct_index)
{
	mechz notify("kill_mechz_tag_in_use_cleanup");
	mechz endon("kill_mechz_tag_in_use_cleanup");
	mechz waittill_any_or_timeout(30,"death","kill_ft","tank_flamethrower_attack_complete");
	self.a_mechz_tags[tag_struct_index].in_use = 0;
	self.a_mechz_tags[tag_struct_index].in_use_by = undefined;
}

//Function Number: 45
get_closest_mechz_tag_on_tank(mechz,target_org)
{
	best_dist = -1;
	best_tag_index = undefined;
	for(i = 0;i < self.a_mechz_tags.size;i++)
	{
		if(self.a_mechz_tags[i].in_use && self.a_mechz_tags[i].in_use_by != mechz)
		{
		}
		else
		{
			s_tag = self.a_mechz_tags[i];
			tag_org = self gettagorigin(s_tag.str_tag);
			dist = distancesquared(tag_org,target_org);
			if(dist < best_dist || best_dist < 0)
			{
				best_dist = dist;
				best_tag_index = i;
			}
		}
	}

	if(IsDefined(best_tag_index))
	{
		for(i = 0;i < self.a_mechz_tags.size;i++)
		{
			if(self.a_mechz_tags[i].in_use && self.a_mechz_tags[i].in_use_by == mechz)
			{
				self.a_mechz_tags[i].in_use = 0;
				self.a_mechz_tags[i].in_use_by = undefined;
			}
		}

		self.a_mechz_tags[best_tag_index].in_use = 1;
		self.a_mechz_tags[best_tag_index].in_use_by = mechz;
		self thread mechz_tag_in_use_cleanup(mechz,best_tag_index);
		return self.a_mechz_tags[best_tag_index].str_tag;
	}

	return undefined;
}

//Function Number: 46
tank_tag_is_valid(s_tag,disable_sides)
{
	if(!(IsDefined(disable_sides)))
	{
		disable_sides = 0;
	}

	if(disable_sides)
	{
		if(s_tag.side == "right" || s_tag.side == "left")
		{
			return 0;
		}
	}

	if(self ent_flag("tank_moving"))
	{
		if(s_tag.side == "front")
		{
			return 0;
		}

		if(!(IsDefined(self.n_next_node)))
		{
			return 1;
		}

		if(!(IsDefined(self.n_next_node.script_string)))
		{
			return 1;
		}

		if(issubstr(self.n_next_node.script_string,"disable_" + s_tag.side))
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	at_church = self.str_location_current == "village";
	at_bunker = self.str_location_current == "bunkers";
	if(at_church)
	{
		return !IsDefined(s_tag.disabled_at_church) && s_tag.disabled_at_church;
	}
	else if(at_bunker)
	{
		return !IsDefined(s_tag.disabled_at_bunker) && s_tag.disabled_at_bunker;
	}

	return 1;
}

//Function Number: 47
zombies_watch_tank()
{
	a_tank_tags = tank_tag_array_setup();
	self.a_tank_tags = a_tank_tags;
	a_mechz_tags = mechz_tag_array_setup();
	self.a_mechz_tags = a_mechz_tags;
	while(1)
	{
		a_zombies = get_round_enemy_array();
		foreach(e_zombie in a_zombies)
		{
			if(!(IsDefined(e_zombie.tank_state)))
			{
				e_zombie thread tank_zombie_think();
			}
		}

		wait_network_frame();
	}
}

//Function Number: 48
start_chasing_tank()
{
	self.tank_state = "tank_chase";
}

//Function Number: 49
stop_chasing_tank()
{
	self.tank_state = "none";
	self.str_tank_tag = undefined;
	self.tank_tag = undefined;
	self.b_on_tank = 0;
	self.tank_re_eval_time = undefined;
	self notify("change_goal");
	if(IsDefined(self.zombie_move_speed_original))
	{
		self set_zombie_run_cycle(self.zombie_move_speed_original);
	}
}

//Function Number: 50
choose_tag_and_chase()
{
	s_tag = self get_closest_valid_tank_tag();
	if(IsDefined(s_tag))
	{
		self.str_tank_tag = s_tag.str_tag;
		self.tank_tag = s_tag;
		self.tank_state = "tag_chase";
	}
	else
	{
		wait(1);
	}
}

//Function Number: 51
choose_tag_and_jump_down()
{
	s_tag = self get_closest_valid_tank_tag(1);
	if(IsDefined(s_tag))
	{
		self.str_tank_tag = s_tag.str_tag;
		self.tank_tag = getstruct(s_tag.str_tag + "_down_start","targetname");
		self.tank_state = "exit_tank";
		self set_zombie_run_cycle("walk");
/#
		assert(IsDefined(self.tank_tag));
#/
	}
	else
	{
		wait(1);
	}
}

//Function Number: 52
climb_tag()
{
	self endon("death");
	self.tank_state = "climbing";
	self.b_on_tank = 1;
	str_tag = self.str_tank_tag;
	self linkto(level.vh_tank,str_tag);
	v_tag_origin = level.vh_tank gettagorigin(str_tag);
	v_tag_angles = level.vh_tank gettagangles(str_tag);
	str_anim_alias = str_tag;
	if(level.vh_tank ent_flag("tank_moving") && str_tag == "window_left_rear_jmp_jnt")
	{
		str_anim_alias = "window_rear_long_jmp_jnt";
	}

	if(!(self.has_legs))
	{
		str_anim_alias = str_anim_alias + "_crawler";
	}

	n_anim_index = self getanimsubstatefromasd("zm_tank_jump_up",str_anim_alias);
	self.b_climbing_tank = 1;
	self animscripted(v_tag_origin,v_tag_angles,"zm_tank_jump_up",n_anim_index);
	self zombieanimnotetrackthink("tank_jump_up");
	self unlink();
	self.b_climbing_tank = 0;
	level.vh_tank tank_mark_tag_occupied(str_tag,self,0);
	set_zombie_on_tank();
}

//Function Number: 53
set_zombie_on_tank()
{
	self setgoalpos(self.origin);
	self thread maps/mp/zombies/_zm_ai_basic::find_flesh();
	self.tank_state = "on_tank";
}

//Function Number: 54
jump_down_tag()
{
	self endon("death");
	self.tank_state = "jumping_down";
	str_tag = self.str_tank_tag;
	self linkto(level.vh_tank,str_tag);
	v_tag_origin = level.vh_tank gettagorigin(str_tag);
	v_tag_angles = level.vh_tank gettagangles(str_tag);
	self setgoalpos(v_tag_origin);
	str_anim_alias = str_tag;
	if(!(self.has_legs))
	{
		str_anim_alias = str_anim_alias + "_crawler";
	}

	n_anim_index = self getanimsubstatefromasd("zm_tank_jump_down",str_anim_alias);
	self.b_climbing_tank = 1;
	self animscripted(v_tag_origin,v_tag_angles,"zm_tank_jump_down",n_anim_index);
	self zombieanimnotetrackthink("tank_jump_down");
	self unlink();
	self.b_climbing_tank = 0;
	level.vh_tank tank_mark_tag_occupied(str_tag,self,0);
	self.pursuing_tank_tag = 0;
	stop_chasing_tank();
}

//Function Number: 55
watch_zombie_fall_off_tank()
{
	self endon("death");
	while(1)
	{
		if(self.tank_state == "on_tank" || self.tank_state == "exit_tank")
		{
			if(!(self entity_on_tank()))
			{
				stop_chasing_tank();
			}

			wait(0.5);
		}
		else if(self.tank_state == "none")
		{
			if(self entity_on_tank())
			{
				set_zombie_on_tank();
			}

			wait(5);
		}

		wait_network_frame();
	}
}

//Function Number: 56
in_range_2d(v1,v2,range,vert_allowance)
{
	if(Abs(v1[2] - v2[2]) > vert_allowance)
	{
		return 0;
	}

	return distance2dsquared(v1,v2) < range * range;
}

//Function Number: 57
tank_zombie_think()
{
	self endon("death");
	self.tank_state = "none";
	self thread watch_zombie_fall_off_tank();
	think_time = 0.5;
	while(1)
	{
		a_players_on_tank = get_players_on_tank(1);
		tag_range = 32;
		if(level.vh_tank ent_flag("tank_moving"))
		{
			tag_range = 64;
		}

		switch(self.tank_state)
		{
			case "none":
				break;
				self start_chasing_tank();
				continue;
				a_players = getplayers();
				a_eligible_players = [];
				_a1495 = a_players;
				_k1495 = FirstArrayKey(_a1495);
				for(;;)
				{
					e_player = _a1495[_k1495];
					a_eligible_players[a_eligible_players.size] = e_player;
					_k1495 = NextArrayKey(_a1495);
				}
	
				self.favoriteenemy = random(a_eligible_players);
				continue;
				self.favoriteenemy = tomb_get_closest_player_using_paths(self.origin,a_eligible_players);
				break;
	a_players_on_tank.size == a_players.size
	a_eligible_players.size > 0
	_k1495
	!IsDefined(e_player.ignoreme) && e_player.ignoreme && is_player_valid(e_player)
	IsDefined(_k1495)
	IsDefined(self.favoriteenemy.b_already_on_tank) && self.favoriteenemy.b_already_on_tank
	is_player_valid(self.favoriteenemy)
	a_players_on_tank.size == 0
	!IsDefined(self.ai_state) || self.ai_state != "find_flesh"
				break;

			case "tank_chase":
				self stop_chasing_tank();
				break;
				dist_sq_to_tank = distancesquared(self.origin,level.vh_tank.origin);
				self choose_tag_and_chase();
				self set_zombie_run_cycle("super_sprint");
				self thread zombie_chasing_tank_turn_crawler();
				break;
	level.vh_tank ent_flag("tank_moving")
	self.has_legs && self.zombie_move_speed != "super_sprint" && !IsDefined(self.is_traversing) && self.is_traversing && self.ai_state == "find_flesh"
	dist_sq_to_tank < 250000
	a_players_on_tank.size == 0
				break;

			case "tag_chase":
				self.tank_re_eval_time = 6;
				self set_zombie_on_tank();
				continue;
				self stop_chasing_tank();
				break;
				self notify("stop_path_to_tag",(IsDefined(self.tank_re_eval_time)) ? self.tank_re_eval_time <= 0 : self entity_on_tank());
				self stop_chasing_tank();
				break;
				dist_sq_to_tank = distancesquared(self.origin,level.vh_tank.origin);
				start_chasing_tank();
				break;
				v_tag = level.vh_tank gettagorigin(self.str_tank_tag);
				tag_claimed = level.vh_tank tank_mark_tag_occupied(self.str_tank_tag,self,1);
				self thread climb_tag();
				continue;
				self thread update_zombie_goal_pos(self.str_tank_tag,"stop_path_to_tag");
				self.tank_re_eval_time = self.tank_re_eval_time - think_time;
				break;
	tag_claimed
	in_range_2d(v_tag,self.origin,tag_range,tag_range)
	dist_sq_to_tank > 1000000 || a_players_on_tank.size == 0
	a_players_on_tank.size == 0
				break;

			case "climbing":
				break;

			case "on_tank":
				choose_tag_and_jump_down();
				continue;
				self.favoriteenemy = random(a_players_on_tank);
				break;
	!IsDefined(self.favoriteenemy) || !is_player_valid(self.favoriteenemy,1)
	a_players_on_tank.size == 0
				break;

			case "exit_tank":
				self notify("stop_exit_tank");
				set_zombie_on_tank();
				break;
				v_tag_pos = level.vh_tank tank_get_jump_down_offset(self.tank_tag);
				tag_claimed = level.vh_tank tank_mark_tag_occupied(self.str_tank_tag,self,1);
				self thread jump_down_tag();
				continue;
				self thread update_zombie_goal_pos(self.tank_tag.targetname,"stop_exit_tank");
				wait(1);
				break;
	tag_claimed
	in_range_2d(v_tag_pos,self.origin,tag_range,tag_range)
	a_players_on_tank.size > 0
				break;

			case "jumping_down":
				break;
		}

		wait(think_time);
	}
}

//Function Number: 58
update_zombie_goal_pos(str_position,stop_notify)
{
	self notify("change_goal");
	self endon("death");
	self endon("goal");
	self endon("near_goal");
	self endon("change_goal");
	if(IsDefined(stop_notify))
	{
		self endon(stop_notify);
	}

	s_script_origin = getstruct(str_position,"targetname");
	while(self.tank_state != "none")
	{
		if(IsDefined(s_script_origin))
		{
			v_origin = level.vh_tank tank_get_jump_down_offset(s_script_origin);
/#
			line(30 + VectorScale((0,0,1)),self.origin);
v_origin
GetDvar(#"55B41FB9") == "on"
#/
		}
		else
		{
			v_origin = level.vh_tank gettagorigin(str_position);
		}

		self setgoalpos(v_origin);
		wait(0.05);
	}
}

//Function Number: 59
zombie_chasing_tank_turn_crawler()
{
	self notify("tank_watch_turn_crawler");
	self endon("tank_watch_turn_crawler");
	self endon("death");
	while(self.has_legs)
	{
		wait(0.05);
	}

	self set_zombie_run_cycle(self.zombie_move_speed_original);
}

//Function Number: 60
tank_mark_tag_occupied(str_tag,ai_occupier,set_occupied)
{
	current_occupier = self.tag_occupied[str_tag];
	min_dist_sq_to_tag = 1024;
	if(set_occupied)
	{
		if(!(IsDefined(current_occupier)))
		{
			self.tag_occupied[str_tag] = ai_occupier;
			return 1;
		}
		else if(ai_occupier == current_occupier || !isalive(current_occupier))
		{
			dist_sq_to_tag = distance2dsquared(ai_occupier.origin,self gettagorigin(str_tag));
			if(dist_sq_to_tag < min_dist_sq_to_tag)
			{
				self.tag_occupied[str_tag] = ai_occupier;
				return 1;
			}
		}

		return 0;
	}
	else if(!(IsDefined(current_occupier)))
	{
		return 1;
	}
	else if(current_occupier != ai_occupier)
	{
		return 0;
	}
	else
	{
		self.tag_occupied[str_tag] = undefined;
		return 1;
	}
}

//Function Number: 61
is_tag_crowded(str_tag)
{
	v_tag = self gettagorigin(str_tag);
	a_zombies = getaiarray(level.zombie_team);
	n_nearby_zombies = 0;
	foreach(e_zombie in a_zombies)
	{
		dist_sq = distancesquared(v_tag,e_zombie.origin);
		if(dist_sq < 4096)
		{
			if(IsDefined(e_zombie.tank_state))
			{
				if(e_zombie.tank_state != "tank_chase" && e_zombie.tank_state != "tag_chase" && e_zombie.tank_state != "none")
				{
				}
				else
				{
					n_nearby_zombies++;
					if(n_nearby_zombies >= 4)
					{
						return 1;
					}
				}
			}
		}
	}

	return 0;
}

//Function Number: 62
get_closest_valid_tank_tag(jumping_down)
{
	if(!(IsDefined(jumping_down)))
	{
		jumping_down = 0;
	}

	closest_dist_sq = 100000000;
	closest_tag = undefined;
	disable_sides = 0;
	if(jumping_down && level.vh_tank ent_flag("tank_moving"))
	{
		disable_sides = 1;
	}

	foreach(s_tag in level.vh_tank.a_tank_tags)
	{
		if(level.vh_tank tank_tag_is_valid(s_tag,disable_sides))
		{
			v_tag = level.vh_tank gettagorigin(s_tag.str_tag);
			dist_sq = distancesquared(self.origin,v_tag);
			if(dist_sq < closest_dist_sq)
			{
				if(!(level.vh_tank is_tag_crowded(s_tag.str_tag)))
				{
					closest_tag = s_tag;
					closest_dist_sq = dist_sq;
				}
			}
		}
	}

	return closest_tag;
}

//Function Number: 63
zombieanimnotetrackthink(str_anim_notetrack_notify,chunk,node)
{
	self endon("death");
	while(1)
	{
		self waittill(str_anim_notetrack_notify,str_notetrack);
		if(str_notetrack == "end")
		{
			return;
		}
	}
}

//Function Number: 64
tank_run_flamethrowers()
{
	self thread tank_flamethrower("tag_flash",1);
	wait(0.25);
	self thread tank_flamethrower("tag_flash_gunner1",2);
	wait(0.25);
	self thread tank_flamethrower("tag_flash_gunner2",3);
}

//Function Number: 65
tank_flamethrower_get_targets(str_tag,n_flamethrower_id)
{
	a_zombies = getaiarray(level.zombie_team);
	a_targets = [];
	v_tag_pos = self gettagorigin(str_tag);
	v_tag_angles = self gettagangles(str_tag);
	v_tag_fwd = AnglesToForward(v_tag_angles);
	v_kill_pos = v_tag_pos + v_tag_fwd * 80;
	foreach(ai_zombie in a_zombies)
	{
		dist_sq = distance2dsquared(ai_zombie.origin,v_kill_pos);
		if(dist_sq > 80 * 80)
		{
		}
		else if(IsDefined(ai_zombie.tank_state))
		{
			if(ai_zombie.tank_state == "climbing" || ai_zombie.tank_state == "jumping_down")
			{
			}
			else
			{
				v_to_zombie = vectornormalize(ai_zombie.origin - v_tag_pos);
				n_dot = vectordot(v_tag_fwd,ai_zombie.origin);
				if(n_dot < 0.95)
				{
				}
				else
				{
					a_targets[a_targets.size] = ai_zombie;
				}
			}
		}
	}

	return a_targets;
}

//Function Number: 66
tank_flamethrower_cycle_targets(str_tag,n_flamethrower_id)
{
	self endon("flamethrower_stop_" + n_flamethrower_id);
	while(1)
	{
		a_targets = tank_flamethrower_get_targets(str_tag,n_flamethrower_id);
		foreach(ai in a_targets)
		{
			if(isalive(ai))
			{
				self setturrettargetent(ai);
				wait(1);
			}
		}

		wait(1);
	}
}

//Function Number: 67
tank_flamethrower(str_tag,n_flamethrower_id)
{
	zombieless_waits = 0;
	time_between_flames = randomfloatrange(3,6);
	while(1)
	{
		wait(1);
		if(n_flamethrower_id == 1)
		{
			self setturrettargetvec(self.origin + AnglesToForward(self.angles) * 1000);
		}

		self ent_flag_wait("tank_moving");
		a_targets = tank_flamethrower_get_targets(str_tag,n_flamethrower_id);
		if(a_targets.size > 0 || zombieless_waits > time_between_flames)
		{
			self setclientfield("tank_flamethrower_fx",n_flamethrower_id);
			self thread flamethrower_damage_zombies(n_flamethrower_id,str_tag);
			if(n_flamethrower_id == 1)
			{
				self thread tank_flamethrower_cycle_targets(str_tag,n_flamethrower_id);
			}

			if(a_targets.size > 0)
			{
				wait(6);
			}
			else
			{
				wait(3);
			}

			self setclientfield("tank_flamethrower_fx",0);
			self notify("flamethrower_stop_" + n_flamethrower_id);
			zombieless_waits = 0;
			time_between_flames = randomfloatrange(3,6);
			continue;
		}

		zombieless_waits++;
	}
}

//Function Number: 68
flamethrower_damage_zombies(n_flamethrower_id,str_tag)
{
	self endon("flamethrower_stop_" + n_flamethrower_id);
	while(1)
	{
		a_targets = tank_flamethrower_get_targets(str_tag,n_flamethrower_id);
		foreach(ai_zombie in a_targets)
		{
			if(isalive(ai_zombie))
			{
				a_players = get_players_on_tank(1);
				if(a_players.size > 0)
				{
					level notify("vo_tank_flame_zombie",random(a_players));
				}

				if(str_tag == "tag_flash")
				{
					ai_zombie do_damage_network_safe(self,ai_zombie.health,"zm_tank_flamethrower","MOD_BURNED");
					ai_zombie thread zombie_gib_guts();
				}
				else
				{
					ai_zombie thread maps/mp/zombies/_zm_weap_staff_fire::flame_damage_fx("zm_tank_flamethrower",self);
				}

				wait(0.05);
			}
		}

		wait_network_frame();
	}
}

//Function Number: 69
enemy_location_override()
{
	self endon("death");
	enemy = self.favoriteenemy;
	location = enemy.origin;
	tank = level.vh_tank;
	if(IsDefined(self.is_mechz) && self.is_mechz)
	{
		return location;
	}

	if(IsDefined(self.item))
	{
		return self.origin;
	}

	if(is_true(self.reroute))
	{
		if(IsDefined(self.reroute_origin))
		{
			location = self.reroute_origin;
		}
	}

	if(IsDefined(self.tank_state))
	{
		if(self.tank_state == "tank_chase")
		{
			self.goalradius = 128;
		}
		else if(self.tank_state == "tag_chase")
		{
			self.goalradius = 16;
		}
		else
		{
			self.goalradius = 32;
		}

		if(self.tank_state == "tank_chase" || self.tank_state == "none" && IsDefined(enemy.b_already_on_tank) && enemy.b_already_on_tank)
		{
			tank_front = tank gettagorigin("window_right_front_jmp_jnt");
			tank_back = tank gettagorigin("window_left_rear_jmp_jnt");
			if(tank ent_flag("tank_moving"))
			{
				self.ignoreall = 1;
				if(!(IsDefined(self.close_to_tank) && self.close_to_tank))
				{
					if(GetTime() != tank.chase_pos_time)
					{
						tank.chase_pos_time = GetTime();
						tank.chase_pos_index = 0;
						tank_forward = vectornormalize(AnglesToForward(level.vh_tank.angles));
						tank_right = vectornormalize(AnglesToRight(level.vh_tank.angles));
						tank.chase_pos = [];
						tank.chase_pos[0] = -164 + VectorScale(tank_forward);
						tank.chase_pos[1] = tank_front;
						tank.chase_pos[2] = tank_back;
					}

					location = tank.chase_pos[tank.chase_pos_index];
					tank.chase_pos_index++;
					if(tank.chase_pos_index >= 3)
					{
						tank.chase_pos_index = 0;
					}

					dist_sq = distancesquared(self.origin,location);
					if(dist_sq < 4096)
					{
						self.close_to_tank = 1;
					}
				}

				return location;
			}

			self.close_to_tank = 0;
			front_dist = distance2dsquared(enemy.origin,level.vh_tank.origin);
			back_dist = distance2dsquared(enemy.origin,level.vh_tank.origin);
			if(front_dist < back_dist)
			{
				location = tank_front;
			}
			else
			{
				location = tank_back;
			}

			self.ignoreall = 0;
		}
		else if(self.tank_state == "tag_chase")
		{
			location = level.vh_tank gettagorigin(self.str_tank_tag);
		}
		else if(self.tank_state == "exit_tank")
		{
			location = level.vh_tank tank_get_jump_down_offset(self.tank_tag);
		}
	}

	return location;
}

//Function Number: 70
adjust_enemyoverride()
{
	self endon("death");
	location = self.enemyoverride[0];
	tank = level.vh_tank;
	ent = self.enemyoverride[1];
	return location;
}

//Function Number: 71
closest_player_tank(origin,players)
{
	if((IsDefined(level.vh_tank) && level.vh_tank.n_players_on > 0) || !IsDefined(level.calc_closest_player_using_paths) && level.calc_closest_player_using_paths)
	{
		player = getclosest(origin,players);
	}
	else
	{
		player = get_closest_player_using_paths(origin,players);
	}

	if(IsDefined(player))
	{
		return player;
	}
}

//Function Number: 72
zombie_on_tank_death_animscript_callback(inflictor,attacker,damage,flags,meansofdeath,weapon,vpoint,vdir,shitloc,psoffsettime,boneindex)
{
	if(IsDefined(self.exploding) && self.exploding)
	{
		self notify("killanimscript");
		self maps/mp/zombies/_zm_spawner::reset_attack_spot();
		return 1;
	}

	if(IsDefined(self))
	{
		level maps/mp/zombies/_zm_spawner::zombie_death_points(self.origin,meansofdeath,shitloc,attacker,self);
		launchvector = undefined;
		self thread maps/mp/zombies/_zm_spawner::zombie_ragdoll_then_explode(launchvector,attacker);
		self notify("killanimscript");
		self maps/mp/zombies/_zm_spawner::reset_attack_spot();
		return 1;
	}
}

//Function Number: 73
tomb_get_path_length_to_tank()
{
	tank_front = 30 + VectorScale((0,0,1));
	tank_back = 30 + VectorScale((0,0,1));
	path_length_1 = self calcpathlength(tank_front);
	path_length_2 = self calcpathlength(tank_back);
	if(path_length_1 < path_length_2)
	{
		return path_length_1;
	}
	else
	{
		return path_length_2;
	}
}