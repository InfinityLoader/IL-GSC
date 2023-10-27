/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\run.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 744 ms
 * Timestamp: 10/27/2023 2:18:38 AM
*******************************************************************/

//Function Number: 1
func_0FB9()
{
	var_00 = [[ self.var_FBA ]]("stand");
	switch(var_00)
	{
		case "stand":
			if(animscripts/setposemovement::func_FBB())
			{
				return;
			}
	
			if(isdefined(self.run_overrideanim))
			{
				animscripts/move::func_FBE(self.run_overrideanim,self.run_override_weights);
				return;
			}
	
			if(func_0FFD())
			{
				return;
			}
	
			if(func_0FF0())
			{
				return;
			}
	
			if(animscripts/utility::func_A69())
			{
				func_0FDC();
			}
			else
			{
				func_0FED();
			}
			break;

		case "crouch":
			if(animscripts/setposemovement::func_FBF())
			{
				return;
			}
	
			if(isdefined(self.crouchrun_combatanim))
			{
				func_0FEE();
			}
			else
			{
				func_0FEF();
			}
			break;

		default:
			if(animscripts/setposemovement::func_FC1())
			{
				return;
			}
	
			func_0FC5();
			break;
	}
}

//Function Number: 2
func_0FC2()
{
	if(!isdefined(self.a.var_CA6))
	{
		return %run_lowready_f;
	}

	if(!self.var_781)
	{
		if(self.var_786 == "none" || abs(self getmotionangle()) > 45)
		{
			return animscripts/utility::func_FC3("move_f");
		}
	}

	if(self.var_786 == "up")
	{
		return animscripts/utility::func_FC3("stairs_up");
	}
	else if(self.var_786 == "down")
	{
		return animscripts/utility::func_FC3("stairs_down");
	}

	return animscripts/utility::func_FC3("straight");
}

//Function Number: 3
func_0FC4()
{
	if(!isdefined(self.a.var_CA6))
	{
		return %crouch_fastwalk_f;
	}

	return animscripts/utility::func_FC3("crouch");
}

//Function Number: 4
func_0FC5()
{
	self.a.movement = "run";
	self setflaggedanimknob("runanim",animscripts/utility::func_FC3("prone"),1,0.3,self.moveplaybackrate);
	animscripts/notetracks::func_D4F(0.25,"runanim");
}

//Function Number: 5
func_0FC7()
{
	if(!isdefined(self.var_FC8))
	{
		self notify("stop_move_anim_update");
		self.var_FC9 = undefined;
		self clearanim(%combatrun_backward,0.2);
		self clearanim(%combatrun_right,0.2);
		self clearanim(%combatrun_left,0.2);
		self clearanim(%w_aim_2,0.2);
		self clearanim(%w_aim_4,0.2);
		self clearanim(%w_aim_6,0.2);
		self clearanim(%w_aim_8,0.2);
		self.var_FC8 = 1;
	}
}

//Function Number: 6
func_0FCA()
{
	if(isdefined(self.var_FC8))
	{
		self clearanim(%run_n_gun,0.2);
		self.var_FC8 = undefined;
	}

	return 0;
}

