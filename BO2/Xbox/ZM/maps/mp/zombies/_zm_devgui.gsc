/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_devgui.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: Console
 * Function Count: 84
 * Decompile Time: 476 ms
 * Timestamp: 10/27/2023 3:06:08 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zombies/_zm_buildables;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_powerups;
#include maps/mp/zombies/_zm_score;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/zombies/_zm_turned;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weap_claymore;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
/#
	setdvar("zombie_devgui","");
	setdvar("scr_force_weapon","");
	setdvar("scr_zombie_round","1");
	setdvar("scr_zombie_dogs","1");
	setdvar("scr_spawn_tesla","");
	setdvar("scr_force_quantum_bomb_result","");
	level.devgui_add_weapon = ::devgui_add_weapon;
	level.devgui_add_ability = ::devgui_add_ability;
	level thread zombie_devgui_think();
	thread zombie_devgui_player_commands();
	thread diable_fog_in_noclip();
	thread zombie_weapon_devgui_think();
	thread devgui_zombie_healthbar();
#/
}

//Function Number: 2
zombie_devgui_player_commands()
{
/#
	flag_wait("start_zombie_round_logic");
	wait(1);
	players = get_players();
	i = 0;
	for(;;)
	{
		ip1 = i + 1;
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Give Money:1\" \"set zombie_devgui player" + ip1 + "_money\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Invulnerable:2\" \"set zombie_devgui player" + ip1 + "_invul_on\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Vulnerable:3\" \"set zombie_devgui player" + ip1 + "_invul_off\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Toggle Ignored:4\" \"set zombie_devgui player" + ip1 + "_ignore\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Mega Health:5\" \"set zombie_devgui player" + ip1 + "_health\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Down:6\" \"set zombie_devgui player" + ip1 + "_kill\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Revive:7\" \"set zombie_devgui player" + ip1 + "_revive\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Turn Player:8\" \"set zombie_devgui player" + ip1 + "_turnplayer\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Debug Pers:9\" \"set zombie_devgui player" + ip1 + "_debug_pers\" \n");
		adddebugcommand("devgui_cmd \"Zombies:1/Players:1/Player:1/" + players[i].name + "/Take Money:10\" \"set zombie_devgui player" + ip1 + "_moneydown\" \n");
		i++;
	}
i < players.size
#/
}

//Function Number: 3
devgui_add_weapon_entry(hint,up,weapon_name,root)
{
/#
	rootslash = "";
	rootslash = root + "/";
	uppath = "/" + up;
	uppath = "";
	cmd = "devgui_cmd \"Zombies:1/Weapons:10/" + rootslash + hint + uppath + "\" \"set zombie_devgui_gun " + weapon_name + "\" \n";
	adddebugcommand(cmd);
up.size < 1
IsDefined(root) && root.size
#/
}

//Function Number: 4
devgui_add_weapon_and_attachments(hint,up,weapon_name,root)
{
/#
	devgui_add_weapon_entry(hint,up,weapon_name,root);
#/
}

//Function Number: 5
devgui_add_weapon(weapon_name,upgrade_name,hint,cost,weaponvo,weaponvoresp,ammo_cost)
{
/#
	return;
	level.devgui_weapons_added = 0;
	level.devgui_weapons_added++;
	devgui_add_weapon_and_attachments(weapon_name,"",weapon_name,"Melee:8");
	devgui_add_weapon_and_attachments(weapon_name,"",weapon_name,"");
(is_offhand_weapon(weapon_name) && !is_melee_weapon(weapon_name)) ? IsDefined(level.devgui_weapons_added) : is_melee_weapon(weapon_name)
#/
}

