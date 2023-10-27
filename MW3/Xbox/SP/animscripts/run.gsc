/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\run.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 43
 * Decompile Time: 743 ms
 * Timestamp: 10/27/2023 2:30:42 AM
*******************************************************************/

//Function Number: 1
moverun()
{
	var_00 = [[ self.chooseposefunc ]]("stand");
	switch(var_00)
	{
		case "stand":
			if(animscripts/setposemovement::beginstandrun())
			{
				return;
			}
	
			if(isdefined(self.run_overrideanim))
			{
				animscripts/move::movestandmoveoverride(self.run_overrideanim,self.var_BA8);
				return;
			}
	
			if(changeweaponstandrun())
			{
				return;
			}
	
			if(reloadstandrun())
			{
				return;
			}
	
			if(animscripts/utility::isincombat())
			{
				movestandcombatnormal();
			}
			else
			{
				movestandnoncombatnormal();
			}
			break;

		case "crouch":
			if(animscripts/setposemovement::begincrouchrun())
			{
				return;
			}
	
			if(isdefined(self.crouchrun_combatanim))
			{
				movecrouchrunoverride();
			}
			else
			{
				movecrouchrunnormal();
			}
			break;

		default:
			if(animscripts/setposemovement::beginpronerun())
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
		return %run_lowready_f;
	}

	if(!self.facemotion)
	{
		if(self.stairsstate == "none" || abs(self getmotionangle()) > 45)
		{
			return animscripts/utility::moveanim("move_f");
		}
	}

	if(self.stairsstate == "up")
	{
		return animscripts/utility::moveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts/utility::moveanim("stairs_down");
	}

	return animscripts/utility::moveanim("straight");
}

//Function Number: 3
getcrouchrunanim()
{
	if(!isdefined(self.a.moveanimset))
	{
		return %crouch_fastwalk_f;
	}

	return animscripts/utility::moveanim("crouch");
}

