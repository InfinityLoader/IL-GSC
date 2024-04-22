/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_orbital.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 1008 ms
 * Timestamp: 4/22/2024 2:10:06 AM
*******************************************************************/

//Function Number: 1
precacheorbital()
{
	precachemodel("tag_player");
	precachemodel("vehicle_ac130_coop");
	precachemodel("vehicle_drop_pod_base");
	precachemodel("vehicle_drop_pod_base_enemy");
	precachempanim("mp_orbital_pod_base_unfold");
	game["dialog"]["orbital_pod_destroyed"] = "orbital_pod_destroyed";
	game["dialog"]["orbital_pod_destroyed_enemy"] = "orbital_pod_destroyed_enemy";
	game["dialog"]["orbital_dropin"] = "orbital_dropin";
	game["dialog"]["orbital_notgood_tryhard"] = "orbital_notgood_tryhard";
	level.drop_pod_effect["pod_base_destroyed"] = loadfx("vfx/explosion/orbital_pod_base_explosion");
	level.drop_pod_effect["dome_impact_flash"] = loadfx("vfx/unique/orbital_dome_impact_flash");
	level.drop_pod_effect["dome_shutdown_friendly"] = loadfx("vfx/unique/orbital_dome_shutdown_friendly");
	level.drop_pod_effect["dome_shutdown_enemy"] = loadfx("vfx/unique/orbital_dome_shutdown_enemy");
	level.drop_pod_effect["player_spawn_from_pod"] = loadfx("vfx/ui/drop_pod_spawn_point_active");
	level.drop_pod_effect["drop_pod_fire_flash"] = loadfx("vfx/unique/orbital_drop_pod_fire_flash");
	level.drop_pod_effect["decel_explosion"] = loadfx("vfx/explosion/orbital_pod_decel_explosion");
	level.drop_pod_effect["dome_impact"] = loadfx("vfx/explosion/orbital_pod_impact_dome");
	level.drop_pod_effect["landing_impact"] = loadfx("vfx/smoke/drop_pod_landing_impact");
	level.drop_pod_effect["drop_pod_explode"] = loadfx("vfx/explosion/orbital_drop_pod_explode");
	level.drop_pod_effect["drop_pod_spike_impact"] = loadfx("vfx/weaponimpact/drop_pod_spike_impact");
	var_00 = getdvar("mapname");
	switch(var_00)
	{
		case "mp_refraction":
			level.drop_pod_dome["friendly"] = loadfx("vfx/unique/orbital_dome_friendly_ref");
			level.drop_pod_dome["enemy"] = loadfx("vfx/unique/orbital_dome_enemy_ref");
			level.drop_pod_dome_ground["friendly"] = loadfx("vfx/unique/orbital_dome_ground_friendly_ref");
			level.drop_pod_dome_ground["enemy"] = loadfx("vfx/unique/orbital_dome_ground_enemy_ref");
			break;

		default:
			level.drop_pod_dome["friendly"] = loadfx("vfx/unique/orbital_dome_friendly");
			level.drop_pod_dome["enemy"] = loadfx("vfx/unique/orbital_dome_enemy");
			level.drop_pod_dome_ground["friendly"] = loadfx("vfx/unique/orbital_dome_ground_friendly");
			level.drop_pod_dome_ground["enemy"] = loadfx("vfx/unique/orbital_dome_ground_enemy");
			break;
	}
}

