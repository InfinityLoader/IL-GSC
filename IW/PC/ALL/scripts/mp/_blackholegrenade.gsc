/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_blackholegrenade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 1899 ms
 * Timestamp: 10/27/2023 12:14:36 AM
*******************************************************************/

//Function Number: 1
func_2B3C()
{
	level.var_2ABD = [];
	level.var_2ABC = [];
}

//Function Number: 2
func_2B41()
{
	scripts\mp\_weapons::func_B2A3();
	self.var_222 func_2B3D(self,1);
}

//Function Number: 3
func_2B40()
{
}

//Function Number: 4
func_2B3D(param_00,param_01)
{
	param_00 endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	scripts\mp\_utility::func_D915("black hole grenade spawned",self);
	thread bhg_deleteondisowned(param_00);
	param_00.var_10E19 = 0;
	thread func_12EB1(param_00,param_01);
	if(!param_01)
	{
		param_00 waittill("blackhole_grenade_stuck");
		if(!isdefined(param_00))
		{
			return;
		}
	}

	param_00.var_10E19 = 1;
	thread func_12F29(param_00);
	param_00 waittill("blackhole_grenade_active");
	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_10E19 = 2;
	thread func_12E56(param_00);
	param_00 waittill("blackhole_grenade_finished");
	if(!isdefined(param_00))
	{
	}
}

//Function Number: 5
func_2B3E(param_00)
{
	param_00 endon("death");
	thread bhg_deleteondisowned(param_00);
	param_00.var_9935 = 1;
	var_01 = spawn("script_model",param_00.origin);
	var_01 method_831F(param_00.var_222);
	var_01 setmodel("prop_mp_black_hole_grenade_scr");
	var_01 method_8317(1);
	var_01 linkto(param_00);
	var_01 thread func_4116(param_00);
	param_00.var_289 = var_01;
	var_02 = func_7E08(param_00);
	thread func_10831(param_00,var_02,param_00.angles,self,"blackhole_grenade_mp");
	thread func_10833(param_00,var_02,param_00.angles,2750);
	thread func_13A58(param_00,var_02);
	thread watchforempents(param_00,var_02);
	param_00.var_289 setscriptablepartstate("vortexUpdate","active",0);
	param_00 thread func_CB0C();
	wait(2);
	param_00 delete();
}

//Function Number: 6
func_12EB1(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("death");
	if(!param_01)
	{
		param_00 waittill("missile_stuck",var_02);
	}

	self notify("powers_blackholeGrenade_used",1);
	playsoundatpos(param_00.origin,"blackhole_plant");
	param_00 method_859F();
	param_00 method_85A0();
	param_00 method_831F(param_00.var_222);
	param_00 method_82DD(param_00.var_222);
	param_00 method_8317(1);
	var_03 = scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	if(var_03)
	{
		param_00.hasruggedeqp = 1;
	}

	var_04 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(var_03),30,15);
	var_05 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(var_03),"hitequip","");
	param_00 thread scripts\mp\_damage::func_B9C6(var_04,var_05,::bhg_handlefataldamage,::bhg_handledamage,0);
	param_00 thread bhg_destroyonemp();
	param_00 thread bhg_destroyongameend();
	param_00 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	thread scripts\mp\_weapons::func_C798(param_00,self);
	param_00 bhg_addtoglobalarr();
	var_06 = func_7E08(param_00);
	var_07 = func_10835(param_00,var_06,param_00.angles);
	param_00.var_289 = var_07;
	param_00 notify("blackhole_grenade_stuck");
}

//Function Number: 7
func_12F29(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00 setscriptablepartstate("beam","active",0);
	param_00.var_289 setscriptablepartstate("vortexStart","active",0);
	wait(1.2);
	param_00 notify("blackhole_grenade_active");
}

