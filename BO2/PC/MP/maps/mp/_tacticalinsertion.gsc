/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_tacticalinsertion.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 49 ms
 * Timestamp: 10/27/2023 3:01:36 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_challenges;
#include maps/mp/_hacker_tool;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include maps/mp/gametypes/_damagefeedback;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_player;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weaponobjects;

//Function Number: 1
init()
{
	level.tacticalinsertionweapon = "tactical_insertion_mp";
	precachemodel("t6_wpn_tac_insert_world");
	loadfx("misc/fx_equip_tac_insert_light_grn");
	loadfx("misc/fx_equip_tac_insert_light_red");
	level._effect["tacticalInsertionFizzle"] = loadfx("misc/fx_equip_tac_insert_exp");
	maps/mp/gametypes/_globallogic_audio::registerdialoggroup("item_destroyed",1);
}

//Function Number: 2
istacspawntouchingcrates(origin,angles)
{
	crate_ents = getentarray("care_package","script_noteworthy");
	mins = (-17,-17,-40);
	maxs = (17,17,40);
	for(i = 0;i < crate_ents.size;i++)
	{
		if(crate_ents[i] istouchingvolume(40 + VectorScale((0,0,1)),origin,mins))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 3
overridespawn(ispredictedspawn)
{
	if(!(IsDefined(self.tacticalinsertion)))
	{
		return 0;
	}

	origin = self.tacticalinsertion.origin;
	angles = self.tacticalinsertion.angles;
	team = self.tacticalinsertion.team;
	if(!(ispredictedspawn))
	{
		self.tacticalinsertion destroy_tactical_insertion();
	}

	if(team != self.team)
	{
		return 0;
	}

	if(istacspawntouchingcrates(origin))
	{
		return 0;
	}

	if(!(ispredictedspawn))
	{
		self.tacticalinsertiontime = GetTime();
		self spawn(origin,angles,"tactical insertion");
		self setspawnclientflag("SCDFL_DISABLE_LOGGING");
		self addweaponstat("tactical_insertion_mp","used",1);
	}

	return 1;
}

//Function Number: 4
waitanddelete(time)
{
	self endon("death");
	wait(0.05);
	self delete();
}

//Function Number: 5
watch(player)
{
	if(IsDefined(player.tacticalinsertion))
	{
		player.tacticalinsertion destroy_tactical_insertion();
	}

	player thread spawntacticalinsertion();
	self waitanddelete(0.05);
}

//Function Number: 6
watchusetrigger(trigger,callback,playersoundonuse,npcsoundonuse)
{
	self endon("delete");
	while(1)
	{
		trigger waittill("trigger",player);
		if(!(isalive(player)))
		{
			continue;
		}

		if(!(player isonground()))
		{
			continue;
		}

		if(IsDefined(trigger.triggerteam) && player.team != trigger.triggerteam)
		{
			continue;
		}

		if(IsDefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore)
		{
			continue;
		}

		if(IsDefined(trigger.claimedby) && player != trigger.claimedby)
		{
			continue;
		}

		if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed())
		{
			if(IsDefined(playersoundonuse))
			{
				player playlocalsound(playersoundonuse);
			}

			if(IsDefined(npcsoundonuse))
			{
				player playsound(npcsoundonuse);
			}

			self thread [[ callback ]](player);
		}
	}
}

//Function Number: 7
watchdisconnect()
{
	self.tacticalinsertion endon("delete");
	self waittill("disconnect");
	self.tacticalinsertion thread destroy_tactical_insertion();
}

//Function Number: 8
destroy_tactical_insertion(attacker)
{
	self.owner.tacticalinsertion = undefined;
	self notify("delete");
	self.owner notify("tactical_insertion_destroyed");
	self.friendlytrigger delete();
	self.enemytrigger delete();
	if(IsDefined(attacker) && IsDefined(attacker.pers["team"]) && IsDefined(self.owner) && IsDefined(self.owner.pers["team"]))
	{
		if(level.teambased)
		{
			if(attacker.pers["team"] != self.owner.pers["team"])
			{
				attacker notify("destroyed_explosive");
				attacker maps/mp/_challenges::destroyedequipment();
				attacker maps/mp/_challenges::destroyedtacticalinsert();
				maps/mp/_scoreevents::processscoreevent("destroyed_tac_insert",attacker);
			}
		}
		else if(attacker != self.owner)
		{
			attacker notify("destroyed_explosive");
			attacker maps/mp/_challenges::destroyedequipment();
			attacker maps/mp/_challenges::destroyedtacticalinsert();
			maps/mp/_scoreevents::processscoreevent("destroyed_tac_insert",attacker);
		}
	}

	self delete();
}

//Function Number: 9
fizzle(attacker)
{
	if(IsDefined(self.fizzle) && self.fizzle)
	{
		return;
	}

	self.fizzle = 1;
	playfx(level._effect["tacticalInsertionFizzle"],self.origin);
	self playsound("dst_tac_insert_break");
	if(IsDefined(attacker) && attacker != self.owner)
	{
		self.owner maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer("tact_destroyed","item_destroyed");
	}

	self destroy_tactical_insertion(attacker);
}

//Function Number: 10
pickup(attacker)
{
	player = self.owner;
	self destroy_tactical_insertion();
	player giveweapon(level.tacticalinsertionweapon);
	player setweaponammoclip(level.tacticalinsertionweapon,1);
}

//Function Number: 11
spawntacticalinsertion()
{
	self endon("disconnect");
	self.tacticalinsertion = spawn("script_model",self.origin + (0,0,1));
	self.tacticalinsertion setmodel("t6_wpn_tac_insert_world");
	self.tacticalinsertion.origin = self.origin + (0,0,1);
	self.tacticalinsertion.angles = self.angles;
	self.tacticalinsertion.team = self.team;
	self.tacticalinsertion setteam(self.team);
	self.tacticalinsertion.owner = self;
	self.tacticalinsertion setowner(self);
	self.tacticalinsertion setweapon(level.tacticalinsertionweapon);
	self.tacticalinsertion thread maps/mp/gametypes/_weaponobjects::attachreconmodel("t6_wpn_tac_insert_detect",self);
	self.tacticalinsertion endon("delete");
	self.tacticalinsertion maps/mp/_hacker_tool::registerwithhackertool(level.equipmenthackertoolradius,level.equipmenthackertooltimems);
	triggerheight = 64;
	triggerradius = 128;
	self.tacticalinsertion.friendlytrigger = spawn("trigger_radius_use",3 + VectorScale((0,0,1)));
	self.tacticalinsertion.friendlytrigger setcursorhint("HINT_NOICON",self.tacticalinsertion);
	self.tacticalinsertion.friendlytrigger sethintstring(&"MP_TACTICAL_INSERTION_PICKUP");
	if(level.teambased)
	{
		self.tacticalinsertion.friendlytrigger setteamfortrigger(self.team);
		self.tacticalinsertion.friendlytrigger.triggerteam = self.team;
	}

	self clientclaimtrigger(self.tacticalinsertion.friendlytrigger);
	self.tacticalinsertion.friendlytrigger.claimedby = self;
	self.tacticalinsertion.enemytrigger = spawn("trigger_radius_use",3 + VectorScale((0,0,1)));
	self.tacticalinsertion.enemytrigger setcursorhint("HINT_NOICON",self.tacticalinsertion);
	self.tacticalinsertion.enemytrigger sethintstring(&"MP_TACTICAL_INSERTION_DESTROY");
	self.tacticalinsertion.enemytrigger setinvisibletoplayer(self);
	if(level.teambased)
	{
		self.tacticalinsertion.enemytrigger setexcludeteamfortrigger(self.team);
		self.tacticalinsertion.enemytrigger.triggerteamignore = self.team;
	}

	self.tacticalinsertion setclientflag(2);
	self thread watchdisconnect();
	watcher = maps/mp/gametypes/_weaponobjects::getweaponobjectwatcherbyweapon(level.tacticalinsertionweapon);
	self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.friendlytrigger,::pickup,watcher.pickupsoundplayer,watcher.pickupsound);
	self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.enemytrigger,::fizzle);
	if(IsDefined(self.tacticalinsertioncount))
	{
		self.tacticalinsertioncount++;
	}
	else
	{
		self.tacticalinsertioncount = 1;
	}

	self.tacticalinsertion setcandamage(1);
	self.tacticalinsertion.health = 1;
	while(1)
	{
		self.tacticalinsertion waittill(self.tacticalinsertion.origin,self.tacticalinsertion.origin,"damage",damage,attacker,direction,point,type,tagname,modelname,partname,weaponname,idflags);
		if(level.teambased && (!IsDefined(attacker) || !isplayer(attacker) || attacker.team == self.team) && attacker != self)
		{
			continue;
		}

		if(attacker != self)
		{
			attacker maps/mp/_challenges::destroyedequipment(weaponname);
			attacker maps/mp/_challenges::destroyedtacticalinsert();
			maps/mp/_scoreevents::processscoreevent("destroyed_tac_insert",attacker);
		}

		if(IsDefined(weaponname))
		{
			switch(weaponname)
			{
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					continue;
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					break;
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
	!level.teambased && self.tacticalinsertion.owner != attacker
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
	level.teambased && self.tacticalinsertion.owner.team != attacker.team
					break;

				default:
					attacker maps/mp/gametypes/_damagefeedback::updatedamagefeedback();
					break;
	maps/mp/gametypes/_globallogic_player::dodamagefeedback(weaponname,attacker)
					break;
			}
		}

		if(IsDefined(attacker) && attacker != self)
		{
			self maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer("tact_destroyed","item_destroyed");
		}

		self.tacticalinsertion thread fizzle();
	}
}