//Function Number: 2
initializeoribtalmode()
{
	precacheorbital();
	level.drop_pod = spawnstruct();
	level.drop_pod.model = "vehicle_drop_pod_base";
	level.drop_pod.enemy_model = "vehicle_drop_pod_base_enemy";
	level.drop_pod.deploy_delay = 2;
	level.drop_pod_volume_array = getentarray("drop_pod_volume","targetname");
	level.drop_pod_bad_spawn_overlay = getentarray("orbital_bad_spawn_overlay","targetname");
	level.orbital_ships = spawnstruct();
	level.forcerespawn_time = 15;
	var_00 = getdvar("mapname");
	switch(var_00)
	{
		case "mp_refraction":
			setdvar("missileRemoteSteerPitchRange","37 88");
			level.left_loop_start = getent("orbital_plane_left_loop_start","targetname");
			level.left_big_loop_start = getent("orbital_plane_left_big_loop_start","targetname");
			level.right_loop_start = getent("orbital_plane_right_loop_start","targetname");
			level.right_big_loop_start = getent("orbital_plane_right_big_loop_start","targetname");
			level.left_pivot = getent("orbital_left_loop_pivot","targetname");
			level.left_big_pivot = getent("orbital_left_big_loop_pivot","targetname");
			level.right_pivot = getent("orbital_right_loop_pivot","targetname");
			level.right_big_pivot = getent("orbital_right_big_loop_pivot","targetname");
			level.orbital_ships.missilespawn["target"] = getent("orbitalMissileTarget","targetname");
			level.orbital_ships.cameraview["allies"] = spawn("script_model",level.left_loop_start.origin);
			level.orbital_ships.cameraview["allies"] setmodel("tag_player");
			level.orbital_ships.cameraview["allies"].angles = level.orbital_ships.cameraview["allies"].angles + (0,220,0);
			level.orbital_ships.cameraview["allies"].team = "allies";
			level.orbital_ships.cameraview["allies"] vehicle_jetbikesethoverforcescale(level.left_pivot);
			level.orbital_ships.cameraview["allies"].track = "left";
			level.orbital_ships.cameraview["allies"] hide();
			level.orbital_ships.cameraview["axis"] = spawn("script_model",level.left_big_loop_start.origin);
			level.orbital_ships.cameraview["axis"] setmodel("tag_player");
			level.orbital_ships.cameraview["axis"].angles = level.orbital_ships.cameraview["axis"].angles + (0,330,0);
			level.orbital_ships.cameraview["axis"].team = "axis";
			level.orbital_ships.cameraview["axis"] vehicle_jetbikesethoverforcescale(level.left_big_pivot);
			level.orbital_ships.cameraview["axis"].track = "left_big";
			level.orbital_ships.cameraview["axis"] hide();
			level.orbital_ships.ship["allies"] = spawn("script_model",level.left_loop_start.origin);
			level.orbital_ships.ship["allies"] setmodel("vehicle_ac130_coop");
			level.orbital_ships.ship["allies"].angles = level.orbital_ships.ship["allies"].angles + (0,220,0);
			level.orbital_ships.ship["allies"] vehicle_jetbikesethoverforcescale(level.orbital_ships.cameraview["allies"],"",(0,0,80),(0,0,0));
			level.orbital_ships.ship["axis"] = spawn("script_model",level.left_big_loop_start.origin);
			level.orbital_ships.ship["axis"] setmodel("vehicle_ac130_coop");
			level.orbital_ships.ship["axis"].angles = level.orbital_ships.ship["axis"].angles + (0,330,0);
			level.orbital_ships.ship["axis"] vehicle_jetbikesethoverforcescale(level.orbital_ships.cameraview["axis"],"",(0,0,80),(0,0,0));
			thread rotateorbitalshippivots();
			level.orbital_ships.cameraview["allies"] thread monitortrackswitching();
			level.orbital_ships.cameraview["axis"] thread monitortrackswitching();
			break;

		default:
			setdvar("missileRemoteSteerPitchRange","47 88");
			var_01 = getent("airstrikeheight","targetname");
			var_02 = getentarray("minimap_corner","targetname");
			if(var_02.size == 2)
			{
				level.orbital_ships.center = maps\mp\gametypes\_spawnlogic::findboxcenter(var_02[0].origin,var_02[1].origin);
			}
			else
			{
			}
	
			level.orbital_ships.dist_from_center = 3500;
			level.orbital_ships.extra_height = 2000;
			level.orbital_ships.center = level.orbital_ships.center * (1,1,0);
			level.orbital_ships.center = level.orbital_ships.center + (0,0,var_01.origin[2] + level.orbital_ships.extra_height);
			var_03 = level.orbital_ships.center;
			var_04 = (0,0,0);
			var_05 = (0,180,0);
			var_06 = var_03 + anglestoforward(var_04) * level.orbital_ships.dist_from_center;
			var_07 = var_03 + anglestoforward(var_05) * level.orbital_ships.dist_from_center;
			level.orbital_ships.script_origin = spawn("script_origin",level.orbital_ships.center);
			level.orbital_ships.cameraview["allies"] = spawn("script_model",var_06);
			level.orbital_ships.cameraview["allies"] setmodel("tag_player");
			level.orbital_ships.cameraview["allies"].angles = level.orbital_ships.cameraview["allies"].angles + (0,180,0);
			level.orbital_ships.cameraview["allies"] vehicle_jetbikesethoverforcescale(level.orbital_ships.script_origin);
			level.orbital_ships.cameraview["allies"] hide();
			level.orbital_ships.cameraview["axis"] = spawn("script_model",var_07);
			level.orbital_ships.cameraview["axis"] setmodel("tag_player");
			level.orbital_ships.cameraview["axis"].angles = level.orbital_ships.cameraview["axis"].angles + (0,0,0);
			level.orbital_ships.cameraview["axis"] vehicle_jetbikesethoverforcescale(level.orbital_ships.script_origin);
			level.orbital_ships.cameraview["axis"] hide();
			level.orbital_ships.missilespawn["target"] = spawn("script_origin",level.orbital_ships.center - (0,0,7000));
			level.orbital_ships.missilespawn["target"].targetname = "orbitalMissileTarget";
			level.orbital_ships.ship["allies"] = spawn("script_model",var_06);
			level.orbital_ships.ship["allies"] setmodel("vehicle_ac130_coop");
			level.orbital_ships.ship["allies"].angles = level.orbital_ships.ship["allies"].angles + (0,180,0);
			level.orbital_ships.ship["allies"] vehicle_jetbikesethoverforcescale(level.orbital_ships.cameraview["allies"],"",(0,0,100),(15,0,0));
			level.orbital_ships.ship["axis"] = spawn("script_model",var_07);
			level.orbital_ships.ship["axis"] setmodel("vehicle_ac130_coop");
			level.orbital_ships.ship["axis"].angles = level.orbital_ships.ship["axis"].angles + (0,0,0);
			level.orbital_ships.ship["axis"] vehicle_jetbikesethoverforcescale(level.orbital_ships.cameraview["axis"],"",(0,0,100),(15,0,0));
			level.orbital_ships.script_origin thread rotateorbitalships();
			break;
	}

	thread showdroppodbadspawnoverlay();
	thread spawnplayerinorbital();
}

//Function Number: 3
monitortrackswitching()
{
	level endon("game_ended");
	self.started_bank = 0;
	level.ship_pos_wait_delay = 0.5;
	var_00 = 4;
	wait(2);
	for(;;)
	{
		var_01 = "none";
		var_02 = self.track;
		switch(var_02)
		{
			case "right":
				var_01 = distance(self.origin,level.left_big_loop_start.origin);
				if(var_01 <= 200 && self.started_bank == 0)
				{
					level.ship_pos_wait_delay = 0.05;
				}
		
				if(var_01 <= var_00)
				{
					self unlink();
					self.origin = level.left_big_loop_start.origin;
					self vehicle_jetbikesethoverforcescale(level.left_big_pivot);
					self.track = "left_big";
					level.ship_pos_wait_delay = 0.5;
				}
				break;
	
			case "left_big":
				var_01 = distance(self.origin,level.left_loop_start.origin);
				if(var_01 <= 200 && self.started_bank == 0)
				{
					level.ship_pos_wait_delay = 0.05;
				}
		
				if(var_01 <= var_00)
				{
					self unlink();
					self.origin = level.left_loop_start.origin;
					self vehicle_jetbikesethoverforcescale(level.left_pivot);
					self.track = "left";
					level.ship_pos_wait_delay = 0.5;
				}
				break;
	
			case "left":
				var_01 = distance(self.origin,level.right_big_loop_start.origin);
				if(var_01 <= 200 && self.started_bank == 0)
				{
					level.ship_pos_wait_delay = 0.05;
				}
		
				if(var_01 <= var_00)
				{
					self unlink();
					self.origin = level.right_big_loop_start.origin;
					self vehicle_jetbikesethoverforcescale(level.right_big_pivot);
					self.track = "right_big";
					level.ship_pos_wait_delay = 0.5;
				}
				break;
	
			case "right_big":
				var_01 = distance(self.origin,level.right_loop_start.origin);
				if(var_01 <= 200 && self.started_bank == 0)
				{
					level.ship_pos_wait_delay = 0.05;
				}
		
				if(var_01 <= var_00)
				{
					self unlink();
					self.origin = level.right_loop_start.origin;
					self vehicle_jetbikesethoverforcescale(level.right_pivot);
					self.track = "right";
					level.ship_pos_wait_delay = 0.5;
				}
				break;
	
			default:
				break;
		}

		level.var_2B71 = var_01;
		wait(level.ship_pos_wait_delay);
	}
}

//Function Number: 4
rotateorbitalships()
{
	level endon("game_ended");
	for(;;)
	{
		self rotateyaw(3600,1200);
		wait(1199);
	}
}

