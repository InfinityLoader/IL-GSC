/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_ims.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 37
 * Decompile Time: 695 ms
 * Timestamp: 10/27/2023 2:27:02 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["ims"] = ::func_3148;
	level.imssettings = [];
	level.imssettings["ims"] = spawnstruct();
	level.imssettings["ims"].weaponinfo = "ims_projectile_mp";
	level.imssettings["ims"].modelbase = "ims_scorpion_body";
	level.imssettings["ims"].modelplacement = "ims_scorpion_body_placement";
	level.imssettings["ims"].modelplacementfailed = "ims_scorpion_body_placement_failed";
	level.imssettings["ims"].modeldestroyed = "ims_scorpion_body";
	level.imssettings["ims"].modelbombsquad = "ims_scorpion_body_bombsquad";
	level.imssettings["ims"].hintstring = &"MP_IMS_PICKUP";
	level.imssettings["ims"].placestring = &"MP_IMS_PLACE";
	level.imssettings["ims"].cannotplacestring = &"MP_IMS_CANNOT_PLACE";
	level.imssettings["ims"].streakname = "ims";
	level.imssettings["ims"].splashname = "used_ims";
	level.imssettings["ims"].lifespan = 90;
	level.imssettings["ims"].graceperiod = 0.4;
	level.imssettings["ims"].attacks = 4;
	level.imssettings["ims"].modelexplosive1 = "ims_scorpion_explosive1";
	level.imssettings["ims"].modelexplosive2 = "ims_scorpion_explosive2";
	level.imssettings["ims"].modelexplosive3 = "ims_scorpion_explosive3";
	level.imssettings["ims"].modelexplosive4 = "ims_scorpion_explosive4";
	level.imssettings["ims"].modellid1 = "ims_scorpion_lid1";
	level.imssettings["ims"].modellid2 = "ims_scorpion_lid2";
	level.imssettings["ims"].modellid3 = "ims_scorpion_lid3";
	level.imssettings["ims"].modellid4 = "ims_scorpion_lid4";
	level.imssettings["ims"].tagexplosive1 = "tag_explosive1";
	level.imssettings["ims"].tagexplosive2 = "tag_explosive2";
	level.imssettings["ims"].tagexplosive3 = "tag_explosive3";
	level.imssettings["ims"].tagexplosive4 = "tag_explosive4";
	level.imssettings["ims"].taglid1 = "tag_lid1";
	level.imssettings["ims"].taglid2 = "tag_lid2";
	level.imssettings["ims"].taglid3 = "tag_lid3";
	level.imssettings["ims"].taglid4 = "tag_lid4";
	foreach(var_01 in level.imssettings)
	{
		precacheitem(var_01.weaponinfo);
		precachemodel(var_01.modelbase);
		precachemodel(var_01.modelplacement);
		precachemodel(var_01.modelplacementfailed);
		precachemodel(var_01.modeldestroyed);
		precachemodel(var_01.modelbombsquad);
		precachemodel(var_01.modelexplosive1);
		precachemodel(var_01.modelexplosive2);
		precachemodel(var_01.modelexplosive3);
		precachemodel(var_01.modelexplosive4);
		precachemodel(var_01.modellid1);
		precachemodel(var_01.modellid2);
		precachemodel(var_01.modellid3);
		precachemodel(var_01.modellid4);
		precachestring(var_01.hintstring);
		precachestring(var_01.placestring);
		precachestring(var_01.cannotplacestring);
	}

	precachestring(&"PLATFORM_HOLD_TO_USE");
	level._effect["ims_explode_mp"] = loadfx("explosions/sentry_gun_explosion");
	level._effect["ims_smoke_mp"] = loadfx("smoke/car_damage_blacksmoke");
	level._effect["ims_sensor_trail"] = loadfx("smoke/smoke_geotrail_rpg");
	level._effect["ims_sensor_explode"] = loadfx("explosions/generator_sparks_d");
	level._effect["ims_antenna_light_mp"] = loadfx("lights/light_detonator_blink");
}