//Function Number: 8
func_12E56(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	var_01 = func_7E08(param_00);
	param_00.planted = 1;
	thread func_10831(param_00,var_01,param_00.angles,self,"blackhole_grenade_mp");
	thread func_10833(param_00,var_01,param_00.angles,2750);
	thread func_13A58(param_00,var_01);
	thread watchforempents(param_00,var_01);
	param_00.var_289 setscriptablepartstate("vortexUpdate","active",0);
	param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_00.var_222,1);
	param_00 thread func_CB0C();
	wait(2);
	scripts\mp\_utility::func_D915("black hole grenade finished",self);
	param_00 scripts\mp\sentientpoolmanager::unregistersentient(param_00.sentientpool,param_00.sentientpoolindex);
	param_00 thread bhg_destroy();
}

//Function Number: 9
func_13A58(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00.var_11AD2 = [];
	var_02 = anglestoup(param_00.angles);
	var_03 = spawn("trigger_rotatable_radius",param_01 - var_02 * 20 * 0.5,0,20,20);
	var_03.angles = param_00.angles;
	var_03 enablelinkto();
	var_03 linkto(param_00);
	var_03 thread func_4108(param_00);
	var_04 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_sky","physicscontents_water","physicscontents_item"]);
	while(isdefined(var_03))
	{
		var_03 waittill("trigger",var_05);
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05 func_9FAF(param_00))
		{
			continue;
		}

		if(lib_0DF8::func_9DDF(var_05))
		{
			continue;
		}

		if(!isplayer(var_05) || isagent(var_05))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_05))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9F72(var_05))
		{
			continue;
		}

		if(!level.var_740A && var_05 != self && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self,var_05)))
		{
			continue;
		}

		var_06 = "tag_eye";
		var_07 = func_7E08(param_00);
		var_08 = var_05 gettagorigin(var_06);
		var_09 = function_0287(var_07,var_08,var_04,[param_00,var_05],0,"physicsquery_closest",1);
		if(isdefined(var_09) && var_09.size > 0)
		{
			var_06 = "tag_origin";
			var_08 = var_05 gettagorigin(var_06);
			var_09 = function_0287(var_07,var_08,var_04,[param_00,var_05],0,"physicsquery_closest",1);
			if(isdefined(var_09) && var_09.size > 0)
			{
				continue;
			}
		}

		var_05 thread func_11AD5(param_00);
		var_05 dodamage(140,param_00.origin,param_00.var_222,param_00,"MOD_EXPLOSIVE","blackhole_grenade_mp");
	}
}