//Function Number: 5
rotateorbitalshippivots()
{
	level endon("game_ended");
	for(;;)
	{
		level.left_pivot rotateyaw(-5400,1200);
		level.left_big_pivot rotateyaw(-700,1200);
		level.right_pivot rotateyaw(5400,1200);
		level.right_big_pivot rotateyaw(700,1200);
		wait(1199);
	}
}

//Function Number: 6
spawnplayerinorbital()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_00 setclientomnvar("ui_orbital_toggle_hud",1);
		var_00 setclientomnvar("ui_orbital_is_dropping",1);
		if(!isbot(var_00))
		{
			var_00 disableweapons();
			var_00 playerhide();
			var_00 hideviewmodel();
			var_00 thread setfovscale(1,0);
			var_00.isdropping = 1;
			var_00 thread showdroppodfx();
			var_00 thread playerinorbital();
			var_00 thread waitforspawnfinished();
		}
	}
}

//Function Number: 7
showdroppodfx()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	for(;;)
	{
		hidepodfx();
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.isdropping))
			{
				if(var_01.isdropping == 1)
				{
					var_01 showpoddroppingfxtoplayer();
					continue;
				}

				var_01 showpodgroundfxtoplayer();
			}
		}

		wait(0.05);
	}
}

//Function Number: 8
hidepodfx()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.drop_pod))
		{
			if(isdefined(var_01.drop_pod.trophyfx_friendly))
			{
				var_01.drop_pod.trophyfx_friendly hide();
			}

			if(isdefined(var_01.drop_pod.trophyfx_enemy))
			{
				var_01.drop_pod.trophyfx_enemy hide();
			}

			if(isdefined(var_01.drop_pod.trophyfx_ground_friendly))
			{
				var_01.drop_pod.trophyfx_ground_friendly hide();
			}

			if(isdefined(var_01.drop_pod.trophyfx_ground_enemy))
			{
				var_01.drop_pod.trophyfx_ground_enemy hide();
			}
		}
	}
}

//Function Number: 9
showpoddroppingfxtoplayer()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.drop_pod))
		{
			if(var_01.team == self.team)
			{
				if(isdefined(var_01.drop_pod.trophyfx_friendly))
				{
					var_01.drop_pod.trophyfx_friendly showtoplayer(self);
				}
			}

			if(!var_01.team == self.team)
			{
				if(isdefined(var_01.drop_pod.trophyfx_enemy))
				{
					var_01.drop_pod.trophyfx_enemy showtoplayer(self);
				}
			}
		}
	}
}

//Function Number: 10
showpodgroundfxtoplayer()
{
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.drop_pod))
		{
			if(var_01.team == self.team)
			{
				if(isdefined(var_01.drop_pod.trophyfx_ground_friendly))
				{
					var_01.drop_pod.trophyfx_ground_friendly showtoplayer(self);
				}
			}

			if(!var_01.team == self.team)
			{
				if(isdefined(var_01.drop_pod.trophyfx_ground_enemy))
				{
					var_01.drop_pod.trophyfx_ground_enemy showtoplayer(self);
				}
			}
		}
	}
}

//Function Number: 11
waitforspawnfinished()
{
	level endon("game_ended");
	self endon("disconnect");
	common_scripts\utility::waittill_any("player_drop_pod_spawned","player_spawned_at_drop_pod");
	self.isdropping = 0;
	thread setorbitalview("off",0);
	thread hideoverlays();
	thread destroyplayericons();
}

//Function Number: 12
playerinorbital()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	level endon("game_ended");
	if(!isbot(self))
	{
		if(!isdefined(self.prematch_over))
		{
			self.prematch_over = 0;
		}

		if(!isdefined(self.respawn_mode))
		{
			self.respawn_mode = 0;
		}

		if(!isdefined(self.mode_button_released))
		{
			self.mode_button_released = 0;
		}

		self.spawn_button_released = 0;
		self.is_linked_to_pod = 0;
		self.is_linked_to_ship = 0;
		if(self.prematch_over == 0)
		{
			self disableweapons();
			self hideviewmodel();
			if(!self islinked())
			{
				linkplayerorbitalship();
			}
		}

		maps\mp\_utility::gameflagwait("prematch_done");
		self.prematch_over = 1;
		self disableweapons();
		self hideviewmodel();
		self.forcerespawn_timer = level.forcerespawn_time;
		var_00 = level.forcerespawn_time * 1000 + gettime();
		self setclientomnvar("ui_orbital_toggle_color",0);
		self setclientomnvar("ui_orbital_timer_time",var_00);
		thread droppodforcerespawn();
		self.forcerespawn = 0;
		if(isdefined(self.drop_pod) && self.drop_pod.destroyed == 0)
		{
			self.respawn_mode = 1;
		}

		for(;;)
		{
			if(isdefined(self.drop_pod) && self.drop_pod.destroyed == 0 && self.respawn_mode == 1)
			{
				if(self.is_linked_to_pod == 0)
				{
					if(self islinked())
					{
						self unlink();
					}

					linkplayerpod();
				}
			}

			if(!isdefined(self.drop_pod) || self.drop_pod.destroyed == 1 || self.respawn_mode == 0)
			{
				if(self.is_linked_to_ship == 0)
				{
					if(self islinked())
					{
						self unlink();
					}

					linkplayerorbitalship();
				}
			}

			if(!self adsbuttonpressed())
			{
				self.mode_button_released = 1;
			}

			if(!self attackbuttonpressed())
			{
				self.spawn_button_released = 1;
			}

			if(self adsbuttonpressed() && self.mode_button_released == 1)
			{
				self.mode_button_released = 0;
				if(self.respawn_mode == 0 && isdefined(self.drop_pod) && self.drop_pod.destroyed == 0)
				{
					self.respawn_mode = 1;
					if(self.is_linked_to_pod == 0)
					{
						if(self islinked())
						{
							self unlink();
						}

						linkplayerpod();
					}
				}
				else if(self.respawn_mode == 1)
				{
					self.respawn_mode = 0;
					if(self.is_linked_to_ship == 0)
					{
						if(self islinked())
						{
							self unlink();
						}

						linkplayerorbitalship();
					}
				}

				continue;
			}

			if((self attackbuttonpressed() && self.spawn_button_released == 1) || self.forcerespawn)
			{
				self.spawn_button_released = 0;
				if(isdefined(self.drop_pod) && self.drop_pod.destroyed == 0 && self.respawn_mode == 1 && self.is_linked_to_pod == 1)
				{
					if(isdefined(self.drop_pod))
					{
						if(isdefined(self.drop_pod.spawn_fx))
						{
							self.drop_pod.spawn_fx delete();
						}
					}

					var_01 = self getplayerangles();
					self unlink();
					self notify("player_spawned_at_drop_pod");
					thread setorbitalview("off",0);
					self setplayerangles(var_01);
					self setorigin(self.drop_pod.origin);
					self enableweapons();
					self playershow();
					self showviewmodel();
					return;
				}
				else if(self.respawn_mode == 0 && self.is_linked_to_ship == 1)
				{
					var_02 = _fire(self.lifeid,self);
					return;
				}
			}

			wait(0.05);
		}

		return;
	}

	linkplayerorbitalship();
	var_02 = _fire(self.lifeid,self);
	if(isdefined(var_02))
	{
		self setorigin(var_02.origin);
		createplayerdroppod(var_02.origin);
		self.drop_pod thread drop_pod_handledeath();
		wait(0.05);
	}
}

