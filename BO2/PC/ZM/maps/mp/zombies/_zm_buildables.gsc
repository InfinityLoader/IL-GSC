/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_buildables.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 127
 * Decompile Time: 453 ms
 * Timestamp: 10/27/2023 3:03:01 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_demo;
#include maps/mp/_utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
	precachestring(&"ZOMBIE_BUILDING");
	precachestring(&"ZOMBIE_BUILD_PIECE_MISSING");
	precachestring(&"ZOMBIE_BUILD_PIECE_GRAB");
	precacheitem("zombie_builder_zm");
	precacheitem("buildable_piece_zm");
	level.gameobjswapping = 1;
	zombie_buildables_callbacks = [];
	level.buildablepickups = [];
	level.buildables_built = [];
	level.buildable_stubs = [];
	level.buildable_piece_count = 0;
	level._effect["building_dust"] = loadfx("maps/zombie/fx_zmb_buildable_assemble_dust");
	if(IsDefined(level.init_buildables))
	{
		[[ level.init_buildables ]]();
	}

	if(IsDefined(level.use_swipe_protection))
	{
		onplayerconnect_callback(::buildables_watch_swipes);
	}
}

//Function Number: 2
anystub_update_prompt(player)
{
	if(player maps/mp/zombies/_zm_laststand::player_is_in_laststand() || player in_revive_trigger())
	{
		self.hint_string = "";
		return 0;
	}

	if(player isthrowinggrenade())
	{
		self.hint_string = "";
		return 0;
	}

	if(IsDefined(player.is_drinking) && player.is_drinking > 0)
	{
		self.hint_string = "";
		return 0;
	}

	if(IsDefined(player.screecher_weapon))
	{
		self.hint_string = "";
		return 0;
	}

	return 1;
}

//Function Number: 3
anystub_get_unitrigger_origin()
{
	if(IsDefined(self.origin_parent))
	{
		return self.origin_parent.origin;
	}

	return self.origin;
}

//Function Number: 4
anystub_on_spawn_trigger(trigger)
{
	if(IsDefined(self.link_parent))
	{
		trigger enablelinkto();
		trigger linkto(self.link_parent);
		trigger setmovingplatformenabled(1);
	}
}

//Function Number: 5
buildables_watch_swipes()
{
	self endon("disconnect");
	self notify("buildables_watch_swipes");
	self endon("buildables_watch_swipes");
	while(1)
	{
		self waittill("melee_swipe",zombie);
		if(distancesquared(zombie.origin,self.origin) > zombie.meleeattackdist * zombie.meleeattackdist)
		{
			continue;
		}

		trigger = level._unitriggers.trigger_pool[self getentitynumber()];
		if(IsDefined(trigger) && IsDefined(trigger.stub.piece))
		{
			piece = trigger.stub.piece;
			if(!(IsDefined(piece.damage)))
			{
				piece.damage = 0;
			}

			piece.damage++;
			if(piece.damage > 12)
			{
				thread maps/mp/zombies/_zm_equipment::equipment_disappear_fx(trigger.stub maps/mp/zombies/_zm_unitrigger::unitrigger_origin());
				piece maps/mp/zombies/_zm_buildables::piece_unspawn();
				self maps/mp/zombies/_zm_stats::increment_client_stat("cheat_total",0);
				if(isalive(self))
				{
					self playlocalsound(level.zmb_laugh_alias);
				}
			}
		}
	}
}

//Function Number: 6
explosiondamage(damage,pos)
{
/#
	println("ZM BUILDABLE Explode do " + damage + " damage to " + self.name + "\n");
#/
	self dodamage(damage,pos);
}

//Function Number: 7
add_zombie_buildable(buildable_name,hint,building,bought)
{
	if(!(IsDefined(level.zombie_include_buildables)))
	{
		level.zombie_include_buildables = [];
	}

	if(IsDefined(level.zombie_include_buildables) && !IsDefined(level.zombie_include_buildables[buildable_name]))
	{
		return;
	}

	precachestring(hint);
	if(IsDefined(building))
	{
		precachestring(building);
	}

	if(IsDefined(bought))
	{
		precachestring(bought);
	}

	buildable_struct = level.zombie_include_buildables[buildable_name];
	if(!(IsDefined(level.zombie_buildables)))
	{
		level.zombie_buildables = [];
	}

	buildable_struct.hint = hint;
	buildable_struct.building = building;
	buildable_struct.bought = bought;
/#
	println("ZM >> Looking for buildable - " + buildable_struct.name);
#/
	level.zombie_buildables[buildable_struct.name] = buildable_struct;
	if(!(level.createfx_enabled))
	{
		if(level.zombie_buildables.size == 1)
		{
			register_clientfields();
		}
	}
}

//Function Number: 8
register_clientfields()
{
	if(IsDefined(level.buildable_slot_count))
	{
		for(i = 0;i < level.buildable_slot_count;i++)
		{
			bits = getminbitcountfornum(level.buildable_piece_counts[i]);
			registerclientfield("toplayer",level.buildable_clientfields[i],12000,bits,"int");
		}
	}
	else
	{
		bits = getminbitcountfornum(level.buildable_piece_count);
		registerclientfield("toplayer","buildable",1,bits,"int");
	}
}

//Function Number: 9
set_buildable_clientfield(slot,newvalue)
{
	if(IsDefined(level.buildable_slot_count))
	{
		self setclientfieldtoplayer(level.buildable_clientfields[slot],newvalue);
	}
	else
	{
		self setclientfieldtoplayer("buildable",newvalue);
	}
}

//Function Number: 10
clear_buildable_clientfield(slot)
{
	self set_buildable_clientfield(slot,0);
}

//Function Number: 11
include_zombie_buildable(buiildable_struct)
{
	if(!(IsDefined(level.zombie_include_buildables)))
	{
		level.zombie_include_buildables = [];
	}

/#
	println("ZM >> Including buildable - " + buiildable_struct.name);
#/
	level.zombie_include_buildables[buiildable_struct.name] = buiildable_struct;
}

//Function Number: 12
generate_zombie_buildable_piece(buildablename,modelname,radius,height,drop_offset,hud_icon,onpickup,ondrop,use_spawn_num,part_name,can_reuse,client_field_state,buildable_slot)
{
	precachemodel(modelname);
	if(IsDefined(hud_icon))
	{
		precacheshader(hud_icon);
	}

	piece = spawnstruct();
	buildable_pieces = [];
	buildable_pieces_structs = getstructarray(buildablename + "_" + modelname,"targetname");
/#
	println("ERROR: Missing buildable piece <" + buildablename + "> <" + modelname + ">\n");
buildable_pieces_structs.size < 1
#/
	foreach(index, struct in buildable_pieces_structs)
	{
		buildable_pieces[index] = struct;
		buildable_pieces[index].hasspawned = 0;
	}

	piece.spawns = buildable_pieces;
	piece.buildablename = buildablename;
	piece.modelname = modelname;
	piece.hud_icon = hud_icon;
	piece.radius = radius;
	piece.height = height;
	piece.part_name = part_name;
	piece.can_reuse = can_reuse;
	piece.drop_offset = drop_offset;
	piece.max_instances = 256;
	if(IsDefined(buildable_slot))
	{
		piece.buildable_slot = buildable_slot;
	}
	else
	{
		piece.buildable_slot = 0;
	}

	piece.onpickup = onpickup;
	piece.ondrop = ondrop;
	piece.use_spawn_num = use_spawn_num;
	piece.client_field_state = client_field_state;
	return piece;
}

//Function Number: 13
manage_multiple_pieces(max_instances,min_instances)
{
	self.max_instances = max_instances;
	self.min_instances = min_instances;
	self.managing_pieces = 1;
	self.piece_allocated = [];
}

//Function Number: 14
buildable_set_force_spawn_location(str_kvp,str_name)
{
	self.str_force_spawn_kvp = str_kvp;
	self.str_force_spawn_name = str_name;
}

//Function Number: 15
buildable_use_cyclic_spawns(randomize_start_location)
{
	self.use_cyclic_spawns = 1;
	self.randomize_cyclic_index = randomize_start_location;
}

//Function Number: 16
combine_buildable_pieces(piece1,piece2,piece3)
{
	spawns1 = piece1.spawns;
	spawns2 = piece2.spawns;
	spawns = arraycombine(spawns1,spawns2,1,0);
	if(IsDefined(piece3))
	{
		spawns3 = piece3.spawns;
		spawns = arraycombine(spawns,spawns3,1,0);
		spawns = array_randomize(spawns);
		piece3.spawns = spawns;
	}
	else
	{
		spawns = array_randomize(spawns);
	}

	piece1.spawns = spawns;
	piece2.spawns = spawns;
}

//Function Number: 17
add_buildable_piece(piece,part_name,can_reuse)
{
	if(!(IsDefined(self.buildablepieces)))
	{
		self.buildablepieces = [];
	}

	if(IsDefined(part_name))
	{
		piece.part_name = part_name;
	}

	if(IsDefined(can_reuse))
	{
		piece.can_reuse = can_reuse;
	}

	self.buildablepieces[self.buildablepieces.size] = piece;
	if(!(IsDefined(self.buildable_slot)))
	{
		self.buildable_slot = piece.buildable_slot;
	}
	else
	{
/#
/#
		assert(self.buildable_slot == piece.buildable_slot);
#/
#/
	}
}

//Function Number: 18
create_zombie_buildable_piece(modelname,radius,height,hud_icon)
{
	piece = generate_zombie_buildable_piece(self.name,modelname,radius,height,hud_icon);
	self add_buildable_piece(piece);
}

//Function Number: 19
onplayerlaststand()
{
	pieces = self player_get_buildable_pieces();
	spawn_pos = [];
	spawn_pos[0] = self.origin;
	if(pieces.size >= 2)
	{
		nodes = getnodesinradiussorted(30 + VectorScale((0,0,1)),self.origin,120,30,72,"path");
		for(i = 0;i < pieces.size;i++)
		{
			if(i < nodes.size && check_point_in_playable_area(nodes[i].origin))
			{
				spawn_pos[i] = nodes[i].origin;
			}
			else
			{
				spawn_pos[i] = 5 + VectorScale((1,1,0));
			}
		}
	}

	spawnidx = 0;
	foreach(piece in pieces)
	{
		slot = piece.buildable_slot;
		if(IsDefined(piece))
		{
			return_to_start_pos = 0;
			if(IsDefined(level.safe_place_for_buildable_piece))
			{
				if(!(self [[ level.safe_place_for_buildable_piece ]](piece)))
				{
					return_to_start_pos = 1;
				}
			}

			if(return_to_start_pos)
			{
				piece piece_spawn_at();
			}
			else if(pieces.size < 2)
			{
				piece piece_spawn_at(5 + VectorScale((1,1,0)),self.origin);
			}
			else
			{
				piece piece_spawn_at(spawn_pos[spawnidx],self.angles);
			}

			if(IsDefined(piece.ondrop))
			{
				piece [[ piece.ondrop ]](self);
			}

			self clear_buildable_clientfield(slot);
			spawnidx++;
		}

		self player_set_buildable_piece(undefined,slot);
		self notify("piece_released" + slot,self.angles,self.origin,5);
	}
}

