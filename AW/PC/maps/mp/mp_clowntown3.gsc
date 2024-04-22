/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_clowntown3.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 813 ms
 * Timestamp: 4/22/2024 2:17:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::clowntown3_callbackstartgametype;
	maps\mp\mp_clowntown3_precache::main();
	maps\createart\mp_clowntown3_art::main();
	maps\mp\mp_clowntown3_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_clowntown3_lighting::main();
	maps\mp\mp_clowntown3_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_clowntown3");
	maps\mp\_water::init();
	precacheitem("iw5_dlcgun12loot9_mp");
	precacheitem("iw5_dlcgun12loot8_mp");
	precachempanim("ct_motel_sign_idle");
	precachempanim("ct_motel_sign_hat_off");
	precachempanim("ct_motel_sign_hat_off_idle");
	precachempanim("ct_motel_sign_hat_on");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	thread aud_event_sign_mech_idle();
	if(level.nextgen)
	{
		thread ct_vista_cars();
		thread delete_ct_vista_cars();
	}

	sign_init();
	bombs_init();
	thread rotating_bed_setup();
	thread rotating_fans_setup();
	thread clowntownclippatch();
	var_00 = level.gametype;
	if(!var_00 == "twar" || var_00 == "sd" || var_00 == "sr")
	{
		level thread maps\mp\_dynamic_events::dynamicevent(::clowntown_dynamic_event);
	}

	setdvar("sm_minSpotLightScore",0.0007);
	level.ospvisionset = "mp_clowntown3_osp";
	level.osplightset = "mp_clowntown3_osp";
	level.warbirdvisionset = "mp_clowntown3_osp";
	level.warbirdlightset = "mp_clowntown3_osp";
	level.vulcanvisionset = "mp_clowntown3_osp";
	level.vulcanlightset = "mp_clowntown3_osp";
	level thread clowntowncustomairstrike();
	level thread clowntowncustomosp();
	level thread getclownlights();
	level thread resetuplinkballoutofbounds();
	if(var_00 == "ctf")
	{
		while(!isdefined(level.teamflags["allies"]) || !isdefined(level.teamflags["axis"]))
		{
			wait(0.5);
		}

		foreach(var_02 in level.teamflags)
		{
			if(isdefined(var_02))
			{
				var_02.onpickupfailed = ::customresetflag;
			}
		}
	}

	if(isdefined(level.gametype))
	{
		if(level.gametype == "sd" || level.gametype == "sr")
		{
			level thread movebombsitea();
		}
	}
}

//Function Number: 2
movebombsitea()
{
	var_00 = 15;
	var_01 = 0;
	var_02 = 0;
	var_03 = 5;
	var_04 = getentarray("bombzone","targetname");
	var_05 = [];
	foreach(var_07 in var_04)
	{
		if(isdefined(var_07.script_label) && var_07.script_label == "_a")
		{
			var_05[var_05.size] = var_07;
			var_08 = getent(var_07.target,"targetname");
			var_05[var_05.size] = var_08;
			var_05[var_05.size] = getent(var_08.target,"targetname");
			break;
		}
	}

	var_0A = getentarray("exploder","targetname");
	foreach(var_0C in var_0A)
	{
		if(isdefined(var_0C.script_gameobjectname) && var_0C.script_gameobjectname == "bombzone")
		{
			if(isdefined(var_0C.script_exploder) && issubstr(var_0C.script_exploder,"_1"))
			{
				var_05[var_05.size] = var_0C;
				break;
			}
		}
	}

	var_0E = getentarray("script_brushmodel","classname");
	foreach(var_10 in var_0E)
	{
		if(isdefined(var_10.script_gameobjectname) && var_10.script_gameobjectname == "bombzone")
		{
			if(isdefined(var_10.script_label) && var_10.script_label == "bombzone_a")
			{
				var_05[var_05.size] = var_10;
				break;
			}
		}
	}

	foreach(var_13 in var_05)
	{
		var_13.origin = var_13.origin + (0,0,var_00);
		var_13.angles = var_13.angles + (var_01,var_02,var_03);
	}
}

//Function Number: 3
resetuplinkballoutofbounds()
{
	level endon("game_ended");
	if(level.gametype == "ball")
	{
		while(!isdefined(level.balls))
		{
			wait(0.05);
		}

		foreach(var_01 in level.balls)
		{
			var_01 thread watchcarryobjects();
		}
	}
}

