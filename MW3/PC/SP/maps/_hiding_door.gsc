/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hiding_door.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 210 ms
 * Timestamp: 10/27/2023 2:23:07 AM
*******************************************************************/

//Function Number: 1
hiding_door_spawner()
{
	var_00 = getentarray("hiding_door_guy_org","targetname");
	var_01 = maps\_utility::getclosest(self.origin,var_00);
	var_01.targetname = undefined;
	var_02 = getentarray(var_01.target,"targetname");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(var_01.script_linkto))
	{
		var_05 = var_01 common_scripts\utility::get_linked_ent();
	}

	if(var_02.size == 1)
	{
		var_03 = var_02[0];
	}
	else
	{
		foreach(var_07 in var_02)
		{
			if(var_07.code_classname == "script_brushmodel")
			{
				var_04 = var_07;
				continue;
			}

			if(var_07.code_classname == "script_model")
			{
				var_03 = var_07;
			}
		}
	}

	var_09 = getent(var_03.target,"targetname");
	var_0A = undefined;
	if(isdefined(var_09.target))
	{
		var_0A = getent(var_09.target,"targetname");
	}

	if(isdefined(var_0A))
	{
		var_01 thread hiding_door_guy_pushplayer(var_0A);
		if(!isdefined(level._hiding_door_pushplayer_clips))
		{
			level._hiding_door_pushplayer_clips = [];
		}

		level._hiding_door_pushplayer_clips[level._hiding_door_pushplayer_clips.size] = var_0A;
	}

	var_03 delete();
	var_0B = maps\_utility::spawn_anim_model("hiding_door");
	var_01 thread maps\_anim::anim_first_frame_solo(var_0B,"fire_3");
	if(isdefined(var_04))
	{
		var_04 linkto(var_0B,"door_hinge_jnt");
		var_0B hide();
	}

	if(isdefined(var_09))
	{
		var_09 linkto(var_0B,"door_hinge_jnt");
		var_09 disconnectpaths();
	}

	var_0C = undefined;
	if(isdefined(self.target))
	{
		var_0C = getent(self.target,"targetname");
		if(!issubstr(var_0C.classname,"trigger"))
		{
			var_0C = undefined;
		}
	}

	if(!isdefined(self.script_flag_wait) && !isdefined(var_0C))
	{
		var_0D = 200;
		if(isdefined(self.radius))
		{
			var_0D = self.radius;
		}

		var_0C = spawn("trigger_radius",var_01.origin,0,var_0D,48);
	}

	if(isdefined(var_05))
	{
		badplace_brush(var_05 getentitynumber(),0,var_05,"allies");
	}

	maps\_utility::add_spawn_function(::hiding_door_guy,var_01,var_0C,var_0B,var_09,var_05);
}

//Function Number: 2
hiding_door_guy(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = hiding_door_starts_open(param_00);
	self.animname = "hiding_door_guy";
	self endon("death");
	self endon("damage");
	self.grenadeammo = 2;
	maps\_utility::set_deathanim("death_2");
	self.allowdeath = 1;
	self.health = -15536;
	var_06 = [];
	thread hiding_door_guy_cleanup(param_01,self,param_03,param_04,var_05);
	thread hiding_door_death(param_03,param_01,self,param_04,var_05);
	if(var_06)
	{
		param_01 thread maps\_anim::anim_loop(var_7B,"idle");
	}
	else
	{
		param_01 thread maps\_anim::anim_first_frame(var_7B,"fire_3");
	}

	if(isdefined(param_02))
	{
		wait 0.05;
		param_02 waittill(param_02,var_7B[var_06.size],self,var_7B[var_7B.size],"trigger");
	}
	else
	{
		common_scripts\utility::flag_wait(self.script_flag_wait);
	}

	if(var_06)
	{
		param_01 notify("stop_loop");
		param_01 maps\_anim::anim_single(var_7B,"close");
	}

	var_07 = 0;
	var_08 = 0;
	for(;;)
	{
		var_09 = level.player;
		if(isdefined(self.enemy))
		{
			var_09 = self.enemy;
		}

		var_0A = hiding_door_get_enemy_direction(param_03.angles,self.origin,var_09.origin);
		if(player_entered_backdoor(var_0A))
		{
			if(quit_door_behavior())
			{
				return;
			}
		}

		if(var_07 >= 2)
		{
			if(quit_door_behavior(1))
			{
				return;
			}
		}

		var_0B = undefined;
		if(var_0A == "left" || var_0A == "front")
		{
			var_0B = "fire_3";
		}
		else if(var_0A == "right")
		{
			var_0B = "fire_1";
			if(common_scripts\utility::cointoss())
			{
				var_0B = "fire_2";
			}
		}
		else
		{
			param_01 maps\_anim::anim_single(var_7B,"open");
			param_01 maps\_anim::anim_single(var_7B,"close");
			var_07++;
			continue;
		}

		if(hiding_door_guy_should_charge(var_0A,var_09,var_08))
		{
			var_0B = "jump";
			if(common_scripts\utility::cointoss())
			{
				if(self maymovetopoint(animscripts/utility::func_F99(level.scr_anim[self.animname]["kick"])))
				{
					var_0B = "kick";
				}
			}

			thread hiding_door_death_door_connections(param_04,var_05);
			param_01 notify("push_player");
			self notify("charge");
			self.allowdeath = 1;
			self.health = 100;
			maps\_utility::clear_deathanim();
			param_01 maps\_anim::anim_single(var_7B,var_0B);
			quit_door_behavior();
			return;
		}

		if(hiding_door_guy_should_throw_grenade(var_0A,var_08))
		{
			self.grenadeammo--;
			var_0B = "grenade";
		}

		var_07 = 0;
		var_08++;
		param_01 thread maps\_anim::anim_single(var_7B,var_0B);
		maps\_utility::delaythread(0.05,::maps\_anim::anim_set_time,var_7B,var_0B,0.3);
		param_01 waittill(var_0B);
		param_01 thread maps\_anim::anim_first_frame(var_7B,"open");
		wait randomfloatrange(0.2,1);
		param_01 notify("stop_loop");
	}
}

