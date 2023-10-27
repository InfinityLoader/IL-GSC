/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_laststand.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 105
 * Decompile Time: 5173 ms
 * Timestamp: 10/27/2023 12:09:34 AM
*******************************************************************/

//Function Number: 1
func_373E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	func_500F(param_09);
}

//Function Number: 2
func_500F(param_00)
{
	var_01 = func_7682(self);
	if(var_01 && isdefined(level.endgame) && isdefined(level.end_game_string_index))
	{
		level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
	}

	if(player_in_laststand(self))
	{
		func_72A1(param_00);
		return;
	}

	func_5D2B(param_00,var_01);
}

//Function Number: 3
func_72A1(param_00)
{
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		self setorigin(param_00.origin);
	}

	self.var_2B6A = param_00;
	self notify("force_bleed_out");
}

//Function Number: 4
func_5D2B(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("last_stand",scripts\cp\_utility::getvalidtakeweapon());
	var_02 = scripts\cp\_utility::has_zombie_perk("perk_machine_revive");
	func_6610();
	func_6612();
	level.var_AA0B++;
	func_6616();
	if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && func_8C50())
	{
		if(scripts\cp\_utility::func_9BA0("self_revive") || scripts\common\utility::istrue(level.the_hoff_revive))
		{
			func_13701(param_00,param_01,var_02);
		}
		else
		{
			func_13703(param_00,param_01);
		}
	}
	else if(func_4F33())
	{
		func_13703(param_00,param_01);
	}
	else if(func_B4DC(param_01,param_00))
	{
		var_03 = func_13701(param_00,param_01);
		if(!var_03)
		{
			func_13703(param_00,param_01);
		}
	}
	else
	{
		func_13703(param_00,param_01);
	}

	self notify("revive");
	level notify("revive_success",self);
	func_6956();
	func_6952();
	func_6951();
}

//Function Number: 5
func_6616()
{
	self.inlaststand = 1;
	self.health = 1;
	scripts\common\utility::func_1C6E(0);
	self notify("healthRegeneration");
}

//Function Number: 6
func_6956()
{
	self laststandrevive();
	self setstance("stand");
	self.inlaststand = 0;
	self.health = func_7EF4();
	scripts\cp\_utility::func_7298();
}

//Function Number: 7
func_7EF4()
{
	return int(self.maxhealth);
}

//Function Number: 8
func_6612()
{
	lib_0A54::func_12E38(lib_0A54::func_7CE6(),"num_players_enter_laststand");
	var_00 = ["iw7_gunless_zm"];
	if(isdefined(level.additional_laststand_weapon_exclusion))
	{
		var_00 = scripts\common\utility::array_combine(var_00,level.additional_laststand_weapon_exclusion);
	}

	if(isdefined(self.former_mule_weapon))
	{
		var_00[var_00.size] = self.former_mule_weapon;
	}

	var_01 = [];
	foreach(var_03 in self getweaponslistprimaries())
	{
		if(!scripts\cp\_utility::isstrstart(var_03,"alt_"))
		{
			var_01[var_01.size] = var_03;
		}
	}

	self.var_B0A1 = var_01;
	scripts\cp\_utility::func_110AA(var_00,1);
	self.var_AA45 = func_6613(var_00,1);
	self.var_2B6A = undefined;
	self.saved_last_stand_pistol = self.var_A913;
	self.var_D7CE = self getweaponslistprimaries()[1];
	self.var_D7D0 = self getweaponammostock(self.var_D7CE);
	self.var_D7CF = self getweaponammoclip(self.var_D7CE);
	self.var_2A85 = 0;
	func_3D89();
	thread func_C553();
	scripts\cp\_persistence::func_11445(func_78F8(self),1,"laststand");
	scripts\cp\_persistence::func_666A("downs",1);
	scripts\cp\_persistence::increment_player_career_downs(self);
	scripts\cp\_analytics::func_93C1();
	scripts\cp\_challenge::func_12D9C("no_laststand");
	self stopgestureviewmodel();
}

