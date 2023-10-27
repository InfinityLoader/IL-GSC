/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 144 ms
 * Timestamp: 10/27/2023 2:41:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.splitscreen = issplitscreen();
	level.ps3 = getdvar("ps3Game") == "true";
	level.xenon = getdvar("xenonGame") == "true";
	level.console = getdvar("consoleGame") == "true";
	level.onlinegame = isonlinegame();
	level.rankedmatch = level.onlinegame && !getdvarint("xblive_privatematch");
	level.script = tolower(getdvar("mapname"));
	if(getdvarint("virtualLobbyActive",0))
	{
		level.gametype = "vlobby";
	}
	else
	{
		level.gametype = tolower(getdvar("g_gametype"));
	}

	level.teamnamelist = ["axis","allies"];
	level.otherteam["allies"] = "axis";
	level.otherteam["axis"] = "allies";
	level.multiteambased = 0;
	level.teambased = 0;
	level.objectivebased = 0;
	level.endgameontimelimit = 1;
	level.showingfinalkillcam = 0;
	level.classicgamemode = 0;
	level.disablesprint = 0;
	level.killstreak_kills = 1;
	level.tispawndelay = getdvarint("scr_tispawndelay");
	if(!isdefined(level.tweakablesinitialized))
	{
		maps\mp\gametypes\_tweakables::init();
	}

	precachestring(&"MP_HALFTIME");
	precachestring(&"MP_OVERTIME");
	precachestring(&"MP_ROUNDEND");
	precachestring(&"MP_INTERMISSION");
	precachestring(&"MP_SWITCHING_SIDES");
	precachestring(&"MP_FRIENDLY_FIRE_WILL_NOT");
	precachestring(&"MP_SUICIDE_PUNISHED");
	precachestring(&"PLATFORM_REVIVE");
	precachestring(&"MP_OBITUARY_NEUTRAL");
	precachestring(&"MP_OBITUARY_FRIENDLY");
	precachestring(&"MP_OBITUARY_ENEMY");
	if(level.splitscreen)
	{
		precachestring(&"MP_ENDED_GAME");
	}
	else
	{
		precachestring(&"MP_HOST_ENDED_GAME");
	}

	level.halftimetype = "halftime";
	level.halftimeonscorelimit = 0;
	level.halftimeonscorelimitsettimetobeat = 1;
	level.laststatustime = 0;
	level.waswinning = "none";
	level.lastslowprocessframe = 0;
	level.placement["allies"] = [];
	level.placement["axis"] = [];
	level.placement["all"] = [];
	level.postroundtime = 5;
	level.playerslookingforsafespawn = [];
	registerdvars();
	precachemodel("tag_origin");
	level.teamcount["allies"] = 0;
	level.teamcount["axis"] = 0;
	level.teamcount["spectator"] = 0;
	level.alivecount["allies"] = 0;
	level.alivecount["axis"] = 0;
	level.alivecount["spectator"] = 0;
	level.livescount["allies"] = 0;
	level.livescount["axis"] = 0;
	level.onelefttime = [];
	level.hasspawned["allies"] = 0;
	level.hasspawned["axis"] = 0;
	var_00 = 9;
	init_multiteamdata(var_00);
}

//Function Number: 2
init_multiteamdata(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		var_02 = "team_" + var_01;
		level.placement[var_02] = [];
		level.teamcount[var_02] = 0;
		level.alivecount[var_02] = 0;
		level.livescount[var_02] = 0;
		level.hasspawned[var_02] = 0;
	}
}

//Function Number: 3
registerdvars()
{
	setomnvar("ui_bomb_timer",0);
	setomnvar("ui_nuke_end_milliseconds",0);
	setdvar("ui_danger_team","");
	setdvar("ui_inhostmigration",0);
	setdvar("camera_thirdPerson",getdvarint("scr_thirdPerson"));
}

//Function Number: 4
setupcallbacks()
{
	level.onxpevent = ::onxpevent;
	level.getspawnpoint = ::blank;
	level.onspawnplayer = ::blank;
	level.onrespawndelay = ::blank;
	level.ontimelimit = ::maps\mp\gametypes\_gamelogic::default_ontimelimit;
	level.onhalftime = ::maps\mp\gametypes\_gamelogic::default_onhalftime;
	level.ondeadevent = ::maps\mp\gametypes\_gamelogic::default_ondeadevent;
	level.ononeleftevent = ::maps\mp\gametypes\_gamelogic::default_ononeleftevent;
	level.onprecachegametype = ::blank;
	level.onstartgametype = ::blank;
	level.onplayerkilled = ::blank;
	level.autoassign = ::maps\mp\gametypes\_menus::autoassign;
}

//Function Number: 5
gethostplayer()
{
	return maps\mp\gametypes\_gamelogic::gethostplayer();
}

//Function Number: 6
blank(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 7
testmenu()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(10);
		var_00 = spawnstruct();
		var_00.titletext = &"MP_CHALLENGE_COMPLETED";
		var_00.notifytext = "wheee";
		var_00.sound = "mp_challenge_complete";
		thread maps\mp\gametypes\_hud_message::notifymessage(var_00);
	}
}

//Function Number: 8
testshock()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait(3);
		var_00 = randomint(6);
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			iprintlnbold(var_00);
			self shellshock("frag_grenade_mp",0.2);
			wait(0.1);
		}
	}
}

//Function Number: 9
onxpevent(param_00)
{
	level thread maps\mp\gametypes\_rank::awardgameevent(param_00,self);
}

//Function Number: 10
debugline(param_00,param_01)
{
	for(var_02 = 0;var_02 < 50;var_02++)
	{
		wait(0.05);
	}
}