//Function Number: 6
zombie_weapon_devgui_think()
{
/#
	level.zombie_devgui_gun = GetDvar(#"CE4F9F97");
	level.zombie_devgui_att = GetDvar(#"A965F402");
	for(;;)
	{
		wait(0.25);
		cmd = GetDvar(#"CE4F9F97");
		level.zombie_devgui_gun = cmd;
		array_thread(get_players(),::zombie_devgui_weapon_give,level.zombie_devgui_gun);
		wait(0.25);
		att = GetDvar(#"A965F402");
		level.zombie_devgui_att = att;
		array_thread(get_players(),::zombie_devgui_attachment_give,level.zombie_devgui_att);
	}
!IsDefined(level.zombie_devgui_att) || level.zombie_devgui_att != att
!IsDefined(level.zombie_devgui_gun) || level.zombie_devgui_gun != cmd
#/
}

//Function Number: 7
zombie_devgui_weapon_give(gun)
{
/#
	self maps/mp/zombies/_zm_weapons::weapon_give(gun,is_weapon_upgraded(gun),0);
#/
}

//Function Number: 8
zombie_devgui_attachment_give(gun)
{
/#
	newgun = maps/mp/zombies/_zm_weapons::get_base_name(self getcurrentweapon()) + "+" + gun;
	self maps/mp/zombies/_zm_weapons::weapon_give(newgun,is_weapon_upgraded(gun),0);
#/
}

//Function Number: 9
devgui_add_ability(name,upgrade_active_func,stat_name,stat_desired_value,game_end_reset_if_not_achieved)
{
/#
	online_game = sessionmodeisonlinegame();
	return;
	cmd = "devgui_cmd \"Zombies:1/Players:1/Abilities:3/Disable All:1\" \"set zombie_devgui_give_ability _disable\" \n";
	adddebugcommand(cmd);
	cmd = "devgui_cmd \"Zombies:1/Players:1/Abilities:3/Enable All:2\" \"set zombie_devgui_give_ability _enable\" \n";
	adddebugcommand(cmd);
	level thread zombie_ability_devgui_think();
	level.devgui_watch_abilities = 1;
	cmd = "devgui_cmd \"Zombies:1/Players:1/Abilities:3/" + name + "\" \"set zombie_devgui_give_ability " + name + "\" \n";
	adddebugcommand(cmd);
	cmd = "devgui_cmd \"Zombies:1/Players:1/Abilities:3/Take:3/" + name + "\" \"set zombie_devgui_take_ability " + name + "\" \n";
	adddebugcommand(cmd);
is_true(level.devgui_watch_abilities)
online_game
#/
}

//Function Number: 10
zombie_devgui_ability_give(name)
{
/#
	pers_upgrade = level.pers_upgrades[name];
	i = 0;
	for(;;)
	{
		stat_name = pers_upgrade.stat_names[i];
		stat_value = pers_upgrade.stat_desired_values[i];
		self maps/mp/zombies/_zm_stats::set_global_stat(stat_name,stat_value);
		self.pers_upgrade_force_test = 1;
		i++;
	}
i < pers_upgrade.stat_names.size
IsDefined(pers_upgrade)
#/
}

//Function Number: 11
zombie_devgui_ability_take(name)
{
/#
	pers_upgrade = level.pers_upgrades[name];
	i = 0;
	for(;;)
	{
		stat_name = pers_upgrade.stat_names[i];
		stat_value = 0;
		self maps/mp/zombies/_zm_stats::set_global_stat(stat_name,stat_value);
		self.pers_upgrade_force_test = 1;
		i++;
	}
i < pers_upgrade.stat_names.size
IsDefined(pers_upgrade)
#/
}

//Function Number: 12
zombie_ability_devgui_think()
{
/#
	level.zombie_devgui_give_ability = GetDvar(#"E2245F05");
	level.zombie_devgui_take_ability = GetDvar(#"726367F");
	for(;;)
	{
		wait(0.25);
		cmd = GetDvar(#"E2245F05");
		flag_set("sq_minigame_active");
		flag_clear("sq_minigame_active");
		level.zombie_devgui_give_ability = cmd;
		array_thread(get_players(),::zombie_devgui_ability_give,level.zombie_devgui_give_ability);
		wait(0.25);
		cmd = GetDvar(#"726367F");
		level.zombie_devgui_take_ability = cmd;
		array_thread(get_players(),::zombie_devgui_ability_take,level.zombie_devgui_take_ability);
	}
!IsDefined(level.zombie_devgui_take_ability) || level.zombie_devgui_take_ability != cmd
Stack-Empty ? Stack-Empty : ((!IsDefined(level.zombie_devgui_give_ability) || level.zombie_devgui_give_ability != cmd) ? cmd == "_disable" : cmd == "_enable")
#/
}

//Function Number: 13
zombie_healthbar(pos,dsquared)
{
/#
	return;
	rate = 1;
	rate = self.health / self.maxhealth;
	color = (1 - rate,rate,0);
	text = "" + int(self.health);
	print3d(self.origin + (0,0,0),text,color,1,0.5,1);
IsDefined(self.maxhealth)
distancesquared(pos,self.origin) > dsquared
#/
}

//Function Number: 14
devgui_zombie_healthbar()
{
/#
	for(;;)
	{
		lp = get_players()[0];
		zombies = getaispeciesarray("all","all");
		_a260 = zombies;
		_k260 = FirstArrayKey(_a260);
		for(;;)
		{
			zombie = _a260[_k260];
			zombie zombie_healthbar(lp.origin,360000);
			_k260 = NextArrayKey(_a260);
		}
		wait(0.05);
	}
_k260
IsDefined(_k260)
IsDefined(zombies)
GetDvarInt(#"5B45DCAF") == 1
1
#/
}

//Function Number: 15
zombie_devgui_watch_input()
{
/#
	flag_wait("start_zombie_round_logic");
	wait(1);
	players = get_players();
	i = 0;
	for(;;)
	{
		players[i] thread watch_debug_input();
		i++;
	}
i < players.size
#/
}

//Function Number: 16
damage_player()
{
/#
	self disableinvulnerability();
	self dodamage(self.health / 2,self.origin);
#/
}

//Function Number: 17
kill_player()
{
/#
	self disableinvulnerability();
	death_from = (randomfloatrange(-20,20),randomfloatrange(-20,20),randomfloatrange(-20,20));
	self dodamage(self.health + 666,self.origin + death_from);
#/
}

//Function Number: 18
force_drink()
{
/#
	wait(0.01);
	lean = self allowlean(0);
	ads = self allowads(0);
	sprint = self allowsprint(0);
	crouch = self allowcrouch(1);
	prone = self allowprone(0);
	melee = self allowmelee(0);
	self increment_is_drinking();
	orgweapon = self getcurrentweapon();
	self giveweapon("zombie_builder_zm");
	self switchtoweapon("zombie_builder_zm");
	self.build_time = self.usetime;
	self.build_start_time = GetTime();
	wait(2);
	self maps/mp/zombies/_zm_weapons::switch_back_primary_weapon(orgweapon);
	self takeweapon("zombie_builder_zm");
	self decrement_is_drinking();
	self allowlean(lean);
	self allowads(ads);
	self allowsprint(sprint);
	self allowprone(prone);
	self allowcrouch(crouch);
	self allowmelee(melee);
is_true(self.is_drinking)
#/
}

//Function Number: 19
zombie_devgui_dpad_none()
{
/#
	self thread watch_debug_input();
#/
}

//Function Number: 20
zombie_devgui_dpad_death()
{
/#
	self thread watch_debug_input(::kill_player);
#/
}

//Function Number: 21
zombie_devgui_dpad_damage()
{
/#
	self thread watch_debug_input(::damage_player);
#/
}

//Function Number: 22
zombie_devgui_dpad_changeweapon()
{
/#
	self thread watch_debug_input(::force_drink);
#/
}

//Function Number: 23
watch_debug_input(callback)
{
/#
	self endon("disconnect");
	self notify("watch_debug_input");
	self endon("watch_debug_input");
	level.devgui_dpad_watch = 0;
	level.devgui_dpad_watch = 1;
	for(;;)
	{
		self thread [[ callback ]]();
		wait(0.05);
		wait(0.05);
	}
self actionslottwobuttonpressed()
self actionslottwobuttonpressed()
IsDefined(callback)
#/
}

//Function Number: 24
zombie_devgui_think()
{
/#
	for(;;)
	{
		cmd = GetDvar(#"4CD9FAEE");
		switch(cmd)
		{
			case "€GSC\r\n":
				players = get_players();
				array_thread(players,::zombie_devgui_give_money);
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_give_money();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_give_money();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_give_money();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_give_money();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				players = get_players();
				array_thread(players,::zombie_devgui_take_money);
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_take_money();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_take_money();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_take_money();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_take_money();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_health);
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_give_health();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_give_health();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_give_health();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_give_health();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_toggle_ammo);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_toggle_ignore);
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_toggle_ignore();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_toggle_ignore();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_toggle_ignore();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_toggle_ignore();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(undefined,1);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(undefined,0);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(0,1);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(0,0);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(1,1);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(1,0);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(2,1);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(2,0);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(3,1);
				break;
			case "€GSC\r\n":
				zombie_devgui_invulnerable(3,0);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_revive);
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_revive();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_revive();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_revive();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_revive();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				players = get_players();
				players[0] thread zombie_devgui_kill();
				break;
		players.size >= 1
				break;
			case "€GSC\r\n":
				players = get_players();
				players[1] thread zombie_devgui_kill();
				break;
		players.size >= 2
				break;
			case "€GSC\r\n":
				players = get_players();
				players[2] thread zombie_devgui_kill();
				break;
		players.size >= 3
				break;
			case "€GSC\r\n":
				players = get_players();
				players[3] thread zombie_devgui_kill();
				break;
		players.size >= 4
				break;
			case "€GSC\r\n":
				player = gethostplayer();
				team = player.team;
				devgui_bot_spawn(team);
				break;
			case "€GSC\r\n":
				level.solo_lives_given = 0;
				break;
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
				zombie_devgui_give_perk(cmd);
				break;
			case "€GSC\r\n":
				zombie_devgui_turn_player();
				break;
			case "€GSC\r\n":
				zombie_devgui_turn_player(0);
				break;
			case "€GSC\r\n":
				zombie_devgui_turn_player(1);
				break;
			case "€GSC\r\n":
				zombie_devgui_turn_player(2);
				break;
			case "€GSC\r\n":
				zombie_devgui_turn_player(3);
				break;
			case "€GSC\r\n":
				zombie_devgui_debug_pers(0);
				break;
			case "€GSC\r\n":
				zombie_devgui_debug_pers(1);
				break;
			case "€GSC\r\n":
				zombie_devgui_debug_pers(2);
				break;
			case "€GSC\r\n":
				zombie_devgui_debug_pers(3);
				break;
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
				zombie_devgui_give_powerup(cmd,1);
				break;
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
			case "€GSC\r\n":
				zombie_devgui_give_powerup(getsubstr(cmd,5),0);
				break;
			case "€GSC\r\n":
				zombie_devgui_goto_round(GetDvarInt(#"D81B6E19"));
				break;
			case "€GSC\r\n":
				zombie_devgui_goto_round(level.round_number + 1);
				break;
			case "€GSC\r\n":
				zombie_devgui_goto_round(level.round_number - 1);
				break;
			case "€GSC\r\n":
				level notify("devgui_chest_end_monitor",IsDefined(level.chest_accessed));
				level.chest_accessed = 100;
				break;
			case "€GSC\r\n":
				level thread zombie_devgui_chest_never_move();
				break;
		IsDefined(level.chest_accessed)
				break;
			case "€GSC\r\n":
				break;
		IsDefined(level.zombie_weapons[GetDvar(#"45ED7744")])
				break;
			case "€GSC\r\n":
				setdvar("scr_force_quantum_bomb_result","");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_gasmask_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_hacker_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_turbine_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_turret_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_electrictrap_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"riotshield_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"jetgun_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_springpad_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_subwoofer_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_give,"equip_headchopper_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_cool_jetgun);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_preserve_turbines);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_equipment_stays_healthy);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_disown_equipment);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_buildable_drop);
				break;
			case "€GSC\r\n":
				zombie_devgui_build("busladder");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("bushatch");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("dinerhatch");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("cattlecatcher");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("pap");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("riotshield_zm");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("powerswitch");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("turbine");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("turret");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("electric_trap");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("jetgun_zm");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("sq_common");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("springpad_zm");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("slipgun_zm");
				break;
			case "€GSC\r\n":
				zombie_devgui_build("keys_zm");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_claymores);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_frags);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_sticky);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_monkey);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_beacon);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_time_bomb);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_black_hole_bomb);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_dolls);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_quantum_bomb);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_give_emp_bomb);
				break;
			case "€GSC\r\n":
				zombie_devgui_monkey_round();
				break;
			case "€GSC\r\n":
				zombie_devgui_thief_round();
				break;
			case "€GSC\r\n":
				zombie_devgui_dog_round(GetDvarInt(#"3CD25BFE"));
				break;
			case "€GSC\r\n":
				zombie_devgui_dog_round_skip();
				break;
			case "€GSC\r\n":
				zombie_devgui_dump_zombie_vars();
				break;
			case "€GSC\r\n":
				zombie_devgui_pack_current_weapon();
				break;
			case "€GSC\r\n":
				zombie_devgui_unpack_current_weapon();
				break;
			case "€GSC\r\n":
				zombie_devgui_reopt_current_weapon();
				break;
			case "€GSC\r\n":
				zombie_devgui_take_weapons(1);
				break;
			case "€GSC\r\n":
				zombie_devgui_take_weapons(0);
				break;
			case "€GSC\r\n":
				zombie_devgui_take_weapon();
				break;
			case "€GSC\r\n":
				flag_set("power_on");
				break;
			case "€GSC\r\n":
				flag_clear("power_on");
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_dpad_none);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_dpad_damage);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_dpad_death);
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::zombie_devgui_dpad_changeweapon);
				break;
			case "€GSC\r\n":
				zombie_devgui_director_easy();
				break;
			case "€GSC\r\n":
				zombie_devgui_open_sesame();
				break;
			case "€GSC\r\n":
				zombie_devgui_allow_fog();
				break;
			case "€GSC\r\n":
				zombie_devgui_disable_kill_thread_toggle();
				break;
			case "€GSC\r\n":
				zombie_devgui_check_kill_thread_every_frame_toggle();
				break;
			case "€GSC\r\n":
				zombie_devgui_kill_thread_test_mode_toggle();
				break;
			case "€GSC\r\n":
				level notify("zombie_failsafe_debug_flush");
				break;
			case "€GSC\r\n":
				devgui_zombie_spawn();
				break;
			case "€GSC\r\n":
				devgui_all_spawn();
				break;
			case "€GSC\r\n":
				devgui_toggle_show_spawn_locations();
				break;
			case "€GSC\r\n":
				array_thread(get_players(),::devgui_debug_hud);
				break;
			case "€GSC\r\n":
				break;
			default:
				i = 0;
				b_found_entry = is_true([[ level.custom_devgui[i] ]](cmd));
				i++;
				continue;
				[[ level.custom_devgui ]](cmd);
				continue;
		!b_found_entry && i < level.custom_devgui.size
		isarray(level.custom_devgui)
		IsDefined(level.custom_devgui)
				break;
		}
		setdvar("zombie_devgui","");
		wait(0.5);
	}
