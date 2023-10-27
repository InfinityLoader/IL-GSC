/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_ims.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 49
 * Decompile Time: 824 ms
 * Timestamp: 10/27/2023 1:32:47 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["ims"] = ::func_843D;
	level.imssettings = [];
	var_00 = addstruct();
	var_00.weaponinfo = "ims_projectile_mp";
	var_00.modelbase = "ims_scorpion_body_iw6";
	var_00.modelplacement = "ims_scorpion_body_iw6_placement";
	var_00.modelplacementfailed = "ims_scorpion_body_iw6_placement_failed";
	var_00.modeldestroyed = "ims_scorpion_body_iw6";
	var_00.modelbombsquad = "ims_scorpion_body_iw6_bombsquad";
	var_00.hintstring = &"KILLSTREAKS_HINTS_IMS_PICKUP_TO_MOVE";
	var_00.placestring = &"KILLSTREAKS_HINTS_IMS_PLACE";
	var_00.cannotplacestring = &"KILLSTREAKS_HINTS_IMS_CANNOT_PLACE";
	var_00.streakname = "ims";
	var_00.splashname = "used_ims";
	var_00.maxhealth = 1000;
	var_00.lifespan = 90;
	var_00.rearmtime = 0.5;
	var_00.graceperiod = 0.4;
	var_00.numexplosives = 4;
	var_00.explosivemodel = "ims_scorpion_explosive_iw6";
	var_00.placementheighttolerance = 30;
	var_00.placementradius = 24;
	var_00.lidtagroot = "tag_lid";
	var_00.lidopenanims = [];
	var_00.lidopenanims[1] = "IMS_Scorpion_door_1";
	var_00.lidopenanims[2] = "IMS_Scorpion_door_2";
	var_00.lidopenanims[3] = "IMS_Scorpion_door_3";
	var_00.lidopenanims[4] = "IMS_Scorpion_door_4";
	var_00.lidsnapopenanims = [];
	var_00.lidsnapopenanims[1] = "IMS_Scorpion_1_opened";
	var_00.lidsnapopenanims[2] = "IMS_Scorpion_2_opened";
	var_00.lidsnapopenanims[3] = "IMS_Scorpion_3_opened";
	var_00.expltagroot = "tag_explosive";
	var_00.killcamoffset = (0,0,12);
	level.imssettings["ims"] = var_00;
	level._effect["ims_explode_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_explosion");
	level._effect["ims_smoke_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["ims_sensor_explode"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_ims_sparks");
	level._effect["ims_antenna_light_mp"] = loadfx("vfx/gameplay/mp/killstreaks/vfx_light_detonator_blink");
	level.placedims = [];
}

//Function Number: 2
func_843D(param_00,param_01)
{
	var_02 = [];
	if(isdefined(self.imslist))
	{
		var_02 = self.imslist;
	}

	var_03 = giveims("ims");
	if(!isdefined(var_03))
	{
		var_03 = 0;
		if(isdefined(self.imslist))
		{
			if(!var_02.size && self.imslist.size)
			{
				var_03 = 1;
			}

			if(var_02.size && var_02[0] != self.imslist[0])
			{
				var_03 = 1;
			}
		}
	}

	if(var_03)
	{
		maps\mp\_matchdata::func_4F1D(level.imssettings["ims"].streakname,self.origin);
	}

	self.iscarrying = 0;
	return var_03;
}

//Function Number: 3
giveims(param_00)
{
	var_01 = createimsforplayer(param_00,self);
	func_65A6();
	self.carriedims = var_01;
	var_01.firstplacement = 1;
	var_02 = func_6FFA(var_01,1);
	self.carriedims = undefined;
	thread func_665E();
	return var_02;
}