//Function Number: 2
func_3148(param_00)
{
	var_01 = [];
	if(isdefined(self.imslist))
	{
		var_01 = self.imslist;
	}

	var_02 = giveims("ims");
	if(!isdefined(var_02))
	{
		var_02 = 0;
		if(isdefined(self.imslist))
		{
			if(!var_01.size && self.imslist.size)
			{
				var_02 = 1;
			}

			if(var_01.size && var_01[0] != self.imslist[0])
			{
				var_02 = 1;
			}
		}
	}

	if(var_02)
	{
		maps\mp\_matchdata::logkillstreakevent(level.imssettings["ims"].streakname,self.origin);
	}

	self.iscarrying = 0;
	return var_02;
}

//Function Number: 3
giveims(param_00)
{
	var_01 = createimsforplayer(param_00,self);
	func_2DF8();
	var_02 = func_314B(var_01,1);
	thread func_2DFB();
	return var_02;
}

//Function Number: 4
func_314B(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread func_315E(self);
	common_scripts\utility::_disableweapon();
	self notifyonplayercommand("place_ims","+attack");
	self notifyonplayercommand("place_ims","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_ims","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_ims","+actionslot 5");
		self notifyonplayercommand("cancel_ims","+actionslot 6");
		self notifyonplayercommand("cancel_ims","+actionslot 7");
	}

	for(;;)
	{
		var_02 = common_scripts\utility::waittill_any_return("place_ims","cancel_ims","force_cancel_placement");
		if(var_02 == "cancel_ims" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_ims")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = maps\mp\killstreaks\_killstreaks::func_2C01(level.imssettings[param_00.imstype].streakname);
				if(isdefined(self.killstreakindexweapon) && var_03 == maps\mp\killstreaks\_killstreaks::func_2C01(self.pers["killstreaks"][self.killstreakindexweapon].streakname) && !self getweaponslistitems().size)
				{
					maps\mp\_utility::_giveweapon(var_03,0);
					maps\mp\_utility::func_31F3(4,"weapon",var_03);
				}
			}

			param_00 func_315D();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!param_00.canbeplaced)
		{
			continue;
		}

		param_00 thread func_315C();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

//Function Number: 5
func_2DF6()
{
	if(self hasweapon("riotshield_mp"))
	{
		self.restoreweapon = "riotshield_mp";
		self takeweapon("riotshield_mp");
	}
}

//Function Number: 6
func_2DF8()
{
	if(maps\mp\_utility::func_27AF("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::func_282E("specialty_explosivebullets");
	}
}

//Function Number: 7
func_2DFA()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		self.restoreweapon = undefined;
	}
}

//Function Number: 8
func_2DFB()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::giveperk(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 9
waitrestoreperks()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	func_2DFB();
}