//Function Number: 7
func_0FC8(param_00)
{
	if(param_00)
	{
		var_01 = func_0FEC(0.2);
		var_02 = var_01 < 0;
	}
	else
	{
		var_01 = 0;
		var_02 = self.var_FCB < 0;
	}

	var_03 = 1 - var_02;
	var_04 = self.var_CA1;
	var_05 = self.var_CA2;
	var_06 = self.var_CA3;
	if(!param_00 || squared(var_01) > var_04 * var_04)
	{
		self clearanim(%add_fire,0);
		if(squared(self.var_FCB) < var_06 * var_06)
		{
			self.var_FCB = 0;
			self.var_FC8 = undefined;
			return 0;
		}
		else if(self.var_FCB > 0)
		{
			self.var_FCB = self.var_FCB - var_06;
		}
		else
		{
			self.var_FCB = self.var_FCB + var_06;
		}
	}
	else
	{
		var_07 = var_01 / var_04;
		var_08 = var_07 - self.var_FCB;
		if(abs(var_08) < var_05 * 0.7)
		{
			self.var_FCB = var_07;
		}
		else if(var_08 > 0)
		{
			self.var_FCB = self.var_FCB + var_06;
		}
		else
		{
			self.var_FCB = self.var_FCB - var_06;
		}
	}

	func_0FC7();
	var_09 = abs(self.var_FCB);
	if(var_09 > var_05)
	{
		var_0A = var_09 - var_05 / var_05;
		var_0A = clamp(var_0A,0,1);
		self clearanim(self.var_CA4["F"],0.2);
		self setanimlimited(self.var_CA4["L"],1 - var_0A * var_02,0.2);
		self setanimlimited(self.var_CA4["R"],1 - var_0A * var_03,0.2);
		self setanimlimited(self.var_CA4["LB"],var_0A * var_02,0.2);
		self setanimlimited(self.var_CA4["RB"],var_0A * var_03,0.2);
	}
	else
	{
		var_0A = clamp(var_0A / var_06,0,1);
		self setanimlimited(self.var_CA4["F"],1 - var_0A,0.2);
		self setanimlimited(self.var_CA4["L"],var_0A * var_02,0.2);
		self setanimlimited(self.var_CA4["R"],var_0A * var_03,0.2);
		if(var_05 < 1)
		{
			self clearanim(self.var_CA4["LB"],0.2);
			self clearanim(self.var_CA4["RB"],0.2);
		}
	}

	self setflaggedanimknob("runanim",%run_n_gun,1,0.3,0.8);
	self.a.var_FCC = gettime() + 500;
	if(param_00 && isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	return 1;
}

//Function Number: 8
func_0FCD()
{
	func_0FC7();
	self setflaggedanimknob("runanim",%combatwalk_b,1,0.3,0.8);
	if(isplayer(self.enemy))
	{
		self updateplayersightaccuracy();
	}

	animscripts/notetracks::func_D4F(0.2,"runanim");
	thread func_0FE5();
	self clearanim(%combatwalk_b,0.2);
}

//Function Number: 9
func_0FCE()
{
	self endon("killanimscript");
	for(;;)
	{
		wait 0.2;
		if(!isdefined(self.var_FCF))
		{
			break;
		}

		if(!isdefined(self.pathgoalpos) || distancesquared(self.pathgoalpos,self.origin) < squared(80))
		{
			func_0FD0();
			self notify("interrupt_react_to_bullet");
			break;
		}
	}
}

//Function Number: 10
func_0FD0()
{
	self orientmode("face default");
	self.var_FCF = undefined;
	self.var_FD1 = undefined;
}

//Function Number: 11
func_0F1D()
{
	self.var_FD2 = undefined;
	self notify("end_face_enemy_tracking");
	self endon("interrupt_react_to_bullet");
	self.var_FCF = 1;
	self orientmode("face motion");
	var_00 = randomint(level.var_F1D.size);
	if(var_00 == level.var_F1E)
	{
		var_00 = var_00 + 1 % level.var_F1D.size;
	}

	anim.var_F1E = var_00;
	var_01 = level.var_F1D[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5);
	thread func_0FCE();
	animscripts/shared::donotetracks("reactanim");
	func_0FD0();
}

//Function Number: 12
func_0FD3()
{
	self.var_FD2 = undefined;
	self notify("end_face_enemy_tracking");
	self.var_FCF = 1;
	self orientmode("face motion");
	var_00 = randomint(self.var_FD4.size);
	var_01 = self.var_FD4[var_00];
	self setflaggedanimknobrestart("reactanim",var_01,1,0.5);
	thread func_0FCE();
	animscripts/shared::donotetracks("reactanim");
	func_0FD0();
}

//Function Number: 13
func_0FD5()
{
	var_00 = undefined;
	if(isdefined(self.var_73C))
	{
		var_00 = animscripts/utility::func_FC3("sprint_short");
	}

	if(!isdefined(var_00))
	{
		var_00 = animscripts/utility::func_FC3("sprint");
	}

	return var_00;
}

//Function Number: 14
func_0FD6()
{
	if(isdefined(self.sprint))
	{
		return 1;
	}

	if(isdefined(self.var_73C) && isdefined(self.enemy) && self.var_772 == 1)
	{
		return distancesquared(self.origin,self.enemy.origin) > 90000;
	}

	return 0;
}

//Function Number: 15
func_0FD8()
{
	if(isdefined(self.neversprintforvariation))
	{
		return 0;
	}

	if(!self.var_781 || self.var_786 != "none")
	{
		return 0;
	}

	var_00 = gettime();
	if(isdefined(self.var_FDA))
	{
		if(var_00 < self.var_FDA)
		{
			return 1;
		}

		if(var_00 - self.var_FDA < 6000)
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
		self.var_FDA = var_00 + 2000 + randomint(1000);
		return 1;
	}

	return 0;
}

//Function Number: 16
func_0FDB()
{
	var_00 = self.moveplaybackrate;
	if(self.var_775 && self.var_786 == "none" && self.var_774 < 300)
	{
		var_00 = var_00 * 0.75;
	}

	return var_00;
}

//Function Number: 17
func_0FDC()
{
	var_00 = func_0FDB();
	self setanimknob(%combatrun,1,0.5,var_00);
	var_01 = 0;
	if(isdefined(self.var_FD1) && gettime() - self.var_FD1 < 100 && randomfloat(1) < self.a.var_FDD)
	{
		func_0FCA();
		func_0F1D();
		return;
	}

	if(func_0FD6())
	{
		self setflaggedanimknob("runanim",func_0FD5(),1,0.5);
		var_01 = 1;
	}
	else if(isdefined(self.enemy) && animscripts/move::func_FDE())
	{
		func_0FE3();
		if(!self.var_781)
		{
			thread func_0FE1();
		}
		else if(self.var_CDA != "none" && !isdefined(self.norunngun))
		{
			self notify("end_face_enemy_tracking");
			self.var_FD2 = undefined;
			if(func_0FE9())
			{
				var_01 = func_0FC8(1);
			}
			else if(func_0FEA())
			{
				func_0FCD();
				return;
			}
		}
		else if(isdefined(self.var_FCB) && self.var_FCB != 0)
		{
			var_01 = func_0FC8(0);
		}
	}
	else if(isdefined(self.var_FCB) && self.var_FCB != 0)
	{
		var_01 = func_0FC8(0);
	}

	if(!var_01)
	{
		func_0FCA();
		if(isdefined(self.var_FD1) && gettime() - self.var_FD1 < 100 && self.a.var_FDD != 0)
		{
			func_0F1D();
			return;
		}

		if(func_0FD8())
		{
			var_02 = animscripts/utility::func_FC3("sprint_short");
		}
		else
		{
			var_02 = func_0FC2();
		}

		self setflaggedanimknoblimited("runanim",var_02,1,0.1,1,1);
		func_0FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"),self.var_FE0);
		thread func_0FF8("run");
	}

	animscripts/notetracks::func_D4F(0.2,"runanim");
	thread func_0FE5();
}

//Function Number: 18
func_0FE1()
{
	self notify("want_aim_while_moving");
	if(isdefined(self.var_FD2))
	{
		return;
	}

	self.var_FD2 = 1;
	self endon("killanimscript");
	self endon("end_face_enemy_tracking");
	self setdefaultaimlimits();
	if(!isdefined(self.var_C82) || !isdefined(self.var_C82["walk_aims"]))
	{
		self setanimlimited(%walk_aim_2);
		self setanimlimited(%walk_aim_4);
		self setanimlimited(%walk_aim_6);
		self setanimlimited(%walk_aim_8);
	}
	else
	{
		self setanimlimited(self.var_C82["walk_aims"]["walk_aim_2"]);
		self setanimlimited(self.var_C82["walk_aims"]["walk_aim_4"]);
		self setanimlimited(self.var_C82["walk_aims"]["walk_aim_6"]);
		self setanimlimited(self.var_C82["walk_aims"]["walk_aim_8"]);
	}

	animscripts/track::func_CAA(%w_aim_2,%w_aim_4,%w_aim_6,%w_aim_8);
}

//Function Number: 19
func_0FE2()
{
	self.var_FD2 = undefined;
	self notify("end_face_enemy_tracking");
}

//Function Number: 20
func_0FE3()
{
	self notify("want_shoot_while_moving");
	if(isdefined(self.var_FE4))
	{
		return;
	}

	self.var_FE4 = 1;
	thread func_0FE6();
	thread func_0FE7();
}

//Function Number: 21
func_0FE5()
{
	self endon("killanimscript");
	self endon("want_shoot_while_moving");
	self endon("want_aim_while_moving");
	wait 0.05;
	self notify("end_shoot_while_moving");
	self notify("end_face_enemy_tracking");
	self.var_FE4 = undefined;
	self.var_FD2 = undefined;
	self.var_FC8 = undefined;
}

//Function Number: 22
func_0FE6()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/shoot_behavior::func_CD7("normal");
}

