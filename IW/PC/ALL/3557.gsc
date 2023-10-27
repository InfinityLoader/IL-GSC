/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3557.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:41 AM
*******************************************************************/

//Function Number: 1
func_5223()
{
	level._effect["deployableCover_explode"] = loadfx("vfx/iw7/core/equipment/coverwall/vfx_coverwall_foam_expand_mp.vfx");
	level._effect["deployableCover_explode_mist"] = loadfx("vfx/iw7/core/equipment/coverwall/vfx_coverwall_mist_hang_mp.vfx");
}

//Function Number: 2
func_5224(param_00)
{
	param_00 endon("death");
	param_00 waittill("missile_stuck",var_01);
	self notify("powers_deployableCover_used",1);
	param_00.angles = param_00.angles * (0,1,1);
	func_10842(param_00);
	param_00 delete();
}

//Function Number: 3
func_10842(param_00)
{
	var_01 = self.var_4759;
	if(isdefined(var_01))
	{
		var_01 func_5285();
	}

	scripts\mp\_utility::func_D915("deployable cover spawned",param_00.var_222);
	var_02 = anglestoforward(param_00.angles);
	var_02 = rotatepointaroundvector(anglestoup(param_00.angles),var_02,90);
	var_03 = anglestoup(param_00.angles);
	var_04 = vectorcross(var_02,var_03);
	var_03 = vectorcross(var_04,var_02);
	var_05 = axistoangles(var_02,var_04,var_03);
	var_01 = spawncoverwall(param_00.origin + anglestoup(var_05) * 2,var_05);
	var_01.var_222 = self;
	var_01.team = self.team;
	var_01 method_8318(1);
	var_01 method_8317(1);
	var_01 setcandamage(1);
	var_01.health = 9999;
	playfx(scripts\common\utility::getfx("deployableCover_explode"),param_00.origin,anglestoforward(var_05),anglestoup(var_05));
	playfx(scripts\common\utility::getfx("deployableCover_explode_mist"),param_00.origin,anglestoforward(var_05),anglestoup(var_05));
	playsoundatpos(param_00.origin,"deployable_cover_expand");
	var_01 thread func_40EB();
	var_01 thread func_40ED();
	var_01 thread func_40EC();
	var_01 thread func_40EE();
	var_01 thread func_139DE();
	var_01 thread func_139DF(self);
	var_01 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	var_01 thread createcovernavobstacle();
	self.var_4759 = var_01;
}

//Function Number: 4
createcovernavobstacle()
{
	self endon("death");
	self endon("entitydeleted");
	self endon("despawnCover");
	self waittill("coverwall_expand_finish");
	self.var_BE64 = function_0314(self);
}

//Function Number: 5
func_5285(param_00)
{
	self notify("despawnCover");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!param_00)
	{
		playsoundatpos(self.origin,"deployable_cover_contract");
	}

	if(isdefined(self.var_BE64))
	{
		destroynavobstacle(self.var_BE64);
		self.var_BE64 = undefined;
	}

	self method_8514(param_00);
	scripts\mp\_utility::func_D915("deployable cover removed",self.var_222);
}

//Function Number: 6
func_139DF(param_00)
{
	self endon("death");
	param_00 endon("disconnect");
	self waittill("coverwall_expand_finish");
	wait(0.25);
	thread scripts\mp\_weapons::func_C798(self,param_00);
	self waittill("coverwall_contract_start");
	self notify("death");
}

//Function Number: 7
func_139DE()
{
	self endon("death");
	self endon("despawnCover");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03);
		self.health = 9999;
		var_01 scripts\mp\_damagefeedback::func_12E84("hitequip");
	}
}

//Function Number: 8
func_40EE()
{
	self endon("death");
	self endon("despawnCover");
	wait(15);
	thread func_5285();
}

//Function Number: 9
func_40EB()
{
	self endon("death");
	self endon("despawnCover");
	self.var_222 waittill("death");
	thread func_5285();
}

//Function Number: 10
func_40ED()
{
	self endon("death");
	self endon("despawnCover");
	level scripts\common\utility::waittill_any_3("game_ended","bro_shot_start");
	thread func_5285();
}

//Function Number: 11
func_40EC()
{
	self endon("death");
	self endon("despawnCover");
	self.var_222 waittill("disconnect");
	thread func_5285(1);
}

//Function Number: 12
func_CC21(param_00)
{
	self notify("powers_deployableCover_used",0);
	scripts\mp\_utility::func_CC16(param_00.var_13C2E,1,param_00.origin);
	param_00 delete();
}