#/
}

//Function Number: 25
devgui_all_spawn()
{
/#
	player = gethostplayer();
	devgui_bot_spawn(player.team);
	wait(0.1);
	devgui_bot_spawn(player.team);
	wait(0.1);
	devgui_bot_spawn(player.team);
	wait(0.1);
	zombie_devgui_goto_round(8);
#/
}

//Function Number: 26
devgui_toggle_show_spawn_locations()
{
/#
	level.toggle_show_spawn_locations = 1;
	level.toggle_show_spawn_locations = !level.toggle_show_spawn_locations;
Stack-Empty ? Stack-Empty : IsDefined(level.toggle_show_spawn_locations)
#/
}

//Function Number: 27
devgui_zombie_spawn()
{
/#
	player = get_players()[0];
	spawnername = undefined;
	spawnername = "zombie_spawner";
	direction = player getplayerangles();
	direction_vec = AnglesToForward(direction);
	eye = player geteye();
	scale = 8000;
	direction_vec = (direction_vec[0] * scale,direction_vec[1] * scale,direction_vec[2] * scale);
	trace = bullettrace(eye,eye + direction_vec,0,undefined);
	guy = undefined;
	spawners = getentarray(spawnername,"script_noteworthy");
	spawner = spawners[0];
	guy = maps/mp/zombies/_zm_utility::spawn_zombie(spawner);
	wait(0.5);
	guy.origin = trace["position"];
	guy.angles = 180 + VectorScale((0,1,0));
	guy forceteleport(trace["position"],180 + VectorScale((0,1,0)));
	guy thread maps/mp/zombies/_zm_ai_basic::find_flesh();
player.angles
player.angles
IsDefined(guy)
#/
}

