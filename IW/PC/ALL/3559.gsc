/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3559.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:30:42 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_6BBA = spawnstruct();
	level.var_6BBA.var_451D = [];
	level._effect["vfx_haywire_scrn"] = loadfx("vfx/iw7/_requests/mp/vfx_haywire_scrn.vfx");
	level._effect["haywire_smoke_friendly"] = loadfx("vfx/old/_requests/mp_weapons/vfx_haywire_gas_friendly");
	level._effect["haywire_smoke_enemy"] = loadfx("vfx/old/_requests/mp_weapons/vfx_haywire_gas_enemy");
	level._effect["vfx_fear_grenade_explode_frag"] = loadfx("vfx/core/expl/grenadeexp_default");
	level._effect["vfx_fear_grenade_explode_plasma"] = loadfx("vfx/iw7/_requests/mp/vfx_plasma_large_explosion_enemy");
	level._effect["vfx_fear_grenade_explode_blackhole"] = loadfx("vfx/iw7/_requests/mp/vfx_blackhole_grenade_enemy");
	level._effect["fear_mine_vanish"] = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	func_49CF("projectile_m67fraggrenade","vfx_fear_grenade_explode_frag","grenade_explode_scr",undefined,2);
	func_49CF("projectile_m67fraggrenade","vfx_fear_grenade_explode_plasma","grenade_explode_scr",undefined,2);
	func_49CF("projectile_m67fraggrenade","vfx_fear_grenade_explode_blackhole","blackhole_grenade_explode_default",75,0.5);
	level.var_6BBA.var_8283 = ["mp_fullbody_synaptic_1"];
	level.var_6BBA.var_3251 = ["drone_ak12_fire_npc"];
	scripts\mp\_powerloot::func_DF06("power_fearGrenade",["passive_increased_duration","passive_increased_damage","passive_increased_radius"]);
}

//Function Number: 2
func_49CF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.model = param_00;
	var_05.var_1336D = scripts\common\utility::getfx(param_01);
	var_05.var_FC43 = param_02;
	var_05.var_763E = param_03;
	var_05.var_AC75 = param_04;
	level.var_6BBA.var_451D[level.var_6BBA.var_451D.size] = var_05;
}

//Function Number: 3
func_80BA()
{
	return level.var_6BBA.var_451D[randomint(level.var_6BBA.var_451D.size)];
}

//Function Number: 4
func_6BBC()
{
	self notify("detonateExplosive");
}

//Function Number: 5
func_6BBB()
{
	var_00 = self.var_222;
	var_01 = self.origin;
	playfx(scripts\common\utility::getfx("fear_mine_vanish"),var_01);
	if(isdefined(self.var_76CF))
	{
		self.var_76CF moveto(var_01 + (0,0,72),0.5);
	}

	var_02 = var_00 scripts\mp\_powerloot::func_7FC4("power_fearGrenade",160);
	var_03 = spawn("trigger_radius",var_01,0,var_02,160);
	var_03.var_222 = var_00;
	var_04 = scripts\mp\_utility::func_108CB(var_00,var_01,"haywire_smoke_friendly","haywire_smoke_enemy",0);
	var_00 thread func_13A3E(var_03,self.var_76CF);
	wait(5);
	foreach(var_06 in var_04)
	{
		var_06 delete();
	}

	wait(2);
	var_03 delete();
}

//Function Number: 6
func_13A3E(param_00,param_01)
{
	param_00.var_222 endon("disconnect");
	self endon("disconnect");
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!lib_0DF8::func_213D(param_00,var_02))
		{
			continue;
		}

		var_03 = func_370F(param_00.var_222,var_02);
		if(var_03.var_13378 > 0)
		{
			var_02 thread func_127C3(var_03.var_13378,param_00.var_222,param_01);
		}

		if(var_03.var_24E6 > 0)
		{
			param_00.var_222 thread func_127C3(var_03.var_24E6,param_00.var_222,param_01);
		}
	}
}

//Function Number: 7
func_370F(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_24E6 = 0;
	var_02.var_13378 = 0;
	var_03 = scripts\mp\_powerloot::func_7FC1("power_fearGrenade",2.5);
	if(level.teambased && param_00.team == param_01.team && param_00 != param_01)
	{
		if(level.var_740A == 0)
		{
		}
		else if(level.var_740A == 1)
		{
			var_02.var_13378 = var_03;
		}
		else if(level.var_740A == 2)
		{
			var_02.var_24E6 = var_03;
		}
		else if(level.var_740A == 3)
		{
			var_02.var_13378 = var_03 * 0.5;
			var_02.var_24E6 = var_03 * 0.5;
		}
	}
	else
	{
		var_02.var_13378 = var_03;
	}

	return var_02;
}

