/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_traps.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 29
 * Decompile Time: 210 ms
 * Timestamp: 10/27/2023 3:06:19 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/_visionset_mgr;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
	level.trap_kills = 0;
	traps = getentarray("zombie_trap","targetname");
	array_thread(traps,::trap_init);
	level thread register_visionsets(traps);
	level.burning_zombies = [];
	level.elec_trap_time = 40;
	level.elec_trap_cooldown_time = 60;
}

//Function Number: 2
trap_init()
{
	self ent_flag_init("flag_active");
	self ent_flag_init("flag_cooldown");
	self._trap_type = "";
	if(IsDefined(self.script_noteworthy))
	{
		self._trap_type = self.script_noteworthy;
		if(IsDefined(level._zombiemode_trap_activate_funcs) && IsDefined(level._zombiemode_trap_activate_funcs[self._trap_type]))
		{
			self._trap_activate_func = level._zombiemode_trap_activate_funcs[self._trap_type];
		}
		else
		{
			switch(self.script_noteworthy)
			{
				case "€GSC\r\n":
					self._trap_activate_func = ::trap_activate_rotating;
					break;

				case "€GSC\r\n":
					self._trap_activate_func = ::trap_activate_electric;
					break;

				case "€GSC\r\n":
					self._trap_activate_func = ::trap_activate_flipper;
					break;

				case "€GSC\r\n":
				default:
					self._trap_activate_func = ::trap_activate_fire;
					break;
			}
		}

		if(IsDefined(level._zombiemode_trap_use_funcs) && IsDefined(level._zombiemode_trap_use_funcs[self._trap_type]))
		{
			self._trap_use_func = level._zombiemode_trap_use_funcs[self._trap_type];
		}
		else
		{
			self._trap_use_func = ::trap_use_think;
		}
	}

	self trap_model_type_init();
	self._trap_use_trigs = [];
	self._trap_lights = [];
	self._trap_movers = [];
	self._trap_switches = [];
	components = getentarray(self.target,"targetname");
	for(i = 0;i < components.size;i++)
	{
		if(IsDefined(components[i].script_noteworthy))
		{
			switch(components[i].script_noteworthy)
			{
				case "€GSC\r\n":
					self.counter_1s = components[i];
					break;

				case "€GSC\r\n":
					self.counter_10s = components[i];
					break;

				case "€GSC\r\n":
					self.counter_100s = components[i];
					break;

				case "€GSC\r\n":
					self._trap_movers[self._trap_movers.size] = components[i];
					break;

				case "€GSC\r\n":
					self._trap_switches[self._trap_switches.size] = components[i];
					break;

				case "€GSC\r\n":
					self._trap_lightes[self._trap_lightes.size] = components[i];
					break;
			}
		}

		if(IsDefined(components[i].script_string))
		{
			switch(components[i].script_string)
			{
				case "€GSC\r\n":
					self.flipper1 = components[i];
					break;

				case "€GSC\r\n":
					self.flipper2 = components[i];
					break;

				case "€GSC\r\n":
					self.flipper1_radius_check = components[i];
					break;

				case "€GSC\r\n":
					self.flipper2_radius_check = components[i];
					break;

				case "€GSC\r\n":
					self.target1 = components[i];
					break;

				case "€GSC\r\n":
					self.target2 = components[i];
					break;

				case "€GSC\r\n":
					self.target3 = components[i];
					break;
			}
		}

		switch(components[i].classname)
		{
			case "€GSC\r\n":
				self._trap_use_trigs[self._trap_use_trigs.size] = components[i];
				break;

			case "€GSC\r\n":
				self._trap_lights[self._trap_lights.size] = components[i];
				continue;
				self._trap_switches[self._trap_switches.size] = components[i];
	components[i].model == self._trap_switch_model
	components[i].model == self._trap_light_model_off
				break;
		}
	}

	self._trap_fx_structs = [];
	components = getstructarray(self.target,"targetname");
	for(i = 0;i < components.size;i++)
	{
		if(IsDefined(components[i].script_string) && components[i].script_string == "use_this_angle")
		{
			self.use_this_angle = components[i];
		}
		else
		{
			self._trap_fx_structs[self._trap_fx_structs.size] = components[i];
		}
	}

/#
	assert(self._trap_use_trigs.size > 0,"_zm_traps::init no use triggers found for " + self.target);
#/
	if(!(IsDefined(self.zombie_cost)))
	{
		self.zombie_cost = 1000;
	}

	self._trap_in_use = 0;
	self._trap_cooling_down = 0;
	self thread trap_dialog();
	flag_wait("start_zombie_round_logic");
	self trap_lights_red();
	for(i = 0;i < self._trap_use_trigs.size;i++)
	{
		self._trap_use_trigs[i] setcursorhint("HINT_NOICON");
	}

	if(!(IsDefined(self.script_flag_wait)))
	{
		self trap_set_string(&"ZOMBIE_NEED_POWER");
		flag_wait("power_on");
	}
	else
	{
		if(!(IsDefined(level.flag[self.script_flag_wait])))
		{
			flag_init(self.script_flag_wait);
		}

		flag_wait(self.script_flag_wait);
	}

	self trap_set_string(&"ZOMBIE_BUTTON_BUY_TRAP",self.zombie_cost);
	self trap_lights_green();
	for(i = 0;i < self._trap_use_trigs.size;i++)
	{
		self._trap_use_trigs[i] thread [[ self._trap_use_func ]](self);
	}
}

