/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_pers_upgrades_system.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:11:53 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_utility;

//Function Number: 1
pers_register_upgrade(name,upgrade_active_func,stat_name,stat_desired_value,game_end_reset_if_not_achieved)
{
	if(!(IsDefined(level.pers_upgrades)))
	{
		level.pers_upgrades = [];
		level.pers_upgrades_keys = [];
	}

	if(IsDefined(level.pers_upgrades[name]))
	{
/#
		assert(0,"A persistent upgrade is already registered for name: " + name);
	}
#/
	level.pers_upgrades_keys[level.pers_upgrades_keys.size] = name;
	level.pers_upgrades[name] = spawnstruct();
	level.pers_upgrades[name].stat_names = [];
	level.pers_upgrades[name].stat_desired_values = [];
	level.pers_upgrades[name].upgrade_active_func = upgrade_active_func;
	level.pers_upgrades[name].game_end_reset_if_not_achieved = game_end_reset_if_not_achieved;
	add_pers_upgrade_stat(name,stat_name,stat_desired_value);
/#
	if(IsDefined(level.devgui_add_ability))
	{
		[[ level.devgui_add_ability ]](name,upgrade_active_func,stat_name,stat_desired_value,game_end_reset_if_not_achieved);
	}
#/
}

//Function Number: 2
add_pers_upgrade_stat(name,stat_name,stat_desired_value)
{
	if(!(IsDefined(level.pers_upgrades[name])))
	{
/#
		assert(0,name + " - Persistent upgrade is not registered yet.");
	}
#/
	stats_size = level.pers_upgrades[name].stat_names.size;
	level.pers_upgrades[name].stat_names[stats_size] = stat_name;
	level.pers_upgrades[name].stat_desired_values[stats_size] = stat_desired_value;
}