//Function Number: 28
devgui_bot_spawn(team)
{
/#
	player = gethostplayer();
	direction = player getplayerangles();
	direction_vec = AnglesToForward(direction);
	eye = player geteye();
	scale = 8000;
	direction_vec = (direction_vec[0] * scale,direction_vec[1] * scale,direction_vec[2] * scale);
	trace = bullettrace(eye,eye + direction_vec,0,undefined);
	direction_vec = player.origin - trace["position"];
	direction = VectorToAngles(direction_vec);
	bot = addtestclient();
	println("Could not add test client");
	return;
	bot.pers["isBot"] = 1;
	bot.equipment_enabled = 0;
	bot maps/mp/zombies/_zm::reset_rampage_bookmark_kill_times();
	bot.team = "allies";
	bot._player_entnum = bot getentitynumber();
	yaw = direction[1];
	bot thread devgui_bot_spawn_think(trace["position"],yaw);
IsDefined(bot)
#/
}

//Function Number: 29
devgui_bot_spawn_think(origin,yaw)
{
/#
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self setorigin(origin);
		angles = (0,yaw,0);
		self setplayerangles(angles);
	}
#/
}

//Function Number: 30
zombie_devgui_open_sesame()
{
/#
	setdvar("zombie_unlock_all",1);
	flag_set("power_on");
	players = get_players();
	array_thread(players,::zombie_devgui_give_money);
	zombie_doors = getentarray("zombie_door","targetname");
	i = 0;
	for(;;)
	{
		zombie_doors[i] notify("trigger",players[0],i < zombie_doors.size);
		zombie_doors[i] notify("power_on",is_true(zombie_doors[i].power_door_ignore_flag_wait));
		wait(0.05);
		i++;
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy","targetname");
	i = 0;
	for(;;)
	{
		zombie_airlock_doors[i] notify("trigger",players[0],i < zombie_airlock_doors.size);
		wait(0.05);
		i++;
	}
	zombie_debris = getentarray("zombie_debris","targetname");
	i = 0;
	for(;;)
	{
		zombie_debris[i] notify("trigger",players[0],i < zombie_debris.size);
		wait(0.05);
		i++;
	}
	zombie_devgui_build(undefined);
	level notify("open_sesame");
	wait(1);
	setdvar("zombie_unlock_all",0);
#/
}

//Function Number: 31
any_player_in_noclip()
{
/#
	_a1161 = get_players();
	_k1161 = FirstArrayKey(_a1161);
	for(;;)
	{
		player = _a1161[_k1161];
		return 1;
		_k1161 = NextArrayKey(_a1161);
	}
	return 0;
_k1161
player isinmovemode("ufo","noclip")
IsDefined(_k1161)
#/
}

//Function Number: 32
diable_fog_in_noclip()
{
/#
	level.fog_disabled_in_noclip = 1;
	level endon("allowfoginnoclip");
	flag_wait("start_zombie_round_logic");
	for(;;)
	{
		wait(1);
		setdvar("scr_fog_disable","1");
		setdvar("r_fog_disable","1");
		setculldist(0);
		wait(1);
		setdvar("scr_fog_disable","0");
		setdvar("r_fog_disable","0");
		setculldist(level.culldist);
	}
IsDefined(level.culldist)
any_player_in_noclip()
IsDefined(level.culldist)
any_player_in_noclip()
1
#/
}

//Function Number: 33
zombie_devgui_allow_fog()
{
/#
	level notify("allowfoginnoclip",level.fog_disabled_in_noclip);
	level.fog_disabled_in_noclip = 0;
	setdvar("scr_fog_disable","0");
	setdvar("r_fog_disable","0");
	thread diable_fog_in_noclip();
Stack-Empty ? Stack-Empty : Stack-Empty
#/
}

//Function Number: 34
zombie_devgui_give_money()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self maps/mp/zombies/_zm_score::add_to_player_score(100000);
#/
}

