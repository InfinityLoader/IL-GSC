/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_kremlin.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 59
 * Decompile Time: 869 ms
 * Timestamp: 4/22/2024 2:17:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.callbackstartgametype = ::kremlin_callbackstartgametype;
	maps\mp\mp_kremlin_precache::main();
	maps\createart\mp_kremlin_art::main();
	maps\mp\mp_kremlin_fx::main();
	maps\mp\_load::main();
	maps\mp\mp_kremlin_lighting::main();
	maps\mp\mp_kremlin_aud::main();
	maps\mp\_compass::setupminimap("compass_map_mp_kremlin");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.ospvisionset = "mp_kremlin_osp";
	level.osplightset = "mp_kremlin_osp";
	level.dronevisionset = "mp_kremlin_drone";
	level.dronelightset = "mp_kremlin_drone";
	level.warbirdvisionset = "mp_kremlin_warbird";
	level.warbirdlightset = "mp_kremlin_warbird";
	precachempanim("krem_killstreak_mine_close");
	precachempanim("krem_killstreak_mine_closed_idle");
	precachempanim("krem_killstreak_mine_open");
	precachempanim("krem_killstreak_mine_open_idle");
	level.orbitalsupportoverridefunc = ::kremlinpaladinoverrides;
	thread mine_init();
	level dynamicevent_init_sound();
	level dynamicevent_init();
	level thread maps\mp\_dynamic_events::dynamicevent(::startdynamicevent,::resetdynamicevent,::enddynamicevent);
	if(level.nextgen)
	{
		thread set_walker_tank_anims();
	}

	level thread resetuplinkballoutofbounds();
	level.airstrikeoverrides = spawnstruct();
	level.airstrikeoverrides.spawnheight = 600;
	if(level.nextgen)
	{
		thread scriptpatchclip();
	}
}

//Function Number: 2
kremlin_callbackstartgametype()
{
	maps\mp\gametypes\_gamelogic::callback_startgametype();
	common_scripts\_bcs_location_trigs_dlc::bcs_location_trigs_dlc_init();
}

//Function Number: 3
kremlinpaladinoverrides()
{
	level.orbitalsupportoverrides.spawnanglemin = 30;
	level.orbitalsupportoverrides.spawnanglemax = 120;
	level.orbitalsupportoverrides.spawnheight = 7000;
	level.orbitalsupportoverrides.spawnradius = 5000;
	level.orbitalsupportoverrides.leftarc = 45;
	level.orbitalsupportoverrides.rightarc = 45;
	level.orbitalsupportoverrides.toparc = -32;
	level.orbitalsupportoverrides.bottomarc = 80;
}

//Function Number: 4
set_walker_tank_anims()
{
	var_00 = getent("walker_tank_south_1","targetname");
	var_00.animname = "krem_walker_tank_south01";
	var_00.animtime = 54.2;
	var_01 = getent("walker_tank_north_1","targetname");
	var_01.animname = "krem_walker_tank_north01";
	var_01.animtime = 93.36;
	var_02 = getent("walker_tank_north_2","targetname");
	var_02.animname = "krem_walker_tank_north02";
	var_02.animtime = 93.36;
	var_03 = getent("walker_tank_west_1","targetname");
	var_03.animname = "krem_walker_tank_west01";
	var_03.animtime = 111;
	var_04 = [var_00,var_01,var_02,var_03];
	foreach(var_06 in var_04)
	{
		var_06 hide();
	}

	var_01 thread sequence_walker_tank_anims();
	wait(10);
	var_03 thread sequence_walker_tank_anims();
}

//Function Number: 5
sequence_walker_tank_anims()
{
	level endon("game_ended");
	for(;;)
	{
		play_walker_tank_anims();
		wait(10);
	}
}

//Function Number: 6
play_walker_tank_anims()
{
	self scriptmodelplayanim(self.animname);
	self show();
	wait(self.animtime);
	self hide();
}

