/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cqb.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 280 ms
 * Timestamp: 10/27/2023 2:44:04 AM
*******************************************************************/

//Function Number: 1
movecqb()
{
	cqb_checkchangeweapon();
	if(self.a.pose != "stand")
	{
		self clearanim(%animscript_root,0.2);
		if(self.a.pose == "prone")
		{
			animscripts\utility::exitpronewrapper(1);
		}

		self.a.pose = "stand";
	}

	self.a.movement = self.movemode;
	cqbtracking();
	self clearanim(%h1_stairs,0.1);
	if(cqb_checkreload())
	{
		return;
	}

	var_00 = determinecqbanim();
	var_01 = cqb_gettranstime();
	var_02 = 0.2;
	thread cqb_scaleforslowdown(var_00,var_02);
	cqb_animate(var_00,var_02,var_01);
	cqb_playfacialanim(var_00);
	animscripts\notetracks::donotetracksfortime(var_02,"runanim");
}

//Function Number: 2
cqb_checkchangeweapon()
{
	if(!animscripts\stairs_utility::isonstairs())
	{
		animscripts\run::standrun_checkchangeweapon();
	}
}

//Function Number: 3
cqb_checkreload()
{
	return !animscripts\stairs_utility::isonstairs() && animscripts\run::standrun_checkreload();
}

//Function Number: 4
cqb_gettranstime()
{
	var_00 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();
	if(var_00 == "none" && !animscripts\stairs_utility::isonstairs())
	{
		return 0.3;
	}

	return 0.1;
}

//Function Number: 5
cqb_animate(param_00,param_01,param_02)
{
	if(isdefined(self.timeofmaincqbupdate))
	{
		var_03 = self.timeofmaincqbupdate;
	}
	else
	{
		var_03 = 0;
	}

	self.timeofmaincqbupdate = gettime();
	if(!animscripts\stairs_utility::isonstairs())
	{
		var_04 = animscripts\stairs_utility::getstairtransitionfinishedthisframe();
		var_05 = %walk_and_run_loops;
		if(self.timeofmaincqbupdate - var_03 > param_01 * 1000 && var_04 == "none")
		{
			var_05 = %stand_and_crouch;
		}

		self setflaggedanimknoball("runanim",param_00,var_05,1,param_02,self.moveplaybackrate * self.cqb_slowdown_scale,1);
		animscripts\run::setmovenonforwardanims(animscripts\utility::lookupanim("cqb","move_b"),animscripts\utility::lookupanim("cqb","move_l"),animscripts\utility::lookupanim("cqb","move_r"));
		thread animscripts\run::setcombatstandmoveanimweights("cqb");
		return;
	}

	self notify("stop_move_anim_update");
	self.update_move_anim_type = undefined;
	var_05 = %body;
	self setflaggedanimknoball("runanim",param_00,var_05,1,param_02,self.moveplaybackrate * self.cqb_slowdown_scale,1);
}

//Function Number: 6
determinecqbanim()
{
	if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset["cqb"]))
	{
		return animscripts\run::getrunanim();
	}

	if(animscripts\stairs_utility::isonstairs())
	{
		var_00 = animscripts\stairs_utility::getstairsanimnameatgroundpos();
		return animscripts\utility::lookupanim("cqb",var_00);
	}

	if(self.movemode == "walk")
	{
		return animscripts\utility::lookupanim("cqb","move_f");
	}

	if(isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
	{
		return animscripts\utility::lookupanim("cqb","straight");
	}

	if(!isdefined(self.a.runloopcount))
	{
		return animscripts\utility::lookupanim("cqb","straight");
	}

	var_01 = animscripts\utility::lookupanim("cqb","straight_twitch");
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return animscripts\utility::lookupanim("cqb","straight");
	}

	var_02 = animscripts\utility::getrandomintfromseed(self.a.runloopcount,4);
	if(var_02 == 0)
	{
		return animscripts\utility::gettwitchanim(var_01);
	}

	return animscripts\utility::lookupanim("cqb","straight");
}

//Function Number: 7
cqb_reloadinternal()
{
	self endon("movemode");
	self endon("should_stairs_transition");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
	var_01 = animscripts\utility::lookupanim("cqb","reload");
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	thread cqb_scaleforslowdown(var_01,getanimlength(var_01));
	self setflaggedanimknoballrestart(var_00,var_01,%body,1,0.25,self.moveplaybackrate * self.cqb_slowdown_scale);
	cqb_playfacialanim(var_01);
	animscripts\run::setmovenonforwardanims(animscripts\utility::lookupanim("cqb","move_b"),animscripts\utility::lookupanim("cqb","move_l"),animscripts\utility::lookupanim("cqb","move_r"));
	thread animscripts\run::setcombatstandmoveanimweights("cqb");
	childthread animscripts\stairs_utility::threadcheckstairstransition(var_01,0,0.3);
	animscripts\shared::donotetracks(var_00);
	self notify("killThreadCheckStairsTransition");
}

