/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\notetracks.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 91
 * Decompile Time: 4777 ms
 * Timestamp: 10/27/2023 12:00:47 AM
*******************************************************************/

//Function Number: 1
func_DF01()
{
	if(isdefined(level.var_C118))
	{
		return;
	}

	anim.var_C118 = [];
	func_DF00();
}

//Function Number: 2
func_DF00()
{
	level.var_C118["anim_pose = \"stand\"] = ::func_C10F;
	level.var_C118["anim_pose = \"crouch\"] = ::func_C10D;
	level.var_C118["anim_pose = \"prone\"] = ::func_C10E;
	level.var_C118["anim_pose = \"crawl\"] = ::func_C10C;
	level.var_C118["anim_pose = \"back\"] = ::func_C10B;
	level.var_C118["anim_movement = \"stop\"] = ::func_C106;
	level.var_C118["anim_movement = \"walk\"] = ::func_C107;
	level.var_C118["anim_movement = \"run\"] = ::func_C105;
	level.var_C118["anim_gunhand = \"left\"] = ::func_C0FD;
	level.var_C118["anim_gunhand = \"right\"] = ::func_C0FD;
	level.var_C118["anim_gunhand = \"none\"] = ::func_C0FD;
	level.var_C118["anim_pose = stand"] = ::func_C10F;
	level.var_C118["anim_pose = crouch"] = ::func_C10D;
	level.var_C118["anim_pose = prone"] = ::func_C10E;
	level.var_C118["anim_pose = crawl"] = ::func_C10C;
	level.var_C118["anim_pose = back"] = ::func_C10B;
	level.var_C118["anim_movement = stop"] = ::func_C106;
	level.var_C118["anim_movement = walk"] = ::func_C107;
	level.var_C118["anim_movement = run"] = ::func_C105;
	level.var_C118["anim_movement_gun_pose_override = run_gun_down"] = ::func_C104;
	level.var_C118["anim_aiming = 1"] = ::func_C0E2;
	level.var_C118["anim_aiming = 0"] = ::func_C0E3;
	level.var_C118["anim_alertness = causal"] = ::func_C0E4;
	level.var_C118["anim_alertness = alert"] = ::func_C0E3;
	level.var_C118["anim_alertness = aiming"] = ::func_C0E2;
	level.var_C118["gunhand = (gunhand)_left"] = ::func_C0FD;
	level.var_C118["anim_gunhand = left"] = ::func_C0FD;
	level.var_C118["gunhand = (gunhand)_right"] = ::func_C0FD;
	level.var_C118["anim_gunhand = right"] = ::func_C0FD;
	level.var_C118["anim_gunhand = none"] = ::func_C0FD;
	level.var_C118["gun drop"] = ::func_C0FC;
	level.var_C118["dropgun"] = ::func_C0FC;
	level.var_C118["gun_2_chest"] = ::func_C0FF;
	level.var_C118["gun_2_back"] = ::func_C0FE;
	level.var_C118["pistol_pickup"] = ::func_C108;
	level.var_C118["pistol_putaway"] = ::func_C109;
	level.var_C118["drop clip"] = ::func_C0E7;
	level.var_C118["refill clip"] = ::func_C115;
	level.var_C118["reload done"] = ::func_C115;
	level.var_C118["load_shell"] = ::func_C103;
	level.var_C118["pistol_rechamber"] = ::func_C10A;
	level.var_C118["gravity on"] = ::func_C0FB;
	level.var_C118["gravity off"] = ::func_C0FB;
	level.var_C118["footstep_right_large"] = ::func_C0F9;
	level.var_C118["footstep_right_small"] = ::func_C0F9;
	level.var_C118["footstep_left_large"] = ::func_C0F9;
	level.var_C118["footstep_left_small"] = ::func_C0F9;
	level.var_C118["handstep_left"] = ::func_C100;
	level.var_C118["handstep_right"] = ::func_C100;
	level.var_C118["footscrape"] = ::func_C0F8;
	level.var_C118["land"] = ::func_C101;
	level.var_C118["bodyfall large"] = ::func_C0E5;
	level.var_C118["bodyfall small"] = ::func_C0E5;
	level.var_C118["code_move"] = ::func_C0E6;
	level.var_C118["face_enemy"] = ::func_C0E8;
	level.var_C118["laser_on"] = ::func_C102;
	level.var_C118["laser_off"] = ::func_C102;
	level.var_C118["start_ragdoll"] = ::func_C11C;
	level.var_C118["ragdollblendinit"] = ::func_C111;
	level.var_C118["ragdollblendstart"] = ::func_C114;
	level.var_C118["ragdollblendend"] = ::func_C110;
	level.var_C118["ragdollblendrootanim"] = ::func_C112;
	level.var_C118["ragdollblendrootragdoll"] = ::func_C113;
	level.var_C118["fire"] = ::func_C0F6;
	level.var_C118["fire_spray"] = ::func_C0F7;
	level.var_C118["bloodpool"] = ::scripts\anim\death::func_CCAA;
	level.var_C118["space_jet_top"] = ::func_C119;
	level.var_C118["space_jet_top_1"] = ::func_C119;
	level.var_C118["space_jet_top_2"] = ::func_C119;
	level.var_C118["space_jet_bottom"] = ::func_C119;
	level.var_C118["space_jet_bottom_1"] = ::func_C119;
	level.var_C118["space_jet_bottom_2"] = ::func_C119;
	level.var_C118["space_jet_left"] = ::func_C119;
	level.var_C118["space_jet_left_1"] = ::func_C119;
	level.var_C118["space_jet_left_2"] = ::func_C119;
	level.var_C118["space_jet_right"] = ::func_C119;
	level.var_C118["space_jet_right_1"] = ::func_C119;
	level.var_C118["space_jet_right_2"] = ::func_C119;
	level.var_C118["space_jet_front"] = ::func_C119;
	level.var_C118["space_jet_front_1"] = ::func_C119;
	level.var_C118["space_jet_front_2"] = ::func_C119;
	level.var_C118["space_jet_back"] = ::func_C119;
	level.var_C118["space_jet_back_1"] = ::func_C119;
	level.var_C118["space_jet_back_2"] = ::func_C119;
	level.var_C118["space_jet_back_3"] = ::func_C119;
	level.var_C118["space_jet_back_4"] = ::func_C119;
	level.var_C118["space_jet_random"] = ::func_C119;
	level.var_C118["fingers_out_start_left_hand"] = ::func_C0F2;
	level.var_C118["fingers_out_start_right_hand"] = ::func_C0F3;
	level.var_C118["fingers_in_start_left_hand"] = ::func_C0F4;
	level.var_C118["fingers_in_start_right_hand"] = ::func_C0F5;
	level.var_C118["anim_facial = idle"] = ::func_C0ED;
	level.var_C118["anim_facial = run"] = ::func_C0EF;
	level.var_C118["anim_facial = pain"] = ::func_C0EE;
	level.var_C118["anim_facial = death"] = ::func_C0EB;
	level.var_C118["anim_facial = talk"] = ::func_C0F1;
	level.var_C118["anim_facial = cheer"] = ::func_C0EA;
	level.var_C118["anim_facial = happy"] = ::func_C0EC;
	level.var_C118["anim_facial = angry"] = ::func_C0E9;
	level.var_C118["anim_facial = scared"] = ::func_C0F0;
	level.var_C118["visor_raise"] = ::func_C11F;
	level.var_C118["visor_lower"] = ::func_C11E;
	level.var_C118["c12_death_dying"] = ::func_3538;
	level.var_C118["c12_death_bodyfall"] = ::func_3537;
	if(isdefined(level.var_1359))
	{
		var_00 = getarraykeys(level.var_1359);
		foreach(var_02 in var_00)
		{
			level.var_C118[var_02] = ::func_4C92;
		}
	}
}

//Function Number: 3
func_3538(param_00,param_01)
{
	if(soundexists("generic_death_c12"))
	{
		self playsound("generic_death_c12");
	}
}

//Function Number: 4
func_3537(param_00,param_01)
{
	if(soundexists("c12_death_generic_bf"))
	{
		self playsound("c12_death_generic_bf");
	}
}

//Function Number: 5
func_C0F6(param_00,param_01)
{
	if(isdefined(level.var_6D14[self.script]))
	{
		thread [[ level.var_6D14[self.script] ]]();
		return;
	}

	thread func_FEC8();
}

//Function Number: 6
func_FEC8()
{
	waittillframeend;
	if(isdefined(self) && gettime() > self.var_1491.var_A9ED)
	{
		if(isdefined(self.var_2303.var_FECD))
		{
			var_00 = self.var_2303.var_FECD.var_FF0B == 1;
		}
		else
		{
			var_00 = 1;
		}

		scripts\anim\utility_common::func_FE9A(var_00);
		scripts\anim\combat_utility::func_4FBE();
		if(weaponclass(self.var_394) == "rocketlauncher")
		{
			self.var_1491.var_E5DE--;
		}
	}
}

//Function Number: 7
func_C102(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self.var_1491.var_A878 = 1;
	}
	else
	{
		self.var_1491.var_A878 = 0;
	}

	scripts\anim\shared::func_12EBD();
}

//Function Number: 8
func_C11D(param_00,param_01)
{
}

//Function Number: 9
func_12BB4()
{
	wait(0.1);
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 10
func_C11C(param_00,param_01)
{
	if(isdefined(self.var_C089))
	{
		return;
	}

	if(isdefined(self.var_DC23))
	{
		return;
	}

	if(!isdefined(self.var_594E))
	{
		thread func_12BB4();
	}

	if(isdefined(self.var_1198))
	{
		if(isdefined(self.var_1198.var_26C6) && self.var_1198.var_26C6 == 1)
		{
			scripts\anim\shared::func_5D19();
			self.var_AA45 = self.var_394;
		}
	}

	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	if(isdefined(self))
	{
		self method_839A();
	}
}

//Function Number: 11
func_C111(param_00,param_01)
{
	if(isdefined(self.var_C089))
	{
		return;
	}

	if(isdefined(self.var_DC23))
	{
		return;
	}

	if(!isdefined(self.var_594E))
	{
		thread func_12BB4();
	}

	if(isdefined(self.var_1198))
	{
		if(isdefined(self.var_1198.var_26C6) && self.var_1198.var_26C6 == 1)
		{
			scripts\anim\shared::func_5D19();
			self.var_AA45 = self.var_394;
		}
	}

	if(isdefined(self.var_71C8))
	{
		self [[ self.var_71C8 ]]();
	}

	self method_8576();
}

//Function Number: 12
func_C114(param_00,param_01)
{
}

//Function Number: 13
func_C110(param_00,param_01)
{
}

//Function Number: 14
func_C112(param_00,param_01)
{
}

//Function Number: 15
func_C113(param_00,param_01)
{
}

//Function Number: 16
func_C106(param_00,param_01)
{
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 17
func_C107(param_00,param_01)
{
	self.var_1491.var_BCC8 = "walk";
}

//Function Number: 18
func_C105(param_00,param_01)
{
	self.var_1491.var_BCC8 = "run";
}

//Function Number: 19
func_C104(param_00,param_01)
{
	self.var_2303.var_BCCB = "run_gun_down";
}

//Function Number: 20
func_C0E2(param_00,param_01)
{
}

//Function Number: 21
func_C0E4(param_00,param_01)
{
}

//Function Number: 22
func_C0E3(param_00,param_01)
{
}

//Function Number: 23
func_11082()
{
	scripts\anim\utility::func_697B(1);
	self.var_1491.var_C4C8 = undefined;
}

//Function Number: 24
func_F803(param_00)
{
	self.var_1491.var_D6A5 = param_00;
	if(isdefined(self.var_1491.var_C4C8))
	{
		func_11082();
	}

	lib_0A1B::func_296A(param_00);
	self notify("entered_pose" + param_00);
}

//Function Number: 25
func_C10F(param_00,param_01)
{
	if(self.var_1491.var_D6A5 == "prone")
	{
		scripts\anim\utility::func_697B(1);
	}

	func_F803("stand");
}

//Function Number: 26
func_C10D(param_00,param_01)
{
	if(self.var_1491.var_D6A5 == "prone")
	{
		scripts\anim\utility::func_697B(1);
	}

	func_F803("crouch");
}

//Function Number: 27
func_C10E(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self method_832B(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	scripts\anim\utility::func_662A(1);
	func_F803("prone");
	if(isdefined(self.var_1491.var_8445))
	{
		self.var_1491.var_DA7D = 1;
		return;
	}

	self.var_1491.var_DA7D = undefined;
}

//Function Number: 28
func_C10C(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self method_832B(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	scripts\anim\utility::func_662A(1);
	func_F803("prone");
	self.var_1491.var_DA7D = undefined;
}

//Function Number: 29
func_C10B(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	func_F803("crouch");
	self.var_1491.var_C4C8 = 1;
	self.var_1491.var_BCC8 = "stop";
	self method_832B(-90,90,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	scripts\anim\utility::func_662A(1);
}

//Function Number: 30
func_C0FD(param_00,param_01)
{
	if(issubstr(param_00,"left"))
	{
		scripts\anim\shared::func_CC2C(self.var_394,"left");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"right"))
	{
		scripts\anim\shared::func_CC2C(self.var_394,"right");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"none"))
	{
		scripts\anim\shared::func_CC2C(self.var_394,"none");
		return;
	}
}

//Function Number: 31
func_C0FC(param_00,param_01)
{
	scripts\anim\shared::func_5D19();
	self.var_1198.var_26C6 = 0;
	self.var_AA45 = self.var_394;
}

//Function Number: 32
func_C0FF(param_00,param_01)
{
	scripts\anim\shared::func_CC2C(self.var_394,"chest");
}

//Function Number: 33
func_C0FE(param_00,param_01)
{
	scripts\anim\shared::func_CC2C(self.var_394,"back");
	self.var_394 = scripts\anim\utility::func_8097();
	self.var_3250 = weaponclipsize(self.var_394);
}

//Function Number: 34
func_C108(param_00,param_01)
{
	scripts\anim\shared::func_CC2C(self.var_101B4,"right");
	self.var_3250 = weaponclipsize(self.var_394);
	self notify("weapon_switch_done");
}

//Function Number: 35
func_C109(param_00,param_01)
{
	if(isdefined(self.var_110CB))
	{
		scripts\anim\shared::func_CC2C(self.var_394,"thigh");
	}
	else
	{
		scripts\anim\shared::func_CC2C(self.var_394,"none");
	}

	self.var_394 = scripts\anim\utility::func_8097();
	self.var_3250 = weaponclipsize(self.var_394);
}

//Function Number: 36
func_C0E7(param_00,param_01)
{
	thread scripts\anim\shared::func_8996(param_01);
}

//Function Number: 37
func_C115(param_00,param_01)
{
	scripts\anim\weaponlist::func_DE4D();
	self.var_1491.var_BE98 = 0;
}

//Function Number: 38
func_C103(param_00,param_01)
{
	self playsound("weap_reload_shotgun_loop_npc");
}

//Function Number: 39
func_C10A(param_00,param_01)
{
	self playsound("weap_reload_pistol_chamber_npc");
}

//Function Number: 40
func_C0FB(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self method_8016("gravity");
		return;
	}

	if(issubstr(param_00,"off"))
	{
		self method_8016("nogravity");
	}
}

//Function Number: 41
func_C0F9(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	var_04 = "right";
	if(var_02)
	{
		var_04 = "left";
	}

	if(isai(self))
	{
		self.var_2303.var_7257.var_7254 = var_04;
		self.var_2303.var_7257.time = gettime();
	}

	if(lib_0A1B::func_9ED3("left_leg") || lib_0A1B::func_9ED3("right_leg"))
	{
		return;
	}

	func_D47E(var_02,var_03);
	var_05 = func_7B24();
	if(isdefined(self.classname) && self.classname != "script_model")
	{
		self method_8584(var_05);
		if(isdefined(self.var_394))
		{
			var_06 = self method_8583(var_05,self.var_394);
		}
	}
}

//Function Number: 42
func_C100(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	var_04 = "right";
	if(var_02)
	{
		var_04 = "left";
	}

	if(isai(self))
	{
		self.var_2303.var_7257.var_7254 = var_04;
		self.var_2303.var_7257.time = gettime();
	}

	func_D492(var_02,var_03);
}

//Function Number: 43
func_7B24()
{
	var_00 = "run";
	if(isdefined(self.var_10AB7))
	{
		var_00 = "sprint";
	}

	if(isdefined(self.var_1198))
	{
		if(self.var_1198.var_BD23 == "walk" || self.var_1198.var_BD23 == "casual_gun" || self.var_1198.var_BD23 == "patrol" || self.var_1198.var_BD23 == "casual")
		{
			var_00 = "walk";
		}

		if(lib_0A1B::func_292C() == "prone")
		{
			var_00 = "prone";
		}
	}
	else if(isdefined(self.var_1491))
	{
		if(isdefined(self.var_1491.var_BCC8))
		{
			if(self.var_1491.var_BCC8 == "walk")
			{
				var_00 = "walk";
			}
		}

		if(isdefined(self.var_1491.var_D6A5))
		{
			if(self.var_1491.var_D6A5 == "prone")
			{
				var_00 = "prone";
			}
		}
	}

	return var_00;
}

//Function Number: 44
func_C119(param_00,param_01)
{
	thread func_C11A(param_00,param_01);
}

//Function Number: 45
func_C11A(param_00,param_01)
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

	if(scripts\common\utility::fxexists("space_jet_small") && isdefined(var_02))
	{
		if(isdefined(var_02))
		{
			if(param_00 == "space_jet_random")
			{
				for(var_04 = 0;var_04 < 6;var_04++)
				{
					var_05 = randomint(8);
					var_06 = var_02[var_05];
					if(scripts\sp\_utility::func_8C32(self.model,var_06))
					{
						if(!isdefined(self.var_25C8))
						{
							self.var_25C8 = 0;
						}

						self.var_25C8++;
						if(self.var_25C8 > 5)
						{
							self.var_25C8 = 0;
						}

						if(self.var_25C8 == 1)
						{
							self playsound("space_npc_jetpack_boost_ss");
						}

						playfxontag(level._effect["space_jet_small"],self,var_06);
					}

					wait(randomfloatrange(0.1,0.3));
				}

				return;
			}

			foreach(var_06 in var_03)
			{
				if(isdefined(var_06) && scripts\sp\_utility::func_8C32(self.model,var_06))
				{
					if(!isdefined(self.var_25C8))
					{
						self.var_25C8 = 0;
					}

					self.var_25C8++;
					if(self.var_25C8 > 5)
					{
						self.var_25C8 = 0;
					}

					if(self.var_25C8 == 1)
					{
						self playsound("space_npc_jetpack_boost_ss");
					}

					playfxontag(level._effect["space_jet_small"],self,var_06);
					wait(0.1);
				}
			}

			return;
		}
	}
}

//Function Number: 46
func_C11F(param_00,param_01)
{
	if(!isai(self))
	{
		return;
	}

	self.var_2303.var_DC48 = 1;
	lib_0A1E::func_236E();
}

//Function Number: 47
func_C11E(param_00,param_01)
{
	if(!isai(self))
	{
		return;
	}

	self.var_2303.var_DC48 = 0;
	lib_0A1E::func_236E();
}

//Function Number: 48
func_C0F2(param_00,param_01)
{
	lib_0A1E::func_2319("left");
}

//Function Number: 49
func_C0F4(param_00,param_01)
{
	lib_0A1E::func_234C("left");
}

//Function Number: 50
func_C0F3(param_00,param_01)
{
	lib_0A1E::func_2319("left");
}

//Function Number: 51
func_C0F5(param_00,param_01)
{
	lib_0A1E::func_234C("right");
}

//Function Number: 52
func_C0ED(param_00,param_01)
{
	lib_0A1E::func_236A("facial_idle");
}

//Function Number: 53
func_C0EF(param_00,param_01)
{
	lib_0A1E::func_236A("facial_run");
}

//Function Number: 54
func_C0EE(param_00,param_01)
{
	lib_0A1E::func_236A("facial_pain");
}

//Function Number: 55
func_C0EB(param_00,param_01)
{
	lib_0A1E::func_236A("facial_death");
}

//Function Number: 56
func_C0F1(param_00,param_01)
{
	lib_0A1E::func_236A("facial_talk");
}

//Function Number: 57
func_C0EA(param_00,param_01)
{
	lib_0A1E::func_236A("facial_cheer");
}

//Function Number: 58
func_C0EC(param_00,param_01)
{
	lib_0A1E::func_236A("facial_happy");
}

//Function Number: 59
func_C0F0(param_00,param_01)
{
	lib_0A1E::func_236A("facial_scared");
}

//Function Number: 60
func_C0E9(param_00,param_01)
{
	lib_0A1E::func_236A("facial_angry");
}

//Function Number: 61
func_4C92(param_00,param_01)
{
	if(isdefined(self.var_168))
	{
		var_02 = self.var_168;
	}
	else
	{
		var_02 = "dirt";
	}

	var_03 = undefined;
	if(isdefined(level.var_1359[param_00][var_02]))
	{
		var_03 = level.var_1359[param_00][var_02];
	}
	else if(isdefined(level.var_1359[param_00]["all"]))
	{
		var_03 = level.var_1359[param_00]["all"];
	}

	if(!isdefined(var_03))
	{
		return;
	}

	if(isai(self) && isdefined(var_03.var_7542))
	{
		playfxontag(var_03.var_7542,self,var_03.var_2DD);
	}

	if(!isdefined(var_03.var_1046D) && !isdefined(var_03.var_10470))
	{
		return;
	}

	var_04 = "" + var_03.var_1046D + var_02 + var_03.var_10470;
	if(soundexists(var_04))
	{
		self playsound(var_04);
	}
}

//Function Number: 62
func_C0F8(param_00,param_01)
{
	if(isdefined(self.var_168))
	{
		var_02 = self.var_168;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsurfacesound("step_scrape",var_02);
}

//Function Number: 63
func_C101(param_00,param_01)
{
	if(isdefined(self.var_168))
	{
		var_02 = self.var_168;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsurfacesound("default_step_land",var_02);
	self method_8584("land");
	self method_8583("land",self.var_394);
}

//Function Number: 64
func_C0E6(param_00,param_01)
{
	return "code_move";
}

//Function Number: 65
func_C0E8(param_00,param_01)
{
	if(self.script != "reactions")
	{
		self method_8221("face enemy");
		return;
	}

	if(isdefined(self.var_10C) && distancesquared(self.var_10C.origin,self.var_25C) < 4096)
	{
		self method_8221("face enemy");
		return;
	}

	self method_8221("face point",self.var_25C);
}

//Function Number: 66
func_C0E5(param_00,param_01)
{
	var_02 = "_small";
	if(issubstr(param_00,"large"))
	{
		var_02 = "_large";
	}

	if(isdefined(self.var_168))
	{
		var_03 = self.var_168;
	}
	else
	{
		var_03 = "dirt";
	}

	if(soundexists("bodyfall_" + var_03 + var_02))
	{
		self playsound("bodyfall_" + var_03 + var_02);
	}
}

//Function Number: 67
func_89DE()
{
	self endon("detached");
	self waittill("death");
	if(isdefined(self.var_E5DC))
	{
		self.var_E5DC delete();
	}
}

//Function Number: 68
func_C116()
{
	if(!isalive(self))
	{
		return;
	}

	if(!scripts\anim\utility_common::func_1311B())
	{
		return;
	}

	self.var_E5DC = spawn("script_model",self.origin);
	if(issubstr(tolower(self.var_394),"lockon"))
	{
		self.var_E5DC setmodel("weapon_launcher_missile_wm");
	}
	else if(issubstr(tolower(self.var_394),"panzerfaust"))
	{
		self.var_E5DC setmodel("weapon_panzerfaust3_missle");
	}
	else
	{
		self.var_E5DC setmodel("projectile_rpg7");
	}

	self.var_E5DC linkto(self,"tag_accessory_right",(0,0,0),(0,0,0));
	thread func_89DE();
}

//Function Number: 69
func_C117()
{
	self notify("detached");
	if(isdefined(self.var_E5DC))
	{
		self.var_E5DC delete();
	}

	self.var_1491.var_E5E3 = 1;
	if(isai(self) && !isalive(self))
	{
		return;
	}

	if(scripts\sp\_utility::func_8C32(function_00EA(self.var_394),"tag_rocket"))
	{
		self method_8387("tag_rocket");
	}
}

//Function Number: 70
func_89CB(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_C118[param_00];
	if(isdefined(var_04))
	{
		return [[ var_04 ]](param_00,param_01);
	}
	else if(isdefined(self.var_4C93))
	{
		if(isdefined(param_03))
		{
			return [[ self.var_4C93 ]](param_00,param_01,param_02,param_03);
		}
		else
		{
			return [[ self.var_4C93 ]](param_00,param_01,param_02);
		}
	}

	switch(param_00)
	{
		case "undefined":
		case "finish":
		case "end":
			return param_00;

		case "finish early":
			if(isdefined(self.var_10C))
			{
				return param_00;
			}
			break;

		case "swish small":
			thread scripts\common\utility::play_sound_in_space("melee_swing_small",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "swish large":
			thread scripts\common\utility::play_sound_in_space("melee_swing_large",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "rechamber":
			if(scripts\anim\utility_common::func_13C40())
			{
				self playsound("weap_reload_shotgun_pump_npc");
			}
	
			self.var_1491.var_BE98 = 0;
			break;

		case "no death":
			self.var_1491.var_C043 = 1;
			break;

		case "no pain":
			self.allowpain = 0;
			break;

		case "allow pain":
			self.allowpain = 1;
			break;

		case "anim_melee = \"right\":
		case "anim_melee = right":
			self.var_1491.var_B646 = "right";
			break;

		case "anim_melee = \"left\":
		case "anim_melee = left":
			self.var_1491.var_B646 = "left";
			break;

		case "swap taghelmet to tagleft":
			if(isdefined(self.var_8C43))
			{
				if(isdefined(self.var_8E1C))
				{
					self detach(self.var_8E1C,"TAG_HELMETSIDE");
					self.var_8E1C = undefined;
				}
	
				self detach(self.var_8C43,"");
				self attach(self.var_8C43,"TAG_WEAPON_LEFT");
				self.var_8C43 = undefined;
			}
			break;

		case "stop anim":
			scripts\sp\_utility::func_1F53();
			return param_00;

		case "break glass":
			level notify("glass_break",self);
			break;

		case "break_glass":
			level notify("glass_break",self);
			break;

		case "attach clip left":
			if(scripts\anim\utility_common::func_1311B())
			{
				func_C116();
			}
			break;

		case "detach clip left":
			if(scripts\anim\utility_common::func_1311B())
			{
				func_C117();
			}
			break;

		case "jetpack_boost":
			thread func_CCAB("boost_on_up","large");
			break;

		case "boost_on_right":
		case "boost_on_left":
		case "boost_on_down":
		case "boost_on_back":
		case "boost_on_forward":
		case "boost_on_up":
			thread func_CCAB(param_00,"large");
			break;

		case "boost_on_right_short":
		case "boost_on_left_short":
		case "boost_on_down_short":
		case "boost_on_up_short":
		case "boost_on_back_short":
		case "boost_on_forward_short":
			func_CCAB(param_00,"small");
			break;

		case "jetpack_death_fx":
			playfxontag(scripts\common\utility::getfx("zerog_jetpack_death"),self,"tag_fx_bottom");
			break;

		case "start_drift":
			if(!self.var_132)
			{
				self method_8016("physics_drift");
			}
			break;

		case "c6_punch":
			self playsound("c6_punch");
			break;

		default:
			if(isdefined(param_02))
			{
				if(isdefined(param_03))
				{
					return [[ param_02 ]](param_00,param_03);
				}
				else
				{
					return [[ param_02 ]](param_00);
				}
			}
			break;
	}
}

//Function Number: 71
func_5936(param_00,param_01,param_02)
{
	for(;;)
	{
		self waittill(param_00,var_03);
		if(!isdefined(var_03))
		{
			var_03 = ["undefined"];
		}

		if(!isarray(var_03))
		{
			var_03 = [var_03];
		}

		scripts\anim\utility::func_13142(param_00,var_03);
		var_04 = [[ param_01 ]](var_03);
		if(isdefined(var_04) && var_04)
		{
			continue;
		}

		var_05 = undefined;
		foreach(var_07 in var_03)
		{
			var_08 = func_89CB(var_07,param_00);
			if(isdefined(var_08))
			{
				var_05 = var_08;
				break;
			}
		}

		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 72
func_5937(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_00,var_02);
		if(!isdefined(var_02))
		{
			var_02 = ["undefined"];
		}

		if(!isarray(var_02))
		{
			var_02 = [var_02];
		}

		scripts\anim\utility::func_13142(param_00,var_02);
		var_03 = undefined;
		foreach(var_05 in var_02)
		{
			var_06 = func_89CB(var_05,param_00);
			if(isdefined(var_06))
			{
				var_03 = var_06;
				break;
			}
		}

		[[ param_01 ]](var_02);
		if(isdefined(var_03))
		{
			return var_03;
		}
	}
}

//Function Number: 73
func_5934(param_00,param_01,param_02,param_03)
{
	scripts\anim\shared::func_592B(param_00,param_02,param_03);
}

//Function Number: 74
func_592D(param_00,param_01,param_02,param_03)
{
	func_592F(::scripts\anim\shared::func_592B,param_00,param_01,param_02,param_03);
}

//Function Number: 75
func_592E(param_00,param_01,param_02,param_03)
{
	func_592F(::func_5936,param_00,param_01,param_02,param_03);
}

//Function Number: 76
func_592F(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 77
func_593A(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_5932(param_01);
	func_5935(::func_5934,param_00,param_02,param_03,var_04);
}

//Function Number: 78
func_5931(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_5932(param_00);
	func_5935(::func_592D,param_01,param_02,param_03,var_04);
}

//Function Number: 79
func_5933(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_5932(param_00);
	func_5935(::func_592E,param_01,param_02,param_03,var_04);
}

//Function Number: 80
func_5935(param_00,param_01,param_02,param_03,param_04)
{
	param_04 endon("stop_notetracks");
	[[ param_00 ]](param_01,undefined,param_02,param_03);
}

//Function Number: 81
func_5932(param_00)
{
	wait(param_00);
	self notify("stop_notetracks");
}

//Function Number: 82
func_D47E(param_00,param_01)
{
	if(!isai(self))
	{
		self playsurfacesound("default_step_run","dirt");
		return;
	}

	var_02 = undefined;
	if(!isdefined(self.var_168))
	{
		if(!isdefined(self.var_A995))
		{
			self playsurfacesound("default_step_run","dirt");
			return;
		}

		var_02 = self.var_A995;
	}
	else
	{
		var_02 = self.var_168;
		self.var_A995 = self.var_168;
	}

	var_03 = "J_Ball_RI";
	if(param_00)
	{
		var_03 = "J_Ball_LE";
	}

	var_04 = func_7B24();
	if(self.var_12BA4 == "soldier" || self.var_12BA4 == "civilian")
	{
		var_05 = "";
	}
	else
	{
		var_05 = tolower(self.var_12BA4 + "_");
	}

	if(self.var_12BA4 == "c6i" || self.var_12BA4 == "c6" || self.var_12BA4 == "c8" || self.var_12BA4 == "c12")
	{
		var_06 = var_05 + "step_" + var_04;
	}
	else
	{
		var_06 = var_06 + "default_step_" + var_05;
	}

	if(soundexists(var_06))
	{
		if(self.var_12BA4 == "c8")
		{
			if(!isdefined(self.var_6BC7))
			{
				self.var_6BC7 = spawn("script_origin",self.origin);
				self.var_6BC7 linkto(self);
			}

			self.var_6BC7 playsurfacesound(var_06,var_02);
		}
		else
		{
			thread scripts\sp\_utility::func_CE48(var_06,var_02,var_03);
		}
	}

	if(isdefined(self.var_164D[self.var_238F].var_4BC0))
	{
		if(issubstr(self.var_164D[self.var_238F].var_4BC0,"wall_run"))
		{
			self playsound("wall_run_tech_lyr_npc");
		}

		if(self.var_12BA4 == "c8" && self.var_164D[self.var_238F].var_4BC0 == "melee_charge")
		{
			thread scripts\sp\_utility::play_sound_on_tag("c8_step_charge_lyr",var_03);
		}
	}

	if(self.var_12BA4 == "c12")
	{
		var_07 = "c12_footstep_small";
		var_08 = 450;
		var_09 = 0.3;
		if(var_04 == "run")
		{
			var_07 = "c12_footstep_large";
			var_09 = 0.5;
			var_08 = 900;
		}

		self playrumbleonentity(var_07);
		function_01A2(self.origin,var_09,var_09,var_09,0.3,0,-1,var_08,5,0.2,2);
		var_0A = self gettagorigin(var_03);
		var_0B = self.angles;
		var_0C = anglestoup(var_0B);
		var_0C = var_0C * 0.35;
		function_016C(var_0A,50,25,var_0C);
		var_0D = 100;
		if(!level.player isjumping() && distancesquared(level.player.origin,var_0A) <= squared(var_0D))
		{
			level.player dodamage(level.player.maxhealth * 0.5,var_0A,self);
			level.player method_83F6(1,var_0A,0);
			var_0E = vectornormalize(level.player.origin - var_0A);
			level.player setvelocity(150 * var_0E);
		}
	}

	if(param_01)
	{
		if(![[ level.var_C6BC ]](var_03,var_02))
		{
			func_D480(var_03,var_02);
			return;
		}

		return;
	}

	if(![[ level.var_C6BE ]](var_03,var_02))
	{
		func_D47F(var_03,var_02);
	}
}

//Function Number: 83
func_D492(param_00,param_01)
{
	if(!isai(self))
	{
		self playsurfacesound("c6_handstep","default");
		return;
	}

	if(param_00)
	{
		var_02 = "J_MID_LE_1";
		if(lib_0A0B::func_7C35("left_arm") == "dismember")
		{
			return;
		}
	}
	else
	{
		var_02 = "J_MID_RI_1";
		if(lib_0A0B::func_7C35("right_arm") == "dismember")
		{
			return;
		}
	}

	var_03 = undefined;
	if(!isdefined(self.var_168))
	{
		if(!isdefined(self.var_A995))
		{
			self playsurfacesound("c6_handstep","default");
			return;
		}

		var_03 = self.var_A995;
	}
	else
	{
		var_03 = self.var_168;
		self.var_A995 = self.var_168;
	}

	var_04 = func_7B24();
	var_05 = "c6_handstep";
	if(soundexists(var_05))
	{
		self playsurfacesound(var_05,var_03);
	}

	if(![[ level.var_C6BE ]](var_02,var_03))
	{
		func_D47F(var_02,var_03);
	}
}

//Function Number: 84
func_D47F(param_00,param_01)
{
	if(!isdefined(level.var_C6BD[param_01]))
	{
		return 0;
	}

	var_02 = self gettagorigin(param_00);
	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	if(!isdefined(level._effect["step_" + param_01][self.var_12BA4]))
	{
		level._effect["step_" + param_01][self.var_12BA4] = level._effect["step_" + param_01]["soldier"];
	}

	playfx(level._effect["step_" + param_01][self.var_12BA4],var_02,var_04,var_05);
	return 1;
}

//Function Number: 85
func_D480(param_00,param_01)
{
	if(!isdefined(level.var_C6BF[param_01]))
	{
		return 0;
	}

	var_02 = self gettagorigin(param_00);
	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	if(!isdefined(level._effect["step_small_" + param_01][self.var_12BA4]))
	{
		level._effect["step_small_" + param_01][self.var_12BA4] = level._effect["step_small_" + param_01]["soldier"];
	}

	playfx(level._effect["step_small_" + param_01][self.var_12BA4],var_02,var_04,var_05);
	return 1;
}

//Function Number: 86
func_6D3C()
{
	if(self.var_1491.var_13CBA["right"] == "none")
	{
		return;
	}

	if(isdefined(self.var_596B))
	{
		func_FEC8();
		return;
	}

	if(scripts\sp\_utility::func_8C32(self.model,"tag_weapon"))
	{
		var_00 = self gettagorigin("tag_weapon");
	}
	else
	{
		var_00 = self gettagorigin("tag_weapon_right");
	}

	var_01 = anglestoforward(self method_8141());
	var_02 = var_00 + var_01 * 1000;
	self method_837B(1,var_02);
	scripts\anim\combat_utility::func_4FBE();
}

//Function Number: 87
func_C0F7(param_00,param_01)
{
	if(!isalive(self) && self method_8198())
	{
		if(isdefined(self.var_3C55))
		{
			return;
		}

		self.var_3C55 = 1;
		var_02["axis"] = "team3";
		var_02["team3"] = "axis";
		self.team = var_02[self.team];
	}

	if(!issentient(self))
	{
		self notify("fire");
		return;
	}

	if(self.var_1491.var_13CBA["right"] == "none")
	{
		return;
	}

	var_03 = self method_8142();
	var_04 = anglestoforward(self method_8141());
	var_05 = 10;
	if(isdefined(self.var_9F15))
	{
		var_05 = 20;
	}

	var_06 = 0;
	if(isalive(self.var_10C) && issentient(self.var_10C) && self method_8061())
	{
		var_07 = vectornormalize(self.var_10C geteye() - var_03);
		if(vectordot(var_04,var_07) > cos(var_05))
		{
			var_06 = 1;
		}
	}

	if(var_06)
	{
		scripts\anim\utility_common::func_FE9A();
	}
	else
	{
		var_04 = var_04 + (randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1);
		var_08 = var_03 + var_04 * 1000;
		self [[ level.var_FED3 ]](var_08);
	}

	scripts\anim\combat_utility::func_4FBE();
}

//Function Number: 88
func_CCAB(param_00,param_01)
{
	var_02 = [];
	if(param_00 == "boost_on_forward" || param_00 == "boost_on_forward_short")
	{
		var_02[var_02.size] = "tag_fx_back";
	}
	else if(param_00 == "boost_on_back" || param_00 == "boost_on_back_short")
	{
		var_02[var_02.size] = "tag_fx_left";
		var_02[var_02.size] = "tag_fx_right";
	}
	else if(param_00 == "boost_on_up" || param_00 == "boost_on_up_short")
	{
		var_02[var_02.size] = "tag_fx_bottom";
	}
	else if(param_00 == "boost_on_down" || param_00 == "boost_on_down_short")
	{
		var_02[var_02.size] = "tag_fx_top";
	}
	else if(param_00 == "boost_on_left" || param_00 == "boost_on_left_short")
	{
		var_02[var_02.size] = "tag_fx_right";
	}
	else if(param_00 == "boost_on_right" || param_00 == "boost_on_right_short")
	{
		var_02[var_02.size] = "tag_fx_left";
	}

	var_03 = undefined;
	if(param_01 == "large")
	{
		var_03 = scripts\common\utility::func_116D7(isdefined(level.var_E977),level.var_13EE8,::func_CD6B);
	}
	else if(param_01 == "small")
	{
		var_03 = scripts\common\utility::func_116D7(isdefined(level.var_E977),level.var_13EE9,::func_CE13);
	}

	foreach(var_05 in var_02)
	{
		self [[ var_03 ]](var_05);
	}
}

//Function Number: 89
func_CD6B(param_00)
{
	return func_CE37("jetpack_thruster_large","jetpack_thruster_large_allies",param_00);
}

//Function Number: 90
func_CE13(param_00)
{
	return func_CE37("jetpack_thruster_small","jetpack_thruster_small_allies",param_00);
}

//Function Number: 91
func_CE37(param_00,param_01,param_02)
{
	self endon("death");
	if(self.team == "neutral")
	{
		return undefined;
	}

	var_03 = self.team;
	if(var_03 == "dead")
	{
		var_03 = self.var_C733;
	}

	var_04 = undefined;
	if(var_03 == "axis")
	{
		var_04 = scripts\common\utility::getfx(param_00);
	}
	else if(var_03 == "allies")
	{
		var_04 = scripts\common\utility::getfx(param_01);
	}

	var_05 = scripts\common\utility::func_116D7(self.team == "axis","double_jump_boost_enemy","double_jump_boost_npc");
	childthread scripts\sp\_utility::func_CE2F(var_05);
	playfxontag(var_04,self,param_02);
	return [var_04,param_02];
}