//Function Number: 4
watchcarryobjects()
{
	level endon("game_ended");
	for(;;)
	{
		self waittill("dropped");
		wait(0.1);
		thread monitorballstate();
		var_00 = common_scripts\utility::waittill_any_return("pickup_object","reset");
	}
}

//Function Number: 5
monitorballstate()
{
	self endon("pickup_object");
	self endon("reset");
	for(;;)
	{
		if(isoutofbounds())
		{
			thread maps\mp\gametypes\_gameobjects::returnhome();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 6
isoutofbounds()
{
	var_00 = getentarray("object_out_of_bounds","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!self.visuals[0] istouching(var_00[var_01]))
		{
			continue;
		}

		return 1;
	}

	return 0;
}

//Function Number: 7
getclownlights()
{
	level.clownlightson = getentarray("lights_on","targetname");
	level.clownlightsoff = getentarray("lights_off","targetname");
	foreach(var_01 in level.clownlightson)
	{
		var_01 hide();
	}
}

//Function Number: 8
clowntowncustomosp()
{
	level.orbitalsupportoverrides.spawnheight = 6500;
	level.orbitalsupportoverrides.spawnradius = 6500;
}

//Function Number: 9
clowntowncustomairstrike()
{
	if(!isdefined(level.airstrikeoverrides))
	{
		level.airstrikeoverrides = spawnstruct();
	}

	level.airstrikeoverrides.spawnheight = 750;
}

//Function Number: 10
clowntown3_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 11
rotating_bed_setup()
{
	var_00 = getentarray("bed_collision","targetname");
	var_01 = getent("bed_model","targetname");
	var_02 = 10000;
	thread aud_bed_sfx(var_01);
	foreach(var_04 in var_00)
	{
		var_04 linkto(var_01);
	}

	var_01 rotatevelocity((0,-10,0),var_02);
}

//Function Number: 12
rotating_fans_setup()
{
	level.fans = getentarray("ceilingfan_01","targetname");
	foreach(var_03, var_01 in level.fans)
	{
		var_02 = common_scripts\utility::mod(var_03,3) + 1;
		var_01 scriptmodelplayanim("ct_ceiling_fan_idle_" + var_02);
		wait(0.2);
	}
}

//Function Number: 13
clowntown_dynamic_event()
{
	level endon("dynamic_event_starting");
	wait(8);
	sign_startup_sequence();
	wait(5);
	for(;;)
	{
		cannon_firing_event();
		while(level.bombsonstandby.size <= level.bomb_count_min)
		{
			wait 0.05;
		}

		if(isdefined(level.ishorde) && level.ishorde)
		{
			wait(randomintrange(300,360));
			while(level.currentaliveenemycount < 1)
			{
				wait(10);
			}

			continue;
		}

		wait(randomintrange(20,30));
	}
}

//Function Number: 14
sign_init()
{
	level.anim_sign = getent("clown_sign","targetname");
	level.sign_off = getent("clown_sign_off","targetname");
	level.sign_on = getent("clown_sign_on_static","targetname");
	level.anim_sign hide();
	level.sign_on hide();
}

//Function Number: 15
sign_startup_sequence()
{
	thread aud_clowntown_sign_startup_sequence();
	if(isdefined(level.clownlightsoff) && isdefined(level.clownlightson))
	{
		foreach(var_01 in level.clownlightsoff)
		{
			var_01 hide();
		}

		foreach(var_01 in level.clownlightson)
		{
			var_01 show();
		}
	}

	sign_on();
	wait(0.5);
	sign_off();
	wait(0.3);
	sign_on();
	wait(0.3);
	sign_off();
	wait(0.5);
	sign_on();
	wait(0.5);
	sign_off();
	wait(0.3);
	sign_on();
	wait(1);
	level.sign_on hide();
	level.anim_sign show();
	thread scriptmodelplayanimwithnotifycheap(level.anim_sign,"ct_motel_sign_idle","motel_sign_idle_notify","ct_motel_sign_idle_start","ct3_cannon_idle_mech","aud_stop_01","aud_stop_02","aud_stop_03");
}

//Function Number: 16
sign_off()
{
	level.sign_on ghost();
	level.sign_off show();
}

//Function Number: 17
sign_on()
{
	level.sign_on show();
	level.sign_off ghost();
}

//Function Number: 18
cannon_firing_event()
{
	var_00 = level.bombsonstandby.size;
	level.bomb_targets = common_scripts\utility::array_randomize(level.bomb_targets);
	level.anim_sign waittillmatch("ct_motel_sign_idle_start","motel_sign_idle_notify");
	level.anim_sign scriptmodelclearanim();
	level.anim_sign scriptmodelplayanim("ct_motel_sign_hat_off","anim_end");
	var_01 = 20;
	aud_event_sign_hat_off(var_01);
	wait(6.96);
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		if(isdefined(level.bombsonstandby[0]))
		{
			level.bombsonstandby[0] bomb_fires(var_02);
			level.anim_sign scriptmodelclearanim();
			level.anim_sign scriptmodelplayanim("ct_motel_sign_hat_off_idle","anim_end");
			wait(4);
		}
	}

	level.anim_sign scriptmodelclearanim();
	level.anim_sign scriptmodelplayanim("ct_motel_sign_hat_on","anim_end");
	aud_event_sign_hat_on(var_01);
	wait(7.7);
	scriptmodelplayanimwithnotifycheap(level.anim_sign,"ct_motel_sign_idle","motel_sign_idle_notify","ct_motel_sign_idle_start","ct3_cannon_idle_mech","aud_stop_01","aud_stop_02","aud_stop_03");
	wait(1);
}

//Function Number: 19
bombs_init()
{
	wait(1);
	level.bombsonstandby = [];
	level.launch_point = getent("org_bomb_launch","targetname");
	level.bomb_targets = getentarray("org_bomb_targets","targetname");
	level.bomb_count_max = 6;
	level.bomb_count_min = 2;
	for(var_00 = 0;var_00 < level.bomb_count_max;var_00++)
	{
		var_01 = spawn("script_model",(0,0,-10));
		var_01 setmodel("npc_bomb_clown");
		var_01 thread bomb_physics_impact_watch();
		var_02 = 24;
		var_03 = getent("bomb_pickup_" + var_00 + 1,"targetname");
		if(isdefined(var_03))
		{
			var_03.origin = var_01.origin;
		}
		else
		{
			var_03 = spawn("trigger_radius",var_01.origin - (0,0,var_02 / 2),0,var_02,var_02);
		}

		var_03 enablelinkto();
		var_03 linkto(var_01);
		var_03.no_moving_platfrom_unlink = 1;
		var_04 = [var_01];
		var_05 = maps\mp\gametypes\_gameobjects::createcarryobject("any",var_03,var_04,(0,0,32));
		var_05 maps\mp\gametypes\_gameobjects::allowcarry("any");
		var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_05.objidpingenemy = 1;
		var_05.objpingdelay = 1;
		var_05.allowweapons = 0;
		var_05.carryweapon = "iw5_dlcgun12loot9_mp";
		var_05.keepcarryweapon = 1;
		var_05.waterbadtrigger = 0;
		var_05.visualgroundoffset = (0,0,30);
		var_05.canuseobject = ::bomb_can_pickup;
		var_05.onpickup = ::bomb_on_pickup;
		var_05.setdropped = ::bomb_set_dropped;
		var_05.carryweaponthink = ::bomb_throw;
		var_05.requireslos = 1;
		maps\mp\_utility::_objective_delete(var_05.objidallies);
		maps\mp\_utility::_objective_delete(var_05.objidaxis);
		maps\mp\_utility::_objective_delete(var_05.objidmlgspectator);
		var_05.compassicons = undefined;
		var_05.objidallies = undefined;
		var_05.objidaxis = undefined;
		var_05.objidmlgspectator = undefined;
		level.bombsonstandby[level.bombsonstandby.size] = var_05;
		wait 0.05;
	}
}

//Function Number: 20
bomb_fires(param_00)
{
	var_01 = level.bomb_targets[param_00];
	var_02 = self.visuals[0];
	var_02 show();
	var_02 dontinterpolate();
	self.bomb_fx_active = 0;
	var_02 physicsstop();
	var_02.origin = level.launch_point.origin;
	level.mines[level.mines.size] = var_02;
	var_03 = var_01.origin + (randomfloatrange(-10,10),randomfloatrange(-10,10),randomfloatrange(-10,10));
	var_04 = var_03 - var_02.origin * 2;
	var_05 = (0,0,0);
	var_02 physicslaunchserver(var_02.origin + var_05,var_04);
	aud_event_fire_bomb();
	thread bomb_fuse_default();
	level.bombsonstandby = common_scripts\utility::array_remove(level.bombsonstandby,self);
	bomb_fx_start();
	radiusdamage(level.launch_point.origin + (0,0,20),20,50,40);
	playfx(common_scripts\utility::getfx("cannon_firing"),level.launch_point.origin + (0,0,35));
	var_06 = anglestoforward(level.launch_point.origin);
	var_07 = anglestoup(level.launch_point.origin);
}

//Function Number: 21
bomb_fuse_default()
{
	self endon("stop_fuse");
	self endon("pickup_object");
	var_00 = 15;
	var_01 = self.visuals[0];
	playfxontag(common_scripts\utility::getfx("mp_clowntown_bomb_fuse"),var_01,"tag_fx");
	while(var_00 > 0)
	{
		if(isdefined(self) && var_00 < 4)
		{
			playfx(common_scripts\utility::getfx("ball_flash"),self.visuals[0].origin);
		}

		wait(1);
		var_00 = var_00 - 1;
	}

	magicgrenademanual("iw5_dlcgun12loot8_mp",self.visuals[0].origin,(0,0,0),0);
	thread bomb_cleanup();
}

//Function Number: 22
bomb_fuse_short()
{
	self endon("stop_fuse");
	self endon("pickup_object");
	for(var_00 = 3;var_00 > 0;var_00 = var_00 - 1)
	{
		if(isdefined(self) && var_00 < 4)
		{
			playfx(common_scripts\utility::getfx("ball_flash"),self.visuals[0].origin);
		}

		wait(1);
	}

	magicgrenademanual("iw5_dlcgun12loot8_mp",self.visuals[0].origin,(0,0,0),0);
	thread bomb_cleanup();
}

//Function Number: 23
bomb_can_pickup(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.underwater) && param_00.underwater)
	{
		return 0;
	}

	if(isdefined(self.droptime) && self.droptime >= gettime())
	{
		return 0;
	}

	if(!param_00 common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(param_00 isusingturret())
	{
		return 0;
	}

	if(isdefined(param_00.manuallyjoiningkillstreak) && param_00.manuallyjoiningkillstreak)
	{
		return 0;
	}

	var_01 = param_00 getcurrentweapon();
	if(isdefined(var_01))
	{
		if(!valid_bomb_pickup_weapon(var_01))
		{
			return 0;
		}
	}

	var_02 = param_00.changingweapon;
	if(isdefined(var_02) && param_00 isreloading())
	{
		if(!valid_bomb_pickup_weapon(var_02))
		{
			return 0;
		}
	}

	if(isdefined(param_00.exo_shield_on) && param_00.exo_shield_on == 1)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 0;
	}

	if(isbot(param_00) || isagent(param_00))
	{
		return 0;
	}

	if(param_00 player_no_pickup_time())
	{
		return 0;
	}

	return 1;
}

