/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3332.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:26:35 AM
*******************************************************************/

//Function Number: 1
func_2B3C()
{
	level.var_2ABC = [];
}

//Function Number: 2
func_2B41()
{
	scripts\cp\_weapon::func_B2A3();
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

	var_02 = func_49DF(param_00);
	param_00.var_A63A = var_02;
	thread func_13A55(param_00);
	param_00.var_10E19 = 0;
	thread func_12EB1(param_00,var_02,param_01);
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
	thread func_13A55(param_00);
	var_01 = spawn("script_model",param_00.origin);
	var_01 method_831F(param_00.var_222);
	var_01 setmodel("prop_mp_black_hole_grenade_scr");
	var_01 method_8317(1);
	var_01 linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	var_01 thread func_4116(param_00);
	param_00.var_289 = var_01;
	var_02 = func_7E08(param_00);
	thread func_13A58(param_00);
	param_00.var_289 setscriptablepartstate("vortexUpdate","active_cp",0);
	param_00 thread func_CB0C();
	var_03 = 10;
	wait(var_03);
	param_00 delete();
}

//Function Number: 6
func_12EB1(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 endon("death");
	if(!param_02)
	{
		param_00 waittill("missile_stuck",var_03);
	}

	if(param_00 func_3E5B(self))
	{
		self notify("powers_blackholeGrenade_used",1);
		playsoundatpos(param_00.origin,"blackhole_plant");
		var_04 = func_10834(param_00,param_00.origin,param_00.angles);
		param_00.var_DA64 = var_04;
		var_05 = func_7E08(param_00);
		var_06 = func_10835(param_00,var_05,param_00.angles);
		param_00.var_289 = var_06;
		param_01 unlink();
		param_01.origin = var_05;
		param_01.angles = param_00.angles;
		param_01 linkto(param_00);
		param_01 thread func_4108(var_06,10);
		param_00 notify("blackhole_grenade_stuck");
		return;
	}

	thread func_CC21(var_04);
}

//Function Number: 7
func_3E5B(param_00)
{
	if(!isdefined(self))
	{
		return 0;
	}

	var_01 = param_00 method_8428(param_00.origin,self.origin);
	if(var_01.size < 1)
	{
		return 0;
	}
	else if(distance(var_01[var_01.size - 1],self.origin) >= 12)
	{
		return 0;
	}

	var_02 = getclosestpointonnavmesh(self.origin);
	if(!isdefined(var_02))
	{
		return 0;
	}

	if(distance(self.origin,var_02) > 18)
	{
		return 0;
	}

	if(isdefined(level.var_164B))
	{
		if(!self [[ level.var_164B ]](var_02))
		{
			return 0;
		}
	}

	if(!scripts\cp\_weapon::func_9E54(self.origin,level.var_9B0B,param_00,undefined,1))
	{
		return 0;
	}

	if(positionwouldtelefrag(self.origin))
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_12F29(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00.var_DA64 setscriptablepartstate("beam","active",0);
	param_00.var_289 setscriptablepartstate("vortexStart","active",0);
	var_01 = 1.2;
	wait(var_01);
	param_00 notify("blackhole_grenade_active");
}

//Function Number: 9
func_12E56(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	var_01 = func_7E08(param_00);
	thread grabclosestzombies(param_00);
	param_00.var_289 setscriptablepartstate("vortexUpdate","active_cp",0);
	param_00 thread func_CB0C();
	var_02 = 10;
	wait(var_02);
	param_00 delete();
}

//Function Number: 10
grabclosestzombies(param_00,param_01)
{
	param_00 endon("death");
	param_00.grabbedents = [];
	var_02 = anglestoup(param_00.angles);
	var_03 = spawn("trigger_rotatable_radius",func_7E08(param_00) - var_02 * 64 * 0.5,0,200,64);
	var_03.angles = param_00.angles;
	var_03 enablelinkto();
	var_03 linkto(param_00);
	var_03 thread func_4108(param_00);
	while(isdefined(var_03))
	{
		var_03 waittill("trigger",var_04);
		if(!scripts\cp\_utility::func_9F19(var_04) || !isdefined(param_00.var_222))
		{
			continue;
		}

		if(isplayer(var_04))
		{
			continue;
		}

		if(isdefined(var_04.team) && var_04.team == "allies")
		{
			continue;
		}

		if(param_00.var_222 == var_04)
		{
			continue;
		}

		if(!lib_0D12::func_213D(param_00,var_04))
		{
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_04) || isdefined(var_04.flung))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_04.not_affected_by_traps))
		{
			continue;
		}

		if(!isalive(var_04))
		{
			continue;
		}

		if(!var_04 isgrabbedent(param_00))
		{
			var_04 thread grabent(param_00);
			var_04.flung = 1;
			var_04 thread func_111B0(var_04,param_00,param_01);
			wait(0.2);
		}
	}
}