//Function Number: 10
createimsforplayer(param_00,param_01)
{
	if(isdefined(param_01.iscarrying) && param_01.iscarrying)
	{
		return;
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
	var_03.health = 1000;
	var_03.angles = var_01.angles;
	var_03.imstype = var_02;
	var_03.owner = var_01;
	var_03.team = var_01.team;
	var_03.shouldsplash = 0;
	var_03.hidden = 0;
	var_03.attacks = level.imssettings[var_02].attacks;
	var_03.lid1 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].taglid1 + "_attach"));
	var_03.lid1 setmodel(level.imssettings[var_02].modellid1);
	var_03.lid1.tag = level.imssettings[var_02].taglid1;
	var_03.lid1 linkto(var_03);
	var_03.lid2 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].taglid2 + "_attach"));
	var_03.lid2 setmodel(level.imssettings[var_02].modellid2);
	var_03.lid2.tag = level.imssettings[var_02].taglid2;
	var_03.lid2 linkto(var_03);
	var_03.lid3 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].taglid3 + "_attach"));
	var_03.lid3 setmodel(level.imssettings[var_02].modellid3);
	var_03.lid3.tag = level.imssettings[var_02].taglid3;
	var_03.lid3 linkto(var_03);
	var_03.lid4 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].taglid4 + "_attach"));
	var_03.lid4 setmodel(level.imssettings[var_02].modellid4);
	var_03.lid4.tag = level.imssettings[var_02].taglid4;
	var_03.lid4 linkto(var_03);
	var_03.explosive1 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].tagexplosive1 + "_attach"));
	var_03.explosive1 setmodel(level.imssettings[var_02].modelexplosive1);
	var_03.explosive1.tag = level.imssettings[var_02].tagexplosive1;
	var_03.explosive1 linkto(var_03);
	var_03.explosive2 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].tagexplosive2 + "_attach"));
	var_03.explosive2 setmodel(level.imssettings[var_02].modelexplosive2);
	var_03.explosive2.tag = level.imssettings[var_02].tagexplosive2;
	var_03.explosive2 linkto(var_03);
	var_03.explosive3 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].tagexplosive3 + "_attach"));
	var_03.explosive3 setmodel(level.imssettings[var_02].modelexplosive3);
	var_03.explosive3.tag = level.imssettings[var_02].tagexplosive3;
	var_03.explosive3 linkto(var_03);
	var_03.explosive4 = spawn("script_model",var_03 gettagorigin(level.imssettings[var_02].tagexplosive4 + "_attach"));
	var_03.explosive4 setmodel(level.imssettings[var_02].modelexplosive4);
	var_03.explosive4.tag = level.imssettings[var_02].tagexplosive4;
	var_03.explosive4 linkto(var_03);
	var_03 ims_setinactive();
	var_03 thread ims_handleownerdisconnect();
	var_03 thread ims_handledeath();
	var_03 thread ims_handleuse();
	var_03 thread func_3158();
	var_03 thread func_316D();
	var_03 thread ims_createbombsquadmodel();
	return var_03;
}

//Function Number: 12
ims_createbombsquadmodel()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 hide();
	var_01 = level.otherteam[self.team];
	var_00 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(var_01,self.owner);
	var_00 setmodel(level.imssettings[self.imstype].modelbombsquad);
	var_00 linkto(self);
	var_00 setcontents(0);
	self.bombsquadmodel = var_00;
	self waittill("death");
	var_00 delete();
}

