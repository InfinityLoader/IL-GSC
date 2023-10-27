/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\run.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 785 ms
 * Timestamp: 10/27/2023 1:24:20 AM
*******************************************************************/

//Function Number: 1
moverun()
{
	var_00 = [[ self.chooseposefunc ]]("stand");
	switch(var_00)
	{
		case "stand":
			if(animscripts/setposemovement::standrun_begin())
			{
				return;
			}
	
			if(isdefined(self.run_overrideanim))
			{
				animscripts/move::func_54A4(self.run_overrideanim,self.var_6969);
				return;
			}
	
			if(func_79D6())
			{
				return;
			}
	
			if(standrun_checkreload())
			{
				return;
			}
	
			animscripts/utility::func_86F6();
			if(animscripts/utility::func_48DE())
			{
				func_79D8();
			}
			else
			{
				func_79D9();
			}
			break;

		case "crouch":
			if(animscripts/setposemovement::func_2152())
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
			if(animscripts/setposemovement::func_6201())
			{
				return;
			}
	
			func_61FD();
			break;
	}
}

//Function Number: 2
func_3BDB()
{
	if(!isdefined(self.a.var_5473))
	{
		return animscripts/utility::lookupanim("run","straight");
	}

	if(!self.facemotion)
	{
		if(self.stairsstate == "none" || abs(self getmotionangle()) > 45)
		{
			return animscripts/utility::getmoveanim("move_f");
		}
	}

	if(self.stairsstate == "up")
	{
		return animscripts/utility::getmoveanim("stairs_up");
	}
	else if(self.stairsstate == "down")
	{
		return animscripts/utility::getmoveanim("stairs_down");
	}

	if(animscripts/utility::func_48DE() || isdefined(self.a.bdisablemovetwitch) && self.a.bdisablemovetwitch)
	{
		return animscripts/utility::getmoveanim("straight");
	}

	var_00 = animscripts/utility::getmoveanim("straight_twitch");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		return animscripts/utility::getmoveanim("straight");
	}

	var_01 = animscripts/utility::func_3BBB(self.a.var_698E,4);
	if(var_01 == 0)
	{
		var_01 = animscripts/utility::func_3BBB(self.a.var_698E,var_00.size);
		return var_00[var_01];
	}

	return animscripts/utility::getmoveanim("straight");
}

//Function Number: 3
func_3A69()
{
	if(!isdefined(self.a.var_5473))
	{
		return animscripts/utility::lookupanim("run","crouch");
	}

	return animscripts/utility::getmoveanim("crouch");
}

//Function Number: 4
func_61FD()
{
	self.a.var_5486 = "run";
	self setflaggedanimknob("runanim",animscripts/utility::getmoveanim("prone"),1,0.3,self.moveplaybackrate);
	func_693D();
	animscripts/notetracks::donotetracksfortime(0.25,"runanim");
}

//Function Number: 5
func_464B()
{
	if(!isdefined(self.var_6995))
	{
		self notify("stop_move_anim_update");
		self.var_868B = undefined;
		self clearanim(%combatrun_backward,0.2);
		self clearanim(%combatrun_right,0.2);
		self clearanim(%combatrun_left,0.2);
		self clearanim(%w_aim_2,0.2);
		self clearanim(%w_aim_4,0.2);
		self clearanim(%w_aim_6,0.2);
		self clearanim(%w_aim_8,0.2);
		self.var_6995 = 1;
	}
}

//Function Number: 6
func_7C6E()
{
	if(isdefined(self.var_6995))
	{
		self clearanim(%run_n_gun,0.2);
		self.var_6995 = undefined;
	}

	return 0;
}