//Function Number: 4
func_6FFA(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread ims_setcarried(self);
	common_scripts\utility::_disableweapon();
	if(!isai(self))
	{
		self notifyonplayercommand("place_ims","+attack");
		self notifyonplayercommand("place_ims","+attack_akimbo_accessible");
		self notifyonplayercommand("cancel_ims","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancel_ims","+actionslot 5");
			self notifyonplayercommand("cancel_ims","+actionslot 6");
			self notifyonplayercommand("cancel_ims","+actionslot 7");
		}
	}

	for(;;)
	{
		if(maps\mp\_utility::func_47BB())
		{
			var_02 = common_scripts\utility::func_8B33("place_ims","cancel_ims","force_cancel_placement","player_action_slot_restart");
		}
		else
		{
			var_02 = common_scripts\utility::func_8B33("place_ims","cancel_ims","force_cancel_placement");
		}

		if(var_02 == "cancel_ims" || var_02 == "force_cancel_placement" || var_02 == "player_action_slot_restart")
		{
			if(!param_01 && var_02 == "cancel_ims")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\_utility::getkillstreakweapon(level.imssettings[param_00.imstype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\_utility::getkillstreakweapon(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 ims_setcancelled(var_02 == "force_cancel_placement" && !isdefined(param_00.firstplacement));
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 thread func_4437();
		self notify("IMS_placed");
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 5
func_65BE()
{
	if(self hasweapon("iw6_riotshield_mp"))
	{
		self.restoreweapon = "iw6_riotshield_mp";
		self takeweapon("iw6_riotshield_mp");
	}
}

//Function Number: 6
func_65A6()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 7
func_6667()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		self.restoreweapon = undefined;
	}
}

//Function Number: 8
func_665E()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::func_3CFB(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 9
func_8B12()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_665E();
}

//Function Number: 10
createimsforplayer(param_00,param_01)
{
	if(isdefined(param_01.iscarrying) && param_01.iscarrying)
	{
	}

	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),"sentry_minigun_mp");
	var_02.angles = param_01.angles;
	var_02.imstype = param_00;
	var_02.owner = param_01;
	var_02 setmodel(level.imssettings[param_00].modelbase);
	var_02 maketurretinoperable();
	var_02 setturretmodechangewait(1);
	var_02 setmode("sentry_offline");
	var_02 makeunusable();
	var_02 setsentryowner(param_01);
	return var_02;
}

//Function Number: 11
createims(param_00)
{
	var_01 = param_00.owner;
	var_02 = param_00.imstype;
	var_03 = spawn("script_model",param_00.origin);
	var_03 setmodel(level.imssettings[var_02].modelbase);
	var_03.scale = 3;
	var_03.angles = param_00.angles;
	var_03.imstype = var_02;
	var_03.owner = var_01;
	var_03 setotherent(var_01);
	var_03.team = var_01.team;
	var_03.shouldsplash = 0;
	var_03.hidden = 0;
	var_03.attacks = 1;
	var_03 autoboltmissileeffects();
	var_03.hasexplosivefired = [];
	var_03.config = level.imssettings[var_02];
	var_03 thread func_4429();
	var_03 thread func_443A();
	var_03 thread func_4424();
	var_03 thread func_4430();
	return var_03;
}

//Function Number: 12
func_4424()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 hide();
	var_00 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
	var_00 setmodel(level.imssettings[self.imstype].modelbombsquad);
	var_00 linkto(self);
	var_00 setcontents(0);
	self.bombsquadmodel = var_00;
	self waittill("death");
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 13
func_442C(param_00)
{
	self.immediatedeath = 1;
	self notify("death");
}

//Function Number: 14
func_4425()
{
	self endon("carried");
	maps\mp\gametypes\_damage::func_537B(self.config.maxhealth,"ims",::func_4427,::ims_modifydamage,1);
}

//Function Number: 15
ims_modifydamage(param_00,param_01,param_02,param_03)
{
	if(self.hidden || param_01 == "ims_projectile_mp")
	{
		return -1;
	}

	var_04 = param_03;
	if(param_02 == "MOD_MELEE")
	{
		var_04 = self.maxhealth * 0.25;
	}

	if(isexplosivedamagemod(param_02))
	{
		var_04 = param_03 * 1.5;
	}

	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 16
func_4427(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"destroyed_ims","ims_destroyed");
	if(var_04)
	{
		param_00 notify("destroyed_equipment");
	}
}

//Function Number: 17
func_4426()
{
	self endon("carried");
	self waittill("death");
	removefromimslist();
	if(!isdefined(self))
	{
	}

	func_4436();
	self playsound("ims_destroyed");
	if(isdefined(self.inuseby))
	{
		playfx(common_scripts\utility::func_3AB9("ims_explode_mp"),self.origin + (0,0,10));
		playfx(common_scripts\utility::func_3AB9("ims_smoke_mp"),self.origin);
		self.inuseby func_665E();
		self.inuseby func_6667();
		self notify("deleting");
		wait(1);
	}
	else if(isdefined(self.immediatedeath))
	{
		playfx(common_scripts\utility::func_3AB9("ims_explode_mp"),self.origin + (0,0,10));
		self notify("deleting");
	}
	else
	{
		playfx(common_scripts\utility::func_3AB9("ims_explode_mp"),self.origin + (0,0,10));
		playfx(common_scripts\utility::func_3AB9("ims_smoke_mp"),self.origin);
		wait(3);
		self playsound("ims_fire");
		self notify("deleting");
	}

	if(isdefined(self.objidfriendly))
	{
		maps\mp\_utility::_objective_delete(self.objidfriendly);
	}

	if(isdefined(self.objidenemy))
	{
		maps\mp\_utility::_objective_delete(self.objidenemy);
	}

	maps\mp\gametypes\_weapons::equipmentdeletevfx();
	self disablemissilestick();
	self delete();
}

//Function Number: 18
func_8CDF()
{
	self endon("carried");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		maps\mp\gametypes\_weapons::func_7C5B();
		playfx(common_scripts\utility::func_3AB9("emp_stun"),self.origin);
		playfx(common_scripts\utility::func_3AB9("ims_smoke_mp"),self.origin);
		wait(var_01);
		func_4439();
	}
}

