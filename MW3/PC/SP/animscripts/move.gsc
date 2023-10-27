/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\move.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 699 ms
 * Timestamp: 10/27/2023 2:18:29 AM
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
	[[ self.var_8BE["move"] ]]();
	func_10AC();
	func_10AE();
	animscripts/utility::func_D15("move");
	var_00 = func_10B1();
	if(var_00 && isdefined(self.var_F74))
	{
		func_10D9();
		func_10DB();
	}
	else if(isdefined(self.battlechatter) && self.battlechatter)
	{
		func_10B2(var_00);
		animscripts/battlechatter::func_ABF();
	}

	thread func_10BD();
	thread func_1090();
	thread func_10CB();
	animscripts/cover_arrival::func_10A6();
	self.var_10A7 = undefined;
	self.var_10A8 = undefined;
	thread func_10BC();
	thread animscripts/cover_arrival::func_10A9(1);
	self.var_FE4 = undefined;
	self.var_FD2 = undefined;
	self.var_FC8 = undefined;
	func_10B3(1);
}

//Function Number: 2
func_067F()
{
	if(isdefined(self.var_108F))
	{
		self.grenadeweapon = self.var_108F;
		self.var_108F = undefined;
	}

	self.teamflashbangimmunity = undefined;
	self.var_108E = undefined;
	self.var_10A8 = undefined;
	self.var_F74 = undefined;
	self.var_F75 = undefined;
	self.var_FC8 = undefined;
	self.var_FCF = undefined;
	self.var_FD1 = undefined;
	self.var_10AA = undefined;
	self.var_10AB = undefined;
}

//Function Number: 3
func_10AC()
{
	self.var_FCF = undefined;
	self.var_FD1 = undefined;
	self.var_FC9 = undefined;
	self.var_FF5 = undefined;
	self.var_FCB = 0;
	self.var_10AD = undefined;
}

//Function Number: 4
func_10AE()
{
	if(self.a.pose == "prone")
	{
		var_00 = animscripts/utility::func_10AF("stand");
		if(var_00 != "prone")
		{
			self orientmode("face current");
			self animmode("zonly_physics",0);
			var_01 = 1;
			if(isdefined(self.var_73C))
			{
				var_01 = 2;
			}

			animscripts/cover_prone::func_10B0(var_00,var_01);
			self animmode("none",0);
			self orientmode("face default");
		}
	}
}