//Function Number: 9
func_3D89()
{
	if(!isdefined(self.var_4643))
	{
		return;
	}

	if(scripts\cp\_utility::func_9BA0("just_a_flesh_wound"))
	{
		return;
	}

	var_00 = undefined;
	if(isdefined(self.var_AA45) && !scripts\common\utility::func_693B(self.var_4643,self.var_AA45))
	{
		self.var_4643 = scripts\common\utility::array_add(self.var_4643,self.var_AA45);
	}

	foreach(var_02 in self.var_4643)
	{
		if(scripts\cp\_weapon::func_8BD1(var_02,"doubletap"))
		{
			var_03 = strtok(var_02,"+");
			var_00 = var_03[0];
			for(var_04 = 1;var_04 < var_03.size;var_04++)
			{
				if(issubstr(var_03[var_04],"doubletap"))
				{
					continue;
				}

				var_00 = var_00 + "+" + var_03[var_04];
			}

			if(scripts\common\utility::func_2286(self.var_4643,var_02))
			{
				self.var_4643 = scripts\common\utility::func_22A9(self.var_4643,var_02);
				self.var_4643[self.var_4643.size] = var_00;
			}

			if(issubstr(self.var_464B,var_03[0]))
			{
				self.var_464B = var_00;
			}

			var_05 = getarraykeys(self.var_4648);
			var_06 = getarraykeys(self.var_464A);
			foreach(var_08 in var_05)
			{
				if(issubstr(var_08,var_03[0]))
				{
					if(var_00 != var_08)
					{
						self.var_4648[var_00] = self.var_4648[var_08];
						self.var_4648[var_08] = undefined;
					}
				}
			}

			foreach(var_0B in var_06)
			{
				if(issubstr(var_0B,var_03[0]))
				{
					if(var_00 != var_0B)
					{
						self.var_464A[var_00] = self.var_464A[var_0B];
						self.var_464A[var_0B] = undefined;
					}
				}
			}

			if(issubstr(self.var_AA45,var_03[0]))
			{
				self.var_AA45 = var_00;
			}

			if(issubstr(self.var_D7CE,var_03[0]))
			{
				self.var_D7CE = var_00;
			}
		}
	}
}

//Function Number: 10
func_6613(param_00,param_01)
{
	var_02 = scripts\cp\_utility::getvalidtakeweapon(param_00);
	if(isdefined(self.var_D7AB))
	{
		var_02 = self.var_D7AB;
	}

	var_03 = 0;
	if(var_02 == "none")
	{
		var_03 = 1;
	}
	else if(scripts\common\utility::func_2286(param_00,var_02))
	{
		var_03 = 1;
	}
	else if(scripts\common\utility::func_2286(param_00,getweaponbasename(var_02)))
	{
		var_03 = 1;
	}
	else if(scripts\common\utility::istrue(param_01) && scripts\cp\_utility::func_9C42(var_02,1))
	{
		var_03 = 1;
	}

	if(scripts\cp\_utility::func_9C8F(var_02))
	{
		var_03 = 0;
	}

	if(var_03)
	{
		return func_3E88(param_00,param_01,1);
	}

	return var_02;
}

//Function Number: 11
func_3E88(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < self.var_4643.size;var_03++)
	{
		if(self.var_4643[var_03] == "none")
		{
			continue;
		}
		else if(scripts\common\utility::func_2286(param_00,self.var_4643[var_03]))
		{
			continue;
		}
		else if(scripts\common\utility::func_2286(param_00,getweaponbasename(self.var_4643[var_03])))
		{
			continue;
		}
		else if(scripts\common\utility::istrue(param_01) && scripts\cp\_utility::func_9C42(self.var_4643[var_03],param_02))
		{
			continue;
		}
		else
		{
			return self.var_4643[var_03];
		}
	}
}

//Function Number: 12
func_6952()
{
	self.var_8C4C = 1;
	self.var_4D69 = gettime() + 3000;
	var_00 = [];
	scripts\cp\_utility::func_E2D5(var_00);
	if(isdefined(self.var_D7D0))
	{
		self setweaponammostock(self.var_D7CE,self.var_D7D0);
	}

	if(isdefined(self.var_D7CF))
	{
		self setweaponammoclip(self.var_D7CE,self.var_D7CF);
	}

	if(is_valid_spawn_weapon(self.var_AA45))
	{
		self method_833B(self.var_AA45,1);
	}

	give_fists_if_no_real_weapon(self);
	self.var_2B6A = undefined;
	self.var_D7AB = undefined;
	self.var_D7AC = undefined;
	self.var_D7AD = undefined;
	self.former_mule_weapon = undefined;
	scripts\cp\_analytics::func_93C7();
	scripts\cp\_damage::func_F446(self,0);
	func_12ED5();
	self setclientomnvarbit("player_damaged",2,0);
}

//Function Number: 13
func_6610()
{
	if(isdefined(level.var_A9FD))
	{
		[[ level.var_A9FD ]](self);
	}

	if(isdefined(level.laststand_enter_levelspecificaction))
	{
		[[ level.laststand_enter_levelspecificaction ]](self);
	}
}

//Function Number: 14
func_6951()
{
	if(isdefined(level.var_A9FF))
	{
		[[ level.var_A9FF ]](self);
	}
}