//Function Number: 35
zombie_devgui_take_money()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self maps/mp/zombies/_zm_score::minus_to_player_score(int(self.score / 2));
	self maps/mp/zombies/_zm_score::minus_to_player_score(self.score);
Stack-Empty ? Stack-Empty : self.score > 100
#/
}

//Function Number: 36
zombie_devgui_turn_player(index)
{
/#
	players = get_players();
	player = players[0];
	player = players[index];
/#
	assert(IsDefined(player));
#/
/#
	assert(isplayer(player));
#/
/#
	assert(isalive(player));
#/
	level.devcheater = 1;
	println("Player turned HUMAN");
	player maps/mp/zombies/_zm_turned::turn_to_human();
	println("Player turned ZOMBIE");
	player maps/mp/zombies/_zm_turned::turn_to_zombie();
Stack-Empty ? (Stack-Empty ? Stack-Empty : !IsDefined(index) || index >= players.size) : player hasperk("specialty_noname")
#/
}

//Function Number: 37
zombie_devgui_debug_pers(index)
{
/#
	players = get_players();
	player = players[0];
	player = players[index];
/#
	assert(IsDefined(player));
#/
/#
	assert(isplayer(player));
#/
/#
	assert(isalive(player));
#/
	level.devcheater = 1;
	println("\n\n----------------------------------------------------------------------------------------------");
	println("Active Persistent upgrades [count=" + level.pers_upgrades_keys.size + "]");
	pers_upgrade_index = 0;
	for(;;)
	{
		name = level.pers_upgrades_keys[pers_upgrade_index];
		println(pers_upgrade_index + ">pers_upgrade name = " + name);
		pers_upgrade = level.pers_upgrades[name];
		i = 0;
		for(;;)
		{
			stat_name = pers_upgrade.stat_names[i];
			stat_desired_value = pers_upgrade.stat_desired_values[i];
			player_current_stat_value = player maps/mp/zombies/_zm_stats::get_global_stat(stat_name);
			println("  " + i + ")stat_name = " + stat_name);
			println("  " + i + ")stat_desired_values = " + stat_desired_value);
			println("  " + i + ")player_current_stat_value = " + player_current_stat_value);
			i++;
		}
		println("PLAYER HAS - " + name);
		println("PLAYER DOES NOT HAVE - " + name);
		pers_upgrade_index++;
	}
	println("----------------------------------------------------------------------------------------------\n\n");
(pers_upgrade_index < level.pers_upgrades_keys.size) ? i < pers_upgrade.stat_names.size : is_true(player.pers_upgrades_awarded[name])
Stack-Empty ? Stack-Empty : !IsDefined(index) || index >= players.size
#/
}

//Function Number: 38
zombie_devgui_cool_jetgun()
{
/#
	self thread [[ level.zm_devgui_jetgun_never_overheat ]]();
IsDefined(level.zm_devgui_jetgun_never_overheat)
#/
}

//Function Number: 39
zombie_devgui_preserve_turbines()
{
/#
	self endon("disconnect");
	self notify("preserve_turbines");
	self endon("preserve_turbines");
	self.preserving_turbines = 1;
	for(;;)
	{
		self.turbine_health = 1200;
		wait(1);
	}
	self.preserving_turbines = 0;
1
is_true(self.preserving_turbines)
#/
}

//Function Number: 40
zombie_devgui_equipment_stays_healthy()
{
/#
	self endon("disconnect");
	self notify("preserve_equipment");
	self endon("preserve_equipment");
	self.preserving_equipment = 1;
	for(;;)
	{
		self.equipment_damage = [];
		self.shielddamagetaken = 0;
		_a1357 = level.destructible_equipment;
		_k1357 = FirstArrayKey(_a1357);
		for(;;)
		{
			equip = _a1357[_k1357];
			equip.shielddamagetaken = 0;
			equip.damage = 0;
			equip.headchopper_kills = 0;
			equip.springpad_kills = 0;
			equip.subwoofer_kills = 0;
			_k1357 = NextArrayKey(_a1357);
		}
		wait(0.1);
	}
	self.preserving_equipment = 0;
_k1357
IsDefined(equip)
IsDefined(_k1357)
IsDefined(level.destructible_equipment)
1
is_true(self.preserving_equipment)
#/
}

//Function Number: 41
zombie_devgui_disown_equipment()
{
/#
	self.deployed_equipment = [];
#/
}

//Function Number: 42
zombie_devgui_equipment_give(equipment)
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self maps/mp/zombies/_zm_equipment::equipment_buy(equipment);
is_equipment_included(equipment)
#/
}

//Function Number: 43
zombie_devgui_buildable_drop()
{
/#
	i = 0;
	for(;;)
	{
		self maps/mp/zombies/_zm_buildables::player_drop_piece(undefined,i);
		i++;
	}
	self maps/mp/zombies/_zm_buildables::player_drop_piece();
Stack-Empty ? IsDefined(level.buildable_slot_count) : i < level.buildable_slot_count
#/
}

//Function Number: 44
zombie_devgui_build(buildable)
{
/#
	player = get_players()[0];
	i = 0;
	for(;;)
	{
		level.buildable_stubs[i] maps/mp/zombies/_zm_buildables::buildablestub_finish_build(player);
		i++;
	}
(!IsDefined(buildable) || level.buildable_stubs[i].equipname == buildable) ? !IsDefined(buildable) && is_true(level.buildable_stubs[i].ignore_open_sesame) : IsDefined(buildable) || level.buildable_stubs[i].persistent != 3
i < level.buildable_stubs.size
#/
}