//Function Number: 20
piecestub_get_unitrigger_origin()
{
	if(IsDefined(self.origin_parent))
	{
		return 12 + VectorScale((0,0,1));
	}

	return self.origin;
}

//Function Number: 21
generate_piece_unitrigger(classname,origin,angles,flags,radius,script_height,moving)
{
	if(!(IsDefined(radius)))
	{
		radius = 64;
	}

	if(!(IsDefined(script_height)))
	{
		script_height = 64;
	}

	script_width = script_height;
	if(!(IsDefined(script_width)))
	{
		script_width = 64;
	}

	script_length = script_height;
	if(!(IsDefined(script_length)))
	{
		script_length = 64;
	}

	unitrigger_stub = spawnstruct();
	unitrigger_stub.origin = origin;
	if(IsDefined(script_length))
	{
		unitrigger_stub.script_length = script_length;
	}
	else
	{
		unitrigger_stub.script_length = 13.5;
	}

	if(IsDefined(script_width))
	{
		unitrigger_stub.script_width = script_width;
	}
	else
	{
		unitrigger_stub.script_width = 27.5;
	}

	if(IsDefined(script_height))
	{
		unitrigger_stub.script_height = script_height;
	}
	else
	{
		unitrigger_stub.script_height = 24;
	}

	unitrigger_stub.radius = radius;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	unitrigger_stub.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.require_look_at = 0;
	switch(classname)
	{
		case "trigger_radius":
			unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
			break;

		case "trigger_radius_use":
			unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
			break;

		case "trigger_box":
			unitrigger_stub.script_unitrigger_type = "unitrigger_box";
			break;

		case "trigger_box_use":
			unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
			break;
	}

	unitrigger_force_per_player_triggers(unitrigger_stub,1);
	unitrigger_stub.prompt_and_visibility_func = ::piecetrigger_update_prompt;
	unitrigger_stub.originfunc = ::piecestub_get_unitrigger_origin;
	unitrigger_stub.onspawnfunc = ::anystub_on_spawn_trigger;
	if(IsDefined(moving) && moving)
	{
		maps/mp/zombies/_zm_unitrigger::register_unitrigger(unitrigger_stub,::piece_unitrigger_think);
	}
	else
	{
		maps/mp/zombies/_zm_unitrigger::register_static_unitrigger(unitrigger_stub,::piece_unitrigger_think);
	}

	return unitrigger_stub;
}

//Function Number: 22
piecetrigger_update_prompt(player)
{
	can_use = self.stub piecestub_update_prompt(player);
	self setinvisibletoplayer(player,!can_use);
	if(IsDefined(self.stub.hint_parm1))
	{
		self sethintstring(self.stub.hint_string,self.stub.hint_parm1);
	}
	else
	{
		self sethintstring(self.stub.hint_string);
	}

	if(IsDefined(self.stub.cursor_hint))
	{
		if(self.stub.cursor_hint == "HINT_WEAPON" && IsDefined(self.stub.cursor_hint_weapon))
		{
			self setcursorhint(self.stub.cursor_hint,self.stub.cursor_hint_weapon);
		}
		else
		{
			self setcursorhint(self.stub.cursor_hint);
		}
	}

	return can_use;
}

//Function Number: 23
piecestub_update_prompt(player)
{
	if(!(self anystub_update_prompt(player)))
	{
		self.cursor_hint = "HINT_NOICON";
		return 0;
	}

	if(IsDefined(player player_get_buildable_piece(self.piece.buildable_slot)))
	{
		spiece = self.piece;
		cpiece = player player_get_buildable_piece(self.piece.buildable_slot);
		if(spiece.modelname == cpiece.modelname && spiece.buildablename == cpiece.buildablename && !IsDefined(spiece.script_noteworthy) || !IsDefined(cpiece.script_noteworthy) || spiece.script_noteworthy == cpiece.script_noteworthy)
		{
			self.hint_string = "";
			return 0;
		}

		if(IsDefined(spiece.hint_swap))
		{
			self.hint_string = spiece.hint_swap;
			self.hint_parm1 = self.piece.hint_swap_parm1;
		}
		else
		{
			self.hint_string = &"ZOMBIE_BUILD_PIECE_SWITCH";
		}

		if(IsDefined(self.piece.cursor_hint))
		{
			self.cursor_hint = self.piece.cursor_hint;
		}

		if(IsDefined(self.piece.cursor_hint_weapon))
		{
			self.cursor_hint_weapon = self.piece.cursor_hint_weapon;
		}
	}
	else
	{
		if(IsDefined(self.piece.hint_grab))
		{
			self.hint_string = self.piece.hint_grab;
			self.hint_parm1 = self.piece.hint_grab_parm1;
		}
		else
		{
			self.hint_string = &"ZOMBIE_BUILD_PIECE_GRAB";
		}

		if(IsDefined(self.piece.cursor_hint))
		{
			self.cursor_hint = self.piece.cursor_hint;
		}

		if(IsDefined(self.piece.cursor_hint_weapon))
		{
			self.cursor_hint_weapon = self.piece.cursor_hint_weapon;
		}
	}

	return 1;
}

//Function Number: 24
piece_unitrigger_think()
{
	self endon("kill_trigger");
	while(1)
	{
		self waittill("trigger",player);
		if(player != self.parent_player)
		{
			continue;
		}

		if(IsDefined(player.screecher_weapon))
		{
			continue;
		}

		if(!(is_player_valid(player)))
		{
			player thread ignore_triggers(0.5);
			continue;
		}

		status = player player_can_take_piece(self.stub.piece);
		if(!(status))
		{
			self.stub.hint_string = "";
			self sethintstring(self.stub.hint_string);
			continue;
		}

		player thread player_take_piece(self.stub.piece);
	}
}

//Function Number: 25
player_get_buildable_pieces()
{
	if(!(IsDefined(self.current_buildable_pieces)))
	{
		self.current_buildable_pieces = [];
	}

	return self.current_buildable_pieces;
}

//Function Number: 26
player_get_buildable_piece(slot)
{
	if(!(IsDefined(slot)))
	{
		slot = 0;
	}

	if(!(IsDefined(self.current_buildable_pieces)))
	{
		self.current_buildable_pieces = [];
	}

	return self.current_buildable_pieces[slot];
}

//Function Number: 27
player_set_buildable_piece(piece,slot)
{
	if(!(IsDefined(slot)))
	{
		slot = 0;
	}

/#
/#
	assert(slot == piece.buildable_slot);
#/
IsDefined(slot) && IsDefined(piece) && IsDefined(piece.buildable_slot)
#/
	if(!(IsDefined(self.current_buildable_pieces)))
	{
		self.current_buildable_pieces = [];
	}

	self.current_buildable_pieces[slot] = piece;
}

//Function Number: 28
player_can_take_piece(piece)
{
	if(!(IsDefined(piece)))
	{
		return 0;
	}
}

//Function Number: 29
dbline(from,to)
{
/#
	time = 20;
	for(;;)
	{
		line(from,to,(0,0,1),0,1);
		time = time - 0.05;
		wait(0.05);
	}
time > 0
#/
}

//Function Number: 30
player_throw_piece(piece,origin,dir,return_to_spawn,return_time,endangles)
{
/#
	assert(IsDefined(piece));
#/
	if(IsDefined(piece))
	{
/#
		thread dbline(origin,origin + dir);
#/
		pass = 0;
		done = 0;
		altmodel = undefined;
		while(pass < 2 && !done)
		{
			grenade = self magicgrenadetype("buildable_piece_zm",origin,dir,30000);
			grenade thread watch_hit_players();
			grenade ghost();
			if(!(IsDefined(altmodel)))
			{
				altmodel = spawn("script_model",grenade.origin);
				altmodel setmodel(piece.modelname);
			}

			altmodel.origin = grenade.angles;
			altmodel.angles = grenade.angles;
			altmodel linkto(grenade,"",(0,0,0),(0,0,0));
			grenade.altmodel = altmodel;
			grenade waittill("stationary");
			grenade_origin = grenade.origin;
			grenade_angles = grenade.angles;
			landed_on = grenade getgroundent();
			grenade delete();
			if(IsDefined(landed_on) && landed_on == level)
			{
				done = 1;
				continue;
			}

			origin = grenade_origin;
			dir = (dir[0] * -1 / 10,dir[1] * -1 / 10,-1);
			pass++;
		}

		if(!(IsDefined(endangles)))
		{
			endangles = grenade_angles;
		}

		piece piece_spawn_at(grenade_origin,endangles);
		if(IsDefined(altmodel))
		{
			altmodel delete();
		}

		if(IsDefined(piece.ondrop))
		{
			piece [[ piece.ondrop ]](self);
		}

		if(IsDefined(return_to_spawn) && return_to_spawn)
		{
			piece piece_wait_and_return(return_time);
		}
	}
}

//Function Number: 31
watch_hit_players()
{
	self endon("death");
	self endon("stationary");
	while(IsDefined(self))
	{
		self waittill("grenade_bounce",pos,normal,ent);
		if(isplayer(ent))
		{
			ent explosiondamage(25,pos);
		}
	}
}

//Function Number: 32
piece_wait_and_return(return_time)
{
	self endon("pickup");
	wait(0.15);
	if(IsDefined(level.exploding_jetgun_fx))
	{
		playfxontag(level.exploding_jetgun_fx,self.model,"tag_origin");
	}
	else
	{
		playfxontag(level._effect["powerup_on"],self.model,"tag_origin");
	}

	wait(return_time - 6);
	self piece_hide();
	wait(1);
	self piece_show();
	wait(1);
	self piece_hide();
	wait(1);
	self piece_show();
	wait(1);
	self piece_hide();
	wait(1);
	self piece_show();
	wait(1);
	self notify("respawn");
	self piece_unspawn();
	self piece_spawn_at();
}

//Function Number: 33
player_return_piece_to_original_spawn(slot)
{
	if(!(IsDefined(slot)))
	{
		slot = 0;
	}

	self notify("piece_released" + slot);
	piece = self player_get_buildable_piece(slot);
	self player_set_buildable_piece(undefined,slot);
	if(IsDefined(piece))
	{
		piece piece_spawn_at();
		self clear_buildable_clientfield(slot);
	}
}

//Function Number: 34
player_drop_piece_on_death(slot)
{
	self notify("piece_released" + slot);
	self endon("piece_released" + slot);
	origin = self.origin;
	angles = self.angles;
	piece = self player_get_buildable_piece(slot);
	self waittill("death_or_disconnect");
	piece piece_spawn_at(origin,angles);
	if(IsDefined(self))
	{
		self clear_buildable_clientfield(slot);
	}

	if(IsDefined(piece.ondrop))
	{
		piece [[ piece.ondrop ]](self);
	}
}