//Function Number: 24
valid_bomb_pickup_weapon(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(param_00 == "iw5_dlcgun12loot9_mp")
	{
		return 0;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return 0;
	}

	if(param_00 == "iw5_combatknifegoliath_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
player_no_pickup_time()
{
	return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

//Function Number: 26
bomb_on_pickup(param_00)
{
	level.usestartspawns = 0;
	self notify("pickup_object");
	level.mines = common_scripts\utility::array_remove(level.mines,self.visuals[0]);
	var_01 = self.visuals[0] getlinkedparent();
	if(isdefined(var_01))
	{
		self.visuals[0] unlink();
	}

	self.visuals[0] physicsstop();
	self.visuals[0] maps\mp\_movers::notify_moving_platform_invalid();
	self.visuals[0] show();
	self.visuals[0] ghost();
	self.trigger maps\mp\_movers::stop_handling_moving_platforms();
	bomb_fx_stop();
	param_00 setweaponammoclip("iw5_dlcgun12loot9_mp",1);
	param_00 maps\mp\_utility::giveperk("specialty_ballcarrier",0);
	param_00 common_scripts\utility::_disableusability();
	param_00 maps\mp\killstreaks\_coop_util::playerstoppromptforstreaksupport();
}

//Function Number: 27
bomb_throw()
{
	self endon("disconnect");
	thread bomb_throw_watch();
	self.carryobject waittill("dropped");
}

//Function Number: 28
bomb_throw_watch()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("drop_object");
	var_00 = getdvarfloat("scr_ball_shoot_extra_pitch",-12);
	var_01 = getdvarfloat("scr_ball_shoot_force",320);
	for(;;)
	{
		self waittill("weapon_fired",var_02);
		if(var_02 != "iw5_dlcgun12loot9_mp")
		{
			continue;
		}

		break;
	}

	if(isdefined(self.carryobject))
	{
		var_03 = self getplayerangles();
		var_03 = var_03 + (var_00,0,0);
		var_03 = (clamp(var_03[0],-85,85),var_03[1],var_03[2]);
		var_04 = anglestoforward(var_03);
		thread bomb_throw_active();
		wait(0.25);
		self playsound("mp_ul_ball_throw");
		self.carryobject bomb_create_killcam_ent();
		self.carryobject thread bomb_physics_launch_drop(var_04 * var_01,self);
	}
}

//Function Number: 29
bomb_physics_impact_watch()
{
	self endon("death");
	for(;;)
	{
		self waittill("physics_impact",var_00,var_01,var_02,var_03);
		var_04 = level._effect["ball_physics_impact"];
		if(isdefined(var_03) && isdefined(level._effect["ball_physics_impact_" + var_03]))
		{
			var_04 = level._effect["ball_physics_impact_" + var_03];
		}

		playfx(var_04,var_00,var_01);
		thread aud_play_bomb_bounce();
		wait(0.3);
	}
}

//Function Number: 30
bomb_throw_active()
{
	self endon("death");
	self endon("disconnect");
	self.pass_or_throw_active = 1;
	self allowmelee(0);
	while("iw5_dlcgun12loot9_mp" == self getcurrentweapon())
	{
		wait 0.05;
	}

	self allowmelee(1);
	self.pass_or_throw_active = 0;
}

//Function Number: 31
bomb_physics_launch_drop(param_00,param_01)
{
	bomb_carrier_cleanup();
	self.ownerteam = "any";
	maps\mp\gametypes\_gameobjects::clearcarrier();
	bomb_physics_launch(param_00,param_01);
}

//Function Number: 32
bomb_physics_launch(param_00,param_01)
{
	var_02 = self.visuals[0];
	var_02.origin_prev = undefined;
	bomb_cleanup();
	var_03 = anglestoforward(param_01 getplayerangles()) * 940 + anglestoup(param_01 getplayerangles()) * 120;
	var_04 = param_01 geteye();
	var_05 = magicgrenademanual("iw5_dlcgun12loot8_mp",var_04,var_03,2,param_01);
}

//Function Number: 33
bomb_create_killcam_ent()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	self.killcament = spawn("script_model",self.visuals[0].origin);
	self.killcament linkto(self.visuals[0]);
	self.killcament setcontents(0);
	self.killcament setscriptmoverkillcam("explosive");
}

//Function Number: 34
bomb_set_dropped(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.isresetting = 1;
	self.droptime = gettime();
	self notify("dropped");
	var_01 = self.carrier;
	if(isdefined(var_01) && var_01.team != "spectator")
	{
		var_02 = var_01.origin;
	}
	else
	{
		var_02 = self.safeorigin;
	}

	var_03 = self.visuals[0];
	var_03.origin = var_02;
	var_03 show();
	var_03 physicslaunchserver(var_03.origin + (0,1,0));
	level.mines[level.mines.size] = var_03;
	thread bomb_fuse_short();
	bomb_carrier_cleanup();
	bomb_fx_start();
	self.ownerteam = "any";
	maps\mp\gametypes\_gameobjects::clearcarrier();
	return 1;
}

//Function Number: 35
bomb_carrier_cleanup()
{
	if(isdefined(self.carrier))
	{
		self.carrier.nopickuptime = gettime() + 500;
		self.carrier maps\mp\_utility::_unsetperk("specialty_ballcarrier");
		self.carrier common_scripts\utility::_enableusability();
		self.carrier maps\mp\killstreaks\_coop_util::playerstartpromptforstreaksupport();
	}
}

//Function Number: 36
bomb_dont_interpolate()
{
	self.visuals[0] dontinterpolate();
	self.bomb_fx_active = 0;
}

//Function Number: 37
bomb_cleanup()
{
	self notify("stop_fuse");
	bomb_fx_stop();
	self.visuals[0] dontinterpolate();
	self.bomb_fx_active = 0;
	self.visuals[0] physicsstop();
	self.visuals[0].origin = (0,0,0);
	level.mines = common_scripts\utility::array_remove(level.mines,self.visuals[0]);
	level.bombsonstandby = common_scripts\utility::array_add(level.bombsonstandby,self);
}

//Function Number: 38
bomb_fx_start()
{
	if(!bomb_fx_active())
	{
		var_00 = self.visuals[0];
		playfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"body_animate_jnt");
		playfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"body_animate_jnt");
		var_00 hudoutlineenable(0,0);
		self.bomb_fx_active = 1;
		var_00 playloopsound("mp_clown_bomb_fuse_lp_world");
	}
}

