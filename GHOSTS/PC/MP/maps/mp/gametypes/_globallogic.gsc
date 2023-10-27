/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 195 ms
 * Timestamp: 10/27/2023 1:18:22 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.splitscreen = issplitscreen();
	maps\mp\_utility::set_console_status();
	level.onlinegame = getdvarint("onlinegame");
	level.rankedmatch = (level.onlinegame && !getdvarint("xblive_privatematch")) || getdvarint("force_ranking");
	level.script = tolower(getdvar("mapname"));
	level.gametype = tolower(getdvar("g_gametype"));
	level.teamnamelist = ["axis","allies"];
	level.otherteam["allies"] = "axis";
	level.otherteam["axis"] = "allies";
	level.multiteambased = 0;
	level.teambased = 0;
	level.objectivebased = 0;
	level.endgameontimelimit = 1;
	level.showingfinalkillcam = 0;
	level.tispawndelay = getdvarint("scr_tispawndelay");
	if(!isdefined(level.tweakablesinitialized))
	{
		maps\mp\gametypes\_tweakables::func_44DF();
	}

	level.halftimetype = "halftime";
	level.laststatustime = 0;
	level.waswinning = "none";
	level.lastslowprocessframe = 0;
	level.placement["allies"] = [];
	level.placement["axis"] = [];
	level.placement["all"] = [];
	level.postroundtime = 5;
	level.playerslookingforsafespawn = [];
	func_6468();
	if(maps\mp\_utility::func_50C1())
	{
		var_00 = " LB_MAP_" + getdvar("ui_mapname");
		var_01 = "";
		var_02 = "";
		if(issquadsmode())
		{
			if(getdvarint("squad_match"))
			{
				var_01 = " LB_GM_SQUAD_ASSAULT";
				level thread func_9136();
			}
			else if(level.gametype == "horde")
			{
				var_01 = " LB_GM_HORDE";
			}
		}
		else
		{
			var_02 = "LB_GB_TOTALXP_AT LB_GB_TOTALXP_LT LB_GB_WINS_AT LB_GB_WINS_LT LB_GB_KILLS_AT LB_GB_KILLS_LT LB_GB_ACCURACY_AT LB_ACCOLADES";
			var_01 = " LB_GM_" + level.gametype;
			if(getdvarint("g_hardcore"))
			{
				var_01 = var_01 + "_HC";
			}
		}

		precacheleaderboards(var_02 + var_01 + var_00);
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
	var_03 = 9;
	func_4573(var_03);
}

//Function Number: 2
func_9136()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		if(var_00 ishost())
		{
			var_01 = var_00;
			break;
		}
	}

	var_01 waittill("disconnect");
	thread maps\mp\gametypes\_gamelogic::endgame("draw",game["end_reason"]["host_ended_game"]);
}

//Function Number: 3
func_4573(param_00)
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

//Function Number: 4
func_6468()
{
	setomnvar("ui_bomb_timer",0);
	if(getdvar("r_reflectionProbeGenerate") != "1")
	{
		setomnvar("ui_nuke_end_milliseconds",0);
	}

	setdvar("ui_danger_team","");
	setdvar("ui_inhostmigration",0);
	setdvar("ui_override_halftime",0);
	setdvar("camera_thirdPerson",getdvarint("scr_thirdPerson"));
}

//Function Number: 5
func_71F0()
{
	level.onxpevent = ::onxpevent;
	level.getspawnpoint = ::blank;
	level.var_5976 = ::blank;
	level.onrespawndelay = ::blank;
	level.ontimelimit = ::maps\mp\gametypes\_gamelogic::func_24A3;
	level.onhalftime = ::maps\mp\gametypes\_gamelogic::func_24A1;
	level.ondeadevent = ::maps\mp\gametypes\_gamelogic::default_ondeadevent;
	level.ononeleftevent = ::maps\mp\gametypes\_gamelogic::default_ononeleftevent;
	level.onprecachegametype = ::blank;
	level.onstartgametype = ::blank;
	level.onplayerkilled = ::blank;
	level.killstreakinit = ::maps\mp\killstreaks\_killstreaks_init::func_44DF;
	level.matcheventsinit = ::maps\mp\_matchevents::func_44DF;
	level.intelinit = ::maps\mp\gametypes\_intel::func_44DF;
}

//Function Number: 6
blank(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 7
func_8058()
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
		thread maps\mp\gametypes\_hud_message::func_5729(var_00);
	}
}

//Function Number: 8
func_8059()
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
	thread maps\mp\gametypes\_rank::giverankxp(param_00);
}

//Function Number: 10
func_2422(param_00,param_01)
{
	for(var_02 = 0;var_02 < 50;var_02++)
	{
		wait(0.05);
	}
}