/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_placeable.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 519 ms
 * Timestamp: 10/27/2023 1:21:23 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(level.placeableconfigs))
	{
		level.placeableconfigs = [];
	}
}

//Function Number: 2
func_3CFF(param_00)
{
	var_01 = func_210F(param_00);
	func_65A6();
	self.carrieditem = var_01;
	var_02 = func_58FA(param_00,var_01,1);
	self.carrieditem = undefined;
	func_665E();
	return isdefined(var_01);
}

//Function Number: 3
func_210F(param_00)
{
	if(isdefined(self.iscarrying) && self.iscarrying)
	{
	}

	var_01 = level.placeableconfigs[param_00];
	var_02 = spawn("script_model",self.origin);
	var_02 setmodel(var_01.modelbase);
	var_02.angles = self.angles;
	var_02.owner = self;
	var_02.team = self.team;
	var_02.config = var_01;
	var_02.firstplacement = 1;
	if(isdefined(var_01.oncreatedelegate))
	{
		var_02 [[ var_01.oncreatedelegate ]](param_00);
	}

	var_02 deactivate(param_00);
	var_02 thread timeout(param_00);
	var_02 thread handleuse(param_00);
	var_02 thread onkillstreakdisowned(param_00);
	var_02 thread func_593F(param_00);
	var_02 thread createbombsquadmodel(param_00);
	return var_02;
}

//Function Number: 4
handleuse(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!maps\mp\_utility::func_4945(var_01))
		{
			continue;
		}

		if(isdefined(self getlinkedparent()))
		{
			self unlink();
		}

		var_01 func_58FA(param_00,self,0);
	}
}

//Function Number: 5
func_58FA(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	param_01 thread func_5902(param_00,self);
	common_scripts\utility::_disableweapon();
	if(!isai(self))
	{
		self notifyonplayercommand("placePlaceable","+attack");
		self notifyonplayercommand("placePlaceable","+attack_akimbo_accessible");
		self notifyonplayercommand("cancelPlaceable","+actionslot 4");
		if(!level.console)
		{
			self notifyonplayercommand("cancelPlaceable","+actionslot 5");
			self notifyonplayercommand("cancelPlaceable","+actionslot 6");
			self notifyonplayercommand("cancelPlaceable","+actionslot 7");
		}
	}

	for(;;)
	{
		var_03 = common_scripts\utility::func_8B33("placePlaceable","cancelPlaceable","force_cancel_placement");
		if(!isdefined(param_01))
		{
			common_scripts\utility::_enableweapon();
			return 1;
		}
		else if((var_03 == "cancelPlaceable" && param_02) || var_03 == "force_cancel_placement")
		{
			param_01 func_58FF(param_00,var_03 == "force_cancel_placement" && !isdefined(param_01.firstplacement));
			return 0;
		}
		else if(param_01.canbeplaced)
		{
			param_01 thread func_595A(param_00);
			common_scripts\utility::_enableweapon();
			return 1;
		}
	}
}

//Function Number: 6
func_58FF(param_00,param_01)
{
	if(isdefined(self.carriedby))
	{
		var_02 = self.carriedby;
		var_02 forceusehintoff();
		var_02.iscarrying = undefined;
		var_02.carrieditem = undefined;
		var_02 common_scripts\utility::_enableweapon();
	}

	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel delete();
	}

	if(isdefined(self.carriedobj))
	{
		self.carriedobj delete();
	}

	var_03 = level.placeableconfigs[param_00];
	if(isdefined(var_03.oncanceldelegate))
	{
		self [[ var_03.oncanceldelegate ]](param_00);
	}

	if(isdefined(param_01) && param_01)
	{
		maps\mp\gametypes\_weapons::equipmentdeletevfx();
	}

	self delete();
}

