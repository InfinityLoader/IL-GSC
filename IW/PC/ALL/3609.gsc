/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3609.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 26 ms
 * Timestamp: 10/27/2023 12:30:54 AM
*******************************************************************/

//Function Number: 1
func_1127D()
{
	var_00 = spawnstruct();
	var_00.var_12801 = [];
	var_00.var_1141B = [];
	var_00.var_1141B[0] = "fx_01_jnt";
	var_00.var_1141B[1] = "fx_02_jnt";
	var_00.var_1141B[2] = "fx_03_jnt";
	var_00.var_1141B[3] = "fx_04_jnt";
	level.var_11267 = var_00;
}

//Function Number: 2
func_11296(param_00)
{
	var_01 = self.supertrophies;
	if(isdefined(var_01))
	{
		foreach(var_03 in var_01)
		{
			var_03 thread func_11274();
		}

		self.supertrophies = undefined;
	}

	if(isdefined(self.var_11293))
	{
		self.var_11293 = undefined;
		func_11276(param_00);
	}
}

//Function Number: 3
func_11297()
{
	scripts\mp\_utility::func_1254();
	self setscriptablepartstate("killstreak","visor_active",0);
	self.var_11293 = 1;
	func_11272();
	thread func_1129D();
	thread func_1129B();
	thread func_1129C();
	thread watcharbitraryup();
	return 1;
}

//Function Number: 4
func_11276(param_00)
{
	self notify("superTrophy_end");
	if(!scripts\mp\_utility::func_9FB3(param_00))
	{
		scripts\mp\_utility::func_11DB();
	}

	self setscriptablepartstate("killstreak","neutral",0);
	func_11273(param_00);
	var_01 = self.var_11293;
	self.var_11293 = undefined;
	return scripts\mp\_utility::func_9FB3(var_01);
}

//Function Number: 5
func_11274()
{
	self notify("death");
	supertrophy_removefromarrays(self,self.var_222);
	if(isdefined(self.objstruct))
	{
		self.objstruct func_11275();
	}

	if(isdefined(self.var_222))
	{
		scripts\mp\_utility::func_D915("supertrophy destroyed",self.var_222);
	}

	self setcandamage(0);
	self method_854A();
	self setscriptablepartstate("effects","activeDestroyStart",0);
	wait(3);
	self setscriptablepartstate("effects","activeDestroyEnd",0);
	wait(0.1);
	self delete();
}

//Function Number: 6
func_11299()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self setscriptablepartstate("effects","activeDeployStart",0);
	self.objstruct = func_11270();
	wait(1.25);
	self setscriptablepartstate("effects","activeDeployEnd",0);
	scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground",self.var_222);
	thread scripts\mp\_weapons::outlinesuperequipment(self,self.var_222);
	thread scripts\mp\_entityheadicons::func_F73E(self.var_222,(0,0,50),0);
	thread scripts\mp\perks\_perk_equipmentping::func_E84B(self);
	thread func_1129F();
	thread func_1129E();
}

//Function Number: 7
func_11278(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	if(!lib_0DF8::func_213D(self,param_00))
	{
		return 0;
	}

	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	var_05 = func_1127B(param_01,param_02,var_05);
	var_05 = supertrophy_handlesuperdamage(param_01,param_02,var_05);
	var_05 = scripts\mp\_supers::modifysuperequipmentdamage(param_00,param_01,param_02,var_05,param_04);
	return var_05;
}

//Function Number: 8
func_11279(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
	{
		param_00 thread scripts\mp\_events::func_11265(self.var_222);
		param_00 notify("destroyed_equipment");
	}

	if(isdefined(param_00) && isplayer(param_00) && param_00 != self.var_222)
	{
		param_00 scripts\mp\_missions::func_D991("ch_killjoy_six_ability");
	}

	thread func_11274();
}

//Function Number: 9
func_1127B(param_00,param_01,param_02)
{
	if(param_01 == "MOD_MELEE")
	{
		return int(ceil(self.maxhealth / 2));
	}

	return param_02;
}