//Function Number: 7
mine_init()
{
	level.minesettings = [];
	level.minesettings["mine"] = spawnstruct();
	level.minesettings["mine"].weaponinfo = "iw5_dlcgun12loot1_mp";
	level.minesettings["mine"].modelbase = "krm_mine";
	level.minesettings["mine"].animationactivate = "krem_killstreak_mine_open";
	level.minesettings["mine"].animationdeactivate = "krem_killstreak_mine_close";
	level.minesettings["mine"].animationidleactive = "krem_killstreak_mine_open_idle";
	level.minesettings["mine"].animationidleinactive = "krem_killstreak_mine_closed_idle";
	level.minesettings["mine"].lifespan = 90;
	level.minesettings["mine"].graceperiod = 0.2;
	level.minesettings["mine"].modelexplosive = "ims_scorpion_explosive_iw6";
	level.minesettings["mine"].tagexplosive1 = "tag_explosive1";
	level.minesettings["mine"].team = "neutral";
	level.minesettings["mine"].eventstartcountdown = 6;
	level.minesettings["mine"].eventduration = 60;
	level.minesettings["mine"].eventdisableduration = 1;
	level.minesettings["mine"].attackcooldown = 2;
	level.minesettings["mine"].empdisableduration = 10;
	if(level.currentgen)
	{
		level.minesettings["mine"].collision = getent("mineField_mineCollision","targetname");
	}

	level.minekillcamoffset = (0,0,12);
	level._effect["mine_antenna_light_mp"] = loadfx("vfx/map/mp_kremlin/krem_light_detonator_blink");
	level._effect["mine_emp_disable_fx"] = loadfx("vfx/sparks/emp_drone_damage");
}

//Function Number: 8
dynamicevent_init_sound()
{
	level.minesoundactivatealarm = "mp_kre_mine_warning";
	level.minesoundactivatemine = "mp_kre_mine_activate";
	level.minesoundlaunchmine = "mp_kre_mine_popup";
}

//Function Number: 9
dynamicevent_init()
{
	level endon("game_ended");
	maps\mp\_dynamic_events::setdynamiceventstartpercent(0.5);
	setdvar("scr_dynamic_event_start_perc",level.dynamicevent["start_percent"]);
	level.minetype = "mine";
	thread minefielddeploy();
	level.cancelbadminefieldspawns = 0;
	level.mineeventcomplete = 0;
}

//Function Number: 10
minefielddeploy()
{
	level endon("game_ended");
	level.minelist = [];
	level.minespawnlist = common_scripts\utility::getstructarray("mineField_mineLoc","targetname");
	common_scripts\utility::array_randomize(level.minespawnlist);
	foreach(var_01 in level.minespawnlist)
	{
		createmine(var_01);
	}
}

//Function Number: 11
startdynamicevent()
{
	level endon("game_ended");
	level notify("minefield_beginActivation");
	thread handleminefieldsettimer();
	thread minefieldsetactive();
	thread minefieldsetinactive();
	thread minefieldareafx();
}

//Function Number: 12
resetdynamicevent()
{
	if(!isdefined(level.mineeventcomplete) || !level.mineeventcomplete)
	{
		level waittill("minefield_complete");
	}

	wait(1);
	level.cancelbadminefieldspawns = 0;
	level.mineeventcomplete = 0;
}

//Function Number: 13
debugmineactivatewarning()
{
	level endon("game_ended");
	iprintlnbold("Warning: Mine Field Active in 5 seconds...");
	wait(2);
	iprintlnbold("4...");
	wait(1);
	iprintlnbold("3...");
	wait(1);
	iprintlnbold("2...");
	wait(1);
	iprintlnbold("1...");
	wait(1);
	iprintlnbold("Mine Field Active");
}

//Function Number: 14
debugminedectivatewarning()
{
	level endon("game_ended");
	iprintlnbold("Kremlin Defense Field is now deactive");
}

//Function Number: 15
enddynamicevent()
{
	level endon("game_ended");
	thread minefieldsetinactive();
}

