/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_exocrossbow.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 129 ms
 * Timestamp: 4/22/2024 2:15:47 AM
*******************************************************************/

//Function Number: 1
monitor_exocrossbow_launch()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	level._effect["exocrossbow_sticky_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
	level._effect["exocrossbow_sticky_blinking"] = loadfx("vfx/lights/light_beacon_crossbow");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		var_02 = 0;
		if(issubstr(var_01,"iw5_exocrossbow"))
		{
			var_02 = 1;
		}
		else if(issubstr(var_01,"dlcgun11loot0"))
		{
			var_02 = 1;
		}

		if(!var_02)
		{
			continue;
		}

		var_00 setotherent(self);
		var_00.ch_crossbow_player_jumping = self ishighjumping();
		thread wait_for_stuck(var_00);
	}
}

//Function Number: 2
wait_for_stuck(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("faux_spawn");
	param_00 endon("death");
	param_00 waittill("missile_stuck",var_01);
	param_00 thread determine_sticky_position(self,var_01);
}

//Function Number: 3
determine_sticky_position(param_00,param_01)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("faux_spawn");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01) && !maps\mp\_utility::invirtuallobby() && isplayer(param_01))
	{
		self.ch_crossbow_victim_jumping = param_01 ishighjumping();
		if(param_00 maps\mp\gametypes\_weapons::isstucktofriendly(param_01))
		{
			self.isstuck = "friendly";
		}
		else
		{
			self.isstuck = "enemy";
			self.stuckenemyentity = param_01;
			param_00 maps\mp\_events::crossbowstickevent(param_01);
			param_00 notify("process","ch_bullseye");
		}
	}

	thread sticky_timer(param_00);
	thread sticky_fx(param_00);
	thread remove_sticky_on_explosion(param_00);
	thread cleanup_sticky_on_death();
	thread maps\mp\gametypes\_weapons::stickyhandlemovers("detonate");
}

//Function Number: 4
sticky_timer(param_00)
{
	self endon("death");
	wait(1.5);
	self notify("exocrossbow_exploded");
}

//Function Number: 5
sticky_fx(param_00)
{
	self endon("exocrossbow_exploded");
	self endon("death");
	self.fx_origin = common_scripts\utility::spawn_tag_origin();
	self.fx_origin.origin = self.origin;
	self.fx_origin.angles = self.angles;
	self.fx_origin show();
	self.fx_origin linkto(self);
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"),self.fx_origin,"tag_origin");
	self playsound("exocrossbow_warning");
}

//Function Number: 6
remove_sticky_on_explosion(param_00)
{
	self endon("death");
	self waittill("exocrossbow_exploded");
	cleanup_sticky();
}

//Function Number: 7
cleanup_sticky_on_death()
{
	self endon("exocrossbow_exploded");
	self waittill("death");
	cleanup_sticky();
}

//Function Number: 8
cleanup_sticky()
{
	stopfxontag(common_scripts\utility::getfx("exocrossbow_sticky_blinking"),self.fx_origin,"tag_origin");
	self.fx_origin delete();
}