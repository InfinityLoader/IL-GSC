/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_rcbomb.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 24 ms
 * Timestamp: 10/28/2023 12:10:45 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_flashgrenades;
#include maps/mp/_popups;
#include maps/mp/_scoreevents;
#include maps/mp/_treadfx;
#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_hostmigration;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_shellshock;
#include maps/mp/gametypes/_spawning;
#include maps/mp/gametypes/_tweakables;
#include maps/mp/gametypes/_weaponobjects;
#include maps/mp/killstreaks/_emp;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	precachemodel("veh_t6_drone_rcxd");
	precachemodel("veh_t6_drone_rcxd_alt");
	precachevehicle("rc_car_medium_mp");
	precacherumble("rcbomb_engine_stutter");
	precacherumble("rcbomb_slide");
	loadtreadfx("dust");
	loadtreadfx("concrete");
	loadfx("weapon/grenade/fx_spark_disabled_rc_car");
	loadfx("vehicle/light/fx_rcbomb_blinky_light");
	loadfx("vehicle/light/fx_rcbomb_solid_light");
	loadfx("vehicle/light/fx_rcbomb_light_green_os");
	loadfx("vehicle/light/fx_rcbomb_light_red_os");
	maps/mp/_treadfx::preloadtreadfx("rc_car_medium_mp");
	level._effect["rcbombexplosion"] = loadfx("maps/mp_maps/fx_mp_exp_rc_bomb");
	car_size = GetDvar(#"8660C30");
	if(car_size == "")
	{
		setdvar("scr_rcbomb_car_size","1");
	}

	setdvar("scr_rcbomb_notimeout",0);
	if(maps/mp/gametypes/_tweakables::gettweakablevalue("killstreak","allowrcbomb"))
	{
		maps/mp/killstreaks/_killstreaks::registerkillstreak("rcbomb_mp","rcbomb_mp","killstreak_rcbomb","rcbomb_used",::usekillstreakrcbomb);
		maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("rcbomb_mp",&"KILLSTREAK_EARNED_RCBOMB",&"KILLSTREAK_RCBOMB_NOT_AVAILABLE",&"KILLSTREAK_RCBOMB_INBOUND");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("rcbomb_mp","mpl_killstreak_rcbomb","kls_rcbomb_used","","kls_rcbomb_enemy","","kls_rcbomb_ready");
		maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("rcbomb_mp","scr_givercbomb");
		maps/mp/killstreaks/_killstreaks::allowkillstreakassists("rcbomb_mp",1);
	}
}

//Function Number: 2
register()
{
	registerclientfield("vehicle","rcbomb_death",1,1,"int");
	registerclientfield("vehicle","rcbomb_countdown",1,2,"int");
}

//Function Number: 3
loadtreadfx(type)
{
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type);
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_drift");
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_peel");
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_first_person");
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_reverse");
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_trail");
	loadfx("vehicle/treadfx/fx_treadfx_rcbomb_" + type + "_slow");
}

//Function Number: 4
usekillstreakrcbomb(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	if(!self isonground() || self isusingremote())
	{
		self iprintlnbold(&"KILLSTREAK_RCBOMB_NOT_PLACEABLE");
		return 0;
	}

	placement = self.rcbombplacement;
	if(!(IsDefined(placement)))
	{
		placement = getrcbombplacement();
	}

	if(!(IsDefined(placement)))
	{
		self iprintlnbold(&"KILLSTREAK_RCBOMB_NOT_PLACEABLE");
		return 0;
	}

	if(maps/mp/killstreaks/_killstreaks::isinteractingwithobject())
	{
		self iprintlnbold(&"KILLSTREAK_RCBOMB_NOT_PLACEABLE");
		return 0;
	}

	self setusingremote("rcbomb");
	self freezecontrolswrapper(1);
	result = self maps/mp/killstreaks/_killstreaks::initridekillstreak("rcbomb");
	if(result != "success")
	{
		if(result != "disconnect")
		{
			self clearusingremote();
		}

		return 0;
	}

	if(level.gameended)
	{
		return 0;
	}

	ret = self usercbomb(placement);
	if(!IsDefined(ret) && level.gameended)
	{
		ret = 1;
	}
	else if(!(IsDefined(ret)))
	{
		ret = 0;
	}

	if(IsDefined(self))
	{
		self clearusingremote();
	}

	return ret;
}