//Function Number: 16
createmine(param_00)
{
	var_01 = level.minetype;
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel(level.minesettings[var_01].modelbase);
	var_02.scale = 3;
	var_02.health = 1000;
	var_02.angles = (0,0,0);
	if(isdefined(param_00.angles))
	{
		var_02.angles = param_00.angles;
	}

	var_02.minetype = level.minetype;
	var_02.team = level.minesettings["mine"].team;
	var_02.shouldsplash = 0;
	var_02.attackradius = param_00.radius;
	var_02.attackheight = param_00.height;
	if(param_00.origin == (-204.3,893.5,122.9))
	{
		var_02.attackheight = 80;
	}

	var_02.animationactivate = level.minesettings[var_02.minetype].animationactivate;
	var_02.animationdeactivate = level.minesettings[var_02.minetype].animationdeactivate;
	var_02.animationidleactive = level.minesettings[var_02.minetype].animationidleactive;
	var_02.animationidleinactive = level.minesettings[var_02.minetype].animationidleinactive;
	if(isdefined(var_02.animationidleinactive))
	{
		var_02 scriptmodelplayanim(var_02.animationidleinactive);
	}

	if(level.nextgen)
	{
		var_03 = param_00.target;
		var_02.minecollision = getent(var_03,"targetname");
	}

	var_02.explosive = spawn("script_model",var_02 gettagorigin(level.minesettings[var_02.minetype].tagexplosive1));
	var_02.explosive setmodel(level.minesettings[var_02.minetype].modelexplosive);
	var_02.explosive.tag = level.minesettings[var_02.minetype].tagexplosive1;
	var_02.explosive linkto(var_02);
	var_02.explosive.isenvironmentweapon = 1;
	var_02.script_stay_drone = 1;
	if(level.nextgen)
	{
		var_02.explosive.killcament = spawn("script_model",var_02.explosive.origin + level.minekillcamoffset);
		var_02.explosive.killcament setscriptmoverkillcam("explosive");
	}

	var_02 setcandamage(0);
	level.minelist = common_scripts\utility::add_to_array(level.minelist,var_02);
	var_02.activateoffsettime = level.minelist.size * 0.1;
	return var_02;
}

//Function Number: 17
reload_mine()
{
	if(isdefined(self.explosive))
	{
		self.explosive.fired = undefined;
		self.explosive.origin = self gettagorigin(level.minesettings[self.minetype].tagexplosive1);
		self.explosive.angles = (0,0,0);
		self.explosive linkto(self);
		if(level.nextgen)
		{
			self.explosive.killcament.origin = self.explosive.origin + level.minekillcamoffset;
		}

		self.explosive show();
	}

	if(level.currentgen && isdefined(self.targetplayer))
	{
		self.targetplayer = undefined;
	}
}

//Function Number: 18
handleminefieldsettimer()
{
	level endon("game_ended");
	level waittill("minefield_active");
	if(isdefined(level.minesettings["mine"].eventdisableduration) && level.minesettings["mine"].eventdisableduration == 1)
	{
		return;
	}

	wait(level.minesettings[level.minetype].eventduration);
	level notify("minefield_beginDisable");
}

//Function Number: 19
minefieldsetactive()
{
	level endon("game_ended");
	level endon("minefield_deactiavte_begin");
	var_00 = getentarray("mine_field_trigger","targetname");
	thread handleminefieldwarningsound();
	thread disconnectnodesslowly();
	if(isdefined(level.minelist))
	{
		foreach(var_02 in level.minelist)
		{
			var_02 thread activateminewithdelay();
		}
	}

	if(level.currentgen)
	{
		thread cg_minecollisionmoveup();
	}

	level notify("minefield_active");
}

//Function Number: 20
cg_minecollisionmoveup()
{
	var_00 = level.minelist.size * 0.1 + 2.2;
	wait(var_00);
	if(isdefined(level.minesettings["mine"].collision))
	{
		level.minesettings["mine"].collision moveto(level.minesettings["mine"].collision.origin + (0,0,30),0.5);
	}
}

//Function Number: 21
cg_minecollisionmovedown()
{
	if(isdefined(level.minesettings["mine"].collision))
	{
		level.minesettings["mine"].collision moveto(level.minesettings["mine"].collision.origin + (0,0,-30),0.5);
	}
}

