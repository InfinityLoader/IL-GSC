/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\melee.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 59
 * Decompile Time: 1065 ms
 * Timestamp: 10/27/2023 2:18:26 AM
*******************************************************************/

//Function Number: 1
func_1006()
{
	precachemodel("weapon_parabolic_knife");
	level._effect["melee_knife_ai"] = loadfx("impacts/flesh_hit_knife");
}

//Function Number: 2
func_1007()
{
	if(!isdefined(self._stealth))
	{
		return 0;
	}

	if(isdefined(self.ent_flag) && isdefined(self.ent_flag["_stealth_enabled"]) && self.ent_flag["_stealth_enabled"])
	{
		if(isdefined(self.ent_flag["_stealth_attack"]) && !self.ent_flag["_stealth_attack"])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 3
func_1009()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}

	if(isdefined(self.dontmelee))
	{
		return 0;
	}

	if(func_1007())
	{
		return 0;
	}

	if(!func_1073(self.enemy))
	{
		return 0;
	}

	func_100B();
	if(!func_100F())
	{
		func_1074(self.enemy);
		return 0;
	}

	self animcustom(::func_1020,::func_1072);
}

//Function Number: 4
func_100B()
{
	self.melee.target = self.enemy;
	self.melee.var_100D = 0;
	self.melee.var_100E = 0;
}

//Function Number: 5
func_100F()
{
	if(!func_1016())
	{
		return 0;
	}

	self.melee.var_100D = 1;
	if(func_1040())
	{
		self.melee.func = ::func_1047;
		return 1;
	}

	if(func_1025())
	{
		if(isdefined(self.var_1010))
		{
			self.melee.func = self.var_1010;
		}
		else
		{
			self.melee.func = ::func_1029;
		}

		return 1;
	}

	self.melee.func = undefined;
	self.var_1011 = gettime() + 150;
	self.var_1012 = self.melee.target;
	return 0;
}

