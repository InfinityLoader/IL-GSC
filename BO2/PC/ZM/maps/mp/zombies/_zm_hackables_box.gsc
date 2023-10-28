/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_hackables_box.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 10 ms
 * Timestamp: 10/28/2023 12:11:47 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_equip_hacker;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
box_hacks()
{
	boxes = getstructarray("treasure_chest_use","targetname");
	for(i = 0;i < boxes.size;i++)
	{
		box = boxes[i];
		box.box_hacks["respin"] = ::init_box_respin;
		box.box_hacks["respin_respin"] = ::init_box_respin_respin;
		box.box_hacks["summon_box"] = ::init_summon_box;
		box.last_hacked_round = 0;
	}

	level._zombiemode_chest_joker_chance_override_func = ::check_for_free_locations;
	level._zombiemode_custom_box_move_logic = ::custom_box_move_logic;
	level._zombiemode_check_firesale_loc_valid_func = ::custom_check_firesale_loc_valid_func;
	init_summon_hacks();
}

//Function Number: 2
custom_check_firesale_loc_valid_func()
{
	if(IsDefined(self.unitrigger_stub))
	{
		box = self.unitrigger_stub.trigger_target;
	}
	else if(IsDefined(self.stub))
	{
		box = self.stub.trigger_target;
	}

	if(box.last_hacked_round >= level.round_number)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
custom_box_move_logic()
{
	num_hacked_locs = 0;
	for(i = 0;i < level.chests.size;i++)
	{
		if(level.chests[i].last_hacked_round >= level.round_number)
		{
			num_hacked_locs++;
		}
	}

	if(num_hacked_locs == 0)
	{
		maps/mp/zombies/_zm_magicbox::default_box_move_logic();
		return;
	}

	found_loc = 0;
	original_spot = level.chest_index;
	while(!(found_loc))
	{
		level.chest_index++;
		if(original_spot == level.chest_index)
		{
			level.chest_index++;
		}

		level.chest_index = level.chest_index % level.chests.size;
		if(level.chests[level.chest_index].last_hacked_round < level.round_number)
		{
			found_loc = 1;
		}
	}
}

//Function Number: 4
check_for_free_locations(chance)
{
	boxes = level.chests;
	stored_chance = chance;
	chance = -1;
	for(i = 0;i < boxes.size;i++)
	{
		if(i == level.chest_index)
		{
		}
		else if(boxes[i].last_hacked_round < level.round_number)
		{
			chance = stored_chance;
			break;
		}
	}

	return chance;
}

//Function Number: 5
init_box_respin(chest,player)
{
	self thread box_respin_think(chest,player);
}

//Function Number: 6
box_respin_think(chest,player)
{
	respin_hack = spawnstruct();
	respin_hack.origin = 24 + VectorScale((0,0,1));
	respin_hack.radius = 48;
	respin_hack.height = 72;
	respin_hack.script_int = 600;
	respin_hack.script_float = 1.5;
	respin_hack.player = player;
	respin_hack.no_bullet_trace = 1;
	respin_hack.chest = chest;
	maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(respin_hack,::respin_box,::hack_box_qualifier);
	self.weapon_model waittill_either("death","kill_respin_think_thread");
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(respin_hack);
}

//Function Number: 7
respin_box_thread(hacker)
{
	if(IsDefined(self.chest.zbarrier.weapon_model))
	{
		self.chest.zbarrier.weapon_model notify("kill_respin_think_thread");
	}

	self.chest.no_fly_away = 1;
	self.chest.zbarrier notify("box_hacked_respin");
	self.chest disable_trigger();
	play_sound_at_pos("open_chest",self.chest.zbarrier.origin);
	play_sound_at_pos("music_chest",self.chest.zbarrier.origin);
	maps/mp/zombies/_zm_weapons::unacquire_weapon_toggle(self.chest.zbarrier.weapon_string);
	self.chest.zbarrier thread maps/mp/zombies/_zm_magicbox::treasure_chest_weapon_spawn(self.chest,hacker,1);
	self.chest.zbarrier waittill("randomization_done");
	self.chest.no_fly_away = undefined;
	if(!(flag("moving_chest_now")))
	{
		self.chest enable_trigger();
		self.chest thread maps/mp/zombies/_zm_magicbox::treasure_chest_timeout();
	}
}

//Function Number: 8
respin_box(hacker)
{
	self thread respin_box_thread(hacker);
}

//Function Number: 9
hack_box_qualifier(player)
{
	if(player == self.chest.chest_user && IsDefined(self.chest.weapon_out))
	{
		return 1;
	}
}

//Function Number: 10
init_box_respin_respin(chest,player)
{
	self thread box_respin_respin_think(chest,player);
}

//Function Number: 11
box_respin_respin_think(chest,player)
{
	respin_hack = spawnstruct();
	respin_hack.origin = 24 + VectorScale((0,0,1));
	respin_hack.radius = 48;
	respin_hack.height = 72;
	respin_hack.script_int = -950;
	respin_hack.script_float = 1.5;
	respin_hack.player = player;
	respin_hack.no_bullet_trace = 1;
	respin_hack.chest = chest;
	maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(respin_hack,::respin_respin_box,::hack_box_qualifier);
	self.weapon_model waittill_either("death","kill_respin_respin_think_thread");
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(respin_hack);
}

//Function Number: 12
respin_respin_box(hacker)
{
	org = self.chest.zbarrier.origin;
	if(IsDefined(self.chest.zbarrier.weapon_model))
	{
		self.chest.zbarrier.weapon_model notify("kill_respin_respin_think_thread");
		self.chest.zbarrier.weapon_model notify("kill_weapon_movement");
		self.chest.zbarrier.weapon_model moveto(40 + VectorScale((0,0,1)),org);
	}

	if(IsDefined(self.chest.zbarrier.weapon_model_dw))
	{
		self.chest.zbarrier.weapon_model_dw notify("kill_weapon_movement",0.5);
		self.chest.zbarrier.weapon_model_dw moveto(3 - VectorScale((1,1,1)),40 + VectorScale((0,0,1)));
	}

	self.chest.zbarrier notify("box_hacked_rerespin",org,0.5);
	self.chest.box_rerespun = 1;
	self thread fake_weapon_powerup_thread(self.chest.zbarrier.weapon_model,self.chest.zbarrier.weapon_model_dw);
}

//Function Number: 13
fake_weapon_powerup_thread(weapon1,weapon2)
{
	weapon1 endon("death");
	playfxontag(level._effect["powerup_on_solo"],weapon1,"tag_origin");
	playsoundatposition("zmb_spawn_powerup",weapon1.origin);
	weapon1 playloopsound("zmb_spawn_powerup_loop");
	self thread fake_weapon_powerup_timeout(weapon1,weapon2);
	while(IsDefined(weapon1))
	{
		waittime = randomfloatrange(2.5,5);
		yaw = randomint(360);
		if(yaw > 300)
		{
			yaw = 300;
		}
		else if(yaw < 60)
		{
			yaw = 60;
		}

		yaw = weapon1.angles[1] + yaw;
		weapon1 rotateto((-60 + randomint(120),yaw,-45 + randomint(90)),waittime,waittime * 0.5,waittime * 0.5);
		if(IsDefined(weapon2))
		{
			weapon2 rotateto((-60 + randomint(120),yaw,-45 + randomint(90)),waittime,waittime * 0.5,waittime * 0.5);
		}

		wait(randomfloat(waittime - 0.1));
	}
}

//Function Number: 14
fake_weapon_powerup_timeout(weapon1,weapon2)
{
	weapon1 endon("death");
	wait(15);
	for(i = 0;i < 40;i++)
	{
		if(i % 2)
		{
			weapon1 hide();
			if(IsDefined(weapon2))
			{
				weapon2 hide();
			}
		}
		else
		{
			weapon1 show();
			if(IsDefined(weapon2))
			{
				weapon2 hide();
			}
		}

		if(i < 15)
		{
			wait(0.5);
		}
		else if(i < 25)
		{
			wait(0.25);
		}
		else
		{
			wait(0.1);
		}
	}

	self.chest notify("trigger",level);
	if(IsDefined(weapon1))
	{
		weapon1 delete();
	}

	if(IsDefined(weapon2))
	{
		weapon2 delete();
	}
}

//Function Number: 15
init_summon_hacks()
{
	chests = getstructarray("treasure_chest_use","targetname");
	for(i = 0;i < chests.size;i++)
	{
		chest = chests[i];
		chest init_summon_box(chest.hidden);
	}
}

//Function Number: 16
init_summon_box(create)
{
	if(create)
	{
		if(IsDefined(self._summon_hack_struct))
		{
			maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self._summon_hack_struct);
			self._summon_hack_struct = undefined;
		}

		struct = spawnstruct();
		struct.origin = 24 + VectorScale((0,0,1));
		struct.radius = 48;
		struct.height = 72;
		struct.script_int = 1200;
		struct.script_float = 5;
		struct.no_bullet_trace = 1;
		struct.chest = self;
		self._summon_hack_struct = struct;
		maps/mp/zombies/_zm_equip_hacker::register_pooled_hackable_struct(struct,::summon_box,::summon_box_qualifier);
	}
	else if(IsDefined(self._summon_hack_struct))
	{
		maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self._summon_hack_struct);
		self._summon_hack_struct = undefined;
	}
}