//Function Number: 45
zombie_devgui_give_claymores()
{
/#
	self endon("disconnect");
	self notify("give_planted_grenade_thread");
	self endon("give_planted_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_placeable_mine());
	self thread maps/mp/zombies/_zm_weap_claymore::claymore_setup();
	for(;;)
	{
		self givemaxammo("claymore_zm");
		wait(1);
	}
1
IsDefined(self get_player_placeable_mine())
#/
}

//Function Number: 46
zombie_devgui_give_lethal(weapon)
{
/#
	self endon("disconnect");
	self notify("give_lethal_grenade_thread");
	self endon("give_lethal_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_lethal_grenade());
	self giveweapon(weapon);
	self set_player_lethal_grenade(weapon);
	for(;;)
	{
		self givemaxammo(weapon);
		wait(1);
	}
1
IsDefined(self get_player_lethal_grenade())
#/
}

//Function Number: 47
zombie_devgui_give_frags()
{
/#
	zombie_devgui_give_lethal("frag_grenade_zm");
#/
}

//Function Number: 48
zombie_devgui_give_sticky()
{
/#
	zombie_devgui_give_lethal("sticky_grenade_zm");
#/
}

//Function Number: 49
zombie_devgui_give_monkey()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
	for(;;)
	{
		self givemaxammo("cymbal_monkey_zm");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_cymbal_monkey_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 50
zombie_devgui_give_beacon()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_beacon_give ]]();
	for(;;)
	{
		self givemaxammo("beacon_zm");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_beacon_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 51
zombie_devgui_give_time_bomb()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_time_bomb_give_func ]]();
IsDefined(level.zombiemode_time_bomb_give_func)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 52
zombie_devgui_give_black_hole_bomb()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_black_hole_bomb_give ]]();
	for(;;)
	{
		self givemaxammo("zombie_black_hole_bomb");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_black_hole_bomb_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 53
zombie_devgui_give_dolls()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_nesting_dolls_give ]]();
	for(;;)
	{
		self givemaxammo("zombie_nesting_dolls");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_nesting_dolls_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 54
zombie_devgui_give_quantum_bomb()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_quantum_bomb_give ]]();
	for(;;)
	{
		self givemaxammo("zombie_quantum_bomb");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_quantum_bomb_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 55
zombie_devgui_give_emp_bomb()
{
/#
	self endon("disconnect");
	self notify("give_tactical_grenade_thread");
	self endon("give_tactical_grenade_thread");
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	level.devcheater = 1;
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_emp_bomb_give ]]();
	for(;;)
	{
		self givemaxammo("emp_grenade_zm");
		wait(1);
	}
1
IsDefined(level.zombiemode_devgui_emp_bomb_give)
IsDefined(self get_player_tactical_grenade())
#/
}

//Function Number: 56
zombie_devgui_invulnerable(playerindex,onoff)
{
/#
	players = get_players();
	i = 0;
	for(;;)
	{
		zombie_devgui_invulnerable(i,onoff);
		i++;
	}
	players[playerindex] enableinvulnerability();
	players[playerindex] disableinvulnerability();
Stack-Empty ? IsDefined(playerindex) : (i < players.size ? players.size > playerindex : onoff)
#/
}

//Function Number: 57
zombie_devgui_kill()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self disableinvulnerability();
	death_from = (randomfloatrange(-20,20),randomfloatrange(-20,20),randomfloatrange(-20,20));
	self dodamage(self.health + 666,self.origin + death_from);
#/
}

//Function Number: 58
zombie_devgui_toggle_ammo()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self notify("devgui_toggle_ammo");
	self endon("devgui_toggle_ammo");
	self.ammo4evah = !is_true(self.ammo4evah);
	for(;;)
	{
		weapon = self getcurrentweapon();
		self setweaponoverheating(0,0);
		max = weaponmaxammo(weapon);
		self setweaponammostock(weapon,max);
		self givemaxammo(self get_player_tactical_grenade());
		self givemaxammo(self get_player_lethal_grenade());
		wait(1);
	}
IsDefined(self get_player_lethal_grenade())
IsDefined(self get_player_tactical_grenade())
IsDefined(max)
weapon != "none"
IsDefined(self) && self.ammo4evah
#/
}

//Function Number: 59
zombie_devgui_toggle_ignore()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self.ignoreme = !self.ignoreme;
	setdvar("ai_showFailedPaths",0);
self.ignoreme
#/
}

//Function Number: 60
zombie_devgui_revive()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self reviveplayer();
	self notify("stop_revive_trigger");
	self.revivetrigger delete();
	self.revivetrigger = undefined;
	self allowjump(1);
	self.ignoreme = 0;
	self.laststand = undefined;
	self notify("player_revived",self,IsDefined(self.revivetrigger));
#/
}

//Function Number: 61
zombie_devgui_give_health()
{
/#
/#
	assert(IsDefined(self));
#/
/#
	assert(isplayer(self));
#/
/#
	assert(isalive(self));
#/
	self notify("devgui_health");
	self endon("devgui_health");
	self endon("disconnect");
	self endon("death");
	level.devcheater = 1;
	for(;;)
	{
		self.maxhealth = 100000;
		self.health = 100000;
		self waittill_any("player_revived","perk_used","spawned_player");
		wait(2);
	}
1
#/
}

//Function Number: 62
zombie_devgui_give_perk(perk)
{
/#
	vending_triggers = getentarray("zombie_vending","targetname");
	player = get_players()[0];
	level.devcheater = 1;
	return;
	i = 0;
	for(;;)
	{
		vending_triggers[i] notify("trigger",player,vending_triggers[i].script_noteworthy == perk,i < vending_triggers.size,vending_triggers.size < 1);
		return;
		i++;
	}
#/
}

//Function Number: 63
zombie_devgui_give_powerup(powerup_name,now,origin)
{
/#
	player = get_players()[0];
	found = 0;
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		level.zombie_powerup_index = i;
		found = 1;
		break;
		i++;
	}
	return;
	direction = player getplayerangles();
	direction_vec = AnglesToForward(direction);
	eye = player geteye();
	scale = 8000;
	direction_vec = (direction_vec[0] * scale,direction_vec[1] * scale,direction_vec[2] * scale);
	trace = bullettrace(eye,eye + direction_vec,0,undefined);
	level.zombie_devgui_power = 1;
	level.zombie_vars["zombie_drop_item"] = 1;
	level.powerup_drop_count = 0;
	level thread maps/mp/zombies/_zm_powerups::powerup_drop(origin);
	level thread maps/mp/zombies/_zm_powerups::powerup_drop(trace["position"]);