//Function Number: 15
func_13701(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	if(self_revive_activated())
	{
		return func_F1E5(self);
	}

	var_03 = 35;
	if(scripts\cp\_utility::func_9BA0("coagulant"))
	{
		var_03 = 60;
		scripts\cp\_utility::func_C151("coagulant");
	}

	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		if(scripts\cp\_utility::has_zombie_perk("perk_machine_revive") && !isdefined(level.the_hoff_revive))
		{
			wait(5);
			return 1;
		}
	}
	else
	{
		param_02 = undefined;
	}

	if(!param_01)
	{
		thread func_CF17(var_03);
		if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
		{
			func_1143C(self,1);
			if(scripts\common\utility::istrue(level.the_hoff_revive))
			{
				func_F44B(self,35);
			}
			else
			{
				func_F44B(self,5);
			}
		}
		else if(!scripts\common\utility::func_6E34("meph_fight") || scripts\common\utility::func_6E34("meph_fight") && !scripts\common\utility::flag("meph_fight"))
		{
			func_F44B(self,var_03);
		}
		else
		{
			var_03 = undefined;
		}
	}

	if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && !isdefined(level.the_hoff_revive))
	{
		return func_13626(param_00,param_01);
	}

	return func_13679(self,self.origin,undefined,undefined,1,func_7B22(),(0.33,0.75,0.24),var_03,0,param_01,1,param_02);
}

//Function Number: 16
func_13703(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	wait(0.5);
	self notify("death");
	scripts\common\utility::func_136F7();
	func_DDE2(param_00);
	if(isdefined(self.var_2B6A))
	{
		param_00 = self.var_2B6A;
		self.var_2B6A = undefined;
	}

	if(func_9C2D(param_00))
	{
		var_02 = scripts\common\utility::func_5D14(param_00.origin,32,-64) + (0,0,5);
		var_03 = param_00.angles;
	}
	else
	{
		var_02 = self.origin;
		var_03 = self.angles;
	}

	func_4164(self);
	self.var_1097A = 1;
	foreach(var_05 in level.players)
	{
		if(var_05 == self)
		{
			continue;
		}

		var_06 = var_05 scripts\cp\_persistence::func_7B8B();
		var_07 = int(var_06 * 0.1);
		var_05 scripts\cp\_persistence::func_11445(var_07,1,"bleedoutPenalty");
	}

	var_09 = func_13679(self,var_02,undefined,undefined,0,func_7C95(),(1,0,0),undefined,1,param_01,0);
	func_100C2(self);
	self.var_1097A = undefined;
	scripts\cp\_utility::func_12F19("playing");
	self.var_72E2 = var_02;
	self.var_72E0 = var_03;
	if(isdefined(level.var_D869))
	{
		[[ level.var_D869 ]](self);
	}

	scripts\cp\_globallogic::func_108F2();
}

//Function Number: 17
func_DDE2(param_00)
{
	scripts\cp\_persistence::func_666A("deaths",1);
	scripts\cp\_challenge::func_12D9C("no_bleedout");
	if(!func_9C2D(param_00))
	{
		lib_0A54::func_12E38(lib_0A54::func_7CE6(),"num_players_bleed_out");
		scripts\cp\_analytics::func_93BE();
	}
}

//Function Number: 18
func_13626(param_00,param_01)
{
	if(param_01)
	{
		level waittill("forever");
		func_4164(self);
		return 0;
	}

	if(func_9C2D(param_00))
	{
		self setorigin(param_00.origin);
	}
	else
	{
		wait(5);
	}

	func_4164(self);
	return 1;
}

//Function Number: 19
func_13679(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = func_B2AE(param_00,param_01,param_02,param_03,param_04);
	if(param_08)
	{
		thread func_661D(param_00,param_01,var_0C);
	}

	if(param_09)
	{
		level waittill("forever");
		return 0;
	}

	var_0D = var_0C;
	if(param_08)
	{
		var_0D = func_B2B0(param_00,var_0C);
	}

	if(param_0A)
	{
		var_0D func_B2AF(var_0D,param_00,param_06,param_07);
	}

	param_00.reviveent = var_0C;
	param_00.var_E4AB = var_0D;
	if(isdefined(level.wait_to_be_revived_func))
	{
		var_0E = [[ level.wait_to_be_revived_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		if(isdefined(var_0E))
		{
			return var_0E;
		}
	}

	if(param_0A)
	{
		var_0C thread func_AA1A(param_00,param_05);
	}

	if(isdefined(param_07))
	{
		var_0E = var_0C scripts\cp\_utility::func_1372C(param_07,var_0C,"revive_success",param_00,"force_bleed_out",param_00,"revive_success",param_00,"challenge_complete_revive");
	}
	else
	{
		var_0E = var_0D scripts\cp\_utility::func_1372D(var_0D,"revive_success",param_01,"challenge_complete_revive");
	}

	if(var_0E == "timeout" && func_9B79(param_00))
	{
		var_0E = var_0C scripts\common\utility::func_13734("revive_success","revive_fail");
	}

	if(var_0E == "revive_success" || var_0E == "challenge_complete_revive")
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
func_AA1A(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self makeusable();
		self waittill("trigger",var_02);
		self makeunusable();
		if(!var_02 isonground())
		{
			continue;
		}

		if(var_02 ismeleeing())
		{
			continue;
		}

		if(!isplayer(var_02) && !scripts\common\utility::istrue(var_02.var_3842))
		{
			continue;
		}

		var_03 = func_80F0(var_02,param_00);
		var_04 = int(param_01 / var_03);
		var_05 = func_7C12(param_00,var_02,self.origin,var_04);
		if(var_05)
		{
			if(isdefined(var_02.var_134FD))
			{
				if(param_00.var_134FD == "p4_" && soundexists(var_02.var_134FD + "respawn_laststand_valleygirl"))
				{
					var_02 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand_valleygirl","zmb_comment_vo","medium",10,0,0,0,50);
					param_00 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand","zmb_comment_vo","medium",10,0,0,1,50);
				}
				else if(param_00.var_134FD == "p1_" && soundexists(var_02.var_134FD + "respawn_laststand_aj"))
				{
					var_02 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand_aj","zmb_comment_vo","medium",10,0,0,0,50);
					param_00 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand","zmb_comment_vo","medium",10,0,0,1,50);
				}
				else if(level.script == "cp_town")
				{
					if(var_02.var_134FD == "p1_")
					{
						param_00 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand_sally","town_comment_vo");
					}
				}
				else
				{
					param_00 thread scripts\cp\_vo::try_to_play_vo("respawn_laststand","zmb_comment_vo","medium",10,0,0,1,50);
				}
			}

			if(param_00 scripts\cp\_utility::func_9BA0("faster_revive_upgrade"))
			{
				param_00 scripts\cp\_utility::func_C151("faster_revive_upgrade");
			}

			var_02 playlocalsound("revive_teammate");
			func_DDEA(var_02,param_00);
			var_02 notify("revive_teammate",param_00);
			if(isplayer(var_02) && scripts\common\utility::istrue(var_02.can_give_revive_xp))
			{
				var_02.can_give_revive_xp = 0;
				var_02 scripts\cp\_persistence::give_player_xp(int(250),1);
			}

			break;
		}
		else
		{
			self notify("revive_fail");
			continue;
		}
	}

	func_4164(param_00);
	self notify("revive_success");
}

//Function Number: 21
func_80F0(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.var_3842))
	{
		return 2;
	}

	var_02 = param_00 lib_0CFC::func_CA41();
	if(param_01 scripts\cp\_utility::func_9BA0("faster_revive_upgrade"))
	{
		var_02 = var_02 * 2;
	}

	return var_02;
}