//Function Number: 23
func_0FE7()
{
	self endon("killanimscript");
	self endon("end_shoot_while_moving");
	animscripts/move::func_FE8();
}

//Function Number: 24
func_0D60()
{
	var_00 = self getmuzzleangle();
	var_01 = vectortoangles(self.enemy getshootatpos() - self getmuzzlepos());
	if(animscripts/utility::func_D61(var_00[1] - var_01[1]) > 15)
	{
		return 0;
	}

	return animscripts/utility::func_D61(var_00[0] - var_01[0]) <= 20;
}

//Function Number: 25
func_0FE9()
{
	if((!isdefined(self.var_FCB) || self.var_FCB == 0) && abs(self getmotionangle()) > self.var_CA1)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_0FEA()
{
	if(180 - abs(self getmotionangle()) >= 45)
	{
		return 0;
	}

	var_00 = func_0FEC(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_0FEB()
{
	return animscripts/move::func_FDE() && isdefined(self.enemy) && func_0FE9() || func_0FEA();
}

//Function Number: 28
func_0FEC(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self getmotionangle();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.velocity) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.enemy.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 29
func_0FED()
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	var_00 = func_0FDB();
	self setanimknoball(%combatrun,%body,1,0.2,var_00);
	if(func_0FD6())
	{
		var_01 = func_0FD5();
	}
	else
	{
		var_01 = func_0FC2();
	}

	if(self.var_786 == "none")
	{
		var_02 = 0.3;
	}
	else
	{
		var_02 = 0.1;
	}

	self setflaggedanimknob("runanim",var_01,1,var_02,1,1);
	func_0FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
	thread func_0FF8("run");
	animscripts/notetracks::func_D4F(0.2,"runanim");
}

//Function Number: 30
func_0FEE()
{
	self endon("movemode");
	self setflaggedanimknoball("runanim",self.crouchrun_combatanim,%body,1,0.4,self.moveplaybackrate);
	animscripts/shared::donotetracks("runanim");
}

//Function Number: 31
func_0FEF()
{
	self endon("movemode");
	var_00 = func_0FC4();
	self setanimknob(var_00,1,0.4);
	thread func_0FF9("crouchrun",var_00,%crouch_fastwalk_b,%crouch_fastwalk_l,%crouch_fastwalk_r);
	self setflaggedanimknoball("runanim",%crouchrun,%body,1,0.2,self.moveplaybackrate);
	animscripts/notetracks::func_D4F(0.2,"runanim");
}

//Function Number: 32
func_0FF0()
{
	var_00 = isdefined(self.a.var_FCC) && self.a.var_FCC > gettime();
	var_00 = var_00 || isdefined(self.enemy) && distancesquared(self.origin,self.enemy.origin) < 65536;
	if(var_00)
	{
		if(!animscripts/combat_utility::func_F08(0))
		{
			return 0;
		}
	}
	else if(!animscripts/combat_utility::func_F08(0.5))
	{
		return 0;
	}

	if(isdefined(self.var_73C))
	{
		return 0;
	}

	if(!self.var_781 || self.var_786 != "none")
	{
		return 0;
	}

	if(isdefined(self.dontshootwhilemoving) || isdefined(self.var_FF2))
	{
		return 0;
	}

	if(func_0FEB() && !animscripts/combat_utility::func_F08(0))
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

	if(!animscripts/utility::func_EE3())
	{
		return 0;
	}

	if(!func_0FF6())
	{
		return 0;
	}

	func_0FF3();
	self notify("abort_reload");
	self orientmode("face default");
	return 1;
}

//Function Number: 33
func_0FF3()
{
	self endon("movemode");
	self orientmode("face motion");
	var_00 = "reload_" + animscripts/combat_utility::func_FF4();
	self setflaggedanimknoballrestart(var_00,%run_lowready_reload,%body,1,0.25);
	self.var_FF5 = 1;
	func_0FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
	thread func_0FF8("run");
	animscripts/shared::donotetracks(var_00);
	self.var_FF5 = undefined;
}

//Function Number: 34
func_0FF6()
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
func_0FF7(param_00,param_01,param_02,param_03)
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
func_0FF8(param_00)
{
	func_0FF9(param_00,%combatrun_forward,%combatrun_backward,%combatrun_left,%combatrun_right);
}

//Function Number: 37
func_0FF9(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_FC9) && self.var_FC9 == param_00)
	{
		return;
	}

	self notify("stop_move_anim_update");
	self.var_FC9 = param_00;
	self.var_FFA = undefined;
	self endon("killanimscript");
	self endon("move_interrupt");
	self endon("stop_move_anim_update");
	for(;;)
	{
		func_0FFB(param_01,param_02,param_03,param_04);
		wait 0.05;
		waittillframeend;
	}
}

