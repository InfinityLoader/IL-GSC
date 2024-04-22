/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_zombies.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 655 ms
 * Timestamp: 4/22/2024 2:09:48 AM
*******************************************************************/

//Function Number: 1
initzombies()
{
	precacherumble("dna_carpet_bomb");
	level.zombieweapons = getentarray("zombie_weapon","targetname");
	foreach(var_01 in level.zombieweapons)
	{
		var_01 hide();
		var_01 makeunusable();
	}
}

//Function Number: 2
runhordezombies()
{
	level.zombiesstarted = 1;
	level.hordedronetype = "vehicle_atlas_assault_drone";
	level.dnadronelocs = common_scripts\utility::getstructarray("dna_locs","targetname");
	level.interiordnadrones = getentarray("dna_drone_interior","targetname");
	level.dnadrones = [];
	level.dronesatgoal = 0;
	thread zombiespatchclip();
	foreach(var_01 in level.players)
	{
		level thread zombiepreloadweapons(var_01);
		var_01 setdemigod(1);
	}

	wait(3);
	disablekillstreaks();
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.changingweapon) && maps\mp\_utility::iskillstreakweapon(var_01.changingweapon))
		{
			if(var_01.changingweapon == "killstreak_predator_missile_mp" || var_01.changingweapon == "orbital_laser_fov_mp")
			{
				while(!var_01 maps\mp\_utility::isusingremote())
				{
					wait 0.05;
				}
			}
			else
			{
				var_01 switchtoweapon(var_01.hordeclassweapons[var_01 getclientomnvar("ui_horde_player_class")]["primary"]);
			}
		}

		if(isdefined(var_01.enteringgoliath))
		{
			while(isdefined(var_01.enteringgoliath))
			{
				wait(0.05);
			}
		}

		if(isdefined(var_01.iscarrying) && var_01.iscarrying)
		{
			var_01 notify("force_cancel_placement");
		}
	}

	foreach(var_06 in level.hordesentryarray)
	{
		if(isdefined(var_06))
		{
			var_06 notify("death");
		}
	}

	foreach(var_09 in level.carepackages)
	{
		var_09 maps\mp\killstreaks\_airdrop::deletecrate();
	}

	thread zombiesdisablearmories();
	thread zombiesdestroykillstreaks();
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_hide_hints_hud",1);
	}

	level thread zombiesmusic();
	level thread hordednaexplosion();
	preloadcinematicforall("coop_outro");
	level thread monitorgameended();
}

//Function Number: 3
disablekillstreaks()
{
	foreach(var_01 in level.players)
	{
		for(var_02 = 1;var_02 <= var_01.currentkillstreaks.size;var_02++)
		{
			if(var_01.pers["killstreaks"][var_02].available == 1)
			{
				var_01 thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(var_01.currentkillstreaks[var_02],var_01,var_01.lastkillstreakmodules,var_02,0);
			}
		}

		var_03 = 5;
		if(level.console || var_01 common_scripts\utility::is_player_gamepad_enabled())
		{
			var_03 = 1;
		}

		for(var_02 = 0;var_02 < var_03;var_02++)
		{
			var_01 maps\mp\_utility::_setactionslot(var_02 + 4,"");
			var_01.actionslotenabled[var_02] = 0;
		}

		var_01 setclientomnvar("ks_count1",0);
		var_01 setclientomnvar("ks_count_updated",1);
	}
}

//Function Number: 4
monitorgameended()
{
	level waittill("game_ended");
	stopcinematicforall("coop_outro");
}