//Function Number: 19
func_4429()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!maps\mp\_utility::func_4945(var_00))
		{
			continue;
		}

		if(self.damagetaken >= self.maxhealth)
		{
			continue;
		}

		if(maps\mp\_utility::func_47BB() && isdefined(level.drill_carrier) && var_00 == level.drill_carrier)
		{
			continue;
		}

		var_01 = createimsforplayer(self.imstype,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01.ims = self;
		func_4436();
		ims_hideallparts();
		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_00 func_6FFA(var_01,0);
	}
}

//Function Number: 20
func_4437()
{
	self endon("death");
	level endon("game_ended");
	if(isdefined(self.carriedby))
	{
		self.carriedby forceusehintoff();
	}

	self.carriedby = undefined;
	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	self.firstplacement = undefined;
	var_00 = undefined;
	if(isdefined(self.ims))
	{
		var_00 = self.ims;
		var_00 endon("death");
		var_00.origin = self.origin;
		var_00.angles = self.angles;
		var_00.carriedby = undefined;
		var_00 func_4438();
		if(isdefined(var_00.bombsquadmodel))
		{
			var_00.bombsquadmodel show();
			var_00 func_4440(var_00.bombsquadmodel,1);
			level notify("update_bombsquad");
		}
	}
	else
	{
		var_00 = createims(self);
	}

	var_00 addtoimslist();
	var_00.isplaced = 1;
	var_00 thread func_4425();
	var_00 thread func_8CDF();
	var_00 thread func_4426();
	var_00 setcandamage(1);
	self playsound("ims_plant");
	self notify("placed");
	var_00 thread ims_setactive();
	var_01 = addstruct();
	if(isdefined(self.moving_platform))
	{
		var_01.linkparent = self.moving_platform;
	}

	var_01.endonstring = "carried";
	var_01.deathoverridecallback = ::func_442C;
	var_00 thread maps\mp\_movers::func_3F25(var_01);
	self delete();
}

//Function Number: 21
ims_setcancelled(param_00)
{
	if(isdefined(self.carriedby))
	{
		var_01 = self.carriedby;
		var_01 forceusehintoff();
		var_01.iscarrying = undefined;
		var_01.carrieditem = undefined;
		var_01 common_scripts\utility::_enableweapon();
		if(isdefined(var_01.imslist))
		{
			foreach(var_03 in var_01.imslist)
			{
				if(isdefined(var_03.bombsquadmodel))
				{
					var_03.bombsquadmodel delete();
				}
			}
		}
	}

	if(isdefined(param_00) && param_00)
	{
		maps\mp\gametypes\_weapons::equipmentdeletevfx();
	}

	self delete();
}