//Function Number: 22
func_B529(param_00,param_01)
{
	func_992F(param_01);
	func_DDEA(param_00,param_01);
}

//Function Number: 23
func_DDEA(param_00,param_01)
{
	if(isplayer(param_00))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_reviver");
		param_00 scripts\cp\_persistence::increment_player_career_revives(param_00);
		param_00 scripts\cp\_merits::func_D9AD("mt_revives");
		param_00 scripts\cp\_persistence::func_666A("revives",1);
		param_01 thread scripts\cp\_hud_message::func_10151("revived",undefined,param_00);
		if(isdefined(level.var_E4A4))
		{
			[[ level.var_E4A4 ]](param_00);
		}
	}
}

//Function Number: 24
func_B2AE(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,0,20);
	param_01 = scripts\common\utility::func_5D14(param_01 + var_05,32,-64);
	var_06 = spawn("script_model",param_01);
	var_06 setcursorhint("HINT_NOICON");
	var_06 sethintstring(&"PLATFORM_REVIVE");
	var_06.var_222 = param_00;
	var_06.var_9B04 = 0;
	var_06.var_336 = "revive_trigger";
	if(isdefined(param_02))
	{
		var_06 setmodel(param_02);
	}

	if(isdefined(param_03))
	{
		var_06 scriptmodelplayanim(param_03);
	}

	if(param_04)
	{
		var_06 linkto(param_00,"tag_origin",var_05,(0,0,0));
	}

	var_06 thread func_4110(param_00);
	return var_06;
}

//Function Number: 25
func_B2B0(param_00,param_01)
{
	var_02 = (0,0,30);
	var_03 = spawn("script_model",param_01.origin + var_02);
	var_03 thread func_4110(param_00);
	return var_03;
}

//Function Number: 26
func_B4DC(param_00,param_01)
{
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return func_10400(param_00,param_01);
	}

	return func_4628(param_01);
}