//Function Number: 5
hordednaexplosion()
{
	level endon("game_ended");
	level thread startexteriordnadrones();
	foreach(var_01 in level.interiordnadrones)
	{
		level thread startinteriordnadrones(var_01);
	}

	wait(2);
	foreach(var_04 in level.players)
	{
		level thread droneswarmaudio(var_04);
	}

	maps\mp\_utility::leaderdialogonplayers("coop_gdn_sensorsareshowingmanticore",level.players,"horde");
	wait(3);
	level waittill("dna_explode");
	for(var_06 = 1;var_06 < level.dnadrones.size + 1;var_06++)
	{
		level thread startdnadronelights(level.dnadrones[var_06]);
	}

	wait(3);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_hitthedeck",level.players,"horde");
	for(var_06 = 1;var_06 < level.dnadrones.size + 1;var_06++)
	{
		level thread stopdnadronelights(level.dnadrones[var_06]);
	}

	wait(0.5);
	thread dnadronesexplode();
	wait(1);
	thread dnablackout_moveplayers_off_roof();
	foreach(var_04 in level.players)
	{
		var_04 thread dnablackout();
		var_04 maps\mp\_utility::playerallowdodge(1,"class");
		var_04 maps\mp\_utility::playerallowhighjumpdrop(1,"class");
		var_04 maps\mp\_utility::playerallowhighjump(1,"class");
		var_04 maps\mp\_utility::playerallowpowerslide(1,"class");
		var_04 maps\mp\_utility::playerallowdodge(0,"zombie");
		var_04 maps\mp\_utility::playerallowhighjumpdrop(0,"zombie");
		var_04 maps\mp\_utility::playerallowhighjump(0,"zombie");
		var_04 maps\mp\_utility::playerallowpowerslide(0,"zombie");
		var_04.weapondmgmod = 1;
		var_04 maps\mp\_utility::_clearperks();
		var_04.horde_perks = [];
		var_04.lastperks = [];
		var_04 maps\mp\_utility::giveperk("specialty_pistoldeath",0);
		var_04 maps\mp\_utility::giveperk("specialty_horde_dualprimary",1,1);
	}

	level.players[0] thread play_backout_sound_heartbeat();
	level waittill("blackout_done");
	foreach(var_0A in level.zombieweapons)
	{
		var_0A show();
		var_0A makeusable();
		var_0A hudoutlineenable(4,1);
		var_0A thread zombieweaponpickup();
	}

	activateclientexploder(60);
	foreach(var_0D in level.hordedome)
	{
		var_0D hide();
	}

	foreach(var_04 in level.players)
	{
		var_04 takeallweapons();
		var_04 setclientomnvar("ui_horde_zombie_hud",1);
		var_04 setclientomnvar("ui_hide_hints_hud",0);
		if(isdefined(var_04.hasselfrevive))
		{
			var_04.hasselfrevive = 0;
		}

		var_04 setdemigod(0);
		var_04.maxhealth = var_04.classsettings["support"]["classhealth"];
		var_04.health = var_04.maxhealth;
		var_04.movespeedscaler = 1.1;
	}

	level notify("zombie_go_night");
	wait(2.2);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_teamreportstatus",level.players,"horde");
	wait(6);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_alliedforcesthisisgideon",level.players,"horde");
	wait(5);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_isanyoneoutthere",level.players,"horde");
	wait(8);
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_welcomebackteam",level.players,"horde");
	thread func_4136();
	thread maps\mp\gametypes\_horde_dialog::zombiedialog();
	thread zombiewavesequence();
	thread zombieincreasewavecount();
}

//Function Number: 6
startinteriordnadrones(param_00)
{
	level endon("game_ended");
	wait(5);
	playfxontag(level._effect["bagh_dna_bomb_drone_loop"],param_00,"tag_origin");
	wait(0.25);
	var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
	param_00 moveto(var_01.origin,1,0.2,0.5);
	param_00 thread dnadronereachedgoal(var_01);
	var_02 = int(param_00.script_parameters);
	level.dnadrones[var_02][level.dnadrones[var_02].size] = param_00;
}

