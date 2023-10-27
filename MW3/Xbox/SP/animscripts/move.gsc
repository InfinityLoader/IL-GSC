/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\move.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 38
 * Decompile Time: 646 ms
 * Timestamp: 10/27/2023 2:30:32 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.custom_animscript_table))
	{
		if(isdefined(self.custom_animscript_table["move"]))
		{
			[[ self.custom_animscript_table["move"] ]]();
			return;
		}
	}

	self endon("killanimscript");
	[[ self.exception["move"] ]]();
	moveinit();
	getupifprone();
	animscripts/utility::initialize("move");
	var_00 = waspreviouslyincover();
	if(var_00 && isdefined(self.shufflemove))
	{
		movecovertocover();
		movecovertocoverfinish();
	}
	else if(isdefined(self.battlechatter) && self.battlechatter)
	{
		func_0C9D(var_00);
		animscripts/battlechatter::playbattlechatter();
	}

	thread stairscheck();
	thread pathchangecheck();
	thread animdodgeobstacle();
	animscripts/cover_arrival::startmovetransition();
	self.doingreacquirestep = undefined;
	self.ignorepathchange = undefined;
	thread startthreadstorunwhilemoving();
	thread animscripts/cover_arrival::func_C94(1);
	self.shoot_while_moving_thread = undefined;
	self.var_BBD = undefined;
	self.runngun = undefined;
	movemainloop(1);
}

//Function Number: 2
end_script()
{
	if(isdefined(self.oldgrenadeweapon))
	{
		self.grenadeweapon = self.oldgrenadeweapon;
		self.oldgrenadeweapon = undefined;
	}

	self.var_C76 = undefined;
	self.minindoortime = undefined;
	self.ignorepathchange = undefined;
	self.shufflemove = undefined;
	self.shufflenode = undefined;
	self.runngun = undefined;
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
	self.var_C95 = undefined;
	self.moveloopoverridefunc = undefined;
}

//Function Number: 3
moveinit()
{
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
	self.update_move_anim_type = undefined;
	self.var_BE0 = undefined;
	self.runngunweight = 0;
	self.var_C98 = undefined;
}

//Function Number: 4
getupifprone()
{
	if(self.a.var_911 == "prone")
	{
		var_00 = animscripts/utility::choosepose("stand");
		if(var_00 != "prone")
		{
			self orientmode("face current");
			self animmode("zonly_physics",0);
			var_01 = 1;
			if(isdefined(self.grenade))
			{
				var_01 = 2;
			}

			animscripts/cover_prone::proneto(var_00,var_01);
			self animmode("none",0);
			self orientmode("face default");
		}
	}
}

//Function Number: 5
waspreviouslyincover()
{
	switch(self.prevscript)
	{
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_wide_right":
		case "cover_wide_left":
		case "cover_prone":
		case "cover_stand":
		case "cover_left":
		case "turret":
		case "cover_crouch":
		case "cover_right":
		case "hide":
			return 1;
	}

	return 0;
}

//Function Number: 6
func_0C9D(param_00)
{
	if(self.movemode == "run")
	{
		animscripts/battlechatter_ai::evaluatemoveevent(param_00);
	}
}

//Function Number: 7
movemainloop(param_00)
{
	movemainloopinternal(param_00);
	self notify("abort_reload");
}

//Function Number: 8
changemovemode(param_00)
{
	if(param_00 != self.prevmovemode)
	{
		if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset[param_00]))
		{
			self.a.moveanimset = self.custommoveanimset[param_00];
		}
		else
		{
			self.a.moveanimset = level.animsets.move[param_00];
			if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > squared(100))
			{
				self.sidesteprate = 1;
				animscripts/animset::set_ambush_sidestep_anims();
			}
			else
			{
				self.sidesteprate = 1.35;
			}
		}

		self.prevmovemode = param_00;
	}
}

//Function Number: 9
movemainloopinternal(param_00)
{
	self endon("killanimscript");
	self endon("move_interrupt");
	var_01 = self getanimtime(%walk_and_run_loops);
	self.a.runloopcount = randomint(10000);
	self.prevmovemode = "none";
	self.moveloopcleanupfunc = undefined;
	for(;;)
	{
		var_02 = self getanimtime(%walk_and_run_loops);
		if(var_02 < var_01)
		{
			self.a.runloopcount++;
		}

		var_01 = var_02;
		changemovemode(self.movemode);
		movemainloopprocess(self.movemode);
		if(isdefined(self.moveloopcleanupfunc))
		{
			self [[ self.moveloopcleanupfunc ]]();
			self.moveloopcleanupfunc = undefined;
		}

		self notify("abort_reload");
	}
}