//Function Number: 22
activateminewithdelay()
{
	var_00 = level.minesettings[self.minetype].eventstartcountdown;
	if(isdefined(self.activateoffsettime))
	{
		wait(self.activateoffsettime);
	}

	thread play_mine_open_anim();
	thread play_mine_fx();
	wait(var_00);
	thread mine_setactive();
}

//Function Number: 23
minefieldsetinactive()
{
	level endon("game_ended");
	level waittill("minefield_beginDisable");
	var_00 = getentarray("mine_field_trigger","targetname");
	foreach(var_02 in var_00)
	{
		thread clearsetupsupportdropvolumes(var_02);
	}

	thread reconnectnodesslowly();
	if(isdefined(level.minelist))
	{
		foreach(var_05 in level.minelist)
		{
			var_05 thread mine_setinactive();
		}
	}

	if(level.currentgen)
	{
		thread cg_minecollisionmovedown();
	}

	level.mineeventcomplete = 1;
	level notify("minefield_complete");
}

//Function Number: 24
minefieldareafx()
{
	thread maps\mp\mp_kremlin_fx::laser_grid_a_fx();
	thread maps\mp\mp_kremlin_fx::laser_grid_b_fx();
}

//Function Number: 25
mine_setactive()
{
	thread mine_handledamage();
	self setcandamage(1);
	self makeentitynomeleetarget();
	var_00 = (0,0,20);
	var_01 = (0,0,128);
	var_02 = [];
	var_03 = self gettagorigin(level.minesettings[self.minetype].tagexplosive1) + var_00;
	var_02[0] = bullettrace(var_03,var_03 + var_01 - var_00,0,self);
	var_04 = var_02[0];
	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		if(var_02[var_05]["position"][2] < var_04["position"][2])
		{
			var_04 = var_02[var_05];
		}
	}

	self.attackheightpos = var_04["position"] - (0,0,20);
	var_06 = spawn("trigger_radius",self.origin,0,self.attackradius,self.attackheight);
	self.attacktrigger = var_06;
	self.attackmovetime = distance(self.origin,self.attackheightpos) / 350;
	thread mine_attacktargets();
}

//Function Number: 26
mine_setinactive()
{
	self setcandamage(0);
	self freeentitysentient();
	if(isdefined(self.activateoffsettime))
	{
		wait(self.activateoffsettime);
	}

	thread play_mine_close_anim();
	if(isdefined(self.attacktrigger))
	{
		self.attacktrigger delete();
	}

	self notify("mine_deactivate");
}

//Function Number: 27
mine_attacktargets()
{
	level endon("game_ended");
	self endon("mine_deactivate");
	for(;;)
	{
		if(!isdefined(self.attacktrigger))
		{
			break;
		}

		self.attacktrigger waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(var_00) && var_00 maps\mp\_utility::_hasperk("specialty_blindeye"))
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_00))
			{
				continue;
			}
		}
		else if(isdefined(var_00.owner))
		{
			continue;
		}

		if(!sighttracepassed(self.attackheightpos,var_00.origin + (0,0,50),0,self) || !sighttracepassed(self gettagorigin(level.minesettings[self.minetype].tagexplosive1) + (0,0,5),var_00.origin + (0,0,50),0,self))
		{
			continue;
		}

		if(level.currentgen)
		{
			self.targetplayer = var_00;
			var_01 = 0;
			var_02 = common_scripts\utility::array_remove(level.minelist,self);
			foreach(var_04 in var_02)
			{
				if(isdefined(var_04.targetplayer) && var_04.targetplayer == self.targetplayer)
				{
					var_01 = 1;
					self.targetplayer = undefined;
					break;
				}
			}

			if(var_01 == 1)
			{
				continue;
			}
		}

		if(isplayer(var_00) && var_00 maps\mp\_utility::_hasperk("specialty_delaymine"))
		{
			var_00 notify("triggered_mine");
			wait(level.delayminetime);
		}
		else
		{
			wait(level.minesettings[self.minetype].graceperiod);
		}

		self playsound(level.minesoundactivatemine);
		if(isdefined(self.explosive) && !isdefined(self.explosive.fired))
		{
			fire_sensor(self.explosive);
		}

		wait(level.minesettings[self.minetype].attackcooldown);
		thread reload_mine();
	}
}