//Function Number: 7
startexteriordnadrones()
{
	level endon("game_ended");
	foreach(var_01 in level.dnadronelocs)
	{
		var_02 = spawn("script_model",var_01.origin + (0,0,6000));
		var_02 setmodel("sentinel_survey_drone_sphere_ai_swarm");
		var_02.drone_travel_time = randomfloatrange(7.5,9);
		var_02 moveto(var_01.origin,var_02.drone_travel_time,0.5,0.2);
		var_02 thread dnadronereachedgoal(var_01);
		var_03 = int(var_01.script_parameters);
		var_04 = bullettrace(var_01.origin,var_01.origin + (0,0,6001),0,undefined,0,0,0,0,1);
		if(isdefined(var_04["glass"]))
		{
			var_05 = calculate_break_time(var_02,var_04["position"]);
			thread dnadronebreakprisonglass(var_05,var_04["glass"]);
		}

		if(!isdefined(level.dnadrones[var_03]))
		{
			level.dnadrones[var_03] = [];
		}

		level.dnadrones[var_03][level.dnadrones[var_03].size] = var_02;
	}
}

//Function Number: 8
startdnadronelights(param_00)
{
	level endon("game_ended");
	foreach(var_02 in param_00)
	{
		playfxontag(level._effect["bagh_dna_bomb_drone_loop"],var_02,"tag_origin");
	}
}

//Function Number: 9
stopdnadronelights(param_00)
{
	level endon("game_ended");
	foreach(var_02 in param_00)
	{
		killfxontag(level._effect["bagh_dna_bomb_drone_loop"],var_02,"tag_origin");
	}
}

//Function Number: 10
func_4136()
{
	level endon("game_ended");
	level.extractionloc = getent("zombie_extraction","targetname");
	var_00 = getent("zombie_outro","targetname");
	level waittill("start_extraction");
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("ui_hide_hud",0);
	}

	maps\mp\gametypes\horde::sethudtimer("escape_time",40);
	if(getdvarint("horde_nozombieoutro") < 1)
	{
		var_00 thread hordestartzombieoutro();
	}

	maps\mp\_utility::leaderdialogonplayers("coop_gdn_iaminboundwithanextraction",level.players,"horde");
	thread maps\mp\gametypes\_horde_dialog::extraction_nag_lines();
	var_04 = maps\mp\gametypes\_gameobjects::getnextobjid();
	level.extractionloc.objid = var_04;
	objective_add(var_04,"active",level.extractionloc.origin);
	foreach(var_02 in level.players)
	{
		level.extractionloc.headicon = level.extractionloc maps\mp\_entityheadicons::setheadicon(var_02,"waypoint_extraction",(0,0,0),4,4,undefined,undefined,0,1,undefined,0);
	}

	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(40);
	maps\mp\gametypes\horde::clearhudtimer();
	if(!isdefined(level.zombiescompleted))
	{
		maps\mp\gametypes\_horde_laststand::hordeendgame("extraction_failed");
	}
}

//Function Number: 11
zombiewavesequence()
{
	level endon("game_ended");
	while(level.enemiesleft > 85)
	{
		wait(0.25);
	}

	wait(randomfloatrange(1,3));
	maps\mp\_utility::leaderdialogonplayers("coop_gdn_exosarebackupuseboostjump",level.players,"horde");
	foreach(var_01 in level.players)
	{
		var_01 maps\mp\_utility::playerallowdodge(1,"zombie");
		var_01 maps\mp\_utility::playerallowhighjumpdrop(1,"zombie");
		var_01 maps\mp\_utility::playerallowhighjump(1,"zombie");
		var_01 maps\mp\_utility::playerallowpowerslide(1,"zombie");
	}

	while(level.enemiesleft > 60)
	{
		wait(0.25);
	}

	level notify("start_extraction");
}

//Function Number: 12
zombieincreasewavecount()
{
	level endon("game_ended");
	level endon("start_extraction");
	for(;;)
	{
		wait(20);
		level notify("go_zombie");
		level.maxaliveenemycount = min(20,level.maxaliveenemycount + 2);
	}
}

