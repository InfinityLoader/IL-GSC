/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_weap_cymbal_monkey.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 105 ms
 * Timestamp: 10/27/2023 3:03:31 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_utility;

#using_animtree( "zombie_cymbal_monkey" );

//Function Number: 1
init()
{
	if(!(cymbal_monkey_exists()))
	{
		return;
	}

/#
	level.zombiemode_devgui_cymbal_monkey_give = ::player_give_cymbal_monkey;
#/
	level._effect["monkey_glow"] = loadfx("maps/zombie/fx_zombie_monkey_light");
	level._effect["grenade_samantha_steal"] = loadfx("maps/zombie/fx_zmb_blackhole_trap_end");
	level.cymbal_monkeys = [];
	scriptmodelsuseanimtree(-1);
}

//Function Number: 2
player_give_cymbal_monkey()
{
	self giveweapon("cymbal_monkey_zm");
	self set_player_tactical_grenade("cymbal_monkey_zm");
	self thread player_handle_cymbal_monkey();
}

//Function Number: 3
player_handle_cymbal_monkey()
{
	self notify("starting_monkey_watch");
	self endon("disconnect");
	self endon("starting_monkey_watch");
	attract_dist_diff = level.monkey_attract_dist_diff;
	if(!(IsDefined(attract_dist_diff)))
	{
		attract_dist_diff = 45;
	}

	num_attractors = level.num_monkey_attractors;
	if(!(IsDefined(num_attractors)))
	{
		num_attractors = 96;
	}

	max_attract_dist = level.monkey_attract_dist;
	if(!(IsDefined(max_attract_dist)))
	{
		max_attract_dist = 1536;
	}

	while(1)
	{
		grenade = get_thrown_monkey();
		self player_throw_cymbal_monkey(grenade,num_attractors,max_attract_dist,attract_dist_diff);
		wait(0.05);
	}
}

//Function Number: 4
watch_for_dud(model)
{
	self endon("death");
	self waittill("grenade_dud");
	model.dud = 1;
	self playsound("zmb_vox_monkey_scream");
	self.monk_scream_vox = 1;
	wait(3);
	if(IsDefined(model))
	{
		model delete();
	}

	if(IsDefined(self))
	{
		self delete();
	}
}

//Function Number: 5
watch_for_emp(model)
{
	self endon("death");
	while(1)
	{
		level waittill("emp_detonate",origin,radius);
		if(distancesquared(origin,self.origin) < radius * radius)
		{
			break;
		}
	}

	self.stun_fx = 1;
	if(IsDefined(level._equipment_emp_destroy_fx))
	{
		playfx(level._equipment_emp_destroy_fx,5 + VectorScale((0,0,1)),self.origin);
	}

	wait(0.15);
	self.attract_to_origin = 0;
	self deactivate_zombie_point_of_interest();
	model clearanim(%o_monkey_bomb,0);
	wait(1);
	self detonate();
	wait(1);
	if(IsDefined(model))
	{
		model delete();
	}

	if(IsDefined(self))
	{
		self delete();
	}
}

//Function Number: 6
player_throw_cymbal_monkey(grenade,num_attractors,max_attract_dist,attract_dist_diff)
{
	self endon("disconnect");
	self endon("starting_monkey_watch");
	if(IsDefined(grenade))
	{
		grenade endon("death");
		if(self maps/mp/zombies/_zm_laststand::player_is_in_laststand())
		{
			grenade delete();
			return;
		}

		grenade hide();
		model = spawn("script_model",grenade.origin);
		model setmodel("weapon_zombie_monkey_bomb");
		model useanimtree(-1);
		model linkto(grenade);
		model.angles = grenade.angles;
		model thread monkey_cleanup(grenade);
		grenade thread watch_for_dud(model);
		grenade thread watch_for_emp(model);
		info = spawnstruct();
		info.sound_attractors = [];
		grenade thread monitor_zombie_groans(info);
		grenade waittill("stationary");
		if(IsDefined(level.grenade_planted))
		{
			self thread [[ level.grenade_planted ]](grenade,model);
		}

		if(IsDefined(grenade))
		{
			if(IsDefined(model))
			{
				model setanim(%o_monkey_bomb);
				if(!(IsDefined(grenade.backlinked) && grenade.backlinked))
				{
					model unlink();
					model.origin = grenade.origin;
					model.angles = grenade.angles;
				}
			}

			grenade resetmissiledetonationtime();
			playfxontag(level._effect["monkey_glow"],model,"origin_animate_jnt");
			valid_poi = check_point_in_active_zone(grenade.origin);
			if(valid_poi)
			{
				grenade create_zombie_point_of_interest(max_attract_dist,num_attractors,10000);
				grenade.attract_to_origin = 1;
				grenade thread create_zombie_point_of_interest_attractor_positions(4,attract_dist_diff);
				grenade thread wait_for_attractor_positions_complete();
				grenade thread do_monkey_sound(model,info);
				level.cymbal_monkeys[level.cymbal_monkeys.size] = grenade;
			}
			else
			{
				grenade.script_noteworthy = undefined;
				level thread grenade_stolen_by_sam(grenade,model);
			}
		}
		else
		{
			grenade.script_noteworthy = undefined;
			level thread grenade_stolen_by_sam(grenade,model);
		}
	}
}