//Function Number: 39
bomb_fx_stop()
{
	if(bomb_fx_active())
	{
		var_00 = self.visuals[0];
		stopfxontag(common_scripts\utility::getfx("ball_trail"),var_00,"body_animate_jnt");
		killfxontag(common_scripts\utility::getfx("ball_idle"),var_00,"body_animate_jnt");
		killfxontag(common_scripts\utility::getfx("mp_clowntown_bomb_fuse"),var_00,"tag_fx");
		var_00 hudoutlinedisable();
		var_00 stopsounds();
	}

	self.bomb_fx_active = 0;
}

//Function Number: 40
bomb_fx_active()
{
	return isdefined(self.bomb_fx_active) && self.bomb_fx_active;
}

//Function Number: 41
customresetflag(param_00)
{
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		maps\mp\gametypes\ctf::flageffectsstop();
		thread maps\mp\gametypes\ctf::returnflag();
		maps\mp\_utility::leaderdialog("flag_returned",var_01,"status");
		maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med",var_01);
		maps\mp\_utility::leaderdialog("enemy_flag_returned",var_02,"status");
		maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med",var_02);
		param_00 thread maps\mp\_events::flagreturnevent();
		maps\mp\gametypes\ctf::onresetflaghudstatus(var_01);
	}
}

