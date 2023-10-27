/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_perk_mark_targets.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 295 ms
 * Timestamp: 10/27/2023 12:30:04 AM
*******************************************************************/

//Function Number: 1
func_B381()
{
	level._effect["marked_target"] = loadfx("vfx/iw7/_requests/mp/vfx_marked_target_z.vfx");
}

//Function Number: 2
func_B382(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(scripts\common\utility::func_9D74(param_01) && isplayer(param_00) && param_00.team != self.team && !param_00 scripts\mp\_utility::_hasperk("specialty_empimmune") && !isdefined(param_00.var_9E92))
	{
		thread func_B380(param_00);
	}
}

//Function Number: 3
func_B380(param_00)
{
	var_01 = param_00 scripts\common\utility::spawn_tag_origin();
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("tag_origin");
	var_02 linkto(var_01,"tag_origin",(0,0,45),(0,0,0));
	var_01 linkto(param_00,"tag_origin",(0,0,0),(0,0,0));
	param_00.var_9E92 = 1;
	param_00.var_8CC1 = 1;
	wait(0.1);
	func_11417(param_00,var_02);
	wait(0.1);
	if(isdefined(param_00))
	{
		param_00 func_E13C(var_01);
	}
}

//Function Number: 4
func_11417(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	scripts\mp\_missions::func_D991("ch_trait_marked_target");
	var_02 = gettime() + 3000;
	while(isalive(param_00) && gettime() < var_02)
	{
		if(level.gametype != "dm")
		{
			var_03 = function_029A(scripts\common\utility::getfx("marked_target"),param_01,"tag_origin",self.team);
			continue;
		}

		var_03 = playfxontagforclients(scripts\common\utility::getfx("marked_target"),param_01,"tag_origin",self);
		wait(1.1);
	}
}

//Function Number: 5
func_E13C(param_00)
{
	param_00 delete();
	self.var_9E92 = undefined;
	self.var_8CC1 = undefined;
}

//Function Number: 6
func_13AA0(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
	}
}