//Function Number: 22
ims_setcarried(param_00)
{
	removefromimslist();
	self setmodel(level.imssettings[self.imstype].modelplacement);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self setcandamage(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_86F5(self);
	thread ims_oncarrierdeath(param_00);
	thread ims_oncarrierdisconnect(param_00);
	thread func_442F();
	thread ims_onenterride(param_00);
	if(maps\mp\_utility::func_47BB() && isdefined(level.drop_ims_when_grabbed_func))
	{
		self thread [[ level.drop_ims_when_grabbed_func ]](param_00);
	}

	self notify("carried");
	if(isdefined(self.ims))
	{
		self.ims notify("carried");
		self.ims.carriedby = param_00;
		self.ims.isplaced = 0;
		if(isdefined(self.ims.bombsquadmodel))
		{
			self.ims.bombsquadmodel hide();
		}
	}
}

//Function Number: 23
func_86F5(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	var_02 = level.imssettings[param_00.imstype];
	for(;;)
	{
		var_03 = self canplayerplacesentry(1,var_02.placementradius);
		param_00.origin = var_03["origin"];
		param_00.angles = var_03["angles"];
		param_00.canbeplaced = self isonground() && var_03["result"] && abs(param_00.origin[2] - self.origin[2]) < var_02.placementheighttolerance;
		if(isdefined(var_03["entity"]))
		{
			param_00.moving_platform = var_03["entity"];
		}
		else
		{
			param_00.moving_platform = undefined;
		}

		if(param_00.canbeplaced != var_01)
		{
			if(param_00.canbeplaced)
			{
				param_00 setmodel(level.imssettings[param_00.imstype].modelplacement);
				self forceusehinton(level.imssettings[param_00.imstype].placestring);
			}
			else
			{
				param_00 setmodel(level.imssettings[param_00.imstype].modelplacementfailed);
				self forceusehinton(level.imssettings[param_00.imstype].cannotplacestring);
			}
		}

		var_01 = param_00.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 24
ims_oncarrierdeath(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(self.canbeplaced && param_00.team != "spectator")
	{
		thread func_4437();
	}

	ims_setcancelled();
}

//Function Number: 25
ims_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	ims_setcancelled();
}

//Function Number: 26
ims_onenterride(param_00)
{
	self endon("placed");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.carriedby.onhelisniper) && self.carriedby.onhelisniper)
		{
			self notify("death");
		}

		wait(0.1);
	}
}

//Function Number: 27
func_442F(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	ims_setcancelled();
}

//Function Number: 28
ims_setactive()
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.imssettings[self.imstype].hintstring);
	var_00 = self.owner;
	var_00 forceusehintoff();
	if(!maps\mp\_utility::func_47BB())
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::func_70E0(self.team,(0,0,60));
		}
		else
		{
			maps\mp\_entityheadicons::func_7099(var_00,(0,0,60));
		}
	}

	self makeusable();
	self setcandamage(1);
	maps\mp\gametypes\_weapons::func_5015();
	if(isdefined(var_00.imslist))
	{
		foreach(var_02 in var_00.imslist)
		{
			if(var_02 == self)
			{
				continue;
			}

			var_02 notify("death");
		}
	}

	var_00.imslist = [];
	var_00.imslist[0] = self;
	foreach(var_05 in level.players)
	{
		if(var_05 == var_00)
		{
			self enableplayeruse(var_05);
			continue;
		}

		self disableplayeruse(var_05);
	}

	if(self.shouldsplash)
	{
		level thread maps\mp\_utility::func_7FA0(level.imssettings[self.imstype].splashname,var_00);
		self.shouldsplash = 0;
	}

	var_07 = (0,0,20);
	var_08 = (0,0,256) - var_07;
	var_09 = [];
	self.killcam_ents = [];
	for(var_0A = 0;var_0A < self.config.numexplosives;var_0A++)
	{
		if(numexplosivesexceedmodelcapacity())
		{
			var_0B = func_7405(var_0A + 1,self.config.numexplosives - 4);
		}
		else
		{
			var_0B = var_0A + 1;
		}

		var_0C = self gettagorigin(self.config.expltagroot + var_0B + "_attach");
		var_0D = self gettagorigin(self.config.expltagroot + var_0B + "_attach") + var_07;
		var_09[var_0A] = bullettrace(var_0D,var_0D + var_08,0,self);
		if(var_0A < 4)
		{
			var_0E = spawn("script_model",var_0C + self.config.killcamoffset);
			var_0E setscriptmoverkillcam("explosive");
			self.killcam_ents[self.killcam_ents.size] = var_0E;
		}
	}

	var_0F = var_09[0];
	for(var_0A = 0;var_0A < var_09.size;var_0A++)
	{
		if(var_09[var_0A]["position"][2] < var_0F["position"][2])
		{
			var_0F = var_09[var_0A];
		}
	}

	self.attackheightpos = var_0F["position"] - (0,0,20) - self.origin;
	var_10 = spawn("trigger_radius",self.origin,0,256,100);
	self.attacktrigger = var_10;
	self.attacktrigger enablelinkto();
	self.attacktrigger linkto(self);
	self.attackmovetime = length(self.attackheightpos) / 200;
	func_443C();
	func_4439();
	thread ims_watchplayerconnected();
	foreach(var_05 in level.players)
	{
		thread func_4432(var_05);
	}
}