//Function Number: 42
ct_vista_cars()
{
	level endon("game_ended");
	var_00 = (33,62,-3);
	var_01 = (33,-105,-3);
	level.car01 = spawncar(var_00,(0,252,0));
	level.car02 = spawncar(var_00,(0,252,0));
	level.car03 = spawncar(var_01,(0,252,0));
	level.car04 = spawncar(var_01,(0,252,0));
	level.car05 = spawncar(var_01,(0,252,0));
	level.car06 = spawncar(var_00,(0,252,0));
	level.car07 = spawncar(var_00,(0,252,0));
	level.car08 = spawncar(var_00,(0,252,0));
	level.car09 = spawncar(var_01,(0,252,0));
	level.car10 = spawncar(var_01,(0,252,0));
	level.car11 = spawncar(var_01,(0,252,0));
	level.car12 = spawncar(var_00,(0,252,0));
	level.car13 = spawncar(var_00,(0,252,0));
	level.car14 = spawncar(var_00,(0,252,0));
	level.car15 = spawncar(var_01,(0,252,0));
	level.car16 = spawncar(var_01,(0,252,0));
	level.car17 = spawncar(var_01,(0,252,0));
	level.car18 = spawncar(var_00,(0,252,0));
	level.car19 = spawncar(var_00,(0,252,0));
	level.car20 = spawncar(var_00,(0,252,0));
	level.car21 = spawncar(var_01,(0,252,0));
	level.car22 = spawncar(var_01,(0,252,0));
	level.car23 = spawncar(var_01,(0,252,0));
	level.car24 = spawncar(var_00,(0,252,0));
	level.car01 setmodel("vehicle_ct_civ_vista_cars_01");
	level.car02 setmodel("vehicle_ct_civ_vista_cars_02");
	level.car03 setmodel("vehicle_ct_civ_vista_cars_03");
	level.car04 setmodel("vehicle_ct_civ_vista_cars_04");
	level.car05 setmodel("vehicle_ct_civ_vista_cars_05");
	level.car06 setmodel("vehicle_ct_civ_vista_cars_06");
	level.car07 setmodel("vehicle_ct_civ_vista_cars_06");
	level.car08 setmodel("vehicle_ct_civ_vista_cars_05");
	level.car09 setmodel("vehicle_ct_civ_vista_cars_04");
	level.car10 setmodel("vehicle_ct_civ_vista_cars_03");
	level.car11 setmodel("vehicle_ct_civ_vista_cars_02");
	level.car12 setmodel("vehicle_ct_civ_vista_cars_01");
	level.car13 setmodel("vehicle_ct_civ_vista_cars_03");
	level.car14 setmodel("vehicle_ct_civ_vista_cars_01");
	level.car15 setmodel("vehicle_ct_civ_vista_cars_02");
	level.car16 setmodel("vehicle_ct_civ_vista_cars_06");
	level.car17 setmodel("vehicle_ct_civ_vista_cars_04");
	level.car18 setmodel("vehicle_ct_civ_vista_cars_05");
	level.car19 setmodel("vehicle_ct_civ_vista_cars_02");
	level.car20 setmodel("vehicle_ct_civ_vista_cars_04");
	level.car21 setmodel("vehicle_ct_civ_vista_cars_06");
	level.car22 setmodel("vehicle_ct_civ_vista_cars_01");
	level.car23 setmodel("vehicle_ct_civ_vista_cars_03");
	level.car24 setmodel("vehicle_ct_civ_vista_cars_05");
	level.car01 notsolid();
	level.car02 notsolid();
	level.car03 notsolid();
	level.car04 notsolid();
	level.car05 notsolid();
	level.car06 notsolid();
	level.car07 notsolid();
	level.car08 notsolid();
	level.car09 notsolid();
	level.car10 notsolid();
	level.car11 notsolid();
	level.car12 notsolid();
	level.car13 notsolid();
	level.car14 notsolid();
	level.car15 notsolid();
	level.car16 notsolid();
	level.car17 notsolid();
	level.car18 notsolid();
	level.car19 notsolid();
	level.car20 notsolid();
	level.car21 notsolid();
	level.car22 notsolid();
	level.car23 notsolid();
	level.car24 notsolid();
	level.car01 hide();
	level.car02 hide();
	level.car03 hide();
	level.car04 hide();
	level.car05 hide();
	level.car06 hide();
	level.car07 hide();
	level.car08 hide();
	level.car09 hide();
	level.car10 hide();
	level.car11 hide();
	level.car12 hide();
	level.car13 hide();
	level.car14 hide();
	level.car15 hide();
	level.car16 hide();
	level.car17 hide();
	level.car18 hide();
	level.car19 hide();
	level.car20 hide();
	level.car21 hide();
	level.car22 hide();
	level.car23 hide();
	level.car24 hide();
	wait(0.05);
	level.car01 scriptmodelplayanim("ct_vista_car_1");
	level.car02 scriptmodelplayanim("ct_vista_car_2");
	level.car03 scriptmodelplayanim("ct_vista_car_3");
	level.car04 scriptmodelplayanim("ct_vista_car_4");
	level.car05 scriptmodelplayanim("ct_vista_car_5");
	level.car06 scriptmodelplayanim("ct_vista_car_6");
	level.car01 thread unhidecar();
	level.car02 thread unhidecar();
	level.car03 thread unhidecar();
	level.car04 thread unhidecar();
	level.car05 thread unhidecar();
	level.car06 thread unhidecar();
	wait(5);
	level.car07 scriptmodelplayanim("ct_vista_car_1");
	level.car08 scriptmodelplayanim("ct_vista_car_2");
	level.car09 scriptmodelplayanim("ct_vista_car_3");
	level.car10 scriptmodelplayanim("ct_vista_car_4");
	level.car11 scriptmodelplayanim("ct_vista_car_5");
	level.car12 scriptmodelplayanim("ct_vista_car_6");
	level.car07 thread unhidecar();
	level.car08 thread unhidecar();
	level.car09 thread unhidecar();
	level.car10 thread unhidecar();
	level.car11 thread unhidecar();
	level.car12 thread unhidecar();
	wait(5);
	level.car13 scriptmodelplayanim("ct_vista_car_1");
	level.car14 scriptmodelplayanim("ct_vista_car_2");
	level.car15 scriptmodelplayanim("ct_vista_car_3");
	level.car16 scriptmodelplayanim("ct_vista_car_4");
	level.car17 scriptmodelplayanim("ct_vista_car_5");
	level.car18 scriptmodelplayanim("ct_vista_car_6");
	level.car13 thread unhidecar();
	level.car14 thread unhidecar();
	level.car15 thread unhidecar();
	level.car16 thread unhidecar();
	level.car17 thread unhidecar();
	level.car18 thread unhidecar();
	wait(5);
	level.car19 scriptmodelplayanim("ct_vista_car_1");
	level.car20 scriptmodelplayanim("ct_vista_car_2");
	level.car21 scriptmodelplayanim("ct_vista_car_3");
	level.car22 scriptmodelplayanim("ct_vista_car_4");
	level.car23 scriptmodelplayanim("ct_vista_car_5");
	level.car24 scriptmodelplayanim("ct_vista_car_6");
	level.car19 thread unhidecar();
	level.car20 thread unhidecar();
	level.car21 thread unhidecar();
	level.car22 thread unhidecar();
	level.car23 thread unhidecar();
	level.car24 thread unhidecar();
}