//Function Number: 10
watchforempents(param_00,param_01)
{
	self endon("disconnect");
	param_00 endon("death");
	var_02 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_sky","physicscontents_water","physicscontents_item"]);
	var_03 = func_7E08(param_00);
	for(;;)
	{
		var_04 = scripts\mp\_weapons::func_7E8C(param_01,60,0);
		foreach(var_06 in var_04)
		{
			if(var_06 func_9FAF(param_00) || var_06 == param_00)
			{
				continue;
			}

			var_07 = var_06 gettagorigin("tag_origin");
			var_08 = function_0287(var_03,var_07,var_02,[param_00,var_06],0,"physicsquery_closest",1);
			if(isdefined(var_08) && var_08.size > 0)
			{
				continue;
			}

			var_06 thread func_11AD5(param_00);
			var_06 dodamage(140,param_00.origin,param_00.var_222,param_00,"MOD_EXPLOSIVE","blackhole_grenade_mp");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 11
func_10835(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_01);
	var_03.angles = param_02;
	var_03 method_831F(param_00.var_222);
	var_03 method_82DD(param_00);
	var_03 setmodel("prop_mp_black_hole_grenade_scr");
	var_03 linkto(param_00);
	var_03 thread func_4116(param_00);
	return var_03;
}

//Function Number: 12
bhg_handlefataldamage(param_00,param_01,param_02,param_03,param_04)
{
	bhg_awardpoints(param_00);
	thread bhg_destroy();
}

//Function Number: 13
bhg_handledamage(param_00,param_01,param_02,param_03,param_04)
{
	if(!lib_0DF8::func_213D(param_00,self))
	{
		return 0;
	}

	if(param_02 == "MOD_MELEE")
	{
		return self.maxhealth + 1;
	}

	var_05 = 15;
	var_06 = 1;
	if(scripts\mp\_utility::func_9DFF(param_01,param_02))
	{
		var_06 = 2;
	}
	else if(param_03 >= scripts\mp\_weapons::minegettwohitthreshold())
	{
		var_06 = 2;
	}

	scripts\mp\_powers::equipmenthit(self.var_222,param_00,param_01,param_02);
	return var_06 * var_05;
}

//Function Number: 14
func_4116(param_00)
{
	param_00 waittill("death");
	self setscriptablepartstate("vortexStart","neutral",0);
	self setscriptablepartstate("vortexUpdate","neutral",0);
	self setscriptablepartstate("vortexEnd","active",0);
	wait(2);
	self delete();
}

//Function Number: 15
func_10833(param_00,param_01,param_02,param_03)
{
	var_04 = physics_volumecreate(param_01,256);
	var_04.angles = param_02;
	var_04 linkto(param_00);
	var_04 method_852C(1,param_01,param_03);
	var_04 method_8526(1);
	var_04 method_8529(1);
	var_04.time = gettime();
	var_04.var_720E = param_03;
	level.var_2ABC scripts\common\utility::func_22BC(level.var_2ABC);
	var_05 = undefined;
	var_06 = 0;
	for(var_07 = 0;var_07 < 7;var_07++)
	{
		var_08 = level.var_2ABC[var_07];
		if(!isdefined(var_08))
		{
			var_06 = var_07;
			break;
		}
		else if(!isdefined(var_05) || isdefined(var_05) && var_05.time > var_08.time)
		{
			var_05 = var_08;
			var_06 = var_07;
		}
	}

	if(isdefined(var_05))
	{
		var_05 delete();
	}

	level.var_2ABC[var_06] = var_04;
	var_04 thread func_139AD();
	var_04 thread func_4108(param_00);
}

//Function Number: 16
func_139AD()
{
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(var_00 != self.origin)
		{
			self method_852C(1,self.origin,self.var_720E);
			var_00 = self.origin;
		}

		wait(0.1);
	}
}

//Function Number: 17
func_10831(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = function_02AF(param_03,param_04,param_01);
	var_05.angles = param_02;
	var_05 linkto(param_00);
	thread bhg_trackimpulsefielddebuff(var_05,param_03);
	var_05 thread func_4108(param_00);
}

//Function Number: 18
func_CB0C()
{
	var_00 = spawnstruct();
	func_CB0D(var_00);
	physicsexplosionsphere(var_00.var_D699,128,0,200);
}

//Function Number: 19
func_CB0D(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00.var_D699 = self.origin;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
bhg_destroyongameend()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread bhg_destroy();
}

//Function Number: 21
bhg_destroyonemp()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01,var_02,var_03,var_04);
	if(isdefined(var_03) && var_03 == "emp_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_00)))
		{
			var_00 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}

	bhg_awardpoints(var_00);
	var_05 = "";
	if(scripts\mp\_utility::func_9FB3(self.hasruggedeqp))
	{
		var_05 = "hitequip";
	}

	if(isplayer(var_00))
	{
		var_00 scripts\mp\_damagefeedback::func_12E84(var_05);
	}

	thread bhg_destroy();
}

//Function Number: 22
bhg_deleteondisowned(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators","disconnect");
	self delete();
}

//Function Number: 23
func_4108(param_00,param_01)
{
	self endon("death");
	self notify("cleanupOnParentDeath");
	self endon("cleanupOnParentDeath");
	if(isdefined(param_00))
	{
		param_00 waittill("death");
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}

	self delete();
}

//Function Number: 24
func_9FAF(param_00)
{
	return isdefined(param_00.var_11AD2[self getentitynumber()]);
}

//Function Number: 25
func_11AD5(param_00)
{
	param_00 endon("death");
	var_01 = self getentitynumber();
	param_00.var_11AD2[var_01] = self;
	func_11AD6();
	param_00.var_11AD2[var_01] = undefined;
}

//Function Number: 26
func_11AD6()
{
	self endon("death");
	self endon("disconnect");
	wait(0.75);
}