//Function Number: 27
func_10400(param_00,param_01)
{
	if(param_00 && func_9C2D(param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_4628(param_00)
{
	if(func_9C2D(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 29
func_C553()
{
	if(scripts\common\utility::istrue(self.var_9D81))
	{
		wait(0.5);
	}

	var_00 = func_7A72();
	if(self hasweapon(var_00))
	{
		self takeweapon(var_00);
	}

	scripts\cp\_utility::func_12C6(var_00,scripts\cp\_utility::func_7D72(self,var_00),0,1);
	var_01 = ["iw7_knife_zm","iw7_knife_zm_hoff","iw7_knife_zm_jock","iw7_knife_zm_vgirl","iw7_knife_zm_rapper","iw7_knife_zm_nerd","iw7_knife_zm_wyler","iw7_knife_zm_schoolgirl","iw7_knife_zm_scientist","iw7_knife_zm_soldier","iw7_knife_zm_rebel","iw7_knife_zm_elvira","iw7_knife_zm_crowbar","iw7_knife_zm_cleaver","iw7_knife_zm_chola","iw7_knife_zm_raver","iw7_knife_zm_grunge","iw7_knife_zm_hiphop","iw7_knife_zm_kevinsmith","iw7_knife_zm_disco"];
	var_02 = func_3868(self);
	if(var_02)
	{
		var_01[var_01.size] = var_00;
	}

	func_1420(var_01);
	var_03 = func_7B40();
	if(var_02)
	{
		var_04 = self method_80FB(var_00);
		var_05 = weaponclipsize(var_00);
		self setweaponammostock(var_00,var_05 * var_03);
		self setweaponammoclip(var_00,var_05);
		self method_83B6(var_00);
	}
}

//Function Number: 30
func_7B40()
{
	return 2;
}

//Function Number: 31
func_7A72()
{
	if(isdefined(self.var_A913))
	{
		return self.var_A913;
	}

	var_00 = self.var_501C;
	var_01 = self getweaponslistprimaries()[0];
	if(scripts\cp\_utility::func_7DF7(var_00) == scripts\cp\_utility::func_7DF7(var_01))
	{
		return var_01;
	}

	return var_00;
}

//Function Number: 32
func_3868(param_00)
{
	if(isdefined(level.var_3869))
	{
		return [[ level.var_3869 ]](param_00);
	}

	return 1;
}

//Function Number: 33
func_4110(param_00)
{
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect","revive");
	self delete();
}

//Function Number: 34
func_E026(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	param_01.var_E49F = scripts\common\utility::func_22A9(param_01.var_E49F,param_00);
}

//Function Number: 35
func_500D()
{
	func_970D(self);
}

//Function Number: 36
func_9730(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(5);
	var_01 = func_7A71();
}

//Function Number: 37
func_82E0(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = param_00 func_7A71() + param_01;
	func_F44A(param_00,var_02);
}

//Function Number: 38
func_1143C(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = param_00 func_7A71() - param_01;
	func_F44A(param_00,max(var_02,0));
}

//Function Number: 39
func_7682(param_00)
{
	if(param_00 self_revive_activated())
	{
		return 0;
	}

	if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_revive") || scripts\common\utility::istrue(level.the_hoff_revive))
	{
		return 0;
	}

	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return func_103FF(param_00);
	}

	return func_4624(param_00);
}

//Function Number: 40
func_103FF(param_00)
{
	if(player_in_laststand(param_00))
	{
		return 0;
	}

	return param_00 func_7A71() == 0;
}

//Function Number: 41
func_4624(param_00)
{
	return func_68BE(param_00);
}

//Function Number: 42
func_68BE(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02 == param_00)
		{
			continue;
		}

		if(!player_in_laststand(var_02))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 43
func_7C12(param_00,param_01,param_02,param_03)
{
	var_04 = func_4A2D(param_02);
	var_04 thread func_4110(param_00);
	var_05 = func_E4A6(param_00,param_01,var_04,param_03);
	return var_05;
}

//Function Number: 44
func_4A2D(param_00)
{
	var_01 = spawn("script_origin",param_00);
	var_01.var_4B30 = 0;
	var_01.var_130EE = 0;
	var_01.userate = 8000;
	var_01.var_9B04 = 0;
	return var_01;
}

//Function Number: 45
func_CF17(param_00)
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	scripts\cp\_utility::func_CF16();
	wait(param_00 / 3);
	scripts\cp\_utility::func_CF16();
	wait(param_00 / 3);
	thread scripts\cp\_vo::try_to_play_vo("laststand_bleedout","zmb_comment_vo","low",10,0,0,1,100);
	scripts\cp\_utility::func_CF16();
}

//Function Number: 46
func_661D(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	if(isdefined(param_00.var_3AF5))
	{
		param_00.var_3AF5 destroy();
	}

	param_00.var_8B69 = 0;
	func_660A();
	func_37C0(param_00,param_01,param_02);
	func_6943();
}

//Function Number: 47
func_37C0(param_00,param_01,param_02)
{
	param_02 endon("revive_success");
	var_03 = (0,0,30);
	var_04 = (0,0,100);
	var_05 = (0,0,400);
	var_06 = 2;
	var_07 = 0.6;
	var_08 = 0.6;
	var_09 = param_01 + var_03;
	var_0A = bullettrace(var_09,var_09 + var_04,0,param_00);
	var_0B = var_0A["position"];
	var_0A = bullettrace(var_0B,var_0B + var_05,0,param_00);
	var_0C = var_0A["position"];
	var_0D = spawn("script_model",var_0B);
	var_0D setmodel("tag_origin");
	var_0D.angles = vectortoangles((0,0,-1));
	var_0D thread func_4110(param_00);
	param_00 cameralinkto(var_0D,"tag_origin");
	var_0D moveto(var_0C,var_06,var_07,var_08);
	var_0D waittill("movedone");
	var_0D delete();
	param_00 func_6609(param_00);
}

//Function Number: 48
func_6609(param_00)
{
	func_8E6C(param_00);
	if(isdefined(level.var_CF91))
	{
		param_00 [[ level.var_CF91 ]](param_00);
		return;
	}

	param_00 scripts\cp\_globallogic::func_662C();
}

//Function Number: 49
func_660A()
{
	self method_8232();
	self freezecontrols(1);
	self.zoom_out_camera = 1;
}

//Function Number: 50
func_6943()
{
	self cameraunlink();
	self freezecontrols(0);
	self.zoom_out_camera = undefined;
}

//Function Number: 51
func_E4A6(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.var_134FD))
	{
		if(param_00.var_134FD == "p1_" && soundexists(param_01.var_134FD + "reviving_valleygirl"))
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("reviving_valleygirl","zmb_comment_vo");
		}
		else if(param_00.var_134FD == "p1_" && soundexists(param_01.var_134FD + "reviving_sally"))
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("reviving_sally","zmb_comment_vo");
		}
		else
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("reviving","zmb_comment_vo");
		}
	}

	func_661A(param_00,param_01,param_02,param_03);
	if(!isdefined(level.the_hoff) || isdefined(level.the_hoff) && param_01 != level.the_hoff)
	{
		func_CDE3(param_01,param_00);
	}

	thread func_135D1(param_00,param_01,param_02,param_01 scripts\cp\_utility::getvalidtakeweapon());
	param_00.var_E4AD = param_01;
	var_04 = 0;
	var_05 = 0;
	func_621E(param_00,param_01);
	if(isplayer(param_01))
	{
		param_00 notify("reviving");
	}

	while(func_FF85(param_01))
	{
		if(var_04 >= param_03)
		{
			var_05 = 1;
			break;
		}

		var_06 = var_04 / param_03;
		func_12E15(param_00,param_01,var_06);
		var_04 = var_04 + 50;
		scripts\common\utility::func_136F7();
	}

	func_555D(param_00,param_01);
	param_02 notify("use_hold_think_complete");
	param_02 waittill("exit_use_hold_think_complete");
	return var_05;
}

