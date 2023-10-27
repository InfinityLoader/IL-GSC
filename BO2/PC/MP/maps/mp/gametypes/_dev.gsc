/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_dev.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 92
 * Decompile Time: 304 ms
 * Timestamp: 10/27/2023 2:59:56 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/bots/_bot;
#include maps/mp/gametypes/_dev_class;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_killcam;
#include maps/mp/gametypes/_rank;
#include maps/mp/killstreaks/_helicopter;
#include maps/mp/killstreaks/_helicopter_gunner;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/killstreaks/_radar;
#include maps/mp/killstreaks/_supplydrop;

//Function Number: 1
init()
{
/#
	for(;;)
	{
		updatedevsettingszm();
		wait(0.5);
	}
	return;
	setdvar("scr_showspawns","0");
	setdvar("scr_showstartspawns","0");
	setdvar("scr_botsHasPlayerWeapon","0");
	setdvar("scr_botsGrenadesOnly","0");
	setdvar("scr_botsSpecialGrenadesOnly","0");
	setdvar("scr_devHeliPathsDebugDraw","0");
	setdvar("scr_devStrafeRunPathDebugDraw","0");
	setdvar("scr_show_hq_spawns","");
	setdvar("scr_testScriptRuntimeError","0");
	precachemodel("defaultactor");
	precachestring(&"testPlayerScoreForTan");
	thread testscriptruntimeerror();
	thread testdvars();
	thread addtestclients();
	thread addenemyheli();
	thread addenemyu2();
	thread addtestcarepackage();
	thread removetestclients();
	thread watch_botsdvars();
	thread devhelipathdebugdraw();
	thread devstraferunpathdebugdraw();
	thread maps/mp/gametypes/_dev_class::dev_cac_init();
	thread maps/mp/gametypes/_globallogic_score::setplayermomentumdebug();
	setdvar("scr_giveperk","");
	setdvar("scr_forceevent","");
	setdvar("scr_draw_triggers","0");
	thread engagement_distance_debug_toggle();
	thread equipment_dev_gui();
	thread grenade_dev_gui();
	setdvar("debug_dynamic_ai_spawning","0");
	level.bot_overlay = 0;
	level.bot_threat = 0;
	level.bot_path = 0;
	level.dem_spawns = [];
	extra_spawns = [];
	extra_spawns[0] = "mp_dem_spawn_attacker_a";
	extra_spawns[1] = "mp_dem_spawn_attacker_b";
	extra_spawns[2] = "mp_dem_spawn_defender_a";
	extra_spawns[3] = "mp_dem_spawn_defender_b";
	i = 0;
	for(;;)
	{
		points = getentarray(extra_spawns[i],"classname");
		level.dem_spawns = arraycombine(level.dem_spawns,points,1,0);
		i++;
	}
	thread onplayerconnect();
	for(;;)
	{
		updatedevsettings();
		wait(0.5);
	}
IsDefined(points) && points.size > 0
i < extra_spawns.size
level.gametype == "dem"
GetDvar(#"316B7BEF") == ""
GetDvar(#"F8E39F40") == ""
GetDvar(#"AD911707") == ""
GetDvar(#"C0DBB722") == ""
GetDvar(#"FC880A10") == ""
GetDvar(#"8330ABEF") == ""
GetDvar(#"98F33417") == ""
GetDvar(#"472D7677") == ""
GetDvar(#"16553A29") == ""
sessionmodeiszombiesgame()
#/
}

//Function Number: 2
onplayerconnect()
{
/#
	level waittill("connecting",player);
#/
}

//Function Number: 3
updatehardpoints()
{
/#
	keys = getarraykeys(level.killstreaks);
	i = 0;
	for(;;)
	{
		dvar = level.killstreaks[keys[i]].devdvar;
		_a148 = level.players;
		_k148 = FirstArrayKey(_a148);
		for(;;)
		{
			player = _a148[_k148];
			player maps/mp/killstreaks/_killstreaks::givekillstreak(keys[i]);
			player.bot["killstreaks"] = [];
			player.bot["killstreaks"][0] = maps/mp/killstreaks/_killstreaks::getkillstreakmenuname(keys[i]);
			killstreakweapon = maps/mp/killstreaks/_killstreaks::getkillstreakweapon(keys[i]);
			player maps/mp/killstreaks/_killstreaks::givekillstreakweapon(killstreakweapon,1);
			maps/mp/gametypes/_globallogic_score::_setplayermomentum(player,2000);
			player maps/mp/killstreaks/_killstreaks::givekillstreak(keys[i]);
			_k148 = NextArrayKey(_a148);
		}
		setdvar(dvar,"0");
		i++;
	}
i < keys.size ? ((IsDefined(level.killstreaks[keys[i]].devdvar)) ? GetDvarInt(dvar) == 1 : (IsDefined(_k148) ? IsDefined(level.usingmomentum) && level.usingmomentum && IsDefined(level.usingscorestreaks) && level.usingscorestreaks : player is_bot())) : _k148
#/
}

//Function Number: 4
warpalltohost(team)
{
/#
	host = gethostplayer();
	players = get_players();
	origin = host.origin;
	nodes = getnodesinradius(origin,128,32,128,"Path");
	angles = host getplayerangles();
	yaw = (0,angles[1],0);
	forward = AnglesToForward(yaw);
	spawn_origin = 16 + VectorScale((0,0,1));
	spawn_origin = undefined;
	i = 0;
	for(;;)
	{
		players[i] setorigin(spawn_origin);
		node = random(nodes);
		players[i] setorigin(node.origin);
		players[i] setorigin(origin);
		i++;
	}
	setdvar("scr_playerwarp","");
Stack-Empty ? Stack-Empty : ((origin + forward * 128) ? bullettracepassed(host geteye(),spawn_origin,0,host) : (i < players.size ? players[i] == host : (IsDefined(team) ? team == "enemies_host" && host.team == players[i].team : ((team == "friendlies_host" && host.team != players[i].team) ? IsDefined(spawn_origin) : nodes.size > 0))))
#/
}

//Function Number: 5
updatedevsettingszm()
{
/#
	level.streamdumpteamindex = 0;
	level.streamdumpteamindex++;
	numpoints = 0;
	spawnpoints = [];
	location = level.scr_zm_map_start_location;
	location = level.default_start_location;
	match_string = level.scr_zm_ui_gametype + "_" + location;
	structs = getstructarray("initial_spawn","script_noteworthy");
	_a260 = structs;
	_k260 = FirstArrayKey(_a260);
	for(;;)
	{
		struct = _a260[_k260];
		tokens = strtok(struct.script_string," ");
		_a265 = tokens;
		_k265 = FirstArrayKey(_a265);
		for(;;)
		{
			token = _a265[_k265];
			spawnpoints[spawnpoints.size] = struct;
			_k265 = NextArrayKey(_a265);
		}
		_k260 = NextArrayKey(_a260);
	}
	spawnpoints = getstructarray("initial_spawn_points","targetname");
	numpoints = spawnpoints.size;
	setdvar("r_streamDumpDistance","0");
	level.streamdumpteamindex = -1;
	averageorigin = (0,0,0);
	averageangles = (0,0,0);
	_a294 = spawnpoints;
	_k294 = FirstArrayKey(_a294);
	for(;;)
	{
		spawnpoint = _a294[_k294];
		averageorigin = averageorigin + spawnpoint.origin / numpoints;
		averageangles = averageangles + spawnpoint.angles / numpoints;
		_k294 = NextArrayKey(_a294);
	}
	level.players[0] setplayerangles(averageangles);
	level.players[0] setorigin(averageorigin);
	wait(0.05);
	setdvar("r_streamDumpDistance","2");
numpoints == 0 ? IsDefined(_k294) : _k294
IsDefined(spawnpoints)
!IsDefined(spawnpoints) || spawnpoints.size == 0
_k260
_k265
token == match_string
IsDefined(_k265)
IsDefined(struct.script_string)
IsDefined(_k260)
IsDefined(structs)
level.streamdumpteamindex < level.teams.size
(location == "default" || location == "") && IsDefined(level.default_start_location)
(level.players.size > 0) ? GetDvar(#"7B03E923") == "3" : IsDefined(level.streamdumpteamindex)
#/
}

//Function Number: 6
updatedevsettings()
{
/#
	show_spawns = GetDvarInt(#"16553A29");
	show_start_spawns = GetDvarInt(#"472D7677");
	player = gethostplayer();
	show_spawns = 1;
	show_spawns = 0;
	show_start_spawns = 1;
	show_start_spawns = 0;
	level.show_spawns = show_spawns;
	setdvar("scr_showspawns",level.show_spawns);
	showspawnpoints();
	hidespawnpoints();
	level.show_start_spawns = show_start_spawns;
	setdvar("scr_showstartspawns",level.show_start_spawns);
	showstartspawnpoints();
	hidestartspawnpoints();
	updateminimapsetting();
	updatehardpoints();
	warpalltohost();
	warpalltohost(GetDvar(#"6A09CB73"));
	warpalltohost(GetDvar(#"6A09CB73"));
	players = get_players();
	setdvar("scr_playerwarp","");
	level.devgui_start_spawn_index = 0;
	player = gethostplayer();
	spawns = level.spawn_start[player.pers["team"]];
	return;
	i = 0;
	for(;;)
	{
		players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
		players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
		i++;
	}
	level.devgui_start_spawn_index++;
	level.devgui_start_spawn_index = 0;
	players = get_players();
	setdvar("scr_playerwarp","");
	level.devgui_start_spawn_index = 0;
	player = gethostplayer();
	spawns = level.spawn_start[player.pers["team"]];
	return;
	i = 0;
	for(;;)
	{
		players[i] setorigin(spawns[level.devgui_start_spawn_index].origin);
		players[i] setplayerangles(spawns[level.devgui_start_spawn_index].angles);
		i++;
	}
	level.devgui_start_spawn_index--;
	level.devgui_start_spawn_index = spawns.size - 1;
	players = get_players();
	setdvar("scr_playerwarp","");
	level.devgui_spawn_index = 0;
	spawns = level.spawnpoints;
	spawns = arraycombine(spawns,level.dem_spawns,1,0);
	return;
	i = 0;
	for(;;)
	{
		players[i] setorigin(spawns[level.devgui_spawn_index].origin);
		players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
		i++;
	}
	level.devgui_spawn_index++;
	level.devgui_spawn_index = 0;
	players = get_players();
	setdvar("scr_playerwarp","");
	level.devgui_spawn_index = 0;
	spawns = level.spawnpoints;
	spawns = arraycombine(spawns,level.dem_spawns,1,0);
	return;
	i = 0;
	for(;;)
	{
		players[i] setorigin(spawns[level.devgui_spawn_index].origin);
		players[i] setplayerangles(spawns[level.devgui_spawn_index].angles);
		i++;
	}
	level.devgui_spawn_index--;
	level.devgui_spawn_index = spawns.size - 1;
	player = gethostplayer();
	player.devgui_spawn_active = 0;
	iprintln("Previous spawn bound to D-Pad Left");
	iprintln("Next spawn bound to D-Pad Right");
	player.devgui_spawn_active = 1;
	player thread devgui_spawn_think();
	player notify("devgui_spawn_think",player.devgui_spawn_active,IsDefined(player.devgui_spawn_active),GetDvar(#"1F70E0F8") != "",level.devgui_spawn_index < 0,i < players.size,!IsDefined(spawns) || spawns.size <= 0,IsDefined(level.devgui_spawn_index),GetDvar(#"6A09CB73") == "prev_spawn",level.devgui_spawn_index >= spawns.size,i < players.size,!IsDefined(spawns) || spawns.size <= 0,IsDefined(level.devgui_spawn_index),GetDvar(#"6A09CB73") == "next_spawn",level.devgui_start_spawn_index < 0,i < players.size,!IsDefined(spawns) || spawns.size <= 0,IsDefined(level.devgui_start_spawn_index),GetDvar(#"6A09CB73") == "prev_start_spawn",level.devgui_start_spawn_index >= spawns.size,i < players.size,!IsDefined(spawns) || spawns.size <= 0,IsDefined(level.devgui_start_spawn_index),GetDvar(#"6A09CB73") == "next_start_spawn",GetDvar(#"6A09CB73") == "friendlies_host",GetDvar(#"6A09CB73") == "enemies_host",GetDvar(#"6A09CB73") == "host",level.players.size > 0,((Stack-Empty ? (Stack-Empty ? Stack-Empty : show_spawns >= 1) : show_start_spawns >= 1) ? !IsDefined(level.show_spawns) || level.show_spawns != show_spawns : level.show_spawns) ? !IsDefined(level.show_start_spawns) || level.show_start_spawns != show_start_spawns : level.show_start_spawns);
	player.devgui_spawn_active = 0;
	player setactionslot(3,"altMode");
	player setactionslot(4,"nightvision");
	setdvar("scr_devgui_spawn","");
	players = get_players();
	level.devgui_unlimited_ammo = 1;
	level.devgui_unlimited_ammo = !level.devgui_unlimited_ammo;
	iprintln("Giving unlimited ammo to all players");
	iprintln("Stopping unlimited ammo for all players");
	i = 0;
	for(;;)
	{
		players[i] thread devgui_unlimited_ammo();
		players[i] notify("devgui_unlimited_ammo",level.devgui_unlimited_ammo,i < players.size,Stack-Empty ? ((Stack-Empty ? Stack-Empty : Stack-Empty) ? GetDvar(#"A990D882") != "" : IsDefined(level.devgui_unlimited_ammo)) : level.devgui_unlimited_ammo);
		i++;
	}
	setdvar("scr_player_ammo","");
	level.devgui_unlimited_momentum = 1;
	level.devgui_unlimited_momentum = !level.devgui_unlimited_momentum;
	iprintln("Giving unlimited momentum to all players");
	level thread devgui_unlimited_momentum();
	iprintln("Stopping unlimited momentum for all players");
	level notify("devgui_unlimited_momentum",level.devgui_unlimited_momentum,(Stack-Empty ? Stack-Empty : Stack-Empty) ? GetDvar(#"EC01172A") != "" : IsDefined(level.devgui_unlimited_momentum));
	setdvar("scr_player_momentum","");
	level thread devgui_increase_momentum(GetDvarInt(#"ADB1B0DE"));
	setdvar("scr_give_player_score","");
	players = get_players();
	i = 0;
	for(;;)
	{
		player = players[i];
		weapons = player getweaponslist();
		arrayremovevalue(weapons,"knife_mp");
		j = 0;
		for(;;)
		{
			player setweaponammostock(weapons[j],0);
			player setweaponammoclip(weapons[j],0);
			j++;
		}
		i++;
	}
	setdvar("scr_player_zero_ammo","");
	players = get_players();
	i = 0;
	for(;;)
	{
		player = players[i];
		player setempjammed(0);
		player setempjammed(1);
		i++;
	}
	setdvar("scr_emp_jammed","");
	iprintln("Pausing Round Timer");
	maps/mp/gametypes/_globallogic_utils::pausetimer();
	iprintln("Resuming Round Timer");
	maps/mp/gametypes/_globallogic_utils::resumetimer();
	setdvar("scr_round_pause","");
	level maps/mp/gametypes/_globallogic::forceend();
	setdvar("scr_round_end","");
	players = get_players();
	host = gethostplayer();
	host.devgui_health_debug = 0;
	host.devgui_health_debug = 0;
	i = 0;
	for(;;)
	{
		players[i] notify("devgui_health_debug",i < players.size,host.devgui_health_debug,IsDefined(host.devgui_health_debug),GetDvar(#"9A7D1E68") != "",GetDvar(#"6C3088CA") != "",((GetDvar(#"C2F42DBB") != "") ? i < players.size : GetDvar(#"C2F42DBB") == "0") ? GetDvar(#"3B362771") != "" : level.timerstopped,i < players.size ? j < weapons.size : weapons[j] == "none",GetDvar(#"B3003261") != "",GetDvar(#"ADB1B0DE") != "",Stack-Empty ? Stack-Empty : Stack-Empty);
		players[i].debug_health_bar destroy();
		players[i].debug_health_text destroy();
		players[i].debug_health_bar = undefined;
		players[i].debug_health_text = undefined;
		i++;
	}
	host.devgui_health_debug = 1;
	i = 0;
	for(;;)
	{
		players[i] thread devgui_health_debug();
		i++;
	}
	setdvar("scr_health_debug","");
	level.devgui_show_hq = 0;
	i = 0;
	for(;;)
	{
		color = (1,0,0);
		level showonespawnpoint(level.radios[i],color,"hide_hq_points",32,"hq_spawn");
		i++;
	}
	level notify("hide_hq_points",i < level.radios.size,level.devgui_show_hq,level.gametype == "koth" && IsDefined(level.radios),IsDefined(level.devgui_show_hq),GetDvar(#"F8E39F40") != "",Stack-Empty ? IsDefined(players[i].debug_health_bar) : i < players.size);
	level.devgui_show_hq = !level.devgui_show_hq;
	setdvar("scr_show_hq_spawns","");
	level.streamdumpteamindex = 0;
	level.streamdumpteamindex++;
	numpoints = 0;
	teamname = getarraykeys(level.teams)[level.streamdumpteamindex];
	numpoints = level.spawn_start[teamname].size;
	setdvar("r_streamDumpDistance","0");
	level.streamdumpteamindex = -1;
	averageorigin = (0,0,0);
	averageangles = (0,0,0);
	_a761 = level.spawn_start[teamname];
	_k761 = FirstArrayKey(_a761);
	for(;;)
	{
		spawnpoint = _a761[_k761];
		averageorigin = averageorigin + spawnpoint.origin / numpoints;
		averageangles = averageangles + spawnpoint.angles / numpoints;
		_k761 = NextArrayKey(_a761);
	}
	level.players[0] setplayerangles(averageangles);
	level.players[0] setorigin(averageorigin);
	wait(0.05);
	setdvar("r_streamDumpDistance","2");
	players = get_players();
	iprintln("Taking all perks from all players");
	i = 0;
	for(;;)
	{
		players[i] clearperks();
		i++;
	}
	setdvar("scr_giveperk","");
	perk = GetDvar(#"AB757D49");
	specialties = strtok(perk,"|");
	players = get_players();
	iprintln("Giving all players perk: \'" + perk + "\'");
	i = 0;
	for(;;)
	{
		j = 0;
		for(;;)
		{
			players[i] setperk(specialties[j]);
			players[i].extraperks[specialties[j]] = 1;
			j++;
		}
		i++;
	}
	setdvar("scr_giveperk","");
	force_grenade_throw(GetDvar(#"A21C71D1"));
	setdvar("scr_forcegrenade","");
	event = GetDvar(#"B107A31D");
	player = gethostplayer();
	forward = AnglesToForward(player.angles);
	right = AnglesToRight(player.angles);
	player dodamage(1,player.origin + forward);
	player dodamage(1,player.origin - forward);
	player dodamage(1,player.origin - right);
	player dodamage(1,player.origin + right);
	setdvar("scr_forceevent","");
	perk = GetDvar(#"2952A7C3");
	i = 0;
	for(;;)
	{
		level.players[i] unsetperk(perk);
		level.players[i].extraperks[perk] = undefined;
		i++;
	}
	setdvar("scr_takeperk","");
	nametokens = strtok(GetDvar(#"5625D4BA")," ");
	thread xkillsy(nametokens[0],nametokens[1]);
	setdvar("scr_x_kills_y","");
	ownername = GetDvar(#"31F91106");
	setdvar("scr_usedogs","");
	owner = undefined;
	index = 0;
	for(;;)
	{
		owner = level.players[index];
		index++;
	}
	owner maps/mp/killstreaks/_killstreaks::triggerkillstreak("dogs_mp");
	player.pers["rank"] = 0;
	player.pers["rankxp"] = 0;
	newrank = min(GetDvarInt(#"36B7604F"),54);
	newrank = max(newrank,1);
	setdvar("scr_set_level","");
	lastxp = 0;
	index = 0;
	for(;;)
	{
		newxp = maps/mp/gametypes/_rank::getrankinfominxp(index);
		player thread maps/mp/gametypes/_rank::giverankxp("kill",newxp - lastxp);
		lastxp = newxp;
		wait(0.25);
		self notify("cancel_notify",index <= newrank,GetDvar(#"36B7604F") != "",IsDefined(owner),level.players[index].name == ownername,index < level.players.size,GetDvar(#"31F91106") != "",nametokens.size > 1,GetDvar(#"5625D4BA") != "",i < level.players.size,GetDvar(#"2952A7C3") != "",j < specialties.size ? GetDvar(#"A21C71D1") != "" : ((GetDvar(#"B107A31D") != "") ? event == "painfront" : (event == "painback" ? event == "painleft" : event == "painright")),i < players.size,GetDvar(#"AB757D49") != "",i < players.size,GetDvar(#"AB757D49") == "0",numpoints == 0 ? IsDefined(_k761) : _k761,IsDefined(level.spawn_start[teamname]),level.streamdumpteamindex < level.teams.size,(Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : (Stack-Empty ? Stack-Empty : Stack-Empty))))))))))))))))) ? GetDvar(#"7B03E923") == "3" : IsDefined(level.streamdumpteamindex));
		index++;
	}
	player thread maps/mp/gametypes/_rank::giverankxp("challenge",GetDvarInt(#"D0ABF43F"),1);
	setdvar("scr_givexp","");
	i = 0;
	for(;;)
	{
		level.players[i] maps/mp/gametypes/_hud_message::oldnotifymessage(GetDvar(#"70B3C3B7"),GetDvar(#"70B3C3B7"),game["icons"]["allies"]);
		i++;
	}
	announcement(GetDvar(#"70B3C3B7"),0);
	setdvar("scr_do_notify","");
	ents = getentarray();
	level.entarray = [];
	level.entcounts = [];
	level.entgroups = [];
	index = 0;
	for(;;)
	{
		classname = ents[index].classname;
		curent = ents[index];
		level.entarray[level.entarray.size] = curent;
		level.entcounts[classname] = 0;
		level.entcounts[classname]++;
		level.entgroups[classname] = [];
		level.entgroups[classname][level.entgroups[classname].size] = curent;
		index++;
	}
	thread larry_thread();
	level notify("kill_larry",GetDvar(#"36FAE5DF") == "0",GetDvar(#"36FAE5DF") == "1" && !IsDefined(level.larry),IsDefined(level.entgroups[classname]),IsDefined(level.entcounts[classname]),issubstr(classname,"_spawn"),index < ents.size,GetDvar(#"4F1284FA") != "",i < level.players.size,GetDvar(#"70B3C3B7") != "",GetDvar(#"D0ABF43F") != "");
	level thread bot_overlay_think();
	level.bot_overlay = 1;
	level bot_overlay_stop();
	level.bot_overlay = 0;
	level thread bot_threat_think();
	level.bot_threat = 1;
	level bot_threat_stop();
	level.bot_threat = 0;
	level thread bot_path_think();
	level.bot_path = 1;
	level bot_path_stop();
	level.bot_path = 0;
	level thread maps/mp/gametypes/_killcam::dofinalkillcam();
	level thread waitthennotifyfinalkillcam();
	level thread maps/mp/gametypes/_killcam::dofinalkillcam();
	level thread waitthennotifyroundkillcam();
	level notify("bot_dpad_terminate",!level.bot_overlay && !level.bot_threat && !level.bot_path,GetDvarInt(#"A0259FFF") == 1,GetDvarInt(#"9003F201") == 1,(((Stack-Empty ? Stack-Empty : Stack-Empty) ? level.bot_overlay == 0 && GetDvarInt(#"1CBC4852") == 1 : level.bot_overlay == 1 && GetDvarInt(#"1CBC4852") == 0) ? level.bot_threat == 0 && GetDvarInt(#"68A98D18") == 1 : level.bot_threat == 1 && GetDvarInt(#"68A98D18") == 0) ? level.bot_path == 0 && GetDvarInt(#"D6F2CC5D") == 1 : level.bot_path == 1 && GetDvarInt(#"D6F2CC5D") == 0);
#/
}

//Function Number: 7
waitthennotifyroundkillcam()
{
/#
	wait(0.05);
	level notify("play_final_killcam");
	setdvar("scr_force_roundkillcam",0);
#/
}

//Function Number: 8
waitthennotifyfinalkillcam()
{
/#
	wait(0.05);
	level notify("play_final_killcam");
	wait(0.05);
	setdvar("scr_force_finalkillcam",0);
#/
}

//Function Number: 9
devgui_spawn_think()
{
/#
	self notify("devgui_spawn_think");
	self endon("devgui_spawn_think");
	self endon("disconnect");
	dpad_left = 0;
	dpad_right = 0;
	for(;;)
	{
		self setactionslot(3,"");
		self setactionslot(4,"");
		setdvar("scr_playerwarp","prev_spawn");
		dpad_left = 1;
		dpad_left = 0;
		setdvar("scr_playerwarp","next_spawn");
		dpad_right = 1;
		dpad_right = 0;
		wait(0.05);
	}
(Stack-Empty ? !dpad_left && self buttonpressed("DPAD_LEFT") : self buttonpressed("DPAD_LEFT")) ? !dpad_right && self buttonpressed("DPAD_RIGHT") : self buttonpressed("DPAD_RIGHT")
#/
}

//Function Number: 10
devgui_unlimited_ammo()
{
/#
	self notify("devgui_unlimited_ammo");
	self endon("devgui_unlimited_ammo");
	self endon("disconnect");
	for(;;)
	{
		wait(0.1);
		weapons = [];
		weapons[0] = self getcurrentweapon();
		weapons[1] = self getcurrentoffhand();
		i = 0;
		for(;;)
		{
			self givemaxammo(weapons[i]);
			i++;
		}
	}
Stack-Empty ? Stack-Empty : (i < weapons.size ? weapons[i] == "none" : maps/mp/killstreaks/_killstreaks::iskillstreakweapon(weapons[i]))
#/
}

//Function Number: 11
devgui_unlimited_momentum()
{
/#
	level notify("devgui_unlimited_momentum");
	level endon("devgui_unlimited_momentum");
	for(;;)
	{
		wait(1);
		players = get_players();
		_a1088 = players;
		_k1088 = FirstArrayKey(_a1088);
		for(;;)
		{
			player = _a1088[_k1088];
			maps/mp/gametypes/_globallogic_score::_setplayermomentum(player,5000);
			_k1088 = NextArrayKey(_a1088);
		}
	}
_k1088
Stack-Empty ? Stack-Empty : (Stack-Empty ? IsDefined(_k1088) : (IsDefined(player) ? isalive(player) : player.sessionstate != "playing"))
#/
}

//Function Number: 12
devgui_increase_momentum(score)
{
/#
	players = get_players();
	_a1114 = players;
	_k1114 = FirstArrayKey(_a1114);
	for(;;)
	{
		player = _a1114[_k1114];
		player maps/mp/gametypes/_globallogic_score::giveplayermomentumnotification(score,&"testPlayerScoreForTan","PLAYER_SCORE",0);
		_k1114 = NextArrayKey(_a1114);
	}
_k1114
Stack-Empty ? Stack-Empty : (Stack-Empty ? IsDefined(_k1114) : (IsDefined(player) ? isalive(player) : player.sessionstate != "playing"))
#/
}

//Function Number: 13
devgui_health_debug()
{
/#
	self notify("devgui_health_debug");
	self endon("devgui_health_debug");
	self endon("disconnect");
	x = 80;
	y = 40;
	self.debug_health_bar = newclienthudelem(self);
	self.debug_health_bar.x = x + 80;
	self.debug_health_bar.y = y + 2;
	self.debug_health_bar.alignx = "left";
	self.debug_health_bar.aligny = "top";
	self.debug_health_bar.horzalign = "fullscreen";
	self.debug_health_bar.vertalign = "fullscreen";
	self.debug_health_bar.alpha = 1;
	self.debug_health_bar.foreground = 1;
	self.debug_health_bar setshader("black",1,8);
	self.debug_health_text = newclienthudelem(self);
	self.debug_health_text.x = x + 80;
	self.debug_health_text.y = y;
	self.debug_health_text.alignx = "left";
	self.debug_health_text.aligny = "top";
	self.debug_health_text.horzalign = "fullscreen";
	self.debug_health_text.vertalign = "fullscreen";
	self.debug_health_text.alpha = 1;
	self.debug_health_text.fontscale = 1;
	self.debug_health_text.foreground = 1;
	self.maxhealth = 100;
	for(;;)
	{
		wait(0.05);
		width = self.health / self.maxhealth * 300;
		width = int(max(width,1));
		self.debug_health_bar setshader("black",width,8);
		self.debug_health_text setvalue(self.health);
	}
!IsDefined(self.maxhealth) || self.maxhealth <= 0
#/
}

//Function Number: 14
giveextraperks()
{
/#
	return;
	perks = getarraykeys(self.extraperks);
	i = 0;
	for(;;)
	{
		self setperk(perks[i]);
		i++;
	}
i < perks.size
IsDefined(self.extraperks)
#/
}

//Function Number: 15
xkillsy(attackername,victimname)
{
/#
	attacker = undefined;
	victim = undefined;
	index = 0;
	for(;;)
	{
		attacker = level.players[index];
		victim = level.players[index];
		index++;
	}
	return;
	victim thread [[ level.callbackplayerdamage ]](attacker,attacker,1000,0,"MOD_RIFLE_BULLET","none",(0,0,0),(0,0,0),"none",0,0);
!isalive(attacker) || !isalive(victim)
(index < level.players.size) ? level.players[index].name == attackername : level.players[index].name == victimname
#/
}

//Function Number: 16
updateminimapsetting()
{
/#
	requiredmapaspectratio = GetDvarFloat(#"33CF364A");
	setdvar("scr_minimap_height","0");
	level.minimapheight = 0;
	minimapheight = GetDvarFloat(#"6B3B5DAF");
	gethostplayer() cameraactivate(0);
	level.minimapheight = minimapheight;
	level notify("end_draw_map_bounds",minimapheight <= 0,minimapheight != level.minimapheight,IsDefined(level.minimapheight));
	level.minimapheight = minimapheight;
	players = get_players();
	player = gethostplayer();
	corners = getentarray("minimap_corner","targetname");
	viewpos = corners[0].origin + corners[1].origin;
	viewpos = (viewpos[0] * 0.5,viewpos[1] * 0.5,viewpos[2] * 0.5);
	level thread minimapwarn(corners);
	maxcorner = (corners[0].origin[0],corners[0].origin[1],viewpos[2]);
	mincorner = (corners[0].origin[0],corners[0].origin[1],viewpos[2]);
	maxcorner = (corners[1].origin[0],maxcorner[1],maxcorner[2]);
	mincorner = (corners[1].origin[0],mincorner[1],mincorner[2]);
	maxcorner = (maxcorner[0],corners[1].origin[1],maxcorner[2]);
	mincorner = (mincorner[0],corners[1].origin[1],mincorner[2]);
	viewpostocorner = maxcorner - viewpos;
	viewpos = (viewpos[0],viewpos[1],viewpos[2] + minimapheight);
	northvector = (cos(getnorthyaw()),sin(getnorthyaw()),0);
	eastvector = (northvector[1],0 - northvector[0],0);
	disttotop = vectordot(northvector,viewpostocorner);
	disttotop = 0 - disttotop;
	disttoside = vectordot(eastvector,viewpostocorner);
	disttoside = 0 - disttoside;
	mapaspectratio = disttoside / disttotop;
	incr = requiredmapaspectratio / mapaspectratio;
	disttoside = disttoside * incr;
	addvec = vecscale(eastvector,vectordot(eastvector,maxcorner - viewpos) * incr - 1);
	mincorner = mincorner - addvec;
	maxcorner = maxcorner + addvec;
	incr = mapaspectratio / requiredmapaspectratio;
	disttotop = disttotop * incr;
	addvec = vecscale(northvector,vectordot(northvector,maxcorner - viewpos) * incr - 1);
	mincorner = mincorner - addvec;
	maxcorner = maxcorner + addvec;
	aspectratioguess = 1.777778;
	angleside = 2 * atan(disttoside * 0.8 / minimapheight);
	angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
	aspectratioguess = 1.333333;
	angleside = 2 * atan(disttoside / minimapheight);
	angletop = 2 * atan(disttotop * aspectratioguess / minimapheight);
	angle = angleside;
	angle = angletop;
	znear = minimapheight - 1000;
	znear = 16;
	znear = 10000;
	player camerasetposition(viewpos,(90,getnorthyaw(),0));
	player cameraactivate(1);
	player takeallweapons();
	setdvar("cg_drawGun",0);
	setdvar("cg_draw2D",0);
	setdvar("cg_drawFPS",0);
	setdvar("fx_enable",0);
	setdvar("r_fog",0);
	setdvar("r_highLodDist",0);
	setdvar("r_znear",znear);
	setdvar("r_lodscale",0);
	setdvar("r_lodScaleRigid",0);
	setdvar("cg_drawVersion",0);
	setdvar("sm_enable",1);
	setdvar("player_view_pitch_down",90);
	setdvar("player_view_pitch_up",0);
	setdvar("cg_fov",angle);
	setdvar("cg_fovMin",1);
	setdvar("debug_show_viewpos","0");
	i = 0;
	for(;;)
	{
		level.objpoints[level.objpointnames[i]] destroy();
		i++;
	}
	level.objpoints = [];
	level.objpointnames = [];
	thread drawminimapbounds(viewpos,mincorner,maxcorner);
	println("^1Error: There are not exactly 2 \"minimap_corner\" entities in the level.");
	setdvar("scr_minimap_height","0");
znear < 16 ? znear > 10000 : ((IsDefined(level.objpoints)) ? i < level.objpointnames.size : IsDefined(level.objpoints[level.objpointnames[i]]))
(minimapheight > 0 ? (players.size > 0 ? corners.size == 2 : corners[1].origin[0] > corners[0].origin[0]) : corners[1].origin[1] > corners[0].origin[1]) ? (disttotop < 0 ? (disttoside < 0 ? requiredmapaspectratio > 0 : mapaspectratio < requiredmapaspectratio) : level.console) : angleside > angletop
#/
}

//Function Number: 17
vecscale(vec,scalar)
{
/#
	return (vec[0] * scalar,vec[1] * scalar,vec[2] * scalar);
#/
}

//Function Number: 18
drawminimapbounds(viewpos,mincorner,maxcorner)
{
/#
	level notify("end_draw_map_bounds");
	level endon("end_draw_map_bounds");
	viewheight = viewpos[2] - maxcorner[2];
	north = (cos(getnorthyaw()),sin(getnorthyaw()),0);
	diaglen = length(mincorner - maxcorner);
	mincorneroffset = mincorner - viewpos;
	mincorneroffset = vectornormalize((mincorneroffset[0],mincorneroffset[1],0));
	mincorner = mincorner + vecscale(mincorneroffset,diaglen * 1 / 800);
	maxcorneroffset = maxcorner - viewpos;
	maxcorneroffset = vectornormalize((maxcorneroffset[0],maxcorneroffset[1],0));
	maxcorner = maxcorner + vecscale(maxcorneroffset,diaglen * 1 / 800);
	diagonal = maxcorner - mincorner;
	side = vecscale(north,vectordot(diagonal,north));
	sidenorth = vecscale(north,Abs(vectordot(diagonal,north)));
	corner0 = mincorner;
	corner1 = mincorner + side;
	corner2 = maxcorner;
	corner3 = maxcorner - side;
	toppos = vecscale(mincorner + maxcorner,0.5) + vecscale(sidenorth,0.51);
	textscale = diaglen * 0.003;
	for(;;)
	{
		line(corner0,corner1);
		line(corner1,corner2);
		line(corner2,corner3);
		line(corner3,corner0);
		print3d(toppos,"This Side Up",(1,1,1),1,textscale);
		wait(0.05);
	}
1
#/
}

//Function Number: 19
minimapwarn(corners)
{
/#
	threshold = 10;
	width = Abs(corners[0].origin[0] - corners[1].origin[0]);
	width = int(width);
	height = Abs(corners[0].origin[1] - corners[1].origin[1]);
	height = int(height);
	for(;;)
	{
		iprintln("^1Warning: Minimap corners do not form a square (width: " + width + " height: " + height + ")\n");
		scale = height / width;
		iprintln("^1Warning: The compass minimap might be scaled: " + scale + " units in height more than width\n");
		scale = width / height;
		iprintln("^1Warning: The compass minimap might be scaled: " + scale + " units in width more than height\n");
		wait(10);
	}
Stack-Empty ? Abs(width - height) > threshold : height > width
#/
}

//Function Number: 20
testscriptruntimeerrorassert()
{
/#
	wait(1);
/#
	assert(0);
#/
#/
}

//Function Number: 21
testscriptruntimeerror2()
{
/#
	myundefined = "test";
	println("undefined in testScriptRuntimeError2\n");
myundefined == 1
#/
}

//Function Number: 22
testscriptruntimeerror1()
{
/#
	testscriptruntimeerror2();
#/
}

//Function Number: 23
testscriptruntimeerror()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	myerror = GetDvar(#"316B7BEF");
	setdvar("scr_testScriptRuntimeError","0");
	testscriptruntimeerrorassert();
	testscriptruntimeerror1();
	thread testscriptruntimeerror();
Stack-Empty ? GetDvar(#"316B7BEF") != "0" : myerror == "assert"
#/
}

//Function Number: 24
testdvars()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	tokens = strtok(GetDvar(#"70EE00F9")," ");
	dvarname = tokens[0];
	dvarvalue = tokens[1];
	setdvar(dvarname,dvarvalue);
	setdvar("scr_testdvar","");
	thread testdvars();
GetDvar(#"70EE00F9") != ""
#/
}

//Function Number: 25
addtestclients()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	playsoundonplayers("vox_kls_dav_spawn");
	testclients = GetDvarInt(#"8EF43DBE");
	setdvar("scr_testclients",0);
	i = 0;
	for(;;)
	{
		ent[i] = addtestclient();
		println("Could not add test client");
		wait(1);
		ent[i].pers["isBot"] = 1;
		ent[i] thread testclient("autoassign");
		i++;
	}
	thread addtestclients();
(GetDvarInt(#"8EF43DBE") > 0) ? i < testclients : IsDefined(ent[i])
#/
}

//Function Number: 26
addenemyheli()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	enemyheli = GetDvarInt(#"A1755E55");
	setdvar("scr_spawnenemyheli",0);
	team = "autoassign";
	player = gethostplayer();
	team = getotherteam(player.pers["team"]);
	ent = getormakebot(team);
	println("Could not add test client");
	wait(1);
	thread addenemyheli();
	return;
	switch(enemyheli)
	{
		case "1":
			level.helilocation = ent.origin;
			ent thread maps/mp/killstreaks/_helicopter::usekillstreakhelicopter("helicopter_comlink_mp");
			wait(0.5);
			ent notify("confirm_location",level.helilocation);
			break;
		case "2":
			ent thread maps/mp/killstreaks/_helicopter_gunner::heli_gunner_killstreak("helicopter_player_gunner_mp");
			break;
	}
	thread addenemyheli();
IsDefined(ent)
IsDefined(player.pers["team"])
GetDvarInt(#"A1755E55") > 0
#/
}

//Function Number: 27
getormakebot(team)
{
/#
	i = 0;
	for(;;)
	{
		return level.players[i];
		i++;
	}
	ent = addtestclient();
	playsoundonplayers("vox_kls_dav_spawn");
	ent.pers["isBot"] = 1;
	ent thread testclient(team);
	wait(1);
	return ent;
IsDefined(ent)
IsDefined(level.players[i].pers["isBot"]) && level.players[i].pers["isBot"]
level.players[i].team == team
i < level.players.size
#/
}

//Function Number: 28
addenemyu2()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	type = GetDvarInt(#"23E1517A");
	setdvar("scr_spawnenemyu2",0);
	team = "autoassign";
	player = gethostplayer();
	team = getotherteam(player.team);
	ent = getormakebot(team);
	println("Could not add test client");
	wait(1);
	thread addenemyu2();
	return;
	ent thread maps/mp/killstreaks/_radar::usekillstreaksatellite("radardirection_mp");
	ent thread maps/mp/killstreaks/_radar::usekillstreakcounteruav("counteruav_mp");
	ent thread maps/mp/killstreaks/_radar::usekillstreakradar("radar_mp");
	thread addenemyu2();
(GetDvarInt(#"23E1517A") > 0) ? IsDefined(player.team) : (IsDefined(ent) ? type == 3 : type == 2)
#/
}

//Function Number: 29
addtestcarepackage()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	supplydrop = GetDvarInt(#"78762059");
	team = "autoassign";
	player = gethostplayer();
	switch(supplydrop)
	{
		case "2":
			team = getotherteam(player.pers["team"]);
			break;
		case "1":
		default:
			team = player.pers["team"];
			break;
	}
	setdvar("scr_givetestsupplydrop",0);
	ent = getormakebot(team);
	println("Could not add test client");
	wait(1);
	thread addtestcarepackage();
	return;
	ent maps/mp/killstreaks/_killstreakrules::killstreakstart("supply_drop_mp",team);
	ent thread maps/mp/killstreaks/_supplydrop::helidelivercrate(ent.origin,"supplydrop_mp",ent,team);
	thread addtestcarepackage();
IsDefined(ent)
IsDefined(player.pers["team"])
GetDvarInt(#"78762059") > 0
#/
}

//Function Number: 30
removetestclients()
{
/#
	wait(5);
	for(;;)
	{
		break;
		wait(1);
	}
	playsoundonplayers("vox_kls_dav_kill");
	removetype = GetDvarInt(#"C97483EC");
	setdvar("scr_testclientsremove",0);
	host = gethostplayer();
	players = level.players;
	i = 0;
	for(;;)
	{
		kick(players[i] getentitynumber());
		i++;
	}
	thread removetestclients();
(GetDvarInt(#"C97483EC") > 0) ? i < players.size : ((IsDefined(players[i].pers["isBot"]) && players[i].pers["isBot"] == 1) ? removetype == 2 && host.team != players[i].team : removetype == 3 && host.team == players[i].team)
#/
}

//Function Number: 31
testclient(team)
{
/#
	self endon("disconnect");
	wait(0.05);
	self notify("menuresponse",game["menu_team"],team,level.teambased,IsDefined(self.pers["team"]));
	wait(0.5);
	for(;;)
	{
		classes = maps/mp/bots/_bot::bot_build_classes();
		self notify("menuresponse","changeclass",random(classes),1);
		self waittill("spawned_player");
		wait(0.1);
	}
#/
}

//Function Number: 32
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

//Function Number: 33
showspawnpoints()
{
/#
	color = (1,1,1);
	spawn_point_index = 0;
	for(;;)
	{
		showonespawnpoint(level.spawnpoints[spawn_point_index],color,"hide_spawnpoints");
		spawn_point_index++;
	}
	i = 0;
	for(;;)
	{
		color = (0,1,0);
		showonespawnpoint(level.dem_spawns[i],color,"hide_spawnpoints");
		i++;
	}
i < level.dem_spawns.size
spawn_point_index < level.spawnpoints.size
IsDefined(level.spawnpoints)
#/
}

//Function Number: 34
hidespawnpoints()
{
/#
	level notify("hide_spawnpoints");
#/
}

//Function Number: 35
showstartspawnpoints()
{
/#
	return;
	return;
	team_colors = [];
	team_colors["axis"] = (1,0,1);
	team_colors["allies"] = (0,1,1);
	team_colors["team3"] = (1,1,0);
	team_colors["team4"] = (0,1,0);
	team_colors["team5"] = (0,0,1);
	team_colors["team6"] = (1,0.7,0);
	team_colors["team7"] = (0.25,0.25,1);
	team_colors["team8"] = (0.88,0,1);
	_a1908 = level.teams;
	_k1908 = FirstArrayKey(_a1908);
	for(;;)
	{
		team = _a1908[_k1908];
		color = team_colors[team];
		_a1912 = level.spawn_start[team];
		_k1912 = FirstArrayKey(_a1912);
		for(;;)
		{
			spawnpoint = _a1912[_k1912];
			showonespawnpoint(spawnpoint,color,"hide_startspawnpoints");
			_k1912 = NextArrayKey(_a1912);
		}
		_k1908 = NextArrayKey(_a1908);
	}
_k1908
_k1912
IsDefined(_k1912)
IsDefined(_k1908)
IsDefined(level.spawn_start)
level.teambased
#/
}

//Function Number: 36
hidestartspawnpoints()
{
/#
	level notify("hide_startspawnpoints");
#/
}

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
engagement_distance_debug_toggle()
{
/#
	level endon("kill_engage_dist_debug_toggle_watcher");
	setdvar("debug_engage_dists","0");
	laststate = GetDvarInt(#"99BAF398");
	for(;;)
	{
		currentstate = GetDvarInt(#"99BAF398");
		weapon_engage_dists_init();
		thread debug_realtime_engage_dist();
		laststate = currentstate;
		level notify("kill_all_engage_dist_debug",!dvar_turned_on(currentstate) && dvar_turned_on(laststate),dvar_turned_on(currentstate) && !dvar_turned_on(laststate),1,IsDefined(GetDvarInt(#"99BAF398")));
		laststate = currentstate;
		wait(0.3);
	}
Stack-Empty ? Stack-Empty : Stack-Empty
#/
}

//Function Number: 40
dvar_turned_on(val)
{
/#
	return 0;
	return 1;
Stack-Empty ? Stack-Empty : val <= 0
#/
}

//Function Number: 41
engagement_distance_debug_init()
{
/#
	level.debug_xpos = -50;
	level.debug_ypos = 250;
	level.debug_yinc = 18;
	level.debug_fontscale = 1.5;
	level.white = (1,1,1);
	level.green = (0,1,0);
	level.yellow = (1,1,0);
	level.red = (1,0,0);
	level.realtimeengagedist = newhudelem();
	level.realtimeengagedist.alignx = "left";
	level.realtimeengagedist.fontscale = level.debug_fontscale;
	level.realtimeengagedist.x = level.debug_xpos;
	level.realtimeengagedist.y = level.debug_ypos;
	level.realtimeengagedist.color = level.white;
	level.realtimeengagedist settext("Current Engagement Distance: ");
	xpos = level.debug_xpos + 207;
	level.realtimeengagedist_value = newhudelem();
	level.realtimeengagedist_value.alignx = "left";
	level.realtimeengagedist_value.fontscale = level.debug_fontscale;
	level.realtimeengagedist_value.x = xpos;
	level.realtimeengagedist_value.y = level.debug_ypos;
	level.realtimeengagedist_value.color = level.white;
	level.realtimeengagedist_value setvalue(0);
	xpos = xpos + 37;
	level.realtimeengagedist_middle = newhudelem();
	level.realtimeengagedist_middle.alignx = "left";
	level.realtimeengagedist_middle.fontscale = level.debug_fontscale;
	level.realtimeengagedist_middle.x = xpos;
	level.realtimeengagedist_middle.y = level.debug_ypos;
	level.realtimeengagedist_middle.color = level.white;
	level.realtimeengagedist_middle settext(" units, SHORT/LONG by ");
	xpos = xpos + 105;
	level.realtimeengagedist_offvalue = newhudelem();
	level.realtimeengagedist_offvalue.alignx = "left";
	level.realtimeengagedist_offvalue.fontscale = level.debug_fontscale;
	level.realtimeengagedist_offvalue.x = xpos;
	level.realtimeengagedist_offvalue.y = level.debug_ypos;
	level.realtimeengagedist_offvalue.color = level.white;
	level.realtimeengagedist_offvalue setvalue(0);
	hudobjarray = [];
	hudobjarray[0] = level.realtimeengagedist;
	hudobjarray[1] = level.realtimeengagedist_value;
	hudobjarray[2] = level.realtimeengagedist_middle;
	hudobjarray[3] = level.realtimeengagedist_offvalue;
	return hudobjarray;
#/
}

//Function Number: 42
engage_dist_debug_hud_destroy(hudarray,killnotify)
{
/#
	level waittill(killnotify);
	i = 0;
	for(;;)
	{
		hudarray[i] destroy();
		i++;
	}
i < hudarray.size
#/
}

//Function Number: 43
weapon_engage_dists_init()
{
/#
	level.engagedists = [];
	genericpistol = spawnstruct();
	genericpistol.engagedistmin = 125;
	genericpistol.engagedistoptimal = 225;
	genericpistol.engagedistmulligan = 50;
	genericpistol.engagedistmax = 400;
	shotty = spawnstruct();
	shotty.engagedistmin = 50;
	shotty.engagedistoptimal = 200;
	shotty.engagedistmulligan = 75;
	shotty.engagedistmax = 350;
	genericsmg = spawnstruct();
	genericsmg.engagedistmin = 100;
	genericsmg.engagedistoptimal = 275;
	genericsmg.engagedistmulligan = 100;
	genericsmg.engagedistmax = 500;
	genericlmg = spawnstruct();
	genericlmg.engagedistmin = 325;
	genericlmg.engagedistoptimal = 550;
	genericlmg.engagedistmulligan = 150;
	genericlmg.engagedistmax = 850;
	genericriflesa = spawnstruct();
	genericriflesa.engagedistmin = 325;
	genericriflesa.engagedistoptimal = 550;
	genericriflesa.engagedistmulligan = 150;
	genericriflesa.engagedistmax = 850;
	genericriflebolt = spawnstruct();
	genericriflebolt.engagedistmin = 350;
	genericriflebolt.engagedistoptimal = 600;
	genericriflebolt.engagedistmulligan = 150;
	genericriflebolt.engagedistmax = 900;
	generichmg = spawnstruct();
	generichmg.engagedistmin = 390;
	generichmg.engagedistoptimal = 600;
	generichmg.engagedistmulligan = 100;
	generichmg.engagedistmax = 900;
	genericsniper = spawnstruct();
	genericsniper.engagedistmin = 950;
	genericsniper.engagedistoptimal = 1700;
	genericsniper.engagedistmulligan = 300;
	genericsniper.engagedistmax = 3000;
	engage_dists_add("colt_mp",genericpistol);
	engage_dists_add("nambu_mp",genericpistol);
	engage_dists_add("tokarev_mp",genericpistol);
	engage_dists_add("walther_mp",genericpistol);
	engage_dists_add("thompson_mp",genericsmg);
	engage_dists_add("type100_smg_mp",genericsmg);
	engage_dists_add("ppsh_mp",genericsmg);
	engage_dists_add("mp40_mp",genericsmg);
	engage_dists_add("stg44_mp",genericsmg);
	engage_dists_add("sten_mp",genericsmg);
	engage_dists_add("sten_silenced_mp",genericsmg);
	engage_dists_add("shotgun_mp",shotty);
	engage_dists_add("bar_mp",genericlmg);
	engage_dists_add("bar_bipod_mp",genericlmg);
	engage_dists_add("type99_lmg_mp",genericlmg);
	engage_dists_add("type99_lmg_bipod_mp",genericlmg);
	engage_dists_add("dp28_mp",genericlmg);
	engage_dists_add("dp28_bipod_mp",genericlmg);
	engage_dists_add("fg42_mp",genericlmg);
	engage_dists_add("fg42_bipod_mp",genericlmg);
	engage_dists_add("bren_mp",genericlmg);
	engage_dists_add("bren_bipod_mp",genericlmg);
	engage_dists_add("m1garand_mp",genericriflesa);
	engage_dists_add("m1garand_bayonet_mp",genericriflesa);
	engage_dists_add("m1carbine_mp",genericriflesa);
	engage_dists_add("m1carbine_bayonet_mp",genericriflesa);
	engage_dists_add("svt40_mp",genericriflesa);
	engage_dists_add("gewehr43_mp",genericriflesa);
	engage_dists_add("springfield_mp",genericriflebolt);
	engage_dists_add("springfield_bayonet_mp",genericriflebolt);
	engage_dists_add("type99_rifle_mp",genericriflebolt);
	engage_dists_add("type99_rifle_bayonet_mp",genericriflebolt);
	engage_dists_add("mosin_rifle_mp",genericriflebolt);
	engage_dists_add("mosin_rifle_bayonet_mp",genericriflebolt);
	engage_dists_add("kar98k_mp",genericriflebolt);
	engage_dists_add("kar98k_bayonet_mp",genericriflebolt);
	engage_dists_add("lee_enfield_mp",genericriflebolt);
	engage_dists_add("lee_enfield_bayonet_mp",genericriflebolt);
	engage_dists_add("30cal_mp",generichmg);
	engage_dists_add("30cal_bipod_mp",generichmg);
	engage_dists_add("mg42_mp",generichmg);
	engage_dists_add("mg42_bipod_mp",generichmg);
	engage_dists_add("springfield_scoped_mp",genericsniper);
	engage_dists_add("type99_rifle_scoped_mp",genericsniper);
	engage_dists_add("mosin_rifle_scoped_mp",genericsniper);
	engage_dists_add("kar98k_scoped_mp",genericsniper);
	engage_dists_add("fg42_scoped_mp",genericsniper);
	engage_dists_add("lee_enfield_scoped_mp",genericsniper);
	level thread engage_dists_watcher();
#/
}

//Function Number: 44
engage_dists_add(weapontypestr,values)
{
/#
	level.engagedists[weapontypestr] = values;
#/
}

//Function Number: 45
get_engage_dists(weapontypestr)
{
/#
	return level.engagedists[weapontypestr];
	return undefined;
Stack-Empty ? Stack-Empty : IsDefined(level.engagedists[weapontypestr])
#/
}

//Function Number: 46
engage_dists_watcher()
{
/#
	level endon("kill_all_engage_dist_debug");
	level endon("kill_engage_dists_watcher");
	for(;;)
	{
		for(;;)
		{
			player = gethostplayer();
			playerweapon = player getcurrentweapon();
			player.lastweapon = playerweapon;
			break;
			wait(0.05);
		}
		values = get_engage_dists(playerweapon);
		level.weaponengagedistvalues = values;
		level.weaponengagedistvalues = undefined;
		player.lastweapon = playerweapon;
		wait(0.05);
	}
(IsDefined(player.lastweapon)) ? player.lastweapon == playerweapon : IsDefined(values)
1
#/
}

//Function Number: 47
debug_realtime_engage_dist()
{
/#
	level endon("kill_all_engage_dist_debug");
	level endon("kill_realtime_engagement_distance_debug");
	hudobjarray = engagement_distance_debug_init();
	level thread engage_dist_debug_hud_destroy(hudobjarray,"kill_all_engage_dist_debug");
	level.debugrtengagedistcolor = level.green;
	player = gethostplayer();
	for(;;)
	{
		lasttracepos = (0,0,0);
		direction = player getplayerangles();
		direction_vec = AnglesToForward(direction);
		eye = player geteye();
		eye = (eye[0],eye[1],eye[2] + 20);
		trace = bullettrace(eye,10000 + VectorScale(direction_vec),eye,1);
		tracepoint = trace["position"];
		tracenormal = trace["normal"];
		tracedist = int(distance(eye,tracepoint));
		lasttracepos = tracepoint;
		hudobj_changecolor(hudobjarray,level.white);
		hudobjarray engagedist_hud_changetext("nodata",tracedist);
		engagedistmin = level.weaponengagedistvalues.engagedistmin;
		engagedistoptimal = level.weaponengagedistvalues.engagedistoptimal;
		engagedistmulligan = level.weaponengagedistvalues.engagedistmulligan;
		engagedistmax = level.weaponengagedistvalues.engagedistmax;
		hudobjarray engagedist_hud_changetext("optimal",tracedist);
		hudobj_changecolor(hudobjarray,level.green);
		continue;
		hudobjarray engagedist_hud_changetext("ok",tracedist);
		hudobj_changecolor(hudobjarray,level.yellow);
		hudobj_changecolor(hudobjarray,level.red);
		hudobjarray engagedist_hud_changetext("short",tracedist);
		hudobj_changecolor(hudobjarray,level.red);
		hudobjarray engagedist_hud_changetext("long",tracedist);
		thread plot_circle_fortime(1,5,0.05,level.debugrtengagedistcolor,tracepoint,tracenormal);
		thread plot_circle_fortime(1,1,0.05,level.debugrtengagedistcolor,tracepoint,tracenormal);
		wait(0.05);
	}
player ? tracepoint != lasttracepos : ((IsDefined(level.weaponengagedistvalues)) ? tracedist >= engagedistmin && tracedist <= engagedistmax : ((tracedist >= engagedistoptimal - engagedistmulligan && tracedist <= engagedistoptimal + engagedistmulligan) ? tracedist < engagedistmin : tracedist > engagedistmax))
1
#/
}

//Function Number: 48
hudobj_changecolor(hudobjarray,newcolor)
{
/#
	i = 0;
	for(;;)
	{
		hudobj = hudobjarray[i];
		hudobj.color = newcolor;
		level.debugrtengagedistcolor = newcolor;
		i++;
	}
hudobj.color != newcolor
i < hudobjarray.size
#/
}

//Function Number: 49
engagedist_hud_changetext(engagedisttype,units)
{
/#
	level.lastdisttype = "none";
	self[1] setvalue(units);
	self[2] settext("units: OPTIMAL!");
	self[3].alpha = 0;
	self[1] setvalue(units);
	self[2] settext("units: OK!");
	self[3].alpha = 0;
	amountunder = level.weaponengagedistvalues.engagedistmin - units;
	self[1] setvalue(units);
	self[3] setvalue(amountunder);
	self[3].alpha = 1;
	self[2] settext("units: SHORT by ");
	amountover = units - level.weaponengagedistvalues.engagedistmax;
	self[1] setvalue(units);
	self[3] setvalue(amountover);
	self[3].alpha = 1;
	self[2] settext("units: LONG by ");
	self[1] setvalue(units);
	self[2] settext(" units: (NO CURRENT WEAPON VALUES)");
	self[3].alpha = 0;
	level.lastdisttype = engagedisttype;
Stack-Empty ? IsDefined(level.lastdisttype) : ((engagedisttype == "optimal") ? engagedisttype == "ok" : ((engagedisttype == "short") ? level.lastdisttype != engagedisttype : ((engagedisttype == "long") ? level.lastdisttype != engagedisttype : engagedisttype == "nodata")))
#/
}

//Function Number: 50
plot_circle_fortime(radius1,radius2,time,color,origin,normal)
{
/#
	color = (0,1,0);
	hangtime = 0.05;
	circleres = 6;
	hemires = circleres / 2;
	circleinc = 360 / circleres;
	circleres++;
	plotpoints = [];
	rad = 0;
	timer = GetTime() + time * 1000;
	radius = radius1;
	for(;;)
	{
		radius = radius2;
		angletoplayer = VectorToAngles(normal);
		i = 0;
		for(;;)
		{
			plotpoints[plotpoints.size] = radius + VectorScale(AnglesToForward(angletoplayer + (rad,90,0)));
			rad = rad + circleinc;
			i++;
		}
		maps/mp/_utility::plot_points(plotpoints,color[0],color[1],color[2],hangtime);
		plotpoints = [];
		wait(hangtime);
	}
origin
i < circleres
GetTime() < timer
IsDefined(color)
#/
}

//Function Number: 51
larry_thread()
{
/#
	setdvar("bot_AllowMovement","0");
	setdvar("bot_PressAttackBtn","0");
	setdvar("bot_PressMeleeBtn","0");
	level.larry = spawnstruct();
	player = gethostplayer();
	player thread larry_init(level.larry);
	level waittill("kill_larry");
	larry_hud_destroy(level.larry);
	level.larry.model delete();
	i = 0;
	for(;;)
	{
		kick(level.larry.ai[i] getentitynumber());
		i++;
	}
	level.larry = undefined;
i < level.larry.ai.size
IsDefined(level.larry.ai)
IsDefined(level.larry.model)
#/
}

//Function Number: 52
larry_init(larry)
{
/#
	level endon("kill_larry");
	larry_hud_init(larry);
	larry.model = spawn("script_model",(0,0,0));
	larry.model setmodel("defaultactor");
	larry.ai = [];
	wait(0.1);
	for(;;)
	{
		wait(0.05);
		larry.model hide();
		continue;
		direction = self getplayerangles();
		direction_vec = AnglesToForward(direction);
		eye = self geteye();
		trace = bullettrace(eye,8000 + VectorScale(direction_vec),eye,0);
		dist = distance(eye,trace["position"]);
		position = dist - 64 + VectorScale(direction_vec);
		larry.model.origin = position;
		larry.model.angles = 180 + VectorScale((0,1,0));
		self larry_ai(larry);
		wait(0.05);
	}
self usebuttonpressed()
self usebuttonpressed()
self.angles
eye
undefined
larry.ai.size > 0
#/
}

//Function Number: 53
larry_ai(larry)
{
/#
	larry.ai[larry.ai.size] = addtestclient();
	i = larry.ai.size - 1;
	larry.ai[i].pers["isBot"] = 1;
	larry.ai[i] thread testclient("autoassign");
	larry.ai[i] thread larry_ai_thread(larry,larry.model.origin,larry.model.angles);
	larry.ai[i] thread larry_ai_damage(larry);
	larry.ai[i] thread larry_ai_health(larry);
#/
}

//Function Number: 54
larry_ai_thread(larry,origin,angles)
{
/#
	level endon("kill_larry");
	for(;;)
	{
		self waittill("spawned_player");
		larry.menu[larry.menu_health] setvalue(self.health);
		larry.menu[larry.menu_damage] settext("");
		larry.menu[larry.menu_range] settext("");
		larry.menu[larry.menu_hitloc] settext("");
		larry.menu[larry.menu_weapon] settext("");
		larry.menu[larry.menu_perks] settext("");
		self setorigin(origin);
		self setplayerangles(angles);
		self clearperks();
	}
#/
}

//Function Number: 55
larry_ai_damage(larry)
{
/#
	level endon("kill_larry");
	for(;;)
	{
		self waittill("damage",damage,attacker,dir,point);
		continue;
		player = gethostplayer();
		continue;
		eye = player geteye();
		range = int(distance(eye,point));
		larry.menu[larry.menu_health] setvalue(self.health);
		larry.menu[larry.menu_damage] setvalue(damage);
		larry.menu[larry.menu_range] setvalue(range);
		larry.menu[larry.menu_hitloc] settext(self.cac_debug_location);
		larry.menu[larry.menu_hitloc] settext("<unknown>");
		larry.menu[larry.menu_weapon] settext(self.cac_debug_weapon);
		continue;
		larry.menu[larry.menu_weapon] settext("<unknown>");
	}
IsDefined(attacker) ? (IsDefined(player) ? attacker != player : IsDefined(self.cac_debug_location)) : IsDefined(self.cac_debug_weapon)
#/
}

//Function Number: 56
larry_ai_health(larry)
{
/#
	level endon("kill_larry");
	for(;;)
	{
		wait(0.05);
		larry.menu[larry.menu_health] setvalue(self.health);
	}
#/
}

//Function Number: 57
larry_hud_init(larry)
{
/#
	x = -45;
	y = 275;
	menu_name = "larry_menu";
	larry.hud = new_hud(menu_name,undefined,x,y,1);
	larry.hud setshader("white",135,65);
	larry.hud.alignx = "left";
	larry.hud.aligny = "top";
	larry.hud.sort = 10;
	larry.hud.alpha = 0.6;
	larry.hud.color = VectorScale((0,0,1));
	larry.menu[0] = new_hud(menu_name,"Larry Health:",x + 5,y + 10,1);
	larry.menu[1] = new_hud(menu_name,"Damage:",x + 5,y + 20,1);
	larry.menu[2] = new_hud(menu_name,"Range:",x + 5,y + 30,1);
	larry.menu[3] = new_hud(menu_name,"Hit Location:",x + 5,y + 40,1);
	larry.menu[4] = new_hud(menu_name,"Weapon:",x + 5,y + 50,1);
	larry.cleartextmarker = newdebughudelem();
	larry.cleartextmarker.alpha = 0;
	larry.cleartextmarker settext("marker");
	larry.menu_health = larry.menu.size;
	larry.menu_damage = larry.menu.size + 1;
	larry.menu_range = larry.menu.size + 2;
	larry.menu_hitloc = larry.menu.size + 3;
	larry.menu_weapon = larry.menu.size + 4;
	larry.menu_perks = larry.menu.size + 5;
	x_offset = 70;
	larry.menu[larry.menu_health] = new_hud(menu_name,"",x + x_offset,y + 10,1);
	larry.menu[larry.menu_damage] = new_hud(menu_name,"",x + x_offset,y + 20,1);
	larry.menu[larry.menu_range] = new_hud(menu_name,"",x + x_offset,y + 30,1);
	larry.menu[larry.menu_hitloc] = new_hud(menu_name,"",x + x_offset,y + 40,1);
	larry.menu[larry.menu_weapon] = new_hud(menu_name,"",x + x_offset,y + 50,1);
	larry.menu[larry.menu_perks] = new_hud(menu_name,"",x + x_offset,y + 60,1);
0.5
#/
}

//Function Number: 58
larry_hud_destroy(larry)
{
/#
	larry.hud destroy();
	i = 0;
	for(;;)
	{
		larry.menu[i] destroy();
		i++;
	}
	larry.cleartextmarker destroy();
i < larry.menu.size
IsDefined(larry.hud)
#/
}

//Function Number: 59
new_hud(hud_name,msg,x,y,scale)
{
/#
	level.hud_array = [];
	level.hud_array[hud_name] = [];
	hud = set_hudelem(msg,x,y,scale);
	level.hud_array[hud_name][level.hud_array[hud_name].size] = hud;
	return hud;
IsDefined(level.hud_array[hud_name])
IsDefined(level.hud_array)
#/
}

//Function Number: 60
set_hudelem(text,x,y,scale,alpha,sort,debug_hudelem)
{
/#
	alpha = 1;
	scale = 1;
	sort = 20;
	hud = newdebughudelem();
	hud.debug_hudelem = 1;
	hud.location = 0;
	hud.alignx = "left";
	hud.aligny = "middle";
	hud.foreground = 1;
	hud.fontscale = scale;
	hud.sort = sort;
	hud.alpha = alpha;
	hud.x = x;
	hud.y = y;
	hud.og_scale = scale;
	hud settext(text);
	return hud;
IsDefined(text)
IsDefined(sort)
IsDefined(scale)
IsDefined(alpha)
#/
}

//Function Number: 61
watch_botsdvars()
{
/#
	hasplayerweaponprev = GetDvarInt(#"98F33417");
	grenadesonlyprev = GetDvarInt(#"8330ABEF");
	secondarygrenadesonlyprev = GetDvarInt(#"FC880A10");
	for(;;)
	{
		hasplayerweaponprev = GetDvarInt(#"98F33417");
		iprintlnbold("LARRY has player weapon: ON");
		iprintlnbold("LARRY has player weapon: OFF");
		grenadesonlyprev = GetDvarInt(#"8330ABEF");
		iprintlnbold("LARRY using grenades only: ON");
		iprintlnbold("LARRY using grenades only: OFF");
		secondarygrenadesonlyprev = GetDvarInt(#"FC880A10");
		iprintlnbold("LARRY using secondary grenades only: ON");
		iprintlnbold("LARRY using secondary grenades only: OFF");
		wait(1);
	}
((1 ? hasplayerweaponprev != GetDvarInt(#"98F33417") : hasplayerweaponprev) ? grenadesonlyprev != GetDvarInt(#"8330ABEF") : grenadesonlyprev) ? secondarygrenadesonlyprev != GetDvarInt(#"FC880A10") : secondarygrenadesonlyprev
#/
}

//Function Number: 62
getattachmentchangemodifierbutton()
{
/#
	return "BUTTON_X";
#/
}

//Function Number: 63
watchattachmentchange()
{
/#
	self endon("disconnect");
	clientnum = self getentitynumber();
	return;
	dpad_left = 0;
	dpad_right = 0;
	dpad_up = 0;
	dpad_down = 0;
	lstick_down = 0;
	dpad_modifier_button = getattachmentchangemodifierbutton();
	for(;;)
	{
		self giveweaponnextattachment("muzzle");
		dpad_left = 1;
		self thread print_weapon_name();
		self giveweaponnextattachment("trigger");
		dpad_right = 1;
		self thread print_weapon_name();
		self giveweaponnextattachment("top");
		dpad_up = 1;
		self thread print_weapon_name();
		self giveweaponnextattachment("bottom");
		dpad_down = 1;
		self thread print_weapon_name();
		self giveweaponnextattachment("gunperk");
		lstick_down = 1;
		self thread print_weapon_name();
		dpad_left = 0;
		dpad_right = 0;
		dpad_up = 0;
		dpad_down = 0;
		lstick_down = 0;
		wait(0.05);
	}
self buttonpressed("BUTTON_LSTICK")
self buttonpressed("DPAD_DOWN")
self buttonpressed("DPAD_UP")
self buttonpressed("DPAD_RIGHT")
self buttonpressed("DPAD_LEFT")
!lstick_down && self buttonpressed("BUTTON_LSTICK")
!dpad_down && self buttonpressed("DPAD_DOWN")
!dpad_up && self buttonpressed("DPAD_UP")
!dpad_right && self buttonpressed("DPAD_RIGHT")
!dpad_left && self buttonpressed("DPAD_LEFT")
self buttonpressed(dpad_modifier_button)
clientnum != 0
#/
}

//Function Number: 64
print_weapon_name()
{
/#
	self notify("print_weapon_name");
	self endon("print_weapon_name");
	wait(0.2);
	self waittill(self isswitchingweapons(),"weapon_change_complete",weapon_name);
	fail_safe = 0;
	for(;;)
	{
		self waittill(weapon_name == "none","weapon_change_complete",weapon_name);
		wait(0.05);
		fail_safe++;
		break;
	}
	weapon_name = self getcurrentweapon();
	printweaponname = getdvarintdefault("scr_print_weapon_name",1);
	iprintlnbold(weapon_name);
printweaponname
Stack-Empty ? Stack-Empty : fail_safe > 120
#/
}

//Function Number: 65
set_equipment_list()
{
/#
	return;
	level.dev_equipment = [];
	level.dev_equipment[1] = "acoustic_sensor_mp";
	level.dev_equipment[2] = "camera_spike_mp";
	level.dev_equipment[3] = "claymore_mp";
	level.dev_equipment[4] = "satchel_charge_mp";
	level.dev_equipment[5] = "scrambler_mp";
	level.dev_equipment[6] = "tactical_insertion_mp";
	level.dev_equipment[7] = "bouncingbetty_mp";
	level.dev_equipment[8] = "trophy_system_mp";
	level.dev_equipment[9] = "pda_hack_mp";
IsDefined(level.dev_equipment)
#/
}

//Function Number: 66
set_grenade_list()
{
/#
	return;
	level.dev_grenade = [];
	level.dev_grenade[1] = "frag_grenade_mp";
	level.dev_grenade[2] = "sticky_grenade_mp";
	level.dev_grenade[3] = "hatchet_mp";
	level.dev_grenade[4] = "willy_pete_mp";
	level.dev_grenade[5] = "proximity_grenade_mp";
	level.dev_grenade[6] = "flash_grenade_mp";
	level.dev_grenade[7] = "concussion_grenade_mp";
	level.dev_grenade[8] = "nightingale_mp";
	level.dev_grenade[9] = "emp_grenade_mp";
	level.dev_grenade[10] = "sensor_grenade_mp";
IsDefined(level.dev_grenade)
#/
}

//Function Number: 67
take_all_grenades_and_equipment(player)
{
/#
	i = 0;
	for(;;)
	{
		player takeweapon(level.dev_equipment[i + 1]);
		i++;
	}
	i = 0;
	for(;;)
	{
		player takeweapon(level.dev_grenade[i + 1]);
		i++;
	}
i < level.dev_grenade.size
i < level.dev_equipment.size
#/
}

//Function Number: 68
equipment_dev_gui()
{
/#
	set_equipment_list();
	set_grenade_list();
	setdvar("scr_give_equipment","");
	for(;;)
	{
		wait(0.5);
		devgui_int = GetDvarInt(#"A0215B8E");
		i = 0;
		for(;;)
		{
			take_all_grenades_and_equipment(level.players[i]);
			level.players[i] giveweapon(level.dev_equipment[devgui_int]);
			i++;
		}
		setdvar("scr_give_equipment","0");
	}
i < level.players.size
devgui_int != 0
1
#/
}

//Function Number: 69
grenade_dev_gui()
{
/#
	set_equipment_list();
	set_grenade_list();
	setdvar("scr_give_grenade","");
	for(;;)
	{
		wait(0.5);
		devgui_int = GetDvarInt(#"227BB8EC");
		i = 0;
		for(;;)
		{
			take_all_grenades_and_equipment(level.players[i]);
			level.players[i] giveweapon(level.dev_grenade[devgui_int]);
			i++;
		}
		setdvar("scr_give_grenade","0");
	}
i < level.players.size
devgui_int != 0
1
#/
}

//Function Number: 70
force_grenade_throw(weapon)
{
/#
	setdvar("bot_AllowMovement","0");
	setdvar("bot_PressAttackBtn","0");
	setdvar("bot_PressMeleeBtn","0");
	setdvar("scr_botsAllowKillstreaks","0");
	host = gethostplayer();
	iprintln("Unable to determine host player team");
	return;
	bot = getormakebot(getotherteam(host.team));
	iprintln("Could not add test client");
	return;
	angles = host getplayerangles();
	angles = (0,angles[1],0);
	dir = AnglesToForward(angles);
	dir = vectornormalize(dir);
	origin = 256 + VectorScale(dir);
	velocity = VectorScale(dir);
	grenade = bot magicgrenade(weapon,origin,velocity);
	grenade setteam(bot.team);
	grenade setowner(bot);
-1024
host geteye()
IsDefined(bot)
IsDefined(host.team)
#/
}

//Function Number: 71
bot_dpad_think()
{
/#
	level notify("bot_dpad_stop");
	level endon("bot_dpad_stop");
	level endon("bot_dpad_terminate");
	level.bot_index = 0;
	host = gethostplayer();
	for(;;)
	{
		wait(0.5);
		host = gethostplayer();
		level.bot_index = 0;
	}
	dpad_left = 0;
	dpad_right = 0;
	for(;;)
	{
		wait(0.05);
		host setactionslot(3,"");
		host setactionslot(4,"");
		players = get_players();
		max = players.size;
		level.bot_index--;
		level.bot_index = max - 1;
		continue;
		dpad_left = 1;
		dpad_left = 0;
		level.bot_index++;
		level.bot_index = 0;
		continue;
		dpad_right = 1;
		dpad_right = 0;
		level notify("bot_index_changed",(level.bot_index >= max) ? players[level.bot_index] is_bot() : host buttonpressed("DPAD_RIGHT"),!dpad_right && host buttonpressed("DPAD_RIGHT"),level.bot_index < 0 ? players[level.bot_index] is_bot() : host buttonpressed("DPAD_LEFT"),!dpad_left && host buttonpressed("DPAD_LEFT"),IsDefined(host),IsDefined(level.bot_index));
	}
#/
}

//Function Number: 72
bot_overlay_think()
{
/#
	level endon("bot_overlay_stop");
	level thread bot_dpad_think();
	iprintln("Previous Bot bound to D-Pad Left");
	iprintln("Next Bot bound to D-Pad Right");
	for(;;)
	{
		setdvar("bot_Debug",level.bot_index);
		level waittill(GetDvarInt(#"C0935AD0") != level.bot_index,"bot_index_changed");
	}
#/
}

//Function Number: 73
bot_threat_think()
{
/#
	level endon("bot_threat_stop");
	level thread bot_dpad_think();
	iprintln("Previous Bot bound to D-Pad Left");
	iprintln("Next Bot bound to D-Pad Right");
	for(;;)
	{
		setdvar("bot_DebugThreat",level.bot_index);
		level waittill(GetDvarInt(#"3DB0D1F8") != level.bot_index,"bot_index_changed");
	}
#/
}

//Function Number: 74
bot_path_think()
{
/#
	level endon("bot_path_stop");
	level thread bot_dpad_think();
	iprintln("Previous Bot bound to D-Pad Left");
	iprintln("Next Bot bound to D-Pad Right");
	for(;;)
	{
		setdvar("bot_DebugPaths",level.bot_index);
		level waittill(GetDvarInt(#"F20E8150") != level.bot_index,"bot_index_changed");
	}
#/
}

//Function Number: 75
bot_overlay_stop()
{
/#
	level notify("bot_overlay_stop");
	setdvar("bot_Debug","-1");
#/
}

//Function Number: 76
bot_path_stop()
{
/#
	level notify("bot_path_stop");
	setdvar("bot_DebugPaths","-1");
#/
}

//Function Number: 77
bot_threat_stop()
{
/#
	level notify("bot_threat_stop");
	setdvar("bot_DebugThreat","-1");
#/
}

//Function Number: 78
devstraferunpathdebugdraw()
{
/#
	white = (1,1,1);
	red = (1,0,0);
	green = (0,1,0);
	blue = (0,0,1);
	violet = (0.4,0,0.6);
	maxdrawtime = 10;
	drawtime = maxdrawtime;
	origintextoffset = VectorScale((0,0,-1));
	endonmsg = "devStopStrafeRunPathDebugDraw";
	for(;;)
	{
		for(;;)
		{
			nodes = [];
			end = 0;
			node = getvehiclenode("warthog_start","targetname");
			println("No strafe run path found");
			setdvar("scr_devStrafeRunPathDebugDraw","0");
		}
		for(;;)
		{
			new_node = getvehiclenode(node.target,"targetname");
			_a3325 = nodes;
			_k3325 = FirstArrayKey(_a3325);
			for(;;)
			{
				n = _a3325[_k3325];
				end = 1;
				_k3325 = NextArrayKey(_a3325);
			}
			textscale = 30;
			node thread drawpathsegment(new_node,violet,violet,1,textscale,origintextoffset,drawtime,endonmsg);
			textscale = 10;
			switch(node.script_noteworthy)
			{
				case "strafe_start":
					textcolor = green;
					textalpha = 1;
					break;
				case "strafe_stop":
					textcolor = red;
					textalpha = 1;
					break;
				case "strafe_leave":
					textcolor = white;
					textalpha = 1;
					break;
			}
			switch(node.script_noteworthy)
			{
				case "strafe_leave":
				case "strafe_start":
				case "strafe_stop":
					sides = 10;
					radius = 100;
					sphere(node.origin,radius,textcolor,textalpha,1,sides,drawtime * 1000);
					node draworiginlines();
					node drawnoteworthytext(textcolor,textalpha,textscale);
					break;
			drawtime == maxdrawtime
					break;
			}
			break;
			nodes[nodes.size] = new_node;
			node = new_node;
		}
		drawtime = drawtime - 0.05;
		drawtime = maxdrawtime;
		wait(0.05);
		continue;
		wait(1);
	}
drawtime < 0
end
IsDefined(node.script_noteworthy)
drawtime == maxdrawtime
_k3325
n == new_node
IsDefined(_k3325)
IsDefined(node.target)
IsDefined(node)
GetDvarInt(#"AD911707") > 0
1
50
#/
}

//Function Number: 79
devhelipathdebugdraw()
{
/#
	white = (1,1,1);
	red = (1,0,0);
	green = (0,1,0);
	blue = (0,0,1);
	textcolor = white;
	textalpha = 1;
	textscale = 1;
	maxdrawtime = 10;
	drawtime = maxdrawtime;
	origintextoffset = VectorScale((0,0,-1));
	endonmsg = "devStopHeliPathsDebugDraw";
	for(;;)
	{
		script_origins = getentarray("script_origin","classname");
		_a3424 = script_origins;
		_k3424 = FirstArrayKey(_a3424);
		for(;;)
		{
			ent = _a3424[_k3424];
			switch(ent.targetname)
			{
				case "heli_start":
					textcolor = blue;
					textalpha = 1;
					textscale = 3;
					break;
				case "heli_loop_start":
					textcolor = green;
					textalpha = 1;
					textscale = 3;
					break;
				case "heli_attack_area":
					textcolor = red;
					textalpha = 1;
					textscale = 3;
					break;
				case "heli_leave":
					textcolor = white;
					textalpha = 1;
					textscale = 3;
					break;
			}
			switch(ent.targetname)
			{
				case "heli_attack_area":
				case "heli_leave":
				case "heli_loop_start":
				case "heli_start":
					ent thread drawpath(textcolor,white,textalpha,textscale,origintextoffset,drawtime,endonmsg);
					ent draworiginlines();
					ent drawtargetnametext(textcolor,textalpha,textscale);
					ent draworigintext(textcolor,textalpha,textscale,origintextoffset);
					break;
			drawtime == maxdrawtime
					break;
			}
			_k3424 = NextArrayKey(_a3424);
		}
		drawtime = drawtime - 0.05;
		drawtime = maxdrawtime;
		level notify(endonmsg,GetDvarInt(#"C0DBB722") == 0,drawtime < 0,_k3424,IsDefined(ent.targetname),IsDefined(_k3424),GetDvarInt(#"C0DBB722") > 0,1,50);
		drawtime = maxdrawtime;
		wait(1);
		wait(0.05);
	}
#/
}

//Function Number: 80
draworiginlines()
{
/#
	red = (1,0,0);
	green = (0,1,0);
	blue = (0,0,1);
	line(self.origin,self.origin + AnglesToForward(self.angles) * 10,red);
	line(self.origin,self.origin + AnglesToRight(self.angles) * 10,green);
	line(self.origin,self.origin + AnglesToUp(self.angles) * 10,blue);
#/
}

//Function Number: 81
drawtargetnametext(textcolor,textalpha,textscale,textoffset)
{
/#
	textoffset = (0,0,0);
	print3d(self.origin + textoffset,self.targetname,textcolor,textalpha,textscale);
IsDefined(textoffset)
#/
}

//Function Number: 82
drawnoteworthytext(textcolor,textalpha,textscale,textoffset)
{
/#
	textoffset = (0,0,0);
	print3d(self.origin + textoffset,self.script_noteworthy,textcolor,textalpha,textscale);
IsDefined(textoffset)
#/
}

//Function Number: 83
draworigintext(textcolor,textalpha,textscale,textoffset)
{
/#
	textoffset = (0,0,0);
	originstring = "(" + self.origin[0] + ", " + self.origin[1] + ", " + self.origin[2] + ")";
	print3d(self.origin + textoffset,originstring,textcolor,textalpha,textscale);
IsDefined(textoffset)
#/
}

//Function Number: 84
drawspeedacceltext(textcolor,textalpha,textscale,textoffset)
{
/#
	print3d(self.origin + (0,0,textoffset[2] * 2),"script_airspeed:" + self.script_airspeed,textcolor,textalpha,textscale);
	print3d(self.origin + (0,0,textoffset[2] * 3),"script_accel:" + self.script_accel,textcolor,textalpha,textscale);
IsDefined(self.script_accel)
IsDefined(self.script_airspeed)
#/
}

//Function Number: 85
drawpath(linecolor,textcolor,textalpha,textscale,textoffset,drawtime,endonmsg)
{
/#
	level endon(endonmsg);
	ent = self;
	entfirsttarget = ent.targetname;
	for(;;)
	{
		enttarget = getent(ent.target,"targetname");
		ent thread drawpathsegment(enttarget,linecolor,textcolor,textalpha,textscale,textoffset,drawtime,endonmsg);
		entfirsttarget = ent.target;
		break;
		ent = enttarget;
		wait(0.05);
	}
(IsDefined(ent.target)) ? ent.targetname == "heli_loop_start" : ent.target == entfirsttarget
#/
}

//Function Number: 86
drawpathsegment(enttarget,linecolor,textcolor,textalpha,textscale,textoffset,drawtime,endonmsg)
{
/#
	level endon(endonmsg);
	for(;;)
	{
		print3d(self.origin + textoffset,self.targetname,textcolor,textalpha,textscale);
		line(self.origin,enttarget.origin,linecolor);
		self drawspeedacceltext(textcolor,textalpha,textscale,textoffset);
		drawtime = drawtime - 0.05;
		wait(0.05);
	}
IsDefined(self.targetname) && self.targetname == "warthog_start"
drawtime > 0
#/
}

//Function Number: 87
get_lookat_origin(player)
{
/#
	angles = player getplayerangles();
	forward = AnglesToForward(angles);
	dir = VectorScale(forward);
	eye = player geteye();
	trace = bullettrace(eye,eye + dir,0,undefined);
	return trace["position"];
8000
#/
}

//Function Number: 88
draw_pathnode(node,color)
{
/#
	color = (1,0,1);
	box(node.origin,VectorScale((-1,-1,0)),16,VectorScale((1,1,1)),16,0,color,1);
0
1
IsDefined(color)
#/
}

//Function Number: 89
draw_pathnode_think(node,color)
{
/#
	level endon("draw_pathnode_stop");
	for(;;)
	{
		draw_pathnode(node,color);
		wait(0.05);
	}
#/
}

//Function Number: 90
draw_pathnodes_stop()
{
/#
	wait(5);
	level notify("draw_pathnode_stop");
#/
}

//Function Number: 91
node_get(player)
{
/#
	for(;;)
	{
		wait(0.05);
		origin = get_lookat_origin(player);
		node = getnearestnode(origin);
		continue;
		return node;
		return undefined;
		draw_pathnode(node,(1,0,1));
		continue;
		draw_pathnode(node,(0.85,0.85,0.1));
	}
node.type == "Path"
IsDefined(node) ? player buttonpressed("BUTTON_A") : player buttonpressed("BUTTON_B")
#/
}

//Function Number: 92
dev_get_node_pair()
{
/#
	player = gethostplayer();
	start = undefined;
	for(;;)
	{
		start = node_get(player);
		level notify("draw_pathnode_stop",player buttonpressed("BUTTON_B"),IsDefined(start));
		return undefined;
	}
	level thread draw_pathnode_think(start,(0,1,0));
	wait(0.05);
	end = undefined;
	for(;;)
	{
		end = node_get(player);
		level notify("draw_pathnode_stop",player buttonpressed("BUTTON_B"),IsDefined(end),player buttonpressed("BUTTON_A"));
		return undefined;
	}
	level thread draw_pathnode_think(end,(0,1,0));
	level thread draw_pathnodes_stop();
	array = [];
	array[0] = start;
	array[1] = end;
	return array;
#/
}