//Function Number: 27
bhg_addtoglobalarr()
{
	var_00 = self getentitynumber();
	if(isdefined(level.var_2ABD[var_00]))
	{
		return;
	}

	level.var_2ABD[var_00] = self;
	thread bhg_removefromglobalarrondeath();
}

//Function Number: 28
bhg_removefromglobalarr(param_00)
{
	self notify("blackHoleGrenade_removeFromGlobalArr");
	if(!isdefined(param_00))
	{
		param_00 = self getentitynumber();
	}

	level.var_2ABD[param_00] = undefined;
}

//Function Number: 29
bhg_removefromglobalarrondeath()
{
	self endon("blackHoleGrenade_removeFromGlobalArr");
	var_00 = self getentitynumber();
	self waittill("death");
	thread bhg_removefromglobalarr(var_00);
}

//Function Number: 30
bhg_trackimpulsefielddebuff(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.players = [];
	bhg_trackimpulsefielddebuffend(param_00,param_01,var_02);
	if(isdefined(param_01))
	{
		foreach(var_04 in var_02.players)
		{
			if(isdefined(var_04) && scripts\mp\_utility::func_9F19(var_04))
			{
				scripts\mp\_gamescore::func_12D6F(param_01,var_04,"blackhole_grenade_mp");
			}
		}
	}
}

//Function Number: 31
bhg_trackimpulsefielddebuffend(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_01 endon("disconnect");
	for(;;)
	{
		var_03 = [];
		var_04 = undefined;
		if(level.teambased)
		{
			var_04 = scripts\mp\_utility::func_807C(param_00.origin,256,scripts\mp\_utility::getotherteam(param_01.team),param_01);
		}
		else
		{
			var_04 = scripts\mp\_utility::func_807C(param_00.origin,256,undefined,param_01);
		}

		foreach(var_06 in var_04)
		{
			var_07 = var_06 getentitynumber();
			if(!scripts\mp\_utility::func_9F19(var_06))
			{
				param_02.players[var_07] = undefined;
				continue;
			}

			if(isdefined(param_02.players[var_07]))
			{
				param_02.players[var_07] = undefined;
				var_03[var_07] = var_06;
				continue;
			}

			var_03[var_07] = var_06;
			scripts\mp\_gamescore::func_11ACE(param_01,var_06,"blackhole_grenade_mp");
		}

		foreach(var_06 in param_02.players)
		{
			if(isdefined(var_06) && scripts\mp\_utility::func_9F19(var_06))
			{
				scripts\mp\_gamescore::func_12D6F(param_01,var_06,"blackhole_grenade_mp");
			}
		}

		param_02.players = var_03;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 32
bhg_destroy()
{
	thread bhg_delete(0.1);
	self setscriptablepartstate("beam","neutral",0);
	self setscriptablepartstate("destroy","active",0);
}

//Function Number: 33
bhg_delete(param_00)
{
	self notify("death");
	self setcandamage(0);
	self.var_69BA = 1;
	wait(0.1);
	self delete();
}

//Function Number: 34
bhg_awardpoints(param_00)
{
	if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,param_00)))
	{
		param_00 notify("destroyed_equipment");
		param_00 thread scripts\mp\_utility::func_83B4("destroyed_equipment");
	}
}

//Function Number: 35
func_7E08(param_00)
{
	if(scripts\mp\_utility::func_9FB3(param_00.var_9935))
	{
		return param_00.origin;
	}

	if(!isdefined(param_00.centeroffset))
	{
		var_01 = anglestoup(param_00.angles);
		var_02 = param_00.origin;
		var_03 = var_02 + var_01 * 55;
		var_04 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_sky","physicscontents_water","physicscontents_item"]);
		var_05 = function_0287(var_02,var_03,var_04,[self],0,"physicsquery_closest");
		if(isdefined(var_05) && var_05.size > 0)
		{
			var_03 = var_05[0]["position"];
			param_00.centeroffset = max(3,vectordot(var_01,var_03 - var_02) - 2);
		}
		else
		{
			param_00.centeroffset = 55;
		}
	}

	return param_00.origin + anglestoup(param_00.angles) * param_00.centeroffset;
}