//Function Number: 11
func_111B0(param_00,param_01,param_02)
{
	self endon("death");
	param_01 endon("death");
	thread killzombieongrenadedeath(param_01);
	if(scripts\common\utility::istrue(param_02))
	{
		var_03 = param_01.origin;
	}
	else
	{
		var_03 = param_02.origin + (0,0,32);
	}

	self.var_EF64 = 1;
	wait(randomfloatrange(0,1));
	var_04 = 22500;
	while(distancesquared(self.origin,param_01.origin) > var_04)
	{
		self setvelocity(vectornormalize(param_01.origin - self.origin) * 150 + (0,0,30));
		wait(0.05);
	}

	var_05 = 2304;
	self.nocorpse = 1;
	self.var_180 = 1;
	self.anchor = spawn("script_origin",self.origin);
	self.anchor.angles = self.angles;
	self linkto(self.anchor);
	self.anchor moveto(var_03,0.5);
	wait(0.5);
	if(soundexists("trap_blackhole_body_gore"))
	{
		playsoundatpos(self.origin,"trap_blackhole_body_gore");
	}

	playfx(level._effect["blackhole_trap_death"],self.origin,anglestoforward((-90,0,0)),anglestoup((-90,0,0)));
	self.anchor delete();
	self.disable_armor = 1;
	self dodamage(self.health + 1000,param_01.origin,param_01.var_222,param_01,"MOD_EXPLOSIVE","blackhole_grenade_mp");
}

//Function Number: 12
killzombieongrenadedeath(param_00)
{
	self endon("death");
	var_01 = param_00.origin;
	var_02 = param_00.var_222;
	param_00 waittill("death");
	self.nocorpse = 1;
	self.var_180 = 1;
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}

	self dodamage(self.health + 1000,var_01,var_02,var_02,"MOD_EXPLOSIVE","blackhole_grenade_mp");
}

//Function Number: 13
func_13A58(param_00)
{
	param_00 endon("death");
	param_00.var_11AD2 = [];
	var_01 = anglestoup(param_00.angles);
	var_02 = spawn("trigger_rotatable_radius",func_7E08(param_00) - var_01 * 64 * 0.5,0,64,64);
	var_02.angles = param_00.angles;
	var_02 enablelinkto();
	var_02 linkto(param_00);
	var_02 thread func_4108(param_00);
	while(isdefined(var_02))
	{
		var_02 waittill("trigger",var_03);
		if(!scripts\cp\_utility::func_9F19(var_03) || !isdefined(param_00.var_222))
		{
			continue;
		}

		if(param_00.var_222 == var_03)
		{
			continue;
		}

		if(!lib_0D12::func_213D(param_00,var_03))
		{
			continue;
		}

		if(!var_03 func_9FAF(param_00))
		{
			var_03 thread func_11AD5(param_00);
			var_03 dodamage(int(0.34 * var_03.maxhealth),param_00.origin,param_00.var_222,param_00,"MOD_EXPLOSIVE","blackhole_grenade_mp");
		}
	}
}

//Function Number: 14
func_13A55(param_00)
{
	param_00 endon("death");
	self waittill("disconnect");
	param_00 delete();
}

