/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\rat_king.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 336 ms
 * Timestamp: 10/27/2023 12:04:35 AM
*******************************************************************/

//Function Number: 1
rat_king_init()
{
	var_00 = scripts\common\utility::getstructarray("rat_king_spawner","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		level.rat_king_spawn_loc = var_02.origin;
		level.rat_king_spawn_angles = var_02.angles;
	}

	level.rat_king_vo_prefix = "disco_ratking_";
	setuprkbouncestructs();
}

//Function Number: 2
setuprkbouncestructs()
{
	level.rat_king_bounce_structs = scripts\common\utility::getstructarray("shield_bounce_loc","targetname");
}

//Function Number: 3
spawn_rat_king(param_00,param_01,param_02)
{
	level notify("spawn_rat_king");
	level endon("spawn_rat_king");
	scripts\common\utility::flag_wait("interactions_initialized");
	if(isdefined(level.rat_king))
	{
		if(scripts\common\utility::istrue(param_02))
		{
			level.rat_king suicide();
		}
		else
		{
			return;
		}
	}

	if(!isdefined(param_00))
	{
		param_00 = level.rat_king_spawn_loc;
	}

	if(!isdefined(param_01))
	{
		param_01 = level.rat_king_spawn_angles;
	}

	for(;;)
	{
		level.rat_king = scripts\mp\_mp_agent::func_108E8("ratking","axis",param_00,param_01);
		if(isdefined(level.rat_king))
		{
			level.rat_king.var_13550 = level.rat_king_vo_prefix;
			level.rat_king thread setrkscriptablestates();
			level.rat_king thread rkaudiomonitor();
			level.spawned_enemies[level.spawned_enemies.size] = level.rat_king;
			if(scripts\common\utility::flag("rk_fight_started"))
			{
				playsoundatpos(level.rat_king_spawn_loc + (0,0,100),"rk_spawn_in_lr");
			}

			level.rat_king thread runspawnlogic();
			break;
		}
		else
		{
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 4
setrkscriptablestates()
{
	wait(2);
	if(scripts\aitypes\ratking\behaviors::rk_isonplatform())
	{
		self setscriptablepartstate("movement","neutral");
		self setscriptablepartstate("rat_skirt","platform");
	}
}

//Function Number: 5
runspawnlogic()
{
	self.var_180 = 1;
	self.var_EF64 = 1;
	self.outofplayspace = 1;
	self notify("spawn");
	self setscriptablepartstate("movement","materialize");
	wait(2);
	self.outofplayspace = undefined;
	self.var_180 = 0;
	self.var_EF64 = 0;
}

//Function Number: 6
rkaudiomonitor()
{
	level endon("game_ended");
	self endon("death");
	var_00 = 10;
	self.var_D4AA = 0;
	for(;;)
	{
		var_01 = scripts\common\utility::func_1372E(["spawn","summon","pain","melee","shield_throw","over","under","stomp"],var_00);
		var_00 = randomintrange(4,10);
		switch(var_01)
		{
			case "spawn":
				level thread lib_0D62::func_CE9C(self,"spawn",0);
				break;
	
			case "summon":
				level thread lib_0D62::func_CE9C(self,"summon",0);
				break;
	
			case "pain":
				level thread lib_0D62::func_CE9C(self,"pain",0);
				break;
	
			case "under":
				level thread lib_0D62::func_CE9C(self,"melee",0);
				break;
	
			case "shield_throw":
				level thread lib_0D62::func_CE9C(self,"shield_throw",0);
				break;
	
			case "stomp":
				level thread lib_0D62::func_CE9C(self,"staff_stomp",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"staff_over",0);
				level thread lib_0D62::func_CE9C(self,"staff_under",0);
				break;
		}
	}
}