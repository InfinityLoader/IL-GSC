/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\notetracks.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 1139 ms
 * Timestamp: 10/27/2023 1:24:13 AM
*******************************************************************/

//Function Number: 1
func_3F77(param_00)
{
	switch(param_00)
	{
		case "fs_bk_r_lg":
		case "fs_bk_l_lg":
		case "fs_fr_r_lg":
		case "fs_fr_l_lg":
		case "fs_bk_r_sm":
		case "fs_bk_l_sm":
		case "fs_fr_r_sm":
		case "fs_fr_l_sm":
		case "footstep_back_right_large":
		case "footstep_back_left_large":
		case "footstep_front_right_large":
		case "footstep_front_left_large":
		case "footstep_back_right_small":
		case "footstep_back_left_small":
		case "footstep_front_right_small":
		case "footstep_front_left_small":
			var_01 = undefined;
			if(isdefined(self.groundtype))
			{
				var_01 = self.groundtype;
				self.var_4C69 = var_01;
			}
			else if(isdefined(self.var_4C69))
			{
				var_01 = self.var_4C69;
			}
			else
			{
				var_01 = "dirt";
			}
	
			if(var_01 != "dirt" && var_01 != "concrete" && var_01 != "wood" && var_01 != "metal")
			{
				var_01 = "dirt";
			}
	
			if(var_01 == "concrete")
			{
				var_01 = "cement";
			}
	
			var_02 = self.var_5474;
			if(!isdefined(var_02))
			{
				var_02 = "run";
			}
	
			var_03 = self isdogbeingdriven() || isdefined(self.controlling_dog);
			if(var_03)
			{
				self playsound("dogstep_plr_" + var_02 + "_" + var_01);
			}
			else
			{
				self playsound("dogstep_" + var_02 + "_" + var_01);
			}
	
			if(!isdefined(self.bdisablegearsounds) || self.bdisablegearsounds)
			{
				if(issubstr(param_00,"front_left") || issubstr(param_00,"fr_l"))
				{
					var_04 = "anml_dog_mvmt_accent";
					var_05 = "anml_dog_mvmt_vest";
					if(var_03)
					{
						if(!isdefined(self.var_2ACB) || self.var_2ACB == "walk")
						{
							var_06 = "_plr";
						}
						else
						{
							var_06 = "_run_plr";
						}
					}
					else if(var_03 == "walk")
					{
						var_06 = "_npc";
					}
					else
					{
						var_06 = "_run_npc";
					}
	
					self playsound(var_04 + var_06);
					self playsound(var_05 + var_06);
				}
			}
			return 1;
	}

	return 0;
}

//Function Number: 2
func_3F78(param_00)
{
	if(func_3F77(param_00))
	{
		return 1;
	}

	if(param_00 == "sound_dogstep_run_default")
	{
		self playsound("dogstep_run_default");
		return 1;
	}

	var_01 = getsubstr(param_00,0,5);
	if(var_01 != "sound")
	{
		return 0;
	}

	var_02 = "anml" + getsubstr(param_00,5);
	if(isalive(self))
	{
		thread maps\_utility::func_5D26(var_02,"tag_eye");
	}
	else
	{
		thread common_scripts\utility::func_5D1F(var_02,self geteye());
	}

	return 1;
}

//Function Number: 3
func_3F6C(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "alien_idle_04":
			case "alien_idle_03":
			case "alien_idle_02":
			case "alien_death":
			case "alien_pain_light":
			case "alien_pain_heavy":
			case "alien_jump":
			case "alien_land_big":
			case "alien_attack":
			case "alien_voice":
			case "alien_test_idle_sounds":
			case "alien_test_attack_sounds":
			case "alien_footstep_fence":
			case "alien_footstep_small":
			case "alien_footstep":
				self playsound(param_00);
				break;

			default:
				break;
		}
	}
}

//Function Number: 4
func_3DE1()
{
	return isdefined(self.var_6BF4);
}

