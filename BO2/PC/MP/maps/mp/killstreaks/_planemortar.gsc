/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_planemortar.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 4 ms
 * Timestamp: 10/28/2023 12:10:44 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_spawning;
#include maps/mp/killstreaks/_airsupport;
#include maps/mp/killstreaks/_killstreakrules;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
init()
{
	precachemodel("veh_t6_air_fa38_killstreak");
	precachemodel("veh_t6_air_fa38_killstreak_alt");
	precachelocationselector("map_mortar_selector");
	level.planemortarexhaustfx = loadfx("vehicle/exhaust/fx_exhaust_f35_afterburner");
	registerclientfield("scriptmover","planemortar_contrail",1,1,"int");
	maps/mp/killstreaks/_killstreaks::registerkillstreak("planemortar_mp","planemortar_mp","killstreak_planemortar","planemortar_used",::usekillstreakplanemortar,1);
	maps/mp/killstreaks/_killstreaks::registerkillstreakstrings("planemortar_mp",&"MP_EARNED_PLANEMORTAR",&"KILLSTREAK_PLANEMORTAR_NOT_AVAILABLE",&"MP_WAR_PLANEMORTAR_INBOUND",&"MP_WAR_PLANEMORTAR_INBOUND_NEAR_YOUR_POSITION");
	maps/mp/killstreaks/_killstreaks::registerkillstreakdialog("planemortar_mp","mpl_killstreak_planemortar","kls_planemortar_used","","kls_planemortar_enemy","","kls_planemortar_ready");
	maps/mp/killstreaks/_killstreaks::registerkillstreakdevdvar("planemortar_mp","scr_giveplanemortar");
	maps/mp/killstreaks/_killstreaks::setkillstreakteamkillpenaltyscale("planemortar_mp",level.teamkillreducedpenalty);
}

//Function Number: 2
usekillstreakplanemortar(hardpointtype)
{
	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		return 0;
	}

	self thread playpilotdialog("a10_used",1.5);
	result = self selectplanemortarlocation(hardpointtype);
	if(!IsDefined(result) || !result)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
waittill_confirm_location()
{
	self endon("emp_jammed");
	self endon("emp_grenaded");
	self waittill("confirm_location",location);
	return location;
}

//Function Number: 4
selectplanemortarlocation(hardpointtype)
{
	self beginlocationmortarselection("map_mortar_selector",800);
	self.selectinglocation = 1;
	self thread endselectionthink();
	locations = [];
	if(!IsDefined(self.pers["mortarRadarUsed"]) || !self.pers["mortarRadarUsed"])
	{
		self thread singleradarsweep();
	}

	for(i = 0;i < 3;i++)
	{
		location = self waittill_confirm_location();
		if(!(IsDefined(self)))
		{
			return 0;
		}

		if(!(IsDefined(location)))
		{
			self.pers["mortarRadarUsed"] = 1;
			self notify("cancel_selection");
			return 0;
		}

		locations[i] = location;
	}

	if(self maps/mp/killstreaks/_killstreakrules::iskillstreakallowed(hardpointtype,self.team) == 0)
	{
		self.pers["mortarRadarUsed"] = 1;
		self notify("cancel_selection");
		return 0;
	}

	self.pers["mortarRadarUsed"] = 0;
	return self finishhardpointlocationusage(locations,::useplanemortar);
}

//Function Number: 5
playpilotdialog(dialog,waittime)
{
	if(IsDefined(waittime))
	{
		wait(waittime);
	}

	self.pilotvoicenumber = self.bcvoicenumber + 1;
	soundalias = level.teamprefix[self.team] + self.pilotvoicenumber + "_" + dialog;
	if(IsDefined(self))
	{
		if(self.pilotisspeaking)
		{
			while(self.pilotisspeaking)
			{
				wait(0.2);
			}
		}
	}

	if(IsDefined(self))
	{
		self playlocalsound(soundalias);
		self.pilotisspeaking = 1;
		self thread waitplaybacktime(soundalias);
		self waittill_any(soundalias,"death","disconnect");
		if(IsDefined(self))
		{
			self.pilotisspeaking = 0;
		}
	}
}

