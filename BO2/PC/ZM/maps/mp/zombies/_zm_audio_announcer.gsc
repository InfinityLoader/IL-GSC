/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zm_audio_announcer.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 89 ms
 * Timestamp: 10/27/2023 3:02:57 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;

//Function Number: 1
init()
{
	game["zmbdialog"] = [];
	game["zmbdialog"]["prefix"] = "vox_zmba";
	createvox("carpenter","powerup_carpenter");
	createvox("insta_kill","powerup_instakill");
	createvox("double_points","powerup_doublepoints");
	createvox("nuke","powerup_nuke");
	createvox("full_ammo","powerup_maxammo");
	createvox("fire_sale","powerup_firesale");
	createvox("minigun","powerup_death_machine");
	createvox("zombie_blood","powerup_zombie_blood");
	createvox("boxmove","event_magicbox");
	createvox("dogstart","event_dogstart");
	thread init_gamemodespecificvox(GetDvar(#"41651E"),GetDvar(#"C955B4CD"));
	level.allowzmbannouncer = 1;
}

//Function Number: 2
init_gamemodespecificvox(mode,location)
{
	switch(mode)
	{
		case "zmeat":
			init_meatvox("meat");
			break;

		case "zrace":
			init_racevox("race",location);
			break;

		case "zgrief":
			init_griefvox("grief");
			break;

		case "zcleansed":
			init_cleansed(location);
			break;

		default:
			init_gamemodecommonvox();
			break;
	}
}

//Function Number: 3
init_gamemodecommonvox(prefix)
{
	createvox("rules","rules",prefix);
	createvox("countdown","intro",prefix);
	createvox("side_switch","side_switch",prefix);
	createvox("round_win","win_rd",prefix);
	createvox("round_lose","lose_rd",prefix);
	createvox("round_tied","tied_rd",prefix);
	createvox("match_win","win",prefix);
	createvox("match_lose","lose",prefix);
	createvox("match_tied","tied",prefix);
}

//Function Number: 4
init_griefvox(prefix)
{
	init_gamemodecommonvox(prefix);
	createvox("1_player_down","1rivdown",prefix);
	createvox("2_player_down","2rivdown",prefix);
	createvox("3_player_down","3rivdown",prefix);
	createvox("4_player_down","4rivdown",prefix);
	createvox("grief_restarted","restart",prefix);
	createvox("grief_lost","lose",prefix);
	createvox("grief_won","win",prefix);
	createvox("1_player_left","1rivup",prefix);
	createvox("2_player_left","2rivup",prefix);
	createvox("3_player_left","3rivup",prefix);
	createvox("last_player","solo",prefix);
}

//Function Number: 5
init_cleansed(prefix)
{
	init_gamemodecommonvox(prefix);
	createvox("dr_start_single_0","dr_start_0");
	createvox("dr_start_2","dr_start_1");
	createvox("dr_start_3","dr_start_2");
	createvox("dr_cure_found_line","dr_cure_found");
	createvox("dr_monkey_killer","dr_monkey_0");
	createvox("dr_monkey_killee","dr_monkey_1");
	createvox("dr_human_killed","dr_kill_plr");
	createvox("dr_human_killer","dr_kill_plr_2");
	createvox("dr_survival","dr_plr_survive_0");
	createvox("dr_zurvival","dr_zmb_survive_2");
	createvox("dr_countdown0","dr_plr_survive_1");
	createvox("dr_countdown1","dr_plr_survive_2");
	createvox("dr_countdown2","dr_plr_survive_3");
	createvox("dr_ending","dr_time_0");
}

//Function Number: 6
init_meatvox(prefix)
{
	init_gamemodecommonvox(prefix);
	createvox("meat_drop","drop",prefix);
	createvox("meat_grab","grab",prefix);
	createvox("meat_grab_A","team_cdc",prefix);
	createvox("meat_grab_B","team_cia",prefix);
	createvox("meat_land","land",prefix);
	createvox("meat_hold","hold",prefix);
	createvox("meat_revive_1","revive1",prefix);
	createvox("meat_revive_2","revive2",prefix);
	createvox("meat_revive_3","revive3",prefix);
	createvox("meat_ring_splitter","ring_tripple",prefix);
	createvox("meat_ring_minigun","ring_death",prefix);
	createvox("meat_ring_ammo","ring_ammo",prefix);
}

//Function Number: 7
init_racevox(prefix,location)
{
	init_gamemodecommonvox(prefix);
	switch(location)
	{
		case "tunnel":
			createvox("rules","rules_" + location,prefix);
			createvox("countdown","intro_" + location,prefix);
			break;

		case "power":
			createvox("rules","rules_" + location,prefix);
			createvox("countdown","intro_" + location,prefix);
			createvox("lap1","lap1",prefix);
			createvox("lap2","lap2",prefix);
			createvox("lap_final","lap_final",prefix);
			break;

		case "farm":
			createvox("rules","rules_" + location,prefix);
			createvox("countdown","intro_" + location,prefix);
			createvox("hoop_area","hoop_area",prefix);
			createvox("hoop_miss","hoop_miss",prefix);
			break;

		default:
			break;
	}

	createvox("race_room_2_ally","room2_ally",prefix);
	createvox("race_room_3_ally","room3_ally",prefix);
	createvox("race_room_4_ally","room4_ally",prefix);
	createvox("race_room_5_ally","room5_ally",prefix);
	createvox("race_room_2_axis","room2_axis",prefix);
	createvox("race_room_3_axis","room3_axis",prefix);
	createvox("race_room_4_axis","room4_axis",prefix);
	createvox("race_room_5_axis","room5_axis",prefix);
	createvox("race_ahead_1_ally","ahead1_ally",prefix);
	createvox("race_ahead_2_ally","ahead2_ally",prefix);
	createvox("race_ahead_3_ally","ahead3_ally",prefix);
	createvox("race_ahead_4_ally","ahead4_ally",prefix);
	createvox("race_ahead_1_axis","ahead1_axis",prefix);
	createvox("race_ahead_2_axis","ahead2_axis",prefix);
	createvox("race_ahead_3_axis","ahead3_axis",prefix);
	createvox("race_ahead_4_axis","ahead4_axis",prefix);
	createvox("race_kill_15","door15",prefix);
	createvox("race_kill_10","door10",prefix);
	createvox("race_kill_5","door5",prefix);
	createvox("race_kill_3","door3",prefix);
	createvox("race_kill_1","door1",prefix);
	createvox("race_door_open","door_open",prefix);
	createvox("race_door_nag","door_nag",prefix);
	createvox("race_grief_incoming","grief_income_ammo",prefix);
	createvox("race_grief_land","grief_land",prefix);
	createvox("race_laststand","last_stand",prefix);
}

//Function Number: 8
createvox(type,alias,gametype)
{
	if(!(IsDefined(gametype)))
	{
		gametype = "";
	}
	else
	{
		gametype = gametype + "_";
	}

	game["zmbdialog"][type] = gametype + alias;
}

//Function Number: 9
announceroundwinner(winner,delay)
{
	if(IsDefined(delay) && delay > 0)
	{
		wait(delay);
	}

	if(!IsDefined(winner) || isplayer(winner))
	{
		return;
	}

	if(winner != "tied")
	{
		players = get_players();
		foreach(player in players)
		{
			if(IsDefined(player._encounters_team) && player._encounters_team == winner)
			{
				winning_team = player.pers["team"];
				break;
			}
		}

		losing_team = getotherteam(winning_team);
		leaderdialog("round_win",winning_team,undefined,1);
		leaderdialog("round_lose",losing_team,undefined,1);
	}
	else
	{
		leaderdialog("round_tied",undefined,undefined,1);
	}
}

//Function Number: 10
announcematchwinner(winner,delay)
{
	if(IsDefined(delay) && delay > 0)
	{
		wait(delay);
	}

	if(!IsDefined(winner) || isplayer(winner))
	{
		return;
	}

	if(winner != "tied")
	{
		players = get_players();
		foreach(player in players)
		{
			if(IsDefined(player._encounters_team) && player._encounters_team == winner)
			{
				winning_team = player.pers["team"];
				break;
			}
		}

		losing_team = getotherteam(winning_team);
		leaderdialog("match_win",winning_team,undefined,1);
		leaderdialog("match_lose",losing_team,undefined,1);
	}
	else
	{
		leaderdialog("match_tied",undefined,undefined,1);
	}
}

//Function Number: 11
announcegamemoderules()
{
	if(GetDvar(#"C955B4CD") == "town")
	{
		leaderdialog("rules",undefined,undefined,undefined,20);
	}
}

//Function Number: 12
leaderdialog(dialog,team,group,queue,waittime)
{
/#
	assert(IsDefined(level.players));
#/
	if(!(IsDefined(team)))
	{
		leaderdialogbothteams(dialog,"allies",dialog,"axis",group,queue,waittime);
		return;
	}

	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(dialog,group,queue,waittime);
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(IsDefined(player.pers["team"]) && player.pers["team"] == team)
		{
			player leaderdialogonplayer(dialog,group,queue,waittime);
		}
	}
}

//Function Number: 13
leaderdialogbothteams(dialog1,team1,dialog2,team2,group,queue,waittime)
{
/#
	assert(IsDefined(level.players));
#/
	if(level.splitscreen)
	{
		if(level.players.size)
		{
			level.players[0] leaderdialogonplayer(dialog1,group,queue,waittime);
		}

		return;
	}

	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		team = player.pers["team"];
		if(!(IsDefined(team)))
		{
		}
		else if(team == team1)
		{
			player leaderdialogonplayer(dialog1,group,queue,waittime);
		}
		else if(team == team2)
		{
			player leaderdialogonplayer(dialog2,group,queue,waittime);
		}
	}
}

//Function Number: 14
leaderdialogonplayer(dialog,group,queue,waittime)
{
	team = self.pers["team"];
	if(!(IsDefined(team)))
	{
		return;
	}

	if(team != "allies" && team != "axis")
	{
		return;
	}

	if(IsDefined(group))
	{
		if(self.zmbdialoggroup == group)
		{
			return;
		}

		hadgroupdialog = IsDefined(self.zmbdialoggroups[group]);
		self.zmbdialoggroups[group] = dialog;
		dialog = group;
		if(hadgroupdialog)
		{
			return;
		}
	}

	if(!(self.zmbdialogactive))
	{
		self thread playleaderdialogonplayer(dialog,team,waittime);
	}
	else if(IsDefined(queue) && queue)
	{
		self.zmbdialogqueue[self.zmbdialogqueue.size] = dialog;
	}
}

//Function Number: 15
playleaderdialogonplayer(dialog,team,waittime)
{
	self endon("disconnect");
	if(level.allowzmbannouncer)
	{
		if(!(IsDefined(game["zmbdialog"][dialog])))
		{
/#
			println("DIALOG DEBUGGER: No VOX created for - " + dialog);
GetDvarInt(#"AEB127D") > 0
#/
			return;
		}
	}

	self.zmbdialogactive = 1;
	if(IsDefined(self.zmbdialoggroups[dialog]))
	{
		group = dialog;
		dialog = self.zmbdialoggroups[group];
		self.zmbdialoggroups[group] = undefined;
		self.zmbdialoggroup = group;
	}

	if(level.allowzmbannouncer)
	{
		alias = game["zmbdialog"]["prefix"] + "_" + game["zmbdialog"][dialog];
		variant = self getleaderdialogvariant(alias);
		if(!(IsDefined(variant)))
		{
			full_alias = alias;
		}
		else
		{
			full_alias = alias + "_" + variant;
		}

		self playlocalsound(full_alias);
	}

	if(IsDefined(waittime))
	{
		wait(waittime);
	}
	else
	{
		wait(4);
	}

	self.zmbdialogactive = 0;
	self.zmbdialoggroup = "";
	if(self.zmbdialogqueue.size > 0 && level.allowzmbannouncer)
	{
		nextdialog = self.zmbdialogqueue[0];
		for(i = 1;i < self.zmbdialogqueue.size;i++)
		{
			self.zmbdialogqueue[i - 1] = self.zmbdialogqueue[i];
		}

		self.zmbdialogqueue[i - 1] = undefined;
		self thread playleaderdialogonplayer(nextdialog,team);
	}
}

//Function Number: 16
getleaderdialogvariant(alias)
{
	if(!(IsDefined(alias)))
	{
		return;
	}

	if(!(IsDefined(level.announcer_dialog)))
	{
		level.announcer_dialog = [];
		level.announcer_dialog_available = [];
	}

	num_variants = maps/mp/zombies/_zm_spawner::get_number_variants(alias);
	if(num_variants <= 0)
	{
/#
		println("DIALOG DEBUGGER: No variants found for - " + alias);
GetDvarInt(#"AEB127D") > 0
#/
		return undefined;
	}

	for(i = 0;i < num_variants;i++)
	{
		level.announcer_dialog[alias][i] = i;
	}

	level.announcer_dialog_available[alias] = [];
	if(level.announcer_dialog_available[alias].size <= 0)
	{
		level.announcer_dialog_available[alias] = level.announcer_dialog[alias];
	}

	variation = random(level.announcer_dialog_available[alias]);
	level.announcer_dialog_available[alias] = arrayremovevalue(level.announcer_dialog_available[alias],variation);
	return variation;
}

//Function Number: 17
getroundswitchdialog(switchtype)
{
	switch(switchtype)
	{
		case "halftime":
			return "halftime";

		case "overtime":
			return "overtime";

		default:
			return "side_switch";
	}
}

//Function Number: 18
getotherteam(team)
{
	if(team == "allies")
	{
		return "axis";
	}
	else
	{
		return "allies";
	}
}