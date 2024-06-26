/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: run.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 703 ms
 * Timestamp: 4/22/2024 2:00:48 AM
*******************************************************************/

//Function Number: 1
moverun()
{
	var_00 = [[ self.chooseposefunc ]]("stand");
	switch(var_00)
	{
		case "stand":
			if(animscripts\setposemovement::standrun_begin())
			{
				return;
			}
	
			if(isdefined(self.run_overrideanim))
			{
				animscripts\move::movestand_moveoverride(self.run_overrideanim,self.run_override_weights);
				return;
			}
	
			if(standrun_checkchangeweapon())
			{
				return;
			}
	
			if(standrun_checkreload())
			{
				return;
			}
	
			animscripts\utility::updateisincombattimer();
			if(animscripts\utility::isincombat())
			{
				standrun_combatnormal();
			}
			else
			{
				standrun_noncombatnormal();
			}
			break;

		case "crouch":
			if(animscripts\setposemovement::crouchrun_begin())
			{
				return;
			}
	
			if(isdefined(self.crouchrun_combatanim))
			{
				crouchrun_runoverride();
			}
			else
			{
				crouchrun_runnormal();
			}
			break;

		default:
			if(animscripts\setposemovement::pronerun_begin())
			{
				return;
			}
	
			pronecrawl();
			break;
	}
}

//Function Number: 2
getrunanim()
{
	if(!isdefined(self.a.moveanimset))
	{
		return animscripts\utility::lookupanim("run","straight");
	}

	if(!self.facemotion)
	{
		if(self.stairsstate == "none" || abs(self getmotionangle()) > 45)
		{
			return animscripts\utility::getmoveanim("move_f");
		}
	}

	if(self.stairsstate == "up")
	{
		return animscripts\utility::getmoveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts\utility::getmoveanim("stairs_down");
	}
	else if(animscripts\utility::usingsmg())
	{
		return animscripts\utility::getmoveanim("smg_straight");
	}

	if(animscripts\utility::isincombat() || isdefined(self.noruntwitch) && self.noruntwitch || isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
	{
		return animscripts\utility::getmoveanim("straight");
	}

	var_00 = animscripts\utility::getmoveanim("straight_twitch");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return animscripts\utility::getmoveanim("straight");
	}

	var_01 = animscripts\utility::getrandomintfromseed(self.a.runloopcount,4);
	if(var_01 == 0)
	{
		var_01 = animscripts\utility::getrandomintfromseed(self.a.runloopcount,var_00.size);
		return var_00[var_01];
	}

	return animscripts\utility::getmoveanim("straight");
}

//Function Number: 3
getcrouchrunanim()
{
	if(!isdefined(self.a.moveanimset))
	{
		if(animscripts\utility::usingsmg())
		{
			return animscripts\utility::lookupanim("smg_crouch_run","crouch");
		}
		else
		{
			return animscripts\utility::lookupanim("run","crouch");
		}
	}

	return animscripts\utility::getmoveanim("crouch");
}

//Function Number: 4
pronecrawl()
{
	self.a.movement = "run";
	self setflaggedanimknob("runanim",animscripts\utility::getmoveanim("prone"),1,0.3,self.moveplaybackrate);
	run_clearfacialanim();
	animscripts\notetracks::donotetracksfortime(0.25,"runanim");
}

//Function Number: 5
initrunngun()
{
	if(!isdefined(self.runngun))
	{
		self notify("stop_move_anim_update");
		self.update_move_anim_type = undefined;
		self clearanim(%combatrun_backward,0.2);
		self clearanim(%combatrun_right,0.2);
		self clearanim(%combatrun_left,0.2);
		self clearanim(%w_aim_2,0.2);
		self clearanim(%w_aim_4,0.2);
		self clearanim(%w_aim_6,0.2);
		self clearanim(%w_aim_8,0.2);
		self.runngun = 1;
	}
}

//Function Number: 6
stoprunngun()
{
	if(isdefined(self.runngun))
	{
		self clearanim(%run_n_gun,0.2);
		self.runngun = undefined;
	}

	return 0;
}