//Function Number: 52
func_CDE3(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.hasentanglerequipped))
	{
		return;
	}

	param_00 giveweapon("iw7_gunless_zm");
	param_00 switchtoweapon("iw7_gunless_zm");
	param_00 allowmelee(0);
	param_00 method_80AB();
	param_00 method_846F(get_revive_gesture(param_00),param_01);
}

//Function Number: 53
func_11038(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.hasentanglerequipped))
	{
		return;
	}

	param_00 takeweapon("iw7_gunless_zm");
	param_00 enableweaponswitch();
	param_00 switchtoweapon(param_01);
	param_00 allowmelee(1);
	param_00 stopgestureviewmodel(get_revive_gesture(param_00));
}

//Function Number: 54
get_revive_gesture(param_00)
{
	if(isdefined(param_00.revive_gesture))
	{
		return param_00.revive_gesture;
	}

	return "ges_zombies_revive_nerd";
}

//Function Number: 55
func_12E15(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		if(var_04 == param_00 || var_04 == param_01)
		{
			var_04 setclientomnvar("ui_securing_progress",param_02);
			continue;
		}

		var_04 setclientomnvar("zm_revive_bar_" + param_00.var_E4A3 + "_progress",param_02);
	}
}

//Function Number: 56
func_661A(param_00,param_01,param_02,param_03)
{
	param_00 setclientomnvar("ui_securing",4);
	param_01 setclientomnvar("ui_securing",3);
	param_00.var_2A85 = 1;
	if(isplayer(param_01))
	{
		param_01 playerlinkto(param_02);
		param_01 playerlinkedoffsetenable();
		param_01 scripts\cp\powers\coop_powers::func_D728();
		param_01 thread func_CDDC(param_01);
	}

	param_01.var_9F28 = 1;
}

//Function Number: 57
func_135D1(param_00,param_01,param_02,param_03)
{
	scripts\common\utility::func_1372B(param_02,"use_hold_think_complete",param_00,"disconnect",param_00,"revive_success",param_00,"force_bleed_out",param_01,"challenge_complete",param_00,"death");
	if(scripts\cp\_utility::func_9F19(param_00))
	{
		param_00.var_2A85 = 0;
		param_00 setclientomnvar("ui_securing",0);
	}

	param_01.var_9F28 = 0;
	if(isplayer(param_01))
	{
		param_01 func_11038(param_01,param_03);
		param_01 setclientomnvar("ui_securing",0);
		param_01 scripts\cp\powers\coop_powers::func_D72E();
		param_01 unlink();
		param_01 notify("stop_revive");
	}

	param_02 notify("exit_use_hold_think_complete");
}

//Function Number: 58
func_CDDC(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("stop_playing_revive_anim");
	param_00 playanimscriptevent("power_active_cp","gesture015");
}

//Function Number: 59
func_FF85(param_00)
{
	if(scripts\common\utility::istrue(param_00.var_3842))
	{
		return 1;
	}

	return !level.var_7669 && scripts\cp\_utility::func_9F19(param_00) && param_00 usebuttonpressed() && !player_in_laststand(param_00);
}