//Function Number: 13
linkplayerpod()
{
	self.is_linked_to_pod = 1;
	self.is_linked_to_ship = 0;
	self.isdropping = 0;
	destroyplayericons();
	showplayericons("friendly");
	self notify("switched_to_pod_view");
	thread setorbitalview("pod",0);
	self dontinterpolate();
	self playerlinkto(self.drop_pod.camera,"tag_player",0);
	self.drop_pod.spawn_fx = spawnfx(level.drop_pod_effect["player_spawn_from_pod"],self.drop_pod.origin,self.drop_pod.forward);
	triggerfx(self.drop_pod.spawn_fx);
	thread centerpodspawnview();
}

//Function Number: 14
linkplayerorbitalship()
{
	self.is_linked_to_pod = 0;
	self.is_linked_to_ship = 1;
	self.isdropping = 1;
	destroyplayericons();
	thread showplayericons("both");
	if(!isdefined(self.is_first_drop))
	{
		self.is_first_drop = 0;
	}
	else
	{
		thread maps\mp\_utility::leaderdialogonplayer("orbital_dropin",undefined,undefined,self.origin);
	}

	if(isdefined(self.drop_pod))
	{
		self setclientomnvar("ui_orbital_toggle_switch",0);
		if(isdefined(self.drop_pod.spawn_fx))
		{
			self.drop_pod.spawn_fx delete();
		}
	}
	else
	{
		self setclientomnvar("ui_orbital_toggle_switch",1);
	}

	var_00 = 0.3;
	thread setorbitalview("ship",0);
	var_01 = getdvar("mapname");
	self dontinterpolate();
	switch(var_01)
	{
		case "mp_refraction":
			self playerlinkto(level.orbital_ships.cameraview[self.pers["team"]],"tag_player",0,180,180,-40,80,0);
			break;

		default:
			self playerlinkto(level.orbital_ships.cameraview[self.pers["team"]],"tag_player",1,90,90,-50,80,0);
			break;
	}

	thread centerorbitalview();
	self setclientomnvar("ui_orbital_collision_warn",0);
	thread tracecollisionwarn();
}

//Function Number: 15
unlinkplayer()
{
	self dontinterpolate();
	self controlsunlink();
	self cameraunlink();
	self unlink();
	self freezecontrols(1);
	self enableweapons();
	self showviewmodel();
}

//Function Number: 16
centerorbitalview()
{
	var_00 = level.orbital_ships.cameraview[self.pers["team"]].origin;
	var_01 = level.orbital_ships.missilespawn["target"].origin;
	var_02 = vectortoangles(var_01 - var_00);
	self setplayerangles(var_02);
}

//Function Number: 17
centerpodspawnview()
{
	var_00 = self.drop_pod.camera.origin;
	var_01 = level.orbital_ships.missilespawn["target"].origin;
	var_02 = vectortoangles(var_01 - var_00);
	var_02 = var_02 * (0,1,0);
	self setplayerangles(var_02);
}

//Function Number: 18
setorbitalview(param_00,param_01)
{
	self setclientomnvar("ui_orbital_toggle_ship_view",2);
	self setclientomnvar("ui_orbital_toggle_pod_view",2);
	self setclientomnvar("ui_orbital_toggle_drop_view",2);
	wait(param_01);
	switch(param_00)
	{
		case "ship":
			self setclientomnvar("ui_orbital_toggle_ship_view",1);
			break;

		case "pod":
			self setclientomnvar("ui_orbital_collision_warn",0);
			self setclientomnvar("ui_orbital_toggle_pod_view",1);
			break;

		case "drop":
			self setclientomnvar("ui_orbital_toggle_drop_view",1);
			break;

		case "off":
			self setclientomnvar("ui_orbital_is_dropping",0);
			break;

		default:
			break;
	}
}

//Function Number: 19
tracecollisionwarn()
{
	self endon("player_drop_pod_spawned");
	self endon("disconnect");
	self endon("player_spawned_at_drop_pod");
	self endon("joined_team");
	self endon("death");
	self endon("switched_to_pod_view");
	for(;;)
	{
		var_00 = self getplayerangles();
		var_01 = self geteye() + anglestoforward(var_00) * 20;
		var_02 = var_01 + anglestoforward(var_00) * 30000;
		var_03 = playerphysicstraceinfo(var_01,var_02);
		var_03["position"] = var_03["position"] + (0,0,10);
		level.trace = var_03;
		if(isdefined(var_03["position"]))
		{
			var_04 = var_03["position"];
			var_05 = 0;
			var_06 = spawn("script_origin",var_04);
			var_06.targetname = "orbital_trace_position";
			foreach(var_08 in level.drop_pod_volume_array)
			{
				var_09 = var_06 istouching(var_08);
				var_0A = canspawn(var_04);
				if(var_09 && var_0A)
				{
					var_05 = 1;
					break;
				}
			}

			var_06 delete();
			if(var_05 == 1)
			{
				self setclientomnvar("ui_orbital_collision_warn",0);
			}
			else
			{
				self setclientomnvar("ui_orbital_collision_warn",1);
			}
		}

		wait(0.15);
	}
}