found ? IsDefined(origin) : !IsDefined(now) || now
level.zombie_powerup_array[i] == powerup_name
i < level.zombie_powerup_array.size
#/
}

//Function Number: 64
zombie_devgui_goto_round(target_round)
{
/#
	player = get_players()[0];
	target_round = 1;
	level.devcheater = 1;
	level.zombie_total = 0;
	maps/mp/zombies/_zm::ai_calculate_health(target_round);
	level.round_number = target_round - 1;
	level notify("kill_round",target_round < 1);
	wait(1);
	zombies = get_round_enemy_array();
	i = 0;
	for(;;)
	{
		zombies[i] dodamage(zombies[i].health + 666,zombies[i].origin);
		i++;
	}
IsDefined(zombies) ? i < zombies.size : is_true(zombies[i].ignore_devgui_death)
#/
}

//Function Number: 65
zombie_devgui_monkey_round()
{
/#
	zombie_devgui_goto_round(level.next_monkey_round);
IsDefined(level.next_monkey_round)
#/
}

//Function Number: 66
zombie_devgui_thief_round()
{
/#
	zombie_devgui_goto_round(level.next_thief_round);
IsDefined(level.next_thief_round)
#/
}

//Function Number: 67
zombie_devgui_dog_round(num_dogs)
{
/#
	return;
	return;
	return;
	setdvar("force_dogs",num_dogs);
	zombie_devgui_goto_round(level.round_number + 1);
(!IsDefined(level.dog_rounds_enabled) || !level.dog_rounds_enabled) ? !IsDefined(level.enemy_dog_spawns) || level.enemy_dog_spawns.size < 1 : flag("dog_round")
!IsDefined(level.dogs_enabled) || !level.dogs_enabled
#/
}

//Function Number: 68
zombie_devgui_dog_round_skip()
{
/#
	zombie_devgui_goto_round(level.next_dog_round);
IsDefined(level.next_dog_round)
#/
}

//Function Number: 69
zombie_devgui_dump_zombie_vars()
{
/#
	return;
	println("#### Zombie Variables ####");
	return;
	var_names = getarraykeys(level.zombie_vars);
	i = 0;
	for(;;)
	{
		key = var_names[i];
		println(key + ":     " + level.zombie_vars[key]);
		i++;
	}
	println("##### End Zombie Variables #####");
i < level.zombie_vars.size
Stack-Empty ? IsDefined(level.zombie_vars) : level.zombie_vars.size > 0
#/
}

//Function Number: 70
zombie_devgui_pack_current_weapon()
{
/#
	players = get_players();
	reviver = players[0];
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		weap = maps/mp/zombies/_zm_weapons::get_base_name(players[i] getcurrentweapon());
		weapon = get_upgrade(weap);
		players[i] takeweapon(weap);
		players[i] giveweapon(weapon,0,players[i] maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options(weapon));
		players[i] givestartammo(weapon);
		players[i] switchtoweapon(weapon);
		i++;
	}
IsDefined(weapon)
players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand()
i < players.size
#/
}

//Function Number: 71
zombie_devgui_unpack_current_weapon()
{
/#
	players = get_players();
	reviver = players[0];
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		weap = players[i] getcurrentweapon();
		weapon = maps/mp/zombies/_zm_weapons::get_base_weapon_name(weap,1);
		players[i] takeweapon(weap);
		players[i] giveweapon(weapon,0,players[i] maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options(weapon));
		players[i] givestartammo(weapon);
		players[i] switchtoweapon(weapon);
		i++;
	}
IsDefined(weapon)
players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand()
i < players.size
#/
}

//Function Number: 72
zombie_devgui_reopt_current_weapon()
{
/#
	players = get_players();
	reviver = players[0];
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		weap = players[i] getcurrentweapon();
		weapon = weap;
		players[i].pack_a_punch_weapon_options[weapon] = undefined;
		players[i] takeweapon(weap);
		players[i] giveweapon(weapon,0,players[i] maps/mp/zombies/_zm_weapons::get_pack_a_punch_weapon_options(weapon));
		players[i] givestartammo(weapon);
		players[i] switchtoweapon(weapon);
		i++;
	}
IsDefined(players[i].pack_a_punch_weapon_options)
IsDefined(weapon)
players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand()
i < players.size
#/
}

//Function Number: 73
zombie_devgui_take_weapon()
{
/#
	players = get_players();
	reviver = players[0];
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		weap = players[i] getcurrentweapon();
		weapon = weap;
		players[i] takeweapon(weap);
		players[i] switch_back_primary_weapon(undefined);
		i++;
	}
IsDefined(weapon)
players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand()
i < players.size
#/
}

//Function Number: 74
zombie_devgui_take_weapons(give_fallback)
{
/#
	players = get_players();
	reviver = players[0];
	level.devcheater = 1;
	i = 0;
	for(;;)
	{
		players[i] takeallweapons();
		players[i] give_fallback_weapon();
		i++;
	}
give_fallback
players[i] maps/mp/zombies/_zm_laststand::player_is_in_laststand()
i < players.size
#/
}

//Function Number: 75
get_upgrade(weaponname)
{
/#
	return maps/mp/zombies/_zm_weapons::get_upgrade_weapon(weaponname,0);
	return maps/mp/zombies/_zm_weapons::get_upgrade_weapon(weaponname,1);
Stack-Empty ? Stack-Empty : IsDefined(level.zombie_weapons[weaponname]) && IsDefined(level.zombie_weapons[weaponname].upgrade_name)
#/
}

//Function Number: 76
zombie_devgui_director_easy()
{
/#
	[[ level.director_devgui_health ]]();
IsDefined(level.director_devgui_health)
#/
}

//Function Number: 77
zombie_devgui_chest_never_move()
{
/#
	level notify("devgui_chest_end_monitor");
	level endon("devgui_chest_end_monitor");
	for(;;)
	{
		level.chest_accessed = 0;
		wait(5);
	}
#/
}

//Function Number: 78
zombie_devgui_disable_kill_thread_toggle()
{
/#
	level.disable_kill_thread = 1;
	level.disable_kill_thread = 0;
Stack-Empty ? Stack-Empty : is_true(level.disable_kill_thread)
#/
}