//Function Number: 5
spawnrcbomb(placement,team)
{
	car_size = GetDvar(#"8660C30");
	model = "veh_t6_drone_rcxd";
	enemymodel = "veh_t6_drone_rcxd_alt";
	death_model = "veh_t6_drone_rcxd";
	car = "rc_car_medium_mp";
	vehicle = spawnvehicle(model,"rcbomb",car,placement.origin,placement.angles);
	vehicle makevehicleunusable();
	vehicle.death_model = death_model;
	vehicle.allowfriendlyfiredamageoverride = ::rccarallowfriendlyfiredamage;
	vehicle setenemymodel(enemymodel);
	vehicle enableaimassist();
	vehicle setowner(self);
	vehicle setvehicleteam(team);
	vehicle.team = team;
	vehicle setdrawinfrared(1);
	maps/mp/_treadfx::loadtreadfx(vehicle);
	vehicle maps/mp/gametypes/_spawning::create_rcbomb_influencers(team);
	return vehicle;
}

//Function Number: 6
getrcbombplacement()
{
	return calculatespawnorigin(self.origin,self.angles);
}

//Function Number: 7
giveplayercontrolofrcbomb()
{
	self endon("disconnect");
	level endon("game_ended");
	self thread maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("rcbomb_mp",self.team);
	level.globalkillstreakscalled++;
	self addweaponstat("rcbomb_mp","used",1);
	xpamount = maps/mp/killstreaks/_killstreaks::getxpamountforkillstreak("rcbomb_mp");
	if(maps/mp/_scoreevents::shouldaddrankxp(self))
	{
		self addrankxpvalue("killstreakCalledIn",xpamount);
	}

	self freeze_player_controls(0);
	self.rcbomb usevehicle(self,0);
	self thread playerdisconnectwaiter(self.rcbomb);
	self thread cardetonatewaiter(self.rcbomb);
	self thread exitcarwaiter(self.rcbomb);
	self thread gameendwatcher(self.rcbomb);
	self thread changeteamwaiter(self.rcbomb);
	self.rcbomb thread maps/mp/_flashgrenades::monitorrcbombflash();
	self thread cartimer(self.rcbomb);
	self waittill("rcbomb_done");
}

//Function Number: 8
usercbomb(placement)
{
	self endon("disconnect");
	level endon("game_ended");
	hardpointtype = "rcbomb_mp";
	maps/mp/gametypes/_globallogic_utils::waittillslowprocessallowed();
	if(!IsDefined(self) || !isalive(self) || self isremotecontrolling() || self maps/mp/killstreaks/_killstreaks::isinteractingwithobject())
	{
		self iprintlnbold(&"KILLSTREAK_RCBOMB_NOT_PLACEABLE");
		return 0;
	}

	if(!(IsDefined(self.rcbomb)))
	{
		self.rcbomb = self spawnrcbomb(placement,self.team);
		self.rcbomb thread carcleanupwaiter(self.rcbomb);
		self.rcbomb thread trigger_hurt_monitor();
		self.rcbomb.team = self.team;
		if(!(IsDefined(self.rcbomb)))
		{
			return 0;
		}

		self maps/mp/gametypes/_weaponobjects::addweaponobjecttowatcher("rcbomb",self.rcbomb);
	}

	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart(hardpointtype,self.team,undefined,0);
	if(killstreak_id == -1)
	{
		if(IsDefined(self.rcbomb))
		{
			self.rcbomb delete();
		}

		return 0;
	}

	self.rcbomb.killstreak_id = killstreak_id;
	self.enteringvehicle = 1;
	self thread updatekillstreakondisconnect();
	self thread updatekillstreakondeletion(self.team);
	self freeze_player_controls(1);
	if(!IsDefined(self) || !isalive(self) || !IsDefined(self.rcbomb))
	{
		if(IsDefined(self))
		{
			self.enteringvehicle = 0;
			self notify("weapon_object_destroyed");
		}

		return 0;
	}

	self thread giveplayercontrolofrcbomb();
	self.rcbomb thread watchforscramblers();
	self.killstreak_waitamount = 30000;
	self.enteringvehicle = 0;
	self stopshellshock();
	if(IsDefined(level.killstreaks[hardpointtype]) && IsDefined(level.killstreaks[hardpointtype].inboundtext))
	{
		level thread maps/mp/_popups::displaykillstreakteammessagetoall(hardpointtype,self);
	}

	if(IsDefined(level.rcbomb_vision))
	{
		self thread setvisionsetwaiter();
	}

	self updaterulesonend();
	return 1;
}

//Function Number: 9
watchforscramblers()
{
	self endon("death");
	while(1)
	{
		scrambled = self getclientflag(9);
		shouldscramble = 0;
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			if(!IsDefined(players[i]) || !IsDefined(players[i].scrambler))
			{
			}
			else
			{
				player = players[i];
				scrambler = player.scrambler;
				if(level.teambased && self.team == player.team)
				{
				}
				else if(!level.teambased && self.owner == player)
				{
				}
				else if(distancesquared(scrambler.origin,self.origin) < level.scramblerinnerradiussq)
				{
					shouldscramble = 1;
					break;
				}
			}
		}

		if(shouldscramble == 1 && scrambled == 0)
		{
			self setclientflag(9);
		}
		else if(shouldscramble == 0 && scrambled == 1)
		{
			self clearclientflag(9);
		}

		wait_delay = randomfloatrange(0.25,0.5);
		wait(wait_delay);
	}
}

