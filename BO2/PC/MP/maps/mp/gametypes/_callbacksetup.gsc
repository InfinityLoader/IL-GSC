/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_callbacksetup.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 3 ms
 * Timestamp: 10/28/2023 12:10:28 AM
*******************************************************************/

#include maps/mp/_audio;
#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_actor;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_globallogic_vehicle;
#include maps/mp/gametypes/_hostmigration;

//Function Number: 1
codecallback_startgametype()
{
	if(!IsDefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[ level.callbackstartgametype ]]();
		level.gametypestarted = 1;
	}
}

//Function Number: 2
codecallback_finalizeinitialization()
{
	maps/mp/_utility::callback("on_finalize_initialization");
}

//Function Number: 3
codecallback_playerconnect()
{
	self endon("disconnect");
	self thread maps/mp/_audio::monitor_player_sprint();
	[[ level.callbackplayerconnect ]]();
}

//Function Number: 4
codecallback_playerdisconnect()
{
	self notify("disconnect");
	level notify("disconnect",self);
	client_num = self getentitynumber();
	[[ level.callbackplayerdisconnect ]]();
}

//Function Number: 5
codecallback_hostmigration()
{
/#
	println("****CodeCallback_HostMigration****");
#/
	[[ level.callbackhostmigration ]]();
}

//Function Number: 6
codecallback_hostmigrationsave()
{
/#
	println("****CodeCallback_HostMigrationSave****");
#/
	[[ level.callbackhostmigrationsave ]]();
}

//Function Number: 7
codecallback_playermigrated()
{
/#
	println("****CodeCallback_PlayerMigrated****");
#/
	[[ level.callbackplayermigrated ]]();
}

//Function Number: 8
codecallback_playerdamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,boneindex)
{
	self endon("disconnect");
	[[ level.callbackplayerdamage ]](einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,boneindex);
}

//Function Number: 9
codecallback_playerkilled(einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset,deathanimduration)
{
	self endon("disconnect");
	[[ level.callbackplayerkilled ]](einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset,deathanimduration);
}

//Function Number: 10
codecallback_playerlaststand(einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset,deathanimduration)
{
	self endon("disconnect");
	[[ level.callbackplayerlaststand ]](einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset,deathanimduration);
}

//Function Number: 11
codecallback_playermelee(eattacker,idamage,sweapon,vorigin,vdir,boneindex,shieldhit)
{
	self endon("disconnect");
	[[ level.callbackplayermelee ]](eattacker,idamage,sweapon,vorigin,vdir,boneindex,shieldhit);
}

//Function Number: 12
codecallback_actordamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,boneindex)
{
	[[ level.callbackactordamage ]](einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,boneindex);
}

//Function Number: 13
codecallback_actorkilled(einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset)
{
	[[ level.callbackactorkilled ]](einflictor,eattacker,idamage,smeansofdeath,sweapon,vdir,shitloc,timeoffset);
}

//Function Number: 14
codecallback_vehicledamage(einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,damagefromunderneath,modelindex,partname)
{
	[[ level.callbackvehicledamage ]](einflictor,eattacker,idamage,idflags,smeansofdeath,sweapon,vpoint,vdir,shitloc,timeoffset,damagefromunderneath,modelindex,partname);
}

//Function Number: 15
codecallback_vehicleradiusdamage(einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,timeoffset)
{
	[[ level.callbackvehicleradiusdamage ]](einflictor,eattacker,idamage,finnerdamage,fouterdamage,idflags,smeansofdeath,sweapon,vpoint,fradius,fconeanglecos,vconedir,timeoffset);
}

//Function Number: 16
codecallback_faceeventnotify(notify_msg,ent)
{
	if(IsDefined(ent) && IsDefined(ent.do_face_anims) && ent.do_face_anims)
	{
		if(IsDefined(level.face_event_handler) && IsDefined(level.face_event_handler.events[notify_msg]))
		{
			ent sendfaceevent(level.face_event_handler.events[notify_msg]);
		}
	}
}