//Function Number: 13
dnadronereachedgoal(param_00)
{
	level endon("game_ended");
	self endon("death");
	while(distance(self.origin,param_00.origin) > 16)
	{
		wait(0.1);
	}

	level.dronesatgoal++;
	if(level.dronesatgoal == level.dnadronelocs.size)
	{
		level notify("dna_explode");
	}

	var_01 = self.origin;
	for(;;)
	{
		var_02 = (0,0,randomintrange(16,24));
		var_03 = (0,0,randomintrange(-24,-16));
		self moveto(var_01 + var_02,1,0.3,0.3);
		wait(1);
		self moveto(var_01 + var_03,1,0.3,0.3);
		wait(1);
	}
}

//Function Number: 14
dnadronesexplode()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 playsound("bagh_dna_bombs_main");
		var_01 playsound("dna_bomb_gas_start");
		var_01 playrumbleonentity("dna_carpet_bomb");
		var_01 setclienttriggervisionset("mp_prison_z_zombiefog",1);
		level thread dnaexplosionscreenshake(var_01);
	}

	for(var_03 = 1;var_03 < level.dnadrones.size + 1;var_03++)
	{
		level thread dnadroneexplode(level.dnadrones[var_03]);
	}
}

//Function Number: 15
dnadroneexplode(param_00)
{
	level endon("game_ended");
	foreach(var_02 in param_00)
	{
		wait(randomfloatrange(0.1,0.2));
		playfx(level._effect["bagh_dna_bomb_explode"],var_02.origin);
		var_02 delete();
	}
}

//Function Number: 16
dnaexplosionscreenshake(param_00)
{
	earthquake(1,1,param_00.origin,9999);
	wait(1.2);
	earthquake(0.7,1,param_00.origin,9999);
	wait(1.4);
	earthquake(0.5,1,param_00.origin,9999);
}

//Function Number: 17
dnablackout()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.blackoutoverlay))
	{
		self.blackoutoverlay = newclienthudelem(self);
		self.blackoutoverlay.x = 0;
		self.blackoutoverlay.y = 0;
		self.blackoutoverlay setshader("black",640,480);
		self.blackoutoverlay.alignx = "left";
		self.blackoutoverlay.aligny = "top";
		self.blackoutoverlay.horzalign = "fullscreen";
		self.blackoutoverlay.vertalign = "fullscreen";
		self.blackoutoverlay.alpha = 0;
	}

	wait(1);
	self freezecontrols(1);
	self disableweapons();
	self disableoffhandweapons();
	self disableoffhandsecondaryweapons();
	self setstance("prone");
	self allowstand(0);
	self allowcrouch(0);
	self allowmelee(0);
	self allowsprint(0);
	thread play_backout_sound_breath();
	self.blackoutoverlay hordefadeinblackout(2,1);
	level notify("blackout_done");
	wait(16);
	self.blackoutoverlay thread hordefadeoutblackout(5,0);
	self freezecontrols(0);
	wait(4);
	self allowmelee(1);
	self allowstand(1);
	self allowcrouch(1);
	self setstance("stand");
	wait(0.65);
	self allowsprint(1);
	self enableweapons();
	self giveweapon("iw5_titan45_mp_xmags");
	self switchtoweaponimmediate("iw5_titan45_mp_xmags");
	thread zombiegivemaxammo();
	wait(0.5);
	level notify("end_blackout_sounds");
}

//Function Number: 18
finalblackout(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	param_00.blackoutoverlay hordefadeinblackout(1,1);
	param_00 freezecontrols(1);
	param_00 setdemigod(1);
	param_00 setclientomnvar("ui_hide_hud",1);
}

//Function Number: 19
play_backout_sound_heartbeat()
{
	maps\mp\_audio::snd_play_loop_in_space("zombie_fadeout_heartbeat",self.origin,"end_blackout_sounds",2);
}