//Function Number: 10
supertrophy_handlesuperdamage(param_00,param_01,param_02)
{
	var_03 = 1;
	var_04 = getweaponbasename(param_00);
	if(isdefined(var_04))
	{
		param_00 = var_04;
	}

	switch(param_00)
	{
		case "micro_turret_gun_mp":
			var_03 = 4;
			break;

		case "iw7_penetrationrail_mp":
			var_03 = 2.3;
			break;

		case "iw7_atomizer_mp":
			var_03 = 1.5;
			break;
	}

	return int(ceil(var_03 * param_02));
}

//Function Number: 11
func_1129D()
{
	self endon("disconnect");
	self endon("superTrophy_createTrophy");
	self endon("superTrophy_end");
	for(;;)
	{
		self waittill("equip_deploy_succeeded",var_00,var_01,var_02,var_03);
		if(var_00 == "deploy_supertrophy_mp")
		{
			thread func_11271(var_01,var_02,var_03);
			break;
		}
	}
}

//Function Number: 12
func_1129B()
{
	self endon("disconnect");
	self endon("superTrophy_createTrophy");
	self endon("superTrophy_end");
	for(;;)
	{
		self waittill("equip_deploy_failed",var_00,var_01,var_02,var_03);
		if(var_00 == "deploy_supertrophy_mp")
		{
			self setweaponammoclip("deploy_supertrophy_mp",100);
			break;
		}
	}
}

//Function Number: 13
func_1129C()
{
	self endon("disconnect");
	self endon("superTrophy_createTrophy");
	self endon("superTrophy_end");
	level waittill("game_ended");
	scripts\mp\_supers::func_DE3B(9999000);
}

//Function Number: 14
watcharbitraryup()
{
	self endon("disconnect");
	self endon("superTrophy_createTrophy");
	self endon("superTrophy_end");
	scripts\common\utility::func_136F7();
	while(!scripts\mp\_utility::isinarbitraryup())
	{
		scripts\common\utility::func_136F7();
	}

	scripts\mp\_supers::superdisabledinarbitraryupmessage();
	scripts\mp\_supers::func_DE3B(9999000);
}

//Function Number: 15
func_11272()
{
	self.var_11277 = 1;
	scripts\common\utility::func_1C6E(0);
	scripts\mp\_powers::func_D729();
	scripts\mp\_utility::func_1C47(0);
}

//Function Number: 16
func_11273(param_00)
{
	if(!scripts\mp\_utility::func_9FB3(param_00))
	{
		if(scripts\mp\_utility::func_9FB3(self.var_11277))
		{
			scripts\common\utility::func_1C6E(1);
			scripts\mp\_powers::func_D72F();
			scripts\mp\_utility::func_1C47(1);
		}
	}

	self.var_11277 = undefined;
}

//Function Number: 17
func_11271(param_00,param_01,param_02)
{
	if(isdefined(self.var_11267))
	{
		self.var_11267 thread func_11274();
	}

	self notify("superTrophy_createTrophy");
	if(!isdefined(self.supertrophies))
	{
		self.supertrophies = [];
	}

	if(self.supertrophies.size >= supertrophy_getmaxnum())
	{
		self.supertrophies[0] thread func_11274();
	}

	var_03 = spawn("script_model",param_00);
	var_03.angles = param_01;
	var_03 method_831F(self);
	var_03 setmodel("super_trophy_mp_wm");
	var_03 method_8317(1);
	var_03 method_8549();
	var_03 method_8594();
	var_03.var_222 = self;
	var_03.team = var_03.var_222.team;
	var_03.var_11234 = "super_supertrophy";
	var_03.var_13C2E = "super_trophy_mp";
	var_03.planted = 1;
	var_03.var_B373 = [];
	var_03.var_B374 = [];
	var_03.var_1E2D = 10;
	supertrophy_addtoarrays(var_03,self);
	var_03 thread func_1126D();
	var_03 thread func_1126E();
	var_03.var_A63A = func_1126F(var_03);
	var_03.var_69DA = supertrophy_createexplosion(var_03);
	var_04 = scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	var_05 = scripts\common\utility::func_116D7(var_04,475,399);
	var_06 = scripts\common\utility::func_116D7(var_04,"hitequip","");
	var_03 thread scripts\mp\_damage::func_B9C6(var_05,var_06,::func_11279,::func_11278,0);
	if(isdefined(param_02))
	{
		var_03 scripts\mp\_weapons::func_69FF(param_02);
	}

	var_03 thread func_11299();
	self.var_11293 = undefined;
	scripts\mp\_supers::func_DE3B(9999000);
	level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_trophy",undefined,0.75);
	scripts\mp\_utility::func_D915("supertrophy placed",self);
}