//Function Number: 35
player_drop_piece(piece,slot)
{
	if(!(IsDefined(slot)))
	{
		slot = 0;
	}

	if(!(IsDefined(piece)))
	{
		piece = self player_get_buildable_piece(slot);
	}
	else
	{
		slot = piece.buildable_slot;
	}

	if(IsDefined(piece))
	{
		origin = self.origin;
		origintrace = groundtrace(5 + VectorScale((0,0,1)),origin,999999 - VectorScale((0,0,1)),origin);
		if(IsDefined(origintrace["entity"]))
		{
			origintrace = groundtrace(origintrace["entity"].origin,999999 - VectorScale((0,0,1)),origintrace["entity"].origin,0);
		}

		if(IsDefined(origintrace["position"]))
		{
			origin = origintrace["position"];
		}

		piece.damage = 0;
		piece piece_spawn_at(origin,self.angles);
		if(isplayer(self))
		{
			self clear_buildable_clientfield(slot);
		}

		if(IsDefined(piece.ondrop))
		{
			piece [[ piece.ondrop ]](self);
		}
	}

	self player_set_buildable_piece(undefined,slot);
	self notify("piece_released" + slot,origintrace["entity"],0,self);
}

//Function Number: 36
player_take_piece(piece)
{
	piece_slot = piece.buildable_slot;
	damage = piece.damage;
	if(IsDefined(self player_get_buildable_piece(piece_slot)))
	{
		other_piece = self player_get_buildable_piece(piece_slot);
		self player_drop_piece(self player_get_buildable_piece(piece_slot),piece_slot);
		other_piece.damage = damage;
		self do_player_general_vox("general","build_swap");
	}

	if(IsDefined(piece.onpickup))
	{
		piece [[ piece.onpickup ]](self);
	}

	piece piece_unspawn();
	piece notify("pickup");
	if(isplayer(self))
	{
		if(IsDefined(piece.client_field_state))
		{
			self set_buildable_clientfield(piece_slot,piece.client_field_state);
		}

		self player_set_buildable_piece(piece,piece_slot);
		self thread player_drop_piece_on_death(piece_slot);
		self track_buildable_piece_pickedup(piece);
	}
}

//Function Number: 37
player_destroy_piece(piece)
{
	if(!(IsDefined(piece)))
	{
		piece = self player_get_buildable_piece();
	}

	if(isplayer(self))
	{
		slot = piece.buildable_slot;
		if(IsDefined(piece))
		{
			piece piece_destroy();
			self clear_buildable_clientfield(slot);
		}

		self player_set_buildable_piece(undefined,slot);
		self notify("piece_released" + slot);
	}
}

//Function Number: 38
claim_location(location)
{
	if(!(IsDefined(level.buildable_claimed_locations)))
	{
		level.buildable_claimed_locations = [];
	}

	if(!(IsDefined(level.buildable_claimed_locations[location])))
	{
		level.buildable_claimed_locations[location] = 1;
		return 1;
	}
}