//Function Number: 5
func_646F()
{
	level.var_56F7["anim_pose = \"stand\"] = ::func_56F3;
	level.var_56F7["anim_pose = \"crouch\"] = ::func_56F1;
	level.var_56F7["anim_pose = \"prone\"] = ::func_56F2;
	level.var_56F7["anim_pose = \"crawl\"] = ::notetrackposecrawl;
	level.var_56F7["anim_pose = \"back\"] = ::func_56EF;
	level.var_56F7["anim_movement = \"stop\"] = ::notetrackmovementstop;
	level.var_56F7["anim_movement = \"walk\"] = ::func_56EB;
	level.var_56F7["anim_movement = \"run\"] = ::func_56E9;
	level.var_56F7["anim_aiming = 1"] = ::func_56D6;
	level.var_56F7["anim_aiming = 0"] = ::func_56D7;
	level.var_56F7["anim_alertness = causal"] = ::notetrackalertnesscasual;
	level.var_56F7["anim_alertness = alert"] = ::func_56D7;
	level.var_56F7["anim_alertness = aiming"] = ::func_56D6;
	level.var_56F7["gunhand = (gunhand)_left"] = ::func_56E3;
	level.var_56F7["anim_gunhand = \"left\"] = ::func_56E3;
	level.var_56F7["gunhand = (gunhand)_right"] = ::func_56E3;
	level.var_56F7["anim_gunhand = \"right\"] = ::func_56E3;
	level.var_56F7["anim_gunhand = \"none\"] = ::func_56E3;
	level.var_56F7["gun drop"] = ::func_56E2;
	level.var_56F7["dropgun"] = ::func_56E2;
	level.var_56F7["gun_2_chest"] = ::notetrackguntochest;
	level.var_56F7["gun_2_back"] = ::func_56E4;
	level.var_56F7["pistol_pickup"] = ::notetrackpistolpickup;
	level.var_56F7["pistol_putaway"] = ::notetrackpistolputaway;
	level.var_56F7["drop clip"] = ::func_56DB;
	level.var_56F7["refill clip"] = ::func_56F4;
	level.var_56F7["reload done"] = ::func_56F4;
	level.var_56F7["load_shell"] = ::func_56E8;
	level.var_56F7["pistol_rechamber"] = ::notetrackpistolrechamber;
	level.var_56F7["gravity on"] = ::func_56E1;
	level.var_56F7["gravity off"] = ::func_56E1;
	level.var_56F7["footstep_right_large"] = ::func_56E0;
	level.var_56F7["footstep_right_small"] = ::func_56E0;
	level.var_56F7["footstep_left_large"] = ::func_56E0;
	level.var_56F7["footstep_left_small"] = ::func_56E0;
	level.var_56F7["footscrape"] = ::func_56DF;
	level.var_56F7["land"] = ::func_56E6;
	level.var_56F7["bodyfall large"] = ::notetrackbodyfall;
	level.var_56F7["bodyfall small"] = ::notetrackbodyfall;
	level.var_56F7["code_move"] = ::func_56DA;
	level.var_56F7["face_enemy"] = ::func_56DC;
	level.var_56F7["laser_on"] = ::func_56E7;
	level.var_56F7["laser_off"] = ::func_56E7;
	level.var_56F7["start_ragdoll"] = ::func_56FA;
	level.var_56F7["fire"] = ::notetrackfire;
	level.var_56F7["fire_spray"] = ::func_56DE;
	level.var_56F7["bloodpool"] = ::animscripts/death::func_5CB1;
	level.var_56F7["space_jet_top"] = ::func_56F8;
	level.var_56F7["space_jet_top_1"] = ::func_56F8;
	level.var_56F7["space_jet_top_2"] = ::func_56F8;
	level.var_56F7["space_jet_bottom"] = ::func_56F8;
	level.var_56F7["space_jet_bottom_1"] = ::func_56F8;
	level.var_56F7["space_jet_bottom_2"] = ::func_56F8;
	level.var_56F7["space_jet_left"] = ::func_56F8;
	level.var_56F7["space_jet_left_1"] = ::func_56F8;
	level.var_56F7["space_jet_left_2"] = ::func_56F8;
	level.var_56F7["space_jet_right"] = ::func_56F8;
	level.var_56F7["space_jet_right_1"] = ::func_56F8;
	level.var_56F7["space_jet_right_2"] = ::func_56F8;
	level.var_56F7["space_jet_front"] = ::func_56F8;
	level.var_56F7["space_jet_front_1"] = ::func_56F8;
	level.var_56F7["space_jet_front_2"] = ::func_56F8;
	level.var_56F7["space_jet_back"] = ::func_56F8;
	level.var_56F7["space_jet_back_1"] = ::func_56F8;
	level.var_56F7["space_jet_back_2"] = ::func_56F8;
	level.var_56F7["space_jet_back_3"] = ::func_56F8;
	level.var_56F7["space_jet_back_4"] = ::func_56F8;
	level.var_56F7["space_jet_random"] = ::func_56F8;
	if(isdefined(level._notetrackfx))
	{
		var_00 = getarraykeys(level._notetrackfx);
		foreach(var_02 in var_00)
		{
			level.var_56F7[var_02] = ::func_224B;
		}
	}
}

//Function Number: 6
notetrackfire(param_00,param_01)
{
	if(isdefined(level.var_32D4[self.script]))
	{
		thread [[ level.var_32D4[self.script] ]]();
	}

	thread [[ ::func_7442 ]]();
}

//Function Number: 7
func_56E7(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self.a.var_4BDF = 1;
	}
	else
	{
		self.a.var_4BDF = 0;
	}

	animscripts/shared::func_86F8();
}

//Function Number: 8
func_56FB(param_00,param_01)
{
}

//Function Number: 9
func_85AE()
{
	wait(0.1);
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 10
func_56FA(param_00,param_01)
{
	if(isdefined(self.var_5674))
	{
	}

	if(isdefined(self.var_62E2))
	{
	}

	if(!isdefined(self.var_299F))
	{
		thread func_85AE();
	}

	self startragdoll();
}

//Function Number: 11
notetrackmovementstop(param_00,param_01)
{
	self.a.var_5486 = "stop";
}

//Function Number: 12
func_56EB(param_00,param_01)
{
	self.a.var_5486 = "walk";
}

//Function Number: 13
func_56E9(param_00,param_01)
{
	self.a.var_5486 = "run";
}

//Function Number: 14
func_56D6(param_00,param_01)
{
}

//Function Number: 15
notetrackalertnesscasual(param_00,param_01)
{
}

//Function Number: 16
func_56D7(param_00,param_01)
{
}

//Function Number: 17
stoponback()
{
	animscripts/utility::exitpronewrapper(1);
	self.a.onback = undefined;
}

//Function Number: 18
setpose(param_00)
{
	self.a.var_60B1 = param_00;
	if(isdefined(self.a.onback))
	{
		stoponback();
	}

	self notify("entered_pose" + param_00);
}

//Function Number: 19
func_56F3(param_00,param_01)
{
	if(self.a.var_60B1 == "prone")
	{
		self orientmode("face default");
		animscripts/utility::exitpronewrapper(1);
	}

	setpose("stand");
}

//Function Number: 20
func_56F1(param_00,param_01)
{
	if(self.a.var_60B1 == "prone")
	{
		self orientmode("face default");
		animscripts/utility::exitpronewrapper(1);
	}

	setpose("crouch");
}

//Function Number: 21
func_56F2(param_00,param_01)
{
	if(!issentient(self))
	{
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	setpose("prone");
	if(isdefined(self.a.goingtoproneaim))
	{
		self.a.var_61FB = 1;
	}

	self.a.var_61FB = undefined;
}

//Function Number: 22
notetrackposecrawl(param_00,param_01)
{
	if(!issentient(self))
	{
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	setpose("prone");
	self.a.var_61FB = undefined;
}

//Function Number: 23
func_56EF(param_00,param_01)
{
	if(!issentient(self))
	{
	}

	setpose("crouch");
	self.a.onback = 1;
	self.a.var_5486 = "stop";
	self setproneanimnodes(-90,90,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
}

//Function Number: 24
func_56E3(param_00,param_01)
{
	if(issubstr(param_00,"left"))
	{
		animscripts/shared::placeweaponon(self.weapon,"left");
		self notify("weapon_switch_done");
	}

	if(issubstr(param_00,"right"))
	{
		animscripts/shared::placeweaponon(self.weapon,"right");
		self notify("weapon_switch_done");
	}

	if(issubstr(param_00,"none"))
	{
		animscripts/shared::placeweaponon(self.weapon,"none");
	}
}

//Function Number: 25
func_56E2(param_00,param_01)
{
	animscripts/shared::func_2B48();
	self.lastweapon = self.weapon;
}

//Function Number: 26
notetrackguntochest(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"chest");
}

//Function Number: 27
func_56E4(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"back");
	self.weapon = animscripts/utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 28
notetrackpistolpickup(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.var_7544,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 29
notetrackpistolputaway(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"none");
	self.weapon = animscripts/utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 30
func_56DB(param_00,param_01)
{
	thread animscripts/shared::func_3F7A(param_01);
}

//Function Number: 31
func_56F4(param_00,param_01)
{
	animscripts/weaponlist::refillclip();
	self.a.var_5593 = 0;
}

//Function Number: 32
func_56E8(param_00,param_01)
{
	self playsound("weap_reload_shotgun_loop_npc");
}

//Function Number: 33
notetrackpistolrechamber(param_00,param_01)
{
	self playsound("weap_reload_pistol_chamber_npc");
}

//Function Number: 34
func_56E1(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self animmode("gravity");
	}

	if(issubstr(param_00,"off"))
	{
		self animmode("nogravity");
	}
}

//Function Number: 35
func_56E0(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	func_6008(var_02,var_03);
	var_04 = func_3911();
	var_05 = self getclothmovesound(var_04);
	if(isdefined(var_05) && var_05 != "")
	{
		self playsoundatviewheight(var_05);
	}

	if(isdefined(self.weapon))
	{
		var_06 = self getequipmovesound(self.weapon,var_04);
		if(isdefined(var_06) && var_06 != "")
		{
			self playsoundatviewheight(var_06);
		}
	}
}

//Function Number: 36
func_3911()
{
	var_00 = "run";
	if(isdefined(self.var_797D))
	{
		var_00 = "sprint";
	}

	if(isdefined(self.a))
	{
		if(isdefined(self.a.var_5486))
		{
			if(self.a.var_5486 == "walk")
			{
				var_00 = "walk";
			}
		}

		if(isdefined(self.a.var_60B1))
		{
			if(self.a.var_60B1 == "prone")
			{
				var_00 = "prone";
			}
		}
	}

	return var_00;
}

//Function Number: 37
func_56F8(param_00,param_01)
{
	thread func_56F9(param_00,param_01);
}

//Function Number: 38
func_56F9(param_00,param_01)
{
	self endon("death");
	var_02 = [];
	var_03 = undefined;
	switch(param_00)
	{
		case "space_jet_bottom":
			var_02 = ["tag_jet_bottom_1","tag_jet_bottom_2"];
			break;

		case "space_jet_bottom_1":
			var_02 = ["tag_jet_bottom_1"];
			break;

		case "space_jet_bottom_2":
			var_02 = ["tag_jet_bottom_2"];
			break;

		case "space_jet_top":
			var_02 = ["tag_jet_top_1","tag_jet_top_2"];
			break;

		case "space_jet_top_1":
			var_02 = ["tag_jet_top_1"];
			break;

		case "space_jet_top_2":
			var_02 = ["tag_jet_top_2"];
			break;

		case "space_jet_left":
			var_02 = ["tag_jet_le_1","tag_jet_le_2"];
			break;

		case "space_jet_left_1":
			var_02 = ["tag_jet_le_1"];
			break;

		case "space_jet_left_2":
			var_02 = ["tag_jet_le_2"];
			break;

		case "space_jet_right":
			var_02 = ["tag_jet_ri_1","tag_jet_ri_2"];
			break;

		case "space_jet_right_1":
			var_02 = ["tag_jet_ri_1"];
			break;

		case "space_jet_right_2":
			var_02 = ["tag_jet_ri_2"];
			break;

		case "space_jet_front":
			var_02 = ["tag_jet_front_1","tag_jet_front_2"];
			break;

		case "space_jet_front_1":
			var_02 = ["tag_jet_front_1"];
			break;

		case "space_jet_front_2":
			var_02 = ["tag_jet_front_2"];
			break;

		case "space_jet_back":
			var_02 = ["tag_jet_back_1","tag_jet_back_2","tag_jet_back_3","tag_jet_back_4"];
			break;

		case "space_jet_back_1":
			var_02 = ["tag_jet_back_1"];
			break;

		case "space_jet_back_2":
			var_02 = ["tag_jet_back_2"];
			break;

		case "space_jet_back_3":
			var_02 = ["tag_jet_back_3"];
			break;

		case "space_jet_back_4":
			var_02 = ["tag_jet_back_4"];
			break;

		case "space_jet_random":
			var_02 = ["tag_jet_bottom_1","tag_jet_bottom_2","tag_jet_top_1","tag_jet_top_2","tag_jet_le_1","tag_jet_le_2","tag_jet_ri_1","tag_jet_ri_2"];
			break;
	}

	if(common_scripts\utility::func_36C3("space_jet_small") && isdefined(var_02))
	{
		if(isdefined(var_02))
		{
			if(param_00 == "space_jet_random")
			{
				for(var_04 = 0;var_04 < 6;var_04++)
				{
					var_05 = randomint(8);
					var_06 = var_02[var_05];
					if(maps\_utility::func_4027(self.model,var_06))
					{
						if(!isdefined(self.audio_jet_counter))
						{
							self.audio_jet_counter = 0;
						}

						self.audio_jet_counter++;
						if(self.audio_jet_counter > 5)
						{
							self.audio_jet_counter = 0;
						}

						if(self.audio_jet_counter == 1)
						{
							self playsound("space_npc_jetpack_boost_ss");
						}

						playfxontag(level._effect["space_jet_small"],self,var_06);
					}

					wait(randomfloatrange(0.1,0.3));
				}
			}

			foreach(var_06 in var_03)
			{
				if(isdefined(var_06) && maps\_utility::func_4027(self.model,var_06))
				{
					if(!isdefined(self.audio_jet_counter))
					{
						self.audio_jet_counter = 0;
					}

					self.audio_jet_counter++;
					if(self.audio_jet_counter > 5)
					{
						self.audio_jet_counter = 0;
					}

					if(self.audio_jet_counter == 1)
					{
						self playsound("space_npc_jetpack_boost_ss");
					}

					playfxontag(level._effect["space_jet_small"],self,var_06);
					wait(0.1);
				}
			}
		}
	}
}

//Function Number: 39
func_224B(param_00,param_01)
{
	if(isdefined(self.groundtype))
	{
		var_02 = self.groundtype;
	}
	else
	{
		var_02 = "dirt";
	}

	var_03 = undefined;
	if(isdefined(level._notetrackfx[param_00][var_02]))
	{
		var_03 = level._notetrackfx[param_00][var_02];
	}
	else if(isdefined(level._notetrackfx[param_00]["all"]))
	{
		var_03 = level._notetrackfx[param_00]["all"];
	}

	if(!isdefined(var_03))
	{
	}

	if(isai(self) && isdefined(var_03.fx))
	{
		playfxontag(var_03.fx,self,var_03.tag);
	}

	if(!isdefined(var_03.var_7712) && !isdefined(var_03.var_7715))
	{
	}

	var_04 = "" + var_03.var_7712 + var_02 + var_03.var_7715;
	self playsound(var_04);
}

//Function Number: 40
func_56DF(param_00,param_01)
{
	if(isdefined(self.groundtype))
	{
		var_02 = self.groundtype;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsound("step_scrape_" + var_02);
}

//Function Number: 41
func_56E6(param_00,param_01)
{
	if(isdefined(self.groundtype))
	{
		var_02 = self.groundtype;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsound("land_" + var_02);
	var_03 = self getclothmovesound("land");
	if(isdefined(var_03) && var_03 != "")
	{
		self playsoundatviewheight(var_03);
	}

	var_04 = self getequipmovesound(self.weapon,"land");
	if(isdefined(var_04) && var_04 != "")
	{
		self playsoundatviewheight(var_04);
	}
}

//Function Number: 42
func_56DA(param_00,param_01)
{
	return "code_move";
}

//Function Number: 43
func_56DC(param_00,param_01)
{
	if(self.script != "reactions")
	{
		self orientmode("face enemy");
	}

	if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.reactiontargetpos) < 4096)
	{
		self orientmode("face enemy");
	}

	self orientmode("face point",self.reactiontargetpos);
}

//Function Number: 44
notetrackbodyfall(param_00,param_01)
{
	var_02 = "_small";
	if(issubstr(param_00,"large"))
	{
		var_02 = "_large";
	}

	if(isdefined(self.groundtype))
	{
		var_03 = self.groundtype;
	}
	else
	{
		var_03 = "dirt";
	}

	self playsound("bodyfall_" + var_03 + var_02);
}

//Function Number: 45
func_3F95()
{
	self endon("detached");
	self waittill("death");
	if(isdefined(self.var_66F5))
	{
		self.var_66F5 delete();
	}
}

//Function Number: 46
func_56F5()
{
	self.var_66F5 = spawn("script_model",self.origin);
	if(issubstr(tolower(self.weapon),"panzerfaust"))
	{
		self.var_66F5 setmodel("weapon_panzerfaust3_missle");
	}
	else
	{
		self.var_66F5 setmodel("projectile_rpg7");
	}

	self.var_66F5 linkto(self,"tag_inhand",(0,0,0),(0,0,0));
	thread func_3F95();
}

//Function Number: 47
func_56F6()
{
	self notify("detached");
	if(isdefined(self.var_66F5))
	{
		self.var_66F5 delete();
	}

	self.a.var_66F8 = 1;
	if(isai(self) && !isalive(self))
	{
	}

	if(maps\_utility::func_4027(getweaponmodel(self.weapon),"tag_rocket"))
	{
		self showpart("tag_rocket");
	}
}

//Function Number: 48
handlenotetrack(param_00,param_01,param_02)
{
	if(isai(self) && self.type == "alien")
	{
		func_3F6C(param_00);
	}

	if(isai(self) && self.type == "dog")
	{
		if(func_3F78(param_00))
		{
		}
	}

	var_03 = level.var_56F7[param_00];
	if(isdefined(var_03))
	{
		return [[ var_03 ]](param_00,param_01);
	}

	switch(param_00)
	{
		case "undefined":
		case "finish":
		case "end":
			return param_00;

		case "finish early":
			if(isdefined(self.enemy))
			{
				return param_00;
			}
			break;

		case "swish small":
			thread common_scripts\utility::func_5D1F("melee_swing_small",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "swish large":
			thread common_scripts\utility::func_5D1F("melee_swing_large",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "rechamber":
			if(animscripts/utility::func_8D9B())
			{
				self playsound("weap_reload_shotgun_pump_npc");
			}
	
			self.a.var_5593 = 0;
			break;

		case "no death":
			self.a.var_564F = 1;
			break;

		case "no pain":
			self.allowpain = 0;
			break;

		case "allow pain":
			self.allowpain = 1;
			break;

		case "anim_melee = \"right\":
		case "anim_melee = right":
			self.a.var_51AA = "right";
			break;

		case "anim_melee = \"left\":
		case "anim_melee = left":
			self.a.var_51AA = "left";
			break;

		case "swap taghelmet to tagleft":
			if(isdefined(self.hatmodel))
			{
				if(isdefined(self.helmetsidemodel))
				{
					self detach(self.helmetsidemodel,"TAG_HELMETSIDE");
					self.helmetsidemodel = undefined;
				}
	
				self detach(self.hatmodel,"");
				self attach(self.hatmodel,"TAG_WEAPON_LEFT");
				self.hatmodel = undefined;
			}
			break;

		case "stop anim":
			maps\_utility::anim_stopanimscripted();
			return param_00;

		case "break glass":
			level notify("glass_break",self);
			break;

		case "break_glass":
			level notify("glass_break",self);
			break;

		case "attach clip left":
			if(animscripts/utility::func_87FA())
			{
				func_56F5();
			}
			break;

		case "detach clip left":
			if(animscripts/utility::func_87FA())
			{
				func_56F6();
			}
	
			break;

		default:
			if(isdefined(param_02))
			{
				return [[ param_02 ]](param_00);
			}
			break;
	}
}

//Function Number: 49
func_2990(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = "undefined";
		}

		var_04 = [[ param_01 ]](var_03);
		if(isdefined(var_04) && var_04)
		{
			continue;
		}

		var_05 = handlenotetrack(var_03,param_00);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 50
donotetrackspostcallback(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_00,var_02);
		if(!isdefined(var_02))
		{
			var_02 = "undefined";
		}

		var_03 = handlenotetrack(var_02,param_00);
		[[ param_01 ]](var_02);
		if(isdefined(var_03))
		{
			return var_03;
		}
	}
}

//Function Number: 51
func_298E(param_00,param_01,param_02,param_03)
{
	animscripts/shared::func_2986(param_00,param_02,param_03);
}

//Function Number: 52
donotetracksforever(param_00,param_01,param_02,param_03)
{
	func_2989(::animscripts/shared::func_2986,param_00,param_01,param_02,param_03);
}

//Function Number: 53
func_2988(param_00,param_01,param_02,param_03)
{
	func_2989(::func_2990,param_00,param_01,param_02,param_03);
}

//Function Number: 54
func_2989(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	self endon("killanimscript");
	if(!isdefined(param_04))
	{
		param_04 = "undefined";
	}

	for(;;)
	{
		var_05 = gettime();
		var_06 = [[ param_00 ]](param_01,param_03,param_04);
		var_07 = gettime() - var_05;
		if(var_07 < 0.05)
		{
			var_05 = gettime();
			var_06 = [[ param_00 ]](param_01,param_03,param_04);
			var_07 = gettime() - var_05;
			if(var_07 < 0.05)
			{
				wait(0.05 - var_07);
			}
		}
	}
}

//Function Number: 55
donotetrackswithtimeout(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_298C(param_01);
	func_298F(::func_298E,param_00,param_02,param_03,var_04);
}

//Function Number: 56
donotetracksfortime(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_298C(param_00);
	func_298F(::donotetracksforever,param_01,param_02,param_03,var_04);
}

//Function Number: 57
func_298D(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_298C(param_00);
	func_298F(::func_2988,param_01,param_02,param_03,var_04);
}

//Function Number: 58
func_298F(param_00,param_01,param_02,param_03,param_04)
{
	param_04 endon("stop_notetracks");
	[[ param_00 ]](param_01,undefined,param_02,param_03);
}

//Function Number: 59
func_298C(param_00)
{
	wait(param_00);
	self notify("stop_notetracks");
}

//Function Number: 60
func_6008(param_00,param_01)
{
	if(!isai(self))
	{
		self playsound("step_run_dirt");
	}

	var_02 = undefined;
	if(!isdefined(self.groundtype))
	{
		if(!isdefined(self.var_4C69))
		{
			self playsound("step_run_dirt");
		}

		var_02 = self.var_4C69;
	}
	else
	{
		var_02 = self.groundtype;
		self.var_4C69 = self.groundtype;
	}

	var_03 = "J_Ball_RI";
	if(param_00)
	{
		var_03 = "J_Ball_LE";
	}

	var_04 = func_3911();
	self playsound("step_" + var_04 + "_" + var_02);
	if(param_01)
	{
		if(![[ level.var_59D0 ]](var_03,var_02))
		{
			func_600A(var_03,var_02);
		}
	}

	if(![[ level.var_59D2 ]](var_03,var_02))
	{
		func_6009(var_03,var_02);
	}
}

//Function Number: 61
func_6009(param_00,param_01)
{
	if(!isdefined(level.var_59D1[param_01]))
	{
		return 0;
	}

	var_02 = self gettagorigin(param_00);
	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = var_04 * -1;
	var_06 = anglestoup(var_03);
	playfx(level._effect["step_" + param_01],var_02,var_06,var_05);
	return 1;
}

//Function Number: 62
func_600A(param_00,param_01)
{
	if(!isdefined(level.var_59D3[param_01]))
	{
		return 0;
	}

	var_02 = self gettagorigin(param_00);
	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = var_04 * -1;
	var_06 = anglestoup(var_03);
	playfx(level._effect["step_small_" + param_01],var_02,var_06,var_05);
	return 1;
}

//Function Number: 63
func_7442()
{
	waittillframeend;
	if(isdefined(self) && gettime() > self.a.lastshoottime)
	{
		animscripts/utility::func_7435();
		animscripts/combat_utility::func_2467();
		if(weaponclass(self.weapon) == "rocketlauncher")
		{
			self.a.rockets--;
		}
	}
}

//Function Number: 64
func_32E8()
{
	if(self.a.var_8DB5["right"] == "none")
	{
	}

	if(isdefined(self.var_29B1))
	{
		func_7442();
	}

	var_00 = self gettagorigin("tag_weapon");
	var_01 = anglestoforward(self getmuzzleangle());
	var_02 = var_00 + var_01 * 1000;
	self shoot(1,var_02);
	animscripts/combat_utility::func_2467();
}

//Function Number: 65
func_56DE(param_00,param_01)
{
	if(!isalive(self) && self isbadguy())
	{
		if(isdefined(self.changed_team))
		{
		}

		self.changed_team = 1;
		var_02["axis"] = "team3";
		var_02["team3"] = "axis";
		self.team = var_02[self.team];
	}

	if(!issentient(self))
	{
		self notify("fire");
	}

	if(self.a.var_8DB5["right"] == "none")
	{
	}

	var_03 = self getmuzzlepos();
	var_04 = anglestoforward(self getmuzzleangle());
	var_05 = 10;
	if(isdefined(self.var_4940))
	{
		var_05 = 20;
	}

	var_06 = 0;
	if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy())
	{
		var_07 = vectornormalize(self.enemy geteye() - var_03);
		if(vectordot(var_04,var_07) > cos(var_05))
		{
			var_06 = 1;
		}
	}

	if(var_06)
	{
		animscripts/utility::func_7435();
	}
	else
	{
		var_04 = var_04 + (randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1);
		var_08 = var_03 + var_04 * 1000;
		self [[ level.var_7449 ]](var_08);
	}

	animscripts/combat_utility::func_2467();
}