//Function Number: 7
func_595A(param_00)
{
	var_01 = level.placeableconfigs[param_00];
	self.origin = self.placementorigin;
	self.angles = self.carriedobj.angles;
	self playsound(var_01.placedsfx);
	func_9492(param_00);
	if(isdefined(var_01.onplaceddelegate))
	{
		self [[ var_01.onplaceddelegate ]](param_00);
	}

	self setcursorhint("HINT_NOICON");
	self sethintstring(var_01.hintstring);
	var_02 = self.owner;
	var_02 forceusehintoff();
	var_02.iscarrying = undefined;
	self.carriedby = undefined;
	self.isplaced = 1;
	self.firstplacement = undefined;
	if(isdefined(var_01.headiconheight))
	{
		if(level.teambased)
		{
			maps\mp\_entityheadicons::func_70E0(self.team,(0,0,var_01.headiconheight));
		}
		else
		{
			maps\mp\_entityheadicons::func_7099(var_02,(0,0,var_01.headiconheight));
		}
	}

	thread func_3F74(param_00);
	thread func_3F75(param_00);
	self makeusable();
	common_scripts\utility::func_5009(self.owner.team);
	if(issentient(self))
	{
		self setthreatbiasgroup("DogsDontAttack");
	}

	foreach(var_04 in level.players)
	{
		if(var_04 == var_02)
		{
			self enableplayeruse(var_04);
			continue;
		}

		self disableplayeruse(var_04);
	}

	if(isdefined(self.shouldsplash))
	{
		level thread maps\mp\_utility::func_7FA0(var_01.splashname,var_02);
		self.shouldsplash = 0;
	}

	var_06 = spawnstruct();
	var_06.linkparent = self.moving_platform;
	var_06.playdeathfx = 1;
	var_06.endonstring = "carried";
	if(isdefined(var_01.onmovingplatformcollision))
	{
		var_06.deathoverridecallback = var_01.onmovingplatformcollision;
	}

	thread maps\mp\_movers::func_3F25(var_06);
	thread watchplayerconnected();
	self notify("placed");
	self.carriedobj delete();
	self.carriedobj = undefined;
}

//Function Number: 8
func_5902(param_00,param_01)
{
	var_02 = level.placeableconfigs[param_00];
	self.carriedobj = param_01 createcarriedobject(param_00);
	self.isplaced = undefined;
	self.carriedby = param_01;
	param_01.iscarrying = 1;
	deactivate(param_00);
	func_9232(param_00);
	if(isdefined(var_02.oncarrieddelegate))
	{
		self [[ var_02.oncarrieddelegate ]](param_00);
	}

	thread func_870E(param_00,param_01);
	thread func_5904(param_00,param_01);
	self notify("carried");
}

//Function Number: 9
func_870E(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	level endon("game_ended");
	self endon("placed");
	self endon("death");
	self.canbeplaced = 1;
	var_02 = -1;
	var_03 = level.placeableconfigs[param_00];
	var_04 = (0,0,0);
	if(isdefined(var_03.placementoffsetz))
	{
		var_04 = (0,0,var_03.placementoffsetz);
	}

	var_05 = self.carriedobj;
	for(;;)
	{
		var_06 = param_01 canplayerplacesentry(1,var_03.placementradius);
		self.placementorigin = var_06["origin"];
		var_05.origin = self.placementorigin + var_04;
		var_05.angles = var_06["angles"];
		self.canbeplaced = param_01 isonground() && var_06["result"] && abs(self.placementorigin[2] - param_01.origin[2]) < var_03.placementheighttolerance;
		if(isdefined(var_06["entity"]))
		{
			self.moving_platform = var_06["entity"];
		}
		else
		{
			self.moving_platform = undefined;
		}

		if(self.canbeplaced != var_02)
		{
			if(self.canbeplaced)
			{
				var_05 setmodel(var_03.modelplacement);
				param_01 forceusehinton(var_03.placestring);
			}
			else
			{
				var_05 setmodel(var_03.modelplacementfailed);
				param_01 forceusehinton(var_03.cannotplacestring);
			}
		}

		var_02 = self.canbeplaced;
		wait(0.05);
	}
}

//Function Number: 10
deactivate(param_00)
{
	self makeunusable();
	func_4206();
	self freeentitysentient();
	var_01 = level.placeableconfigs[param_00];
	if(isdefined(var_01.ondeactivedelegate))
	{
		self [[ var_01.ondeactivedelegate ]](param_00);
	}
}

//Function Number: 11
func_4206()
{
	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0("none",(0,0,0));
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::func_7099(undefined,(0,0,0));
	}
}

//Function Number: 12
func_3F74(param_00)
{
	self endon("carried");
	var_01 = level.placeableconfigs[param_00];
	maps\mp\gametypes\_damage::func_537B(var_01.maxhealth,var_01.damagefeedback,::handledeathdamage,::modifydamage,1);
}

//Function Number: 13
modifydamage(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_05 = self.config;
	if(isdefined(var_05.allowmeleedamage) && var_05.allowmeleedamage)
	{
		var_04 = maps\mp\gametypes\_damage::handlemeleedamage(param_01,param_02,var_04);
	}

	if(isdefined(var_05.allowempdamage) && var_05.allowempdamage)
	{
		var_04 = maps\mp\gametypes\_damage::handleempdamage(param_01,param_02,var_04);
	}

	var_04 = maps\mp\gametypes\_damage::func_3F8A(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handlegrenadedamage(param_01,param_02,var_04);
	var_04 = maps\mp\gametypes\_damage::handleapdamage(param_01,param_02,var_04,param_00);
	if(isdefined(var_05.modifydamage))
	{
		var_04 = self [[ var_05.modifydamage ]](param_01,param_02,var_04);
	}

	return var_04;
}

//Function Number: 14
handledeathdamage(param_00,param_01,param_02,param_03)
{
	var_04 = self.config;
	var_05 = maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,var_04.xppopup,var_04.destroyedvo);
	if(var_05 && isdefined(var_04.ondestroyeddelegate))
	{
		self [[ var_04.ondestroyeddelegate ]](self.streakname,param_00,self.owner,param_02);
	}
}