//Function Number: 12
cancel_button_think()
{
	if(!(IsDefined(self.tacticalinsertion)))
	{
		return;
	}

	text = cancel_text_create();
	self thread cancel_button_press();
	event = self waittill_any_return("tactical_insertion_destroyed","disconnect","end_killcam","abort_killcam","tactical_insertion_canceled","spawned");
	if(event == "tactical_insertion_canceled")
	{
		self.tacticalinsertion destroy_tactical_insertion();
	}

	if(IsDefined(text))
	{
		text destroy();
	}
}

//Function Number: 13
canceltackinsertionbutton()
{
	if(level.console)
	{
		return self changeseatbuttonpressed();
	}
	else
	{
		return self jumpbuttonpressed();
	}
}

//Function Number: 14
cancel_button_press()
{
	self endon("disconnect");
	self endon("end_killcam");
	self endon("abort_killcam");
	while(1)
	{
		wait(0.05);
		if(self canceltackinsertionbutton())
		{
			break;
		}
	}

	self notify("tactical_insertion_canceled");
}

//Function Number: 15
cancel_text_create()
{
	text = newclienthudelem(self);
	text.archived = 0;
	text.y = -100;
	text.alignx = "center";
	text.aligny = "middle";
	text.horzalign = "center";
	text.vertalign = "bottom";
	text.sort = 10;
	text.font = "small";
	text.foreground = 1;
	text.hidewheninmenu = 1;
	if(self issplitscreen())
	{
		text.y = -80;
		text.fontscale = 1.2;
	}
	else
	{
		text.fontscale = 1.6;
	}

	text settext(&"PLATFORM_PRESS_TO_CANCEL_TACTICAL_INSERTION");
	text.alpha = 1;
	return text;
}

//Function Number: 16
gettacticalinsertions()
{
	tac_inserts = [];
	foreach(player in level.players)
	{
		if(IsDefined(player.tacticalinsertion))
		{
			tac_inserts[tac_inserts.size] = player.tacticalinsertion;
		}
	}

	return tac_inserts;
}

//Function Number: 17
tacticalinsertiondestroyedbytrophysystem(attacker,trophysystem)
{
	owner = self.owner;
	if(IsDefined(attacker))
	{
		attacker maps/mp/_challenges::destroyedequipment(trophysystem.name);
		attacker maps/mp/_challenges::destroyedtacticalinsert();
	}

	self thread fizzle();
	if(IsDefined(owner))
	{
		owner endon("death");
		owner endon("disconnect");
		wait(0.05);
		owner maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer("tact_destroyed","item_destroyed");
	}
}