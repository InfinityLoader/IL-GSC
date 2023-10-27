/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_waterfall.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 285 ms
 * Timestamp: 10/27/2023 12:09:04 AM
*******************************************************************/

//Function Number: 1
init_waterfall_trap()
{
	var_00 = scripts\common\utility::getstruct("trap_waterfall","script_noteworthy");
	var_01 = getentarray(var_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_model")
		{
			var_00.valve = var_03;
		}

		if(var_03.classname == "physicsvolume")
		{
			var_00.physvolume = var_03;
		}

		if(var_03.classname == "trigger_multiple")
		{
			var_00.trigger = var_03;
		}
	}
}

//Function Number: 2
use_waterfall_trap(param_00,param_01)
{
	scripts\cp\_interaction::func_554F(param_00);
	param_00.var_126A4 = 0;
	param_00.valve rotateroll(-180,1);
	param_00.valve playsound("trap_waterfall_valve");
	thread waterfall_trap_sfx();
	var_02 = gettime() + 2000;
	playrumbleonposition("light_3s",param_00.valve.origin + (0,0,50));
	while(gettime() < var_02)
	{
		earthquake(0.2,2,param_00.origin + (0,0,100),500);
		wait(1);
	}

	scripts\common\utility::exploder(20);
	param_00.physvolume method_852B(1,anglestoforward(param_00.angles + (0,0,5)),2500);
	param_00.physvolume method_8529(1);
	param_00.physvolume method_8526(1);
	level thread func_A631(param_00,param_01);
	var_02 = gettime() + 25000;
	while(gettime() < var_02)
	{
		playrumbleonposition("heavy_3s",param_00.valve.origin + (0,0,50));
		earthquake(0.2,3,param_00.origin + (0,0,100),500);
		wait(1);
	}

	level notify("stop_waterfall_trap");
	level notify("waterfall_trap_kills",param_00.var_126A4);
	param_00.physvolume method_8526(0);
	param_00.physvolume method_8529(0);
	scripts\cp\_interaction::func_6214(param_00);
	param_00.var_4622 = 1;
	wait(30);
	param_00.var_4622 = undefined;
}

//Function Number: 3
waterfall_trap_sfx()
{
	wait(0.65);
	playsoundatpos((-1714,-2031,248),"trap_waterfall_start");
	var_00 = scripts\common\utility::play_loopsound_in_space("trap_waterfall_rushing_lp",(-1717,-2013,189));
	wait(4);
	var_01 = scripts\common\utility::play_loopsound_in_space("trap_waterfall_splashing_lp",(-1702,-1824,101));
	level waittill("stop_waterfall_trap");
	playsoundatpos((-1714,-2031,248),"trap_waterfall_end");
	wait(0.2);
	var_00 stoploopsound();
	var_00 delete();
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 4
func_A631(param_00,param_01)
{
	level endon("stop_waterfall_trap");
	for(;;)
	{
		param_00.trigger waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			var_03 = var_02 getvelocity();
			var_02 setvelocity(var_03 + (0,35,0));
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_02,undefined,1))
		{
			continue;
		}

		param_00.var_126A4++;
		var_02 thread func_6F32(param_00,param_01);
	}
}

//Function Number: 5
func_6F32(param_00,param_01)
{
	self endon("death");
	self.flung = 1;
	self.var_B36E = 1;
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	wait(randomfloatrange(0.5,1.5));
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = undefined;
	}

	self dodamage(self.health + 100,param_00.trigger.origin,var_02,var_02,"MOD_UNKNOWN","iw7_discotrap_zm");
}