//Function Number: 7
runngun(param_00)
{
	if(param_00)
	{
		var_01 = getpredictedyawtoenemy(0.2);
		var_02 = var_01 < 0;
	}
	else
	{
		var_01 = 0;
		var_02 = self.runngunweight < 0;
	}

	var_03 = 1 - var_02;
	var_04 = self.maxrunngunangle;
	var_05 = self.runnguntransitionpoint;
	var_06 = self.runngunincrement;
	if(!param_00 || squared(var_01) > var_04 * var_04)
	{
		self clearanim(%add_fire,0);
		if(squared(self.runngunweight) < var_06 * var_06)
		{
			self.runngunweight = 0;
			self.runngun = undefined;
			return 0;
		}
		else if(self.runngunweight > 0)
		{
			self.runngunweight = self.runngunweight - var_06;
		}
		else
		{
			self.runngunweight = self.runngunweight + var_06;
		}
	}
	else
	{
		var_07 = var_01 / var_04;
		var_08 = var_07 - self.runngunweight;
		if(abs(var_08) < var_05 * 0.7)
		{
			self.runngunweight = var_07;
		}
		else if(var_08 > 0)
		{
			self.runngunweight = self.runngunweight + var_06;
		}
		else
		{
			self.runngunweight = self.runngunweight - var_06;
		}
	}

	initrunngun();
	var_09 = abs(self.runngunweight);
	var_0A = animscripts\utility::lookupanimarray("run_n_gun");
	if(var_09 > var_05)
	{
		var_0B = var_09 - var_05 / var_05;
		var_0B = clamp(var_0B,0,1);
		self clearanim(var_0A["F"],0.2);
		self setanimlimited(var_0A["L"],1 - var_0B * var_02,0.2);
		self setanimlimited(var_0A["R"],1 - var_0B * var_03,0.2);
		self setanimlimited(var_0A["LB"],var_0B * var_02,0.2);
		self setanimlimited(var_0A["RB"],var_0B * var_03,0.2);
	}
	else
	{
		var_0B = clamp(var_0A / var_06,0,1);
		self setanimlimited(var_0A["F"],1 - var_0B,0.2);
		self setanimlimited(var_0A["L"],var_0B * var_02,0.2);
		self setanimlimited(var_0A["R"],var_0B * var_03,0.2);
		if(var_05 < 1)
		{
			self clearanim(var_0A["LB"],0.2);
			self clearanim(var_0A["RB"],0.2);
		}
	}

	self setflaggedanimknob("runanim",%run_n_gun,1,0.3,0.8);
	run_playfacialanim(undefined);
	self.a.allowedpartialreloadontheruntime = gettime() + 500;
	if(param_00 && isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	return 1;
}

//Function Number: 8
runngun_backward()
{
	initrunngun();
	var_00 = animscripts\utility::lookupanim("run_n_gun","move_back");
	self setflaggedanimknob("runanim",var_00,1,0.3,0.8);
	run_playfacialanim(var_00);
	if(isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	animscripts\notetracks::donotetracksfortime(0.2,"runanim");
	self clearanim(var_00,0.2);
}

//Function Number: 9
reacttobulletsinterruptcheck()
{
	self endon("killanimscript");
	for(;;)
	{
		wait(0.2);
		if(!isdefined(self.reactingtobullet))
		{
			break;
		}

		if(!isdefined(self.pathgoalpos) || distancesquared(self.pathgoalpos,self.origin) < squared(80))
		{
			endrunningreacttobullets();
			self notify("interrupt_react_to_bullet");
			break;
		}
	}
}

//Function Number: 10
endrunningreacttobullets()
{
	self orientmode("face default");
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
}

//Function Number: 11
runningreacttobullets()
{
	if(isdefined(self.mech) && self.mech)
	{
		return;
	}

	endfaceenemyaimtracking();
	self endon("interrupt_react_to_bullet");
	self.reactingtobullet = 1;
	self orientmode("face motion");
	var_00 = animscripts\utility::lookupanimarray("running_react_to_bullets");
	var_01 = randomint(var_00.size);
	if(var_01 == level.lastrunningreactanim)
	{
		var_01 = var_01 + 1 % var_00.size;
	}

	anim.lastrunningreactanim = var_01;
	var_02 = var_00[var_01];
	self setflaggedanimknobrestart("reactanim",var_02,1,0.5,self.moveplaybackrate);
	run_playfacialanim(var_02);
	thread reacttobulletsinterruptcheck();
	animscripts\shared::donotetracks("reactanim");
	endrunningreacttobullets();
}

//Function Number: 12
customrunningreacttobullets()
{
	endfaceenemyaimtracking();
	self.reactingtobullet = 1;
	self orientmode("face motion");
	var_00 = randomint(self.run_overridebulletreact.size);
	var_01 = self.run_overridebulletreact[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5,self.moveplaybackrate);
	run_playfacialanim(var_01);
	thread reacttobulletsinterruptcheck();
	animscripts\shared::donotetracks("reactanim");
	endrunningreacttobullets();
}

//Function Number: 13
getsprintanim()
{
	var_00 = undefined;
	if(isdefined(self.grenade))
	{
		var_00 = animscripts\utility::getmoveanim("sprint_short");
	}

	if(!isdefined(var_00))
	{
		var_00 = animscripts\utility::getmoveanim("sprint");
	}

	return var_00;
}

//Function Number: 14
shouldsprint()
{
	if(isdefined(self.sprint))
	{
		return 1;
	}

	if(isdefined(self.grenade) && isdefined(self.enemy) && self.frontshieldanglecos == 1)
	{
		return distancesquared(self.origin,self.enemy.origin) > 90000;
	}

	return 0;
}

//Function Number: 15
shouldsprintforvariation()
{
	if(isdefined(self.neversprintforvariation))
	{
		return 0;
	}

	if(!self.facemotion || self.stairsstate != "none")
	{
		return 0;
	}

	var_00 = gettime();
	if(isdefined(self.dangersprinttime))
	{
		if(var_00 < self.dangersprinttime)
		{
			return 1;
		}

		if(var_00 - self.dangersprinttime < 6000)
		{
			return 0;
		}
	}

	if(!isdefined(self.enemy) || !issentient(self.enemy))
	{
		return 0;
	}

	if(randomint(100) < 25 && self lastknowntime(self.enemy) + 2000 > var_00)
	{
		self.dangersprinttime = var_00 + 2000 + randomint(1000);
		return 1;
	}

	return 0;
}

//Function Number: 16
getmoveplaybackrate()
{
	var_00 = self.moveplaybackrate;
	if(self.lookaheadhitsstairs && self.stairsstate == "none" && self.lookaheaddist < 300)
	{
		var_00 = var_00 * 0.75;
	}

	return var_00;
}

//Function Number: 17
standrun_combatnormal()
{
	var_00 = getmoveplaybackrate();
	self setanimknob(%combatrun,1,0.5,var_00);
	var_01 = 0;
	var_02 = isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100;
	if(var_02 && randomfloat(1) < self.a.reacttobulletchance)
	{
		stoprunngun();
		setshootwhilemoving(0);
		runningreacttobullets();
		return;
	}

	if(shouldsprint())
	{
		var_03 = getsprintanim();
		self setflaggedanimknob("runanim",var_03,1,0.5,self.moveplaybackrate);
		run_playfacialanim(var_03);
		setshootwhilemoving(0);
		var_01 = 1;
	}
	else if(isdefined(self.enemy) && animscripts\move::mayshootwhilemoving())
	{
		setshootwhilemoving(1);
		if(!self.facemotion)
		{
			thread faceenemyaimtracking();
		}
		else if(self.shootstyle != "none" && !isdefined(self.norunngun))
		{
			endfaceenemyaimtracking();
			if(canshootwhilerunningforward())
			{
				var_01 = runngun(1);
			}
			else if(canshootwhilerunningbackward())
			{
				runngun_backward();
				return;
			}
		}
		else if(isdefined(self.runngunweight) && self.runngunweight != 0)
		{
			var_01 = runngun(0);
		}
	}
	else if(isdefined(self.runngunweight) && self.runngunweight != 0)
	{
		setshootwhilemoving(0);
		var_01 = runngun(0);
	}
	else
	{
		setshootwhilemoving(0);
	}

	if(!var_01)
	{
		stoprunngun();
		if(var_02 && self.a.reacttobulletchance != 0)
		{
			runningreacttobullets();
			return;
		}

		if(move_checkstairstransition())
		{
			return;
		}

		self clearanim(%stair_transitions,0.1);
		if(shouldsprintforvariation())
		{
			var_04 = animscripts\utility::getmoveanim("sprint_short");
		}
		else
		{
			var_04 = getrunanim();
		}

		self setflaggedanimknoblimited("runanim",var_04,1,0.1,self.moveplaybackrate,1);
		run_playfacialanim(var_04);
		setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"),self.sidesteprate);
		thread setcombatstandmoveanimweights("run");
	}

	animscripts\notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 18
getstairstransitionanim(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "none";
	}

	if(param_00 == param_01)
	{
		return undefined;
	}

	if(param_00 == "up")
	{
		return animscripts\utility::getmoveanim("stairs_up_out");
	}

	if(param_00 == "down")
	{
		return animscripts\utility::getmoveanim("stairs_down_out");
	}

	if(param_01 == "up")
	{
		return animscripts\utility::getmoveanim("stairs_up_in");
	}

	if(param_01 == "down")
	{
		return animscripts\utility::getmoveanim("stairs_down_in");
	}
}

//Function Number: 19
faceenemyaimtracking()
{
	if(isdefined(self.aim_while_moving_thread))
	{
		return;
	}

	self.aim_while_moving_thread = 1;
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	self setdefaultaimlimits();
	var_00 = undefined;
	if(isdefined(self.combatstandanims) && isdefined(self.combatstandanims["walk_aims"]))
	{
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_2"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_4"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_6"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_8"]);
	}
	else
	{
		var_01 = "walk";
		if(animscripts\utility::shouldcqb() && isdefined(animscripts\utility::lookupanim("cqb","aim_2")))
		{
			var_01 = "cqb";
		}

		var_02 = animscripts\utility::lookupanimarray(var_01);
		self setanimlimited(var_02["aim_2"]);
		self setanimlimited(var_02["aim_4"]);
		self setanimlimited(var_02["aim_6"]);
		self setanimlimited(var_02["aim_8"]);
		if(isdefined(var_02["aim_5"]))
		{
			self setanimlimited(var_02["aim_5"]);
			var_00 = %w_aim_5;
		}
	}

	animscripts\track::trackloop(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8,var_00);
}