//Function Number: 4
pronecrawl()
{
	self.a.movement = "run";
	self setflaggedanimknob("runanim",animscripts/utility::moveanim("prone"),1,0.3,self.moveplaybackrate);
	animscripts/notetracks::donotetracksfortime(0.25,"runanim");
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
func_0BB5()
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
		var_01 = func_0BD7(0.2);
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
	if(var_09 > var_05)
	{
		var_0A = var_09 - var_05 / var_05;
		var_0A = clamp(var_0A,0,1);
		self clearanim(self.runngunanims["F"],0.2);
		self setanimlimited(self.runngunanims["L"],1 - var_0A * var_02,0.2);
		self setanimlimited(self.runngunanims["R"],1 - var_0A * var_03,0.2);
		self setanimlimited(self.runngunanims["LB"],var_0A * var_02,0.2);
		self setanimlimited(self.runngunanims["RB"],var_0A * var_03,0.2);
	}
	else
	{
		var_0A = clamp(var_0A / var_06,0,1);
		self setanimlimited(self.runngunanims["F"],1 - var_0A,0.2);
		self setanimlimited(self.runngunanims["L"],var_0A * var_02,0.2);
		self setanimlimited(self.runngunanims["R"],var_0A * var_03,0.2);
		if(var_05 < 1)
		{
			self clearanim(self.runngunanims["LB"],0.2);
			self clearanim(self.runngunanims["RB"],0.2);
		}
	}

	self setflaggedanimknob("runanim",%run_n_gun,1,0.3,0.8);
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
	self setflaggedanimknob("runanim",%combatwalk_b,1,0.3,0.8);
	if(isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
	thread stopshootwhilemovingthreads();
	self clearanim(%combatwalk_b,0.2);
}

//Function Number: 9
reacttobulletsinterruptcheck()
{
	self endon("killanimscript");
	for(;;)
	{
		wait 0.2;
		if(!isdefined(self.reactingtobullet))
		{
			break;
		}

		if(!isdefined(self.pathgoalpos) || distancesquared(self.pathgoalpos,self.origin) < squared(80))
		{
			func_0BBB();
			self notify("interrupt_react_to_bullet");
			break;
		}
	}
}

//Function Number: 10
func_0BBB()
{
	self orientmode("face default");
	self.reactingtobullet = undefined;
	self.requestreacttobullet = undefined;
}

//Function Number: 11
runningreacttobullets()
{
	self.var_BBD = undefined;
	self notify("end_face_enemy_tracking");
	self endon("interrupt_react_to_bullet");
	self.reactingtobullet = 1;
	self orientmode("face motion");
	var_00 = randomint(level.runningreacttobullets.size);
	if(var_00 == level.lastrunningreactanim)
	{
		var_00 = var_00 + 1 % level.runningreacttobullets.size;
	}

	anim.lastrunningreactanim = var_00;
	var_01 = level.runningreacttobullets[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5);
	thread reacttobulletsinterruptcheck();
	animscripts/shared::donotetracks("reactanim");
	func_0BBB();
}

//Function Number: 12
customrunningreacttobullets()
{
	self.var_BBD = undefined;
	self notify("end_face_enemy_tracking");
	self.reactingtobullet = 1;
	self orientmode("face motion");
	var_00 = randomint(self.run_overridebulletreact.size);
	var_01 = self.run_overridebulletreact[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5);
	thread reacttobulletsinterruptcheck();
	animscripts/shared::donotetracks("reactanim");
	func_0BBB();
}

//Function Number: 13
getsprintanim()
{
	var_00 = undefined;
	if(isdefined(self.grenade))
	{
		var_00 = animscripts/utility::moveanim("sprint_short");
	}

	if(!isdefined(var_00))
	{
		var_00 = animscripts/utility::moveanim("sprint");
	}

	return var_00;
}

//Function Number: 14
func_0BC1()
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
movestandcombatnormal()
{
	var_00 = getmoveplaybackrate();
	self setanimknob(%combatrun,1,0.5,var_00);
	var_01 = 0;
	if(isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && randomfloat(1) < self.a.reacttobulletchance)
	{
		func_0BB5();
		runningreacttobullets();
		return;
	}

	if(func_0BC1())
	{
		self setflaggedanimknob("runanim",getsprintanim(),1,0.5);
		var_01 = 1;
	}
	else if(isdefined(self.enemy) && animscripts/move::mayshootwhilemoving())
	{
		runshootwhilemovingthreads();
		if(!self.facemotion)
		{
			thread faceenemyaimtracking();
		}
		else if(self.shootstyle != "none" && !isdefined(self.norunngun))
		{
			self notify("end_face_enemy_tracking");
			self.var_BBD = undefined;
			if(canshootwhilerunningforward())
			{
				var_01 = runngun(1);
			}
			else if(func_0BD5())
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
		var_01 = runngun(0);
	}

	if(!var_01)
	{
		func_0BB5();
		if(isdefined(self.requestreacttobullet) && gettime() - self.requestreacttobullet < 100 && self.a.reacttobulletchance != 0)
		{
			runningreacttobullets();
			return;
		}

		if(shouldsprintforvariation())
		{
			var_02 = animscripts/utility::moveanim("sprint_short");
		}
		else
		{
			var_02 = getrunanim();
		}

		self setflaggedanimknoblimited("runanim",var_02,1,0.1,1,1);
		setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"),self.sidesteprate);
		thread setcombatstandmoveanimweights("run");
	}

	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
	thread stopshootwhilemovingthreads();
}

//Function Number: 18
faceenemyaimtracking()
{
	self notify("want_aim_while_moving");
	if(isdefined(self.var_BBD))
	{
		return;
	}

	self.var_BBD = 1;
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	self setdefaultaimlimits();
	if(!isdefined(self.combatstandanims) || !isdefined(self.combatstandanims["walk_aims"]))
	{
		self setanimlimited(%walk_aim_2);
		self setanimlimited(%walk_aim_4);
		self setanimlimited(%walk_aim_6);
		self setanimlimited(%walk_aim_8);
	}
	else
	{
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_2"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_4"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_6"]);
		self setanimlimited(self.combatstandanims["walk_aims"]["walk_aim_8"]);
	}

	animscripts/track::trackloop(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8);
}

//Function Number: 19
endfaceenemyaimtracking()
{
	self.var_BBD = undefined;
	self notify("end_face_enemy_tracking");
}

//Function Number: 20
runshootwhilemovingthreads()
{
	self notify("want_shoot_while_moving");
	if(isdefined(self.shoot_while_moving_thread))
	{
		return;
	}

	self.shoot_while_moving_thread = 1;
	thread rundecidewhatandhowtoshoot();
	thread runshootwhilemoving();
}

//Function Number: 21
stopshootwhilemovingthreads()
{
	self endon("killanimscript");
	self endon("want_shoot_while_moving");
	self endon("want_aim_while_moving");
	wait 0.05;
	self notify("end_shoot_while_moving");
	self notify("end_face_enemy_tracking");
	self.shoot_while_moving_thread = undefined;
	self.var_BBD = undefined;
	self.runngun = undefined;
}

//Function Number: 22
rundecidewhatandhowtoshoot()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/shoot_behavior::decidewhatandhowtoshoot("normal");
}

//Function Number: 23
runshootwhilemoving()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/move::shootwhilemoving();
}