//Function Number: 38
func_0FFB(param_00,param_01,param_02,param_03)
{
	if(self.var_781 && !animscripts/utility::func_CB2() && !isdefined(self.var_FF5))
	{
		if(!isdefined(self.var_FFA))
		{
			self.var_FFA = 1;
			self setanim(param_00,1,0.2,1,1);
			self setanim(param_01,0,0.2,1,1);
			self setanim(param_02,0,0.2,1,1);
			self setanim(param_03,0,0.2,1,1);
			return;
		}

		return;
	}

	self.var_FFA = undefined;
	var_04 = animscripts/utility::func_FFC(self getmotionangle());
	if(isdefined(self.var_FF5))
	{
		if(var_7B["front"] < 0.2)
		{
		}
	}

	self setanim(param_01,var_7B["front"],0.2,1,1);
	self setanim(param_02,var_7B["back"],0.2,1,1);
	self setanim(param_03,var_7B["left"],0.2,1,1);
	self setanim(var_04,var_7B["right"],0.2,1,1);
}

//Function Number: 39
func_0FFD()
{
	var_00 = isdefined(self.wantshotgun) && self.wantshotgun;
	var_01 = animscripts/utility::func_CEA(self.weapon);
	if(var_00 == var_01)
	{
		return 0;
	}

	if(!isdefined(self.pathgoalpos) || distancesquared(self.origin,self.pathgoalpos) < 65536)
	{
		return 0;
	}

	if(animscripts/utility::func_C95())
	{
		return 0;
	}

	if(self.weapon == self.primaryweapon)
	{
		if(!var_00)
		{
			return 0;
		}

		if(animscripts/utility::func_CEA(self.secondaryweapon))
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

		if(animscripts/utility::func_CEA(self.primaryweapon))
		{
			return 0;
		}
	}

	var_02 = angleclamp180(self getmotionangle());
	if(abs(var_02) > 25)
	{
		return 0;
	}

	if(!func_0FF6())
	{
		return 0;
	}

	if(var_00)
	{
		func_1000("shotgunPullout",%shotgun_cqbrun_pullout,"gun_2_chest","none",self.secondaryweapon,"shotgun_pickup");
	}
	else
	{
		func_1000("shotgunPutaway",%shotgun_cqbrun_putaway,"gun_2_back","back",self.primaryweapon,"shotgun_pickup");
	}

	self notify("switchEnded");
	return 1;
}