//Function Number: 39
is_point_in_build_trigger(point)
{
	candidate_list = [];
	foreach(zone in level.zones)
	{
		if(IsDefined(zone.unitrigger_stubs))
		{
			candidate_list = arraycombine(candidate_list,zone.unitrigger_stubs,1,0);
		}
	}

	valid_range = 128;
	closest = maps/mp/zombies/_zm_unitrigger::get_closest_unitriggers(point,candidate_list,valid_range);
	for(index = 0;index < closest.size;index++)
	{
		if(IsDefined(closest[index].registered) && closest[index].registered && IsDefined(closest[index].piece))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
piece_allocate_spawn(piecespawn)
{
	self.current_spawn = 0;
	self.managed_spawn = 1;
	self.piecespawn = piecespawn;
	if(IsDefined(piecespawn.str_force_spawn_kvp))
	{
		s_struct = getstruct(piecespawn.str_force_spawn_name,piecespawn.str_force_spawn_kvp);
		if(IsDefined(s_struct))
		{
			for(i = 0;i < self.spawns.size;i++)
			{
				if(s_struct == self.spawns[i])
				{
					self.current_spawn = i;
					piecespawn.piece_allocated[self.current_spawn] = 1;
					piecespawn.str_force_spawn_kvp = undefined;
					piecespawn.str_force_spawn_name = undefined;
					return;
				}
			}
		}
	}

	if(IsDefined(piecespawn.use_cyclic_spawns))
	{
		piece_allocate_cyclic(piecespawn);
		return;
	}

	if(self.spawns.size >= 1 && self.spawns.size > 1)
	{
		any_good = 0;
		any_okay = 0;
		totalweight = 0;
		spawnweights = [];
		for(i = 0;i < self.spawns.size;i++)
		{
			if(IsDefined(piecespawn.piece_allocated[i]) && piecespawn.piece_allocated[i])
			{
				spawnweights[i] = 0;
			}
			else if(IsDefined(self.spawns[i].script_forcespawn) && self.spawns[i].script_forcespawn)
			{
				switch(self.spawns[i].script_forcespawn)
				{
					case "4":
						spawnweights[i] = 0;
						break;

					case "1":
						self.spawns[i].script_forcespawn = 0;
						break;

					case "2":
						self.current_spawn = i;
						piecespawn.piece_allocated[self.current_spawn] = 1;
						break;

					case "3":
						self.spawns[i].script_forcespawn = 4;
						self.current_spawn = i;
						piecespawn.piece_allocated[self.current_spawn] = 1;
						break;

					default:
						any_okay = 1;
						spawnweights[i] = 0.01;
						break;
				}
			}
			else if(is_point_in_build_trigger(self.spawns[i].origin))
			{
				any_okay = 1;
				spawnweights[i] = 0.01;
			}
			else
			{
				any_good = 1;
				spawnweights[i] = 1;
			}

			totalweight = totalweight + spawnweights[i];
		}

/#
/#
		assert(any_good || any_okay,"There is nowhere to spawn this piece");
#/
#/
		if(any_good)
		{
			totalweight = float(int(totalweight));
		}

		r = randomfloat(totalweight);
		for(i = 0;i < self.spawns.size;i++)
		{
			if(!any_good || spawnweights[i] >= 1)
			{
				r = r - spawnweights[i];
				if(r < 0)
				{
					self.current_spawn = i;
					piecespawn.piece_allocated[self.current_spawn] = 1;
					return;
				}
			}
		}

		self.current_spawn = randomint(self.spawns.size);
		piecespawn.piece_allocated[self.current_spawn] = 1;
	}
}

//Function Number: 41
piece_allocate_cyclic(piecespawn)
{
	if(self.spawns.size > 1)
	{
		if(IsDefined(piecespawn.randomize_cyclic_index))
		{
			piecespawn.randomize_cyclic_index = undefined;
			piecespawn.cyclic_index = randomint(self.spawns.size);
		}

		if(!(IsDefined(piecespawn.cyclic_index)))
		{
			piecespawn.cyclic_index = 0;
		}

		piecespawn.cyclic_index++;
		if(piecespawn.cyclic_index >= self.spawns.size)
		{
			piecespawn.cyclic_index = 0;
		}
	}
	else
	{
		piecespawn.cyclic_index = 0;
	}

	self.current_spawn = piecespawn.cyclic_index;
	piecespawn.piece_allocated[self.current_spawn] = 1;
}

//Function Number: 42
piece_deallocate_spawn()
{
	if(IsDefined(self.current_spawn))
	{
		self.piecespawn.piece_allocated[self.current_spawn] = 0;
		self.current_spawn = undefined;
	}

	self.start_origin = undefined;
}

//Function Number: 43
piece_pick_random_spawn()
{
	self.current_spawn = 0;
	if(self.spawns.size >= 1 && self.spawns.size > 1)
	{
		self.current_spawn = randomint(self.spawns.size);
		while(IsDefined(self.spawns[self.current_spawn].claim_location) && !claim_location(self.spawns[self.current_spawn].claim_location))
		{
			arrayremoveindex(self.spawns,self.current_spawn);
			if(self.spawns.size < 1)
			{
				self.current_spawn = 0;
/#
				println("ERROR: All buildable spawn locations claimed");
#/
				return;
			}

			self.current_spawn = randomint(self.spawns.size);
		}
	}
}

//Function Number: 44
piece_set_spawn(num)
{
	self.current_spawn = 0;
	if(self.spawns.size >= 1 && self.spawns.size > 1)
	{
		self.current_spawn = int(min(num,self.spawns.size - 1));
	}
}

//Function Number: 45
piece_spawn_in(piecespawn)
{
	if(self.spawns.size < 1)
	{
		return;
	}

	if(IsDefined(self.managed_spawn) && self.managed_spawn)
	{
		if(!(IsDefined(self.current_spawn)))
		{
			self piece_allocate_spawn(self.piecespawn);
		}
	}

	if(!(IsDefined(self.current_spawn)))
	{
		self.current_spawn = 0;
	}

	spawndef = self.spawns[self.current_spawn];
	self.script_noteworthy = spawndef.script_noteworthy;
	self.script_parameters = spawndef.script_parameters;
	self.unitrigger = generate_piece_unitrigger("trigger_radius_use",12 + VectorScale((0,0,1)),spawndef.origin,spawndef.angles,0,piecespawn.radius,piecespawn.height);
	self.unitrigger.piece = self;
	self.buildable_slot = piecespawn.buildable_slot;
	self.radius = piecespawn.radius;
	self.height = piecespawn.height;
	self.buildablename = piecespawn.buildablename;
	self.modelname = piecespawn.modelname;
	self.hud_icon = piecespawn.hud_icon;
	self.part_name = piecespawn.part_name;
	self.drop_offset = piecespawn.drop_offset;
	self.start_origin = spawndef.origin;
	self.start_angles = spawndef.angles;
	self.client_field_state = piecespawn.client_field_state;
	self.hint_grab = piecespawn.hint_grab;
	self.hint_swap = piecespawn.hint_swap;
	self.model = spawn("script_model",self.start_origin);
	if(IsDefined(self.start_angles))
	{
		self.model.angles = self.start_angles;
	}

	self.model setmodel(piecespawn.modelname);
	self.model ghostindemo();
	self.model.hud_icon = piecespawn.hud_icon;
	self.piecespawn = piecespawn;
	self.unitrigger.origin_parent = self.model;
	self.building = undefined;
	self.onunspawn = piecespawn.onunspawn;
	self.ondestroy = piecespawn.ondestroy;
	if(IsDefined(piecespawn.onspawn))
	{
		self.onspawn = piecespawn.onspawn;
		self [[ piecespawn.onspawn ]]();
	}
}

//Function Number: 46
piece_spawn_at_with_notify_delay(origin,angles,str_notify,unbuild_respawn_fn)
{
	level waittill(str_notify);
	piece_spawn_at(origin,angles);
	if(IsDefined(unbuild_respawn_fn))
	{
		self [[ unbuild_respawn_fn ]]();
	}
}

//Function Number: 47
piece_spawn_at(origin,angles)
{
	if(self.spawns.size < 1)
	{
		return;
	}

	if(IsDefined(self.managed_spawn) && self.managed_spawn)
	{
		if(!IsDefined(self.current_spawn) && !IsDefined(origin))
		{
			self piece_allocate_spawn(self.piecespawn);
			spawndef = self.spawns[self.current_spawn];
			self.start_origin = spawndef.origin;
			self.start_angles = spawndef.angles;
		}
	}
	else if(!(IsDefined(self.current_spawn)))
	{
		self.current_spawn = 0;
	}

	unitrigger_offset = VectorScale((0,0,1));
	if(!(IsDefined(origin)))
	{
		origin = self.start_origin;
	}
	else
	{
		origin = origin + (0,0,self.drop_offset);
		unitrigger_offset = unitrigger_offset - (0,0,self.drop_offset);
	}

	if(!(IsDefined(angles)))
	{
		angles = self.start_angles;
	}

/#
	level.drop_offset = 0;
	origin = origin + (0,0,level.drop_offset);
	unitrigger_offset = unitrigger_offset - (0,0,level.drop_offset);
IsDefined(level.drop_offset)
#/
	self.model = spawn("script_model",origin);
	if(IsDefined(angles))
	{
		self.model.angles = angles;
	}

	self.model setmodel(self.modelname);
	if(IsDefined(level.equipment_safe_to_drop))
	{
		if(!([[ level.equipment_safe_to_drop ]](self.model)))
		{
			origin = self.start_origin;
			angles = self.start_angles;
			self.model.origin = origin;
			self.model.angles = angles;
		}
	}

	self.unitrigger = generate_piece_unitrigger("trigger_radius_use",origin + unitrigger_offset,angles,0,self.radius,self.height,IsDefined(self.model.canmove) && self.model.canmove);
	self.unitrigger.piece = self;
	self.model.hud_icon = self.hud_icon;
	self.unitrigger.origin_parent = self.model;
	self.building = undefined;
	if(IsDefined(self.onspawn))
	{
		self [[ self.onspawn ]]();
	}
}

//Function Number: 48
piece_unspawn()
{
	if(IsDefined(self.onunspawn))
	{
		self [[ self.onunspawn ]]();
	}

	if(IsDefined(self.managed_spawn) && self.managed_spawn)
	{
		self piece_deallocate_spawn();
	}

	if(IsDefined(self.model))
	{
		self.model delete();
	}

	self.model = undefined;
	if(IsDefined(self.unitrigger))
	{
		thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.unitrigger);
	}

	self.unitrigger = undefined;
}

//Function Number: 49
piece_hide()
{
	if(IsDefined(self.model))
	{
		self.model ghost();
	}
}

//Function Number: 50
piece_show()
{
	if(IsDefined(self.model))
	{
		self.model show();
	}
}

//Function Number: 51
piece_destroy()
{
	if(IsDefined(self.ondestroy))
	{
		self [[ self.ondestroy ]]();
	}
}

//Function Number: 52
generate_piece(buildable_piece_spawns)
{
	piece = spawnstruct();
	piece.spawns = buildable_piece_spawns.spawns;
	if(IsDefined(buildable_piece_spawns.managing_pieces) && buildable_piece_spawns.managing_pieces)
	{
		piece piece_allocate_spawn(buildable_piece_spawns);
	}
	else if(IsDefined(buildable_piece_spawns.use_spawn_num))
	{
		piece piece_set_spawn(buildable_piece_spawns.use_spawn_num);
	}
	else
	{
		piece piece_pick_random_spawn();
	}

	piece piece_spawn_in(buildable_piece_spawns);
	if(piece.spawns.size >= 1)
	{
		piece.hud_icon = buildable_piece_spawns.hud_icon;
	}

	if(IsDefined(buildable_piece_spawns.onpickup))
	{
		piece.onpickup = buildable_piece_spawns.onpickup;
	}
	else
	{
		piece.onpickup = ::onpickuputs;
	}

	if(IsDefined(buildable_piece_spawns.ondrop))
	{
		piece.ondrop = buildable_piece_spawns.ondrop;
	}
	else
	{
		piece.ondrop = ::ondroputs;
	}

	return piece;
}

//Function Number: 53
buildable_piece_unitriggers(buildable_name,origin)
{
/#
	assert(IsDefined(buildable_name));
#/
/#
	assert(IsDefined(level.zombie_buildables[buildable_name]),"Called buildable_think() without including the buildable - " + buildable_name);
#/
	buildable = level.zombie_buildables[buildable_name];
	if(!(IsDefined(buildable.buildablepieces)))
	{
		buildable.buildablepieces = [];
	}

	flag_wait("start_zombie_round_logic");
	buildablezone = spawnstruct();
	buildablezone.buildable_name = buildable_name;
	buildablezone.buildable_slot = buildable.buildable_slot;
	if(!(IsDefined(buildablezone.pieces)))
	{
		buildablezone.pieces = [];
	}

	buildablepickups = [];
	foreach(buildablepiece in buildable.buildablepieces)
	{
		if(!(IsDefined(buildablepiece.generated_instances)))
		{
			buildablepiece.generated_instances = 0;
		}

		if(IsDefined(buildablepiece.generated_piece) && IsDefined(buildablepiece.can_reuse) && buildablepiece.can_reuse)
		{
			piece = buildablepiece.generated_piece;
		}
		else if(buildablepiece.generated_instances >= buildablepiece.max_instances)
		{
			piece = buildablepiece.generated_piece;
		}
		else
		{
			piece = generate_piece(buildablepiece);
			buildablepiece.generated_piece = piece;
			buildablepiece.generated_instances++;
			if(IsDefined(buildablepiece.min_instances))
			{
				while(buildablepiece.generated_instances < buildablepiece.min_instances)
				{
					piece = generate_piece(buildablepiece);
					buildablepiece.generated_piece = piece;
					buildablepiece.generated_instances++;
				}
			}
		}

		buildablezone.pieces[buildablezone.pieces.size] = piece;
	}

	buildablezone.stub = self;
	return buildablezone;
}

//Function Number: 54
hide_buildable_table_model(trigger_targetname)
{
	trig = getent(trigger_targetname,"targetname");
	if(!(IsDefined(trig)))
	{
		return;
	}

	if(IsDefined(trig.target))
	{
		model = getent(trig.target,"targetname");
		if(IsDefined(model))
		{
			model hide();
			model notsolid();
		}
	}
}

//Function Number: 55
setup_unitrigger_buildable(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	trig = getent(trigger_targetname,"targetname");
	if(!(IsDefined(trig)))
	{
		return;
	}

	return setup_unitrigger_buildable_internal(trig,equipname,weaponname,trigger_hintstring,delete_trigger,persistent);
}

//Function Number: 56
setup_unitrigger_buildable_array(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	triggers = getentarray(trigger_targetname,"targetname");
	stubs = [];
	foreach(trig in triggers)
	{
		stubs[stubs.size] = setup_unitrigger_buildable_internal(trig,equipname,weaponname,trigger_hintstring,delete_trigger,persistent);
	}

	return stubs;
}

//Function Number: 57
setup_unitrigger_buildable_internal(trig,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	if(!(IsDefined(trig)))
	{
		return;
	}

	unitrigger_stub = spawnstruct();
	unitrigger_stub.buildablestruct = level.zombie_include_buildables[equipname];
	angles = trig.script_angles;
	if(!(IsDefined(angles)))
	{
		angles = (0,0,0);
	}

	unitrigger_stub.origin = trig.origin + AnglesToRight(angles) * -6;
	unitrigger_stub.angles = trig.angles;
	if(IsDefined(trig.script_angles))
	{
		unitrigger_stub.angles = trig.script_angles;
	}

	unitrigger_stub.equipname = equipname;
	unitrigger_stub.weaponname = weaponname;
	unitrigger_stub.trigger_hintstring = trigger_hintstring;
	unitrigger_stub.delete_trigger = delete_trigger;
	unitrigger_stub.built = 0;
	unitrigger_stub.persistent = persistent;
	unitrigger_stub.usetime = int(3000);
	unitrigger_stub.onbeginuse = ::onbeginuseuts;
	unitrigger_stub.onenduse = ::onenduseuts;
	unitrigger_stub.onuse = ::onuseplantobjectuts;
	unitrigger_stub.oncantuse = ::oncantuseuts;
	if(IsDefined(trig.script_length))
	{
		unitrigger_stub.script_length = trig.script_length;
	}
	else
	{
		unitrigger_stub.script_length = 32;
	}

	if(IsDefined(trig.script_width))
	{
		unitrigger_stub.script_width = trig.script_width;
	}
	else
	{
		unitrigger_stub.script_width = 100;
	}

	if(IsDefined(trig.script_height))
	{
		unitrigger_stub.script_height = trig.script_height;
	}
	else
	{
		unitrigger_stub.script_height = 64;
	}

	unitrigger_stub.target = trig.target;
	unitrigger_stub.targetname = trig.targetname;
	unitrigger_stub.script_noteworthy = trig.script_noteworthy;
	unitrigger_stub.script_parameters = trig.script_parameters;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	if(IsDefined(level.zombie_buildables[equipname].hint))
	{
		unitrigger_stub.hint_string = level.zombie_buildables[equipname].hint;
	}

	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.require_look_at = 1;
	unitrigger_force_per_player_triggers(unitrigger_stub,1);
	unitrigger_stub.prompt_and_visibility_func = ::buildabletrigger_update_prompt;
	maps/mp/zombies/_zm_unitrigger::register_static_unitrigger(unitrigger_stub,::buildable_place_think);
	unitrigger_stub.piece_trigger = trig;
	trig.trigger_stub = unitrigger_stub;
	unitrigger_stub.zombie_weapon_upgrade = trig.zombie_weapon_upgrade;
	if(IsDefined(unitrigger_stub.target))
	{
		unitrigger_stub.model = getent(unitrigger_stub.target,"targetname");
		if(IsDefined(unitrigger_stub.model))
		{
			if(IsDefined(unitrigger_stub.zombie_weapon_upgrade))
			{
				unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
			}

			unitrigger_stub.model hide();
			unitrigger_stub.model notsolid();
		}
	}

	unitrigger_stub.buildablezone = unitrigger_stub buildable_piece_unitriggers(equipname,unitrigger_stub.origin);
	if(delete_trigger)
	{
		trig delete();
	}

	level.buildable_stubs[level.buildable_stubs.size] = unitrigger_stub;
	return unitrigger_stub;
}

//Function Number: 58
buildable_has_piece(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 59
buildable_set_piece_built(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			self.pieces[i].built = 1;
		}
	}
}

//Function Number: 60
buildable_set_piece_building(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			self.pieces[i] = piece;
			self.pieces[i].building = 1;
		}
	}
}

//Function Number: 61
buildable_clear_piece_building(piece)
{
	if(IsDefined(piece))
	{
		piece.building = 0;
	}
}

//Function Number: 62
buildable_is_piece_built(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			return IsDefined(self.pieces[i].built) && self.pieces[i].built;
		}
	}

	return 0;
}

//Function Number: 63
buildable_is_piece_building(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			return IsDefined(self.pieces[i].building) && self.pieces[i].building && self.pieces[i] == piece;
		}
	}

	return 0;
}

//Function Number: 64
buildable_is_piece_built_or_building(piece)
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(self.pieces[i].modelname == piece.modelname && self.pieces[i].buildablename == piece.buildablename)
		{
			return (IsDefined(self.pieces[i].built) && self.pieces[i].built) || IsDefined(self.pieces[i].building) && self.pieces[i].building;
		}
	}

	return 0;
}