//Function Number: 43
unhidecar()
{
	wait(0.1);
	self show();
}

//Function Number: 44
spawncar(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	return var_02;
}

//Function Number: 45
delete_ct_vista_cars()
{
	level waittill("game_ended");
	level.car01 delete();
	level.car02 delete();
	level.car03 delete();
	level.car04 delete();
	level.car05 delete();
	level.car06 delete();
	level.car07 delete();
	level.car08 delete();
	level.car09 delete();
	level.car10 delete();
	level.car11 delete();
	level.car12 delete();
	level.car13 delete();
	level.car14 delete();
	level.car15 delete();
	level.car16 delete();
	level.car17 delete();
	level.car18 delete();
	level.car19 delete();
	level.car20 delete();
	level.car21 delete();
	level.car22 delete();
	level.car23 delete();
	level.car24 delete();
}

//Function Number: 46
aud_play_bomb_flash()
{
}

//Function Number: 47
aud_play_bomb_bounce()
{
	if(isdefined(self))
	{
		maps\mp\_audio::snd_play_in_space("wpn_clown_bomb_bounce",self.origin);
	}
}

//Function Number: 48
aud_bed_sfx(param_00)
{
	maps\mp\_audio::snd_play_linked_loop("emt_mp_ct3_bed_music_lp",param_00);
}