//Function Number: 6
waitplaybacktime(soundalias)
{
	self endon("death");
	self endon("disconnect");
	playbacktime = soundgetplaybacktime(soundalias);
	if(playbacktime >= 0)
	{
		waittime = playbacktime * 0.001;
		wait(waittime);
	}
	else
	{
		wait(1);
	}

	self notify(soundalias);
}

//Function Number: 7
singleradarsweep()
{
	self endon("disconnect");
	self endon("cancel_selection");
	wait(0.5);
	self playlocalsound("mpl_killstreak_satellite");
	if(level.teambased)
	{
		has_satellite = level.activesatellites[self.team] > 0;
	}
	else
	{
		has_satellite = level.activesatellites[self.entnum] > 0;
	}

	if(self.hasspyplane == 0 && !has_satellite && !level.forceradar)
	{
		self thread doradarsweep();
	}
}

//Function Number: 8
doradarsweep()
{
	self setclientuivisibilityflag("g_compassShowEnemies",1);
	wait(0.2);
	self setclientuivisibilityflag("g_compassShowEnemies",0);
}

//Function Number: 9
useplanemortar(positions)
{
	team = self.team;
	killstreak_id = self maps/mp/killstreaks/_killstreakrules::killstreakstart("planemortar_mp",team,0,1);
	if(killstreak_id == -1)
	{
		return 0;
	}

	self maps/mp/killstreaks/_killstreaks::playkillstreakstartdialog("planemortar_mp",team,1);
	level.globalkillstreakscalled++;
	self addweaponstat("planemortar_mp","used",1);
	self thread planemortar_watchforendnotify(team,killstreak_id);
	self thread doplanemortar(positions,team,killstreak_id);
	return 1;
}

//Function Number: 10
doplanemortar(positions,team,killstreak_id)
{
	self endon("emp_jammed");
	self endon("disconnect");
	yaw = randomintrange(0,360);
	odd = 0;
	wait(1.25);
	foreach(position in positions)
	{
		maps/mp/gametypes/_spawning::create_artillery_influencers(position,-1);
		self thread dobombrun(position,yaw,team);
		if(odd == 0)
		{
			yaw = yaw + 35 % 360;
		}
		else
		{
			yaw = yaw + 290 % 360;
		}

		odd = odd + 1 % 2;
		wait(0.8);
	}

	self notify("planemortarcomplete",_k221);
	wait(1);
	self thread plane_mortar_bda_dialog();
}

//Function Number: 11
plane_mortar_bda_dialog()
{
	if(!(IsDefined(self.planemortarbda)))
	{
		self.planemortarbda = 0;
	}

	if(self.planemortarbda == 0)
	{
		bdadialog = "kls_killn";
	}

	if(self.planemortarbda == 1)
	{
		bdadialog = "kls_kill1";
	}

	if(self.planemortarbda == 2)
	{
		bdadialog = "kls_kill2";
	}

	if(self.planemortarbda == 3)
	{
		bdadialog = "kls_kill3";
	}

	if(self.planemortarbda > 3)
	{
		bdadialog = "kls_killm";
	}

	if(IsDefined(bdadialog))
	{
		self thread playpilotdialog(bdadialog);
	}

	self.planemortarbda = 0;
}

//Function Number: 12
planemortar_watchforendnotify(team,killstreak_id)
{
	self waittill_any("disconnect","joined_team","joined_spectators","planemortarcomplete","emp_jammed");
	planemortar_killstreakstop(team,killstreak_id);
}

//Function Number: 13
planemortar_killstreakstop(team,killstreak_id)
{
	maps/mp/killstreaks/_killstreakrules::killstreakstop("planemortar_mp",team,killstreak_id);
}