//Function Number: 3
trap_use_think(trap)
{
	while(1)
	{
		self waittill("trigger",who);
		if(who in_revive_trigger())
		{
			continue;
		}

		if(is_player_valid(who) && !trap._trap_in_use)
		{
			if(who.score >= trap.zombie_cost)
			{
				who maps/mp/zombies/_zm_score::minus_to_player_score(trap.zombie_cost);
				break;
			}

			continue;
			trap._trap_in_use = 1;
			trap trap_set_string(&"ZOMBIE_TRAP_ACTIVE");
			play_sound_at_pos("purchase",who.origin);
			if(trap._trap_switches.size)
			{
				trap thread trap_move_switches();
				trap waittill("switch_activated");
			}

			trap trigger_on();
			trap thread [[ trap._trap_activate_func ]]();
			trap waittill("trap_done");
			trap trigger_off();
			trap._trap_cooling_down = 1;
			trap trap_set_string(&"ZOMBIE_TRAP_COOLDOWN");
/#
			trap._trap_cooldown_time = 5;
GetDvarInt(#"FA81816F") >= 1
#/
			wait(trap._trap_cooldown_time);
			trap._trap_cooling_down = 0;
			trap notify("available");
			trap._trap_in_use = 0;
			trap trap_set_string(&"ZOMBIE_BUTTON_BUY_TRAP",trap.zombie_cost);
		}
	}
}

//Function Number: 4
trap_lights_red()
{
	for(i = 0;i < self._trap_lights.size;i++)
	{
		light = self._trap_lights[i];
		light setmodel(self._trap_light_model_red);
		if(IsDefined(light.fx))
		{
			light.fx delete();
		}

		light.fx = maps/mp/zombies/_zm_net::network_safe_spawn("trap_lights_red",2,"script_model",light.origin);
		light.fx setmodel("tag_origin");
		light.fx.angles = light.angles;
		playfxontag(level._effect["zapper_light_notready"],light.fx,"tag_origin");
	}
}

//Function Number: 5
trap_lights_green()
{
	for(i = 0;i < self._trap_lights.size;i++)
	{
		light = self._trap_lights[i];
		if(IsDefined(light._switch_disabled))
		{
		}
		else
		{
			light setmodel(self._trap_light_model_green);
			if(IsDefined(light.fx))
			{
				light.fx delete();
			}

			light.fx = maps/mp/zombies/_zm_net::network_safe_spawn("trap_lights_green",2,"script_model",light.origin);
			light.fx setmodel("tag_origin");
			light.fx.angles = light.angles;
			playfxontag(level._effect["zapper_light_ready"],light.fx,"tag_origin");
		}
	}
}

//Function Number: 6
trap_set_string(string,param1,param2)
{
	for(i = 0;i < self._trap_use_trigs.size;i++)
	{
		if(!(IsDefined(param1)))
		{
			self._trap_use_trigs[i] sethintstring(string);
		}
		else if(!(IsDefined(param2)))
		{
			self._trap_use_trigs[i] sethintstring(string,param1);
		}
		else
		{
			self._trap_use_trigs[i] sethintstring(string,param1,param2);
		}
	}
}

//Function Number: 7
trap_move_switches()
{
	self trap_lights_red();
	for(i = 0;i < self._trap_switches.size;i++)
	{
		self._trap_switches[i] rotatepitch(180,0.5);
		self._trap_switches[i] playsound("amb_sparks_l_b");
	}

	self._trap_switches[0] waittill("rotatedone");
	self notify("switch_activated");
	self waittill("available");
	for(i = 0;i < self._trap_switches.size;i++)
	{
		self._trap_switches[i] rotatepitch(-180,0.5);
	}

	self._trap_switches[0] waittill("rotatedone");
	self trap_lights_green();
}

//Function Number: 8
trap_activate_electric()
{
	self._trap_duration = 40;
	self._trap_cooldown_time = 60;
	self notify("trap_activate");
	if(IsDefined(self.script_string))
	{
		number = int(self.script_string);
		if(number != 0)
		{
			exploder(number);
		}
		else
		{
			clientnotify(self.script_string + "1");
		}
	}

	fx_points = getstructarray(self.target,"targetname");
	for(i = 0;i < fx_points.size;i++)
	{
		wait_network_frame();
		fx_points[i] thread trap_audio_fx(self);
	}

	self thread trap_damage();
	wait(self._trap_duration);
	self notify("trap_done");
	if(IsDefined(self.script_string))
	{
		clientnotify(self.script_string + "0");
	}
}

//Function Number: 9
trap_activate_fire()
{
	self._trap_duration = 40;
	self._trap_cooldown_time = 60;
	clientnotify(self.script_string + "1");
	clientnotify(self.script_parameters);
	fx_points = getstructarray(self.target,"targetname");
	for(i = 0;i < fx_points.size;i++)
	{
		wait_network_frame();
		fx_points[i] thread trap_audio_fx(self);
	}

	self thread trap_damage();
	wait(self._trap_duration);
	self notify("trap_done");
	clientnotify(self.script_string + "0");
	clientnotify(self.script_parameters);
}

//Function Number: 10
trap_activate_rotating()
{
	self endon("trap_done");
	self._trap_duration = 30;
	self._trap_cooldown_time = 60;
	self thread trap_damage();
	self thread trig_update(self._trap_movers[0]);
	old_angles = self._trap_movers[0].angles;
	for(i = 0;i < self._trap_movers.size;i++)
	{
		self._trap_movers[i] rotateyaw(360,5,4.5);
	}

	wait(5);
	step = 1.5;
	for(t = 0;t < self._trap_duration;t = t + step)
	{
		for(i = 0;i < self._trap_movers.size;i++)
		{
			self._trap_movers[i] rotateyaw(360,step);
		}

		wait(step);
	}

	for(i = 0;i < self._trap_movers.size;i++)
	{
		self._trap_movers[i] rotateyaw(360,5,0,4.5);
	}

	wait(5);
	for(i = 0;i < self._trap_movers.size;i++)
	{
		self._trap_movers[i].angles = old_angles;
	}

	self notify("trap_done");
}

//Function Number: 11
trap_activate_flipper()
{
}

//Function Number: 12
trap_audio_fx(trap)
{
	sound_origin = undefined;
	if(trap.script_noteworthy == "electric")
	{
		sound_origin = spawn("script_origin",self.origin);
		sound_origin playsound("zmb_elec_start");
		sound_origin playloopsound("zmb_elec_loop");
		self thread play_electrical_sound(trap);
	}
	else if(trap.script_noteworthy == "fire")
	{
		sound_origin = spawn("script_origin",self.origin);
		sound_origin playsound("zmb_firetrap_start");
		sound_origin playloopsound("zmb_firetrap_loop");
	}

	trap waittill_any_or_timeout(trap._trap_duration,"trap_done");
	if(IsDefined(sound_origin))
	{
		if(trap.script_noteworthy == "fire")
		{
			playsoundatposition("zmb_firetrap_end",sound_origin.origin);
		}

		sound_origin stoploopsound();
		wait(0.05);
		sound_origin delete();
	}
}

//Function Number: 13
play_electrical_sound(trap)
{
	trap endon("trap_done");
	while(1)
	{
		wait(randomfloatrange(0.1,0.5));
		playsoundatposition("zmb_elec_arc",self.origin);
	}
}

//Function Number: 14
trap_damage()
{
	self endon("trap_done");
	while(1)
	{
		self waittill("trigger",ent);
		if(isplayer(ent))
		{
			switch(self._trap_type)
			{
				case "€GSC\r\n":
					ent thread player_elec_damage();
					break;

				case "€GSC\r\n":
				case "€GSC\r\n":
					ent thread player_fire_damage();
					break;

				case "€GSC\r\n":
					ent dodamage(50,20 + VectorScale((0,0,1)));
					ent setstance("crouch");
					break;
	ent.origin
	ent getstance() == "stand"
					break;
			}

			continue;
		}

		if(!(IsDefined(ent.marked_for_death)))
		{
			switch(self._trap_type)
			{
				case "€GSC\r\n":
					ent thread zombie_trap_death(self,100);
					break;

				case "€GSC\r\n":
					ent thread zombie_trap_death(self,200);
					break;

				case "€GSC\r\n":
				case "€GSC\r\n":
				default:
					ent thread zombie_trap_death(self,randomint(100));
					break;
			}
		}
	}
}

//Function Number: 15
trig_update(parent)
{
	self endon("trap_done");
	start_angles = self.angles;
	while(1)
	{
		self.angles = parent.angles;
		wait(0.05);
	}
}

//Function Number: 16
player_elec_damage()
{
	self endon("death");
	self endon("disconnect");
	if(!(IsDefined(level.elec_loop)))
	{
		level.elec_loop = 0;
	}

	if(!IsDefined(self.is_burning) && is_player_valid(self))
	{
		self.is_burning = 1;
		if(is_true(level.trap_electric_visionset_registered))
		{
			maps/mp/_visionset_mgr::vsmgr_activate("overlay","zm_trap_electric",self,1.25,1.25);
		}
		else
		{
			self setelectrified(1.25);
		}

		shocktime = 2.5;
		self shellshock("electrocution",shocktime);
		if(level.elec_loop == 0)
		{
			elec_loop = 1;
			self playsound("zmb_zombie_arc");
		}

		if(!self hasperk("specialty_armorvest") || self.health - 100 < 1)
		{
			radiusdamage(self.origin,10,self.health + 100,self.health + 100);
			self.is_burning = undefined;
		}
		else
		{
			self dodamage(50,self.origin);
			wait(0.1);
			self.is_burning = undefined;
		}
	}
}

//Function Number: 17
player_fire_damage()
{
	self endon("death");
	self endon("disconnect");
	if(!IsDefined(self.is_burning) && !self maps/mp/zombies/_zm_laststand::player_is_in_laststand())
	{
		self.is_burning = 1;
		if(is_true(level.trap_fire_visionset_registered))
		{
			maps/mp/_visionset_mgr::vsmgr_activate("overlay","zm_trap_burn",self,1.25,1.25);
		}
		else
		{
			self setburn(1.25);
		}

		self notify("burned");
		if(!self hasperk("specialty_armorvest") || self.health - 100 < 1)
		{
			radiusdamage(self.origin,10,self.health + 100,self.health + 100);
			self.is_burning = undefined;
		}
		else
		{
			self dodamage(50,self.origin);
			wait(0.1);
			self.is_burning = undefined;
		}
	}
}

//Function Number: 18
zombie_trap_death(trap,param)
{
	self endon("death");
	self.marked_for_death = 1;
	switch(trap._trap_type)
	{
		case "€GSC\r\n":
		case "€GSC\r\n":
		case "€GSC\r\n":
			level.burning_zombies[level.burning_zombies.size] = self;
			self thread zombie_flame_watch();
			self playsound("ignite");
			self thread maps/mp/animscripts/zm_death::flame_death_fx();
			playfxontag(level._effect["character_fire_death_torso"],self,"J_SpineLower");
			wait(randomfloat(1.25));
			refs[0] = "guts";
			refs[1] = "right_arm";
			refs[2] = "left_arm";
			refs[3] = "right_leg";
			refs[4] = "left_leg";
			refs[5] = "no_legs";
			refs[6] = "head";
			self.a.gib_ref = refs[randomint(refs.size)];
			playsoundatposition("zmb_zombie_arc",self.origin);
			self thread electroctute_death_fx();
			self thread play_elec_vocals();
			wait(randomfloat(1.25));
			self playsound("zmb_zombie_arc");
			self [[ self.fire_damage_func ]](trap);
			continue;
			level notify("trap_kill",self,trap,IsDefined(self.fire_damage_func),(param > 90 && level.burning_zombies.size < 6) ? trap._trap_type == "electric" : randomint(100) > 50,IsDefined(self.animname) && self.animname != "zombie_dog");
			self dodamage(self.health + 666,self.origin,trap);
			break;

		case "€GSC\r\n":
		case "€GSC\r\n":
			ang = VectorToAngles(trap.origin - self.origin);
			direction_vec = VectorScale(AnglesToRight(ang));
			self [[ self.trap_reaction_func ]](trap);
			level notify("trap_kill",self,trap,IsDefined(self.trap_reaction_func),param);
			self startragdoll();
			self launchragdoll(direction_vec);
			wait_network_frame();
			self.a.gib_ref = "head";
			self dodamage(self.health,self.origin,trap);
			break;
	}
}

//Function Number: 19
zombie_flame_watch()
{
	self waittill("death");
	self stoploopsound();
	arrayremovevalue(level.burning_zombies,self);
}

//Function Number: 20
play_elec_vocals()
{
	if(IsDefined(self))
	{
		org = self.origin;
		wait(0.15);
		playsoundatposition("zmb_elec_vocals",org);
		playsoundatposition("zmb_zombie_arc",org);
		playsoundatposition("zmb_exp_jib_zombie",org);
	}
}

//Function Number: 21
electroctute_death_fx()
{
	self endon("death");
	if(IsDefined(self.is_electrocuted) && self.is_electrocuted)
	{
		return;
	}

	self.is_electrocuted = 1;
	self thread electrocute_timeout();
	if(self.team == level.zombie_team)
	{
		level.bconfiretime = GetTime();
		level.bconfireorg = self.origin;
	}

	if(IsDefined(level._effect["elec_torso"]))
	{
		playfxontag(level._effect["elec_torso"],self,"J_SpineLower");
	}

	self playsound("zmb_elec_jib_zombie");
	wait(1);
	tagarray = [];
	tagarray[0] = "J_Elbow_LE";
	tagarray[1] = "J_Elbow_RI";
	tagarray[2] = "J_Knee_RI";
	tagarray[3] = "J_Knee_LE";
	tagarray = array_randomize(tagarray);
	if(IsDefined(level._effect["elec_md"]))
	{
		playfxontag(level._effect["elec_md"],self,tagarray[0]);
	}

	self playsound("zmb_elec_jib_zombie");
	wait(1);
	self playsound("zmb_elec_jib_zombie");
	tagarray[0] = "J_Wrist_RI";
	tagarray[1] = "J_Wrist_LE";
	if(!IsDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs")
	{
		tagarray[2] = "J_Ankle_RI";
		tagarray[3] = "J_Ankle_LE";
	}

	tagarray = array_randomize(tagarray);
	if(IsDefined(level._effect["elec_sm"]))
	{
		playfxontag(level._effect["elec_sm"],self,tagarray[0]);
		playfxontag(level._effect["elec_sm"],self,tagarray[1]);
	}
}

//Function Number: 22
electrocute_timeout()
{
	self endon("death");
	self playloopsound("fire_manager_0");
	wait(12);
	self stoploopsound();
	if(IsDefined(self) && isalive(self))
	{
		self.is_electrocuted = 0;
		self notify("stop_flame_damage");
	}
}

//Function Number: 23
trap_dialog()
{
	self endon("warning_dialog");
	level endon("switch_flipped");
	timer = 0;
	while(1)
	{
		wait(0.5);
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			dist = distancesquared(players[i].origin,self.origin);
			if(dist > 4900)
			{
				timer = 0;
			}
			else
			{
				if(dist < 4900 && timer < 3)
				{
					wait(0.5);
					timer++;
				}

				if(dist < 4900 && timer == 3)
				{
					index = maps/mp/zombies/_zm_weapons::get_player_index(players[i]);
					plr = "plr_" + index + "_";
					wait(3);
					self notify("warning_dialog");
				}
			}
		}
	}
}

//Function Number: 24
get_trap_array(trap_type)
{
	ents = getentarray("zombie_trap","targetname");
	traps = [];
	for(i = 0;i < ents.size;i++)
	{
		if(ents[i].script_noteworthy == trap_type)
		{
			traps[traps.size] = ents[i];
		}
	}

	return traps;
}

//Function Number: 25
trap_disable()
{
	cooldown = self._trap_cooldown_time;
	if(self._trap_in_use)
	{
		self notify("trap_done");
		self._trap_cooldown_time = 0.05;
		self waittill("available");
	}

	array_thread(self._trap_use_trigs,::trigger_off);
	self trap_lights_red();
	self._trap_cooldown_time = cooldown;
}

//Function Number: 26
trap_enable()
{
	array_thread(self._trap_use_trigs,::trigger_on);
	self trap_lights_green();
}

//Function Number: 27
trap_model_type_init()
{
	if(!(IsDefined(self.script_parameters)))
	{
		self.script_parameters = "default";
	}

	switch(self.script_parameters)
	{
		case "€GSC\r\n":
			self._trap_light_model_off = "zombie_trap_switch_light";
			self._trap_light_model_green = "zombie_trap_switch_light_on_green";
			self._trap_light_model_red = "zombie_trap_switch_light_on_red";
			self._trap_switch_model = "zombie_trap_switch_handle";
			break;

		case "€GSC\r\n":
		default:
			self._trap_light_model_off = "zombie_zapper_cagelight";
			self._trap_light_model_green = "zombie_zapper_cagelight_green";
			self._trap_light_model_red = "zombie_zapper_cagelight_red";
			self._trap_switch_model = "zombie_zapper_handle";
			break;
	}
}

//Function Number: 28
register_visionsets(a_traps)
{
	a_registered_traps = [];
	foreach(trap in a_traps)
	{
		if(IsDefined(trap.script_noteworthy))
		{
			if(!(trap is_trap_registered(a_registered_traps)))
			{
				a_registered_traps[trap.script_noteworthy] = 1;
			}
		}
	}

	keys = getarraykeys(a_registered_traps);
	foreach(key in keys)
	{
		switch(key)
		{
			case "€GSC\r\n":
				level.vsmgr_prio_overlay_zm_trap_electrified = 60;
				maps/mp/_visionset_mgr::vsmgr_register_info("overlay","zm_trap_electric",16000,level.vsmgr_prio_overlay_zm_trap_electrified,15,1,maps/mp/_visionset_mgr::vsmgr_duration_lerp_thread_per_player,0);
				level.trap_electric_visionset_registered = 1;
				break;
	IsDefined(level.vsmgr_prio_overlay_zm_trap_electrified)
				break;

			case "€GSC\r\n":
				level.vsmgr_prio_overlay_zm_trap_burn = 61;
				maps/mp/_visionset_mgr::vsmgr_register_info("overlay","zm_trap_burn",16000,level.vsmgr_prio_overlay_zm_trap_burn,15,1,maps/mp/_visionset_mgr::vsmgr_duration_lerp_thread_per_player,0);
				level.trap_fire_visionset_registered = 1;
				break;
	IsDefined(level.vsmgr_prio_overlay_zm_trap_burn)
				break;
		}
	}
}

//Function Number: 29
is_trap_registered(a_registered_traps)
{
	return IsDefined(a_registered_traps[self.script_noteworthy]);
}