//Function Number: 20
_fire(param_00,param_01)
{
	param_01 endon("death");
	var_02 = 0.3;
	param_01 thread setorbitalview("drop",0);
	thread setfovscale(4.333,0.1);
	param_01 destroyplayericons();
	param_01 showplayericons("friendly");
	if(!isbot(param_01))
	{
		param_01.orbital_location = param_01 geteye();
		param_01.orbital_viewangles = param_01 getplayerangles();
		param_01.orbital_forward = anglestoforward(param_01.orbital_viewangles);
		param_01.orbital_endpoint = param_01.orbital_location + param_01.orbital_forward * 5000;
		var_03 = magicbullet("orbital_drop_pod_mp",param_01.orbital_location,self.orbital_endpoint,param_01);
		var_03 thread aud_drop_pod_fire(param_01);
		var_03 thread aud_play_rocket_travel_loops(param_01);
	}
	else
	{
		var_02.orbital_location = level.orbital_ships.cameraview[self.pers["team"]].origin;
		var_04 = level.orbital_ships.cameraview[self.pers["team"]].origin;
		var_05 = level.orbital_ships.missilespawn["target"].origin;
		param_01.orbital_viewangles = vectortoangles(var_05 - var_04);
		param_01.orbital_forward = anglestoforward(param_01.orbital_viewangles);
		param_01.orbital_endpoint = var_04 + param_01.orbital_forward * 5000;
		var_03 = magicbullet("orbital_drop_pod_mp",var_04,self.orbital_endpoint,param_01);
		var_03 thread aud_drop_pod_fire(param_01);
		var_03 thread aud_play_rocket_travel_loops(param_01);
	}

	playfx(level.drop_pod_effect["drop_pod_fire_flash"],param_01.orbital_location,param_01.orbital_forward);
	thread destroyplayerdroppod();
	self notify("drop_pod_spawned");
	if(!isdefined(var_03))
	{
		return;
	}

	var_03.trigger = spawn("trigger_radius",var_03.origin,0,128,256);
	if(param_01 islinked())
	{
		param_01 unlink();
		param_01 dontinterpolate();
		param_01 playerlinkto(var_03);
	}

	var_03.owner = param_01;
	var_03.lifeid = param_00;
	var_03.type = "orbital_drop_pod_mp";
	var_03.team = param_01.team;
	level.remotemissileinprogress = 1;
	var_03 thread createkillcamentity();
	param_01.rocket = var_03;
	wait(0.1);
	var_06 = missileeyes(param_01,var_03);
	return var_06;
}

//Function Number: 21
setfovscale(param_00,param_01)
{
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	self setclientdvar("cg_fovScale",param_00);
}

//Function Number: 22
missileeyes(param_00,param_01)
{
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_00 endon("death");
	param_01 thread rocket_cleanupondeath();
	param_00 thread player_cleanupongameended(param_01);
	param_00 thread player_cleanuponteamchange(param_01);
	param_01 thread waitforrocketimpact(param_00);
	param_01 thread waitforrocketdeath(param_00);
	var_02 = getdvar("mapname");
	param_00 visionsetmissilecamforplayer(var_02,0);
	param_00 endon("disconnect");
	param_00.spawn_was_good = 0;
	var_03 = undefined;
	var_04 = (0,0,0);
	if(isdefined(param_01))
	{
		param_00 cameralinkto(param_01,"tag_origin");
		param_00 controlslinkto(param_01);
		param_01 thread trackrocket(param_00);
		param_01 thread droppodtrophysystem();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(0);
		}

		param_00 common_scripts\utility::waittill_any("rocket_impacted","rocket_destroyed");
		param_01 thread aud_play_pod_impact(param_00);
		param_00 destroyplayericons();
		param_00 notify("player_drop_pod_spawned");
		param_00 unlinkplayer();
		if(!level.gameended || isdefined(param_00.finalkill))
		{
			thread setfovscale(1,0);
		}

		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(1);
		}
	}
	else
	{
	}

	var_05 = 0.3;
	if(param_00.spawn_was_good == 1 && isdefined(param_00.nearest_node))
	{
		param_00 createplayerdroppod(param_00.nearest_node.origin);
		param_00 setorigin(param_00.drop_pod.origin);
		param_00 setplayerangles((0,param_00.angles[1],0));
		param_00 thread unfreezecontrolsdelay(var_05);
		param_00 playershow();
		param_00.nearest_node = undefined;
		param_00 thread droppodbaseunfold();
		param_00.drop_pod thread drop_pod_handledeath();
		param_00.drop_pod thread aud_drop_pod_land_success(param_00);
	}
	else
	{
		param_00 setorigin(param_00.impact_info["rocket_position"]);
		param_00 thread droppodbadspawndeathfx();
		param_00 maps\mp\gametypes\_damage::addattacker(param_00,param_00,param_00.rocket.killcament,"orbital_drop_pod_mp",999999,(0,0,0),param_00.origin,"none",0,"MOD_EXPLOSIVE");
		param_00 thread unfreezecontrolsdelay(var_05);
		thread aud_drop_pod_land_fail(param_00);
		param_00 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper(param_00.rocket.killcament,param_00,999999,0,"MOD_EXPLOSIVE","orbital_drop_pod_mp",param_00.origin,param_00.origin,"none",0,0);
		param_00 thread maps\mp\_utility::leaderdialogonplayer("orbital_notgood_tryhard",undefined,undefined,self.origin);
	}

	return var_03;
}

//Function Number: 23
waitforrocketimpact(param_00)
{
	level endon("game_ended");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_00 endon("death");
	for(;;)
	{
		param_00 waittill("projectile_impact",var_01,var_02,var_03,var_04);
		if(var_01 == "orbital_drop_pod_mp")
		{
			break;
		}
	}

	param_00.spawn_was_good = 1;
	param_00 notify("rocket_impacted");
}

//Function Number: 24
waitforrocketdeath(param_00)
{
	level endon("game_ended");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_00 endon("death");
	self waittill("death");
	if(isdefined(self))
	{
		self delete();
	}

	param_00 cameraunlink();
	param_00 controlsunlink();
	param_00 setfovscale(1,0);
	param_00 notify("rocket_destroyed");
}

//Function Number: 25
vmlandingimpact()
{
	wait(0.5);
	self stunplayer(0.3);
}

//Function Number: 26
droppodbaseunfold()
{
	wait(level.drop_pod.deploy_delay - 1);
	self.drop_pod thread droppodspikeimpacts();
	self.drop_pod_enemy_model thread droppodspikeimpacts();
	self.drop_pod scriptmodelplayanimdeltamotion("mp_orbital_pod_base_unfold");
	self.drop_pod_enemy_model scriptmodelplayanimdeltamotion("mp_orbital_pod_base_unfold");
}