//Function Number: 7
func_6995(param_00)
{
	if(param_00)
	{
		var_01 = func_3BA3(0.2);
		var_02 = var_01 < 0;
	}
	else
	{
		var_01 = 0;
		var_02 = self.var_6999 < 0;
	}

	var_03 = 1 - var_02;
	var_04 = self.var_5118;
	var_05 = self.var_6998;
	var_06 = self.var_6997;
	if(!param_00 || squared(var_01) > var_04 * var_04)
	{
		self clearanim(%add_fire,0);
		if(squared(self.var_6999) < var_06 * var_06)
		{
			self.var_6999 = 0;
			self.var_6995 = undefined;
			return 0;
		}
		else if(self.var_6999 > 0)
		{
			self.var_6999 = self.var_6999 - var_06;
		}
		else
		{
			self.var_6999 = self.var_6999 + var_06;
		}
	}
	else
	{
		var_07 = var_01 / var_04;
		var_08 = var_07 - self.var_6999;
		if(abs(var_08) < var_05 * 0.7)
		{
			self.var_6999 = var_07;
		}
		else if(var_08 > 0)
		{
			self.var_6999 = self.var_6999 + var_06;
		}
		else
		{
			self.var_6999 = self.var_6999 - var_06;
		}
	}

	func_464B();
	var_09 = abs(self.var_6999);
	var_0A = animscripts/utility::func_4F5D("run_n_gun");
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
	func_696E(undefined);
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
	func_464B();
	var_00 = animscripts/utility::lookupanim("run_n_gun","move_back");
	self setflaggedanimknob("runanim",var_00,1,0.3,0.8);
	func_696E(var_00);
	if(isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
	self clearanim(var_00,0.2);
}

//Function Number: 9
reacttobulletsinterruptcheck()
{
	self endon("killanimscript");
	for(;;)
	{
		wait(0.2);
		if(!isdefined(self.var_63B5))
		{
			break;
		}

		if(!isdefined(self.pathgoalpos) || distancesquared(self.pathgoalpos,self.origin) < squared(80))
		{
			func_2DEC();
			self notify("interrupt_react_to_bullet");
			break;
		}
	}
}

//Function Number: 10
func_2DEC()
{
	self orientmode("face default");
	self.var_63B5 = undefined;
	self.var_65CD = undefined;
}

//Function Number: 11
func_699B()
{
	func_2D51();
	self endon("interrupt_react_to_bullet");
	self.var_63B5 = 1;
	self orientmode("face motion");
	var_00 = animscripts/utility::func_4F5D("running_react_to_bullets");
	var_01 = randomint(var_00.size);
	if(var_01 == level.var_4C94)
	{
		var_01 = var_01 + 1 % var_00.size;
	}

	anim.var_4C94 = var_01;
	var_02 = var_00[var_01];
	self setflaggedanimknobrestart("reactanim",var_02,1,0.5,self.moveplaybackrate);
	func_696E(var_02);
	thread reacttobulletsinterruptcheck();
	animscripts/shared::func_2986("reactanim");
	func_2DEC();
}

//Function Number: 12
customrunningreacttobullets()
{
	func_2D51();
	self.var_63B5 = 1;
	self orientmode("face motion");
	var_00 = randomint(self.run_overridebulletreact.size);
	var_01 = self.run_overridebulletreact[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5,self.moveplaybackrate);
	func_696E(var_01);
	thread reacttobulletsinterruptcheck();
	animscripts/shared::func_2986("reactanim");
	func_2DEC();
}

//Function Number: 13
getsprintanim()
{
	var_00 = undefined;
	if(isdefined(self.grenade))
	{
		var_00 = animscripts/utility::getmoveanim("sprint_short");
	}

	if(!isdefined(var_00))
	{
		var_00 = animscripts/utility::getmoveanim("sprint");
	}

	return var_00;
}

//Function Number: 14
func_74C6()
{
	if(isdefined(self.var_797D))
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
func_74C7()
{
	if(isdefined(self.var_55A9))
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
func_3B36()
{
	var_00 = self.moveplaybackrate;
	if(self.lookaheadhitsstairs && self.stairsstate == "none" && self.lookaheaddist < 300)
	{
		var_00 = var_00 * 0.75;
	}

	return var_00;
}

//Function Number: 17
func_79D8()
{
	var_00 = func_3B36();
	self setanimknob(%combatrun,1,0.5,var_00);
	var_01 = 0;
	var_02 = isdefined(self.var_65CD) && gettime() - self.var_65CD < 100;
	if(var_02 && randomfloat(1) < self.a.var_63C9)
	{
		func_7C6E();
		func_70C6(0);
		func_699B();
	}

	if(func_74C6())
	{
		var_03 = getsprintanim();
		self setflaggedanimknob("runanim",var_03,1,0.5,self.moveplaybackrate);
		func_696E(var_03);
		func_70C6(0);
		var_01 = 1;
	}
	else if(isdefined(self.enemy) && animscripts/move::func_5127())
	{
		func_70C6(1);
		if(!self.facemotion)
		{
			thread faceenemyaimtracking();
		}
		else if(self.var_744B != "none" && !isdefined(self.var_5680))
		{
			func_2D51();
			if(canshootwhilerunningforward())
			{
				var_01 = func_6995(1);
			}
			else if(canshootwhilerunningbackward())
			{
				runngun_backward();
			}
		}
		else if(isdefined(self.var_6999) && self.var_6999 != 0)
		{
			var_01 = func_6995(0);
		}
	}
	else if(isdefined(self.var_6999) && self.var_6999 != 0)
	{
		func_70C6(0);
		var_01 = func_6995(0);
	}
	else
	{
		func_70C6(0);
	}

	if(!var_01)
	{
		func_7C6E();
		if(var_02 && self.a.var_63C9 != 0)
		{
			func_699B();
		}

		if(func_5438())
		{
		}

		self clearanim(%stair_transitions,0.1);
		if(func_74C7())
		{
			var_04 = animscripts/utility::getmoveanim("sprint_short");
		}
		else
		{
			var_04 = func_3BDB();
		}

		self setflaggedanimknoblimited("runanim",var_04,1,0.1,self.moveplaybackrate,1);
		func_696E(var_04);
		setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"),self.sidesteprate);
		thread func_7008("run");
	}

	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 18
func_3C00(param_00,param_01)
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
		return animscripts/utility::getmoveanim("stairs_up_out");
	}

	if(param_00 == "down")
	{
		return animscripts/utility::getmoveanim("stairs_down_out");
	}

	if(param_01 == "up")
	{
		return animscripts/utility::getmoveanim("stairs_up_in");
	}

	if(param_01 == "down")
	{
		return animscripts/utility::getmoveanim("stairs_down_in");
	}
}

//Function Number: 19
faceenemyaimtracking()
{
	if(isdefined(self.aim_while_moving_thread))
	{
	}

	self.aim_while_moving_thread = 1;
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	self setdefaultaimlimits();
	var_00 = undefined;
	if(isdefined(self.var_1E61) && isdefined(self.var_1E61["walk_aims"]))
	{
		self setanimlimited(self.var_1E61["walk_aims"]["walk_aim_2"]);
		self setanimlimited(self.var_1E61["walk_aims"]["walk_aim_4"]);
		self setanimlimited(self.var_1E61["walk_aims"]["walk_aim_6"]);
		self setanimlimited(self.var_1E61["walk_aims"]["walk_aim_8"]);
	}
	else
	{
		var_01 = "walk";
		if(animscripts/utility::func_74A5() && isdefined(animscripts/utility::lookupanim("cqb","aim_2")))
		{
			var_01 = "cqb";
		}

		var_02 = animscripts/utility::func_4F5D(var_01);
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

	animscripts/track::func_8221(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8,var_00);
}

//Function Number: 20
func_2D51()
{
	self.aim_while_moving_thread = undefined;
	self notify("end_face_enemy_tracking");
}

//Function Number: 21
func_70C6(param_00)
{
	var_01 = isdefined(self.bshootwhilemoving);
	if(param_00)
	{
		self.bshootwhilemoving = param_00;
		if(!var_01)
		{
			thread func_6989();
			thread func_69A9();
		}
	}

	self.bshootwhilemoving = undefined;
	if(var_01)
	{
		self notify("end_shoot_while_moving");
		self notify("end_face_enemy_tracking");
		self.var_742D = undefined;
		self.aim_while_moving_thread = undefined;
		self.var_6995 = undefined;
	}
}

//Function Number: 22
func_6989()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/shoot_behavior::func_2439("normal");
}

//Function Number: 23
func_69A9()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/move::func_7451();
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
	if((!isdefined(self.var_6999) || self.var_6999 == 0) && abs(self getmotionangle()) > self.var_5118)
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

	var_00 = func_3BA3(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
canshootwhilerunning()
{
	return animscripts/move::func_5127() && isdefined(self.enemy) && canshootwhilerunningforward() || canshootwhilerunningbackward();
}

//Function Number: 28
func_3BA3(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self getmotionangle();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.velocity) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.enemy.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 29
func_5438()
{
	var_00 = 0;
	var_01 = undefined;
	if(self.stairsstate == "none" && self.lookaheadhitsstairs)
	{
		if(animscripts/utility::func_74A5())
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

			var_01 = func_3C00("none","up");
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

			var_01 = func_3C00("none","down");
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

		var_01 = func_3C00("up","none");
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

		var_01 = func_3C00("down","none");
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	self notify("stop_move_anim_update");
	self.var_868B = undefined;
	self setflaggedanimknoballrestart("runanim",var_01,%body,1,0.1,self.moveplaybackrate);
	func_696E(var_01);
	animscripts/shared::func_2986("runanim");
	return 1;
}

//Function Number: 30
func_79D9()
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	var_00 = func_3B36();
	if(func_5438())
	{
	}

	self clearanim(%stair_transitions,0.1);
	self setanimknoball(%combatrun,%body,1,0.2,var_00);
	if(func_74C6())
	{
		var_01 = getsprintanim();
	}
	else
	{
		var_01 = func_3BDB();
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
	func_696E(var_01);
	setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
	thread func_7008("run");
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
	animscripts/notetracks::donotetracksfortime(var_04,"runanim");
}

//Function Number: 31
crouchrun_runoverride()
{
	self endon("movemode");
	self setflaggedanimknoball("runanim",self.crouchrun_combatanim,%body,1,0.4,self.moveplaybackrate);
	func_696E(self.crouchrun_combatanim);
	animscripts/shared::func_2986("runanim");
}

//Function Number: 32
crouchrun_runnormal()
{
	self endon("movemode");
	var_00 = func_3A69();
	self setanimknob(var_00,1,0.4);
	thread func_8705("crouchrun",var_00,animscripts/utility::lookupanim("run","crouch_b"),animscripts/utility::lookupanim("run","crouch_l"),animscripts/utility::lookupanim("run","crouch_r"));
	self setflaggedanimknoball("runanim",%crouchrun,%body,1,0.2,self.moveplaybackrate);
	func_696E(undefined);
	animscripts/notetracks::donotetracksfortime(0.2,"runanim");
}

//Function Number: 33
standrun_checkreload()
{
	var_00 = isdefined(self.a.allowedpartialreloadontheruntime) && self.a.allowedpartialreloadontheruntime > gettime();
	var_00 = var_00 || isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536;
	if(var_00)
	{
		if(!animscripts/combat_utility::func_5596(0))
		{
			return 0;
		}
	}
	else if(!animscripts/combat_utility::func_5596(0.5))
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

	if(canshootwhilerunning() && !animscripts/combat_utility::func_5596(0))
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

	if(!func_698F())
	{
		return 0;
	}

	if(animscripts/utility::func_74A5())
	{
		animscripts/cqb::cqb_reloadinternal();
	}
	else
	{
		func_79DA();
	}

	self notify("abort_reload");
	self orientmode("face default");
	return 1;
}

//Function Number: 34
func_79DA()
{
	self endon("movemode");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts/combat_utility::getuniqueflagnameindex();
	var_01 = animscripts/utility::lookupanim("run","reload");
	if(isarray(var_01))
	{
		var_01 = var_01[randomint(var_01.size)];
	}

	self setflaggedanimknoballrestart(var_00,var_01,%body,1,0.25);
	func_696E(var_01);
	self.var_868C = 1;
	setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
	thread func_7008("run");
	animscripts/shared::func_2986(var_00);
	self.var_868C = undefined;
}

//Function Number: 35
func_698F()
{
	var_00 = self getanimtime(%walk_and_run_loops);
	var_01 = getanimlength(animscripts/utility::lookupanim("run","straight")) / 3;
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
func_7008(param_00)
{
	func_8705(param_00,%combatrun_forward,%combatrun_backward,%combatrun_left,%combatrun_right);
}

//Function Number: 38
func_8705(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_868B) && self.var_868B == param_00)
	{
	}

	self notify("stop_move_anim_update");
	self.var_868B = param_00;
	self.var_8C47 = undefined;
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("stop_move_anim_update");
	for(;;)
	{
		func_8728(param_01,param_02,param_03,param_04);
		wait(0.05);
		waittillframeend;
	}
}

//Function Number: 39
func_8728(param_00,param_01,param_02,param_03)
{
	if(self.facemotion && !animscripts/utility::func_74A5() && !isdefined(self.var_868C))
	{
		if(!isdefined(self.var_8C47))
		{
			self.var_8C47 = 1;
			self setanim(param_00,1,0.2,1,1);
			self setanim(param_01,0,0.2,1,1);
			self setanim(param_02,0,0.2,1,1);
			self setanim(param_03,0,0.2,1,1);
		}
	}

	self.var_8C47 = undefined;
	var_04 = animscripts/utility::quadrantanimweights(self getmotionangle());
	if(isdefined(self.var_868C))
	{
		var_04["back"] = 0;
		if(var_04["front"] < 0.2)
		{
			var_04["front"] = 0.2;
		}
	}

	self setanim(param_00,var_04["front"],0.2,1,1);
	self setanim(param_01,var_04["back"],0.2,1,1);
	self setanim(param_02,var_04["left"],0.2,1,1);
	self setanim(param_03,var_04["right"],0.2,1,1);
}

//Function Number: 40
func_79D6()
{
	var_00 = isdefined(self.var_8C03) && self.var_8C03;
	var_01 = animscripts/utility::isshotgun(self.weapon);
	if(var_00 == var_01)
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 65536)
	{
		return 0;
	}

	if(animscripts/utility::func_87FE())
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

	if(!func_698F())
	{
		return 0;
	}

	if(var_00)
	{
		func_7462("shotgunPullout",animscripts/utility::lookupanim("cqb","shotgun_pullout"),"gun_2_chest","none",self.secondaryweapon,"shotgun_pickup");
	}
	else
	{
		func_7462("shotgunPutaway",animscripts/utility::lookupanim("cqb","shotgun_putaway"),"gun_2_back","back",self.primaryweapon,"shotgun_pickup");
	}

	self notify("switchEnded");
	return 1;
}

//Function Number: 41
func_7462(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("movemode");
	self setflaggedanimknoballrestart(param_00,param_01,%body,1,0.25);
	func_696E(param_01);
	self.var_868C = 1;
	setmovenonforwardanims(animscripts/utility::getmoveanim("move_b"),animscripts/utility::getmoveanim("move_l"),animscripts/utility::getmoveanim("move_r"));
	thread func_7008("run");
	thread func_8D1F(param_00,param_02,param_03,param_04,param_05);
	animscripts/notetracks::func_298D(getanimlength(param_01) - 0.25,param_00,::func_46A7);
	self.var_868C = undefined;
}

//Function Number: 42
func_46A7(param_00)
{
	if(param_00 == "gun_2_chest" || param_00 == "gun_2_back")
	{
		return 1;
	}
}

//Function Number: 43
func_8D1F(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("movemode");
	self endon("switchEnded");
	self waittillmatch(param_01,param_00);
	animscripts/shared::placeweaponon(self.weapon,param_02);
	thread shotgunswitchfinish(param_03);
	self waittillmatch(param_04,param_00);
	self notify("complete_weapon_switch");
}

//Function Number: 44
shotgunswitchfinish(param_00)
{
	self endon("death");
	common_scripts\utility::func_8B2A("killanimscript","movemode","switchEnded","complete_weapon_switch");
	self.lastweapon = self.weapon;
	animscripts/shared::placeweaponon(param_00,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 45
func_696E(param_00)
{
	self.facialidx = animscripts/face::func_6004(param_00,"run",self.facialidx);
}

//Function Number: 46
func_693D()
{
	self.facialidx = undefined;
	self clearanim(%head,0.2);
}