//Function Number: 28
fire_sensor(param_00)
{
	param_00.fired = 1;
	param_00 unlink();
	param_00 rotateyaw(3600,self.attackmovetime);
	param_00 moveto(self.attackheightpos,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
	if(isdefined(param_00.killcament))
	{
		param_00.killcament moveto(self.attackheightpos + level.minekillcamoffset,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
	}

	param_00 playsound(level.minesoundlaunchmine);
	param_00 waittill("movedone");
	param_00 method_856A(level.minesettings["mine"].weaponinfo);
	param_00 hide();
}

//Function Number: 29
mine_handledamage()
{
	self endon("mine_deactivate");
	level endon("game_ended");
	self.health = 999999;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_09))
		{
			var_0A = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			switch(var_0A)
			{
				case "emp_grenade_var_mp":
				case "emp_grenade_mp":
					thread mine_temporary_emp_disable();
					break;
			}
		}

		self.health = 999999;
	}
}

//Function Number: 30
mine_temporary_emp_disable()
{
	level endon("game_ended");
	self notify("mine_emp");
	self endon("mine_emp");
	if(!isdefined(self.empdisable) || self.empdisable == 0)
	{
		self.empdisable = 1;
		if(isdefined(self.attacktrigger))
		{
			self.attacktrigger common_scripts\utility::trigger_off();
		}

		playfxontag(common_scripts\utility::getfx("mine_emp_disable_fx"),self,"tag_origin");
	}

	wait_for_emp_disable_done();
	stopfxontag(common_scripts\utility::getfx("mine_emp_disable_fx"),self,"tag_origin");
	if(isdefined(self.attacktrigger))
	{
		self.attacktrigger common_scripts\utility::trigger_on();
	}

	self.empdisable = 0;
	self notify("emp_Disable_Complete");
}

//Function Number: 31
wait_for_emp_disable_done()
{
	self endon("mine_deactivate");
	var_00 = 0.75;
	wait(level.minesettings[self.minetype].empdisableduration - var_00);
	self notify("emp_disable_almost_complete");
	wait(var_00);
}

//Function Number: 32
spawnsetup()
{
	level.dynamicspawns = ::getlistofgoodspawnpoints;
}

//Function Number: 33
getlistofgoodspawnpoints(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.targetname) || var_03.targetname == "" || var_03 isvalidspawn() == 1)
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_03);
		}
	}

	return var_01;
}