//Function Number: 7
grenade_stolen_by_sam(ent_grenade,ent_model)
{
	if(!(IsDefined(ent_model)))
	{
		return;
	}

	direction = ent_model.origin;
	direction = (direction[1],direction[0],0);
	if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0)
	{
		direction = (direction[0],direction[1] * -1,0);
	}
	else if(direction[0] < 0)
	{
		direction = (direction[0] * -1,direction[1],0);
	}

	players = get_players();
	for(i = 0;i < players.size;i++)
	{
		if(isalive(players[i]))
		{
			players[i] playlocalsound(level.zmb_laugh_alias);
		}
	}

	playfxontag(level._effect["grenade_samantha_steal"],ent_model,"tag_origin");
	ent_model movez(60,1,0.25,0.25);
	ent_model vibrate(direction,1.5,2.5,1);
	ent_model waittill("movedone");
	ent_model delete();
	if(IsDefined(ent_grenade))
	{
		ent_grenade delete();
	}
}

//Function Number: 8
wait_for_attractor_positions_complete()
{
	self waittill("attractor_positions_generated");
	self.attract_to_origin = 0;
}

//Function Number: 9
monkey_cleanup(parent)
{
	while(1)
	{
		if(!(IsDefined(parent)))
		{
			if(IsDefined(self) && IsDefined(self.dud) && self.dud)
			{
				wait(6);
			}

			self_delete();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 10
do_monkey_sound(model,info)
{
	self.monk_scream_vox = 0;
	if(IsDefined(level.grenade_safe_to_bounce))
	{
		if(!([[ level.grenade_safe_to_bounce ]](self.owner,"cymbal_monkey_zm")))
		{
			self playsound("zmb_vox_monkey_scream");
			self.monk_scream_vox = 1;
		}
	}

	if(!self.monk_scream_vox && level.music_override == 0)
	{
		self playsound("zmb_monkey_song");
	}

	if(!(self.monk_scream_vox))
	{
		self thread play_delayed_explode_vox();
	}

	self waittill("explode",position);
	level notify("grenade_exploded",position,100,5000,450);
	monkey_index = -1;
	for(i = 0;i < level.cymbal_monkeys.size;i++)
	{
		if(!(IsDefined(level.cymbal_monkeys[i])))
		{
			monkey_index = i;
			break;
		}
	}

	if(monkey_index >= 0)
	{
		arrayremoveindex(level.cymbal_monkeys,monkey_index);
	}

	if(IsDefined(model))
	{
		model clearanim(%o_monkey_bomb,0.2);
	}

	for(i = 0;i < info.sound_attractors.size;i++)
	{
		if(IsDefined(info.sound_attractors[i]))
		{
			info.sound_attractors[i] notify("monkey_blown_up");
		}
	}
}

//Function Number: 11
play_delayed_explode_vox()
{
	wait(6.5);
	if(IsDefined(self))
	{
		self playsound("zmb_vox_monkey_explode");
	}
}

//Function Number: 12
get_thrown_monkey()
{
	self endon("disconnect");
	self endon("starting_monkey_watch");
	while(1)
	{
		self waittill("grenade_fire",grenade,weapname);
		if(weapname == "cymbal_monkey_zm")
		{
			grenade.use_grenade_special_long_bookmark = 1;
			grenade.grenade_multiattack_bookmark_count = 1;
			return grenade;
		}

		wait(0.05);
	}
}

//Function Number: 13
monitor_zombie_groans(info)
{
	self endon("explode");
	while(1)
	{
		if(!(IsDefined(self)))
		{
			return;
		}

		if(!(IsDefined(self.attractor_array)))
		{
			wait(0.05);
			continue;
		}

		for(i = 0;i < self.attractor_array.size;i++)
		{
			if(array_check_for_dupes(info.sound_attractors,self.attractor_array[i]))
			{
				if(IsDefined(self.origin) && IsDefined(self.attractor_array[i].origin))
				{
					if(distancesquared(self.origin,self.attractor_array[i].origin) < 250000)
					{
						info.sound_attractors[info.sound_attractors.size] = self.attractor_array[i];
						self.attractor_array[i] thread play_zombie_groans();
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 14
play_zombie_groans()
{
	self endon("death");
	self endon("monkey_blown_up");
	while(1)
	{
		if(IsDefined(self))
		{
			self playsound("zmb_vox_zombie_groan");
			wait(randomfloatrange(2,3));
			continue;
		}

		return;
	}
}

//Function Number: 15
cymbal_monkey_exists()
{
	return IsDefined(level.zombie_weapons["cymbal_monkey_zm"]);
}