//Function Number: 8
cqbtracking()
{
	var_00 = animscripts\stairs_utility::isonstairs();
	var_01 = !var_00 && animscripts\move::mayshootwhilemoving();
	animscripts\run::setshootwhilemoving(var_01);
	if(var_00)
	{
		animscripts\run::endfaceenemyaimtracking();
		return;
	}

	thread animscripts\run::faceenemyaimtracking();
}

//Function Number: 9
setupcqbpointsofinterest()
{
	level.cqbpointsofinterest = [];
	var_00 = getentarray("cqb_point_of_interest","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.cqbpointsofinterest[var_01] = var_00[var_01].origin;
		var_00[var_01] delete();
	}
}

//Function Number: 10
findcqbpointsofinterest()
{
	if(isdefined(level.findingcqbpointsofinterest))
	{
		return;
	}

	anim.findingcqbpointsofinterest = 1;
	if(!level.cqbpointsofinterest.size)
	{
		return;
	}

	for(;;)
	{
		var_00 = getaiarray();
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(isalive(var_03) && var_03 animscripts\utility::iscqbwalking() && !isdefined(var_03.disable_cqb_points_of_interest))
			{
				var_04 = var_03.a.movement != "stop";
				var_05 = (var_03.origin[0],var_03.origin[1],var_03 getshootatpos()[2]);
				var_06 = var_05;
				var_07 = anglestoforward(var_03.angles);
				if(var_04)
				{
					var_08 = bullettrace(var_06,var_06 + var_07 * 128,0,undefined);
					var_06 = var_08["position"];
				}

				var_09 = -1;
				var_0A = 1048576;
				for(var_0B = 0;var_0B < level.cqbpointsofinterest.size;var_0B++)
				{
					var_0C = level.cqbpointsofinterest[var_0B];
					var_0D = distancesquared(var_0C,var_06);
					if(var_0D < var_0A)
					{
						if(var_04)
						{
							if(distancesquared(var_0C,var_05) < 4096)
							{
								continue;
							}

							var_0E = vectordot(vectornormalize(var_0C - var_05),var_07);
							if(var_0E < 0.643 || var_0E > 0.966)
							{
								continue;
							}
						}
						else if(var_0D < 2500)
						{
							continue;
						}

						if(!sighttracepassed(var_06,var_0C,0,undefined))
						{
							continue;
						}

						var_0A = var_0D;
						var_09 = var_0B;
					}
				}

				if(var_09 < 0)
				{
					var_03.cqb_point_of_interest = undefined;
				}
				else
				{
					var_03.cqb_point_of_interest = level.cqbpointsofinterest[var_09];
				}

				wait(0.05);
				var_01 = 1;
			}
		}

		if(!var_01)
		{
			wait(0.25);
		}
	}
}

//Function Number: 11
cqb_playfacialanim(param_00)
{
	self.facialidx = animscripts\face::playfacialanim(param_00,"run",self.facialidx);
}

//Function Number: 12
cqb_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}

//Function Number: 13
cqb_scaleforslowdown(param_00,param_01)
{
	self.cqb_slowdown_anim = param_00;
	self.cqb_slowdown_move_time = param_01;
	if(isdefined(self.cqb_slowdown_watcher_running))
	{
		return;
	}

	self.cqb_slowdown_watcher_running = 1;
	thread cqb_slowdownwatcher_ender();
	cqb_slowdownwatcher();
	self.cqb_slowdown_watcher_running = undefined;
}

//Function Number: 14
cqb_slowdownwatcher()
{
	self notify("end_cqb_slowdown_watcher");
	self endon("death");
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("end_cqb_slowdown_watcher");
	if(isdefined(self.cqb_slowdown_scale) && self.cqb_slowdown_scale != 1)
	{
		self waittill("slow_down_stop");
	}

	for(;;)
	{
		cqb_slowdownscale(1);
		self waittill("slow_down_start");
		cqb_slowdownscale(0.75);
		self waittill("slow_down_stop");
	}
}

//Function Number: 15
cqb_slowdownscale(param_00)
{
	self.cqb_slowdown_scale = param_00;
	self setanimrate(self.cqb_slowdown_anim,self.moveplaybackrate * self.cqb_slowdown_scale);
}

//Function Number: 16
cqb_slowdownwatcher_ender()
{
	self endon("death");
	self endon("killanimscript");
	self endon("move_interrupt");
	wait(self.cqb_slowdown_move_time);
	while(animscripts\utility::shouldcqb())
	{
		wait(self.cqb_slowdown_move_time);
	}

	self notify("end_cqb_slowdown_watcher");
}