//Function Number: 17
summon_box_thread(hacker)
{
	self.chest.last_hacked_round = level.round_number + randomintrange(2,5);
	maps/mp/zombies/_zm_equip_hacker::deregister_hackable_struct(self);
	self.chest thread maps/mp/zombies/_zm_magicbox::show_chest();
	self.chest notify("kill_chest_think");
	self.chest.auto_open = 1;
	self.chest.no_charge = 1;
	self.chest.no_fly_away = 1;
	self.chest.forced_user = hacker;
	self.chest thread maps/mp/zombies/_zm_magicbox::treasure_chest_think();
	self.chest.zbarrier waittill("closed");
	self.chest.forced_user = undefined;
	self.chest.auto_open = undefined;
	self.chest.no_charge = undefined;
	self.chest.no_fly_away = undefined;
	self.chest thread maps/mp/zombies/_zm_magicbox::hide_chest();
}

//Function Number: 18
summon_box(hacker)
{
	self thread summon_box_thread(hacker);
	if(IsDefined(hacker))
	{
		hacker thread maps/mp/zombies/_zm_audio::create_and_play_dialog("general","hack_box");
	}
}

//Function Number: 19
summon_box_qualifier(player)
{
	if(self.chest.last_hacked_round > level.round_number)
	{
		return 0;
	}

	if(IsDefined(self.chest.zbarrier.chest_moving) && self.chest.zbarrier.chest_moving)
	{
		return 0;
	}
}