//Function Number: 10
movemainloopprocess(param_00)
{
	self endon("move_loop_restart");
	animscripts/face::setidlefacedelayed(level.alertface);
	if(isdefined(self.moveloopoverridefunc))
	{
		self [[ self.moveloopoverridefunc ]]();
	}
	else if(animscripts/utility::shouldcqb())
	{
		animscripts/cqb::func_C60();
	}
	else if(param_00 == "run")
	{
		animscripts/run::moverun();
	}
	else
	{
		animscripts/walk::movewalk();
	}

	self.requestreacttobullet = undefined;
}

//Function Number: 11
mayshootwhilemoving()
{
	if(self.weapon == "none")
	{
		return 0;
	}

	var_00 = weaponclass(self.weapon);
	if(!animscripts/utility::usingriflelikeweapon())
	{
		return 0;
	}

	if(animscripts/combat_utility::issniper())
	{
		if(!animscripts/utility::iscqbwalking() && self.facemotion)
		{
			return 0;
		}
	}

	if(isdefined(self.dontshootwhilemoving))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
shootwhilemoving()
{
	self endon("killanimscript");
	self notify("doing_shootWhileMoving");
	self endon("doing_shootWhileMoving");
	if(isdefined(self.combatstandanims) && isdefined(self.combatstandanims["fire"]))
	{
		self.a.array["fire"] = self.combatstandanims["fire"];
	}
	else
	{
		self.a.array["fire"] = %exposed_shoot_auto_v3;
	}

	if(isdefined(self.weapon) && animscripts/utility::weapon_pump_action_shotgun())
	{
		self.a.array["single"] = animscripts/utility::array(%shotgun_stand_fire_1a,%shotgun_stand_fire_1b);
	}
	else
	{
		self.a.array["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	}

	self.a.array["burst2"] = %exposed_shoot_burst3;
	self.a.array["burst3"] = %exposed_shoot_burst3;
	self.a.array["burst4"] = %exposed_shoot_burst4;
	self.a.array["burst5"] = %exposed_shoot_burst5;
	self.a.array["burst6"] = %exposed_shoot_burst6;
	self.a.array["semi2"] = %exposed_shoot_semi2;
	self.a.array["semi3"] = %exposed_shoot_semi3;
	self.a.array["semi4"] = %exposed_shoot_semi4;
	self.a.array["semi5"] = %exposed_shoot_semi5;
	for(;;)
	{
		if(!self.bulletsinclip)
		{
			if(animscripts/utility::iscqbwalkingorfacingenemy())
			{
				self.ammocheattime = 0;
				animscripts/combat_utility::cheatammoifnecessary();
			}

			if(!self.bulletsinclip)
			{
				wait 0.5;
				continue;
			}
		}

		animscripts/combat_utility::shootuntilshootbehaviorchange();
		self clearanim(%exposed_aiming,0.2);
	}
}

//Function Number: 13
startthreadstorunwhilemoving()
{
	self endon("killanimscript");
	wait 0.05;
	thread bulletwhizbycheck_whilemoving();
	thread meleeattackcheck_whilemoving();
	thread animscripts/door::indoorcqbtogglecheck();
	thread animscripts/door::doorenterexitcheck();
}

//Function Number: 14
stairscheck()
{
	self endon("killanimscript");
	self.prevstairsstate = self.stairsstate;
	for(;;)
	{
		wait 0.05;
		if(self.prevstairsstate != self.stairsstate)
		{
			if(!isdefined(self.ignorepathchange) || self.stairsstate != "none")
			{
				self notify("move_loop_restart");
			}
		}

		self.prevstairsstate = self.stairsstate;
	}
}

//Function Number: 15
restartmoveloop(param_00)
{
	self endon("killanimscript");
	if(!param_00)
	{
		animscripts/cover_arrival::startmovetransition();
	}

	self.ignorepathchange = undefined;
	self clearanim(%root,0.1);
	self orientmode("face default");
	self animmode("none",0);
	self.requestarrivalnotify = 1;
	movemainloop(!param_00);
}

//Function Number: 16
pathchangecheck()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self.ignorepathchange = 1;
	for(;;)
	{
		self waittill("path_changed",var_00,var_01);
		if(isdefined(self.ignorepathchange) || isdefined(self.noturnanims))
		{
			continue;
		}

		if(!self.facemotion || abs(self getmotionangle()) > 15)
		{
			continue;
		}

		if(self.a.movement != "run" && self.a.movement != "walk")
		{
			continue;
		}

		if(self.a.var_911 != "stand")
		{
			continue;
		}

		self notify("stop_move_anim_update");
		self.update_move_anim_type = undefined;
		var_02 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
		var_03 = pathchange_getturnanim(var_02);
		if(isdefined(var_03))
		{
			self.turnanim = var_03;
			self.turntime = gettime();
			self.moveloopoverridefunc = ::pathchange_doturnanim;
			self notify("move_loop_restart");
			animscripts/run::endfaceenemyaimtracking();
		}
	}
}

//Function Number: 17
pathchange_getturnanim(param_00)
{
	if(isdefined(self.pathturnanimoverridefunc))
	{
		return [[ self.pathturnanimoverridefunc ]](param_00);
	}

	var_01 = undefined;
	var_02 = undefined;
	if(animscripts/utility::shouldcqb() || self.movemode == "walk")
	{
		var_03 = level.cqbturnanims;
	}
	else
	{
		var_03 = level.runturnanims;
	}

	if(param_00 < -30)
	{
		if(param_00 > -60)
		{
			var_01 = var_03["L45"];
		}
		else if(param_00 > -112.5)
		{
			var_01 = var_03["L90"];
			if(param_00 > -90)
			{
				var_02 = var_03["L45"];
			}
			else
			{
				var_02 = var_03["L135"];
			}
		}
		else if(param_00 > -157.5)
		{
			var_01 = var_03["L135"];
			if(param_00 > -135)
			{
				var_02 = var_03["L90"];
			}
			else
			{
				var_02 = var_03["180"];
			}
		}
		else
		{
			var_01 = var_03["180"];
			var_02 = var_03["L135"];
		}
	}
	else if(param_00 > 30)
	{
		if(param_00 < 60)
		{
			var_01 = var_03["R45"];
		}
		else if(param_00 < 112.5)
		{
			var_01 = var_03["R90"];
			if(param_00 < 90)
			{
				var_02 = var_03["R45"];
			}
			else
			{
				var_02 = var_03["R135"];
			}
		}
		else if(param_00 < 157.5)
		{
			var_01 = var_03["R135"];
			if(param_00 < 135)
			{
				var_02 = var_03["R90"];
			}
			else
			{
				var_02 = var_03["180"];
			}
		}
		else
		{
			var_01 = var_03["180"];
			var_02 = var_03["R135"];
		}
	}

	if(isdefined(var_01))
	{
		if(pathchange_candoturnanim(var_01))
		{
			return var_01;
		}
	}

	if(isdefined(var_02))
	{
		if(pathchange_candoturnanim(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 18
pathchange_candoturnanim(param_00)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	var_01 = getnotetracktimes(param_00,"code_move");
	var_02 = var_01[0];
	var_03 = getmovedelta(param_00,0,var_02);
	var_04 = self localtoworldcoords(var_03);
	if(isdefined(self.var_C98) && squared(self.var_C98) > distancesquared(self.pathgoalpos,var_04))
	{
		return 0;
	}

	var_03 = getmovedelta(param_00,0,1);
	var_05 = self localtoworldcoords(var_03);
	var_05 = var_04 + vectornormalize(var_05 - var_04) * 20;
	return self maymovefrompointtopoint(var_04,var_05,1,1);
}

//Function Number: 19
pathchange_doturnanim()
{
	self endon("killanimscript");
	self.moveloopoverridefunc = undefined;
	var_00 = self.turnanim;
	if(gettime() > self.turntime + 50)
	{
		return;
	}

	self animmode("zonly_physics",0);
	self clearanim(%body,0.1);
	self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
	self.ignorepathchange = 1;
	var_01 = 0.05;
	if(isdefined(self.pathturnanimblendtime))
	{
		var_01 = isdefined(self.pathturnanimblendtime);
	}

	self setflaggedanimrestart("turnAnim",var_00,1,var_01,self.moveplaybackrate);
	self orientmode("face current");
	animscripts/shared::donotetracks("turnAnim");
	self.ignorepathchange = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	animscripts/shared::donotetracks("turnAnim");
}

//Function Number: 20
pathchange_domovetransition()
{
	self.moveloopoverridefunc = undefined;
	if(gettime() > self.turntime + 50)
	{
		return;
	}

	self.moveloopcleanupfunc = ::pathchange_cleanupturnanim;
	animscripts/cover_arrival::startmovetransition();
}

//Function Number: 21
pathchange_cleanupturnanim()
{
	self.ignorepathchange = undefined;
	self orientmode("face default");
	self clearanim(%root,0.1);
	self animmode("none",0);
}

//Function Number: 22
dodgemoveloopoverride()
{
	self pushplayer(1);
	self animmode("zonly_physics",0);
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dodgeAnim",self.var_C95,1,0.2,1);
	animscripts/shared::donotetracks("dodgeAnim");
	self animmode("none",0);
	self orientmode("face default");
	if(animhasnotetrack(self.var_C95,"code_move"))
	{
		animscripts/shared::donotetracks("dodgeAnim");
	}

	self clearanim(%civilian_dodge,0.2);
	self pushplayer(0);
	self.var_C95 = undefined;
	self.moveloopoverridefunc = undefined;
	return 1;
}

//Function Number: 23
trydodgewithanim(param_00,param_01)
{
	var_02 = (self.lookaheaddir[1],-1 * self.lookaheaddir[0],0);
	var_03 = self.lookaheaddir * param_01[0];
	var_04 = var_02 * param_01[1];
	var_05 = self.origin + var_03 - var_04;
	self pushplayer(1);
	if(self maymovetopoint(var_05))
	{
		self.var_C95 = param_00;
		self.moveloopoverridefunc = ::dodgemoveloopoverride;
		self notify("move_loop_restart");
		return 1;
	}

	self pushplayer(0);
	return 0;
}

//Function Number: 24
animdodgeobstacle()
{
	if(!isdefined(self.dodgeleftanim) || !isdefined(self.dodgerightanim))
	{
		return;
	}

	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_need_dodge",var_00,var_01);
		if(animscripts/utility::isincombat())
		{
			self.nododgemove = 0;
			return;
		}

		if(!issentient(var_00))
		{
			continue;
		}

		var_02 = vectornormalize(var_01 - self.origin);
		if(self.lookaheaddir[0] * var_02[1] - var_02[0] * self.lookaheaddir[1] > 0)
		{
			if(!trydodgewithanim(self.dodgerightanim,self.dodgerightanimoffset))
			{
				trydodgewithanim(self.dodgeleftanim,self.dodgeleftanimoffset);
			}
		}
		else if(!trydodgewithanim(self.dodgeleftanim,self.dodgeleftanimoffset))
		{
			trydodgewithanim(self.dodgerightanim,self.dodgerightanimoffset);
		}

		if(isdefined(self.var_C95))
		{
			wait getanimlength(self.var_C95);
			continue;
		}

		wait 0.1;
	}
}

//Function Number: 25
setdodgeanims(param_00,param_01)
{
	self.nododgemove = 1;
	self.dodgeleftanim = param_00;
	self.dodgerightanim = param_01;
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	self.dodgeleftanimoffset = getmovedelta(param_00,0,var_02);
	var_02 = 1;
	if(animhasnotetrack(param_01,"code_move"))
	{
		var_02 = getnotetracktimes(param_01,"code_move")[0];
	}

	self.dodgerightanimoffset = getmovedelta(param_01,0,var_02);
	self.interval = 80;
}

//Function Number: 26
cleardodgeanims()
{
	self.nododgemove = 0;
	self.dodgeleftanim = undefined;
	self.dodgerightanim = undefined;
	self.dodgeleftanimoffset = undefined;
	self.dodgerightanimoffset = undefined;
}

//Function Number: 27
meleeattackcheck_whilemoving()
{
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.enemy) && isai(self.enemy) || isdefined(self.meleeplayerwhilemoving))
		{
			if(abs(self getmotionangle()) <= 135)
			{
				animscripts/melee::melee_tryexecuting();
			}
		}

		wait 0.1;
	}
}

//Function Number: 28
bulletwhizbycheck_whilemoving()
{
	self endon("killanimscript");
	if(isdefined(self.disablebulletwhizbyreaction))
	{
		return;
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(self.movemode != "run" || !self.facemotion || self.a.var_911 != "stand" || isdefined(self.reactingtobullet))
		{
			continue;
		}

		if(self.stairsstate != "none")
		{
			continue;
		}

		if(!isdefined(self.enemy) && !self.ignoreall && isdefined(var_00.team) && isenemyteam(self.team,var_00.team))
		{
			self.whizbyenemy = var_00;
			self animcustom(::animscripts/reactions::func_B0E);
			continue;
		}

		if(self.lookaheadhitsstairs || self.lookaheaddist < 100)
		{
			continue;
		}

		if(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) < 10000)
		{
			wait 0.2;
			continue;
		}

		self.requestreacttobullet = gettime();
		self notify("move_loop_restart");
		animscripts/run::endfaceenemyaimtracking();
	}
}