//Function Number: 29
ims_watchplayerconnected()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		func_4431(var_00);
	}
}

//Function Number: 30
func_4431(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	self disableplayeruse(param_00);
}

//Function Number: 31
func_4432(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		self disableplayeruse(param_00);
	}
}

//Function Number: 32
func_4430()
{
	self endon("death");
	level endon("game_ended");
	self.owner waittill("killstreak_disowned");
	if(isdefined(self.isplaced))
	{
		self notify("death");
	}

	ims_setcancelled(0);
}

//Function Number: 33
func_4439()
{
	thread maps\mp\gametypes\_weapons::doblinkinglight("tag_fx");
	thread func_4423();
}

//Function Number: 34
func_4436()
{
	self makeunusable();
	self freeentitysentient();
	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::func_7099(undefined,(0,0,0));
	}

	if(isdefined(self.attacktrigger))
	{
		self.attacktrigger delete();
	}

	if(isdefined(self.killcam_ents))
	{
		foreach(var_01 in self.killcam_ents)
		{
			if(isdefined(var_01))
			{
				if(isdefined(self.owner) && isdefined(self.owner.imskillcament) && var_01 == self.owner.imskillcament)
				{
					continue;
				}
				else
				{
					var_01 delete();
				}
			}
		}
	}

	if(isdefined(self.explosive1))
	{
		self.explosive1 delete();
		self.explosive1 = undefined;
	}

	maps\mp\gametypes\_weapons::func_7C5B();
}

//Function Number: 35
isfriendlytoims(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_4423()
{
	self endon("death");
	self endon("emp_damage");
	level endon("game_ended");
	for(;;)
	{
		if(!isdefined(self.attacktrigger))
		{
			break;
		}

		self.attacktrigger waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			if(isdefined(self.owner) && var_00 == self.owner)
			{
				continue;
			}

			if(level.teambased && var_00.pers["team"] == self.team)
			{
				continue;
			}

			if(!maps\mp\_utility::func_4945(var_00))
			{
				continue;
			}
		}
		else if(isdefined(var_00.owner))
		{
			if(isdefined(self.owner) && var_00.owner == self.owner)
			{
				continue;
			}

			if(level.teambased && var_00.owner.pers["team"] == self.team)
			{
				continue;
			}
		}

		var_01 = var_00.origin + (0,0,50);
		if(!sighttracepassed(self.attackheightpos + self.origin,var_01,0,self))
		{
			continue;
		}

		var_02 = 0;
		for(var_03 = 1;var_03 <= self.config.numexplosives;var_03++)
		{
			if(var_03 > 4)
			{
				break;
			}

			if(sighttracepassed(self gettagorigin(self.config.lidtagroot + var_03),var_01,0,self))
			{
				var_02 = 1;
				break;
			}
		}

		if(!var_02)
		{
			continue;
		}

		self playsound("ims_trigger");
		if(maps\mp\_utility::func_47BB() && isdefined(level.ims_alien_grace_period_func) && isdefined(self.owner))
		{
			var_04 = [[ level.ims_alien_grace_period_func ]](level.imssettings[self.imstype].graceperiod,self.owner);
			maps\mp\gametypes\_weapons::explosivetrigger(var_00,var_04,"ims");
		}
		else
		{
			maps\mp\gametypes\_weapons::explosivetrigger(var_00,level.imssettings[self.imstype].graceperiod,"ims");
		}

		if(!isdefined(self.attacktrigger))
		{
			break;
		}

		if(!isdefined(self.hasexplosivefired[self.attacks]))
		{
			self.hasexplosivefired[self.attacks] = 1;
			thread fire_sensor(var_00,self.attacks);
			self.attacks++;
		}

		if(self.attacks > self.config.numexplosives)
		{
			break;
		}

		func_443C();
		self waittill("sensor_exploded");
		wait(self.config.rearmtime);
		if(!isdefined(self.owner))
		{
			break;
		}
	}

	if(isdefined(self.carriedby) && isdefined(self.owner) && self.carriedby == self.owner)
	{
	}

	self notify("death");
}

