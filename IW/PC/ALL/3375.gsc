/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3375.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:48 AM
*******************************************************************/

//Function Number: 1
func_9547()
{
	level.beamtrapuses = 0;
	var_00 = scripts\common\utility::getstructarray("beamtrap","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_2A39();
	}
}

//Function Number: 2
func_2A39()
{
	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	}

	self.var_D776 = 1;
	level thread scripts\cp\_vo::func_1769("dj_traps_use_nag","zmb_dj_vo",60,15,2,1);
}

//Function Number: 3
func_12FAA(param_00,param_01)
{
	playfx(level._effect["console_spark"],param_00.origin + (0,0,40));
	level.var_8C5C = 0;
	level.beamtrapuses++;
	var_02 = 25;
	var_03 = sortbydistance(scripts\common\utility::getstructarray("hc_start_struct","targetname"),param_01.origin);
	param_00.var_126A4 = 0;
	param_00.var_126A5 = param_01;
	level.var_8C55 = var_03[0];
	scripts\cp\_interaction::func_554F(param_00);
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	var_04 = getent(param_00.target,"targetname");
	var_05 = scripts\common\utility::getstruct(param_00.target,"targetname");
	playsoundatpos((-946,-3528,456),"trap_beam_build");
	wait(2);
	var_04 playsound("trap_beam_start");
	var_06 = spawnfx(level._effect["beam_trap_beam"],var_05.origin,anglestoforward(var_05.angles),anglestoup(var_05.angles));
	scripts\common\utility::func_136F7();
	earthquake(0.2,25,var_04.origin,850);
	scripts\common\utility::exploder(89);
	scripts\common\utility::func_136F7();
	triggerfx(var_06);
	level thread func_2A37(var_04,param_01,param_00);
	wait(0.4);
	var_04 playloopsound("trap_beam_lp");
	var_07 = thread scripts\common\utility::play_loopsound_in_space("trap_beam_impact_lp",(-950,-3075,428));
	wait(var_02);
	var_04 stoploopsound("trap_beam_lp");
	var_07 stoploopsound();
	var_07 delete();
	playsoundatpos((-946,-3528,456),"trap_beam_stop");
	var_06 delete();
	level notify("beam_trap_done");
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		param_01.var_1189F = param_00.var_126A4;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	wait(3);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.beamtrapuses * 45,45));
}

//Function Number: 4
func_2A37(param_00,param_01,param_02)
{
	level endon("beam_trap_done");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isdefined(var_03.var_C85F))
		{
			continue;
		}

		if(isplayer(var_03) && isalive(var_03) && !scripts\cp\_laststand::player_in_laststand(var_03))
		{
			var_03.var_C85F = 1;
			var_03 thread func_E069();
			var_04 = var_03 getstance();
			if(var_04 == "prone" || var_04 == "crouch" || var_03 method_81BE())
			{
				continue;
			}

			var_03 dodamage(50,(-959,-3560,420),var_03,var_03,"MOD_UNKNOWN","iw7_beamtrap_zm");
			continue;
		}

		if(scripts\cp\_utility::func_FF18(var_03,undefined,1) && !scripts\common\utility::istrue(var_03.var_565C))
		{
			param_02.var_126A4 = param_02.var_126A4 + 2;
			var_03.var_B36E = 1;
			var_03.var_126A3 = param_01;
			var_03 thread func_3286(param_01);
		}
	}
}

//Function Number: 5
func_E069()
{
	self endon("disconnect");
	wait(1);
	self.var_C85F = undefined;
}

//Function Number: 6
func_3286(param_00)
{
	self endon("death");
	if(!scripts\common\utility::istrue(self.var_9CDD))
	{
		self.var_9B81 = 1;
		thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
		wait(1);
		self.disable_armor = 1;
	}

	if(scripts\common\utility::flag("mini_ufo_yellow_ready"))
	{
		level.var_8C5C++;
	}

	if(isdefined(param_00))
	{
		if(!isdefined(param_00.trapkills["trap_dragon"]))
		{
			param_00.trapkills["trap_dragon"] = 1;
		}
		else
		{
			param_00.trapkills["trap_dragon"]++;
		}

		var_01 = ["kill_trap_generic","kill_trap_dragon"];
		param_00 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_01),"zmb_comment_vo","highest",10,0,0,1,25);
		self dodamage(self.health + -15536,self.origin,param_00,param_00,"MOD_UNKNOWN","iw7_beamtrap_zm");
		return;
	}

	self dodamage(self.health + -15536,self.origin,undefined,undefined,"MOD_UNKNOWN","iw7_beamtrap_zm");
}