//Function Number: 34
isvalidspawn()
{
	if(level.cancelbadminefieldspawns == 1 && self.targetname == "mineField_spawn")
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
handleminefieldwarningsound()
{
	level endon("game_ended");
	var_00 = common_scripts\utility::getstructarray("speaker_ent","targetname");
	var_01 = 0;
	for(;;)
	{
		if(isdefined(var_00))
		{
			foreach(var_03 in var_00)
			{
				playsoundatpos(var_03.origin,level.minesoundactivatealarm);
			}

			playsoundatpos((0,0,0),level.minesoundactivatealarm);
		}

		wait(4);
		var_01 = var_01 + 1;
		if(var_01 > 2)
		{
			return;
		}
	}
}

//Function Number: 36
play_mine_open_anim()
{
	wait(2.2);
	thread maps\mp\mp_kremlin_fx::snow_puff_fx();
	if(isdefined(self.animationactivate))
	{
		var_00 = 2.94;
		self scriptmodelplayanim(self.animationactivate);
		wait(var_00);
	}

	if(level.nextgen)
	{
		self.minecollision thread minecollisionmoveup();
	}

	if(isdefined(self.animationidleactive))
	{
		self scriptmodelplayanim(self.animationidleactive);
	}

	self notify("mine_opened");
}

//Function Number: 37
play_mine_close_anim()
{
	if(isdefined(self.empdisable) && self.empdisable == 1)
	{
		self waittill("emp_Disable_Complete");
	}

	if(isdefined(self.animationdeactivate))
	{
		var_00 = 5.03;
		self scriptmodelplayanim(self.animationdeactivate);
		wait(var_00);
	}

	if(level.nextgen)
	{
		self.minecollision thread minecollisionmovedown();
	}

	if(isdefined(self.animationidleinactive))
	{
		self scriptmodelplayanim(self.animationidleinactive);
	}
}

//Function Number: 38
minecollisionmoveup()
{
	self moveto(self.origin + (0,0,30),0.5);
}

//Function Number: 39
minecollisionmovedown()
{
	self moveto(self.origin + (0,0,-30),0.5);
}

//Function Number: 40
play_mine_fx()
{
	level endon("game_ended");
	self waittill("mine_opened");
	var_00 = 1;
	self.mine_fx_on = 1;
	playfxontag(common_scripts\utility::getfx("krem_mine_laser_origin_main"),self,"tag_origin");
	if(level.nextgen)
	{
		var_01 = function_02DF(common_scripts\utility::getfx("mine_antenna_light_mp"),self,"tag_fx",var_00,0);
		mine_fx_wait_for_end(var_01);
		if(isdefined(self.mine_fx_on) && self.mine_fx_on == 1)
		{
			killfxontag(common_scripts\utility::getfx("krem_mine_laser_origin_main"),self,"tag_origin");
			if(isdefined(var_01))
			{
				var_01 delete();
			}

			self.mine_fx_on = 0;
			return;
		}

		return;
	}

	mine_fx_wait_for_end();
	if(isdefined(self.mine_fx_on) && self.mine_fx_on == 1)
	{
		killfxontag(common_scripts\utility::getfx("krem_mine_laser_origin_main"),self,"tag_origin");
		self.mine_fx_on = 0;
	}
}

//Function Number: 41
mine_fx_wait_for_end(param_00)
{
	level endon("minefield_complete");
	self endon("mine_deactivate");
	if(isdefined(level.mineeventcomplete) && level.mineeventcomplete == 1)
	{
		return;
	}

	for(;;)
	{
		if(!isdefined(self.empdisable) || self.empdisable == 0)
		{
			self waittill("mine_emp");
		}

		if(isdefined(param_00))
		{
			param_00 hide();
		}

		killfxontag(common_scripts\utility::getfx("krem_mine_laser_origin_main"),self,"tag_origin");
		self.mine_fx_on = 0;
		self waittill("emp_disable_almost_complete");
		if(isdefined(param_00))
		{
			param_00 show();
		}

		playfxontag(common_scripts\utility::getfx("krem_mine_laser_origin_main"),self,"tag_origin");
		self.mine_fx_on = 1;
		common_scripts\utility::waittill_any("emp_Disable_Complete","mine_emp");
	}
}

//Function Number: 42
disconnectnodesslowly()
{
	var_00 = getnodearray("minefield_node","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] disconnectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}

	wait 0.05;
	var_02 = getnodearray("minefield_node","script_noteworthy");
	for(var_01 = 0;var_01 < var_02.size;var_01++)
	{
		var_02[var_01] disconnectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}
}

//Function Number: 43
reconnectnodesslowly()
{
	var_00 = getnodearray("minefield_node","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] connectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}

	wait 0.05;
	var_02 = getnodearray("minefield_node","script_noteworthy");
	for(var_01 = 0;var_01 < var_02.size;var_01++)
	{
		var_02[var_01] connectnode();
		if(var_01 % 50 == 0)
		{
			wait 0.05;
		}
	}
}

//Function Number: 44
setupsupportdropvolumes(param_00)
{
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	level.orbital_util_covered_volumes[level.orbital_util_covered_volumes.size] = param_00;
	while(!isdefined(level.goliath_bad_landing_volumes))
	{
		wait 0.05;
	}

	level.goliath_bad_landing_volumes[level.goliath_bad_landing_volumes.size] = param_00;
}

//Function Number: 45
clearsetupsupportdropvolumes(param_00)
{
	while(!isdefined(level.orbital_util_covered_volumes))
	{
		wait 0.05;
	}

	level.orbital_util_covered_volumes = common_scripts\utility::array_remove(level.orbital_util_covered_volumes,param_00);
	while(!isdefined(level.goliath_bad_landing_volumes))
	{
		wait 0.05;
	}

	level.goliath_bad_landing_volumes = common_scripts\utility::array_remove(level.goliath_bad_landing_volumes,param_00);
}

//Function Number: 46
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

//Function Number: 47
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

//Function Number: 48
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

//Function Number: 49
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

//Function Number: 50
scriptpatchclip()
{
	thread northgallerybigwindow();
	thread atriumsidewallstanding();
	thread westcourtyardvehiclebounds();
	thread bridgeledgewestside();
	thread atriumgrapplegap();
	thread southeasttreeledge();
	thread northwestgrappleintowall();
	thread northwestledgeoutsidetower();
	thread breachhovertowallstand();
}

//Function Number: 51
breachhovertowallstand()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_64_64_64",(2016,-862,769),(0,0,0));
	var_00 = 865;
	for(var_01 = 0;var_01 < 11;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(1984,-830,var_00),(0,0,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 52
northwestledgeoutsidetower()
{
	var_00 = 555.5;
	for(var_01 = 0;var_01 < 12;var_01++)
	{
		maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(2099,345,var_00),(0,0,0));
		var_00 = var_00 + 128;
	}
}

//Function Number: 53
northgallerybigwindow()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1572,1061,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_128_128",(1572,1273,736),(0,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1572,1110,728),(0,0,-25.9002));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1572,1224,728),(180,0,-25.9002));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(1572,1167,775),(0,0,0));
}

//Function Number: 54
atriumsidewallstanding()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1258,-374,429),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1258,-374,685),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1258,-374,941),(0,270,0));
}