//Function Number: 27
droppodspikeimpacts()
{
	wait(0.68);
	var_00 = 2;
	var_01 = [];
	var_02 = [];
	var_01[0] = self gettagorigin("J_spike_FL");
	var_02[0] = self gettagangles("J_spike_FL");
	var_01[1] = self gettagorigin("J_spike_BL");
	var_02[1] = self gettagangles("J_spike_BL");
	var_01[2] = self gettagorigin("J_spike_BR");
	var_02[2] = self gettagangles("J_spike_BR");
	var_01[3] = self gettagorigin("J_spike_FR");
	var_02[3] = self gettagangles("J_spike_FR");
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = var_01[var_03] - 8 * anglestoforward(var_02[var_03]);
		var_05 = var_01[var_03] + var_00 * anglestoforward(var_02[var_03]);
		var_06 = bullettrace(var_04,var_05,0,self);
		if(isdefined(var_06["position"]))
		{
			playfx(level.drop_pod_effect["drop_pod_spike_impact"],var_06["position"],anglestoforward((270,0,0)));
		}
	}
}

//Function Number: 28
trackrocket(param_00)
{
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	for(;;)
	{
		param_00.impact_info["rocket_position"] = self.origin;
		var_01 = self.origin;
		var_02 = self.angles;
		var_03 = anglestoforward(var_02);
		var_04 = var_01 + var_03 * 512;
		var_05 = playerphysicstraceinfo(var_01,var_04);
		self.trigger dontinterpolate();
		self.trigger.origin = var_05["position"] + (0,0,-128);
		var_06 = self.trigger thread getnearestpathnode();
		if(isdefined(var_06))
		{
			self.owner.nearest_node = var_06;
			self hide();
			playfxontag(level.drop_pod_effect["decel_explosion"],self,"tag_origin");
			var_01 = self.origin;
			var_04 = var_06.origin;
			var_02 = vectortoangles(var_04 - var_01);
			self.angles = var_02;
			self.trigger delete();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 29
unfreezecontrolsdelay(param_00)
{
	wait(param_00);
	self freezecontrols(0);
}

//Function Number: 30
droppodbadspawndeathfx()
{
	self endon("disconnect");
	self waittill("death");
	playfx(level.drop_pod_effect["drop_pod_explode"],self.origin + (0,0,10));
}

//Function Number: 31
getnearestpathnode()
{
	var_00 = getnodesintrigger(self);
	if(isdefined(var_00) && var_00.size > 0)
	{
		var_01 = 0;
		var_02 = distancesquared(self.origin,var_00[0].origin);
		for(var_03 = 0;var_03 < var_00.size;var_03++)
		{
			switch(var_00[var_03].type)
			{
				case "Cover Right":
				case "Cover Left":
				case "Begin":
				case "Cover Stand":
				case "End":
					var_00[var_03] = undefined;
					break;

				default:
					break;
			}

			if(isdefined(var_00[var_03].script_noteworthy))
			{
				if(var_00[var_03].script_noteworthy == "orbital_no_spawn")
				{
					var_00[var_03] = undefined;
					continue;
				}
			}

			var_04 = distancesquared(self.origin,var_00[var_03].origin);
			if(var_04 < var_02)
			{
				var_02 = var_04;
				var_01 = var_03;
			}
		}

		return var_00[var_01];
	}

	return undefined;
}

//Function Number: 32
rocket_cleanupondeath()
{
	var_00 = self getentitynumber();
	level.rockets[var_00] = self;
	self waittill("death");
	level.rockets[var_00] = undefined;
	level.remotemissileinprogress = undefined;
}

//Function Number: 33
player_cleanupongameended(param_00)
{
	param_00 endon("death");
	self endon("death");
	level waittill("game_ended");
	self controlsunlink();
	self cameraunlink();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}
}

//Function Number: 34
player_cleanuponteamchange(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	if(self.team != "spectator")
	{
		self controlsunlink();
		self cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::setthirdpersondof(1);
		}
	}

	setfovscale(1,0);
	level.remotemissileinprogress = undefined;
}

//Function Number: 35
droppod_cleanuponteamchange()
{
	self.drop_pod endon("death");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	deleteplayerdroppod();
}

//Function Number: 36
droppod_cleanupondisconnect()
{
	self.drop_pod endon("death");
	self waittill("disconnect");
	deleteplayerdroppod();
}

//Function Number: 37
createplayerdroppod(param_00)
{
	deleteplayerdroppod();
	if(!isdefined(param_00))
	{
	}

	var_01 = param_00 + (0,0,32);
	var_02 = param_00 + (0,0,-1024);
	var_03 = playerphysicstraceinfo(var_01,var_02);
	var_04 = var_03["position"];
	var_05 = vectortoangles(var_03["normal"]);
	var_06 = anglestoforward(var_05);
	var_05 = var_05 + (180,0,0);
	playfx(level.drop_pod_effect["landing_impact"],var_04,var_03["normal"]);
	self.drop_pod = spawn("script_model",var_04);
	self.drop_pod.angles = var_05;
	self.drop_pod.forward = var_06;
	self.drop_pod setmodel(level.drop_pod.model);
	self.drop_pod solid();
	self.drop_pod setcandamage(1);
	self.drop_pod setcanradiusdamage(1);
	self.drop_pod.hidden = 0;
	self.drop_pod.owner = self;
	self.drop_pod.destroyed = 0;
	self.drop_pod.health = 999999;
	self.drop_pod.maxhealth = 100;
	self.drop_pod.damagetaken = 0;
	self.drop_pod hide();
	self.drop_pod_enemy_model = spawn("script_model",self.drop_pod.origin);
	self.drop_pod_enemy_model setmodel(level.drop_pod.enemy_model);
	self.drop_pod_enemy_model.angles = self.drop_pod.angles;
	self.drop_pod_enemy_model.owner = self;
	self.drop_pod_enemy_model hide();
	self.drop_pod_enemy_model notsolid();
	foreach(var_08 in level.players)
	{
		if(var_08.team == self.team)
		{
			self.drop_pod showtoplayer(var_08);
			continue;
		}

		self.drop_pod_enemy_model showtoplayer(var_08);
	}

	self.drop_pod thread aud_setup_drop_pod_loop();
	self.drop_pod.camera = spawn("script_model",self.drop_pod.origin);
	self.drop_pod.camera setmodel("tag_player");
	self.drop_pod.camera.angles = (0,0,0);
	self.drop_pod.camera hide();
	self.isdropping = 0;
	self.drop_pod thread podsetuptrophyfx(self);
	thread droppod_cleanupondisconnect();
	thread droppod_cleanuponteamchange();
}

//Function Number: 38
destroyplayerdroppod()
{
	if(!isdefined(self.drop_pod))
	{
		return;
	}

	self endon("player_drop_pod_spawned");
	var_00 = self.drop_pod;
	var_01 = level.drop_pod_effect["pod_base_destroyed"];
	var_02 = level.drop_pod_effect["dome_shutdown_friendly"];
	var_03 = level.drop_pod_effect["dome_shutdown_enemy"];
	playfx(var_01,var_00.origin,var_00.forward);
	var_00 hide();
	self.drop_pod_enemy_model hide();
	var_00.shutdown_fx_friendly = spawnfx(var_02,var_00.origin,var_00.forward);
	var_00.shutdown_fx_enemy = spawnfx(var_03,var_00.origin,var_00.forward);
	triggerfx(var_00.shutdown_fx_friendly);
	var_00.shutdown_fx_friendly hide();
	triggerfx(var_00.shutdown_fx_enemy);
	var_00.shutdown_fx_enemy hide();
	var_00 thread aud_destroy_deployed_pod();
	foreach(var_05 in level.players)
	{
		if(var_05.team == self.team)
		{
			var_00.shutdown_fx_friendly showtoplayer(var_05);
			continue;
		}

		var_00.shutdown_fx_enemy showtoplayer(var_05);
	}

	wait(0.7);
	deleteplayerdroppod();
}

//Function Number: 39
deleteplayerdroppod()
{
	if(isdefined(self.drop_pod_enemy_model))
	{
		self.drop_pod_enemy_model delete();
	}

	if(isdefined(self.drop_pod))
	{
		deleteplayerdroppodvfx();
		if(isdefined(self.drop_pod.camera))
		{
			self.drop_pod.camera delete();
		}

		self.drop_pod delete();
	}
}

//Function Number: 40
deleteplayerdroppodvfx()
{
	if(isdefined(self.drop_pod))
	{
		if(isdefined(self.drop_pod.trophyfx_friendly))
		{
			self.drop_pod.trophyfx_friendly delete();
		}

		if(isdefined(self.drop_pod.trophyfx_enemy))
		{
			self.drop_pod.trophyfx_enemy delete();
		}

		if(isdefined(self.drop_pod.trophyfx_ground_friendly))
		{
			self.drop_pod.trophyfx_ground_friendly delete();
		}

		if(isdefined(self.drop_pod.trophyfx_ground_enemy))
		{
			self.drop_pod.trophyfx_ground_enemy delete();
		}

		if(isdefined(self.drop_pod.shutdown_fx_enemy))
		{
			self.drop_pod.shutdown_fx_enemy delete();
		}

		if(isdefined(self.drop_pod.shutdown_fx_enemy))
		{
			self.drop_pod.shutdown_fx_enemy delete();
		}

		if(isdefined(self.drop_pod.spawn_fx))
		{
			self.drop_pod.spawn_fx delete();
		}
	}
}

//Function Number: 41
createkillcamentity()
{
	var_00 = (-512,0,128);
	self.killcament = spawn("script_model",self.origin);
	self.killcament setscriptmoverkillcam("explosive");
	self.killcament linkto(self,"tag_origin",var_00,(0,0,0));
	self.killcament setcontents(0);
	self.killcament.starttime = gettime();
	self.killcament.isorbitalcam = 1;
}

//Function Number: 42
removekillcamentity()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}
}