//Function Number: 65
buildable_all_built()
{
	for(i = 0;i < self.pieces.size;i++)
	{
		if(!(IsDefined(self.pieces[i].built) && self.pieces[i].built))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 66
player_can_build(buildable,continuing)
{
	if(!(IsDefined(buildable)))
	{
		return 0;
	}

	if(!(IsDefined(self player_get_buildable_piece(buildable.buildable_slot))))
	{
		return 0;
	}

	if(!(buildable buildable_has_piece(self player_get_buildable_piece(buildable.buildable_slot))))
	{
		return 0;
	}

	if(IsDefined(continuing) && continuing)
	{
		if(buildable buildable_is_piece_built(self player_get_buildable_piece(buildable.buildable_slot)))
		{
			return 0;
		}
	}
	else if(buildable buildable_is_piece_built_or_building(self player_get_buildable_piece(buildable.buildable_slot)))
	{
		return 0;
	}

	if(IsDefined(buildable.stub) && IsDefined(buildable.stub.custom_buildablestub_update_prompt) && IsDefined(buildable.stub.playertrigger[0]) && IsDefined(buildable.stub.playertrigger[0].stub) && !buildable.stub.playertrigger[0].stub [[ buildable.stub.custom_buildablestub_update_prompt ]](self,1,buildable.stub.playertrigger[0]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 67
player_build(buildable,pieces)
{
	if(IsDefined(pieces))
	{
		for(i = 0;i < pieces.size;i++)
		{
			buildable buildable_set_piece_built(pieces[i]);
			player_destroy_piece(pieces[i]);
		}
	}
	else
	{
		buildable buildable_set_piece_built(self player_get_buildable_piece(buildable.buildable_slot));
		player_destroy_piece(self player_get_buildable_piece(buildable.buildable_slot));
	}

	if(IsDefined(buildable.stub.model))
	{
		for(i = 0;i < buildable.pieces.size;i++)
		{
			if(IsDefined(buildable.pieces[i].part_name))
			{
				buildable.stub.model notsolid();
				if(!(IsDefined(buildable.pieces[i].built) && buildable.pieces[i].built))
				{
					buildable.stub.model hidepart(buildable.pieces[i].part_name);
				}
				else
				{
					buildable.stub.model show();
					buildable.stub.model showpart(buildable.pieces[i].part_name);
				}
			}
		}
	}

	if(isplayer(self))
	{
		self track_buildable_pieces_built(buildable);
	}

	if(buildable buildable_all_built())
	{
		self player_finish_buildable(buildable);
		buildable.stub buildablestub_finish_build(self);
		if(isplayer(self))
		{
			self track_buildables_built(buildable);
		}

		if(IsDefined(level.buildable_built_custom_func))
		{
			self thread [[ level.buildable_built_custom_func ]](buildable);
		}

		alias = sndbuildablecompletealias(buildable.buildable_name);
		self playsound(alias);
	}
	else
	{
		self playsound("zmb_buildable_piece_add");
/#
		assert(IsDefined(level.zombie_buildables[buildable.buildable_name].building),"Missing builing hint");
#/
		if(IsDefined(level.zombie_buildables[buildable.buildable_name].building))
		{
			return level.zombie_buildables[buildable.buildable_name].building;
		}
	}

	return "";
}

//Function Number: 68
sndbuildablecompletealias(name)
{
	alias = undefined;
	switch(name)
	{
		case "chalk":
			alias = "zmb_chalk_complete";
			break;

		default:
			alias = "zmb_buildable_complete";
			break;
	}

	return alias;
}

//Function Number: 69
player_finish_buildable(buildable)
{
	buildable.built = 1;
	buildable.stub.built = 1;
	buildable notify("built",self);
	level.buildables_built[buildable.buildable_name] = 1;
	level notify(buildable.buildable_name + "_built",self);
}

//Function Number: 70
buildablestub_finish_build(player)
{
	player player_finish_buildable(self.buildablezone);
}

//Function Number: 71
buildablestub_remove()
{
	arrayremovevalue(level.buildable_stubs,self);
}

//Function Number: 72
buildabletrigger_update_prompt(player)
{
	can_use = self.stub buildablestub_update_prompt(player);
	self sethintstring(self.stub.hint_string);
	if(IsDefined(self.stub.cursor_hint))
	{
		if(self.stub.cursor_hint == "HINT_WEAPON" && IsDefined(self.stub.cursor_hint_weapon))
		{
			self setcursorhint(self.stub.cursor_hint,self.stub.cursor_hint_weapon);
		}
		else
		{
			self setcursorhint(self.stub.cursor_hint);
		}
	}

	return can_use;
}

//Function Number: 73
buildablestub_update_prompt(player)
{
	if(!(self anystub_update_prompt(player)))
	{
		return 0;
	}

	can_use = 1;
	if(IsDefined(self.buildablestub_reject_func))
	{
		rval = self [[ self.buildablestub_reject_func ]](player);
		if(rval)
		{
			return 0;
		}
	}

	if(IsDefined(self.custom_buildablestub_update_prompt) && !self [[ self.custom_buildablestub_update_prompt ]](player))
	{
		return 0;
	}

	self.cursor_hint = "HINT_NOICON";
	self.cursor_hint_weapon = undefined;
	if(!(IsDefined(self.built) && self.built))
	{
		slot = self.buildablestruct.buildable_slot;
		if(!(IsDefined(player player_get_buildable_piece(slot))))
		{
			if(IsDefined(level.zombie_buildables[self.equipname].hint_more))
			{
				self.hint_string = level.zombie_buildables[self.equipname].hint_more;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
			}

			return 0;
		}
		else if(!(self.buildablezone buildable_has_piece(player player_get_buildable_piece(slot))))
		{
			if(IsDefined(level.zombie_buildables[self.equipname].hint_wrong))
			{
				self.hint_string = level.zombie_buildables[self.equipname].hint_wrong;
			}
			else
			{
				self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
			}

			return 0;
		}
		else
		{
/#
				assert(IsDefined(level.zombie_buildables[self.equipname].hint),"Missing buildable hint");
#/
			if(IsDefined(level.zombie_buildables[self.equipname].hint))
			{
				self.hint_string = level.zombie_buildables[self.equipname].hint;
			}
			else
			{
				self.hint_string = "Missing buildable hint";
			}
		}
	}
	else if(self.persistent == 1)
	{
		if(maps/mp/zombies/_zm_equipment::is_limited_equipment(self.weaponname) && maps/mp/zombies/_zm_equipment::limited_equipment_in_use(self.weaponname))
		{
			self.hint_string = &"ZOMBIE_BUILD_PIECE_ONLY_ONE";
			return 0;
		}

		if(player has_player_equipment(self.weaponname))
		{
			self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
			return 0;
		}

		if(GetDvarInt(#"1F0A2129"))
		{
			self.cursor_hint = "HINT_WEAPON";
			self.cursor_hint_weapon = self.weaponname;
		}

		self.hint_string = self.trigger_hintstring;
	}
	else if(self.persistent == 2)
	{
		if(!(maps/mp/zombies/_zm_weapons::limited_weapon_below_quota(self.weaponname,undefined)))
		{
			self.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			return 0;
		}
		else if(IsDefined(self.bought) && self.bought)
		{
			self.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
			return 0;
		}

		self.hint_string = self.trigger_hintstring;
	}
	else
	{
		self.hint_string = "";
		return 0;
	}
}

//Function Number: 74
player_continue_building(buildablezone,build_stub)
{
	if(!(IsDefined(build_stub)))
	{
		build_stub = buildablezone.stub;
	}

	if(self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || self in_revive_trigger())
	{
		return 0;
	}

	if(self isthrowinggrenade())
	{
		return 0;
	}

	if(!(self player_can_build(buildablezone,1)))
	{
		return 0;
	}

	if(IsDefined(self.screecher))
	{
		return 0;
	}

	if(!(self usebuttonpressed()))
	{
		return 0;
	}

	slot = build_stub.buildablestruct.buildable_slot;
	if(!(buildablezone buildable_is_piece_building(self player_get_buildable_piece(slot))))
	{
		return 0;
	}

	trigger = build_stub maps/mp/zombies/_zm_unitrigger::unitrigger_trigger(self);
	if(build_stub.script_unitrigger_type == "unitrigger_radius_use")
	{
		torigin = build_stub unitrigger_origin();
		porigin = self geteye();
		radius_sq = 2.25 * build_stub.test_radius_sq;
		if(distance2dsquared(torigin,porigin) > radius_sq)
		{
			return 0;
		}
	}
	else if(!IsDefined(trigger) || !trigger istouching(self))
	{
		return 0;
	}

	if(IsDefined(build_stub.require_look_at) && build_stub.require_look_at && !self is_player_looking_at(trigger.origin,0.4))
	{
		return 0;
	}

	return 1;
}

//Function Number: 75
player_progress_bar_update(start_time,build_time)
{
	self endon("entering_last_stand");
	self endon("death");
	self endon("disconnect");
	self endon("buildable_progress_end");
	while(IsDefined(self) && GetTime() - start_time < build_time)
	{
		progress = GetTime() - start_time / build_time;
		if(progress < 0)
		{
			progress = 0;
		}

		if(progress > 1)
		{
			progress = 1;
		}

		self.usebar updatebar(progress);
		wait(0.05);
	}
}

//Function Number: 76
player_progress_bar(start_time,build_time,building_prompt)
{
	self.usebar = self createprimaryprogressbar();
	self.usebartext = self createprimaryprogressbartext();
	if(IsDefined(building_prompt))
	{
		self.usebartext settext(building_prompt);
	}
	else
	{
		self.usebartext settext(&"ZOMBIE_BUILDING");
	}

	if(IsDefined(self) && IsDefined(start_time) && IsDefined(build_time))
	{
		self player_progress_bar_update(start_time,build_time);
	}

	self.usebartext destroyelem();
	self.usebar destroyelem();
}

//Function Number: 77
buildable_use_hold_think_internal(player,bind_stub)
{
	if(!(IsDefined(bind_stub)))
	{
		bind_stub = self.stub;
	}

	wait(0.01);
	if(!(IsDefined(self)))
	{
		self notify("build_failed");
		if(IsDefined(player.buildableaudio))
		{
			player.buildableaudio delete();
			player.buildableaudio = undefined;
		}

		return;
	}

	if(!(IsDefined(self.usetime)))
	{
		self.usetime = int(3000);
	}

	self.build_time = self.usetime;
	self.build_start_time = GetTime();
	build_time = self.build_time;
	build_start_time = self.build_start_time;
	player disable_player_move_states(1);
	player increment_is_drinking();
	orgweapon = player getcurrentweapon();
	build_weapon = "zombie_builder_zm";
	if(IsDefined(bind_stub.build_weapon))
	{
		build_weapon = bind_stub.build_weapon;
	}

	player giveweapon(build_weapon);
	player switchtoweapon(build_weapon);
	slot = bind_stub.buildablestruct.buildable_slot;
	bind_stub.buildablezone buildable_set_piece_building(player player_get_buildable_piece(slot));
	player thread player_progress_bar(build_start_time,build_time,bind_stub.building_prompt);
	if(IsDefined(level.buildable_build_custom_func))
	{
		player thread [[ level.buildable_build_custom_func ]](self.stub);
	}

	while(IsDefined(self) && player player_continue_building(bind_stub.buildablezone,self.stub) && GetTime() - self.build_start_time < self.build_time)
	{
		wait(0.05);
	}

	player notify("buildable_progress_end");
	player maps/mp/zombies/_zm_weapons::switch_back_primary_weapon(orgweapon);
	player takeweapon("zombie_builder_zm");
	if(IsDefined(player.is_drinking) && player.is_drinking)
	{
		player decrement_is_drinking();
	}

	player enable_player_move_states();
	if(IsDefined(self) && player player_continue_building(bind_stub.buildablezone,self.stub) && GetTime() - self.build_start_time >= self.build_time)
	{
		buildable_clear_piece_building(player player_get_buildable_piece(slot));
		self notify("build_succeed");
	}
	else
	{
		if(IsDefined(player.buildableaudio))
		{
			player.buildableaudio delete();
			player.buildableaudio = undefined;
		}

		buildable_clear_piece_building(player player_get_buildable_piece(slot));
		self notify("build_failed");
	}
}

//Function Number: 78
buildable_play_build_fx(player)
{
	self endon("kill_trigger");
	self endon("build_succeed");
	self endon("build_failed");
	while(1)
	{
		playfx(level._effect["building_dust"],player getplayercamerapos(),player.angles);
		wait(0.5);
	}
}

//Function Number: 79
buildable_use_hold_think(player,bind_stub)
{
	if(!(IsDefined(bind_stub)))
	{
		bind_stub = self.stub;
	}

	self thread buildable_play_build_fx(player);
	self thread buildable_use_hold_think_internal(player,bind_stub);
	retval = self waittill_any_return("build_succeed","build_failed");
	if(retval == "build_succeed")
	{
		return 1;
	}

	return 0;
}

//Function Number: 80
buildable_place_think()
{
	self endon("kill_trigger");
	player_built = undefined;
	while(!(IsDefined(self.stub.built) && self.stub.built))
	{
		self waittill("trigger",player);
		if(player != self.parent_player)
		{
			continue;
		}

		if(IsDefined(player.screecher_weapon))
		{
			continue;
		}

		if(!(is_player_valid(player)))
		{
			player thread ignore_triggers(0.5);
			continue;
		}

		status = player player_can_build(self.stub.buildablezone);
		if(!(status))
		{
			self.stub.hint_string = "";
			self sethintstring(self.stub.hint_string);
			if(IsDefined(self.stub.oncantuse))
			{
				self.stub [[ self.stub.oncantuse ]](player);
			}

			break;
		}

		if(IsDefined(self.stub.onbeginuse))
		{
			self.stub [[ self.stub.onbeginuse ]](player);
		}

		result = self buildable_use_hold_think(player);
		team = player.pers["team"];
		if(IsDefined(self.stub.onenduse))
		{
			self.stub [[ self.stub.onenduse ]](team,player,result);
		}

		if(!(result))
		{
			continue;
		}

		if(IsDefined(self.stub.onuse))
		{
			self.stub [[ self.stub.onuse ]](player);
		}

		slot = self.stub.buildablestruct.buildable_slot;
		if(IsDefined(player player_get_buildable_piece(slot)))
		{
			prompt = player player_build(self.stub.buildablezone);
			player_built = player;
			self.stub.hint_string = prompt;
		}

		self sethintstring(self.stub.hint_string);
	}

	if(IsDefined(player_built))
	{
	}

	switch(self.stub.persistent)
	{
		case "1":
			self bptrigger_think_persistent(player_built);
			break;

		case "0":
			self bptrigger_think_one_time(player_built);
			break;

		case "3":
			self bptrigger_think_unbuild(player_built);
			break;

		case "2":
			self bptrigger_think_one_use_and_fly(player_built);
			break;

		case "4":
			self [[ self.stub.custom_completion_callback ]](player_built);
			break;
	}
}

//Function Number: 81
bptrigger_think_one_time(player_built)
{
	self.stub buildablestub_remove();
	thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(self.stub);
}

//Function Number: 82
bptrigger_think_unbuild(player_built)
{
	stub_unbuild_buildable(self.stub,1);
}

//Function Number: 83
bptrigger_think_one_use_and_fly(player_built)
{
	if(IsDefined(player_built))
	{
		self buildabletrigger_update_prompt(player_built);
	}

	if(!(maps/mp/zombies/_zm_weapons::limited_weapon_below_quota(self.stub.weaponname,undefined)))
	{
		self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
		self sethintstring(self.stub.hint_string);
		return;
	}

	if(IsDefined(self.stub.bought) && self.stub.bought)
	{
		self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
		self sethintstring(self.stub.hint_string);
		return;
	}

	if(IsDefined(self.stub.model))
	{
		self.stub.model notsolid();
		self.stub.model show();
	}

	while(self.stub.persistent == 2)
	{
		self waittill("trigger",player);
		if(IsDefined(player.screecher_weapon))
		{
			continue;
		}

		if(!(maps/mp/zombies/_zm_weapons::limited_weapon_below_quota(self.stub.weaponname,undefined)))
		{
			self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
			self sethintstring(self.stub.hint_string);
			return;
		}

		if(!(IsDefined(self.stub.built) && self.stub.built))
		{
			self.stub.hint_string = "";
			self sethintstring(self.stub.hint_string);
			return;
		}

		if(player != self.parent_player)
		{
			continue;
		}

		if(!(is_player_valid(player)))
		{
			player thread ignore_triggers(0.5);
			continue;
		}

		self.stub.bought = 1;
		if(IsDefined(self.stub.model))
		{
			self.stub.model thread model_fly_away();
		}

		player maps/mp/zombies/_zm_weapons::weapon_give(self.stub.weaponname);
		if(IsDefined(level.zombie_include_buildables[self.stub.equipname].onbuyweapon))
		{
			self [[ level.zombie_include_buildables[self.stub.equipname].onbuyweapon ]](player);
		}

		if(!(maps/mp/zombies/_zm_weapons::limited_weapon_below_quota(self.stub.weaponname,undefined)))
		{
			self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX_LIMITED";
		}
		else
		{
			self.stub.hint_string = &"ZOMBIE_GO_TO_THE_BOX";
		}

		self sethintstring(self.stub.hint_string);
		player track_buildables_pickedup(self.stub.weaponname);
	}
}

//Function Number: 84
bptrigger_think_persistent(player_built)
{
	if(!IsDefined(player_built) || self [[ self.stub.prompt_and_visibility_func ]](player_built))
	{
		if(IsDefined(self.stub.model))
		{
			self.stub.model notsolid();
			self.stub.model show();
		}

		while(self.stub.persistent == 1)
		{
			self waittill("trigger",player);
			if(IsDefined(player.screecher_weapon))
			{
				continue;
			}

			if(!(IsDefined(self.stub.built) && self.stub.built))
			{
				self.stub.hint_string = "";
				self sethintstring(self.stub.hint_string);
				self setcursorhint("HINT_NOICON");
				return;
			}

			if(player != self.parent_player)
			{
				continue;
			}

			if(!(is_player_valid(player)))
			{
				player thread ignore_triggers(0.5);
				continue;
			}

			if(player has_player_equipment(self.stub.weaponname))
			{
				continue;
			}

			if(IsDefined(self.stub.buildablestruct.onbought))
			{
				self [[ self.stub.buildablestruct.onbought ]](player);
				continue;
			}

			if(!maps/mp/zombies/_zm_equipment::is_limited_equipment(self.stub.weaponname) || !maps/mp/zombies/_zm_equipment::limited_equipment_in_use(self.stub.weaponname))
			{
				player maps/mp/zombies/_zm_equipment::equipment_buy(self.stub.weaponname);
				player giveweapon(self.stub.weaponname);
				player setweaponammoclip(self.stub.weaponname,1);
				if(IsDefined(level.zombie_include_buildables[self.stub.equipname].onbuyweapon))
				{
					self [[ level.zombie_include_buildables[self.stub.equipname].onbuyweapon ]](player);
				}

				if(self.stub.weaponname != "keys_zm")
				{
					player setactionslot(1,"weapon",self.stub.weaponname);
				}

				self.stub.cursor_hint = "HINT_NOICON";
				self.stub.cursor_hint_weapon = undefined;
				self setcursorhint(self.stub.cursor_hint);
				if(IsDefined(level.zombie_buildables[self.stub.equipname].bought))
				{
					self.stub.hint_string = level.zombie_buildables[self.stub.equipname].bought;
				}
				else
				{
					self.stub.hint_string = "";
				}

				self sethintstring(self.stub.hint_string);
				player track_buildables_pickedup(self.stub.weaponname);
				continue;
			}

			self.stub.hint_string = "";
			self sethintstring(self.stub.hint_string);
			self.stub.cursor_hint = "HINT_NOICON";
			self.stub.cursor_hint_weapon = undefined;
			self setcursorhint(self.stub.cursor_hint);
		}
	}
}

//Function Number: 85
bptrigger_think_unbuild_no_return(player)
{
	stub_unbuild_buildable(self.stub,0);
}

//Function Number: 86
bpstub_set_custom_think_callback(callback)
{
	self.persistent = 4;
	self.custom_completion_callback = callback;
}

//Function Number: 87
model_fly_away()
{
	self moveto(40 + VectorScale((0,0,1)),self.origin);
	direction = self.origin;
	direction = (direction[1],direction[0],0);
	if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0)
	{
		direction = (direction[0],direction[1] * -1,0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1,direction[1],0);
	}

	self vibrate(direction,10,0.5,4);
	self waittill(3,"movedone");
	self hide();
	playfx(level._effect["poltergeist"],self.origin);
}

//Function Number: 88
find_buildable_stub(equipname)
{
	foreach(stub in level.buildable_stubs)
	{
		if(stub.equipname == equipname)
		{
			return stub;
		}
	}

	return undefined;
}

//Function Number: 89
unbuild_buildable(equipname,return_pieces,origin,angles)
{
	stub = find_buildable_stub(equipname);
	stub_unbuild_buildable(stub,return_pieces,origin,angles);
}

//Function Number: 90
stub_unbuild_buildable(stub,return_pieces,origin,angles)
{
	if(IsDefined(stub))
	{
		buildable = stub.buildablezone;
		buildable.built = 0;
		buildable.stub.built = 0;
		buildable notify("unbuilt");
		level.buildables_built[buildable.buildable_name] = 0;
		level notify(buildable.buildable_name + "_unbuilt");
		for(i = 0;i < buildable.pieces.size;i++)
		{
			buildable.pieces[i].built = 0;
			if(IsDefined(buildable.pieces[i].part_name))
			{
				buildable.stub.model notsolid();
				if(!(IsDefined(buildable.pieces[i].built) && buildable.pieces[i].built))
				{
					buildable.stub.model hidepart(buildable.pieces[i].part_name);
				}
				else
				{
					buildable.stub.model show();
					buildable.stub.model showpart(buildable.pieces[i].part_name);
				}
			}

			if(IsDefined(return_pieces) && return_pieces)
			{
				if(IsDefined(buildable.stub.str_unbuild_notify))
				{
					buildable.pieces[i] thread piece_spawn_at_with_notify_delay(origin,angles,buildable.stub.str_unbuild_notify,buildable.stub.unbuild_respawn_fn);
				}
				else
				{
					buildable.pieces[i] piece_spawn_at(origin,angles);
				}
			}
		}

		if(IsDefined(buildable.stub.model))
		{
			buildable.stub.model hide();
		}
	}
}

//Function Number: 91
player_explode_buildable(equipname,origin,speed,return_to_spawn,return_time)
{
	self explosiondamage(50,origin);
	stub = find_buildable_stub(equipname);
	if(IsDefined(stub))
	{
		buildable = stub.buildablezone;
		buildable.built = 0;
		buildable.stub.built = 0;
		buildable notify("unbuilt");
		level.buildables_built[buildable.buildable_name] = 0;
		level notify(buildable.buildable_name + "_unbuilt");
		for(i = 0;i < buildable.pieces.size;i++)
		{
			buildable.pieces[i].built = 0;
			if(IsDefined(buildable.pieces[i].part_name))
			{
				buildable.stub.model notsolid();
				if(!(IsDefined(buildable.pieces[i].built) && buildable.pieces[i].built))
				{
					buildable.stub.model hidepart(buildable.pieces[i].part_name);
				}
				else
				{
					buildable.stub.model show();
					buildable.stub.model showpart(buildable.pieces[i].part_name);
				}
			}

			ang = randomfloat(360);
			h = 0.25 + randomfloat(0.5);
			dir = (sin(ang),cos(ang),h);
			self thread player_throw_piece(buildable.pieces[i],origin,speed * dir,return_to_spawn,return_time);
		}

		buildable.stub.model hide();
	}
}

//Function Number: 92
think_buildables()
{
	foreach(buildable in level.zombie_include_buildables)
	{
		if(IsDefined(buildable.triggerthink))
		{
			level [[ buildable.triggerthink ]]();
			wait_network_frame();
		}
	}

	level notify("buildables_setup",_k2447);
}

//Function Number: 93
buildable_trigger_think(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	return setup_unitrigger_buildable(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent);
}

//Function Number: 94
buildable_trigger_think_array(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	return setup_unitrigger_buildable_array(trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent);
}

//Function Number: 95
buildable_set_unbuild_notify_delay(str_equipname,str_unbuild_notify,unbuild_respawn_fn)
{
	stub = find_buildable_stub(str_equipname);
	stub.str_unbuild_notify = str_unbuild_notify;
	stub.unbuild_respawn_fn = unbuild_respawn_fn;
}

//Function Number: 96
setup_vehicle_unitrigger_buildable(parent,trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	trig = getent(trigger_targetname,"targetname");
	if(!(IsDefined(trig)))
	{
		return;
	}

	unitrigger_stub = spawnstruct();
	unitrigger_stub.buildablestruct = level.zombie_include_buildables[equipname];
	unitrigger_stub.link_parent = parent;
	unitrigger_stub.origin_parent = trig;
	unitrigger_stub.trigger_targetname = trigger_targetname;
	unitrigger_stub.originfunc = ::anystub_get_unitrigger_origin;
	unitrigger_stub.onspawnfunc = ::anystub_on_spawn_trigger;
	unitrigger_stub.origin = trig.origin;
	unitrigger_stub.angles = trig.angles;
	unitrigger_stub.equipname = equipname;
	unitrigger_stub.weaponname = weaponname;
	unitrigger_stub.trigger_hintstring = trigger_hintstring;
	unitrigger_stub.delete_trigger = delete_trigger;
	unitrigger_stub.built = 0;
	unitrigger_stub.persistent = persistent;
	unitrigger_stub.usetime = int(3000);
	unitrigger_stub.onbeginuse = ::onbeginuseuts;
	unitrigger_stub.onenduse = ::onenduseuts;
	unitrigger_stub.onuse = ::onuseplantobjectuts;
	unitrigger_stub.oncantuse = ::oncantuseuts;
	if(IsDefined(trig.script_length))
	{
		unitrigger_stub.script_length = trig.script_length;
	}
	else
	{
		unitrigger_stub.script_length = 24;
	}

	if(IsDefined(trig.script_width))
	{
		unitrigger_stub.script_width = trig.script_width;
	}
	else
	{
		unitrigger_stub.script_width = 64;
	}

	if(IsDefined(trig.script_height))
	{
		unitrigger_stub.script_height = trig.script_height;
	}
	else
	{
		unitrigger_stub.script_height = 24;
	}

	if(IsDefined(trig.radius))
	{
		unitrigger_stub.radius = trig.radius;
	}
	else
	{
		unitrigger_stub.radius = 64;
	}

	unitrigger_stub.target = trig.target;
	unitrigger_stub.targetname = trig.targetname + "_trigger";
	unitrigger_stub.script_noteworthy = trig.script_noteworthy;
	unitrigger_stub.script_parameters = trig.script_parameters;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	if(IsDefined(level.zombie_buildables[equipname].hint))
	{
		unitrigger_stub.hint_string = level.zombie_buildables[equipname].hint;
	}

	unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
	unitrigger_stub.require_look_at = 1;
	unitrigger_force_per_player_triggers(unitrigger_stub,1);
	unitrigger_stub.prompt_and_visibility_func = ::buildabletrigger_update_prompt;
	maps/mp/zombies/_zm_unitrigger::register_unitrigger(unitrigger_stub,::buildable_place_think);
	unitrigger_stub.piece_trigger = trig;
	trig.trigger_stub = unitrigger_stub;
	unitrigger_stub.buildablezone = unitrigger_stub buildable_piece_unitriggers(equipname,unitrigger_stub.origin);
	if(delete_trigger)
	{
		trig delete();
	}

	level.buildable_stubs[level.buildable_stubs.size] = unitrigger_stub;
	return unitrigger_stub;
}

//Function Number: 97
vehicle_buildable_trigger_think(vehicle,trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent)
{
	return setup_vehicle_unitrigger_buildable(vehicle,trigger_targetname,equipname,weaponname,trigger_hintstring,delete_trigger,persistent);
}

//Function Number: 98
ai_buildable_trigger_think(parent,equipname,weaponname,trigger_hintstring,persistent)
{
	unitrigger_stub = spawnstruct();
	unitrigger_stub.buildablestruct = level.zombie_include_buildables[equipname];
	unitrigger_stub.link_parent = parent;
	unitrigger_stub.origin_parent = parent;
	unitrigger_stub.originfunc = ::anystub_get_unitrigger_origin;
	unitrigger_stub.onspawnfunc = ::anystub_on_spawn_trigger;
	unitrigger_stub.origin = parent.origin;
	unitrigger_stub.angles = parent.angles;
	unitrigger_stub.equipname = equipname;
	unitrigger_stub.weaponname = weaponname;
	unitrigger_stub.trigger_hintstring = trigger_hintstring;
	unitrigger_stub.delete_trigger = 1;
	unitrigger_stub.built = 0;
	unitrigger_stub.persistent = persistent;
	unitrigger_stub.usetime = int(3000);
	unitrigger_stub.onbeginuse = ::onbeginuseuts;
	unitrigger_stub.onenduse = ::onenduseuts;
	unitrigger_stub.onuse = ::onuseplantobjectuts;
	unitrigger_stub.oncantuse = ::oncantuseuts;
	unitrigger_stub.script_length = 64;
	unitrigger_stub.script_width = 64;
	unitrigger_stub.script_height = 54;
	unitrigger_stub.radius = 64;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	if(IsDefined(level.zombie_buildables[equipname].hint))
	{
		unitrigger_stub.hint_string = level.zombie_buildables[equipname].hint;
	}

	unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
	unitrigger_stub.require_look_at = 0;
	unitrigger_force_per_player_triggers(unitrigger_stub,1);
	unitrigger_stub.prompt_and_visibility_func = ::buildabletrigger_update_prompt;
	maps/mp/zombies/_zm_unitrigger::register_unitrigger(unitrigger_stub,::buildable_place_think);
	unitrigger_stub.buildablezone = unitrigger_stub buildable_piece_unitriggers(equipname,unitrigger_stub.origin);
	level.buildable_stubs[level.buildable_stubs.size] = unitrigger_stub;
	return unitrigger_stub;
}

//Function Number: 99
onpickuputs(player)
{
/#
	println("ZM >> Buildable piece recovered by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
}

//Function Number: 100
ondroputs(player)
{
/#
	println("ZM >> Buildable piece dropped by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
	player notify("event_ended");
}

//Function Number: 101
onbeginuseuts(player)
{
/#
	println("ZM >> Buildable piece begin use by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
	if(IsDefined(self.buildablestruct.onbeginuse))
	{
		self [[ self.buildablestruct.onbeginuse ]](player);
	}

	if(IsDefined(player) && !IsDefined(player.buildableaudio))
	{
		alias = sndbuildableusealias(self.targetname);
		player.buildableaudio = spawn("script_origin",player.origin);
		player.buildableaudio playloopsound(alias);
	}
}

//Function Number: 102
sndbuildableusealias(name)
{
	alias = undefined;
	switch(name)
	{
		case "cell_door_trigger":
			alias = "zmb_jail_buildable";
			break;

		case "generator_use_trigger":
			alias = "zmb_generator_buildable";
			break;

		case "chalk_buildable_trigger":
			alias = "zmb_chalk_loop";
			break;

		default:
			alias = "zmb_buildable_loop";
			break;
	}

	return alias;
}

//Function Number: 103
onenduseuts(team,player,result)
{
/#
	println("ZM >> Buildable piece end use by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
	if(!(IsDefined(player)))
	{
		return;
	}

	if(IsDefined(player.buildableaudio))
	{
		player.buildableaudio delete();
		player.buildableaudio = undefined;
	}

	if(IsDefined(self.buildablestruct.onenduse))
	{
		self [[ self.buildablestruct.onenduse ]](team,player,result);
	}

	player notify("event_ended");
}

//Function Number: 104
oncantuseuts(player)
{
/#
	println("ZM >> Buildable piece can\'t use by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
	if(IsDefined(self.buildablestruct.oncantuse))
	{
		self [[ self.buildablestruct.oncantuse ]](player);
	}
}

//Function Number: 105
onuseplantobjectuts(player)
{
/#
	println("ZM >> Buildable piece crafted by - " + player.name);
IsDefined(player) && IsDefined(player.name)
#/
	if(IsDefined(self.buildablestruct.onuseplantobject))
	{
		self [[ self.buildablestruct.onuseplantobject ]](player);
	}

	player notify("bomb_planted");
}

//Function Number: 106
add_zombie_buildable_vox_category(buildable_name,vox_id)
{
	buildable_struct = level.zombie_include_buildables[buildable_name];
	buildable_struct.vox_id = vox_id;
}

//Function Number: 107
add_zombie_buildable_piece_vox_category(buildable_name,vox_id,timer)
{
	buildable_struct = level.zombie_include_buildables[buildable_name];
	buildable_struct.piece_vox_id = vox_id;
	buildable_struct.piece_vox_timer = timer;
}

//Function Number: 108
is_buildable()
{
	if(!(IsDefined(level.zombie_buildables)))
	{
		return 0;
	}

	if(IsDefined(self.zombie_weapon_upgrade) && IsDefined(level.zombie_buildables[self.zombie_weapon_upgrade]))
	{
		return 1;
	}

	if(IsDefined(self.script_noteworthy) && self.script_noteworthy == "specialty_weapupgrade")
	{
		if(IsDefined(level.buildables_built["pap"]) && level.buildables_built["pap"])
		{
			return 0;
		}

		return 1;
	}
}

//Function Number: 109
buildable_crafted()
{
	self.pieces--;
}

//Function Number: 110
buildable_complete()
{
	if(self.pieces <= 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 111
get_buildable_hint(buildable_name)
{
/#
	assert(IsDefined(level.zombie_buildables[buildable_name]),buildable_name + " was not included or is not part of the zombie weapon list.");
#/
	return level.zombie_buildables[buildable_name].hint;
}

//Function Number: 112
delete_on_disconnect(buildable,self_notify,skip_delete)
{
	buildable endon("death");
	self waittill("disconnect");
	if(IsDefined(self_notify))
	{
		self notify(self_notify);
	}

	if(!(IsDefined(skip_delete) && skip_delete))
	{
		if(IsDefined(buildable.stub))
		{
			thread maps/mp/zombies/_zm_unitrigger::unregister_unitrigger(buildable.stub);
			buildable.stub = undefined;
		}

		if(IsDefined(buildable))
		{
			buildable delete();
		}
	}
}

//Function Number: 113
get_buildable_pickup(buildablename,modelname)
{
	foreach(buildablepickup in level.buildablepickups)
	{
		if(buildablepickup[0].buildablestruct.name == buildablename && buildablepickup[0].visuals[0].model == modelname)
		{
			return buildablepickup[0];
		}
	}

	return undefined;
}

//Function Number: 114
track_buildable_piece_pickedup(piece)
{
	if(!IsDefined(piece) || !IsDefined(piece.buildablename))
	{
/#
		println("STAT TRACKING FAILURE: NOT DEFINED IN track_buildable_piece_pickedup() \n");
#/
		return;
	}

	self add_map_buildable_stat(piece.buildablename,"pieces_pickedup",1);
	buildable_struct = level.zombie_include_buildables[piece.buildablename];
	if(IsDefined(buildable_struct.piece_vox_id))
	{
		if(IsDefined(self.a_buildable_piece_pickedup_vox_cooldown) && isinarray(self.a_buildable_piece_pickedup_vox_cooldown,buildable_struct.piece_vox_id))
		{
			return;
		}

		self thread do_player_general_vox("general",buildable_struct.piece_vox_id + "_pickup");
		if(IsDefined(buildable_struct.piece_vox_timer))
		{
			self thread buildable_piece_pickedup_vox_cooldown(buildable_struct.piece_vox_id,buildable_struct.piece_vox_timer);
		}
	}
	else
	{
		self thread do_player_general_vox("general","build_pickup");
	}
}

//Function Number: 115
buildable_piece_pickedup_vox_cooldown(piece_vox_id,timer)
{
	self endon("disconnect");
	if(!(IsDefined(self.a_buildable_piece_pickedup_vox_cooldown)))
	{
		self.a_buildable_piece_pickedup_vox_cooldown = [];
	}

	self.a_buildable_piece_pickedup_vox_cooldown[self.a_buildable_piece_pickedup_vox_cooldown.size] = piece_vox_id;
	wait(timer);
	arrayremovevalue(self.a_buildable_piece_pickedup_vox_cooldown,piece_vox_id);
}

//Function Number: 116
track_buildable_pieces_built(buildable)
{
	if(!IsDefined(buildable) || !IsDefined(buildable.buildable_name))
	{
/#
		println("STAT TRACKING FAILURE: NOT DEFINED IN track_buildable_pieces_built() \n");
#/
		return;
	}

	bname = buildable.buildable_name;
	if(IsDefined(buildable.stat_name))
	{
		bname = buildable.stat_name;
	}

	self add_map_buildable_stat(bname,"pieces_built",1);
	if(!(buildable buildable_all_built()))
	{
		if(IsDefined(level.zombie_include_buildables[buildable.buildable_name]) && IsDefined(level.zombie_include_buildables[buildable.buildable_name].snd_build_add_vo_override))
		{
			self thread [[ level.zombie_include_buildables[buildable.buildable_name].snd_build_add_vo_override ]]();
		}
		else
		{
			self thread do_player_general_vox("general","build_add");
		}
	}
}

//Function Number: 117
track_buildables_built(buildable)
{
	if(!IsDefined(buildable) || !IsDefined(buildable.buildable_name))
	{
/#
		println("STAT TRACKING FAILURE: NOT DEFINED IN track_buildables_built() \n");
#/
		return;
	}

	bname = buildable.buildable_name;
	if(IsDefined(buildable.stat_name))
	{
		bname = buildable.stat_name;
	}

	self add_map_buildable_stat(bname,"buildable_built",1);
	self maps/mp/zombies/_zm_stats::increment_client_stat("buildables_built",0);
	self maps/mp/zombies/_zm_stats::increment_player_stat("buildables_built");
	if(IsDefined(buildable.stub.buildablestruct.vox_id))
	{
		self thread do_player_general_vox("general","build_" + buildable.stub.buildablestruct.vox_id + "_final");
	}
}

//Function Number: 118
track_buildables_pickedup(buildable)
{
	if(!(IsDefined(buildable)))
	{
/#
		println("STAT TRACKING FAILURE: NOT DEFINED IN track_buildables_pickedup() \n");
#/
		return;
	}

	stat_name = get_buildable_stat_name(buildable);
	if(!(IsDefined(stat_name)))
	{
/#
		println("STAT TRACKING FAILURE: NO STAT NAME FOR " + buildable + "\n");
#/
		return;
	}

	self add_map_buildable_stat(stat_name,"buildable_pickedup",1);
	self say_pickup_buildable_vo(buildable,0);
}

//Function Number: 119
track_buildables_planted(equipment)
{
	if(!(IsDefined(equipment)))
	{
/#
		println("STAT TRACKING FAILURE: NOT DEFINED for track_buildables_planted() \n");
#/
		return;
	}

	buildable_name = undefined;
	if(IsDefined(equipment.name))
	{
		buildable_name = get_buildable_stat_name(equipment.name);
	}

	if(!(IsDefined(buildable_name)))
	{
/#
		println("STAT TRACKING FAILURE: NO BUILDABLE NAME FOR track_buildables_planted() " + equipment.name + "\n");
#/
		return;
	}

	maps/mp/_demo::bookmark("zm_player_buildable_placed",GetTime(),self);
	self add_map_buildable_stat(buildable_name,"buildable_placed",1);
	vo_name = "build_plc_" + buildable_name;
	if(buildable_name == "electric_trap")
	{
		vo_name = "build_plc_trap";
	}

	if(!(IsDefined(self.buildable_timer) && self.buildable_timer))
	{
		self thread do_player_general_vox("general",vo_name);
		self thread placed_buildable_vo_timer();
	}
}

//Function Number: 120
placed_buildable_vo_timer()
{
	self endon("disconnect");
	self.buildable_timer = 1;
	wait(60);
	self.buildable_timer = 0;
}

//Function Number: 121
buildable_pickedup_timer()
{
	self endon("disconnect");
	self.buildable_pickedup_timer = 1;
	wait(60);
	self.buildable_pickedup_timer = 0;
}

//Function Number: 122
track_planted_buildables_pickedup(equipment)
{
	if(!(IsDefined(equipment)))
	{
		return;
	}

	if(equipment == "equip_turbine_zm" || equipment == "equip_turret_zm" || equipment == "equip_electrictrap_zm" || equipment == "riotshield_zm")
	{
		self maps/mp/zombies/_zm_stats::increment_client_stat("planted_buildables_pickedup",0);
		self maps/mp/zombies/_zm_stats::increment_player_stat("planted_buildables_pickedup");
	}

	if(!(IsDefined(self.buildable_pickedup_timer) && self.buildable_pickedup_timer))
	{
		self say_pickup_buildable_vo(equipment,1);
		self thread buildable_pickedup_timer();
	}
}

//Function Number: 123
track_placed_buildables(buildable_name)
{
	if(!(IsDefined(buildable_name)))
	{
		return;
	}

	self add_map_buildable_stat(buildable_name,"buildable_placed",1);
	vo_name = undefined;
	if(buildable_name == level.riotshield_name)
	{
		vo_name = "build_plc_shield";
	}

	if(!(IsDefined(vo_name)))
	{
		return;
	}

	self thread do_player_general_vox("general",vo_name);
}

//Function Number: 124
add_map_buildable_stat(piece_name,stat_name,value)
{
	if(!IsDefined(piece_name) || piece_name == "sq_common" || piece_name == "keys_zm" || piece_name == "oillamp_zm")
	{
		return;
	}

	if((IsDefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats) || IsDefined(level.zm_disable_recording_buildable_stats) && level.zm_disable_recording_buildable_stats)
	{
		return;
	}

	self adddstat("buildables",piece_name,stat_name,value);
}

//Function Number: 125
say_pickup_buildable_vo(buildable_name,world)
{
	if(IsDefined(self.buildable_pickedup_timer) && self.buildable_pickedup_timer)
	{
		return;
	}

	name = get_buildable_vo_name(buildable_name);
	if(!(IsDefined(name)))
	{
		return;
	}

	vo_name = "build_pck_b" + name;
	if(IsDefined(world) && world)
	{
		vo_name = "build_pck_w" + name;
	}

	if(!IsDefined(level.transit_buildable_vo_override) || !self [[ level.transit_buildable_vo_override ]](name,world))
	{
		self thread do_player_general_vox("general",vo_name);
		self thread buildable_pickedup_timer();
	}
}

//Function Number: 126
get_buildable_vo_name(buildable_name)
{
	switch(buildable_name)
	{
		case "equip_turbine_zm":
			return "turbine";

		case "equip_turret_zm":
			return "turret";

		case "equip_electrictrap_zm":
			return "trap";

		case "riotshield_zm":
			return "shield";

		case "jetgun_zm":
			return "jetgun";

		case "equip_springpad_zm":
			return "springpad_zm";

		case "equip_slipgun_zm":
			return "slipgun_zm";

		case "equip_headchopper_zm":
			return "headchopper_zm";

		case "equip_subwoofer_zm":
			return "subwoofer_zm";
	}

	return undefined;
}

//Function Number: 127
get_buildable_stat_name(buildable)
{
	if(IsDefined(buildable))
	{
		switch(buildable)
		{
			case "equip_turbine_zm":
				return "turbine";

			case "equip_turret_zm":
				return "turret";

			case "equip_electrictrap_zm":
				return "electric_trap";

			case "equip_springpad_zm":
				return "springpad_zm";

			case "equip_slipgun_zm":
				return "slipgun_zm";

			case "equip_headchopper_zm":
				return "headchopper_zm";

			case "equip_subwoofer_zm":
				return "subwoofer_zm";
		}

		return undefined;
	}
}