//Function Number: 37
fire_sensor(param_00,param_01)
{
	if(numexplosivesexceedmodelcapacity())
	{
		param_01 = func_7405(param_01,self.config.numexplosives - 4);
	}

	var_02 = self.explosive1;
	self.explosive1 = undefined;
	var_03 = self.config.lidtagroot + param_01;
	playfxontag(level._effect["ims_sensor_explode"],self,var_03);
	imsopendoor(param_01,self.config);
	var_04 = self.config.weaponinfo;
	var_05 = self.owner;
	var_02 unlink();
	var_02 rotateyaw(3600,self.attackmovetime);
	var_02 moveto(self.attackheightpos + self.origin,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
	if(isdefined(var_02.killcament))
	{
		var_06 = var_02.killcament;
		var_06 unlink();
		if(isdefined(self.owner))
		{
			self.owner.imskillcament = var_06;
		}

		var_06 moveto(self.attackheightpos + self.origin + self.config.killcamoffset,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
		if(!numexplosivesexceedmodelcapacity())
		{
			var_06 thread func_2583(5);
		}
	}

	var_02 playsound("ims_launch");
	var_02 waittill("movedone");
	playfx(level._effect["ims_sensor_explode"],var_02.origin);
	var_07 = [];
	var_07[0] = param_00.origin;
	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		if(isdefined(var_05))
		{
			magicbullet(var_04,var_02.origin,var_07[var_08],var_05);
			if(maps\mp\_utility::func_47BB() && isdefined(level.ims_alien_fire_func))
			{
				self thread [[ level.ims_alien_fire_func ]](var_07[var_08],var_05);
			}

			continue;
		}

		magicbullet(var_04,var_02.origin,var_07[var_08]);
	}

	var_02 delete();
	self notify("sensor_exploded");
}

//Function Number: 38
func_2583(param_00)
{
	self endon("death");
	level maps\mp\gametypes\_hostmigration::func_8B0D(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 39
func_443A()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.imssettings[self.imstype].lifespan;
	while(var_00)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	self notify("death");
}

//Function Number: 40
addtoimslist()
{
	var_00 = self getentitynumber();
	level.placedims[var_00] = self;
}

//Function Number: 41
removefromimslist()
{
	var_00 = self getentitynumber();
	level.placedims[var_00] = undefined;
}

//Function Number: 42
ims_hideallparts()
{
	self hide();
	self.hidden = 1;
}

//Function Number: 43
func_4438()
{
	self show();
	self.hidden = 0;
	func_4440(self,1);
}

//Function Number: 44
imscreateexplosive(param_00)
{
	var_01 = spawn("script_model",self gettagorigin(self.config.expltagroot + param_00 + "_attach"));
	var_01 setmodel(self.config.explosivemodel);
	var_01.angles = self.angles;
	var_01.killcament = self.killcam_ents[param_00 - 1];
	var_01.killcament linkto(self);
	return var_01;
}

//Function Number: 45
func_443C()
{
	for(var_00 = 1;var_00 <= self.config.numexplosives && isdefined(self.hasexplosivefired[var_00]);var_00++)
	{
	}

	if(var_00 <= self.config.numexplosives)
	{
		if(numexplosivesexceedmodelcapacity())
		{
			var_00 = func_7405(var_00,self.config.numexplosives - 4);
		}

		var_01 = imscreateexplosive(var_00);
		var_01 linkto(self);
		self.explosive1 = var_01;
	}
}

//Function Number: 46
imsopendoor(param_00,param_01,param_02)
{
	var_03 = param_01.lidtagroot + param_00 + "_attach";
	var_04 = undefined;
	if(isdefined(param_02))
	{
		var_04 = param_01.lidsnapopenanims[param_00];
	}
	else
	{
		var_04 = param_01.lidopenanims[param_00];
	}

	self scriptmodelplayanim(var_04);
	var_05 = param_01.expltagroot + param_00 + "_attach";
	self hidepart(var_05);
}

//Function Number: 47
func_4440(param_00,param_01)
{
	var_02 = self.hasexplosivefired.size;
	if(var_02 > 0)
	{
		if(numexplosivesexceedmodelcapacity())
		{
			var_02 = func_7405(var_02,self.config.numexplosives - 4);
		}

		param_00 imsopendoor(var_02,self.config,param_01);
	}
}

//Function Number: 48
numexplosivesexceedmodelcapacity()
{
	return self.config.numexplosives > 4;
}

//Function Number: 49
func_7405(param_00,param_01)
{
	var_02 = param_00 - param_01;
	var_02 = max(1,var_02);
	return castint(var_02);
}