//Function Number: 49
aud_clowntown_sign_startup_sequence()
{
	maps\mp\_audio::snd_play_in_space("ct3_cannon_shot_music",level.launch_point.origin);
	maps\mp\_audio::snd_play_in_space("mp_anr_clown_dyn_welcome",level.launch_point.origin);
}

//Function Number: 50
aud_event_sign_mech_idle()
{
	wait(1.5);
	maps\mp\_audio::snd_play_loop_in_space("ct3_cannon_idle_mech_lp",level.launch_point.origin,"aud_stop_mech_loop");
}

//Function Number: 51
aud_event_sign_hat_off(param_00)
{
	maps\mp\_audio::snd_play_in_space("ct3_cannon_mech_start",level.launch_point.origin,param_00);
	maps\mp\_audio::snd_play_in_space("ct3_cannon_shot_fireworks",level.launch_point.origin,param_00);
	maps\mp\_audio::snd_play_in_space("ct3_cannon_shot_music",level.launch_point.origin,param_00);
	maps\mp\_audio::snd_play_in_space("mp_anr_clown_dyn_carnival",level.launch_point.origin);
}

//Function Number: 52
aud_event_fire_bomb()
{
	maps\mp\_audio::snd_play_in_space("ct3_cannon_shot",level.launch_point.origin);
}

//Function Number: 53
aud_event_sign_hat_on(param_00)
{
	maps\mp\_audio::snd_play_in_space_delayed("ct3_cannon_mech_end",level.launch_point.origin,0.55,param_00);
	maps\mp\_audio::snd_play_in_space("mp_anr_clown_dyn_carnival",level.launch_point.origin);
}

//Function Number: 54
scriptmodelplayanimwithnotifycheap(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_05))
	{
		level endon(param_05);
	}

	param_00 scriptmodelplayanimdeltamotion(param_01,param_02);
	thread scriptmodelplayanimwithnotifycheap_notetracks(param_00,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 55
scriptmodelplayanimwithnotifycheap_notetracks(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_04))
	{
		level endon(param_04);
	}

	if(isdefined(param_05))
	{
		param_00 endon(param_05);
	}

	if(isdefined(param_06))
	{
		param_00 endon(param_06);
	}

	param_00 endon("death");
	for(;;)
	{
		param_00 waittillmatch(param_02,param_01);
		param_00 playsound(param_03);
	}
}

//Function Number: 56
clowntownclippatch()
{
}