//Function Number: 60
func_1420(param_00)
{
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(scripts\common\utility::func_2286(param_00,var_03))
		{
			continue;
		}
		else if(!scripts\cp\_utility::isstrstart(var_03,"alt_"))
		{
			self takeweapon(var_03);
		}
	}
}

//Function Number: 61
func_9C2D(param_00)
{
	return isdefined(param_00);
}

//Function Number: 62
func_F44A(param_00,param_01)
{
	param_01 = int(param_01);
	param_00 setplayerdata("cp","alienSession","last_stand_count",param_01);
}

//Function Number: 63
func_F44B(param_00,param_01)
{
	param_00 setclientomnvar("zm_ui_laststand_end_milliseconds",gettime() + param_01 * 1000);
}

//Function Number: 64
func_4164(param_00)
{
	param_00 setclientomnvar("zm_ui_laststand_end_milliseconds",0);
}

//Function Number: 65
func_992F(param_00)
{
	param_00 notify("revive_success");
	if(isdefined(param_00.reviveent))
	{
		param_00.reviveent notify("revive_success");
	}

	if(func_9B79(param_00))
	{
		func_555D(param_00,param_00.var_E4AD);
	}

	func_4164(param_00);
}

//Function Number: 66
func_F579(param_00,param_01)
{
	if(isdefined(param_00))
	{
		level.var_C092 = param_00;
	}

	if(isdefined(param_01))
	{
		level.var_1097D = param_01;
	}
}

//Function Number: 67
func_7B22()
{
	if(isdefined(level.var_C092))
	{
		return level.var_C092;
	}

	return 5000;
}

//Function Number: 68
func_7C95()
{
	if(isdefined(level.var_1097D))
	{
		return level.var_1097D;
	}

	return 6000;
}

//Function Number: 69
func_12ED5()
{
	self [[ level.var_BC70 ]]();
}

//Function Number: 70
func_78F8(param_00)
{
	if(isdefined(level.var_A9FB))
	{
		return [[ level.var_A9FB ]](param_00);
	}

	return 500;
}

//Function Number: 71
func_B2AF(param_00,param_01,param_02,param_03)
{
	func_FA27(param_00);
	param_00.var_4BA5 = param_02;
	param_00 thread func_E4AC(param_00);
	var_04 = undefined;
	foreach(var_06 in level.players)
	{
		if(var_06 == param_01)
		{
			continue;
		}

		var_04 = func_100F6(param_00,var_06);
		func_177C(param_00,var_04);
	}

	if(isdefined(param_03))
	{
		param_00 thread func_E49B(param_03);
	}

	return var_04;
}

//Function Number: 72
func_100F6(param_00,param_01)
{
	var_02 = newclienthudelem(param_01);
	var_02 setshader("waypoint_alien_revive",8,8);
	var_02 setwaypoint(1,1);
	var_02 settargetent(param_00);
	var_02.alpha = func_7C11(param_01);
	var_02.color = param_00.var_4BA5;
	func_1774(param_01,var_02);
	var_02 thread func_E4AA(param_00,param_01);
	return var_02;
}

//Function Number: 73
func_E4AC(param_00)
{
	param_00 waittill("death");
	func_E02A(param_00);
}

//Function Number: 74
func_E4AA(param_00,param_01)
{
	scripts\cp\_utility::func_1372D(param_00,"death",param_01,"disconnect");
	func_E026(self,param_01);
	if(isdefined(self))
	{
		self destroy();
	}
}

//Function Number: 75
func_E49B(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait(param_00 / 3);
	func_F578(self,(1,0.941,0));
	wait(param_00 / 3);
	func_F578(self,(0.929,0.231,0.141));
}

//Function Number: 76
func_F578(param_00,param_01)
{
	param_00.var_4BA5 = param_01;
	param_00.var_E49F = scripts\common\utility::func_22BC(param_00.var_E49F);
	foreach(var_03 in param_00.var_E49F)
	{
		var_03.color = param_01;
	}
}

//Function Number: 77
func_9654()
{
	level.var_E49C = [];
	level.var_D407 = [];
	level thread func_E49E();
}

//Function Number: 78
func_177D(param_00)
{
	level.var_E49C[level.var_E49C.size] = param_00;
}

//Function Number: 79
func_E02A(param_00)
{
	level.var_E49C = scripts\common\utility::func_22A9(level.var_E49C,param_00);
	level.var_E49C = scripts\common\utility::func_22BC(level.var_E49C);
}

//Function Number: 80
func_E49E()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		foreach(var_02 in level.var_E49C)
		{
			func_100F6(var_02,var_00);
		}

		foreach(var_05 in level.var_D407)
		{
			if(isdefined(var_05))
			{
				var_00 setclientomnvar("zm_revive_bar_" + var_05.var_E4A3 + "_target",var_05);
			}
		}
	}
}