//Function Number: 24
aimedsomewhatatenemy()
{
	var_00 = self getmuzzleangle();
	var_01 = vectortoangles(self.enemy getshootatpos() - self getmuzzlepos());
	if(animscripts/utility::absangleclamp180(var_00[1] - var_01[1]) > 15)
	{
		return 0;
	}

	return animscripts/utility::absangleclamp180(var_00[0] - var_01[0]) <= 20;
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
func_0BD5()
{
	if(180 - abs(self getmotionangle()) >= 45)
	{
		return 0;
	}

	var_00 = func_0BD7(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_0BD6()
{
	return animscripts/move::mayshootwhilemoving() && isdefined(self.enemy) && canshootwhilerunningforward() || func_0BD5();
}

//Function Number: 28
func_0BD7(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self getmotionangle();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.velocity) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.enemy.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 29
movestandnoncombatnormal()
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	var_00 = getmoveplaybackrate();
	self setanimknoball(%combatrun,%body,1,0.2,var_00);
	if(func_0BC1())
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

	self setflaggedanimknob("runanim",var_01,1,var_02,1,1);
	setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 30
movecrouchrunoverride()
{
	self endon("movemode");
	self setflaggedanimknoball("runanim",self.crouchrun_combatanim,%body,1,0.4,self.moveplaybackrate);
	animscripts/shared::donotetracks("runanim");
}

//Function Number: 31
movecrouchrunnormal()
{
	self endon("movemode");
	var_00 = getcrouchrunanim();
	self setanimknob(var_00,1,0.4);
	thread updatemoveanimweights("crouchrun",var_00,%crouch_fastwalk_b,%crouch_fastwalk_l,%crouch_fastwalk_r);
	self setflaggedanimknoball("runanim",%crouchrun,%body,1,0.2,self.moveplaybackrate);
	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 32
reloadstandrun()
{
	var_00 = isdefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
	var_00 = var_00 || isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536;
	if(var_00)
	{
		if(!animscripts/combat_utility::needtoreload(0))
		{
			return 0;
		}
	}
	else if(!animscripts/combat_utility::needtoreload(0.5))
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

	if(func_0BD6() && !animscripts/combat_utility::needtoreload(0))
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

	if(!animscripts/utility::usingriflelikeweapon())
	{
		return 0;
	}

	if(!runloopisnearbeginning())
	{
		return 0;
	}

	reloadstandruninternal();
	self notify("abort_reload");
	self orientmode("face default");
	return 1;
}

//Function Number: 33
reloadstandruninternal()
{
	self endon("movemode");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts/combat_utility::getuniqueflagnameindex();
	self setflaggedanimknoballrestart(var_00,%run_lowready_reload,%body,1,0.25);
	self.var_BE0 = 1;
	setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	animscripts/shared::donotetracks(var_00);
	self.var_BE0 = undefined;
}

//Function Number: 34
runloopisnearbeginning()
{
	var_00 = self getanimtime(%walk_and_run_loops);
	var_01 = getanimlength(%run_lowready_f) / 3;
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

//Function Number: 35
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

//Function Number: 36
setcombatstandmoveanimweights(param_00)
{
	updatemoveanimweights(param_00,%combatrun_forward,%combatrun_backward,%combatrun_left,%combatrun_right);
}

//Function Number: 37
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
		wait 0.05;
		waittillframeend;
	}
}

//Function Number: 38
updaterunweightsonce(param_00,param_01,param_02,param_03)
{
	if(self.facemotion && !animscripts/utility::shouldcqb() && !isdefined(self.var_BE0))
	{
		if(!isdefined(self.wasfacingmotion))
		{
			self.wasfacingmotion = 1;
			self setanim(param_00,1,0.2,1,1);
			self setanim(param_01,0,0.2,1,1);
			self setanim(param_02,0,0.2,1,1);
			self setanim(param_03,0,0.2,1,1);
			return;
		}

		return;
	}

	self.wasfacingmotion = undefined;
	var_04 = animscripts/utility::quadrantanimweights(self getmotionangle());
	if(isdefined(self.var_BE0))
	{
		if(var_41["front"] < 0.2)
		{
		}
	}

	self setanim(param_01,var_41["front"],0.2,1,1);
	self setanim(param_02,var_41["back"],0.2,1,1);
	self setanim(param_03,var_41["left"],0.2,1,1);
	self setanim(var_04,var_41["right"],0.2,1,1);
}

//Function Number: 39
changeweaponstandrun()
{
	var_00 = isdefined(self.wantshotgun) && self.wantshotgun;
	var_01 = animscripts/utility::isshotgun(self.weapon);
	if(var_00 == var_01)
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 65536)
	{
		return 0;
	}

	if(animscripts/utility::usingsidearm())
	{
		return 0;
	}

	if(self.weapon == self.primaryweapon)
	{
		if(!var_00)
		{
			return 0;
		}

		if(animscripts/utility::isshotgun(self.secondaryweapon))
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

		if(animscripts/utility::isshotgun(self.primaryweapon))
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
		shotgunswitchstandruninternal("shotgunPullout",%shotgun_cqbrun_pullout,"gun_2_chest","none",self.secondaryweapon,"shotgun_pickup");
	}
	else
	{
		shotgunswitchstandruninternal("shotgunPutaway",%shotgun_cqbrun_putaway,"gun_2_back","back",self.primaryweapon,"shotgun_pickup");
	}

	self notify("switchEnded");
	return 1;
}

//Function Number: 40
shotgunswitchstandruninternal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("movemode");
	self setflaggedanimknoballrestart(param_00,param_01,%body,1,0.25);
	self.var_BE0 = 1;
	setmovenonforwardanims(animscripts/utility::moveanim("move_b"),animscripts/utility::moveanim("move_l"),animscripts/utility::moveanim("move_r"));
	thread setcombatstandmoveanimweights("run");
	thread func_0BEE(param_00,param_02,param_03,param_04,param_05);
	animscripts/notetracks::donotetracksfortimeintercept(getanimlength(param_01) - 0.25,param_00,::func_0BED);
	self.var_BE0 = undefined;
}

//Function Number: 41
func_0BED(param_00)
{
	if(param_00 == "gun_2_chest" || param_00 == "gun_2_back")
	{
		return 1;
	}
}

//Function Number: 42
func_0BEE(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("movemode");
	self endon("switchEnded");
	self waittillmatch(param_01,param_00);
	animscripts/shared::placeweaponon(self.weapon,param_02);
	thread func_0BEF(param_03);
	self waittillmatch(param_04,param_00);
	self notify("complete_weapon_switch");
}

//Function Number: 43
func_0BEF(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any("killanimscript","movemode","switchEnded","complete_weapon_switch");
	self.lastweapon = self.weapon;
	animscripts/shared::placeweaponon(param_00,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
}