//Function Number: 10
updaterulesonend()
{
	team = self.rcbomb.team;
	killstreak_id = self.rcbomb.killstreak_id;
	self endon("disconnect");
	self waittill("rcbomb_done");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("rcbomb_mp",team,killstreak_id);
}

//Function Number: 11
updatekillstreakondisconnect()
{
	team = self.rcbomb.team;
	killstreak_id = self.rcbomb.killstreak_id;
	self endon("rcbomb_done");
	self waittill("disconnect");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("rcbomb_mp",team,killstreak_id);
}

//Function Number: 12
updatekillstreakondeletion(team)
{
	killstreak_id = self.rcbomb.killstreak_id;
	self endon("disconnect");
	self endon("rcbomb_done");
	self waittill("weapon_object_destroyed");
	maps/mp/killstreaks/_killstreakrules::killstreakstop("rcbomb_mp",team,killstreak_id);
	if(IsDefined(self.rcbomb))
	{
		self.rcbomb delete();
	}
}

//Function Number: 13
cardetonatewaiter(vehicle)
{
	self endon("disconnect");
	vehicle endon("death");
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcher("rcbomb");
	while(!(self attackbuttonpressed()))
	{
		wait(0.05);
	}

	watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(vehicle,0);
	self thread maps/mp/gametypes/_hud::fadetoblackforxsec(GetDvarFloat(#"CDE26736"),GetDvarFloat(#"AFCAD5CD"),GetDvarFloat(#"88490433"),GetDvarFloat(#"A925AA4E"));
}

//Function Number: 14
jumpwaiter(vehicle)
{
	self endon("disconnect");
	vehicle endon("death");
	self.jump_hud = newclienthudelem(self);
	self.jump_hud.alignx = "left";
	self.jump_hud.aligny = "bottom";
	self.jump_hud.horzalign = "user_left";
	self.jump_hud.vertalign = "user_bottom";
	self.jump_hud.font = "small";
	self.jump_hud.hidewheninmenu = 1;
	self.jump_hud.x = 5;
	self.jump_hud.y = -60;
	self.jump_hud.fontscale = 1.25;
	while(1)
	{
		self.jump_hud settext("[{+gostand}]" + "Jump");
		if(self jumpbuttonpressed())
		{
			vehicle launchvehicle((0,0,-1) * -10,vehicle.origin,0);
			self.jump_hud settext("");
			wait(5);
		}

		wait(0.05);
	}
}

//Function Number: 15
playerdisconnectwaiter(vehicle)
{
	vehicle endon("death");
	self endon("rcbomb_done");
	self waittill("disconnect");
	vehicle delete();
}

//Function Number: 16
gameendwatcher(vehicle)
{
	vehicle endon("death");
	self endon("rcbomb_done");
	level waittill("game_ended");
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcher("rcbomb");
	watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(vehicle,0);
	self thread maps/mp/gametypes/_hud::fadetoblackforxsec(GetDvarFloat(#"CDE26736"),GetDvarFloat(#"AFCAD5CD"),GetDvarFloat(#"88490433"),GetDvarFloat(#"A925AA4E"));
}

//Function Number: 17
exitcarwaiter(vehicle)
{
	self endon("disconnect");
	self waittill("unlink");
	self notify("rcbomb_done");
}

//Function Number: 18
changeteamwaiter(vehicle)
{
	self endon("disconnect");
	self endon("rcbomb_done");
	vehicle endon("death");
	self waittill_either("joined_team","joined_spectators");
	vehicle.owner unlink();
	self.killstreak_waitamount = undefined;
	vehicle delete();
}

//Function Number: 19
cardeathwaiter(vehicle)
{
	self endon("disconnect");
	self endon("rcbomb_done");
	self waittill("death");
	maps/mp/killstreaks/_killstreaks::removeusedkillstreak("rcbomb_mp");
	self notify("rcbomb_done");
}

//Function Number: 20
carcleanupwaiter(vehicle)
{
	self endon("disconnect");
	self waittill("death");
	self.rcbomb = undefined;
}

//Function Number: 21
setvisionsetwaiter()
{
	self endon("disconnect");
	self useservervisionset(1);
	self setvisionsetforplayer(level.rcbomb_vision,1);
	self waittill("rcbomb_done");
	self useservervisionset(0);
}

//Function Number: 22
cartimer(vehicle)
{
	self endon("disconnect");
	vehicle endon("death");
	if(!(level.vehiclestimed))
	{
		return;
	}

/#
	if(GetDvarInt(#"B2F33084") != 0)
	{
		return;
	}
#/
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpause(20);
	vehicle setclientfield("rcbomb_countdown",1);
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpause(6);
	vehicle setclientfield("rcbomb_countdown",2);
	maps/mp/gametypes/_hostmigration::waitlongdurationwithhostmigrationpause(4);
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcher("rcbomb");
	watcher thread maps/mp/gametypes/_weaponobjects::waitanddetonate(vehicle,0);
}

//Function Number: 23
detonateiftouchingsphere(origin,radius)
{
	if(distancesquared(self.origin,origin) < radius * radius)
	{
		self rcbomb_force_explode();
	}
}

//Function Number: 24
detonatealliftouchingsphere(origin,radius)
{
	rcbombs = getentarray("rcbomb","targetname");
	for(index = 0;index < rcbombs.size;index++)
	{
		rcbombs[index] detonateiftouchingsphere(origin,radius);
	}
}

//Function Number: 25
blowup(attacker,weaponname)
{
	self.owner endon("disconnect");
	self endon("death");
	explosionorigin = self.origin;
	explosionangles = self.angles;
	if(!(IsDefined(attacker)))
	{
		attacker = self.owner;
	}

	from_emp = maps/mp/killstreaks/_emp::isempweapon(weaponname);
	origin = 10 + VectorScale((0,0,1));
	radius = 256;
	min_damage = 25;
	max_damage = 350;
	if(!(from_emp))
	{
		self radiusdamage(origin,radius,max_damage,min_damage,attacker,"MOD_EXPLOSIVE","rcbomb_mp");
		physicsexplosionsphere(origin,radius,radius,1,max_damage,min_damage);
		maps/mp/gametypes/_shellshock::rcbomb_earthquake(origin);
		playsoundatposition("mpl_rc_exp",self.origin);
		playfx(level._effect["rcbombexplosion"],explosionorigin,(0,0,1));
	}

	self setmodel(self.death_model);
	self hide();
	self setclientfield("rcbomb_death",1);
	if(attacker != self.owner && isplayer(attacker))
	{
		attacker maps/mp/_challenges::destroyrcbomb(weaponname);
		if(self.owner isenemyplayer(attacker))
		{
			maps/mp/_scoreevents::processscoreevent("destroyed_rcbomb",attacker,self.owner,weaponname);
			if(IsDefined(weaponname))
			{
				weaponstatname = "destroyed";
				attacker addweaponstat(weaponname,weaponstatname,1);
				level.globalkillstreaksdestroyed++;
				attacker addweaponstat("rcbomb_mp","destroyed",1);
				attacker addweaponstat(weaponname,"destroyed_controlled_killstreak",1);
			}
		}
		else
		{
		}
	}

	wait(1);
	if(IsDefined(self.neverdelete) && self.neverdelete)
	{
		return;
	}

	if(IsDefined(self.owner.jump_hud))
	{
		self.owner.jump_hud destroy();
	}

	self.owner unlink();
	if(IsDefined(level.gameended) && level.gameended)
	{
		self.owner freezecontrolswrapper(1);
	}

	self.owner.killstreak_waitamount = undefined;
	self delete();
}

//Function Number: 26
rccarallowfriendlyfiredamage(einflictor,eattacker,smeansofdeath,sweapon)
{
	if(IsDefined(eattacker) && eattacker == self.owner)
	{
		return 1;
	}

	if(IsDefined(einflictor) && einflictor islinkedto(self))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
getplacementstartheight()
{
	startheight = 50;
	switch(self getstance())
	{
		case "crouch":
			startheight = 30;
			break;

		case "prone":
			startheight = 15;
			break;
	}

	return startheight;
}

//Function Number: 28
calculatespawnorigin(origin,angles)
{
	distance_from_player = 70;
	startheight = getplacementstartheight();
	mins = VectorScale((-1,-1,0));
	maxs = (5,5,10);
	startpoints = [];
	startangles = [];
	wheelcounts = [];
	testcheck = [];
	largestcount = 0;
	largestcountindex = 0;
	testangles = [];
	testangles[0] = (0,0,0);
	testangles[1] = VectorScale((0,1,0));
	testangles[2] = VectorScale((0,-1,0));
	testangles[3] = VectorScale((0,1,0));
	testangles[4] = VectorScale((0,-1,0));
	heightoffset = 5;
	for(i = 0;i < testangles.size;i++)
	{
		testcheck[i] = 0;
		startangles[i] = (0,angles[1],0);
		startpoint = distance_from_player + VectorScale(AnglesToForward(startangles[i] + testangles[i]));
		endpoint = 100 - VectorScale((0,0,1));
		startpoint = startpoint + (0,0,startheight);
		mask = level.physicstracemaskphysics | level.physicstracemaskvehicle;
		trace = physicstrace(startpoint,endpoint,mins,maxs,self,mask);
		if(IsDefined(trace["entity"]) && isplayer(trace["entity"]))
		{
			wheelcounts[i] = 0;
		}
		else
		{
			startpoints[i] = trace["position"] + (0,0,heightoffset);
			wheelcounts[i] = testwheellocations(startpoints[i],startangles[i],heightoffset);
			if(positionwouldtelefrag(startpoints[i]))
			{
			}
			else
			{
				if(largestcount < wheelcounts[i])
				{
					largestcount = wheelcounts[i];
					largestcountindex = i;
				}

				if(wheelcounts[i] >= 3)
				{
					testcheck[i] = 1;
					if(testspawnorigin(startpoints[i],startangles[i]))
					{
						placement = spawnstruct();
						placement.origin = startpoints[i];
						placement.angles = startangles[i];
						return placement;
					}
				}
			}
		}
	}

	for(i = 0;i < testangles.size;i++)
	{
		if(!(testcheck[i]))
		{
			if(wheelcounts[i] >= 2)
			{
				if(testspawnorigin(startpoints[i],startangles[i]))
				{
					placement = spawnstruct();
					placement.origin = startpoints[i];
					placement.angles = startangles[i];
					return placement;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 29
testwheellocations(origin,angles,heightoffset)
{
	forward = 13;
	side = 10;
	wheels = [];
	wheels[0] = (forward,side,0);
	wheels[1] = (forward,-1 * side,0);
	wheels[2] = (-1 * forward,-1 * side,0);
	wheels[3] = (-1 * forward,side,0);
	height = 5;
	touchcount = 0;
	yawangles = (0,angles[1],0);
	for(i = 0;i < 4;i++)
	{
		wheel = rotatepoint(wheels[i],yawangles);
		startpoint = origin + wheel;
		endpoint = startpoint + (0,0,-1 * height - heightoffset);
		startpoint = startpoint + (0,0,height - heightoffset);
		trace = bullettrace(startpoint,endpoint,0,self);
		if(trace["fraction"] < 1)
		{
			touchcount++;
			rcbomb_debug_line(startpoint,endpoint,(1,0,0));
		}
		else
		{
			rcbomb_debug_line(startpoint,endpoint,(0,0,1));
		}
	}

	return touchcount;
}

//Function Number: 30
testspawnorigin(origin,angles)
{
	liftedorigin = 5 + VectorScale((0,0,1));
	size = 12;
	height = 15;
	mins = (-1 * size,-1 * size,0);
	maxs = (size,size,height);
	absmins = liftedorigin + mins;
	absmaxs = liftedorigin + maxs;
	if(boundswouldtelefrag(absmins,absmaxs))
	{
		rcbomb_debug_box(liftedorigin,mins,maxs,(1,0,0));
		return 0;
	}
	else
	{
		rcbomb_debug_box(liftedorigin,mins,maxs,(0,0,1));
	}

	startheight = getplacementstartheight();
	mask = level.physicstracemaskphysics | level.physicstracemaskvehicle | level.physicstracemaskwater;
	trace = physicstrace(liftedorigin,origin + (0,0,1),mins,maxs,self,mask);
	if(trace["fraction"] < 1)
	{
		rcbomb_debug_box(trace["position"],mins,maxs,(1,0,0));
		return 0;
	}
	else
	{
		rcbomb_debug_box(origin + (0,0,1),mins,maxs,(0,1,0));
	}

	size = 2.5;
	height = size * 2;
	mins = (-1 * size,-1 * size,0);
	maxs = (size,size,height);
	sweeptrace = physicstrace(self.origin + (0,0,startheight),liftedorigin,mins,maxs,self,mask);
	if(sweeptrace["fraction"] < 1)
	{
		rcbomb_debug_box(sweeptrace["position"],mins,maxs,(1,0,0));
		return 0;
	}

	return 1;
}

//Function Number: 31
trigger_hurt_monitor()
{
	self endon("death");
	for(;;)
	{
		self waittill("touch",ent);
		if(ent.classname == "trigger_hurt")
		{
			if(level.script == "mp_castaway")
			{
				if(ent.spawnflags & 16)
				{
					if(self depthinwater() < 23)
					{
						continue;
					}
				}
			}

			self rcbomb_force_explode();
			return;
		}
	}
}

//Function Number: 32
rcbomb_force_explode()
{
	self endon("death");
/#
	assert(self.targetname == "rcbomb");
		for(;;)
		{
#/
		if(!(IsDefined(self getseatoccupant(0))))
		{
			wait(0.1);
		}
	}

	self dodamage(10,10 + VectorScale((0,0,1)),self.origin,self.owner,self.owner,"none");
}

//Function Number: 33
rcbomb_debug_box(origin,mins,maxs,color)
{
/#
	debug_rcbomb = GetDvar(#"8EAE5CA0");
	if(debug_rcbomb == "1")
	{
		box(origin,mins,maxs,0,color,1,1,300);
	}
#/
}

//Function Number: 34
rcbomb_debug_line(start,end,color)
{
/#
	debug_rcbomb = GetDvar(#"8EAE5CA0");
	if(debug_rcbomb == "1")
	{
		line(start,end,color,1,1,300);
	}
#/
}