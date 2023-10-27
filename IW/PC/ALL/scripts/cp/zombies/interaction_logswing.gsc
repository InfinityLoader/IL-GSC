/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_logswing.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 283 ms
 * Timestamp: 10/27/2023 12:09:02 AM
*******************************************************************/

//Function Number: 1
init_logswing_trap()
{
	wait(1);
	var_00 = getent("logswing_trap","targetname");
	var_01 = getent("logswing_trig","targetname");
	if(!isdefined(var_00) || !isdefined(var_01))
	{
		return;
	}

	var_01 enablelinkto();
	var_01 linkto(var_00,"tag_trigger");
	var_02 = getentarray("swing_trap_pole","targetname");
	foreach(var_04 in var_02)
	{
		var_04 setscriptablepartstate("light","on");
	}
}

//Function Number: 2
use_logswing_trap(param_00,param_01)
{
	param_01 playlocalsound("purchase_generic");
	scripts\cp\_interaction::func_554F(param_00);
	var_02 = getent("logswing_trig","targetname");
	var_03 = getentarray("swing_trap_pole","targetname");
	foreach(var_05 in var_03)
	{
		var_05 setscriptablepartstate("light","off");
	}

	var_07 = getent("logswing_trap","targetname");
	var_07 thread log_swing_trap_sfx();
	var_08 = getanimlength(%iw7_cp_log_swing);
	var_07 scriptmodelplayanimdeltamotion("IW7_cp_log_swing",1);
	param_00.var_126A4 = 0;
	var_07 thread func_A631(var_02,param_01,param_00);
	wait(var_08);
	var_07 scriptmodelplayanimdeltamotion("IW7_cp_log_swing",1);
	wait(var_08);
	var_02 notify("stop_trap");
	level notify("logswing_trap_kills",param_00.var_126A4);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,45);
	foreach(var_05 in var_03)
	{
		var_05 setscriptablepartstate("light","on");
	}
}

//Function Number: 3
log_swing_trap_sfx()
{
	var_00 = spawn("script_model",self.origin);
	wait(0.05);
	var_00 linkto(self,"tag_trigger");
	wait(0.05);
	var_00 playsoundonmovingent("rave_log_swing_trap_sfx");
	wait(9);
	var_00 delete();
}

//Function Number: 4
func_A631(param_00,param_01,param_02)
{
	param_00 endon("stop_trap");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(isplayer(var_03) && !scripts\cp\_laststand::player_in_laststand(var_03))
		{
			var_03 dodamage(var_03.health + 100,var_03.origin);
			continue;
		}

		if(isdefined(var_03.flung))
		{
			continue;
		}

		if(isdefined(var_03.agent_type) && var_03.agent_type == "slasher")
		{
			continue;
		}

		var_03.flung = 1;
		param_02.var_126A4++;
		level thread func_6F32(var_03,self,param_01);
	}
}

//Function Number: 5
func_6F32(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.do_immediate_ragdoll = 1;
	param_00.var_4C87 = 1;
	param_00.disable_armor = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	var_03 = ["kill_trap_generic","kill_trap_1","kill_trap_2","kill_trap_3","kill_trap_4","kill_trap_5","kill_trap_6","trap_kill_7"];
	param_02 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_03),"zmb_comment_vo","highest",10,0,0,1,25);
	if(param_02 scripts\cp\_utility::is_valid_player())
	{
		param_00 dodamage(param_00.health + 1000,param_00.origin,param_02,param_02,"MOD_UNKNOWN","iw7_discotrap_zm");
		return;
	}

	param_00 dodamage(param_00.health + 1000,param_00.origin,undefined,undefined,"MOD_UNKNOWN","iw7_discotrap_zm");
}