//Function Number: 29
get_shuffle_to_corner_start_anim(param_00,param_01)
{
	if(param_01.type == "Cover Left")
	{
		return %cornercrl_alert_2_shuffle;
	}

	if(param_01.type == "Cover Right")
	{
		return %cornercrr_alert_2_shuffle;
	}

	if(param_00)
	{
		return %covercrouch_hide_2_shufflel;
	}

	return %covercrouch_hide_2_shuffler;
}

//Function Number: 30
func_0CC1(param_00,param_01,param_02)
{
	var_03 = [];
	if(param_02.type == "Cover Left")
	{
	}
	else if(var_03.type == "Cover Right")
	{
	}
	else if(var_03.type == "Cover Stand" && param_02.type == var_03.type)
	{
		if(param_01)
		{
		}
		else
		{
		}
	}
	else if(param_01)
	{
		if(var_03.type == "Cover Stand")
		{
		}
		else
		{
		}
	}
	else if(var_03.type == "Cover Stand")
	{
	}
	else
	{
	}

	self.a.array = var_41;
}

//Function Number: 31
func_0CC2(param_00,param_01)
{
	if(self.a.var_911 == "stand" && param_01.type != "Cover Stand" || param_00.type != "Cover Stand")
	{
		self.a.var_911 = "crouch";
		return 0;
	}

	return 1;
}

