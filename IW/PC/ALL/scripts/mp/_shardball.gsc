/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_shardball.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 549 ms
 * Timestamp: 10/27/2023 12:21:29 AM
*******************************************************************/

//Function Number: 1
func_FC58()
{
	level._effect["shard_ball_rocket_trail"] = loadfx("vfx/iw7/_requests/mp/vfx_shard_ball_launch_trail.vfx");
	level._effect["shard_ball_explosion_shards"] = loadfx("vfx/iw7/_requests/mp/vfx_shard_ball_proj_exp.vfx");
	level._effect["shard_ball_explosion_rocket"] = loadfx("vfx/iw7/_requests/mp/vfx_shard_ball_launch_exp.vfx");
	scripts\mp\_powerloot::func_DF06("power_shardBall",["passive_increased_radius","passive_increased_entities","passive_grenade_to_mine"]);
}

//Function Number: 2
func_FC5A()
{
	scripts\mp\_weapons::func_B2A3();
	self.var_222 func_FC5B(self,1);
	self notify("detonateExplosive",self.var_222);
}

//Function Number: 3
func_FC59()
{
}

//Function Number: 4
func_FC5B(param_00,param_01)
{
	self notify("powers_shardBall_used",1);
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	param_00 endon("death");
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!param_01)
	{
		param_00 waittill("missile_stuck",var_02);
		if(isplayer(var_02) || isagent(var_02))
		{
			scripts\mp\_weapons::func_85DD(param_00,var_02);
		}
	}

	param_00 thread scripts\mp\_shellshock::func_858A();
	param_00 scripts\mp\_weapons::func_69FF(undefined);
	param_00 thread func_13B39();
}

//Function Number: 5
func_13B39()
{
	var_00 = self.var_11180;
	var_01 = self.var_222;
	var_02 = self.var_222.team;
	var_03 = self.var_13C2E;
	var_04 = func_7EA7();
	self waittill("explode",var_05);
	if(!isdefined(var_01))
	{
		return;
	}

	playsoundatpos(var_05,"frag_grenade_explode");
	thread func_13B34(var_04,var_01);
	self notify("start_secondary_explosion",var_05);
}

//Function Number: 6
func_7EA7()
{
	var_00 = self.angles;
	if(isdefined(self.var_11180))
	{
		var_00 = self.var_11180.angles;
	}

	return var_00;
}

//Function Number: 7
func_7EA8(param_00,param_01,param_02,param_03)
{
	var_04 = 150;
	var_05 = 200;
	var_06 = anglestoup(param_00);
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	var_07 = var_05 * var_06;
	var_08 = param_01 + var_07;
	var_06 = var_04 * var_06;
	var_09 = param_01 + var_06;
	if(!isdefined(param_03) || !param_03)
	{
		var_0A = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_missileclip","physicscontents_clipshot"]);
		var_0B = function_0287(param_01,var_08,var_0A,undefined,0,"physicsquery_closest");
		if(var_0B.size > 0)
		{
			var_0C = var_0B[0]["position"];
			var_09 = param_01 + var_0C / 2;
		}
	}

	return var_09;
}

//Function Number: 8
func_13AEA(param_00)
{
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 9
func_13A0A(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 10
func_13B1F(param_00)
{
	self endon("death");
	while(self.origin != param_00)
	{
		wait(0.05);
	}

	self notify("start_secondary_explosion",param_00);
}

//Function Number: 11
func_13B34(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 endon("disconnect");
	param_01 endon("joined_team");
	param_01 endon("joined_spectators");
	var_06 = "start_secondary_explosion";
	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	self waittill(var_06,var_07);
	playsoundatpos(var_07,"shard_ball_explode_default");
	var_08 = [];
	foreach(var_0A in level.players)
	{
		if(!isdefined(var_0A))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_0A))
		{
			continue;
		}

		if(var_0A != param_01 && level.teambased && param_01.team != var_0A.team)
		{
			continue;
		}

		var_08 = scripts\common\utility::array_add_safe(var_08,var_0A);
	}

	var_0C = param_01 scripts\mp\_powerloot::func_7FC4("power_shardBall",30);
	var_0D = param_01 scripts\mp\_powerloot::func_7FC4("power_shardBall",300);
	var_0E = scripts\common\utility::func_782F(var_07,var_08,undefined,undefined,var_0D,var_0C);
	var_0F = 15;
	if(isdefined(param_04))
	{
		var_0F = param_04;
	}

	var_10 = param_01 scripts\mp\_powerloot::func_7FC2("power_shardBall",var_0F);
	for(var_11 = 0;var_11 < var_10;var_11++)
	{
		var_12 = func_80B9(var_07,param_00);
		var_13 = undefined;
		if(isdefined(var_0E) && var_0E.size > 0)
		{
			var_14 = scripts\common\utility::random(var_0E);
			var_13 = var_14 gettagorigin("j_mainroot");
			var_0E = scripts\common\utility::func_22A9(var_0E,var_14);
		}

		param_01 thread func_6D81(var_07,var_12,param_02,var_13,param_05);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_80B9(param_00,param_01)
{
	var_02 = anglestoup(param_01);
	var_03 = anglestoright(param_01);
	var_04 = anglestoforward(param_01);
	var_05 = randomint(360);
	var_06 = randomint(360);
	var_07 = cos(var_06) * sin(var_05);
	var_08 = sin(var_06) * sin(var_05);
	var_09 = cos(var_05);
	var_0A = var_07 * var_03 + var_08 * var_04 + var_09 * var_02 / 0.33;
	return var_0A;
}

//Function Number: 13
func_6D81(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	var_05 = param_00 + param_01;
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}

	var_06 = scripts\mp\_utility::func_1309("iw6_semtexshards_mp",param_00,var_05,self);
	var_06.var_1653 = param_04;
	if(isdefined(param_02))
	{
		var_06 method_82DD(param_02);
	}

	var_06 waittill("explode",var_07);
	playsoundatpos(var_07,"mp_shard_grenade_impacts");
}

//Function Number: 14
func_CC21(param_00)
{
	self notify("powers_shardBall_used",0);
	scripts\mp\_utility::func_CC16(param_00.var_13C2E,1,param_00.origin);
}