//Function Number: 13
func_3158()
{
	self endon("death");
	level endon("game_ended");
	self.health = 999999;
	self.maxhealth = 300;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_01))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "ims_projectile_mp":
				case "concussion_grenade_mp":
				case "flash_grenade_mp":
				case "smoke_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(self.hidden)
		{
			continue;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.damagetaken = self.damagetaken + self.maxhealth;
		}

		if(isexplosivedamagemod(var_04))
		{
			var_00 = var_00 * 1.5;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ims");
			if(var_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.armorpiercingmod;
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("ims");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remote_mortar_missile_mp":
				case "javelin_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "emp_grenade_mp":
				case "bomb_site_mp":
					self.largeprojectiledamage = 0;
					var_0A = self.maxhealth + 1;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 thread maps\mp\gametypes\_rank::func_2AB3("kill",100,var_09,var_04);
				var_01 notify("destroyed_killstreak");
				var_01 notify("destroyed_explosive");
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::func_2A60("ims_destroyed");
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 14
ims_handledeath()
{
	var_00 = self getentitynumber();
	func_316E(var_00);
	self waittill("death");
	removefromimslist(var_00);
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.imssettings[self.imstype].modeldestroyed);
	ims_setinactive();
	self playsound("ims_destroyed");
	if(isdefined(self.inuseby))
	{
		playfx(common_scripts\utility::func_539("ims_explode_mp"),self.origin + (0,0,10));
		playfx(common_scripts\utility::func_539("ims_smoke_mp"),self.origin);
		self.inuseby func_2DFB();
		self.inuseby func_2DFA();
		self notify("deleting");
		wait 1;
	}
	else
	{
		playfx(common_scripts\utility::func_539("ims_explode_mp"),self.origin + (0,0,10));
		wait 1.5;
		self playsound("ims_fire");
		var_01 = 8;
		while(var_01 > 0)
		{
			playfx(common_scripts\utility::func_539("ims_smoke_mp"),self.origin);
			wait 0.4;
			var_01 = var_01 - 0.4;
		}

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

	if(isdefined(self.lid1))
	{
		self.lid1 delete();
	}

	if(isdefined(self.lid2))
	{
		self.lid2 delete();
	}

	if(isdefined(self.lid3))
	{
		self.lid3 delete();
	}

	if(isdefined(self.lid4))
	{
		self.lid4 delete();
	}

	if(isdefined(self.explosive1))
	{
		if(isdefined(self.explosive1.killcament))
		{
			self.explosive1.killcament delete();
		}

		self.explosive1 delete();
	}

	if(isdefined(self.explosive2))
	{
		if(isdefined(self.explosive2.killcament))
		{
			self.explosive2.killcament delete();
		}

		self.explosive2 delete();
	}

	if(isdefined(self.explosive3))
	{
		if(isdefined(self.explosive3.killcament))
		{
			self.explosive3.killcament delete();
		}

		self.explosive3 delete();
	}

	if(isdefined(self.explosive4))
	{
		if(isdefined(self.explosive4.killcament))
		{
			self.explosive4.killcament delete();
		}

		self.explosive4 delete();
	}

	self delete();
}

//Function Number: 15
ims_handleuse()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!maps\mp\_utility::isreallyalive(var_00))
		{
			continue;
		}

		if(self.damagetaken >= self.maxhealth)
		{
			continue;
		}

		var_01 = createimsforplayer(self.imstype,var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01.ims = self;
		ims_setinactive();
		func_3170();
		var_00 func_314B(var_01,0);
	}
}

//Function Number: 16
ims_handleownerdisconnect()
{
	self endon("death");
	level endon("game_ended");
	self notify("ims_handleOwner");
	self endon("ims_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 17
func_315C()
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

	var_00 = undefined;
	if(isdefined(self.ims))
	{
		var_00 = self.ims;
		var_00 endon("death");
		var_00.origin = self.origin;
		var_00.angles = self.angles;
		var_00.carriedby = undefined;
		wait 0.05;
		var_00 ims_showallparts();
		if(isdefined(var_00.bombsquadmodel))
		{
			var_00.bombsquadmodel show();
			level notify("update_bombsquad");
		}
	}
	else
	{
		var_00 = createims(self);
	}

	var_00 setcandamage(1);
	self playsound("ims_plant");
	self notify("placed");
	var_00 thread func_3163();
	self delete();
}

//Function Number: 18
func_315D()
{
	if(isdefined(self.carriedby))
	{
		self.carriedby forceusehintoff();
	}

	if(isdefined(self.owner))
	{
		self.owner.iscarrying = 0;
	}

	if(isdefined(self.lid1))
	{
		self.lid1 delete();
	}

	if(isdefined(self.lid2))
	{
		self.lid2 delete();
	}

	if(isdefined(self.lid3))
	{
		self.lid3 delete();
	}

	if(isdefined(self.lid4))
	{
		self.lid4 delete();
	}

	if(isdefined(self.explosive1))
	{
		self.explosive1 delete();
	}

	if(isdefined(self.explosive2))
	{
		self.explosive2 delete();
	}

	if(isdefined(self.explosive3))
	{
		self.explosive3 delete();
	}

	if(isdefined(self.explosive4))
	{
		self.explosive4 delete();
	}

	self delete();
}

//Function Number: 19
func_315E(param_00)
{
	self setmodel(level.imssettings[self.imstype].modelplacement);
	self setsentrycarrier(param_00);
	self setcontents(0);
	self setcandamage(0);
	self.carriedby = param_00;
	param_00.iscarrying = 1;
	param_00 thread func_315F(self);
	thread ims_oncarrierdeath(param_00);
	thread ims_oncarrierdisconnect(param_00);
	thread func_3162();
	self notify("carried");
	if(isdefined(self.ims))
	{
		self.ims notify("carried");
		self.ims.carriedby = param_00;
		if(isdefined(self.ims.bombsquadmodel))
		{
			self.ims.bombsquadmodel hide();
		}
	}
}

//Function Number: 20
func_315F(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.canbeplaced = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacesentry();
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.canbeplaced = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 10;
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
		wait 0.05;
	}
}

