/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_equip_hacker.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 3:03:05 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
init()
{
	if(!(maps/mp/zombies/_zm_equipment::is_equipment_included("equip_hacker_zm")))
	{
		return;
	}

	maps/mp/zombies/_zm_equipment::register_equipment("equip_hacker_zm",&"ZOMBIE_EQUIP_HACKER_PICKUP_HINT_STRING",&"ZOMBIE_EQUIP_HACKER_HOWTO",undefined,"hacker");
	level._hackable_objects = [];
	level._pooled_hackable_objects = [];
	onplayerconnect_callback(::hacker_on_player_connect);
	level thread hack_trigger_think();
	level thread hacker_trigger_pool_think();
	level thread hacker_round_reward();
	if(GetDvarInt(#"53BD7080") == 1)
	{
		level thread hacker_debug();
	}
}

//Function Number: 2
hacker_round_reward()
{
	while(1)
	{
		level waittill("end_of_round");
		if(!(IsDefined(level._from_nml)))
		{
			players = get_players();
			for(i = 0;i < players.size;i++)
			{
				if(IsDefined(players[i] get_player_equipment()) && players[i] get_player_equipment() == "equip_hacker_zm")
				{
					if(IsDefined(players[i].equipment_got_in_round["equip_hacker_zm"]))
					{
						got_in_round = players[i].equipment_got_in_round["equip_hacker_zm"];
						rounds_kept = level.round_number - got_in_round;
						rounds_kept = rounds_kept - 1;
						if(rounds_kept > 0)
						{
							rounds_kept = min(rounds_kept,5);
							score = rounds_kept * 500;
							players[i] maps/mp/zombies/_zm_score::add_to_player_score(int(score));
						}
					}
				}
			}

			continue;
		}

		level._from_nml = undefined;
	}
}

//Function Number: 3
hacker_debug()
{
	while(1)
	{
		for(i = 0;i < level._hackable_objects.size;i++)
		{
			hackable = level._hackable_objects[i];
			if(IsDefined(hackable.pooled) && hackable.pooled)
			{
				if(IsDefined(hackable._trigger))
				{
					col = VectorScale((0,1,0));
					if(IsDefined(hackable.custom_debug_color))
					{
						col = hackable.custom_debug_color;
					}

/#
					print3d(hackable.origin,"+",col,1,1);
#/
					continue;
				}

/#
				print3d(hackable.origin,"+",VectorScale((0,0,1)),255,1);
1
#/
			}
			else
			{
/#
				print3d(hackable.origin,"+",VectorScale((1,0,0)),255,1);
1
#/
			}
		}

		wait(0.1);
	}
}

//Function Number: 4
hacker_trigger_pool_think()
{
	if(!(IsDefined(level._zombie_hacker_trigger_pool_size)))
	{
		level._zombie_hacker_trigger_pool_size = 8;
	}

	pool_active = 0;
	level._hacker_pool = [];
	while(1)
	{
		if(pool_active)
		{
			if(!(any_hackers_active()))
			{
				destroy_pooled_items();
				continue;
			}

			sweep_pooled_items();
			add_eligable_pooled_items();
		}
		else if(any_hackers_active())
		{
			pool_active = 1;
		}

		wait(0.1);
	}
}

//Function Number: 5
destroy_pooled_items()
{
	pool_active = 0;
	for(i = 0;i < level._hacker_pool.size;i++)
	{
		level._hacker_pool[i]._trigger delete();
		level._hacker_pool[i]._trigger = undefined;
	}

	level._hacker_pool = [];
}

//Function Number: 6
sweep_pooled_items()
{
	new_hacker_pool = [];
	for(i = 0;i < level._hacker_pool.size;i++)
	{
		if(level._hacker_pool[i] should_pooled_object_exist())
		{
			new_hacker_pool[new_hacker_pool.size] = level._hacker_pool[i];
		}
		else
		{
			if(IsDefined(level._hacker_pool[i]._trigger))
			{
				level._hacker_pool[i]._trigger delete();
			}

			level._hacker_pool[i]._trigger = undefined;
		}
	}

	level._hacker_pool = new_hacker_pool;
}

//Function Number: 7
should_pooled_object_exist()
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(players[i] hacker_active())
		{
			if(IsDefined(self.entity))
			{
				if(self.entity != players[i])
				{
					if(distance2dsquared(players[i].origin,self.entity.origin) <= self.radius * self.radius)
					{
						return 1;
					}
				}
			}
			else if(distance2dsquared(players[i].origin,self.origin) <= self.radius * self.radius)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 8
add_eligable_pooled_items()
{
	candidates = [];
	for(i = 0;i < level._hackable_objects.size;i++)
	{
		hackable = level._hackable_objects[i];
		if(IsDefined(hackable.pooled) && hackable.pooled && !IsDefined(hackable._trigger))
		{
			if(!(isinarray(level._hacker_pool,hackable)))
			{
				if(hackable should_pooled_object_exist())
				{
					candidates[candidates.size] = hackable;
				}
			}
		}
	}

	for(i = 0;i < candidates.size;i++)
	{
		candidate = candidates[i];
		height = 72;
		radius = 32;
		if(IsDefined(candidate.radius))
		{
			radius = candidate.radius;
		}

		if(IsDefined(candidate.height))
		{
			height = candidate.height;
		}

		trigger = spawn("trigger_radius_use",candidate.origin,0,radius,height);
		trigger usetriggerrequirelookat();
		trigger triggerignoreteam();
		trigger setcursorhint("HINT_NOICON");
		trigger.radius = radius;
		trigger.height = height;
		trigger.beinghacked = 0;
		candidate._trigger = trigger;
		level._hacker_pool[level._hacker_pool.size] = candidate;
	}
}

//Function Number: 9
get_hackable_trigger()
{
	if(IsDefined(self.door))
	{
		return self.door;
	}
	else if(IsDefined(self.perk))
	{
		return self.perk;
	}
	else if(IsDefined(self.window))
	{
		return self.window.unitrigger_stub.trigger;
	}
	else if(IsDefined(self.classname) && getsubstr(self.classname,0,7) == "trigger_")
	{
		return self;
	}
}

//Function Number: 10
any_hackers_active()
{
	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(players[i] hacker_active())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
register_hackable(name,callback_func,qualifier_func)
{
	structs = getstructarray(name,"script_noteworthy");
	if(!(IsDefined(structs)))
	{
/#
		println("Error:  register_hackable called on script_noteworthy " + name + " but no such structs exist.");
#/
		return;
	}

	for(i = 0;i < structs.size;i++)
	{
		if(!(isinarray(level._hackable_objects,structs[i])))
		{
			structs[i]._hack_callback_func = callback_func;
			structs[i]._hack_qualifier_func = qualifier_func;
			structs[i].pooled = level._hacker_pooled;
			if(IsDefined(structs[i].targetname))
			{
				structs[i].hacker_target = getent(structs[i].targetname,"targetname");
			}

			level._hackable_objects[level._hackable_objects.size] = structs[i];
			if(IsDefined(level._hacker_pooled))
			{
				level._pooled_hackable_objects[level._pooled_hackable_objects.size] = structs[i];
			}

			structs[i] thread hackable_object_thread();
			wait_network_frame();
		}
	}
}

//Function Number: 12
register_hackable_struct(struct,callback_func,qualifier_func)
{
	if(!(isinarray(level._hackable_objects,struct)))
	{
		struct._hack_callback_func = callback_func;
		struct._hack_qualifier_func = qualifier_func;
		struct.pooled = level._hacker_pooled;
		if(IsDefined(struct.targetname))
		{
			struct.hacker_target = getent(struct.targetname,"targetname");
		}

		level._hackable_objects[level._hackable_objects.size] = struct;
		if(IsDefined(level._hacker_pooled))
		{
			level._pooled_hackable_objects[level._pooled_hackable_objects.size] = struct;
		}

		struct thread hackable_object_thread();
	}
}

//Function Number: 13
register_pooled_hackable_struct(struct,callback_func,qualifier_func)
{
	level._hacker_pooled = 1;
	register_hackable_struct(struct,callback_func,qualifier_func);
	level._hacker_pooled = undefined;
}

//Function Number: 14
register_pooled_hackable(name,callback_func,qualifier_func)
{
	level._hacker_pooled = 1;
	register_hackable(name,callback_func,qualifier_func);
	level._hacker_pooled = undefined;
}

//Function Number: 15
deregister_hackable_struct(struct)
{
	if(isinarray(level._hackable_objects,struct))
	{
		new_list = [];
		for(i = 0;i < level._hackable_objects.size;i++)
		{
			if(level._hackable_objects[i] != struct)
			{
				new_list[new_list.size] = level._hackable_objects[i];
			}
			else
			{
				level._hackable_objects[i] notify("hackable_deregistered");
				if(IsDefined(level._hackable_objects[i]._trigger))
				{
					level._hackable_objects[i]._trigger delete();
				}

				if(IsDefined(level._hackable_objects[i].pooled) && level._hackable_objects[i].pooled)
				{
					arrayremovevalue(level._hacker_pool,level._hackable_objects[i]);
					arrayremovevalue(level._pooled_hackable_objects,level._hackable_objects[i]);
				}
			}
		}

		level._hackable_objects = new_list;
	}
}

//Function Number: 16
deregister_hackable(noteworthy)
{
	new_list = [];
	for(i = 0;i < level._hackable_objects.size;i++)
	{
		if(!IsDefined(level._hackable_objects[i].script_noteworthy) || level._hackable_objects[i].script_noteworthy != noteworthy)
		{
			new_list[new_list.size] = level._hackable_objects[i];
		}
		else
		{
			level._hackable_objects[i] notify("hackable_deregistered");
			if(IsDefined(level._hackable_objects[i]._trigger))
			{
				level._hackable_objects[i]._trigger delete();
			}
		}

		if(IsDefined(level._hackable_objects[i].pooled) && level._hackable_objects[i].pooled)
		{
			arrayremovevalue(level._hacker_pool,level._hackable_objects[i]);
		}
	}

	level._hackable_objects = new_list;
}

//Function Number: 17
hack_trigger_think()
{
	while(1)
	{
		players = get_players();
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			for(j = 0;j < level._hackable_objects.size;j++)
			{
				hackable = level._hackable_objects[j];
				if(IsDefined(hackable._trigger))
				{
					qualifier_passed = 1;
					if(IsDefined(hackable._hack_qualifier_func))
					{
						qualifier_passed = hackable [[ hackable._hack_qualifier_func ]](player);
					}

					if(player hacker_active() && qualifier_passed && !hackable._trigger.beinghacked)
					{
						hackable._trigger setinvisibletoplayer(player,0);
					}
					else
					{
						hackable._trigger setinvisibletoplayer(player,1);
					}
				}
			}
		}

		wait(0.1);
	}
}

//Function Number: 18
is_facing(facee)
{
	orientation = self getplayerangles();
	forwardvec = AnglesToForward(orientation);
	forwardvec2d = (forwardvec[0],forwardvec[1],0);
	unitforwardvec2d = vectornormalize(forwardvec2d);
	tofaceevec = facee.origin - self.origin;
	tofaceevec2d = (tofaceevec[0],tofaceevec[1],0);
	unittofaceevec2d = vectornormalize(tofaceevec2d);
	dotproduct = vectordot(unitforwardvec2d,unittofaceevec2d);
	dot_limit = 0.8;
	if(IsDefined(facee.dot_limit))
	{
		dot_limit = facee.dot_limit;
	}

	return dotproduct > dot_limit;
}

//Function Number: 19
can_hack(hackable)
{
	if(!(isalive(self)))
	{
		return 0;
	}

	if(self maps/mp/zombies/_zm_laststand::player_is_in_laststand())
	{
		return 0;
	}

	if(!(self hacker_active()))
	{
		return 0;
	}

	if(!(IsDefined(hackable._trigger)))
	{
		return 0;
	}

	if(IsDefined(hackable.player))
	{
		if(hackable.player != self)
		{
			return 0;
		}
	}

	if(self throwbuttonpressed())
	{
		return 0;
	}

	if(self fragbuttonpressed())
	{
		return 0;
	}

	if(IsDefined(hackable._hack_qualifier_func))
	{
		if(!(hackable [[ hackable._hack_qualifier_func ]](self)))
		{
			return 0;
		}
	}

	if(!(isinarray(level._hackable_objects,hackable)))
	{
		return 0;
	}

	radsquared = 1024;
	if(IsDefined(hackable.radius))
	{
		radsquared = hackable.radius * hackable.radius;
	}

	origin = hackable.origin;
	if(IsDefined(hackable.entity))
	{
		origin = hackable.entity.origin;
	}

	if(distance2dsquared(self.origin,origin) > radsquared)
	{
		return 0;
	}

	if(!IsDefined(hackable.no_touch_check) && !self istouching(hackable._trigger))
	{
		return 0;
	}

	if(!(self is_facing(hackable)))
	{
		return 0;
	}

	if(!IsDefined(hackable.no_sight_check) && !sighttracepassed(50 + VectorScale((0,0,1)),self.origin,origin,0)undefined)
	{
		return 0;
	}

	if(!IsDefined(hackable.no_bullet_trace) && !bullettracepassed(50 + VectorScale((0,0,1)),self.origin,origin,0)undefined)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
is_hacking(hackable)
{
	return can_hack(hackable) && self usebuttonpressed();
}

//Function Number: 21
set_hack_hint_string()
{
	if(IsDefined(self._trigger))
	{
		if(IsDefined(self.custom_string))
		{
			self._trigger sethintstring(self.custom_string);
		}
		else if(!IsDefined(self.script_int) || self.script_int <= 0)
		{
			self._trigger sethintstring(&"ZOMBIE_HACK_NO_COST");
		}
		else
		{
			self._trigger sethintstring(&"ZOMBIE_HACK",self.script_int);
		}
	}
}

//Function Number: 22
tidy_on_deregister(hackable)
{
	self endon("clean_up_tidy_up");
	hackable waittill("hackable_deregistered");
	if(IsDefined(self.hackerprogressbar))
	{
		self.hackerprogressbar maps/mp/gametypes_zm/_hud_util::destroyelem();
	}

	if(IsDefined(self.hackertexthud))
	{
		self.hackertexthud destroy();
	}
}

//Function Number: 23
hacker_do_hack(hackable)
{
	timer = 0;
	hacked = 0;
	hackable._trigger.beinghacked = 1;
	if(!(IsDefined(self.hackerprogressbar)))
	{
		self.hackerprogressbar = self maps/mp/gametypes_zm/_hud_util::createprimaryprogressbar();
	}

	if(!(IsDefined(self.hackertexthud)))
	{
		self.hackertexthud = newclienthudelem(self);
	}

	hack_duration = hackable.script_float;
	if(self hasperk("specialty_fastreload"))
	{
		hack_duration = hack_duration * 0.66;
	}

	hack_duration = max(1.5,hack_duration);
	self thread tidy_on_deregister(hackable);
	self.hackerprogressbar maps/mp/gametypes_zm/_hud_util::updatebar(0.01,1 / hack_duration);
	self.hackertexthud.alignx = "center";
	self.hackertexthud.aligny = "middle";
	self.hackertexthud.horzalign = "center";
	self.hackertexthud.vertalign = "bottom";
	self.hackertexthud.y = -113;
	if(issplitscreen())
	{
		self.hackertexthud.y = -107;
	}

	self.hackertexthud.foreground = 1;
	self.hackertexthud.font = "default";
	self.hackertexthud.fontscale = 1.8;
	self.hackertexthud.alpha = 1;
	self.hackertexthud.color = (1,1,1);
	self.hackertexthud settext(&"ZOMBIE_HACKING");
	self playloopsound("zmb_progress_bar",0.5);
	while(self is_hacking(hackable))
	{
		wait(0.05);
		timer = timer + 0.05;
		if(self maps/mp/zombies/_zm_laststand::player_is_in_laststand())
		{
			break;
		}

		if(timer >= hack_duration)
		{
			hacked = 1;
			break;
		}
	}

	self stoploopsound(0.5);
	if(hacked)
	{
		self playsound("vox_mcomp_hack_success");
	}
	else
	{
		self playsound("vox_mcomp_hack_fail");
	}

	if(IsDefined(self.hackerprogressbar))
	{
		self.hackerprogressbar maps/mp/gametypes_zm/_hud_util::destroyelem();
	}

	if(IsDefined(self.hackertexthud))
	{
		self.hackertexthud destroy();
	}

	hackable set_hack_hint_string();
	if(IsDefined(hackable._trigger))
	{
		hackable._trigger.beinghacked = 0;
	}

	self notify("clean_up_tidy_up");
	return hacked;
}

//Function Number: 24
lowreadywatcher(player)
{
	player endon("disconnected");
	self endon("kill_lowreadywatcher");
	self waittill("hackable_deregistered");
}

//Function Number: 25
hackable_object_thread()
{
	self endon("hackable_deregistered");
	height = 72;
	radius = 64;
	if(IsDefined(self.radius))
	{
		radius = self.radius;
	}

	if(IsDefined(self.height))
	{
		height = self.height;
	}

	if(!(IsDefined(self.pooled)))
	{
		trigger = spawn("trigger_radius_use",self.origin,0,radius,height);
		trigger usetriggerrequirelookat();
		trigger setcursorhint("HINT_NOICON");
		trigger.radius = radius;
		trigger.height = height;
		trigger.beinghacked = 0;
		self._trigger = trigger;
	}

	cost = 0;
	if(IsDefined(self.script_int))
	{
		cost = self.script_int;
	}

	duration = 1;
	if(IsDefined(self.script_float))
	{
		duration = self.script_float;
	}

	while(1)
	{
		wait(0.1);
		if(!(IsDefined(self._trigger)))
		{
			continue;
		}

		players = get_players();
		if(IsDefined(self._trigger))
		{
			if(IsDefined(self.entity))
			{
				self.origin = self.entity.origin;
				self._trigger.origin = self.entity.origin;
				if(IsDefined(self.trigger_offset))
				{
					self._trigger.origin = self._trigger.origin + self.trigger_offset;
				}
			}
		}

		for(i = 0;i < players.size;i++)
		{
			if(players[i] can_hack(self))
			{
				self set_hack_hint_string();
				break;
			}
		}

		for(i = 0;i < players.size;i++)
		{
			hacker = players[i];
			if(!(hacker is_hacking(self)))
			{
			}
			else if(hacker.score >= cost || cost <= 0)
			{
				self thread lowreadywatcher(hacker);
				hack_success = hacker hacker_do_hack(self);
				self notify("kill_lowreadywatcher");
				if(IsDefined(hacker))
				{
				}

				if(IsDefined(hacker) && hack_success)
				{
					if(cost)
					{
						if(cost > 0)
						{
							hacker maps/mp/zombies/_zm_score::minus_to_player_score(cost);
						}
						else
						{
							hacker maps/mp/zombies/_zm_score::add_to_player_score(cost * -1);
						}
					}

					hacker notify("successful_hack");
					if(IsDefined(self._hack_callback_func))
					{
						self thread [[ self._hack_callback_func ]](hacker);
					}
				}
			}
			else
			{
				hacker play_sound_on_ent("no_purchase");
				hacker maps/mp/zombies/_zm_audio::create_and_play_dialog("general","no_money",undefined,1);
			}
		}
	}
}

//Function Number: 26
hacker_on_player_connect()
{
	struct = spawnstruct();
	struct.origin = self.origin;
	struct.radius = 48;
	struct.height = 64;
	struct.script_float = 10;
	struct.script_int = 500;
	struct.entity = self;
	struct.trigger_offset = VectorScale((0,0,1));
	register_pooled_hackable_struct(struct,::player_hack,::player_qualifier);
	struct thread player_hack_disconnect_watcher(self);
}

//Function Number: 27
player_hack_disconnect_watcher(player)
{
	player waittill("disconnect");
	deregister_hackable_struct(self);
}

//Function Number: 28
player_hack(hacker)
{
	if(IsDefined(self.entity))
	{
		self.entity maps/mp/zombies/_zm_score::player_add_points("hacker_transfer",500);
	}

	if(IsDefined(hacker))
	{
		hacker thread maps/mp/zombies/_zm_audio::create_and_play_dialog("general","hack_plr");
	}
}

//Function Number: 29
player_qualifier(player)
{
	if(player == self.entity)
	{
		return 0;
	}

	if(self.entity maps/mp/zombies/_zm_laststand::player_is_in_laststand())
	{
		return 0;
	}

	if(player maps/mp/zombies/_zm_laststand::player_is_in_laststand())
	{
		return 0;
	}

	if(IsDefined(self.entity.sessionstate == "spectator") && self.entity.sessionstate == "spectator")
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
hide_hint_when_hackers_active(custom_logic_func,custom_logic_func_param)
{
	invis_to_any = 0;
	while(1)
	{
		if(IsDefined(custom_logic_func))
		{
			self [[ custom_logic_func ]](custom_logic_func_param);
		}

		if(maps/mp/zombies/_zm_equip_hacker::any_hackers_active())
		{
			players = get_players();
			for(i = 0;i < players.size;i++)
			{
				if(players[i] hacker_active())
				{
					self setinvisibletoplayer(players[i],1);
					invis_to_any = 1;
				}
				else
				{
					self setinvisibletoplayer(players[i],0);
				}
			}
		}
		else if(invis_to_any)
		{
			invis_to_any = 0;
			players = get_players();
			for(i = 0;i < players.size;i++)
			{
				self setinvisibletoplayer(players[i],0);
			}
		}

		wait(0.1);
	}
}

//Function Number: 31
hacker_debug_print(msg,color)
{
/#
	return;
	color = (1,1,1);
	print3d(60 + VectorScale((0,0,1)),self.origin,msg,color,1,1);
40
IsDefined(color)
GetDvarInt(#"428DE100")
#/
}