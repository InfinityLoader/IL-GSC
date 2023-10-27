/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\interaction_loudspeaker.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 663 ms
 * Timestamp: 10/27/2023 12:09:03 AM
*******************************************************************/

//Function Number: 1
init_loudspeaker_trap()
{
	wait(3);
	level.loudspeaker_trap_uses = 0;
	var_00 = scripts\common\utility::getstructarray("trap_loudspeaker","script_noteworthy");
	foreach(var_03, var_02 in var_00)
	{
		if(var_03 == 0)
		{
			var_02.origin = (2412,-2136.5,var_02.origin[2]);
			continue;
		}

		if(var_03 == 1)
		{
			var_02.origin = (2412,-2136.5,var_02.origin[2]);
			continue;
		}

		var_02.origin = (2412,-2058,var_02.origin[2]);
	}

	level.loudspeaker_blast_zone = getent("loudspeaker_blast_zone","targetname");
	level.var_4D7C = level.loudspeaker_blast_zone;
	level.rave_dance_attract_zone = getent("rave_dance_attract_trig","targetname");
	level.rave_dance_attract_zone.var_257 = 750;
	level.rave_dance_attract_zone.height = 175;
	level.rave_dance_attract_zone.origin = level.rave_dance_attract_zone.origin + (0,0,-50);
	foreach(var_05 in var_00)
	{
		var_05 thread func_13611();
	}

	wait(1);
	level.rave_dance_attract_sorter = scripts\common\utility::getstruct("rave_dance_sorter","targetname");
	level.rave_dance_spots = scripts\common\utility::getstructarray("rave_dance_spots","targetname");
	func_E1E0();
}

//Function Number: 2
func_13611()
{
	var_00 = scripts\common\utility::istrue(self.var_E1B9) && isdefined(self.var_D71C);
	for(;;)
	{
		var_01 = "power_on";
		if(var_00)
		{
			var_01 = level scripts\common\utility::waittill_any_return_no_endon_death_3("power_on",self.var_D71C + " power_on","power_off");
		}

		if(var_01 == "power_off" && !scripts\common\utility::istrue(self.var_D776))
		{
			wait(0.25);
			continue;
		}

		if(var_01 != "power_off")
		{
			self.var_D776 = 1;
		}
		else
		{
			self.var_D776 = 0;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 3
use_loudspeaker_trap(param_00,param_01)
{
	level.loudspeaker_trap_uses++;
	level.var_563D = 1;
	scripts\cp\_interaction::disable_like_interactions(param_00);
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	param_00.var_126A4 = 0;
	param_00.var_126A5 = param_01;
	level thread func_254E();
	param_00 thread sfx_speaker_trap();
	wait(29.5);
	level thread loudspeaker_damage(level.loudspeaker_blast_zone,param_01,param_00);
	wait(1);
	level notify("speaker_trap_done");
	wait(0.1);
	level thread loudspeaker_damage(level.loudspeaker_blast_zone,param_01,param_00);
	wait(0.5);
	level notify("speaker_trap_kills",param_00.var_126A4);
	func_E1E0();
	level.var_563D = undefined;
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		param_01.var_1189F = param_00.var_126A4;
		scripts\cp\zombies\arcade_game_utility::update_player_tickets_earned(param_01);
	}

	scripts\cp\_interaction::enable_like_interactions(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,max(level.loudspeaker_trap_uses * 45,45));
}

//Function Number: 4
sfx_speaker_trap()
{
	level thread scripts\cp\maps\cp_rave\cp_rave::disable_rave_speakers();
	playsoundatpos(self.origin,"mus_rave_stage_trap");
	wait(28.8);
	playsoundatpos(self.origin,"trap_speaker_feedback");
	scripts\common\utility::exploder(1);
	wait(1.2);
	playsoundatpos(self.origin,"trap_speaker_expl");
	wait(0.5);
	level thread scripts\cp\maps\cp_rave\cp_rave::reenable_rave_speakers();
}

//Function Number: 5
func_254E()
{
	level endon("speaker_trap_done");
	var_00 = getent("rave_dance_attract_trig","targetname");
	level.rave_dancing_zombies = [];
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			continue;
		}

		if(!scripts\cp\_utility::func_FF18(var_01) || var_01.var_152C || var_01.var_EF64)
		{
			continue;
		}

		if(var_01.agent_type == "slasher" || var_01.agent_type == "superslasher" || var_01.agent_type == "lumberjack" || var_01.agent_type == "zombie_sasquatch")
		{
			continue;
		}

		if(isdefined(var_01.is_skeleton))
		{
			continue;
		}

		var_01 thread func_8401();
		var_01 thread func_DF45();
	}
}

