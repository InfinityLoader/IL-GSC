/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3579.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_D690 = loadfx("vfx/iw7/_requests/mp/vfx_impulse_grenade_start");
	level.var_D68D = loadfx("vfx/iw7/_requests/mp/vfx_impulse_gren_exp");
}

//Function Number: 2
func_D691(param_00)
{
	param_00 endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 waittill("missile_stuck");
	playfx(level.var_D690,param_00.origin + (0,0,2));
	wait(1.25);
	playfx(level.var_D68D,param_00.origin + (0,0,2));
	radiusdamage(param_00.origin,180,1,1,self,"MOD_EXPLOSIVE",param_00.var_13C2E);
	param_00 delete();
}

//Function Number: 3
func_D68E(param_00,param_01)
{
	self endon("disconnect");
	if(scripts\mp\_utility::func_9EF0(self) || !isplayer(self))
	{
		return;
	}

	var_02 = self.origin + (0,0,2000);
	var_03 = self.angles * (0,1,1);
	var_03 = var_03 + (85,0,0);
	var_04 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_05 = scripts\common\trace::func_D305(self.origin,var_02,self.angles,self,var_04);
	var_06 = self.origin;
	self.var_115FC = 1;
	if(var_05["fraction"] < 1)
	{
		var_02 = var_05["position"] - (0,0,65);
		func_11663(var_02);
		wait(0.05);
		self.var_115FC = 0;
		radiusdamage(var_02 + (0,0,32),128,400,400,param_01,"MOD_EXPLOSIVE","portal_grenade_mp");
		func_468B(self,self.origin + (0,0,32));
		return;
	}

	thread func_4E75();
	self shellshock("flashbang_mp",0.8,1,1);
	func_11663(var_02);
	var_07 = (0,0,1500);
	self setplayerangles(var_03);
	self setvelocity(var_07);
	scripts\common\utility::func_1C42(0);
	scripts\mp\_utility::func_1253(1);
	self setmovespeedscale(0);
	thread func_13EF3();
	thread func_13B31();
	thread func_13AF8(param_01);
	self.var_115FE = var_06;
	self.var_115FD = param_01;
}

//Function Number: 4
func_13AF8(param_00)
{
	self endon("portalGrenadeSave");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self waittill("collided",var_01,var_02,var_03,var_04,var_05);
	if(var_05 == "hittype_entity")
	{
		radiusdamage(self.origin + (0,0,32),128,400,400,param_00,"MOD_EXPLOSIVE","portal_grenade_mp");
		func_468B(self,self.origin + (0,0,32));
	}
}

//Function Number: 5
func_4E75()
{
	self endon("portalGrenadeSave");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	scripts\mp\_utility::func_1253(0);
	scripts\common\utility::func_1C42(1);
	self.var_115FC = 0;
	self.var_115FD = undefined;
	self.var_115FE = undefined;
}

//Function Number: 6
func_13B31()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("phase_shift_power_activated","rewind_power_finished","powers_teleport_used","orbital_deployment_complete","phase_slash_entered","transponder_teleportPlayer");
	while(!self isonground())
	{
		wait(0.05);
	}

	self notify("portalGrenadeSave");
	scripts\mp\_weapons::func_12ED5();
	scripts\mp\_utility::func_1253(0);
	scripts\common\utility::func_1C42(1);
	self.var_115FC = 0;
	self.var_115FD = undefined;
	self.var_115FE = undefined;
}

//Function Number: 7
func_13EF3()
{
	level endon("game_ended");
	self endon("death");
	self endon("portalGrenadeSave");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getvelocity();
		var_00 = var_00 * (0,0,1);
		self setvelocity(var_00);
		wait(0.05);
	}
}

//Function Number: 8
func_468B(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("diconnect");
	wait(0.05);
	var_02 = param_00 method_8113();
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = var_02.origin;
	earthquake(0.5,1.5,var_03,120);
	thread scripts\mp\_utility::func_13AF(var_03,64,400,400,self,"MOD_EXPLOSIVE","portal_grenade_mp",0);
	param_00 thread scripts\mp\_utility::func_13AF(var_03,64,400,400,param_00,"MOD_EXPLOSIVE","portal_grenade_mp",0);
	wait(0.1);
	playfx(level._effect["corpse_pop"],var_03 + (0,0,12));
	if(isdefined(var_02))
	{
		var_02 hide();
		var_02.var_CA6C = 1;
	}
}

//Function Number: 9
func_11663(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(param_00))
	{
		return 0;
	}

	self playlocalsound("ftl_teleport");
	self playsound("ftl_teleport_npc_out");
	if(self ismantling())
	{
		self cancelmantle();
	}

	var_01 = length2dsquared(self method_8123());
	var_02 = (0,0,0);
	var_03 = param_00 - self.origin;
	if(var_01 > 0)
	{
		var_02 = var_03 * sqrt(var_01) / length(var_03);
	}

	thread func_E852(self.origin,var_03);
	scripts\common\utility::func_136F7();
	if(!isdefined(self))
	{
		return 0;
	}

	var_04 = self.origin;
	var_05 = scripts\common\utility::spawn_tag_origin(self.origin,self.angles);
	self playerlinkto(var_05);
	self setclientdvar("cg_fovScale",1.7);
	var_05 moveto(param_00,0.15,0,0);
	self playanimscriptevent("power_active","teleport");
	scripts\mp\_utility::func_17C0("teleport",0,0);
	self motionblurhqenable();
	self setblurforplayer(3,0);
	wait(0.15);
	self setblurforplayer(0,0.25);
	self method_8208();
	scripts\mp\_utility::func_E0E6("teleport",0);
	self unlink();
	self setorigin(param_00,1);
	self setclientdvar("cg_fovScale",1);
	scripts\common\utility::func_136F7();
	self playanimscriptevent("power_exit","teleport");
	if(!isdefined(self))
	{
		return 0;
	}

	self playsound("ftl_teleport_npc_in");
	self setvelocity(var_02);
	return 1;
}

//Function Number: 10
func_E852(param_00,param_01)
{
	param_00 = param_00 + (0,0,50);
	var_02 = param_00 + param_01;
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("tag_origin");
	wait(0.1);
	playfxontag(scripts\common\utility::getfx("vfx_tele_trail"),var_03,"tag_origin");
	var_03 moveto(var_02,0.1,0.05,0);
	wait(0.2);
	stopfxontag(scripts\common\utility::getfx("vfx_tele_trail"),var_03,"tag_origin");
	var_03 delete();
}