//Function Number: 20
play_backout_sound_breath()
{
	level endon("end_blackout_sounds");
	level endon("game_ended");
	self endon("disconnect");
	var_00 = check_player_gender();
	var_01 = undefined;
	if(maps\mp\killstreaks\_juggernaut::get_is_in_mech())
	{
		return;
	}

	switch(var_00)
	{
		case 0:
			var_01 = "deaths_door_mp_male";
			break;

		case 1:
			var_01 = "deaths_door_mp_female";
			break;

		default:
			break;
	}

	for(;;)
	{
		self playsoundtoplayer(var_01,self);
		wait(1.6);
	}
}

//Function Number: 21
hordestartzombieoutro()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(maps\mp\gametypes\_horde_util::isonhumanteam(var_00) && isplayer(var_00))
		{
			foreach(var_02 in level.players)
			{
				level thread finalblackout(var_02);
			}

			maps\mp\_utility::_objective_delete(level.extractionloc.objid);
			level.zombiescompleted = 1;
			setdvar("cg_drawCrosshair",0);
			level notify("zombies_ended");
			wait(1);
			foreach(var_02 in level.players)
			{
				level.extractionloc maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
			}

			if(isdefined(level.extractionloc.headicon))
			{
				level.extractionloc.headicon destroy();
			}

			foreach(var_02 in level.players)
			{
				var_02.ignoreme = 1;
			}

			wait(1);
			thread outro_horde_cleanup();
			playcinematicforall("coop_outro",1);
			foreach(var_02 in level.players)
			{
				var_02 giveachievement("COOP_UNDEAD_SURVIVOR");
			}

			break;
		}

		wait(0.05);
	}

	wait(55);
	stopcinematicforall("coop_outro");
	foreach(var_02 in level.players)
	{
		if(!var_02 gethordeplayerdata("requirement_beatenZombies"))
		{
			var_02 sethordeplayerdata("requirement_beatenZombies",1);
			var_02 setclientomnvar("ui_hide_hud",0);
			var_02 setclientomnvar("ui_horde_zombie_hud",1);
			var_02 setclientomnvar("ui_horde_loot_unlocked",1);
		}
	}

	wait(3);
	maps\mp\gametypes\_horde_laststand::hordeendgame("zombies_completed");
}

//Function Number: 22
hordefadeinblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}

//Function Number: 23
hordefadeoutblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}

//Function Number: 24
zombiegivemaxammo()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(5);
		self givemaxammo("iw5_titan45_mp_xmags",1);
	}
}

//Function Number: 25
hordezombiesounds()
{
	thread hordezombiechasesounds();
	thread hordezombiedeathsounds();
	thread hordezombiepainsounds();
}

//Function Number: 26
hordezombiechasesounds()
{
	self endon("death");
	level endon("game_ended");
	level endon("zombies_ended");
	for(;;)
	{
		while(!isdefined(self.enemy))
		{
			wait(0.25);
		}

		while(isdefined(self.enemy) && distance(self.origin,self.enemy.origin) > 200)
		{
			wait(randomfloatrange(4,8));
			self playsound("zombie_screech");
		}

		wait(0.05);
	}
}

//Function Number: 27
hordezombiepainsounds()
{
	level endon("game_ended");
	level endon("zombies_ended");
	self endon("death");
	for(;;)
	{
		self waittill("damage");
		if(!isdefined(self.playing_pain_sound))
		{
			childthread hordezombieplaypainsound(1.5);
		}

		wait(0.05);
	}
}

//Function Number: 28
hordezombiedeathsounds()
{
	level endon("game_ended");
	level endon("zombies_ended");
	self waittill("death");
	waittillframeend;
	self playsound("zombie_death");
}

//Function Number: 29
hordezombieplaypainsound(param_00)
{
	self playsound("zombie_pain");
	self.playing_pain_sound = 1;
	wait(param_00);
	self.playing_pain_sound = undefined;
}