//Function Number: 5
func_10B1()
{
	switch(self.var_788)
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
func_10B2(param_00)
{
	if(self.movemode == "run")
	{
		animscripts/battlechatter_ai::func_B2A(param_00);
	}
}

//Function Number: 7
func_10B3(param_00)
{
	func_10B6(param_00);
	self notify("abort_reload");
}

//Function Number: 8
func_10B4(param_00)
{
	if(param_00 != self.var_10B5)
	{
		if(isdefined(self.custommoveanimset) && isdefined(self.custommoveanimset[param_00]))
		{
			self.a.var_CA6 = self.custommoveanimset[param_00];
		}
		else
		{
			self.a.var_CA6 = level.animsets.move[param_00];
			if((self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only") && isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) > squared(100))
			{
				self.var_FE0 = 1;
				animscripts/animset::func_CA5();
			}
			else
			{
				self.var_FE0 = 1.35;
			}
		}

		self.var_10B5 = param_00;
	}
}

//Function Number: 9
func_10B6(param_00)
{
	self endon("killanimscript");
	self endon("move_interrupt");
	var_01 = self getanimtime(%walk_and_run_loops);
	self.a.var_1077 = randomint(10000);
	self.var_10B5 = "none";
	self.var_10B7 = undefined;
	for(;;)
	{
		var_02 = self getanimtime(%walk_and_run_loops);
		if(var_02 < var_01)
		{
			self.a.var_1077++;
		}

		var_01 = var_02;
		func_10B4(self.movemode);
		func_10B8(self.movemode);
		if(isdefined(self.var_10B7))
		{
			self [[ self.var_10B7 ]]();
			self.var_10B7 = undefined;
		}

		self notify("abort_reload");
	}
}

//Function Number: 10
func_10B8(param_00)
{
	self endon("move_loop_restart");
	animscripts/face::func_C44(level.var_C3D);
	if(isdefined(self.var_10AB))
	{
		self [[ self.var_10AB ]]();
	}
	else if(animscripts/utility::func_CB2())
	{
		animscripts/cqb::func_1075();
	}
	else if(param_00 == "run")
	{
		animscripts/run::func_FB9();
	}
	else
	{
		animscripts/walk::func_107F();
	}

	self.var_FD1 = undefined;
}

//Function Number: 11
func_0FDE()
{
	if(self.weapon == "none")
	{
		return 0;
	}

	var_00 = weaponclass(self.weapon);
	if(!animscripts/utility::func_EE3())
	{
		return 0;
	}

	if(animscripts/combat_utility::issniper())
	{
		if(!animscripts/utility::func_C98() && self.var_781)
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
func_0FE8()
{
	self endon("killanimscript");
	self notify("doing_shootWhileMoving");
	self endon("doing_shootWhileMoving");
	if(isdefined(self.var_C82) && isdefined(self.var_C82["fire"]))
	{
		self.a.array["fire"] = self.var_C82["fire"];
	}
	else
	{
		self.a.array["fire"] = %exposed_shoot_auto_v3;
	}

	if(isdefined(self.weapon) && animscripts/utility::func_C97())
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
			if(animscripts/utility::func_10B9())
			{
				self.var_10BA = 0;
				animscripts/combat_utility::func_10BB();
			}

			if(!self.bulletsinclip)
			{
				wait 0.5;
				continue;
			}
		}

		animscripts/combat_utility::func_F06();
		self clearanim(%exposed_aiming,0.2);
	}
}

//Function Number: 13
func_10BC()
{
	self endon("killanimscript");
	wait 0.05;
	thread func_10D4();
	thread func_10D2();
	thread animscripts/door::func_1096();
	thread animscripts/door::func_1088();
}

//Function Number: 14
func_10BD()
{
	self endon("killanimscript");
	self.var_10BE = self.var_786;
	for(;;)
	{
		wait 0.05;
		if(self.var_10BE != self.var_786)
		{
			if(!isdefined(self.var_10A8) || self.var_786 != "none")
			{
				self notify("move_loop_restart");
			}
		}

		self.var_10BE = self.var_786;
	}
}

//Function Number: 15
func_1091(param_00)
{
	self endon("killanimscript");
	if(!param_00)
	{
		animscripts/cover_arrival::func_10A6();
	}

	self.var_10A8 = undefined;
	self clearanim(%root,0.1);
	self orientmode("face default");
	self animmode("none",0);
	self.var_779 = 1;
	func_10B3(!param_00);
}

//Function Number: 16
func_1090()
{
	self endon("killanimscript");
	self endon("move_interrupt");
	self.var_10A8 = 1;
	for(;;)
	{
		self waittill("path_changed",var_00,var_01);
		if(isdefined(self.var_10A8) || isdefined(self.noturnanims))
		{
			continue;
		}

		if(!self.var_781 || abs(self getmotionangle()) > 15)
		{
			continue;
		}

		if(self.a.movement != "run" && self.a.movement != "walk")
		{
			continue;
		}

		if(self.a.pose != "stand")
		{
			continue;
		}

		self notify("stop_move_anim_update");
		self.var_FC9 = undefined;
		var_02 = angleclamp180(self.angles[1] - vectortoyaw(var_01));
		var_03 = func_10C2(var_02);
		if(isdefined(var_03))
		{
			self.var_10C0 = var_03;
			self.var_10C1 = gettime();
			self.var_10AB = ::func_10C5;
			self notify("move_loop_restart");
			animscripts/run::func_FE2();
		}
	}
}

//Function Number: 17
func_10C2(param_00)
{
	if(isdefined(self.var_10C3))
	{
		return [[ self.var_10C3 ]](param_00);
	}

	var_01 = undefined;
	var_02 = undefined;
	if(animscripts/utility::func_CB2() || self.movemode == "walk")
	{
		var_03 = level.var_C9F;
	}
	else
	{
		var_03 = level.var_C9E;
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
		if(func_10C4(var_01))
		{
			return var_01;
		}
	}

	if(isdefined(var_02))
	{
		if(func_10C4(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 18
func_10C4(param_00)
{
	if(!isdefined(self.pathgoalpos))
	{
		return 0;
	}

	var_01 = getnotetracktimes(param_00,"code_move");
	var_02 = var_01[0];
	var_03 = getmovedelta(param_00,0,var_02);
	var_04 = self localtoworldcoords(var_03);
	if(isdefined(self.var_10AD) && squared(self.var_10AD) > distancesquared(self.pathgoalpos,var_04))
	{
		return 0;
	}

	var_03 = getmovedelta(param_00,0,1);
	var_05 = self localtoworldcoords(var_03);
	var_05 = var_04 + vectornormalize(var_05 - var_04) * 20;
	return self maymovefrompointtopoint(var_04,var_05,1,1);
}

//Function Number: 19
func_10C5()
{
	self endon("killanimscript");
	self.var_10AB = undefined;
	var_00 = self.var_10C0;
	if(gettime() > self.var_10C1 + 50)
	{
		return;
	}

	self animmode("zonly_physics",0);
	self clearanim(%body,0.1);
	self.var_10B7 = ::func_10C8;
	self.var_10A8 = 1;
	var_01 = 0.05;
	if(isdefined(self.var_10C6))
	{
		var_01 = isdefined(self.var_10C6);
	}

	self setflaggedanimrestart("turnAnim",var_00,1,var_01,self.moveplaybackrate);
	self orientmode("face current");
	animscripts/shared::donotetracks("turnAnim");
	self.var_10A8 = undefined;
	self orientmode("face motion");
	self animmode("none",0);
	animscripts/shared::donotetracks("turnAnim");
}

//Function Number: 20
func_10C7()
{
	self.var_10AB = undefined;
	if(gettime() > self.var_10C1 + 50)
	{
		return;
	}

	self.var_10B7 = ::func_10C8;
	animscripts/cover_arrival::func_10A6();
}

//Function Number: 21
func_10C8()
{
	self.var_10A8 = undefined;
	self orientmode("face default");
	self clearanim(%root,0.1);
	self animmode("none",0);
}

//Function Number: 22
func_10C9()
{
	self pushplayer(1);
	self animmode("zonly_physics",0);
	self clearanim(%body,0.2);
	self setflaggedanimrestart("dodgeAnim",self.var_10AA,1,0.2,1);
	animscripts/shared::donotetracks("dodgeAnim");
	self animmode("none",0);
	self orientmode("face default");
	if(animhasnotetrack(self.var_10AA,"code_move"))
	{
		animscripts/shared::donotetracks("dodgeAnim");
	}

	self clearanim(%civilian_dodge,0.2);
	self pushplayer(0);
	self.var_10AA = undefined;
	self.var_10AB = undefined;
	return 1;
}

//Function Number: 23
func_10CA(param_00,param_01)
{
	var_02 = (self.var_773[1],-1 * self.var_773[0],0);
	var_03 = self.var_773 * param_01[0];
	var_04 = var_02 * param_01[1];
	var_05 = self.origin + var_03 - var_04;
	self pushplayer(1);
	if(self maymovetopoint(var_05))
	{
		self.var_10AA = param_00;
		self.var_10AB = ::func_10C9;
		self notify("move_loop_restart");
		return 1;
	}

	self pushplayer(0);
	return 0;
}

//Function Number: 24
func_10CB()
{
	if(!isdefined(self.var_10CC) || !isdefined(self.var_10CD))
	{
		return;
	}

	self endon("killanimscript");
	self endon("move_interrupt");
	for(;;)
	{
		self waittill("path_need_dodge",var_00,var_01);
		if(animscripts/utility::func_A69())
		{
			self.nododgemove = 0;
			return;
		}

		if(!issentient(var_00))
		{
			continue;
		}

		var_02 = vectornormalize(var_01 - self.origin);
		if(self.var_773[0] * var_02[1] - var_02[0] * self.var_773[1] > 0)
		{
			if(!func_10CA(self.var_10CD,self.var_10CE))
			{
				func_10CA(self.var_10CC,self.var_10CF);
			}
		}
		else if(!func_10CA(self.var_10CC,self.var_10CF))
		{
			func_10CA(self.var_10CD,self.var_10CE);
		}

		if(isdefined(self.var_10AA))
		{
			wait getanimlength(self.var_10AA);
			continue;
		}

		wait 0.1;
	}
}

//Function Number: 25
func_10D0(param_00,param_01)
{
	self.nododgemove = 1;
	self.var_10CC = param_00;
	self.var_10CD = param_01;
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	self.var_10CF = getmovedelta(param_00,0,var_02);
	var_02 = 1;
	if(animhasnotetrack(param_01,"code_move"))
	{
		var_02 = getnotetracktimes(param_01,"code_move")[0];
	}

	self.var_10CE = getmovedelta(param_01,0,var_02);
	self.interval = 80;
}

//Function Number: 26
func_10D1()
{
	self.nododgemove = 0;
	self.var_10CC = undefined;
	self.var_10CD = undefined;
	self.var_10CF = undefined;
	self.var_10CE = undefined;
}

//Function Number: 27
func_10D2()
{
	self endon("killanimscript");
	for(;;)
	{
		if(isdefined(self.enemy) && isai(self.enemy) || isdefined(self.var_10D3))
		{
			if(abs(self getmotionangle()) <= 135)
			{
				animscripts/melee::func_1009();
			}
		}

		wait 0.1;
	}
}

//Function Number: 28
func_10D4()
{
	self endon("killanimscript");
	if(isdefined(self.disablebulletwhizbyreaction))
	{
		return;
	}

	for(;;)
	{
		self waittill("bulletwhizby",var_00);
		if(self.movemode != "run" || !self.var_781 || self.a.pose != "stand" || isdefined(self.var_FCF))
		{
			continue;
		}

		if(self.var_786 != "none")
		{
			continue;
		}

		if(!isdefined(self.enemy) && !self.ignoreall && isdefined(var_00.team) && isenemyteam(self.team,var_00.team))
		{
			self.var_F24 = var_00;
			self animcustom(::animscripts/reactions::func_F23);
			continue;
		}

		if(self.var_775 || self.var_774 < 100)
		{
			continue;
		}

		if(isdefined(self.pathgoalpos) && distancesquared(self.origin,self.pathgoalpos) < 10000)
		{
			wait 0.2;
			continue;
		}

		self.var_FD1 = gettime();
		self notify("move_loop_restart");
		animscripts/run::func_FE2();
	}
}

//Function Number: 29
func_10D5(param_00,param_01)
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
func_10D6(param_00,param_01,param_02)
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

	self.a.array = var_7B;
}

//Function Number: 31
func_10D7(param_00,param_01)
{
	if(self.a.pose == "stand" && param_01.type != "Cover Stand" || param_00.type != "Cover Stand")
	{
		self.a.pose = "crouch";
		return 0;
	}

	return 1;
}

//Function Number: 32
func_10D8(param_00)
{
	if(self.a.pose == "crouch" && param_00.type == "Cover Stand")
	{
		self.a.pose = "stand";
		return 0;
	}

	return 1;
}

//Function Number: 33
func_10D9()
{
	self endon("killanimscript");
	self endon("goal_changed");
	var_00 = self.var_F75;
	self.var_F74 = undefined;
	self.var_F75 = undefined;
	self.var_10DA = 1;
	if(!isdefined(self.var_79E))
	{
		return;
	}

	if(!isdefined(self.node) || !isdefined(var_00) || self.node != var_00)
	{
		return;
	}

	var_01 = self.var_79E;
	var_02 = self.node;
	var_03 = var_02.origin - self.origin;
	if(lengthsquared(var_03) < 1)
	{
		return;
	}

	var_03 = vectornormalize(var_03);
	var_04 = anglestoforward(var_02.angles);
	var_05 = var_04[0] * var_03[1] - var_04[1] * var_03[0] > 0;
	if(func_10DC(var_05,var_01,var_02))
	{
		return;
	}

	if(func_10D7(var_01,var_02))
	{
		var_06 = 0.1;
	}
	else
	{
		var_06 = 0.4;
	}

	func_10D6(var_05,var_01,var_02);
	self animmode("zonly_physics",0);
	self clearanim(%body,var_06);
	var_07 = animscripts/utility::func_D4D("shuffle_start");
	var_08 = animscripts/utility::func_D4D("shuffle");
	var_09 = animscripts/utility::func_D4D("shuffle_end");
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
		self orientmode("face angle",animscripts/utility::func_F41(var_01));
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
	animscripts/notetracks::func_D4F(var_11,"shuffle");
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

		animscripts/notetracks::func_D4F(var_11,"shuffle");
	}

	if(var_0F)
	{
		if(func_10D8(var_02))
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
	self.var_10DA = undefined;
}

//Function Number: 34
func_10DB()
{
	if(isdefined(self.var_10DA))
	{
		self clearanim(%cover_shuffle,0.2);
		self.var_10DA = undefined;
		self animmode("none",0);
		self orientmode("face default");
		return;
	}

	wait 0.2;
	self clearanim(%cover_shuffle,0.2);
}

//Function Number: 35
func_10DC(param_00,param_01,param_02)
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
	animscripts/shared::donotetracks("sideToSide",::func_10DD);
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
		thread func_10DE(var_0C,var_0B);
	}

	animscripts/shared::donotetracks("sideToSide");
	self safeteleport(param_02.origin);
	self animmode("none");
	self orientmode("face default");
	self.var_10DA = undefined;
	wait 0.2;
	return 1;
}

//Function Number: 36
func_10DD(param_00)
{
	if(param_00 == "slide_start")
	{
		return 1;
	}
}

//Function Number: 37
func_10DE(param_00,param_01)
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
func_0FBE(param_00,param_01)
{
	self endon("movemode");
	self clearanim(%combatrun,0.6);
	self setanimknoball(%combatrun,%body,1,0.5,self.moveplaybackrate);
	if(isdefined(self.var_FD1) && gettime() - self.var_FD1 < 100 && isdefined(self.var_FD4) && randomfloat(1) < self.a.var_FDD)
	{
		animscripts/run::func_FD3();
		return;
	}

	if(isarray(param_00))
	{
		if(isdefined(self.run_override_weights))
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