//Function Number: 40
func_1000(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("movemode");
	self setflaggedanimknoballrestart(param_00,param_01,%body,1,0.25);
	self.var_FF5 = 1;
	func_0FF7(animscripts/utility::func_FC3("move_b"),animscripts/utility::func_FC3("move_l"),animscripts/utility::func_FC3("move_r"));
	thread func_0FF8("run");
	thread func_1003(param_00,param_02,param_03,param_04,param_05);
	animscripts/notetracks::func_1001(getanimlength(param_01) - 0.25,param_00,::func_1002);
	self.var_FF5 = undefined;
}

//Function Number: 41
func_1002(param_00)
{
	if(param_00 == "gun_2_chest" || param_00 == "gun_2_back")
	{
		return 1;
	}
}

//Function Number: 42
func_1003(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("movemode");
	self endon("switchEnded");
	self waittillmatch(param_01,param_00);
	animscripts/shared::func_C9B(self.weapon,param_02);
	thread func_1004(param_03);
	self waittillmatch(param_04,param_00);
	self notify("complete_weapon_switch");
}

//Function Number: 43
func_1004(param_00)
{
	self endon("death");
	common_scripts\utility::waittill_any("killanimscript","movemode","switchEnded","complete_weapon_switch");
	self.lastweapon = self.weapon;
	animscripts/shared::func_C9B(param_00,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
}