//Function Number: 18
func_1126F(param_00)
{
	var_01 = spawn("script_model",param_00.origin + anglestoup(param_00.angles) * 65);
	var_01.angles = param_00.angles;
	var_01 setmodel("tag_origin");
	var_01 setscriptmoverkillcam("explosive");
	var_01 linkto(param_00);
	var_01 thread supertrophy_cleanuponparentdeath(param_00,5);
	return var_01;
}

//Function Number: 19
supertrophy_createexplosion(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.var_A63A = param_00.var_A63A;
	var_01.var_222 = param_00.var_222;
	var_01.team = param_00.team;
	var_01.var_11234 = param_00.var_11234;
	var_01.var_13C2E = param_00.var_13C2E;
	var_01 method_831F(var_01.var_222);
	var_01 method_82DD(var_01.var_222);
	var_01 setmodel("super_trophy_mp_explode");
	var_01.timebypart = [];
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_01.timebypart[var_02] = 0;
	}

	var_01 thread supertrophy_cleanuponparentdeath(param_00,0.1);
	return var_01;
}

//Function Number: 20
supertrophy_explode(param_00,param_01)
{
	foreach(var_04, var_03 in self.timebypart)
	{
		if(gettime() - var_03 / 1000 > 0.1)
		{
			self dontinterpolate();
			self.origin = param_00;
			self.angles = param_01;
			self setscriptablepartstate("explode" + var_04 + 1,"active",0);
			self.timebypart[var_04] = gettime();
			return;
		}
	}
}

