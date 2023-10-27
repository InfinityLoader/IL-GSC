/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 136 ms
 * Timestamp: 10/27/2023 2:25:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.splitscreen = issplitscreen();
	level.ps3 = getdvar("ps3Game") == "true";
	level.xenon = getdvar("xenonGame") == "true";
	level.console = level.ps3 || level.xenon;
	level.onlinegame = getdvarint("onlinegame");
	level.rankedmatch = !level.onlinegame || !getdvarint("xblive_privatematch");
	level.script = tolower(getdvar("mapname"));
	level.gametype = tolower(getdvar("g_gametype"));
	level.otherteam["allies"] = "axis";
	level.otherteam["axis"] = "allies";
	level.teambased = 0;
	level.objectivebased = 0;
	level.endgameontimelimit = 1;
	level.showingfinalkillcam = 0;
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
	level.halftimesubcaption = &"MP_SWITCHING_SIDES";
	level.laststatustime = 0;
	level.waswinning = "none";
	level.lastslowprocessframe = 0;
	level.placement["allies"] = [];
	level.placement["axis"] = [];
	level.placement["all"] = [];
	level.postroundtime = 5;
	level.playerslookingforsafespawn = [];
	func_3456();
	precachemodel("vehicle_mig29_desert");
	precachemodel("projectile_cbu97_clusterbomb");
	precachemodel("tag_origin");
	level.fx_airstrike_afterburner = loadfx("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx("smoke/jet_contrail");
	if(maps\mp\_utility::matchmakinggame())
	{
		var_00 = " LB_MAP_" + getdvar("ui_mapname");
		var_01 = " LB_GM_" + level.gametype;
		if(getdvarint("g_hardcore"))
		{
			var_01 = var_01 + "_HC";
		}

		precacheleaderboards("LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES" + var_01 + var_00);
	}

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
}

//Function Number: 2
func_3456()
{
	makedvarserverinfo("ui_bomb_timer",0);
	makedvarserverinfo("ui_nuke_end_milliseconds",0);
	makedvarserverinfo("ui_danger_team","");
	makedvarserverinfo("ui_inhostmigration",0);
	makedvarserverinfo("ui_override_halftime",0);
	makedvarserverinfo("camera_thirdPerson",getdvarint("scr_thirdPerson"));
}

//Function Number: 3
setupcallbacks()
{
	level.onxpevent = ::onxpevent;
	level.getspawnpoint = ::blank;
	level.onspawnplayer = ::blank;
	level.onrespawndelay = ::blank;
	level.ontimelimit = ::maps\mp\gametypes\_gamelogic::func_2EEF;
	level.onhalftime = ::maps\mp\gametypes\_gamelogic::func_2EF0;
	level.ondeadevent = ::maps\mp\gametypes\_gamelogic::default_ondeadevent;
	level.ononeleftevent = ::maps\mp\gametypes\_gamelogic::func_2EED;
	level.onprecachegametype = ::blank;
	level.onstartgametype = ::blank;
	level.onplayerkilled = ::blank;
	level.autoassign = ::maps\mp\gametypes\_menus::menuautoassign;
	level.spectator = ::maps\mp\gametypes\_menus::func_2AE8;
	level.class = ::maps\mp\gametypes\_menus::func_2AEA;
	level.allies = ::maps\mp\gametypes\_menus::menuallies;
	level.axis = ::maps\mp\gametypes\_menus::func_2AE7;
}

//Function Number: 4
blank(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 5
func_3458()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait 10;
		var_00 = spawnstruct();
		var_00.titletext = &"MP_CHALLENGE_COMPLETED";
		var_00.notifytext = "wheee";
		var_00.sound = "mp_challenge_complete";
		thread maps\mp\gametypes\_hud_message::func_EBE(var_00);
	}
}

//Function Number: 6
func_3459()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		wait 3;
		var_00 = randomint(6);
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			iprintlnbold(var_00);
			self shellshock("frag_grenade_mp",0.2);
			wait 0.1;
		}
	}
}

//Function Number: 7
onxpevent(param_00)
{
	thread maps\mp\gametypes\_rank::func_2AB3(param_00);
}

//Function Number: 8
fakelag()
{
	self endon("disconnect");
	self.fakelag = randomintrange(50,150);
	for(;;)
	{
		self setclientdvar("fakelag_target",self.fakelag);
		wait randomfloatrange(5,15);
	}
}

//Function Number: 9
debugline(param_00,param_01)
{
	for(var_02 = 0;var_02 < 50;var_02++)
	{
		wait 0.05;
	}
}