//Function Number: 43
drop_pod_handledeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self.owner thread maps\mp\_utility::leaderdialogonplayer("orbital_pod_destroyed_enemy",undefined,undefined,self.owner.origin);
	self.owner destroyplayerdroppod();
}

//Function Number: 44
droppodtrophysystem()
{
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	while(isdefined(self))
	{
		foreach(var_01 in level.players)
		{
			if(var_01.team != self.owner.team)
			{
				if(isdefined(var_01.drop_pod))
				{
					if(distancesquared(self.origin,var_01.drop_pod.origin) < 40000 && self.owner.health > 0)
					{
						var_01.drop_pod thread droppodtrophykill(self,var_01);
					}
				}
			}
		}

		foreach(var_04 in level.trophies)
		{
			if(isdefined(var_04))
			{
				if(distancesquared(self.origin,var_04.origin) < 40000 && var_04.owner.health > 0)
				{
					var_04 thread droppodtrophykill(self,var_04.owner);
					var_04.ammo--;
					if(var_04.ammo <= 0)
					{
						var_04 thread maps\mp\gametypes\_equipment::trophybreak();
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 45
droppodtrophykill(param_00,param_01)
{
	param_00 notify("destroyed");
	playfx(level.sentry_fire,self.origin + (0,0,0),param_00.origin - self.origin,anglestoup(self.angles));
	self playsound("trophy_detect_projectile");
	if(isdefined(param_00.classname) && param_00.classname == "rocket" && isdefined(param_00.type) && param_00.type == "remote")
	{
		if(isdefined(param_00.type) && param_00.type == "remote")
		{
			level thread maps\mp\gametypes\_missions::vehiclekilled(param_00.owner,param_01,undefined,param_01,undefined,"MOD_EXPLOSIVE","trophy_mp");
			level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_predator_missile",param_01);
			level thread maps\mp\gametypes\_rank::awardgameevent("kill",param_01,"trophy_mp",undefined,"MOD_EXPLOSIVE");
		}

		thread aud_drop_pod_trophy_kill();
	}

	param_01 thread projectileexplode(param_00,self);
}

//Function Number: 46
projectileexplode(param_00,param_01)
{
	var_02 = param_00.origin;
	var_03 = param_00.model;
	var_04 = param_00.angles;
	var_05 = param_00.owner;
	var_06 = param_01.owner;
	var_07 = var_06.drop_pod;
	var_08 = level.drop_pod_effect["dome_impact_flash"];
	var_09 = level.drop_pod_effect["dome_impact"];
	var_0A = param_01.origin;
	var_0B = var_02;
	var_0C = vectortoangles(var_0B - var_0A);
	var_0D = anglestoforward(var_0C);
	var_0E = anglestoup(var_0C);
	playfx(var_09,var_02,var_0D,var_0E);
	playfxontag(var_08,var_07,"tag_origin");
	waittillframeend;
	if(var_05.health <= 0)
	{
		return;
	}

	var_05 thread setfovscale(1,0);
	var_05 unlink();
	var_05 cameraunlink();
	var_05 setorigin(var_02);
	var_05 maps\mp\gametypes\_damage::addattacker(var_05,var_05,var_05.rocket.killcament,"orbital_drop_pod_mp",999999,(0,0,0),var_05.origin,"none",0,"MOD_EXPLOSIVE");
	var_05 thread maps\mp\gametypes\_damage::finishplayerdamagewrapper(var_05.rocket.killcament,var_05,999999,0,"MOD_EXPLOSIVE","orbital_drop_pod_mp",var_05.origin,var_05.origin,"none",0,0);
	if(isdefined(param_00))
	{
		param_00 delete();
	}

	param_01 thread aud_play_trophy_fire();
	radiusdamage(var_02,128,105,10,self,"MOD_EXPLOSIVE","trophy_mp");
	var_05 thread maps\mp\_utility::leaderdialogonplayer("orbital_pod_destroyed",undefined,undefined,var_05.origin);
}

//Function Number: 47
podsetuptrophyfx(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	self.trophyfx_friendly = spawnfx(level.drop_pod_dome["friendly"],self.origin,self.forward);
	triggerfx(self.trophyfx_friendly);
	self.trophyfx_friendly hide();
	self.trophyfx_enemy = spawnfx(level.drop_pod_dome["enemy"],self.origin,self.forward);
	triggerfx(self.trophyfx_enemy);
	self.trophyfx_enemy hide();
	wait(level.drop_pod.deploy_delay - 0.5);
	self.trophyfx_ground_friendly = spawnfx(level.drop_pod_dome_ground["friendly"],self.origin,self.forward);
	triggerfx(self.trophyfx_ground_friendly);
	self.trophyfx_ground_enemy = spawnfx(level.drop_pod_dome_ground["enemy"],self.origin,self.forward);
	triggerfx(self.trophyfx_ground_enemy);
	self.trophyfx_ground_enemy hide();
	thread deletepodtrophyfxondeath(param_00);
	thread deletepodtrophyfxondisconnect(param_00);
	thread deletepodtrophyfxonteamchange(param_00);
}

//Function Number: 48
showplayericons(param_00)
{
	self endon("death");
	foreach(var_02 in level.players)
	{
		if(var_02 == self || isdefined(var_02.isdropping))
		{
			continue;
		}

		switch(param_00)
		{
			case "friendly":
				if(var_02.team == self.team)
				{
					var_02 maps\mp\_entityheadicons::setheadicon(self,"ac130_hud_friendly_vehicle_target",(0,0,0),4,4,undefined,undefined,undefined,undefined,undefined,0);
				}
				break;

			case "enemy":
				if(!var_02.team == self.team)
				{
					var_02 maps\mp\_entityheadicons::setheadicon(self,"hud_fofbox_hostile",(0,0,0),4,4,undefined,undefined,undefined,undefined,undefined,0);
				}
				break;

			case "both":
				if(var_02.team == self.team)
				{
					var_02 maps\mp\_entityheadicons::setheadicon(self,"ac130_hud_friendly_vehicle_target",(0,0,0),4,4,undefined,undefined,undefined,undefined,undefined,0);
				}
				else
				{
					var_02 maps\mp\_entityheadicons::setheadicon(self,"hud_fofbox_hostile",(0,0,0),4,4,undefined,undefined,undefined,undefined,undefined,0);
				}
				break;

			default:
				break;
		}
	}
}

//Function Number: 49
destroyplayericons()
{
	level endon("game_ended");
	self endon("disconnect");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.entityheadicons))
		{
			if(isdefined(var_01.entityheadicons[self.guid]))
			{
				var_01.entityheadicons[self.guid] destroy();
				var_01.entityheadicons[self.guid] = undefined;
			}
		}
	}
}

//Function Number: 50
showdroppodbadspawnoverlay()
{
	level endon("game_ended");
	for(;;)
	{
		hideoverlays();
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.isdropping))
			{
				if(var_01.isdropping)
				{
					var_01 showoverlaystoplayer();
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 51
showoverlaystoplayer()
{
	foreach(var_01 in level.drop_pod_bad_spawn_overlay)
	{
		var_01 showtoplayer(self);
	}
}

//Function Number: 52
hideoverlays()
{
	foreach(var_01 in level.drop_pod_bad_spawn_overlay)
	{
		var_01 hide();
	}
}

//Function Number: 53
deletepodtrophyfxondeath(param_00)
{
	param_00 endon("disconnect");
	self waittill("death");
	deletepodtrophyfx();
}

//Function Number: 54
deletepodtrophyfxondisconnect(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	deletepodtrophyfx();
}

//Function Number: 55
deletepodtrophyfxonteamchange(param_00)
{
	self endon("death");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	deletepodtrophyfx();
}

//Function Number: 56
deletepodtrophyfx()
{
	if(isdefined(self.trophyfx_friendly))
	{
		self.trophyfx_friendly delete();
	}

	if(isdefined(self.trophyfx_enemy))
	{
		self.trophyfx_enemy delete();
	}
}

//Function Number: 57
droppodforcerespawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self endon("player_drop_pod_spawned");
	self endon("player_spawned_at_drop_pod");
	level endon("game_ended");
	self.forcerespawn = 0;
	if(!isdefined(self.forcerespawn_timer))
	{
		self.forcerespawn_timer = level.forcerespawn_time;
	}

	while(self.forcerespawn_timer > 0)
	{
		if(self.forcerespawn_timer <= 5)
		{
			self setclientomnvar("ui_orbital_toggle_color",1);
		}

		self.forcerespawn_timer--;
		wait(1);
	}

	self.forcerespawn = 1;
}

//Function Number: 58
aud_play_rocket_travel_loops(param_00)
{
	var_01 = self;
	thread maps\mp\_audio::snd_play_linked_loop("orbital_drop_pod_proj",var_01);
}

//Function Number: 59
aud_play_pod_impact(param_00)
{
	var_01 = self;
}

//Function Number: 60
aud_drop_pod_fire(param_00)
{
	var_01 = self;
	param_00 playlocalsound("orbital_drop_pod_fire_plr");
}

//Function Number: 61
aud_drop_pod_land_success(param_00)
{
	var_01 = self;
	thread maps\mp\_audio::snd_play_linked("orbital_drop_pod_impact",var_01);
	param_00 playlocalsound("orbital_drop_pod_impact");
}

//Function Number: 62
aud_drop_pod_land_fail(param_00)
{
	var_01 = self;
	thread maps\mp\_audio::snd_play_linked("orbital_drop_pod_impact",var_01);
	param_00 playlocalsound("orbital_drop_pod_impact");
}

//Function Number: 63
aud_destroy_deployed_pod()
{
	var_00 = self;
	var_00 playsound("orbital_drop_pod_platform_exp");
}

//Function Number: 64
aud_drop_pod_trophy_kill()
{
	var_00 = self;
}

//Function Number: 65
aud_play_trophy_fire()
{
	var_00 = self;
}

//Function Number: 66
aud_setup_drop_pod_loop()
{
	thread maps\mp\_audio::snd_play_linked_loop("orbital_drop_pod_platform_lp",self);
	self waittill("Death");
	if(isdefined(self))
	{
		self stopsounds();
	}
}