//Function Number: 21
func_1129F()
{
	self endon("death");
	self.var_222 endon("disconnect");
	if(!isdefined(level.var_85D5))
	{
		level.var_85D5 = [];
	}

	if(!isdefined(level.var_B898))
	{
		level.var_B898 = [];
	}

	if(!isdefined(level.var_B779))
	{
		level.var_B779 = [];
	}

	var_00 = scripts\mp\_trophy_system::func_12804();
	for(;;)
	{
		var_01 = [];
		var_01[0] = level.var_85D5;
		var_01[1] = level.var_B898;
		var_01[2] = level.var_B779;
		var_02 = scripts\common\utility::func_2282(var_01);
		var_03 = func_1128F();
		foreach(var_05 in var_02)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(scripts\mp\_utility::func_9FB3(var_05.var_69BA))
			{
				continue;
			}

			if(supertrophy_checkignorelist(var_05))
			{
				continue;
			}

			var_06 = var_05.var_222;
			if(!isdefined(var_06) && isdefined(var_05.var_13C2E) && weaponclass(var_05.var_13C2E) == "grenade")
			{
				var_06 = getmissileowner(var_05);
			}

			if(isdefined(var_06) && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_06)))
			{
				continue;
			}

			if(distancesquared(var_05.origin,self.origin) > scripts\mp\_trophy_system::trophy_modifiedprotectiondistsqr(var_05,65536))
			{
				continue;
			}

			var_07 = function_0287(var_03,var_05.origin,var_00,[self,var_05],0,"physicsquery_closest");
			if(isdefined(var_07) && var_07.size > 0)
			{
				continue;
			}

			if(isdefined(self.objstruct))
			{
				self.objstruct thread supertrophy_setobjectivefiring();
			}

			thread func_1128E(var_05);
			self.var_1E2D--;
			if(self.var_1E2D <= 0)
			{
				thread func_11274();
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 22
func_1128E(param_00)
{
	level thread scripts\mp\_battlechatter_mp::func_EB87(self.var_222,"plr_perk_trophy_block",undefined,0.75);
	self.var_222 scripts\mp\killstreaks\_killstreaks::func_83A1();
	self.var_222 thread scripts\mp\_events::func_11262("super_supertrophy");
	self.var_222 scripts\mp\_supers::combatrecordsuperkill("super_supertrophy");
	param_00 setcandamage(0);
	param_00.var_69BA = 1;
	param_00 method_83AD();
	scripts\mp\_trophy_system::func_12821(param_00);
	scripts\mp\_trophy_system::func_12817(param_00,"super_trophy_mp",self.var_222);
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	if(scripts\mp\_weapons::func_9EE5(param_00))
	{
		param_00 scripts\mp\_weapons::func_51B5();
	}
	else if(param_00 scripts\mp\_domeshield::isdomeshield())
	{
		param_00 thread scripts\mp\_domeshield::domeshield_delete();
	}
	else
	{
		param_00 delete();
	}

	var_03 = supertrophy_getbesttag(var_01);
	var_04 = supertrophy_getpartbytag(var_03);
	self setscriptablepartstate(var_04,"active",0);
	self.var_69DA thread supertrophy_explode(var_01,var_02);
}

//Function Number: 23
func_1129E()
{
	self endon("death");
	self.var_222 endon("disconnect");
	var_00 = physics_createcontents(["physicscontents_solid","physicscontents_vehicle","physicscontents_glass","physicscontents_water","physicscontents_sky","physicscontents_missileclip"]);
	for(;;)
	{
		var_01 = scripts\mp\_utility::func_807C(self.origin,256,undefined);
		foreach(var_03 in self.var_B373)
		{
			if(!func_1127E(var_03))
			{
				continue;
			}

			if(scripts\common\utility::func_2286(var_01,var_03))
			{
				continue;
			}

			func_11292(var_03);
		}

		var_05 = func_1128F();
		foreach(var_07 in var_01)
		{
			if(!func_1127E(var_07))
			{
				continue;
			}

			var_08 = func_11295(var_07);
			var_09 = func_11288(var_07,var_05,var_00);
			if(!var_08 && var_09)
			{
				thread func_11284(var_07);
				continue;
			}

			if(var_08 && !var_09)
			{
				func_11292(var_07);
			}
		}

		var_01 = scripts\mp\_weapons::func_7E8C(self.origin,256);
		foreach(var_03 in self.var_B373)
		{
			if(func_1127E(var_03))
			{
				continue;
			}

			if(scripts\common\utility::func_2286(var_01,var_03))
			{
				continue;
			}

			func_11292(var_03);
		}

		foreach(var_07 in var_01)
		{
			if(func_1127E(var_07))
			{
				continue;
			}

			var_08 = func_11295(var_07);
			var_09 = func_11287(var_07);
			if(!var_08 && var_09)
			{
				thread func_11282(var_07);
				continue;
			}

			if(var_08 && !var_09)
			{
				func_11292(var_07);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 24
func_11284(param_00)
{
	func_11269(param_00);
	var_01 = param_00 getentitynumber();
	var_02 = spawnstruct();
	var_02.empd = 0;
	func_11285(param_00,var_02);
	if(isdefined(self))
	{
		func_11292(param_00,var_01);
	}

	if(isdefined(param_00))
	{
		if(isdefined(self) && isdefined(self.var_222))
		{
			scripts\mp\_gamescore::func_12D6F(self.var_222,param_00,"super_trophy_mp");
		}

		if(var_02.empd)
		{
			param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
		}
	}
}

//Function Number: 25
func_11285(param_00,param_01)
{
	self endon("death");
	self.var_222 endon("disconnect");
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_02 = gettime();
	while(func_11295(param_00))
	{
		if(!param_01.empd)
		{
			if(!param_00 scripts\mp\_utility::_hasperk("specialty_empimmune"))
			{
				param_00 scripts\mp\killstreaks\_emp_common::func_20C3();
				scripts\mp\_gamescore::func_11ACE(self.var_222,param_00,"super_trophy_mp");
				param_01.empd = 1;
			}
		}
		else if(param_00 scripts\mp\_utility::_hasperk("specialty_empimmune"))
		{
			param_00 scripts\mp\killstreaks\_emp_common::func_E0F3();
			scripts\mp\_gamescore::func_12D6F(self.var_222,param_00,"super_trophy_mp");
			param_01.empd = 0;
		}

		if(gettime() >= var_02)
		{
			if(param_00 scripts\mp\_utility::_hasperk("specialty_empimmune"))
			{
				self.var_222 scripts\mp\_damagefeedback::func_12E84("hiticonempimmune",undefined,undefined,undefined,1);
			}

			var_03 = scripts\mp\perks\_perkfunctions::func_20E0(self.var_222,param_00,0.7);
			param_00 dodamage(1,self.origin,self.var_222,self,"MOD_EXPLOSIVE","super_trophy_mp");
			param_00 shellshock("super_trophy_mp",var_03);
			thread supertrophy_persempplayereffectsstun(param_00,var_03);
			var_02 = gettime() + 1000;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 26
supertrophy_persempplayereffectsstun(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 scripts\mp\_weapons::func_F7FC();
	wait(param_01);
	param_00 scripts\mp\_weapons::func_F800();
}

//Function Number: 27
func_11282(param_00)
{
	func_11269(param_00);
	var_01 = param_00 getentitynumber();
	func_11283(param_00);
	if(isdefined(self))
	{
		func_11292(param_00,var_01);
	}
}

//Function Number: 28
func_11283(param_00)
{
	self endon("death");
	self.var_222 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	var_01 = gettime();
	while(func_11295(param_00))
	{
		if(gettime() >= var_01)
		{
			param_00 notify("emp_damage",self.var_222,2.25,self.origin,"super_trophy_mp","MOD_EXPLOSIVE");
			var_01 = gettime() + 1000;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 29
func_11270()
{
	var_00 = spawnstruct();
	var_00.var_222 = self.var_222;
	var_00.var_12802 = self;
	var_00.var_92B8 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_00.var_92B8 == -1)
	{
		return undefined;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_00.var_92B8,"active",self.origin,"icon_minimap_super_trophy_friendly");
	scripts\mp\objidpoolmanager::minimap_objective_onentitywithrotation(var_00.var_92B8,self);
	var_00 thread supertrophy_monitorobjective();
	return var_00;
}

//Function Number: 30
func_11275()
{
	self notify("returnMinimapID");
	scripts\mp\objidpoolmanager::returnminimapid(self.var_92B8);
}

//Function Number: 31
supertrophy_monitorobjective()
{
	self.var_12802 endon("death");
	self.var_222 endon("disconnect");
	self endon("returnMinimapID");
	self notify("superTrophy_monitorObjective");
	self endon("superTrophy_monitorObjective");
	while(isdefined(self.var_222) && isdefined(self.var_12802))
	{
		if(scripts\mp\_utility::func_9FB3(self.firingstate))
		{
			scripts\mp\objidpoolmanager::minimap_objective_playermask_showtoall(self.var_92B8);
			if(self.firingstate == 1)
			{
				scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_92B8,"icon_minimap_super_trophy_friendly_firing");
			}

			if(self.firingstate == 2)
			{
				scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_92B8,"icon_minimap_super_trophy_friendly");
			}

			continue;
		}

		scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefromall(self.var_92B8);
		scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_92B8,self.var_222 getentitynumber());
		scripts\mp\objidpoolmanager::minimap_objective_icon(self.var_92B8,"icon_minimap_super_trophy_friendly");
		foreach(var_01 in level.players)
		{
			if(var_01 scripts\mp\_utility::_hasperk("specialty_engineer"))
			{
				scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_92B8,var_01 getentitynumber());
				continue;
			}

			if(level.teambased && var_01.team == self.var_222.team)
			{
				scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_92B8,var_01 getentitynumber());
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 32
supertrophy_setobjectivefiring()
{
	self notify("superTrophy_setObjectiveFiring");
	self endon("superTrophy_setObjectiveFiring");
	self.firingstate = 1;
	thread supertrophy_monitorobjective();
	wait(0.5);
	self.firingstate = 2;
	wait(0.25);
	self.firingstate = undefined;
}

//Function Number: 33
func_11288(param_00,param_01,param_02)
{
	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return 0;
	}

	if(lib_0DF8::func_9DDF(param_00))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
	{
		return 0;
	}

	var_03 = function_0287(param_01,param_00.origin,param_02,[self,param_00],0,"physicsquery_closest");
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_03 = function_0287(param_01,param_00 geteye(),param_02,[self,param_00],0,"physicsquery_closest");
		if(isdefined(var_03) && var_03.size > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 34
func_11287(param_00)
{
	if(lib_0DF8::func_9DDF(param_00))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00.var_222)))
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
func_11280(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02) || param_02 != "super_trophy_mp")
	{
		return param_03;
	}

	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return param_03;
	}

	if(param_00 != param_01)
	{
		return param_03;
	}

	return 0;
}

//Function Number: 36
func_11286(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
func_11269(param_00)
{
	var_01 = param_00 getentitynumber();
	self.var_B373[var_01] = param_00;
}

//Function Number: 38
func_11292(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = param_00 getentitynumber();
	}

	self.var_B373[param_01] = undefined;
}

//Function Number: 39
func_11295(param_00)
{
	var_01 = param_00 getentitynumber();
	return isdefined(self.var_B373[var_01]);
}

//Function Number: 40
supertrophy_checkignorelist(param_00)
{
	return !supertrophy_ignorelistoverrides(param_00) && scripts\mp\_trophy_system::trophy_checkignorelist(param_00);
}

//Function Number: 41
supertrophy_ignorelistoverrides(param_00)
{
	if(isdefined(param_00.var_13C2E))
	{
		switch(param_00.var_13C2E)
		{
			case "jackal_cannon_mp":
			case "shockproj_mp":
			case "switch_blade_child_mp":
			case "thorproj_tracking_mp":
			case "thorproj_zoomed_mp":
			case "drone_hive_projectile_mp":
				return 1;

			case "trophy_mp":
			case "domeshield_mp":
				if(scripts\mp\_weapons::func_9EE5(param_00))
				{
					return 1;
				}
	
				break;
		}
	}

	return 0;
}

//Function Number: 42
func_1128F()
{
	return self.origin + anglestoup(self.angles) * 35;
}

//Function Number: 43
func_1127E(param_00)
{
	if(!isplayer(param_00) && !isagent(param_00))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9F22(param_00))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9F72(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
supertrophy_getbesttag(param_00)
{
	var_01 = level.var_11267.var_1141B;
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_0A, var_05 in var_01)
	{
		var_06 = self gettagorigin(var_05);
		var_07 = self gettagangles(var_05);
		var_08 = anglestoforward(var_07);
		var_09 = vectordot(vectornormalize(param_00 - var_06),var_08);
		if(var_0A == 0 || var_09 > var_02)
		{
			var_02 = var_09;
			var_03 = var_05;
		}
	}

	return var_03;
}

//Function Number: 45
supertrophy_getpartbytag(param_00)
{
	var_01 = level.var_11267.var_1141B;
	foreach(var_04, var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			return "protect" + var_04 + 1;
		}
	}

	return undefined;
}

//Function Number: 46
supertrophy_getmaxnum()
{
	var_00 = 1;
	if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
	{
		var_00++;
	}

	return var_00;
}

//Function Number: 47
supertrophy_onruggedequipmentunset()
{
	self endon("disconnect");
	if(!isdefined(self.supertrophies) || self.supertrophies.size <= 0)
	{
		return;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		self waittill("giveLoadout");
		if(!isdefined(self.supertrophies) || self.supertrophies.size <= 0)
		{
			return;
		}
	}

	var_00 = supertrophy_getmaxnum();
	var_01 = max(0,self.supertrophies.size - var_00);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self.supertrophies[0] thread func_11274();
	}
}

//Function Number: 48
supertrophy_addtoarrays(param_00,param_01)
{
	param_01.supertrophies[param_01.supertrophies.size] = param_00;
	level.var_11267.var_12801[param_00 getentitynumber()] = param_00;
}

//Function Number: 49
supertrophy_removefromarrays(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.supertrophies))
	{
		param_01.supertrophies = scripts\common\utility::func_22A9(param_01.supertrophies,param_00);
	}

	level.var_11267.var_12801[param_00 getentitynumber()] = undefined;
}

//Function Number: 50
func_1126D()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	thread func_11274();
}

//Function Number: 51
func_1126E()
{
	self endon("death");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread func_11274();
}

//Function Number: 52
supertrophy_cleanuponparentdeath(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	wait(param_01);
	self delete();
}