//Function Number: 14
dobombrun(position,yaw,team)
{
	self endon("emp_jammed");
	player = self;
	angles = (0,yaw,0);
	direction = AnglesToForward(angles);
	height = maps/mp/killstreaks/_airsupport::getminimumflyheight() + 2000;
	position = (position[0],position[1],height);
	startpoint = -12000 + VectorScale(direction);
	endpoint = 18000 + VectorScale(direction);
	height = getnoflyzoneheightcrossed(startpoint,endpoint,height);
	startpoint = (startpoint[0],startpoint[1],height);
	position = (position[0],position[1],height);
	endpoint = (endpoint[0],endpoint[1],height);
	plane = spawnplane(self,"script_model",startpoint);
	plane.team = team;
	plane.targetname = "plane_mortar";
	plane.owner = self;
	plane endon("delete",position,position);
	plane endon("death");
	plane thread planewatchforemp(self);
	plane.angles = angles;
	plane setmodel("veh_t6_air_fa38_killstreak");
	plane setenemymodel("veh_t6_air_fa38_killstreak_alt");
	plane setclientfield("planemortar_contrail",1);
	plane playsound("mpl_lightning_flyover_boom");
	plane setdrawinfrared(1);
	plane.killcament = spawn("script_model",-1500 + VectorScale(direction));
	plane.killcament deleteaftertime(2 * 3);
	plane.killcament.angles = (15,yaw,0);
	plane.killcament.starttime = GetTime();
	plane.killcament linkto(plane);
	start = (position[0],position[1],plane.origin[2]);
	impact = bullettrace(start,100000 + VectorScale((0,0,-1)),start,1);
	plane moveto(endpoint,2 * 5 / 4,0,0);
	plane.killcament thread followbomb(plane,position,direction,impact,player);
	wait(2 / 2);
	if(IsDefined(self))
	{
		self thread dropbomb(plane,position);
	}

	wait(2 * 3 / 4);
	plane plane_cleanupondeath();
}

//Function Number: 15
followbomb(plane,position,direction,impact,player)
{
	player endon("emp_jammed");
	wait(2 * 5 / 12);
	plane.killcament unlink();
	plane.killcament moveto(-600 + VectorScale(direction),1000 + VectorScale((0,0,1)),impact["position"],0.8);
}

//Function Number: 16
lookatexplosion(bomb)
{
	while(IsDefined(self) && IsDefined(bomb))
	{
		angles = VectorToAngles(vectornormalize(bomb.origin - self.origin));
		self.angles = (max(angles[0],15),angles[1],angles[2]);
		wait(0.05);
	}
}

//Function Number: 17
planewatchforemp(owner)
{
	self endon("delete");
	self endon("death");
	self waittill("emp_deployed",attacker);
	thread planeawardscoreevent(attacker,self);
	self plane_cleanupondeath();
}

//Function Number: 18
planeawardscoreevent(attacker,victim)
{
	attacker endon("disconnect");
	attacker notify("planeAwardScoreEvent_singleton");
	attacker endon("planeAwardScoreEvent_singleton");
	waittillframeend;
	maps/mp/_scoreevents::processscoreevent("destroyed_plane_mortar",attacker,victim,"emp_mp");
	attacker maps/mp/_challenges::addflyswatterstat("emp_mp");
}

//Function Number: 19
plane_cleanupondeath()
{
	self delete();
}

//Function Number: 20
dropbomb(plane,bombposition)
{
	if(!(IsDefined(plane.owner)))
	{
		return;
	}

	targets = getplayers();
	foreach(target in targets)
	{
		if(plane.owner isenemyplayer(target) && distance2dsquared(target.origin,bombposition) < 250000)
		{
			if(bullettracepassed((target.origin[0],target.origin[1],plane.origin[2]),target.origin,0,plane))
			{
				bombposition = target.origin;
				break;
			}
		}
	}

	bombposition = (bombposition[0],bombposition[1],plane.origin[2]);
	bomb = self launchbomb("planemortar_mp",bombposition,VectorScale((0,0,-1)));
	bomb playsound("mpl_lightning_bomb_incoming");
	bomb.killcament = plane.killcament;
	plane.killcament thread lookatexplosion(bomb);
}