//Function Number: 8
func_127C3(param_00,param_01,param_02)
{
	if(func_9EEA(self))
	{
		func_F703(param_00);
		return;
	}

	thread func_2A67(param_00,param_01,param_02);
}

//Function Number: 9
func_2A67(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self.var_6BB9 = spawnstruct();
	func_F703(param_00);
	thread func_E84C();
	var_03 = scripts\mp\_powerloot::func_7FC0("power_fearGrenade",8);
	self dodamage(var_03,self.origin,param_01,param_02,"MOD_EXPLOSIVE","fear_grenade_mp");
	for(;;)
	{
		var_04 = self.var_6BB9.var_6393 - gettime() / 1000;
		var_05 = scripts\common\utility::waittill_any_timeout_1(var_04,"fear_update_duration");
		if(var_05 == "timeout")
		{
			func_6319();
			break;
		}
		else
		{
			continue;
		}
	}
}

//Function Number: 10
func_E84C()
{
	self endon("stop_fear_effects");
	self endon("death");
	self endon("disconnect");
	var_00 = function_01E1(scripts\common\utility::getfx("vfx_haywire_scrn"),(0,0,0),self);
	triggerfx(var_00);
	thread func_4115(var_00);
	thread func_13A35();
	childthread func_E85A();
	wait(0.5);
	childthread func_E853();
	childthread func_E854();
}

//Function Number: 11
func_6319()
{
	self notify("stop_fear_effects");
	scripts\common\utility::func_136F7();
	func_40F9();
	self.var_6BB9 = undefined;
	self notify("finished_stop_fear_effects");
}

//Function Number: 12
func_4115(param_00)
{
	scripts\common\utility::waittill_any_3("death","disconnect","stop_fear_effects");
	param_00 delete();
}

//Function Number: 13
func_13A35()
{
	self endon("finished_stop_fear_effects");
	self waittill("death");
	func_6319();
}

//Function Number: 14
func_F703(param_00)
{
	var_01 = gettime() + int(param_00 * 1000);
	if(isdefined(self.var_6BB9.var_6393))
	{
		if(self.var_6BB9.var_6393 > var_01)
		{
			return;
		}
	}

	self.var_6BB9.var_6393 = var_01;
	self notify("fear_update_duration");
}

//Function Number: 15
func_9EEA(param_00)
{
	return isdefined(param_00.var_6BB9);
}

//Function Number: 16
func_E853()
{
	for(;;)
	{
		var_00 = self geteye();
		var_01 = self getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = anglestoright(var_01);
		var_04 = var_00 + (0,0,60) + var_03 * randomfloatrange(-300,300);
		var_05 = self.origin + var_02 * 500 + (randomfloatrange(-150,150),randomfloatrange(-150,150),0);
		var_06 = vectornormalize(var_05 - var_04) * randomfloatrange(500,900);
		var_06 = (var_06[0],var_06[1],0) + self getvelocity();
		thread func_108CE(self,var_04,var_06);
		wait(randomfloatrange(0.1,0.5));
	}
}

//Function Number: 17
func_E8D9()
{
	for(;;)
	{
		var_00 = func_80C1();
		var_01 = randomfloat(50);
		wait(randomfloatrange(0.05,0.15));
	}
}

//Function Number: 18
func_E842()
{
	for(;;)
	{
		var_00 = func_80C1();
		var_01 = self.health;
		self dodamage(1,var_00,undefined,undefined,"MOD_FALLING");
		self.health = var_01;
		wait(randomfloatrange(0.35,1.5));
	}
}

//Function Number: 19
func_E85A()
{
	self setclientomnvar("ui_hud_shake",1);
}