//Function Number: 20
endfaceenemyaimtracking()
{
	self.aim_while_moving_thread = undefined;
	self notify("end_face_enemy_tracking");
}

//Function Number: 21
setshootwhilemoving(param_00)
{
	var_01 = isdefined(self.bshootwhilemoving);
	if(param_00)
	{
		self.bshootwhilemoving = param_00;
		if(!var_01)
		{
			thread rundecidewhatandhowtoshoot();
			thread runshootwhilemoving();
			return;
		}

		return;
	}

	self.bshootwhilemoving = undefined;
	if(var_01)
	{
		self notify("end_shoot_while_moving");
		self notify("end_face_enemy_tracking");
		self.shoot_while_moving_thread = undefined;
		self.aim_while_moving_thread = undefined;
		self.runngun = undefined;
	}
}

//Function Number: 22
rundecidewhatandhowtoshoot()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
}

//Function Number: 23
runshootwhilemoving()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts\move::shootwhilemoving();
}

//Function Number: 24
aimedsomewhatatenemy()
{
	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		var_00 = animscripts\combat_utility::get_last_known_shoot_pos(self.enemy);
	}
	else
	{
		var_00 = self.enemy getshootatpos();
	}

	var_01 = self getmuzzleangle();
	var_02 = vectortoangles(var_00 - self getmuzzlepos());
	if(animscripts\utility::absangleclamp180(var_01[1] - var_02[1]) > 15)
	{
		return 0;
	}

	return animscripts\utility::absangleclamp180(var_01[0] - var_02[0]) <= 20;
}