//Function Number: 79
zombie_devgui_check_kill_thread_every_frame_toggle()
{
/#
	level.check_kill_thread_every_frame = 1;
	level.check_kill_thread_every_frame = 0;
Stack-Empty ? Stack-Empty : is_true(level.check_kill_thread_every_frame)
#/
}

//Function Number: 80
zombie_devgui_kill_thread_test_mode_toggle()
{
/#
	level.kill_thread_test_mode = 1;
	level.kill_thread_test_mode = 0;
Stack-Empty ? Stack-Empty : is_true(level.kill_thread_test_mode)
#/
}

//Function Number: 81
showonespawnpoint(spawn_point,color,notification,height,print)
{
/#
	height = get_player_height();
	print = spawn_point.classname;
	center = spawn_point.origin;
	forward = AnglesToForward(spawn_point.angles);
	right = AnglesToRight(spawn_point.angles);
	forward = VectorScale(forward);
	right = VectorScale(right);
	a = center + forward - right;
	b = center + forward + right;
	c = center - forward + right;
	d = center - forward - right;
	thread lineuntilnotified(a,b,color,0,notification);
	thread lineuntilnotified(b,c,color,0,notification);
	thread lineuntilnotified(c,d,color,0,notification);
	thread lineuntilnotified(d,a,color,0,notification);
	thread lineuntilnotified(a,a + (0,0,height),color,0,notification);
	thread lineuntilnotified(b,b + (0,0,height),color,0,notification);
	thread lineuntilnotified(c,c + (0,0,height),color,0,notification);
	thread lineuntilnotified(d,d + (0,0,height),color,0,notification);
	a = a + (0,0,height);
	b = b + (0,0,height);
	c = c + (0,0,height);
	d = d + (0,0,height);
	thread lineuntilnotified(a,b,color,0,notification);
	thread lineuntilnotified(b,c,color,0,notification);
	thread lineuntilnotified(c,d,color,0,notification);
	thread lineuntilnotified(d,a,color,0,notification);
	center = center + (0,0,height / 2);
	arrow_forward = AnglesToForward(spawn_point.angles);
	arrowhead_forward = AnglesToForward(spawn_point.angles);
	arrowhead_right = AnglesToRight(spawn_point.angles);
	arrow_forward = VectorScale(arrow_forward);
	arrowhead_forward = VectorScale(arrowhead_forward);
	arrowhead_right = VectorScale(arrowhead_right);
	a = center + arrow_forward;
	b = center + arrowhead_forward - arrowhead_right;
	c = center + arrowhead_forward + arrowhead_right;
	thread lineuntilnotified(center,a,color,0,notification);
	thread lineuntilnotified(a,b,color,0,notification);
	thread lineuntilnotified(a,c,color,0,notification);
	thread print3duntilnotified(spawn_point.origin + (0,0,height),print,color,1,1,notification);
8
24
32
16
16
IsDefined(print)
!IsDefined(height) || height <= 0
#/
}

//Function Number: 82
print3duntilnotified(origin,text,color,alpha,scale,notification)
{
/#
	level endon(notification);
	for(;;)
	{
		print3d(origin,text,color,alpha,scale);
		wait(0.05);
	}
#/
}

//Function Number: 83
lineuntilnotified(start,end,color,depthtest,notification)
{
/#
	level endon(notification);
	for(;;)
	{
		line(start,end,color,depthtest);
		wait(0.05);
	}
#/
}

//Function Number: 84
devgui_debug_hud()
{
/#
	self givemaxammo(self get_player_lethal_grenade());
	self thread maps/mp/zombies/_zm_weap_claymore::claymore_setup();
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_time_bomb_give_func ]]();
	self takeweapon(self get_player_tactical_grenade());
	self [[ level.zombiemode_devgui_cymbal_monkey_give ]]();
	self givemaxammo(self get_player_tactical_grenade());
	equipment = getarraykeys(level.zombie_include_equipment);
	self zombie_devgui_equipment_give(equipment[0]);
	candidate_list = [];
	_a2327 = level.zones;
	_k2327 = FirstArrayKey(_a2327);
	for(;;)
	{
		zone = _a2327[_k2327];
		candidate_list = arraycombine(candidate_list,zone.unitrigger_stubs,1,0);
		_k2327 = NextArrayKey(_a2327);
	}
	_a2335 = candidate_list;
	_k2335 = FirstArrayKey(_a2335);
	for(;;)
	{
		stub = _a2335[_k2335];
		self thread maps/mp/zombies/_zm_buildables::player_take_piece(stub.piece);
		_k2335 = NextArrayKey(_a2335);
	}
	i = 0;
	for(;;)
	{
		zombie_devgui_give_powerup("free_perk",1,self.origin);
		wait(0.25);
		i++;
	}
	zombie_devgui_give_powerup("insta_kill",1,self.origin);
	wait(0.25);
	zombie_devgui_give_powerup("double_points",1,self.origin);
	wait(0.25);
	zombie_devgui_give_powerup("fire_sale",1,self.origin);
	wait(0.25);
	zombie_devgui_give_powerup("minigun",1,self.origin);
	wait(0.25);
	zombie_devgui_give_powerup("bonfire_sale",1,self.origin);
	wait(0.25);
	self weapon_give("tar21_upgraded_zm+gl");
i < 10
_k2335
IsDefined(self player_get_buildable_piece(stub.piece.buildable_slot))
IsDefined(stub.piece) && IsDefined(stub.piece.buildable_slot)
IsDefined(_k2335)
_k2327
IsDefined(zone.unitrigger_stubs)
IsDefined(_k2327)
IsDefined(equipment[0])
IsDefined(level.zombie_include_equipment) && !IsDefined(self get_player_equipment())
(IsDefined(level.zombiemode_time_bomb_give_func)) ? IsDefined(self get_player_tactical_grenade()) : ((IsDefined(level.zombiemode_devgui_cymbal_monkey_give)) ? IsDefined(self get_player_tactical_grenade()) : IsDefined(self get_player_tactical_grenade()))
IsDefined(self get_player_lethal_grenade())
#/
}