//Function Number: 32
movecovertocover_checkendpose(param_00)
{
	if(self.a.var_911 == "crouch" && param_00.type == "Cover Stand")
	{
		self.a.var_911 = "stand";
		return 0;
	}

	return 1;
}

//Function Number: 33
movecovertocover()
{
	self endon("killanimscript");
	self endon("goal_changed");
	var_00 = self.shufflenode;
	self.shufflemove = undefined;
	self.shufflenode = undefined;
	self.shufflemoveinterrupted = 1;
	if(!isdefined(self.prevnode))
	{
		return;
	}

	if(!isdefined(self.node) || !isdefined(var_00) || self.node != var_00)
	{
		return;
	}

	var_01 = self.prevnode;
	var_02 = self.node;
	var_03 = var_02.origin - self.origin;
	if(lengthsquared(var_03) < 1)
	{
		return;
	}

	var_03 = vectornormalize(var_03);
	var_04 = anglestoforward(var_02.angles);
	var_05 = var_04[0] * var_03[1] - var_04[1] * var_03[0] > 0;
	if(movedoorsidetoside(var_05,var_01,var_02))
	{
		return;
	}

	if(func_0CC2(var_01,var_02))
	{
		var_06 = 0.1;
	}
	else
	{
		var_06 = 0.4;
	}

	func_0CC1(var_05,var_01,var_02);
	self animmode("zonly_physics",0);
	self clearanim(%body,var_06);
	var_07 = animscripts/utility::animarray("shuffle_start");
	var_08 = animscripts/utility::animarray("shuffle");
	var_09 = animscripts/utility::animarray("shuffle_end");
	if(animhasnotetrack(var_07,"finish"))
	{
		var_0A = getnotetracktimes(var_07,"finish")[0];
	}
	else
	{
		var_0A = 1;
	}

	var_0B = length(getmovedelta(var_07,0,var_0A));
	var_0C = length(getmovedelta(var_08,0,1));
	var_0D = length(getmovedelta(var_09,0,1));
	var_0E = distance(self.origin,var_02.origin);
	if(var_0E > var_0B)
	{
		self orientmode("face angle",animscripts/utility::getnodeforwardyaw(var_01));
		self setflaggedanimrestart("shuffle_start",var_07,1,var_06);
		animscripts/shared::donotetracks("shuffle_start");
		self clearanim(var_07,0.2);
		var_0E = var_0E - var_0B;
		var_06 = 0.2;
	}
	else
	{
		self orientmode("face angle",var_02.angles[1]);
	}

	var_0F = 0;
	if(var_0E > var_0D)
	{
		var_0F = 1;
		var_0E = var_0E - var_0D;
	}

	var_10 = getanimlength(var_08);
	var_11 = var_10 * var_0E / var_0C * 0.9;
	var_11 = floor(var_11 * 20) * 0.05;
	self setflaggedanim("shuffle",var_08,1,var_06);
	animscripts/notetracks::donotetracksfortime(var_11,"shuffle");
	for(var_12 = 0;var_12 < 2;var_12++)
	{
		var_0E = distance(self.origin,var_02.origin);
		if(var_0F)
		{
			var_0E = var_0E - var_0D;
		}

		if(var_0E < 4)
		{
			break;
		}

		var_11 = var_10 * var_0E / var_0C * 0.9;
		var_11 = floor(var_11 * 20) * 0.05;
		if(var_11 < 0.05)
		{
			break;
		}

		animscripts/notetracks::donotetracksfortime(var_11,"shuffle");
	}

	if(var_0F)
	{
		if(movecovertocover_checkendpose(var_02))
		{
			var_06 = 0.2;
		}
		else
		{
			var_06 = 0.4;
		}

		self clearanim(var_08,var_06);
		self setflaggedanim("shuffle_end",var_09,1,var_06);
		animscripts/shared::donotetracks("shuffle_end");
	}

	self safeteleport(var_02.origin);
	self animmode("normal");
	self.shufflemoveinterrupted = undefined;
}