//Function Number: 15
func_10834(param_00,param_01,param_02)
{
	param_00 hide(1);
	var_03 = spawn("script_model",param_01);
	var_03.angles = param_02;
	var_03 method_831F(param_00.var_222);
	var_03 method_82DD(param_00.var_222);
	var_03 setmodel("black_hole_projector_wm");
	var_03 linkto(param_00);
	var_03.var_15F = param_00;
	var_03.var_222 = param_00.var_222;
	var_03 thread func_4108(param_00);
	var_03 thread func_13A5E();
	return var_03;
}

//Function Number: 16
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

//Function Number: 17
func_13A5E()
{
	scripts\cp\_weapon::func_B9C6(38,"blackhole",::func_DA65,::func_DA66,0);
}

//Function Number: 18
func_DA65(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 notify("destroyed_equipment");
	}

	playsoundatpos(self.var_15F.origin,"mp_killstreak_disappear");
	self.var_15F delete();
	self notify("detonateExplosive");
}

//Function Number: 19
func_DA66(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	if(lib_0D12::func_9DDF(param_00))
	{
		return 0;
	}

	return var_05;
}

//Function Number: 20
func_4116(param_00)
{
	param_00 waittill("death");
	self setscriptablepartstate("vortexStart","neutral",0);
	self setscriptablepartstate("vortexUpdate","neutral",0);
	self setscriptablepartstate("vortexEnd","active",0);
	wait(2);
	self delete();
}

//Function Number: 21
func_10833(param_00,param_01,param_02,param_03)
{
	var_04 = physics_volumecreate(param_01,200);
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

//Function Number: 22
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

//Function Number: 23
func_10831(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = function_02AF(param_03,param_04,param_01);
	var_05.angles = param_02;
	var_05 linkto(param_00);
	var_05 thread func_4108(param_00);
}

//Function Number: 24
func_49DF(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("tag_origin");
	var_01 setscriptmoverkillcam("explosive");
	var_01 linkto(param_00);
	var_01 thread func_4108(param_00);
	return var_01;
}

//Function Number: 25
func_CB0C()
{
	var_00 = spawnstruct();
	func_CB0D(var_00);
	physicsexplosionsphere(var_00.var_D699,100,0,200);
}

//Function Number: 26
func_CB0D(param_00)
{
	self endon("death");
	for(;;)
	{
		param_00.var_D699 = self.origin;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 27
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

//Function Number: 28
func_CC21(param_00)
{
	self notify("powers_blackholeGrenade_used",0);
	scripts\cp\_weapon::func_CC16(param_00.var_13C2E,1,param_00.origin);
	param_00 delete();
}

//Function Number: 29
isgrabbedent(param_00)
{
	return isdefined(param_00.grabbedents[self getentitynumber()]);
}

//Function Number: 30
func_9FAF(param_00)
{
	return isdefined(param_00.var_11AD2[self getentitynumber()]);
}

//Function Number: 31
grabent(param_00)
{
	param_00 endon("death");
	var_01 = self getentitynumber();
	param_00.grabbedents[var_01] = self;
	grabentstall();
	param_00.grabbedents[var_01] = undefined;
}

//Function Number: 32
func_11AD5(param_00)
{
	param_00 endon("death");
	var_01 = self getentitynumber();
	param_00.var_11AD2[var_01] = self;
	func_11AD6();
	param_00.var_11AD2[var_01] = undefined;
}

//Function Number: 33
grabentstall()
{
	self endon("death");
	self endon("disconnect");
	wait(0.75);
}

//Function Number: 34
func_11AD6()
{
	self endon("death");
	self endon("disconnect");
	wait(0.75);
}

//Function Number: 35
func_B777(param_00)
{
	self notify("powers_blackholeGrenade_used",0);
	scripts\cp\_weapon::func_CC16(param_00.var_13C2E,1,param_00.origin);
}

//Function Number: 36
func_7E08(param_00)
{
	return param_00.origin + anglestoup(param_00.angles) * 55;
}