//Function Number: 81
func_FA27(param_00)
{
	param_00.var_E49F = [];
	func_177D(param_00);
}

//Function Number: 82
func_177C(param_00,param_01)
{
	param_00.var_E49F[param_00.var_E49F.size] = param_01;
}

//Function Number: 83
func_970D(param_00)
{
	param_00.var_E49F = [];
}

//Function Number: 84
func_1774(param_00,param_01)
{
	param_00.var_E49F[param_00.var_E49F.size] = param_01;
}

//Function Number: 85
func_E028(param_00,param_01)
{
	param_00.var_E49F = scripts\common\utility::func_22A9(param_00.var_E49F,param_01);
}

//Function Number: 86
func_7C11(param_00)
{
	if(isdefined(level.var_E49D))
	{
		return [[ level.var_E49D ]](param_00);
	}

	return 1;
}

//Function Number: 87
func_100C2(param_00)
{
	foreach(var_02 in param_00.var_E49F)
	{
		var_02.alpha = 1;
	}
}

//Function Number: 88
func_8E6C(param_00)
{
	foreach(var_02 in param_00.var_E49F)
	{
		var_02.alpha = 0;
	}
}

//Function Number: 89
func_621E(param_00,param_01)
{
	var_02 = func_1775(param_00);
	var_03 = "zm_revive_bar_" + var_02 + "_target";
	foreach(var_05 in level.players)
	{
		if(var_05 == param_00 || var_05 == param_01)
		{
			continue;
		}

		var_05 setclientomnvar(var_03,param_00);
	}
}

//Function Number: 90
func_555D(param_00,param_01)
{
	var_02 = "zm_revive_bar_" + param_00.var_E4A3 + "_target";
	func_E029(param_00);
	foreach(var_04 in level.players)
	{
		if(var_04 == param_00 || var_04 == param_01)
		{
			continue;
		}

		var_04 setclientomnvar(var_02,undefined);
	}
}

//Function Number: 91
self_revive_activated()
{
	return isdefined(self.var_F1E5) && self.var_F1E5 > 0;
}

//Function Number: 92
func_1775(param_00)
{
	var_01 = 0;
	while(var_01 < 2)
	{
		if(!isdefined(level.var_D407[var_01]))
		{
			level.var_D407[var_01] = param_00;
			var_02 = var_01 + 1;
			param_00.var_E4A3 = var_02;
			return var_02;
		}

		var_02++;
	}
}

//Function Number: 93
func_E029(param_00)
{
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		if(isdefined(level.var_D407[var_01]) && level.var_D407[var_01] == param_00)
		{
			level.var_D407[var_01] = undefined;
			param_00.var_E4A3 = undefined;
			return;
		}
	}
}

//Function Number: 94
func_4F33()
{
	return 0;
}

//Function Number: 95
func_8C50()
{
	return scripts\common\utility::istrue(self.have_self_revive);
}

//Function Number: 96
func_7A71()
{
	return self getplayerdata("cp","alienSession","last_stand_count");
}

//Function Number: 97
func_9B79(param_00)
{
	return scripts\common\utility::istrue(param_00.var_2A85);
}

//Function Number: 98
player_in_laststand(param_00)
{
	return param_00.inlaststand;
}

//Function Number: 99
func_6235(param_00)
{
	if(!isdefined(param_00.var_F1E5))
	{
		param_00.var_F1E5 = 0;
	}

	param_00.var_F1E5++;
}

//Function Number: 100
func_557F(param_00)
{
	param_00.var_F1E5--;
}

//Function Number: 101
func_F1E5(param_00)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(3,"revive_success");
	return 1;
}

//Function Number: 102
give_fists_if_no_real_weapon(param_00)
{
	if(has_no_real_weapon(param_00))
	{
		var_01 = get_fists_weapon(param_00);
		if(var_01 != "iw7_fists_zm" && param_00 hasweapon("iw7_fists_zm"))
		{
			param_00 takeweapon("iw7_fists_zm");
		}

		self giveweapon(var_01);
		self method_83B6(var_01);
		if(is_valid_spawn_weapon(var_01))
		{
			self method_833B(var_01,1);
		}
	}
}

//Function Number: 103
get_fists_weapon(param_00)
{
	if(isdefined(level.get_fists_weapon_func))
	{
		return [[ level.get_fists_weapon_func ]](param_00);
	}

	return "iw7_fists_zm";
}

//Function Number: 104
is_valid_spawn_weapon(param_00)
{
	if(isdefined(level.is_valid_spawn_weapon_func))
	{
		return [[ level.is_valid_spawn_weapon_func ]](param_00);
	}

	return 1;
}

//Function Number: 105
has_no_real_weapon(param_00)
{
	var_01 = param_00 getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(var_03 == "super_default_zm")
		{
			continue;
		}

		if(issubstr(var_03,"knife"))
		{
			continue;
		}

		if(var_03 == "iw7_fists_zm")
		{
			continue;
		}

		return 0;
	}

	return 1;
}