//Function Number: 3
pers_upgrades_monitor()
{
	if(!(IsDefined(level.pers_upgrades)))
	{
		return;
	}

	if(!(is_classic()))
	{
		return;
	}

	level thread wait_for_game_end();
	while(1)
	{
		waittillframeend;
		players = getplayers();
		for(player_index = 0;player_index < players.size;player_index++)
		{
			player = players[player_index];
			if(is_player_valid(player) && IsDefined(player.stats_this_frame))
			{
				if(!player.stats_this_frame.size && !IsDefined(player.pers_upgrade_force_test) && player.pers_upgrade_force_test)
				{
				}
				else
				{
					for(pers_upgrade_index = 0;pers_upgrade_index < level.pers_upgrades_keys.size;pers_upgrade_index++)
					{
						pers_upgrade = level.pers_upgrades[level.pers_upgrades_keys[pers_upgrade_index]];
						is_stat_updated = player is_any_pers_upgrade_stat_updated(pers_upgrade);
						if(is_stat_updated)
						{
							should_award = player check_pers_upgrade(pers_upgrade);
							if(should_award)
							{
								if(IsDefined(player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) && player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]])
								{
								}
								else
								{
									player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]] = 1;
									if(flag("initial_blackscreen_passed") && !is_true(player.is_hotjoining))
									{
										type = "upgrade";
										if(IsDefined(level.snd_pers_upgrade_force_type))
										{
											type = level.snd_pers_upgrade_force_type;
										}

										player playsoundtoplayer("evt_player_upgrade",player);
										if(IsDefined(level.pers_upgrade_vo_spoken) && level.pers_upgrade_vo_spoken)
										{
											player delay_thread(1,maps/mp/zombies/_zm_audio::create_and_play_dialog,"general",type,undefined,level.snd_pers_upgrade_force_variant);
										}
										else
										{
											player delay_thread(1,::play_vox_to_player,"general",type,level.snd_pers_upgrade_force_variant);
										}

										if(IsDefined(player.upgrade_fx_origin))
										{
											fx_org = player.upgrade_fx_origin;
											player.upgrade_fx_origin = undefined;
										}
										else
										{
											fx_org = player.origin;
											v_dir = AnglesToForward(player getplayerangles());
											v_up = AnglesToUp(player getplayerangles());
											fx_org = fx_org + v_dir * 30 + v_up * 12;
										}

										playfx(level._effect["upgrade_aquired"],fx_org);
										level thread maps/mp/zombies/_zm::disable_end_game_intermission(1.5);
									}

/#
									player iprintlnbold("Upgraded!");
#/
									if(IsDefined(pers_upgrade.upgrade_active_func))
									{
										player thread [[ pers_upgrade.upgrade_active_func ]]();
									}

									if(IsDefined(player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]]) && player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]])
									{
										if(flag("initial_blackscreen_passed") && !is_true(player.is_hotjoining))
										{
											player playsoundtoplayer("evt_player_downgrade",player);
										}

/#
										player iprintlnbold("Downgraded!");
									}
#/
									player.pers_upgrades_awarded[level.pers_upgrades_keys[pers_upgrade_index]] = 0;
								}
							}
						}
					}

					player.pers_upgrade_force_test = 0;
					player.stats_this_frame = [];
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 4
wait_for_game_end()
{
	if(!(is_classic()))
	{
		return;
	}

	level waittill("end_game");
	players = getplayers();
	for(player_index = 0;player_index < players.size;player_index++)
	{
		player = players[player_index];
		for(index = 0;index < level.pers_upgrades_keys.size;index++)
		{
			str_name = level.pers_upgrades_keys[index];
			game_end_reset_if_not_achieved = level.pers_upgrades[str_name].game_end_reset_if_not_achieved;
			if(IsDefined(game_end_reset_if_not_achieved) && game_end_reset_if_not_achieved == 1)
			{
				if(!(IsDefined(player.pers_upgrades_awarded[str_name]) && player.pers_upgrades_awarded[str_name]))
				{
					for(stat_index = 0;stat_index < level.pers_upgrades[str_name].stat_names.size;stat_index++)
					{
						player maps/mp/zombies/_zm_stats::zero_client_stat(level.pers_upgrades[str_name].stat_names[stat_index],0);
					}
				}
			}
		}
	}
}

//Function Number: 5
check_pers_upgrade(pers_upgrade)
{
	should_award = 1;
	for(i = 0;i < pers_upgrade.stat_names.size;i++)
	{
		stat_name = pers_upgrade.stat_names[i];
		should_award = self check_pers_upgrade_stat(stat_name,pers_upgrade.stat_desired_values[i]);
		if(!(should_award))
		{
			break;
		}
	}

	return should_award;
}

//Function Number: 6
is_any_pers_upgrade_stat_updated(pers_upgrade)
{
	if(IsDefined(self.pers_upgrade_force_test) && self.pers_upgrade_force_test)
	{
		return 1;
	}

	result = 0;
	for(i = 0;i < pers_upgrade.stat_names.size;i++)
	{
		stat_name = pers_upgrade.stat_names[i];
		if(IsDefined(self.stats_this_frame[stat_name]))
		{
			result = 1;
			break;
		}
	}

	return result;
}

//Function Number: 7
check_pers_upgrade_stat(stat_name,stat_desired_value)
{
	should_award = 1;
	current_stat_value = self maps/mp/zombies/_zm_stats::get_global_stat(stat_name);
	if(current_stat_value < stat_desired_value)
	{
		should_award = 0;
	}

	return should_award;
}

//Function Number: 8
round_end()
{
	if(!(is_classic()))
	{
		return;
	}

	self notify("pers_stats_end_of_round");
	if(IsDefined(self.pers["pers_max_round_reached"]))
	{
		if(level.round_number > self.pers["pers_max_round_reached"])
		{
			self maps/mp/zombies/_zm_stats::set_client_stat("pers_max_round_reached",level.round_number,0);
		}
	}
}