//Function Number: 30
zombieweaponpickup()
{
	level endon("game_ended");
	self waittill("trigger",var_00);
	if(isdefined(self.script_parameters))
	{
		var_01 = weaponclipsize(self.script_parameters);
		var_00 setweaponammostock(self.script_parameters,500);
		var_00 setweaponammoclip(self.script_parameters,var_01);
	}
}

//Function Number: 31
zombiesdisablearmories()
{
	level endon("game_ended");
	foreach(var_01 in level.hordearmories)
	{
		foreach(var_03 in level.players)
		{
			var_01 maps\mp\_entityheadicons::setheadicon("none","",(0,0,0));
			var_03 setclientomnvar("ui_horde_show_armory",0);
			var_03 enableusability();
		}

		if(isdefined(var_01.headicon))
		{
			var_01.headicon destroy();
		}

		maps\mp\_utility::_objective_delete(var_01.objectiveindex);
		var_01 hudoutlinedisable();
		foreach(var_06 in var_01.monitors)
		{
			var_06 hudoutlinedisable();
		}

		var_01 makeunusable();
	}
}

//Function Number: 32
zombiesdestroykillstreaks()
{
	level endon("game_ended");
	var_00 = "MOD_EXPLOSIVE";
	var_01 = "killstreak_emp_mp";
	var_02 = 5000;
	var_03 = level.players[0];
	foreach(var_05 in level.orbital_lasers)
	{
		var_05 notify("death",var_03,var_00,var_01);
		wait(0.05);
	}

	var_07 = common_scripts\utility::array_combine(level.ugvs,level.uavmodels["allies"]);
	var_07 = common_scripts\utility::array_combine(var_07,level.turrets);
	var_07 = common_scripts\utility::array_combine(var_07,level.helis);
	var_07 = common_scripts\utility::array_combine(var_07,level.planes);
	var_07 = common_scripts\utility::array_combine(var_07,level.littlebirds);
	if(isdefined(level.orbitalsupport_planemodel))
	{
		var_07[var_07.size] = level.orbitalsupport_planemodel;
	}

	foreach(var_09 in var_07)
	{
		var_02 = var_09.maxhealth + 1;
		var_09 dodamage(var_02,var_09.origin,var_03,var_03,var_00,var_01);
		wait(0.05);
	}

	foreach(var_0C in level.players)
	{
		if(isdefined(var_0C.missileweapon) && isdefined(var_0C.rocket))
		{
			var_0C.rocket setdamagecallbackon(0);
			var_0C.missileweapon notify("ms_early_exit");
			var_0C.rocket maps\mp\killstreaks\_missile_strike::missilestrikeondeath(var_03,var_01,var_00,var_02);
			var_0C.missileweapon = undefined;
			var_0C.rocket = undefined;
		}
	}

	foreach(var_0C in level.players)
	{
		if(isdefined(var_0C.isjuggernaut) && var_0C.isjuggernaut)
		{
			var_0C maps\mp\_snd_common_mp::snd_message("goliath_self_destruct");
			playfx(common_scripts\utility::getfx("goliath_self_destruct"),var_0C.origin,anglestoup(var_0C.angles));
			wait(0.05);
			var_0C.hideondeath = 1;
			var_0C.juggernautsuicide = 1;
			var_0C thread [[ level.hordehandlejuggdeath ]]();
		}
	}
}

//Function Number: 33
droneswarmaudio(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 playsound("bagh_dna_drone_swarm_layer");
	wait(5.66);
	param_00 playsound("bagh_dna_drone_flyby_01");
}

//Function Number: 34
zombiepreloadweapons(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 loadweapons(["iw5_em1_mp","iw5_sn6_mp","iw5_maul_mp","iw5_lsat_mp"]);
	wait(3);
	param_00 loadweapons(["iw5_hbra3_mp","iw5_asm1_mp","iw5_uts19_mp"]);
}

//Function Number: 35
zombiesetspeedscale(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = 0.2;
	while(var_01 < param_00.classsettings["light"]["speed"])
	{
		param_00.movespeedscaler = var_01;
		var_01 = var_01 + 0.05;
		wait(1);
	}
}