//Function Number: 21
ims_oncarrierdeath(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("death");
	if(self.canbeplaced)
	{
		thread func_315C();
		return;
	}

	func_315D();
}

//Function Number: 22
ims_oncarrierdisconnect(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	func_315D();
}

//Function Number: 23
func_3162(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	func_315D();
}

//Function Number: 24
func_3163()
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.imssettings[self.imstype].hintstring);
	var_00 = self.owner;
	var_00 forceusehintoff();
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,45));
	}
	else
	{
		maps\mp\_entityheadicons::setplayerheadicon(var_00,(0,0,45));
	}

	self makeusable();
	self setcandamage(1);
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
		level thread maps\mp\_utility::teamplayercardsplash(level.imssettings[self.imstype].splashname,var_00);
		self.shouldsplash = 0;
	}

	var_07 = (0,0,20);
	var_08 = (0,0,256);
	var_09 = [];
	var_0A = self gettagorigin(level.imssettings[self.imstype].tagexplosive1) + var_07;
	var_09[0] = bullettrace(var_0A,var_0A + var_08 - var_07,0,self);
	var_0A = self gettagorigin(level.imssettings[self.imstype].tagexplosive2) + var_07;
	var_09[1] = bullettrace(var_0A,var_0A + var_08 - var_07,0,self);
	var_0A = self gettagorigin(level.imssettings[self.imstype].tagexplosive3) + var_07;
	var_09[2] = bullettrace(var_0A,var_0A + var_08 - var_07,0,self);
	var_0A = self gettagorigin(level.imssettings[self.imstype].tagexplosive4) + var_07;
	var_09[3] = bullettrace(var_0A,var_0A + var_08 - var_07,0,self);
	var_0B = var_09[0];
	for(var_0C = 0;var_0C < var_09.size;var_0C++)
	{
		if(var_09[var_0C]["position"][2] < var_0B["position"][2])
		{
			var_0B = var_09[var_0C];
		}
	}

	self.attackheightpos = var_0B["position"] - (0,0,20);
	var_0D = spawn("trigger_radius",self.origin,0,256,100);
	self.attacktrigger = var_0D;
	self.attackmovetime = distance(self.origin,self.attackheightpos) / 200;
	self.killcamoffset = (0,0,12);
	if(isdefined(self.explosive1.killcament))
	{
		self.explosive1.killcament delete();
	}

	if(isdefined(self.explosive2.killcament))
	{
		self.explosive2.killcament delete();
	}

	if(isdefined(self.explosive3.killcament))
	{
		self.explosive3.killcament delete();
	}

	if(isdefined(self.explosive4.killcament))
	{
		self.explosive4.killcament delete();
	}

	var_00.imskillcament = undefined;
	if(isdefined(self.explosive1))
	{
		self.explosive1.killcament = spawn("script_model",self.explosive1.origin + self.killcamoffset);
		self.explosive1.killcament setscriptmoverkillcam("explosive");
		if(!isdefined(var_00.imskillcament))
		{
			var_00.imskillcament = self.explosive1.killcament;
		}
	}

	if(isdefined(self.explosive2))
	{
		self.explosive2.killcament = spawn("script_model",self.explosive2.origin + self.killcamoffset);
		self.explosive2.killcament setscriptmoverkillcam("explosive");
		if(!isdefined(var_00.imskillcament))
		{
			var_00.imskillcament = self.explosive2.killcament;
		}
	}

	if(isdefined(self.explosive3))
	{
		self.explosive3.killcament = spawn("script_model",self.explosive3.origin + self.killcamoffset);
		self.explosive3.killcament setscriptmoverkillcam("explosive");
		if(!isdefined(var_00.imskillcament))
		{
			var_00.imskillcament = self.explosive3.killcament;
		}
	}

	if(isdefined(self.explosive4))
	{
		self.explosive4.killcament = spawn("script_model",self.explosive4.origin + self.killcamoffset);
		self.explosive4.killcament setscriptmoverkillcam("explosive");
		if(!isdefined(var_00.imskillcament))
		{
			var_00.imskillcament = self.explosive4.killcament;
		}
	}

	thread func_3168();
	thread ims_attacktargets();
	thread func_3166();
	foreach(var_05 in level.players)
	{
		thread func_3167(var_05);
	}
}