//Function Number: 55
westcourtyardvehiclebounds()
{
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(-44,1440,188),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(210,1409,188),(0,256,0));
	maps\mp\_utility::spawnpatchclip("patchclip_vehicle_16_256_256",(458,1347,188),(0,256,0));
}

//Function Number: 56
bridgeledgewestside()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-364.5,215,209),(5,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-620.5,217,186),(5,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(236,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(169,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(105,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(41,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-23,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-87,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-151,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-215,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-279,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-343,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-407,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-471,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-535,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-599,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-663,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-727,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-791,208,303.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(105,208,357.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(41,208,352.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-23,208,347.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-87,208,342.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-151,208,336.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-215,208,329.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-279,208,321.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-343,208,315.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-407,208,313.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-471,208,306.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-535,208,298.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-599,208,295.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-663,208,288.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-727,208,282.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-791,208,277.5),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(256,212,236),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(512,212,236),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(262.344,212,280.126),(0,270,5));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(517.156,212,302.374),(0,270,5));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(158,212,402),(0,270,5));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(168.5,212,403),(0,270,5));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_64_64",(-160,209,288),(0,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-144,199,333.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-176,199,333.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-208,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-240,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-272,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-304,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-336,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-368,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-400,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-432,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-464,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-496,199.5,269.55),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-528,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-560,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-592,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-624,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-656,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-688,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-720,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-752,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-784,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-816,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-848,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-880,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-912,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-944,199.5,269.5),(8,270,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_32_32_32",(-976,199.5,269.5),(8,270,0));
}

//Function Number: 57
atriumgrapplegap()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1264,260,801),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1264,4,801),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1264,-252,801),(270,0,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1384,260,921),(360,180,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1384,4,921),(360,180,-180));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(-1384,-252,921),(360,180,-180));
}

//Function Number: 58
southeasttreeledge()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,160),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,288),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,416),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,544),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,672),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,800),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,928),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,1056),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,1184),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,1312),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-827.5,-514,1440),(0,324,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,160),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,288),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,416),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,544),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,672),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,800),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,928),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,1056),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,1184),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,1312),(0,290.9,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_128_128_128",(-896,-566.5,1440),(0,290.9,0));
}

//Function Number: 59
northwestgrappleintowall()
{
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1698,1823,928),(0,350.3,0));
	maps\mp\_utility::spawnpatchclip("patchclip_player_16_256_256",(1682,1823,928),(0,350.3,0));
}