//Function Number: 36
hordesetzombiemodel(param_00)
{
	var_01 = ["zombies_body_afr_a","zombies_body_afr_b","zombies_body_afr_c","zombies_body_afr_d"];
	var_02 = ["zombies_head_afr_a","zombies_head_afr_b","zombies_head_afr_c","zombies_head_afr_c"];
	var_03 = ["zombies_body_cau_a","zombies_body_cau_b","zombies_body_cau_c","zombies_body_cau_d"];
	var_04 = ["zombies_head_cau_a","zombies_head_cau_b","zombies_head_cau_c","zombies_head_shg_b"];
	var_05 = ["zombies_body_civ_cau_a","zombies_body_civ_cau_b","zombies_body_civ_cau_c","zombies_body_civ_cau_d"];
	var_06 = ["zombies_body_civ_afr_a","zombies_body_civ_afr_b","zombies_body_civ_afr_c","zombies_body_civ_afr_d"];
	var_07[0] = var_01;
	var_07[1] = var_03;
	var_07[2] = var_06;
	var_07[3] = var_05;
	var_08[0] = var_02;
	var_08[1] = var_04;
	var_08[2] = var_02;
	var_08[3] = var_04;
	var_09 = randomintrange(0,4);
	var_0A = randomintrange(0,4);
	var_0B = randomintrange(0,4);
	var_0C = var_07[var_09][var_0A];
	var_0D = var_08[var_09][var_0B];
	self detachall();
	self setmodel(var_0C);
	self.headmodel = var_0D;
	self attach(self.headmodel,"",1);
}

//Function Number: 37
zombiesmusic()
{
	level endon("game_ended");
	level waittill("blackout_done");
	maps\mp\_audio::snd_play_loop_in_space("det_mus_horror_lp_01",level.players[0].origin,"beginZombieSpawn",3);
	level waittill("beginZombieSpawn");
	maps\mp\_audio::snd_play_loop_in_space("det_mus_horror_lp_02",level.players[0].origin,"stopZombieMusic",3);
	wait(60);
	level notify("stopZombieMusic");
	level waittill("start_extraction");
	maps\mp\_audio::snd_play_loop_in_space("det_mus_high_tension1",level.players[0].origin,"zombies_ended",1);
}

//Function Number: 38
outro_horde_cleanup()
{
	foreach(var_01 in level.agentarray)
	{
		maps\mp\agents\_agent_utility::killagent(var_01);
	}
}

//Function Number: 39
dnadronebreakprisonglass(param_00,param_01)
{
	wait(param_00);
	destroyglass(param_01);
}

//Function Number: 40
calculate_break_time(param_00,param_01)
{
	var_02 = 6000;
	var_03 = distance(param_00.origin,param_01);
	var_04 = param_00.drone_travel_time;
	var_05 = var_03 * var_04 / var_02;
	return var_05;
}

//Function Number: 41
check_player_gender()
{
	if(isdefined(self.costume))
	{
		return self.costume[0];
	}

	return 0;
}

//Function Number: 42
dnablackout_moveplayers_off_roof()
{
	var_00 = getentarray("org_zombie_player_start_point","targetname");
	common_scripts\utility::array_randomize(var_00);
	level waittill("blackout_done");
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		level.players[var_01] setorigin(var_00[var_01].origin);
		wait(0.5);
		level.players[var_01] setplayerangles(var_00[var_01].angles);
	}
}

//Function Number: 43
zombiespatchclip()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1407.27,2567.11,704),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1407.27,2567.11,960),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1407.27,2567.11,1216),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1185.79,2695.5,704),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1185.79,2695.5,960),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1185.79,2695.5,1216),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-964.314,2823.89,704),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-964.314,2823.89,960),(0,300.1,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-964.314,2823.89,1216),(0,300.1,0));
}