//Function Number: 17
codecallback_menuresponse(action,arg)
{
	if(!(IsDefined(level.menuresponsequeue)))
	{
		level.menuresponsequeue = [];
		level thread menuresponsequeuepump();
	}

	index = level.menuresponsequeue.size;
	level.menuresponsequeue[index] = spawnstruct();
	level.menuresponsequeue[index].action = action;
	level.menuresponsequeue[index].arg = arg;
	level.menuresponsequeue[index].ent = self;
	level notify("menuresponse_queue");
}

//Function Number: 18
menuresponsequeuepump()
{
	while(1)
	{
		level waittill("menuresponse_queue");
		level.menuresponsequeue[0].ent notify("menuresponse",level.menuresponsequeue[0].action,level.menuresponsequeue[0].arg);
		arrayremoveindex(level.menuresponsequeue,0,0);
		wait(0.05);
		if(!(level.menuresponsequeue.size > 0))
		{
		}
	}
}

//Function Number: 19
setupcallbacks()
{
	setdefaultcallbacks();
	level.idflags_radius = 1;
	level.idflags_no_armor = 2;
	level.idflags_no_knockback = 4;
	level.idflags_penetration = 8;
	level.idflags_destructible_entity = 16;
	level.idflags_shield_explosive_impact = 32;
	level.idflags_shield_explosive_impact_huge = 64;
	level.idflags_shield_explosive_splash = 128;
	level.idflags_no_team_protection = 256;
	level.idflags_no_protection = 512;
	level.idflags_passthru = 1024;
}

//Function Number: 20
setdefaultcallbacks()
{
	level.callbackstartgametype = maps/mp/gametypes/_globallogic::callback_startgametype;
	level.callbackplayerconnect = maps/mp/gametypes/_globallogic_player::callback_playerconnect;
	level.callbackplayerdisconnect = maps/mp/gametypes/_globallogic_player::callback_playerdisconnect;
	level.callbackplayerdamage = maps/mp/gametypes/_globallogic_player::callback_playerdamage;
	level.callbackplayerkilled = maps/mp/gametypes/_globallogic_player::callback_playerkilled;
	level.callbackplayermelee = maps/mp/gametypes/_globallogic_player::callback_playermelee;
	level.callbackplayerlaststand = maps/mp/gametypes/_globallogic_player::callback_playerlaststand;
	level.callbackactordamage = maps/mp/gametypes/_globallogic_actor::callback_actordamage;
	level.callbackactorkilled = maps/mp/gametypes/_globallogic_actor::callback_actorkilled;
	level.callbackvehicledamage = maps/mp/gametypes/_globallogic_vehicle::callback_vehicledamage;
	level.callbackvehicleradiusdamage = maps/mp/gametypes/_globallogic_vehicle::callback_vehicleradiusdamage;
	level.callbackplayermigrated = maps/mp/gametypes/_globallogic_player::callback_playermigrated;
	level.callbackhostmigration = maps/mp/gametypes/_hostmigration::callback_hostmigration;
	level.callbackhostmigrationsave = maps/mp/gametypes/_hostmigration::callback_hostmigrationsave;
}

//Function Number: 21
abortlevel()
{
/#
	println("ERROR: Aborting level - gametype is not supported");
#/
	level.callbackstartgametype = ::callbackvoid;
	level.callbackplayerconnect = ::callbackvoid;
	level.callbackplayerdisconnect = ::callbackvoid;
	level.callbackplayerdamage = ::callbackvoid;
	level.callbackplayerkilled = ::callbackvoid;
	level.callbackplayerlaststand = ::callbackvoid;
	level.callbackplayermelee = ::callbackvoid;
	level.callbackactordamage = ::callbackvoid;
	level.callbackactorkilled = ::callbackvoid;
	level.callbackvehicledamage = ::callbackvoid;
	setdvar("g_gametype","dm");
	exitlevel(0);
}

//Function Number: 22
codecallback_glasssmash(pos,dir)
{
	level notify("glass_smash",pos,dir);
}

//Function Number: 23
callbackvoid()
{
}