//Function Number: 6
func_78B3(param_00)
{
	var_01 = sortbydistance(level.rave_dance_spots,level.rave_dance_attract_sorter.origin);
	foreach(var_03 in var_01)
	{
		if(!var_03.var_C2CF)
		{
			var_03.var_C2CF = 1;
			param_00.var_4D7D = var_03;
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 7
func_E1E0()
{
	foreach(var_01 in level.rave_dance_spots)
	{
		var_01.var_C2CF = 0;
	}
}

//Function Number: 8
func_8401(param_00)
{
	self endon("death");
	self endon("turned");
	level endon("speaker_trap_done");
	self.var_152C = 1;
	self.var_EF64 = 1;
	self.var_C37F = self.var_15C;
	self method_8287(32);
	var_01 = func_78B3(self);
	if(!isdefined(var_01))
	{
		var_02 = sortbydistance(level.rave_dance_spots,self.origin);
		var_01 = var_02[0];
	}

	self.var_5273 = (0,var_01.angles[1],0);
	self method_8286(var_01.origin);
	scripts\common\utility::waittill_any_3("goal","goal_reached");
	self.do_immediate_ragdoll = 1;
	self.var_9BB0 = 1;
	level.rave_dancing_zombies[level.rave_dancing_zombies.size] = self;
}

//Function Number: 9
func_DF45()
{
	self endon("death");
	level waittill("speaker_trap_done");
	if(isdefined(self.var_C37F))
	{
		self method_8287(self.var_C37F);
	}

	self.var_C37F = undefined;
	self.var_152C = 0;
	self.var_EF64 = 0;
}

//Function Number: 10
loudspeaker_damage(param_00,param_01,param_02)
{
	physicsexplosionsphere((2216,-2108,2),575,512,10);
	var_03 = 0;
	foreach(var_05 in level.rave_dancing_zombies)
	{
		if(isdefined(var_05) && isalive(var_05))
		{
			var_05.var_126A3 = param_01;
			param_02.var_126A4++;
			if(var_03 > 10)
			{
				var_05.nocorpse = 1;
				var_05.full_gib = 1;
				var_06 = "boombox";
				var_05 dodamage(var_05.health + 100,level.rave_dance_attract_sorter.origin,param_00,param_00,"MOD_EXPLOSIVE","zmb_imsprojectile_mp");
				continue;
			}

			var_05 setvelocity(vectornormalize(var_05.origin + (0,0,40) - level.rave_dance_attract_sorter.origin) * 1800 + (0,0,550));
			var_05.do_immediate_ragdoll = 1;
			var_05.var_4C87 = 1;
			var_05 thread speaker_delayed_death(param_01);
			var_03++;
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 11
speaker_delayed_death(param_00)
{
	self endon("death");
	wait(0.1);
	if(isdefined(param_00) && isalive(param_00))
	{
		var_01 = ["kill_trap_generic","kill_trap_1","kill_trap_2","kill_trap_3","kill_trap_4","kill_trap_5","kill_trap_6","trap_kill_7"];
		param_00 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_01),"zmb_comment_vo","highest",10,0,0,1,25);
		self dodamage(self.health + 1000,level.rave_dance_attract_sorter.origin,param_00,param_00,"MOD_EXPLOSIVE","iw7_discotrap_zm");
		return;
	}

	self dodamage(self.health + 1000,level.rave_dance_attract_sorter.origin,undefined,undefined,"MOD_EXPLOSIVE","iw7_discotrap_zm");
}

//Function Number: 12
func_E069()
{
	self endon("disconnect");
	wait(0.25);
	self.var_C85F = undefined;
}