//Function Number: 15
func_3F75(param_00)
{
	self endon("carried");
	self waittill("death");
	var_01 = level.placeableconfigs[param_00];
	if(isdefined(self))
	{
		deactivate(param_00);
		if(isdefined(var_01.modeldestroyed))
		{
			self setmodel(var_01.modeldestroyed);
		}

		if(isdefined(var_01.ondeathdelegate))
		{
			self [[ var_01.ondeathdelegate ]](param_00);
		}

		self delete();
	}
}

//Function Number: 16
func_5904(param_00,param_01)
{
	self endon("placed");
	self endon("death");
	param_01 endon("disconnect");
	param_01 waittill("death");
	if(self.canbeplaced)
	{
		thread func_595A(param_00);
	}

	func_58FF(param_00);
}

//Function Number: 17
onkillstreakdisowned(param_00)
{
	self endon("death");
	level endon("game_ended");
	self.owner waittill("killstreak_disowned");
	cleanup(param_00);
}

//Function Number: 18
func_593F(param_00)
{
	self endon("death");
	level waittill("game_ended");
	cleanup(param_00);
}

//Function Number: 19
cleanup(param_00)
{
	if(isdefined(self.isplaced))
	{
		self notify("death");
	}

	func_58FF(param_00);
}

//Function Number: 20
watchplayerconnected()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		thread func_595F(var_00);
	}
}

//Function Number: 21
func_595F(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	self disableplayeruse(param_00);
}

//Function Number: 22
timeout(param_00)
{
	self endon("death");
	level endon("game_ended");
	var_01 = level.placeableconfigs[param_00];
	var_02 = var_01.lifespan;
	while(var_02 > 0)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if(!isdefined(self.carriedby))
		{
			var_02 = var_02 - 1;
		}
	}

	if(isdefined(self.owner) && isdefined(var_01.gonevo))
	{
		self.owner thread maps\mp\_utility::func_4D35(var_01.gonevo);
	}

	self notify("death");
}

//Function Number: 23
func_65BE()
{
	if(self hasweapon("iw6_riotshield_mp"))
	{
		self.restoreweapon = "iw6_riotshield_mp";
		self takeweapon("iw6_riotshield_mp");
	}
}

//Function Number: 24
func_65A6()
{
	if(maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.restoreperk = "specialty_explosivebullets";
		maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	}
}

//Function Number: 25
func_6667()
{
	if(isdefined(self.restoreweapon))
	{
		maps\mp\_utility::_giveweapon(self.restoreweapon);
		self.restoreweapon = undefined;
	}
}

//Function Number: 26
func_665E()
{
	if(isdefined(self.restoreperk))
	{
		maps\mp\_utility::func_3CFB(self.restoreperk,0);
		self.restoreperk = undefined;
	}
}

//Function Number: 27
createbombsquadmodel(param_00)
{
	var_01 = level.placeableconfigs[param_00];
	if(isdefined(var_01.modelbombsquad))
	{
		var_02 = spawn("script_model",self.origin);
		var_02.angles = self.angles;
		var_02 hide();
		var_02 thread maps\mp\gametypes\_weapons::bombsquadvisibilityupdater(self.owner);
		var_02 setmodel(var_01.modelbombsquad);
		var_02 linkto(self);
		var_02 setcontents(0);
		self.bombsquadmodel = var_02;
		self waittill("death");
		if(isdefined(var_02))
		{
			var_02 delete();
			self.bombsquadmodel = undefined;
		}
	}
}

//Function Number: 28
func_9492(param_00)
{
	self show();
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel show();
		level notify("update_bombsquad");
	}
}

//Function Number: 29
func_9232(param_00)
{
	self hide();
	if(isdefined(self.bombsquadmodel))
	{
		self.bombsquadmodel hide();
	}
}

//Function Number: 30
createcarriedobject(param_00)
{
	if(isdefined(self.iscarrying) && self.iscarrying)
	{
	}

	var_01 = spawnturret("misc_turret",self.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = self.angles;
	var_01.owner = self;
	var_02 = level.placeableconfigs[param_00];
	var_01 setmodel(var_02.modelbase);
	var_01 maketurretinoperable();
	var_01 setturretmodechangewait(1);
	var_01 setmode("sentry_offline");
	var_01 makeunusable();
	var_01 setsentryowner(self);
	var_01 setsentrycarrier(self);
	var_01 setcandamage(0);
	var_01 setcontents(0);
	return var_01;
}