//Function Number: 25
canshootwhilerunningforward()
{
	if((!isdefined(self.runngunweight) || self.runngunweight == 0) && abs(self getmotionangle()) > self.maxrunngunangle)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
canshootwhilerunningbackward()
{
	if(180 - abs(self getmotionangle()) >= 45)
	{
		return 0;
	}

	var_00 = getpredictedyawtoenemy(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
canshootwhilerunning()
{
	return animscripts\move::mayshootwhilemoving() && isdefined(self.enemy) && canshootwhilerunningforward() || canshootwhilerunningbackward();
}

//Function Number: 28
getpredictedyawtoenemy(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self getmotionangle();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.velocity) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.enemy.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 29
move_checkstairstransition()
{
	var_00 = 0;
	var_01 = undefined;
	if(self.stairsstate == "none" && self.lookaheadhitsstairs)
	{
		if(animscripts\utility::shouldcqb())
		{
			var_02 = 32;
		}
		else
		{
			var_02 = 48;
		}

		var_03 = self.origin + (0,0,6);
		var_04 = vectornormalize((self.lookaheaddir[0],self.lookaheaddir[1],0));
		var_05 = var_03 + var_02 * var_04;
		var_06 = self aiphysicstrace(var_03,var_05,15,48,1,1);
		if(var_06["fraction"] < 1)
		{
			if(!isdefined(var_06["stairs"]))
			{
				return 0;
			}

			var_01 = getstairstransitionanim("none","up");
		}
		else
		{
			var_07 = 18;
			var_08 = var_05 + (0,0,var_07);
			var_09 = var_05 - (0,0,var_07);
			var_06 = self aiphysicstrace(var_08,var_09,15,48,1,1);
			if(var_06["fraction"] >= 1)
			{
				return 0;
			}

			if(!isdefined(var_06["stairs"]))
			{
				return 0;
			}

			var_01 = getstairstransitionanim("none","down");
		}
	}
	else if(self.stairsstate == "up")
	{
		var_02 = 24;
		var_07 = 18;
		var_05 = self.origin + var_02 * self.lookaheaddir;
		var_08 = var_05 + (0,0,var_07);
		var_09 = var_05 - (0,0,var_07);
		var_06 = self aiphysicstrace(var_08,var_09,15,48,1,1);
		if(var_06["fraction"] <= 0 || var_06["fraction"] >= 1)
		{
			return 0;
		}

		if(isdefined(var_06["stairs"]))
		{
			return 0;
		}

		var_01 = getstairstransitionanim("up","none");
	}
	else if(self.stairsstate == "down" && !self.lookaheadhitsstairs)
	{
		var_02 = 24;
		var_07 = 18;
		var_05 = self.origin + var_02 * self.lookaheaddir;
		var_08 = var_05 + (0,0,var_07);
		var_09 = var_05 - (0,0,var_07);
		var_06 = self aiphysicstrace(var_08,var_09,15,48,1,1);
		if(var_06["fraction"] <= 0 || var_06["fraction"] >= 1)
		{
			return 0;
		}

		if(isdefined(var_06["stairs"]))
		{
			return 0;
		}

		var_01 = getstairstransitionanim("down","none");
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	self notify("stop_move_anim_update");
	self.update_move_anim_type = undefined;
	self setflaggedanimknoballrestart("runanim",var_01,%body,1,0.1,self.moveplaybackrate);
	run_playfacialanim(var_01);
	animscripts\shared::donotetracks("runanim");
	return 1;
}

//Function Number: 30
standrun_noncombatnormal()
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	var_00 = getmoveplaybackrate();
	if(move_checkstairstransition())
	{
		return;
	}

	self clearanim(%stair_transitions,0.1);
	self setanimknoball(%combatrun,%body,1,0.2,var_00);
	if(shouldsprint())
	{
		var_01 = getsprintanim();
	}
	else
	{
		var_01 = getrunanim();
	}

	if(self.stairsstate == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	self setflaggedanimknob("runanim",var_01,1,var_02,self.moveplaybackrate,1);
	run_playfacialanim(var_01);
	setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	var_03 = 0;
	if(self.leanamount > 0 && self.leanamount < 0.998)
	{
		var_03 = 1;
	}
	else if(self.leanamount < 0 && self.leanamount > -0.998)
	{
		var_03 = -1;
	}

	var_04 = max(0.2,var_02);
	animscripts\notetracks::donotetracksfortime(var_04,"runanim");
}

//Function Number: 31
crouchrun_runoverride()
{
	self endon("movemode");
	self setflaggedanimknoball("runanim",self.crouchrun_combatanim,%body,1,0.4,self.moveplaybackrate);
	run_playfacialanim(self.crouchrun_combatanim);
	animscripts\shared::donotetracks("runanim");
}

//Function Number: 32
crouchrun_runnormal()
{
	self endon("movemode");
	var_00 = getcrouchrunanim();
	self setanimknob(var_00,1,0.4);
	var_01 = "run";
	if(animscripts\utility::usingsmg())
	{
		var_01 = "smg_crouch_run";
	}

	thread updatemoveanimweights("crouchrun",var_00,animscripts\utility::lookupanim(var_01,"crouch_b"),animscripts\utility::lookupanim(var_01,"crouch_l"),animscripts\utility::lookupanim(var_01,"crouch_r"));
	self setflaggedanimknoball("runanim",%crouchrun,%body,1,0.2,self.moveplaybackrate);
	run_playfacialanim(undefined);
	animscripts\notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 33
standrun_checkreload()
{
	var_00 = isdefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
	var_00 = var_00 || isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536;
	if(var_00)
	{
		if(!animscripts\combat_utility::needtoreload(0))
		{
			return 0;
		}
	}
	else if(!animscripts\combat_utility::needtoreload(0.5))
	{
		return 0;
	}

	if(isdefined(self.grenade))
	{
		return 0;
	}

	if(!self.facemotion || self.stairsstate != "none")
	{
		return 0;
	}

	if(isdefined(self.dontshootwhilemoving) || isdefined(self.norunreload))
	{
		return 0;
	}

	if(canshootwhilerunning() && !animscripts\combat_utility::needtoreload(0))
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 65536)
	{
		return 0;
	}

	var_01 = angleclamp180(self getmotionangle());
	if(abs(var_01) > 25)
	{
		return 0;
	}

	if(!animscripts\utility::usingriflelikeweapon())
	{
		return 0;
	}

	if(!runloopisnearbeginning())
	{
		return 0;
	}

	if(animscripts\utility::shouldcqb())
	{
		animscripts\cqb::cqb_reloadinternal();
	}
	else
	{
		standrun_reloadinternal();
	}

	self notify("abort_reload");
	self orientmode("face default");
	return 1;
}

//Function Number: 34
standrun_reloadinternal()
{
	self endon("movemode");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
	var_01 = animscripts\utility::lookupanim("run","reload");
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	self setflaggedanimknoballrestart(var_00,var_01,%body,1,0.25);
	run_playfacialanim(var_01);
	self.update_move_front_bias = 1;
	setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	animscripts\shared::donotetracks(var_00);
	self.update_move_front_bias = undefined;
}

//Function Number: 35
runloopisnearbeginning()
{
	var_00 = self getanimtime(%walk_and_run_loops);
	var_01 = getanimlength(animscripts\utility::lookupanim("run","straight")) / 3;
	var_00 = var_00 * 3;
	if(var_00 > 3)
	{
		var_00 = var_00 - 2;
	}
	else if(var_00 > 2)
	{
		var_00 = var_00 - 1;
	}

	if(var_00 < 0.15 / var_01)
	{
		return 1;
	}

	if(var_00 > 1 - 0.3 / var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
setmovenonforwardanims(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self setanimknoblimited(param_00,1,0.1,param_03,1);
	self setanimknoblimited(param_01,1,0.1,param_03,1);
	self setanimknoblimited(param_02,1,0.1,param_03,1);
}

//Function Number: 37
setcombatstandmoveanimweights(param_00)
{
	updatemoveanimweights(param_00,%combatrun_forward,%combatrun_backward,%combatrun_left,%combatrun_right);
}

//Function Number: 38
updatemoveanimweights(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.update_move_anim_type) && self.update_move_anim_type == param_00)
	{
		return;
	}

	self notify("stop_move_anim_update");
	self.update_move_anim_type = param_00;
	self.wasfacingmotion = undefined;
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("stop_move_anim_update");
	for(;;)
	{
		updaterunweightsonce(param_01,param_02,param_03,param_04);
		wait(0.05);
		waittillframeend;
	}
}

//Function Number: 39
updaterunweightsonce(param_00,param_01,param_02,param_03)
{
	if(self.facemotion && !animscripts\utility::shouldcqb() && !isdefined(self.update_move_front_bias) && !isdefined(self.mech) && self.mech)
	{
		if(!isdefined(self.wasfacingmotion))
		{
			self.wasfacingmotion = 1;
			var_04 = 0.2;
			if(isdefined(self.strafeblendtimes))
			{
				var_04 = self.strafeblendtimes;
			}

			self setanim(param_00,1,var_04,1,1);
			self setanim(param_01,0,var_04,1,1);
			self setanim(param_02,0,var_04,1,1);
			self setanim(param_03,0,var_04,1,1);
			return;
		}

		return;
	}

	self.wasfacingmotion = undefined;
	var_05 = animscripts\utility::quadrantanimweights(self getmotionangle());
	if(isdefined(self.update_move_front_bias))
	{
		var_05["back"] = 0;
		if(var_05["front"] < 0.2)
		{
			var_05["front"] = 0.2;
		}
	}

	var_04 = 0.2;
	if(isdefined(self.strafeblendtimes))
	{
		var_05 = self.strafeblendtimes;
	}

	var_06 = var_04["front"];
	if(var_06 < 0.001)
	{
		var_06 = 0.001;
	}

	self setanim(param_00,var_06,var_05,1,1);
	self setanim(param_01,var_04["back"],var_05,1,1);
	self setanim(param_02,var_04["left"],var_05,1,1);
	self setanim(param_03,var_04["right"],var_05,1,1);
}

//Function Number: 40
standrun_checkchangeweapon()
{
	var_00 = isdefined(self.wantshotgun) && self.wantshotgun;
	var_01 = animscripts\utility::isshotgun(self.weapon);
	if(var_00 == var_01)
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 65536)
	{
		return 0;
	}

	if(animscripts\utility::usingsidearm())
	{
		return 0;
	}

	if(self.weapon == self.primaryweapon)
	{
		if(!var_00)
		{
			return 0;
		}

		if(animscripts\utility::isshotgun(self.secondaryweapon))
		{
			return 0;
		}
	}
	else
	{
		if(var_00)
		{
			return 0;
		}

		if(animscripts\utility::isshotgun(self.primaryweapon))
		{
			return 0;
		}
	}

	var_02 = angleclamp180(self getmotionangle());
	if(abs(var_02) > 25)
	{
		return 0;
	}

	if(!runloopisnearbeginning())
	{
		return 0;
	}

	if(var_00)
	{
		shotgunswitchstandruninternal("shotgunPullout",animscripts\utility::lookupanim("cqb","shotgun_pullout"),"gun_2_chest","none",self.secondaryweapon,"shotgun_pickup");
	}
	else
	{
		shotgunswitchstandruninternal("shotgunPutaway",animscripts\utility::lookupanim("cqb","shotgun_putaway"),"gun_2_back","back",self.primaryweapon,"shotgun_pickup");
	}

	self notify("switchEnded");
	return 1;
}

//Function Number: 41
shotgunswitchstandruninternal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("movemode");
	self setflaggedanimknoballrestart(param_00,param_01,%body,1,0.25);
	run_playfacialanim(param_01);
	self.update_move_front_bias = 1;
	setmovenonforwardanims(animscripts\utility::getmoveanim("move_b"),animscripts\utility::getmoveanim("move_l"),animscripts\utility::getmoveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	thread watchshotgunswitchnotetracks(param_00,param_02,param_03,param_04,param_05);
	animscripts\notetracks::donotetracksfortimeintercept(getanimlength(param_01) - 0.25,param_00,::interceptnotetracksforweaponswitch);
	self.update_move_front_bias = undefined;
}

//Function Number: 42
interceptnotetracksforweaponswitch(param_00)
{
	if(param_00 == "gun_2_chest" || param_00 == "gun_2_back")
	{
		return 1;
	}
}

//Function Number: 43
watchshotgunswitchnotetracks(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("movemode");
	self endon("switchEnded");
	self waittillmatch(param_01,param_00);
	animscripts\shared::placeweaponon(self.weapon,param_02);
	thread shotgunswitchfinish(param_03);
	self waittillmatch(param_04,param_00);
	self notify("complete_weapon_switch");
}

//Function Number: 44
shotgunswitchfinish(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any("killanimscript","movemode","switchEnded","complete_weapon_switch");
	self.lastweapon = self.weapon;
	animscripts\shared::placeweaponon(param_00,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 45
run_playfacialanim(param_00)
{
	self.facialidx = animscripts\face::playfacialanim(param_00,"run",self.facialidx);
}

//Function Number: 46
run_clearfacialanim()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}