//Function Number: 25
func_3166()
{
	self endon("death");
	level waittill("connected",var_00);
	var_00 waittill("spawned_player");
	self disableplayeruse(var_00);
}

//Function Number: 26
func_3167(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("joined_team");
		self disableplayeruse(param_00);
	}
}

//Function Number: 27
func_3168()
{
	self endon("death");
	self endon("carried");
	for(;;)
	{
		playfxontag(common_scripts\utility::func_539("ims_antenna_light_mp"),self,"tag_fx");
		wait 1;
		stopfxontag(common_scripts\utility::func_539("ims_antenna_light_mp"),self,"tag_fx");
	}
}

//Function Number: 28
ims_setinactive()
{
	self makeunusable();
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon("none",(0,0,0));
	}
	else if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(undefined,(0,0,0));
	}

	if(isdefined(self.attacktrigger))
	{
		self.attacktrigger delete();
	}
}

//Function Number: 29
isfriendlytoims(param_00)
{
	if(level.teambased && self.team == param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
ims_attacktargets()
{
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

			if(!maps\mp\_utility::isreallyalive(var_00))
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

		if(!sighttracepassed(self.attackheightpos,var_00.origin + (0,0,50),0,self) || !sighttracepassed(self gettagorigin(level.imssettings[self.imstype].taglid1) + (0,0,5),var_00.origin + (0,0,50),0,self) && !sighttracepassed(self gettagorigin(level.imssettings[self.imstype].taglid2) + (0,0,5),var_00.origin + (0,0,50),0,self) && !sighttracepassed(self gettagorigin(level.imssettings[self.imstype].taglid3) + (0,0,5),var_00.origin + (0,0,50),0,self) && !sighttracepassed(self gettagorigin(level.imssettings[self.imstype].taglid4) + (0,0,5),var_00.origin + (0,0,50),0,self))
		{
			continue;
		}

		self playsound("ims_trigger");
		if(isplayer(var_00) && var_00 maps\mp\_utility::func_27AF("specialty_delaymine"))
		{
			var_00 notify("triggered_ims");
			wait level.delayminetime;
			if(!isdefined(self.attacktrigger))
			{
				break;
			}
		}
		else
		{
			wait level.imssettings[self.imstype].graceperiod;
		}

		if(isdefined(self.explosive1) && !isdefined(self.explosive1.fired))
		{
			func_316C(var_00,self.explosive1,self.lid1);
		}
		else if(isdefined(self.explosive2) && !isdefined(self.explosive2.fired))
		{
			func_316C(var_00,self.explosive2,self.lid2);
		}
		else if(isdefined(self.explosive3) && !isdefined(self.explosive3.fired))
		{
			func_316C(var_00,self.explosive3,self.lid3);
		}
		else if(isdefined(self.explosive4) && !isdefined(self.explosive4.fired))
		{
			func_316C(var_00,self.explosive4,self.lid4);
		}

		self.attacks--;
		if(self.attacks <= 0)
		{
			break;
		}

		wait 2;
		if(!isdefined(self.owner))
		{
			break;
		}
	}

	if(isdefined(self.carriedby) && isdefined(self.owner) && self.carriedby == self.owner)
	{
		return;
	}

	self notify("death");
}

//Function Number: 31
func_316C(param_00,param_01,param_02)
{
	playfx(level._effect["ims_sensor_explode"],param_02.origin);
	param_02 hide();
	param_01.fired = 1;
	param_01 unlink();
	param_01 rotateyaw(3600,self.attackmovetime);
	param_01 moveto(self.attackheightpos,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
	if(isdefined(param_01.killcament))
	{
		if(isdefined(self.owner))
		{
			self.owner.imskillcament = param_01.killcament;
		}

		param_01.killcament moveto(self.attackheightpos + self.killcamoffset,self.attackmovetime,self.attackmovetime * 0.25,self.attackmovetime * 0.25);
		param_01.killcament thread func_2C55(5);
	}

	param_01 playsound("ims_launch");
	param_01 waittill("movedone");
	playfx(level._effect["ims_sensor_explode"],param_01.origin);
	var_03 = [];
	for(var_04 = 0;var_04 < var_41.size;var_04++ = var_41[0])
	{
		if(isdefined(self.owner))
		{
			magicbullet("ims_projectile_mp",param_02.origin,var_41[var_04],self.owner);
			continue;
		}

		magicbullet("ims_projectile_mp",param_02.origin,var_41[var_04]);
	}

	var_03 delete();
	param_02 delete();
}

//Function Number: 32
func_2C55(param_00)
{
	self endon("death");
	level maps\mp\gametypes\_hostmigration::func_2740(param_00);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 33
func_316D()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.imssettings[self.imstype].lifespan;
	while(var_00)
	{
		wait 1;
		maps\mp\gametypes\_hostmigration::func_273E();
		if(!isdefined(self.carriedby))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	self notify("death");
}

//Function Number: 34
func_316E(param_00)
{
	level.ims[param_00] = self;
}

//Function Number: 35
removefromimslist(param_00)
{
	level.ims[param_00] = undefined;
}

//Function Number: 36
func_3170()
{
	if(isdefined(self.lid1))
	{
		self.lid1 hide();
	}

	if(isdefined(self.lid2))
	{
		self.lid2 hide();
	}

	if(isdefined(self.lid3))
	{
		self.lid3 hide();
	}

	if(isdefined(self.lid4))
	{
		self.lid4 hide();
	}

	if(isdefined(self.explosive1))
	{
		self.explosive1 hide();
	}

	if(isdefined(self.explosive2))
	{
		self.explosive2 hide();
	}

	if(isdefined(self.explosive3))
	{
		self.explosive3 hide();
	}

	if(isdefined(self.explosive4))
	{
		self.explosive4 hide();
	}

	self hide();
	self.hidden = 1;
}

//Function Number: 37
ims_showallparts()
{
	if(isdefined(self.lid1))
	{
		self.lid1 show();
	}

	if(isdefined(self.lid2))
	{
		self.lid2 show();
	}

	if(isdefined(self.lid3))
	{
		self.lid3 show();
	}

	if(isdefined(self.lid4))
	{
		self.lid4 show();
	}

	if(isdefined(self.explosive1))
	{
		self.explosive1 show();
	}

	if(isdefined(self.explosive2))
	{
		self.explosive2 show();
	}

	if(isdefined(self.explosive3))
	{
		self.explosive3 show();
	}

	if(isdefined(self.explosive4))
	{
		self.explosive4 show();
	}

	self show();
	self.hidden = 0;
}