//Function Number: 6
func_1013()
{
	var_00 = 1;
	var_01 = distance2d(self.melee.startpos,self.melee.target.origin);
	if(var_01 < 32)
	{
		var_02 = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0],self.melee.startpos[1] - self.melee.target.origin[1],0));
		self.melee.startpos = self.melee.startpos + var_02 * 32 - var_01;
		var_00 = 0;
	}

	var_03 = self getdroptofloorposition(self.melee.startpos);
	if(!isdefined(var_03))
	{
		return 0;
	}

	if(abs(self.melee.startpos[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	if(abs(self.origin[2] - var_03[2]) > 51.2)
	{
		return 0;
	}

	self.melee.startpos = var_03;
	if(!self maymovetopoint(self.melee.startpos,1,var_00))
	{
		return 0;
	}

	if(isdefined(self.melee.var_1015))
	{
		var_04 = self.melee.startpos - self.melee.target.origin;
		var_05 = anglestoforward(self.melee.var_1015);
		var_06 = vectordot(var_05,var_04);
		var_07 = self.melee.startpos - var_05 * var_06;
		var_08 = self.melee.target.origin - var_07;
		var_09 = distance2d(self.melee.target.origin,var_07);
		if(var_09 < 32)
		{
			var_07 = var_07 - var_08 * 32 - var_09 / 32;
		}
	}
	else
	{
		var_02 = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0],self.melee.startpos[1] - self.melee.target.origin[1],0));
		var_07 = self.melee.target.origin + var_02 * 32;
	}

	if(!self maymovefrompointtopoint(self.melee.startpos,var_07,1,0))
	{
		return 0;
	}

	if(!self maymovefrompointtopoint(var_07,self.melee.target.origin,1,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_1016()
{
	if(!isdefined(self.melee.target))
	{
		return 0;
	}

	var_00 = self.melee.target;
	if(isdefined(var_00.dontmelee))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,var_00.origin);
	if(isdefined(self.var_1017))
	{
		var_02 = self.var_1017;
	}
	else if(isplayer(var_01))
	{
		var_02 = -25536;
	}
	else
	{
		var_02 = 25600;
	}

	if(!self.melee.var_100D && var_01 > var_02)
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(isdefined(self.a.var_1018) && self.a.var_1019 >= gettime() + 50)
	{
		return 0;
	}

	if(isdefined(self.var_1011) && isdefined(self.var_1012) && gettime() < self.var_1011 && self.var_1012 == var_00)
	{
		return 0;
	}

	if(isdefined(self.a.var_D29) || self.a.pose == "prone")
	{
		return 0;
	}

	if(animscripts/utility::func_C95())
	{
		return 0;
	}

	if(isdefined(self.var_73C) && self.var_772 == 1)
	{
		return 0;
	}

	if(!isalive(var_00))
	{
		return 0;
	}

	if(isdefined(var_00.var_FA0) || isdefined(var_00.ignoreme) && var_00.ignoreme)
	{
		return 0;
	}

	if(!isai(var_00) && !isplayer(var_00))
	{
		return 0;
	}

	if(isai(var_00))
	{
		if(var_00 isinscriptedstate())
		{
			return 0;
		}

		if(var_00 maps\_utility::doinglongdeath() || var_00.var_744)
		{
			return 0;
		}
	}

	if(isplayer(var_00))
	{
		var_03 = var_00 getstance();
	}
	else
	{
		var_03 = var_01.a.pose;
	}

	if(var_03 != "stand" && var_03 != "crouch")
	{
		return 0;
	}

	if(isdefined(self.magic_bullet_shield) && isdefined(var_00.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_00.var_73C))
	{
		return 0;
	}

	if(self.melee.var_100E)
	{
		var_04 = 110;
	}
	else
	{
		var_04 = 60;
	}

	var_05 = angleclamp180(self.angles[1] - animscripts/utility::func_101A(var_00.origin));
	if(abs(var_05) > var_04)
	{
		return 0;
	}

	if(var_01 <= 4096)
	{
		return 1;
	}

	if(self.melee.var_100E)
	{
		return 0;
	}

	if(isdefined(self.var_101B) && isdefined(self.var_101C) && gettime() < self.var_101B && self.var_101C == var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_101D()
{
	self.melee.var_101E = 1;
	self.a.movement = "run";
}

//Function Number: 9
func_101F()
{
	self clearanim(%body,0.2);
	self.melee.var_101E = undefined;
	self.a.movement = "stop";
	self orientmode("face default");
}

//Function Number: 10
func_1020()
{
	self endon("killanimscript");
	self endon("end_melee");
	for(;;)
	{
		var_00 = self.melee.func;
		[[ self.melee.func ]]();
		if(!isdefined(self.melee.func) || var_00 == self.melee.func)
		{
			break;
		}
	}
}

//Function Number: 11
func_1021(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	self.var_1022 = gettime() + 2500;
	self.var_1023 = param_00;
}

//Function Number: 12
func_1024()
{
	var_00 = distancesquared(self.melee.target.origin,self.origin);
	if(var_00 > 4096 && isdefined(self.var_1022) && isdefined(self.var_1023) && gettime() < self.var_1022 && self.var_1023 == self.melee.target)
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_1025()
{
	if(isdefined(self.melee.target.magic_bullet_shield))
	{
		return 0;
	}

	if(!func_1024())
	{
		return 0;
	}

	if(isdefined(self.melee.target.var_1026))
	{
		return 0;
	}

	return func_102B();
}

//Function Number: 14
func_1027()
{
	if(isdefined(self.var_1017))
	{
		var_00 = self.var_1017;
	}
	else if(isplayer(self.melee.target))
	{
		var_00 = -25536;
	}
	else
	{
		var_00 = 25600;
	}

	if(distancesquared(self.origin,self.melee.target.origin) > var_00)
	{
		self.melee.var_1028 = gettime() + 3000;
		return;
	}

	self.melee.var_1028 = gettime() + 1000;
}

//Function Number: 15
func_1029()
{
	self animmode("zonly_physics");
	if(isdefined(self.melee.target))
	{
		func_1027();
	}

	while(isdefined(self.melee.target))
	{
		if(!func_102D())
		{
			self.var_101B = gettime() + 1500;
			self.var_101C = self.melee.target;
			break;
		}

		if(!isdefined(self.melee.target))
		{
			break;
		}

		animscripts/battlechatter_ai::func_B37();
		self orientmode("face point",self.melee.target.origin);
		self setflaggedanimknoballrestart("meleeanim",%melee_1,%body,1,0.2,1);
		self.melee.var_100E = 1;
		if(!func_102A())
		{
			func_1021(self.melee.target);
			break;
		}
	}

	self animmode("none");
}

//Function Number: 16
func_102A()
{
	for(;;)
	{
		self waittill("meleeanim",var_00);
		if(var_00 == "end")
		{
			return 1;
		}

		if(var_00 == "stop")
		{
			if(!func_100F())
			{
				return 0;
			}

			if(self.melee.func != ::func_1029)
			{
				return 1;
			}
		}

		if(var_00 == "fire")
		{
			if(isdefined(self.melee.target))
			{
				var_01 = self.melee.target.health;
				self melee();
				if(isdefined(self.melee.target) && self.melee.target.health < var_01)
				{
					func_1027();
				}
			}
		}
	}
}

//Function Number: 17
func_102B()
{
	if(!isdefined(self.melee.target))
	{
		return 0;
	}

	if(!func_1016())
	{
		return 0;
	}

	var_00 = vectornormalize(self.melee.target.origin - self.origin);
	self.melee.startpos = self.melee.target.origin - 40 * var_00;
	return func_1013();
}

//Function Number: 18
func_102C(param_00,param_01)
{
	var_02 = (param_00[0] - param_01[0],param_00[1] - param_01[1],0);
	return lengthsquared(var_02);
}

//Function Number: 19
func_102D()
{
	if(!func_102B())
	{
		return 0;
	}

	var_00 = func_102C(self.origin,self.melee.target.origin);
	if(var_00 <= 4096)
	{
		self setflaggedanimknoball("readyanim",%stand_2_melee_1,%body,1,0.3,1);
		animscripts/shared::donotetracks("readyanim");
		return 1;
	}

	func_102E();
	var_01 = self.melee.target.origin;
	var_02 = 0.1;
	var_03 = length(getmovedelta(%run_2_melee_charge,0,1));
	var_04 = 32;
	var_05 = 48 + var_04 + var_03;
	var_06 = var_05 * var_05;
	var_07 = 64 + var_04;
	var_08 = var_07 * var_07;
	var_09 = getanimlength(%run_2_melee_charge) * 1000;
	var_0A = var_09 - 100;
	var_0B = var_09 - 200;
	var_0C = 0;
	var_0D = undefined;
	var_0E = %run_lowready_f;
	if(isplayer(self.melee.target) && self.melee.target == self.enemy)
	{
		self orientmode("face enemy");
	}
	else
	{
		self orientmode("face point",self.melee.target.origin);
	}

	self setflaggedanimknoball("chargeanim",var_0E,%body,1,0.3,1);
	var_0F = 0;
	for(;;)
	{
		var_10 = gettime();
		var_11 = isdefined(var_0D) && var_0D <= var_06;
		if(!var_0F)
		{
			if(var_11)
			{
				func_101D();
				self setflaggedanimknoballrestart("chargeanim",%run_2_melee_charge,%body,1,0.2,1);
				var_0C = var_10;
				var_0F = 1;
			}
		}
		else
		{
			var_12 = var_00 <= var_06;
			if(var_10 - var_0C >= var_0A || !var_11 && !var_12)
			{
				func_101D();
				self setflaggedanimknoball("chargeanim",var_0E,%body,1,0.3,1);
				var_0F = 0;
			}
		}

		animscripts/notetracks::func_D4F(var_02,"chargeanim");
		if(!func_102B())
		{
			func_101F();
			return 0;
		}

		var_00 = func_102C(self.origin,self.melee.target.origin);
		var_13 = self.melee.target.origin - var_01 * 1 / gettime() - var_10;
		var_01 = self.melee.target.origin;
		var_14 = self.melee.target.origin + var_13 * var_0B;
		var_0D = func_102C(self.origin,var_14);
		if(var_0F && var_00 <= var_08 && gettime() - var_0C >= var_0A || !isplayer(self.melee.target))
		{
			break;
		}

		if(!var_0F && gettime() >= self.melee.var_1028)
		{
			func_101F();
			return 0;
		}
	}

	func_101F();
	return 1;
}

//Function Number: 20
func_102E()
{
	if(!isdefined(self.a.var_102F))
	{
		self.a.var_102F = 0;
	}

	if((isdefined(self.enemy) && isplayer(self.enemy)) || randomint(3) == 0)
	{
		if(gettime() > self.a.var_102F)
		{
			animscripts/face::func_C41("meleecharge");
			self.a.var_102F = gettime() + 8000;
		}
	}
}

//Function Number: 21
func_1030(param_00)
{
	var_01 = 90;
	if(self.melee.var_100E)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.melee.target;
	func_103C();
	if(self.melee.winner)
	{
		self.melee.animname = %melee_f_awin_attack;
		var_02.melee.animname = %melee_f_awin_defend;
		var_02.melee.var_1033 = %melee_f_awin_defend_survive;
	}
	else
	{
		self.melee.animname = %melee_f_dwin_attack;
		var_02.melee.animname = %melee_f_dwin_defend;
	}

	return 1;
}

//Function Number: 22
func_1034(param_00)
{
	var_01 = 100;
	if(self.melee.var_100E)
	{
		var_01 = var_01 + 50;
	}

	if(abs(param_00) < var_01)
	{
		return 0;
	}

	var_02 = self.melee.target;
	if(isdefined(var_02.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_02.meleealwayswin))
	{
		return 0;
	}

	self.melee.winner = 1;
	self.melee.animname = %bog_melee_r_attack;
	var_02.melee.animname = %bog_melee_r_defend;
	var_02.melee.var_1033 = %bog_melee_r_backdeath2;
	return 1;
}

//Function Number: 23
func_1036(param_00)
{
	if(-90 > param_00 || param_00 > 0)
	{
		return 0;
	}

	var_01 = self.melee.target;
	if(isdefined(var_01.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(var_01.meleealwayswin))
	{
		return 0;
	}

	self.melee.winner = 1;
	self.melee.animname = %melee_sync_attack;
	var_01.melee.animname = %melee_sync_defend;
	return 1;
}

//Function Number: 24
func_1037()
{
	if(isdefined(self.var_1038))
	{
		var_00[0] = ::func_1030;
	}
	else if(isdefined(self.var_1039))
	{
		var_00[0] = ::func_1034;
	}
	else
	{
		var_01 = randomint(2);
		var_02 = 1 - var_01;
		var_03 = 2;
		var_00[var_01] = ::func_1030;
		var_00[var_02] = ::func_1034;
		var_00[var_03] = ::func_1036;
	}

	return var_00;
}

//Function Number: 25
func_103A()
{
	var_00 = self.melee.target;
	var_01 = vectortoangles(var_00.origin - self.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	var_03 = func_1037();
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if([[ var_03[var_04] ]](var_02))
		{
			self.melee.var_103B = (0,var_01[1],0);
			self.melee.startpos = getstartorigin(var_00.origin,var_00.angles,self.melee.animname);
			if(func_1013())
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 26
func_103C()
{
	var_00 = self.melee.target;
	if(isdefined(self.meleealwayswin))
	{
		self.melee.winner = 1;
		return;
	}
	else if(isdefined(var_00.meleealwayswin))
	{
		self.melee.winner = 0;
		return;
	}

	if(isdefined(self.magic_bullet_shield))
	{
		self.melee.winner = 1;
		return;
	}

	if(isdefined(var_00.magic_bullet_shield))
	{
		self.melee.winner = 0;
		return;
	}

	self.melee.winner = common_scripts\utility::cointoss();
}

//Function Number: 27
func_103D()
{
	var_00 = self.melee.target;
	func_103C();
	if(var_00.var_CAF.type == "Cover Left")
	{
		if(self.melee.winner)
		{
			self.melee.animname = %cornersdl_melee_wina_attacker;
			var_00.melee.animname = %cornersdl_melee_wina_defender;
			var_00.melee.var_1033 = %cornersdl_melee_wina_defender_survive;
		}
		else
		{
			self.melee.animname = %cornersdl_melee_wind_attacker;
			self.melee.var_1033 = %cornersdl_melee_wind_attacker_survive;
			var_00.melee.animname = %cornersdl_melee_wind_defender;
		}
	}
	else if(self.melee.winner)
	{
		self.melee.animname = %cornersdr_melee_wina_attacker;
		var_00.melee.animname = %cornersdr_melee_wina_defender;
	}
	else
	{
		self.melee.animname = %cornersdr_melee_wind_attacker;
		var_00.melee.animname = %cornersdr_melee_wind_defender;
	}

	self.melee.startpos = getstartorigin(var_00.var_CAF.origin,var_00.var_CAF.angles,self.melee.animname);
	self.melee.var_103B = (var_00.var_CAF.angles[0],angleclamp180(var_00.var_CAF.angles[1] + 180),var_00.var_CAF.angles[2]);
	var_00.melee.var_103E = animscripts/utility::func_F41(var_00.var_CAF);
	self.melee.var_1015 = var_00.var_CAF.angles;
	if(!func_1013())
	{
		self.melee.var_1015 = undefined;
		return 0;
	}

	return 1;
}

//Function Number: 28
func_103F()
{
	var_00 = self.melee.target.var_CAF;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(distancesquared(var_00.origin,self.melee.target.origin) > 16 && isdefined(self.melee.target.a.var_CF8) && self.melee.target.a.var_CF8 != "hide" && self.melee.target.a.var_CF8 != "lean")
	{
		return 0;
	}

	var_01 = vectortoangles(self.origin - var_00.origin);
	var_02 = angleclamp180(var_00.angles[1] - var_01[1]);
	if(var_00.type == "Cover Left")
	{
		if(var_02 >= -50 && var_02 <= 0)
		{
			return 1;
		}
	}
	else if(var_00.type == "Cover Right")
	{
		if(var_02 >= 0 && var_02 <= 50)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 29
func_1040()
{
	var_00 = self.melee.target;
	if(!isai(var_00) || var_00.type != "human")
	{
		return 0;
	}

	if(self.var_786 != "none" || var_00.var_786 != "none")
	{
		return 0;
	}

	if(isdefined(self.meleealwayswin) && isdefined(var_00.meleealwayswin))
	{
		return 0;
	}

	if(isdefined(self.magic_bullet_shield) && isdefined(var_00.magic_bullet_shield))
	{
		return 0;
	}

	if((isdefined(self.meleealwayswin) && isdefined(var_00.magic_bullet_shield)) || isdefined(var_00.meleealwayswin) && isdefined(self.magic_bullet_shield))
	{
		return 0;
	}

	if(isdefined(self.var_1026))
	{
		if(![[ self.var_1026 ]]())
		{
			return 0;
		}

		self.melee.var_1041 = 1;
	}
	else if(isdefined(var_00.var_1026))
	{
		return 0;
	}
	else if(func_103F() && func_103D())
	{
		self.melee.var_1041 = 1;
	}
	else
	{
		if(!func_103A())
		{
			return 0;
		}

		self.melee.var_1041 = 0;
	}

	if(!isdefined(var_00.melee.var_103E))
	{
		var_00.melee.var_103E = var_00.angles[1];
	}

	self.melee.var_1042 = self.melee.startpos - var_00.origin;
	return 1;
}

//Function Number: 30
func_1043(param_00)
{
	self.melee.var_1044 = param_00;
	param_00.melee.var_1044 = undefined;
}

//Function Number: 31
func_1045(param_00)
{
	if(!isdefined(param_00.melee))
	{
		return;
	}

	func_102E();
	if(!isalive(param_00))
	{
		return;
	}

	self.var_78A = param_00;
	param_00.var_78A = self;
	self.melee.var_1046 = 1;
	param_00.melee.var_1046 = 1;
	self linktoblendtotag(param_00,"tag_sync",1,1);
}

//Function Number: 32
func_1047()
{
	if(!func_1051())
	{
		self.var_101B = gettime() + 1500;
		self.var_101C = self.melee.target;
		return;
	}

	var_00 = self.melee.target;
	func_1043(var_00);
	if(self.melee.winner)
	{
		self.melee.death = undefined;
		var_00.melee.death = 1;
	}
	else
	{
		var_00.melee.death = undefined;
		self.melee.death = 1;
	}

	self.melee.var_1049 = var_00;
	var_00.melee.var_1049 = self;
	if(animscripts/utility::func_C95())
	{
		maps\_utility::forceuseweapon(self.primaryweapon,"primary");
		self.lastweapon = self.primaryweapon;
	}

	if(var_00 animscripts/utility::func_C95())
	{
		var_00 maps\_utility::forceuseweapon(var_00.primaryweapon,"primary");
		var_00.lastweapon = var_00.primaryweapon;
	}

	self.melee.weapon = self.weapon;
	self.melee.var_104C = animscripts/utility::func_104B();
	var_00.melee.weapon = var_00.weapon;
	var_00.melee.var_104C = var_00 animscripts/utility::func_104B();
	self.melee.var_100E = 1;
	var_00 animcustom(::func_1052,::func_1072);
	var_00 thread func_104D(self);
	self.melee.target = undefined;
	func_1052();
}

//Function Number: 33
func_104D(param_00)
{
	self endon("end_melee");
	self endon("melee_aivsai_execute");
	wait 0.1;
	if(isdefined(param_00))
	{
		param_00 notify("end_melee");
	}

	self notify("end_melee");
}

//Function Number: 34
func_104E(param_00,param_01)
{
	if(isdefined(param_01) && param_01 <= gettime())
	{
		return 0;
	}

	if(!func_1016())
	{
		return 0;
	}

	var_02 = self.melee.target;
	var_03 = distancesquared(var_02.origin,param_00);
	if(self.melee.var_1041)
	{
		var_04 = 256;
	}
	else
	{
		var_04 = 1296;
	}

	if(var_03 > var_04)
	{
		return 0;
	}

	self.melee.startpos = var_02.origin + self.melee.var_1042;
	if(!func_1013())
	{
		return 0;
	}

	return 1;
}

//Function Number: 35
func_104F(param_00)
{
	var_01 = distancesquared((self.origin[0],self.origin[1],0),(self.melee.startpos[0],self.melee.startpos[1],0));
	if(var_01 < 64 && abs(self.melee.startpos[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	var_02 = distancesquared((param_00[0],param_00[1],0),(self.melee.startpos[0],self.melee.startpos[1],0));
	var_03 = distancesquared((self.origin[0],self.origin[1],0),(self.melee.target.origin[0],self.melee.target.origin[1],0));
	if(var_02 > var_03 && abs(self.melee.target.origin[2] - self.origin[2]) < 64)
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
func_1050(param_00)
{
	func_101F();
	if(self.melee.var_1041)
	{
		self forceteleport(self.melee.startpos,self.melee.var_103B);
		wait 0.05;
	}
	else
	{
		self orientmode("face angle",self.melee.var_103B[1]);
		wait 0.05;
	}

	return func_104E(param_00);
}

//Function Number: 37
func_1051()
{
	if(!func_1016())
	{
		return 0;
	}

	func_101D();
	self clearanim(%body,0.2);
	self setanimknoball(animscripts/run::func_FC2(),%body,1,0.2);
	self animmode("zonly_physics");
	self.var_766 = 1;
	var_00 = gettime() + 1500;
	var_01 = self.melee.target.origin;
	while(func_104E(var_01,var_00))
	{
		if(func_104F(var_01))
		{
			return func_1050(var_01);
		}

		self orientmode("face point",self.melee.startpos);
		wait 0.05;
	}

	func_101F();
	return 0;
}

//Function Number: 38
func_1052()
{
	self endon("killanimscript");
	self endon("end_melee");
	self notify("melee_aivsai_execute");
	self animmode("zonly_physics");
	self.a.var_D19 = "none";
	self.var_D4B = undefined;
	thread func_105C();
	thread func_105F();
	if(isdefined(self.melee.var_103E))
	{
		self orientmode("face angle",self.melee.var_103E);
	}
	else
	{
		self orientmode("face current");
	}

	self.a.pose = "stand";
	self clearanim(%body,0.2);
	if(isdefined(self.melee.death))
	{
		func_1054();
	}

	self setflaggedanimknoballrestart("meleeAnim",self.melee.animname,%body,1,0.2);
	var_00 = animscripts/shared::donotetracks("meleeAnim",::func_1068);
	if(var_00 == "melee_death" && isdefined(self.melee.var_1053))
	{
		func_105A();
		self setflaggedanimknoballrestart("meleeAnim",self.melee.var_1033,%body,1,0.2);
		var_00 = animscripts/shared::donotetracks("meleeAnim",::func_1068);
	}

	if(isdefined(self.melee) && isdefined(self.melee.death))
	{
		self kill();
	}

	self.var_766 = 0;
}

//Function Number: 39
func_1054()
{
	self.melee.var_1055 = self.allowpain;
	self.melee.var_1056 = self.flashbangimmunity;
	maps\_utility::disable_pain();
	maps\_utility::setflashbangimmunity(1);
}

//Function Number: 40
func_1059()
{
	return isdefined(self.melee.weapon) && self.melee.weapon != "none" && self.weapon != self.melee.weapon;
}

//Function Number: 41
func_105A()
{
	if(self.weapon != "none" && self.lastweapon != "none")
	{
		return;
	}

	if(!isdefined(self.melee.weapon) || self.melee.weapon == "none")
	{
		return;
	}

	maps\_utility::forceuseweapon(self.melee.weapon,self.melee.var_104C);
	if(isdefined(self.melee.var_105B))
	{
		self.melee.var_105B delete();
		self.melee.var_105B = undefined;
	}
}

//Function Number: 42
func_105C()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("weapon_dropped",var_00);
	if(isdefined(var_00))
	{
		self.melee.var_105B = var_00;
	}
}

//Function Number: 43
func_105D()
{
	if(!isdefined(self.melee.var_1033))
	{
		return 0;
	}

	if(!isdefined(self.melee.var_105E))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_105F()
{
	self endon("killanimscript");
	self endon("end_melee");
	self waittill("partner_end_melee");
	if(isdefined(self.melee.death))
	{
		if(isdefined(self.melee.var_1060) || isdefined(self.melee.var_1061))
		{
			self kill();
			return;
		}

		self.melee.death = undefined;
		if(func_105D())
		{
			self.melee.var_1053 = 1;
			return;
		}

		self notify("end_melee");
		return;
	}

	if(!isdefined(self.melee.var_1062))
	{
		self notify("end_melee");
	}
}

//Function Number: 45
func_1063()
{
	if(!isdefined(self.melee.var_1046))
	{
		return;
	}

	if(isdefined(self.var_78A))
	{
		self.var_78A func_1064();
	}

	func_1064();
}

//Function Number: 46
func_1064()
{
	self unlink();
	self.var_78A = undefined;
	if(!isalive(self))
	{
		return;
	}

	self.melee.var_1046 = undefined;
	self animmode("zonly_physics");
	self orientmode("face angle",self.angles[1]);
}

//Function Number: 47
func_1065()
{
	func_1063();
	self.melee.var_1062 = 1;
	if(isdefined(self.melee.var_1049) && isdefined(self.melee.var_1049.melee))
	{
		self.melee.var_1049.melee.var_1062 = 1;
	}
}

//Function Number: 48
func_1066()
{
	if(animhasnotetrack(self.melee.animname,"melee_death"))
	{
		return 0;
	}

	return isdefined(self.melee.death);
}

//Function Number: 49
func_1067(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		self.melee.var_1061 = 1;
		return;
	}

	self.melee.var_1060 = 1;
}

//Function Number: 50
func_1068(param_00)
{
	if(issubstr(param_00,"ps_"))
	{
		var_01 = getsubstr(param_00,3);
		self playsound(var_01);
		return;
	}

	if(var_01 == "sync")
	{
		if(isdefined(self.melee.var_1044))
		{
			func_1045(self.melee.var_1044);
			self.melee.var_1044 = undefined;
			return;
		}

		return;
	}

	if(var_01 == "unsync")
	{
		func_1065();
		if(func_1066())
		{
			func_1067();
			return;
		}

		return;
	}

	if(var_01 == "melee_interact")
	{
		self.melee.var_105E = 1;
		return;
	}

	if(var_01 == "melee_death")
	{
		if(isdefined(self.melee.var_1053))
		{
			return var_01;
		}

		func_1067();
		if(isdefined(self.melee.var_1060))
		{
			return var_01;
		}

		return;
	}

	if(var_01 == "attach_knife")
	{
		self attach("weapon_parabolic_knife","TAG_INHAND",1);
		self.melee.var_1069 = 1;
		return;
	}

	if(var_01 == "detach_knife")
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
		self.melee.var_1069 = undefined;
		return;
	}

	if(var_01 == "stab")
	{
		self playsound("melee_knife_hit_body");
		playfxontag(level._effect["melee_knife_ai"],self,"TAG_KNIFE_FX");
		if(isdefined(self.melee.var_1049) && isdefined(self.melee.var_1049.melee))
		{
			self.melee.var_1049 func_1067(1);
			return;
		}

		return;
	}
}

//Function Number: 51
func_106A()
{
	self endon("end_melee");
	animscripts/shared::func_D73();
	return 0;
}

//Function Number: 52
func_106B()
{
	self endon("end_melee");
	animscripts/notetracks::func_106C("meleeAnim",10);
	animscripts/shared::func_D73();
	self startragdoll();
	return 1;
}

//Function Number: 53
func_106D()
{
	if(!isalive(self) && isdefined(self.melee.death))
	{
		if(isdefined(self.melee.var_1060))
		{
			self.deathfunction = ::func_106B;
			return;
		}

		self.deathfunction = ::func_106A;
	}
}

//Function Number: 54
func_106E()
{
	if(!isalive(self))
	{
		return;
	}

	if(isdefined(self.melee.var_101E))
	{
		func_101F();
	}

	var_00 = self getdroptofloorposition();
	if(isdefined(var_00))
	{
		self forceteleport(var_00,self.angles);
	}
}

//Function Number: 55
func_106F()
{
	if(isdefined(self.melee.var_1069))
	{
		self detach("weapon_parabolic_knife","TAG_INHAND",1);
	}

	if(isalive(self))
	{
		func_105A();
	}
}

//Function Number: 56
func_1070()
{
	if(isdefined(self.melee.var_1055))
	{
		if(self.melee.var_1055)
		{
			maps\_utility::enable_pain();
		}
		else
		{
			maps\_utility::disable_pain();
		}
	}

	if(isdefined(self.melee.var_1056))
	{
		maps\_utility::setflashbangimmunity(self.melee.var_1056);
	}
}

//Function Number: 57
func_1072()
{
	func_1063();
	func_106D();
	func_106E();
	func_106F();
	func_1070();
	if(isdefined(self.melee.var_1049))
	{
		self.melee.var_1049 notify("partner_end_melee");
	}

	func_1074(self.melee.target);
}

//Function Number: 58
func_1073(param_00)
{
	if(isdefined(self.melee))
	{
		return 0;
	}

	if(isdefined(param_00.melee))
	{
		return 0;
	}

	self.melee = spawnstruct();
	param_00.melee = spawnstruct();
	return 1;
}

//Function Number: 59
func_1074(param_00)
{
	self.melee = undefined;
	if(isdefined(param_00))
	{
		param_00.melee = undefined;
	}
}