//Function Number: 20
func_E854()
{
	var_00 = spawn("script_model",self.origin);
	var_00 hide();
	self.var_6BB9.var_8282 = var_00;
	var_01 = 0;
	for(;;)
	{
		var_02 = undefined;
		if(!var_01 && randomint(10) == 0)
		{
			var_03 = anglestoforward(self.angles);
			var_02 = self.origin + var_03 * 25 + (0,0,-5);
			var_04 = (self.angles[0],180 + self.angles[1],self.angles[2]);
			var_00.origin = var_02;
			var_00.angles = var_04;
			var_00 setmodel("mp_fullbody_synaptic_1");
			var_01 = 1;
		}
		else
		{
			var_02 = func_80C1(200,300);
			var_02 = getclosestpointonnavmesh(var_02);
			var_04 = (self.angles[0],180 + self.angles[1],self.angles[2]);
			var_00.origin = var_02;
			var_00.angles = var_04;
			var_05 = level.var_6BBA.var_8283[randomint(level.var_6BBA.var_8283.size)];
			var_00 setmodel(var_05);
		}

		scripts\common\utility::func_136F7();
		var_00 showtoplayer(self);
		wait(randomfloatrange(0.3,0.65));
		var_00 hide();
		var_00 unlink();
		wait(randomfloatrange(0.3,0.65));
	}
}

//Function Number: 21
func_E83D()
{
	var_00 = spawn("script_model",self.origin);
	var_00 thread func_4119();
	for(;;)
	{
		var_01 = level.var_6BBA.var_3251[randomint(level.var_6BBA.var_3251.size)];
		var_00.origin = func_80C1();
		var_00 playsoundtoplayer(var_01,self);
		wait(randomfloatrange(0.15,0.3));
	}
}

//Function Number: 22
func_4119(param_00)
{
	scripts\common\utility::waittill_any_3("stop_fear_effects","death","disconnect");
	param_00 delete();
}

//Function Number: 23
func_40F9()
{
	if(isdefined(self.var_6BB9.var_8282))
	{
		self.var_6BB9.var_8282 delete();
	}
}

//Function Number: 24
func_108CE(param_00,param_01,param_02)
{
	var_03 = randomfloatrange(0.4,1.25);
	var_04 = param_00 scripts\mp\_utility::func_1302("fear_ghost_grenade_mp",param_01,param_02,var_03);
	var_04 hide();
	var_04 showtoplayer(param_00);
	var_04 thread func_13A3D();
	var_05 = spawn("script_model",param_01);
	var_05.var_222 = param_00;
	var_05.var_DA5A = var_04;
	var_05.var_451C = func_80BA();
	var_05 hide();
	var_05 showtoplayer(param_00);
	var_05 setmodel(var_05.var_451C.model);
	var_05 linkto(var_04,"tag_origin");
	var_04.var_6B4A = var_05;
	var_05 thread func_13A41();
}

//Function Number: 25
func_13A3D()
{
	var_00 = scripts\common\utility::func_13734("explode","death");
	self.var_6B4A notify("detonate_ghost_grenade");
}

//Function Number: 26
func_13A41()
{
	self endon("death");
	var_00 = scripts\common\utility::waittill_any_timeout_1(4,"detonate_ghost_grenade");
	thread func_108CF();
	self delete();
}

//Function Number: 27
func_108CF()
{
	var_00 = self.var_451C;
	var_01 = undefined;
	if(isdefined(var_00.var_1336D))
	{
		var_02 = (0,0,0);
		if(isdefined(var_00.var_763E))
		{
			var_03 = anglestoup(self.angles);
			var_02 = var_03 * var_00.var_763E;
		}

		var_01 = function_01E1(var_00.var_1336D,self.origin + var_02,self.var_222);
		triggerfx(var_01);
	}

	if(isdefined(var_00.var_FC43))
	{
		self playsoundtoplayer(var_00.var_FC43,self.var_222);
	}

	wait(var_00.var_AC75);
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 28
func_80C1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00))
	{
		param_00 = -100;
	}

	if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	if(!isdefined(param_02))
	{
		param_02 = -100;
	}

	if(!isdefined(param_03))
	{
		param_03 = 100;
	}

	if(!isdefined(param_04))
	{
		param_04 = -100;
	}

	if(!isdefined(param_05))
	{
		param_05 = 100;
	}

	var_06 = randomfloatrange(param_00,param_01);
	var_07 = randomfloatrange(param_02,param_03);
	var_08 = randomfloatrange(param_04,param_05);
	var_09 = anglestoforward(self.angles);
	var_0A = anglestoright(self.angles);
	var_0B = anglestoup(self.angles);
	return self.origin + var_09 * var_06 + var_0A * var_07 + var_0B * var_08;
}