//Function Number: 34
movecovertocoverfinish()
{
	if(isdefined(self.shufflemoveinterrupted))
	{
		self clearanim(%cover_shuffle,0.2);
		self.shufflemoveinterrupted = undefined;
		self animmode("none",0);
		self orientmode("face default");
		return;
	}

	wait 0.2;
	self clearanim(%cover_shuffle,0.2);
}

//Function Number: 35
movedoorsidetoside(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01.type == "Cover Right" && param_02.type == "Cover Left" && !param_00)
	{
		var_03 = %corner_standr_door_r2l;
	}
	else if(param_01.type == "Cover Left" && param_02.type == "Cover Right" && param_00)
	{
		var_03 = %corner_standl_door_l2r;
	}

	if(!isdefined(var_03))
	{
		return 0;
	}

	self animmode("zonly_physics",0);
	self orientmode("face current");
	self setflaggedanimrestart("sideToSide",var_03,1,0.2);
	animscripts/shared::donotetracks("sideToSide",::handlesidetosidenotetracks);
	var_04 = self getanimtime(var_03);
	var_05 = param_02.origin - param_01.origin;
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	var_06 = getmovedelta(var_03,var_04,1);
	var_07 = param_02.origin - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = vectordot(var_07,var_05) - abs(var_06[1]);
	if(var_08 > 2)
	{
		var_09 = getnotetracktimes(var_03,"slide_end")[0];
		var_0A = var_09 - var_04 * getanimlength(var_03);
		var_0B = int(ceil(var_0A / 0.05));
		var_0C = var_05 * var_08 / var_0B;
		thread func_0CC9(var_0C,var_0B);
	}

	animscripts/shared::donotetracks("sideToSide");
	self safeteleport(param_02.origin);
	self animmode("none");
	self orientmode("face default");
	self.shufflemoveinterrupted = undefined;
	wait 0.2;
	return 1;
}

//Function Number: 36
handlesidetosidenotetracks(param_00)
{
	if(param_00 == "slide_start")
	{
		return 1;
	}
}

//Function Number: 37
func_0CC9(param_00,param_01)
{
	self endon("killanimscript");
	self endon("goal_changed");
	while(param_01 > 0)
	{
		self safeteleport(self.origin + param_00);
		param_01--;
		wait 0.05;
	}
}

//Function Number: 38
movestandmoveoverride(param_00,param_01)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && isdefined(self.run_overridebulletreact) && randomfloat(1) < self.a.reacttobulletchance)
	{
		animscripts/run::customrunningreacttobullets();
		return;
	}

	if(isarray(param_00))
	{
		if(isdefined(self.var_BA8))
		{
			var_02 = common_scripts\utility::choose_from_weighted_array(param_00,param_01);
		}
		else
		{
			var_02 = param_01[randomint(param_01.size)];
		}
	}
	else
	{
		var_02 = param_01;
	}

	self setflaggedanimknob("moveanim",var_02,1,0.2);
	animscripts/shared::donotetracks("moveanim");
}