//Function Number: 3
quit_door_behavior(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00)
	{
		if(!sighttracepassed(level.player geteye(),self geteye(),0,self))
		{
			return 0;
		}
	}

	self.health = 100;
	maps\_utility::clear_deathanim();
	self.goalradius = 512;
	self setgoalpos(self.origin);
	self notify("quit_door_behavior");
	self stopanimscripted();
	self notify("killanimscript");
	return 1;
}

//Function Number: 4
player_entered_backdoor(param_00)
{
	if(param_00 != "behind")
	{
		return 0;
	}

	var_01 = distance(self.origin,level.player.origin);
	if(var_01 > 250)
	{
		return 0;
	}

	if(!sighttracepassed(level.player geteye(),self geteye(),0,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
hiding_door_guy_should_charge(param_00,param_01,param_02)
{
	var_03 = 3;
	var_04 = 100;
	var_05 = 600;
	if(param_02 < var_03)
	{
		return 0;
	}

	if(param_01 != level.player)
	{
		return 0;
	}

	if(param_00 != "front")
	{
		return 0;
	}

	var_06 = distance(self.origin,level.player.origin);
	if(var_06 < var_04)
	{
		return 0;
	}

	if(var_06 > var_05)
	{
		return 0;
	}

	return common_scripts\utility::cointoss();
}

//Function Number: 6
hiding_door_guy_should_throw_grenade(param_00,param_01)
{
	if(param_01 < 1)
	{
		return 0;
	}

	if(param_00 == "behind")
	{
		return 0;
	}

	if(randomint(100) < 25 * self.grenadeammo)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
hiding_door_get_enemy_direction(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_00);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = int(var_07) % 360;
	var_08 = undefined;
	if(var_07 >= 90 && var_07 <= 270)
	{
		var_08 = "behind";
	}
	else if(var_07 >= 300 || var_07 <= 45)
	{
		var_08 = "front";
	}
	else if(var_07 < 90)
	{
		var_08 = "right";
	}
	else if(var_07 > 270)
	{
		var_08 = "left";
	}

	return var_08;
}

//Function Number: 8
hiding_door_guy_cleanup(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("charge");
	param_01 common_scripts\utility::waittill_either("death","quit_door_behavior");
	param_00 notify("stop_loop");
	thread hiding_door_death_door_connections(param_03,param_04);
	param_00 notify("push_player");
	if(!isdefined(param_02.played_death_anim))
	{
		param_02.played_death_anim = 1;
		param_00 thread maps\_anim::anim_single_solo(param_02,"death_2");
	}
}

//Function Number: 9
hiding_door_guy_pushplayer(param_00)
{
	self waittill("push_player");
	param_00 moveto(self.origin,1.5);
	wait 1.5;
	param_00 delete();
}

//Function Number: 10
hiding_door_guy_grenade_throw(param_00)
{
	var_01 = param_00 gettagorigin("J_Wrist_RI");
	var_02 = distance(level.player.origin,param_00.origin) * 2;
	if(var_02 < 300)
	{
		var_02 = 300;
	}

	if(var_02 > 1000)
	{
		var_02 = 1000;
	}

	var_03 = vectornormalize(level.player.origin - param_00.origin);
	var_04 = var_03 * var_02;
	param_00 magicgrenademanual(var_01,var_04,randomfloatrange(3,5));
}

//Function Number: 11
hiding_door_death(param_00,param_01,param_02,param_03,param_04)
{
	param_02 endon("charge");
	param_02 endon("quit_door_behavior");
	param_02 waittill("damage",var_05,var_06);
	if(!isalive(param_02))
	{
		return;
	}

	thread hiding_door_death_door_connections(param_03,param_04);
	param_01 notify("push_player");
	param_01 thread maps\_anim::anim_single_solo(param_02,"death_2");
	if(!isdefined(param_00.played_death_anim))
	{
		param_00.played_death_anim = 1;
		param_01 thread maps\_anim::anim_single_solo(param_00,"death_2");
	}

	wait 0.5;
	if(isalive(param_02))
	{
		if(isdefined(var_06))
		{
			param_02 kill((0,0,0),var_06);
			return;
		}

		param_02 kill((0,0,0));
	}
}

//Function Number: 12
hiding_door_death_door_connections(param_00,param_01)
{
	wait 2;
	if(isdefined(param_00))
	{
		param_00 disconnectpaths();
	}

	if(isdefined(param_01))
	{
		badplace_delete(param_01 getentitynumber());
	}
}

//Function Number: 13
hiding_door_starts_open(param_00)
{
	return isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "starts_open";
}