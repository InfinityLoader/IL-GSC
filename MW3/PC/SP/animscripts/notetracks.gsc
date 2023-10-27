/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\notetracks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 943 ms
 * Timestamp: 10/27/2023 2:18:32 AM
*******************************************************************/

//Function Number: 1
func_23D8(param_00)
{
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
		thread maps\_utility::play_sound_on_tag_endon_death(var_02,"tag_eye");
	}
	else
	{
		thread common_scripts\utility::play_sound_in_space(var_02,self geteye());
	}

	return 1;
}

//Function Number: 2
func_23DA()
{
	return isdefined(self.var_23DB);
}

//Function Number: 3
func_1E73()
{
	level.notetracks["anim_pose = \"stand\"] = ::func_23E9;
	level.notetracks["anim_pose = \"crouch\"] = ::func_23EA;
	level.notetracks["anim_pose = \"prone\"] = ::func_23EB;
	level.notetracks["anim_pose = \"crawl\"] = ::func_23EC;
	level.notetracks["anim_pose = \"back\"] = ::func_0D74;
	level.notetracks["anim_movement = \"stop\"] = ::func_23E2;
	level.notetracks["anim_movement = \"walk\"] = ::func_23E3;
	level.notetracks["anim_movement = \"run\"] = ::func_23E4;
	level.notetracks["anim_aiming = 1"] = ::func_23E5;
	level.notetracks["anim_aiming = 0"] = ::func_23E7;
	level.notetracks["anim_alertness = causal"] = ::func_23E6;
	level.notetracks["anim_alertness = alert"] = ::func_23E7;
	level.notetracks["anim_alertness = aiming"] = ::func_23E5;
	level.notetracks["gunhand = (gunhand)_left"] = ::func_23ED;
	level.notetracks["anim_gunhand = \"left\"] = ::func_23ED;
	level.notetracks["gunhand = (gunhand)_right"] = ::func_23ED;
	level.notetracks["anim_gunhand = \"right\"] = ::func_23ED;
	level.notetracks["anim_gunhand = \"none\"] = ::func_23ED;
	level.notetracks["gun drop"] = ::func_23EE;
	level.notetracks["dropgun"] = ::func_23EE;
	level.notetracks["gun_2_chest"] = ::func_23EF;
	level.notetracks["gun_2_back"] = ::func_23F0;
	level.notetracks["pistol_pickup"] = ::func_23F2;
	level.notetracks["pistol_putaway"] = ::func_23F3;
	level.notetracks["drop clip"] = ::func_23F4;
	level.notetracks["refill clip"] = ::func_23F5;
	level.notetracks["reload done"] = ::func_23F5;
	level.notetracks["load_shell"] = ::func_23F6;
	level.notetracks["pistol_rechamber"] = ::func_23F7;
	level.notetracks["gravity on"] = ::func_23F8;
	level.notetracks["gravity off"] = ::func_23F8;
	level.notetracks["footstep_right_large"] = ::func_23F9;
	level.notetracks["footstep_right_small"] = ::func_23F9;
	level.notetracks["footstep_left_large"] = ::func_23F9;
	level.notetracks["footstep_left_small"] = ::func_23F9;
	level.notetracks["footscrape"] = ::func_23FE;
	level.notetracks["land"] = ::func_23FF;
	level.notetracks["bodyfall large"] = ::func_2402;
	level.notetracks["bodyfall small"] = ::func_2402;
	level.notetracks["code_move"] = ::func_2400;
	level.notetracks["face_enemy"] = ::func_2401;
	level.notetracks["laser_on"] = ::func_23DD;
	level.notetracks["laser_off"] = ::func_23DD;
	level.notetracks["start_ragdoll"] = ::func_23E0;
	level.notetracks["fire"] = ::func_23DC;
	level.notetracks["fire_spray"] = ::func_240C;
	level.notetracks["bloodpool"] = ::animscripts/death::func_ECA;
	if(isdefined(level._notetrackfx))
	{
		var_00 = getarraykeys(level._notetrackfx);
		foreach(var_02 in var_00)
		{
			level.notetracks[var_02] = ::func_23FB;
		}
	}
}

//Function Number: 4
func_23DC(param_00,param_01)
{
	if(isdefined(level.fire_notetrack_functions[self.script]))
	{
		thread [[ level.fire_notetrack_functions[self.script] ]]();
		return;
	}

	thread [[ ::func_20D7 ]]();
}

//Function Number: 5
func_23DD(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self.a.var_CDF = 1;
	}
	else
	{
		self.a.var_CDF = 0;
	}

	animscripts/shared::func_CE0();
}

//Function Number: 6
func_23DE(param_00,param_01)
{
}

//Function Number: 7
func_23DF()
{
	wait 0.1;
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 8
func_23E0(param_00,param_01)
{
	if(isdefined(self.noragdoll))
	{
		return;
	}

	if(isdefined(self.var_EC7))
	{
		return;
	}

	if(!isdefined(self.var_23E1))
	{
		thread func_23DF();
	}

	self startragdoll();
}

//Function Number: 9
func_23E2(param_00,param_01)
{
	self.a.movement = "stop";
}

//Function Number: 10
func_23E3(param_00,param_01)
{
	self.a.movement = "walk";
}

//Function Number: 11
func_23E4(param_00,param_01)
{
	self.a.movement = "run";
}

//Function Number: 12
func_23E5(param_00,param_01)
{
}

//Function Number: 13
func_23E6(param_00,param_01)
{
}

//Function Number: 14
func_23E7(param_00,param_01)
{
}

//Function Number: 15
func_0D2A()
{
	animscripts/utility::func_F7D(1);
	self.a.var_D29 = undefined;
}

//Function Number: 16
func_23E8(param_00)
{
	self.a.pose = param_00;
	if(isdefined(self.a.var_D29))
	{
		func_0D2A();
	}

	self notify("entered_pose" + param_00);
}

//Function Number: 17
func_23E9(param_00,param_01)
{
	if(self.a.pose == "prone")
	{
		self orientmode("face default");
		animscripts/utility::func_F7D(1);
	}

	func_23E8("stand");
}

//Function Number: 18
func_23EA(param_00,param_01)
{
	if(self.a.pose == "prone")
	{
		self orientmode("face default");
		animscripts/utility::func_F7D(1);
	}

	func_23E8("crouch");
}

//Function Number: 19
func_23EB(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(1);
	func_23E8("prone");
	if(isdefined(self.a.var_10E0))
	{
		self.a.var_EE0 = 1;
		return;
	}

	self.a.var_EE0 = undefined;
}

//Function Number: 20
func_23EC(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(1);
	func_23E8("prone");
	self.a.var_EE0 = undefined;
}

//Function Number: 21
func_0D74(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	func_23E8("crouch");
	self.a.var_D29 = 1;
	self.a.movement = "stop";
	self setproneanimnodes(-90,90,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::func_10E1(1);
}

//Function Number: 22
func_23ED(param_00,param_01)
{
	if(issubstr(param_00,"left"))
	{
		animscripts/shared::func_C9B(self.weapon,"left");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"right"))
	{
		animscripts/shared::func_C9B(self.weapon,"right");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"none"))
	{
		animscripts/shared::func_C9B(self.weapon,"none");
		return;
	}
}

//Function Number: 23
func_23EE(param_00,param_01)
{
	animscripts/shared::func_23C8();
	self.lastweapon = self.weapon;
}

//Function Number: 24
func_23EF(param_00,param_01)
{
	animscripts/shared::func_C9B(self.weapon,"chest");
}

//Function Number: 25
func_23F0(param_00,param_01)
{
	animscripts/shared::func_C9B(self.weapon,"back");
	self.weapon = animscripts/utility::func_23F1();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 26
func_23F2(param_00,param_01)
{
	animscripts/shared::func_C9B(self.sidearm,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 27
func_23F3(param_00,param_01)
{
	animscripts/shared::func_C9B(self.weapon,"none");
	self.weapon = animscripts/utility::func_23F1();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 28
func_23F4(param_00,param_01)
{
	thread animscripts/shared::func_23D1(param_01);
}

//Function Number: 29
func_23F5(param_00,param_01)
{
	if(weaponclass(self.weapon) == "rocketlauncher")
	{
		animscripts/combat_utility::func_2385();
	}

	animscripts/weaponlist::func_CD0();
	self.a.var_114D = 0;
}

//Function Number: 30
func_23F6(param_00,param_01)
{
	self playsound("weap_reload_shotgun_loop_npc");
}

//Function Number: 31
func_23F7(param_00,param_01)
{
	self playsound("weap_reload_pistol_chamber_npc");
}

//Function Number: 32
func_23F8(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self animmode("gravity");
		return;
	}

	if(issubstr(param_00,"off"))
	{
		self animmode("nogravity");
	}
}

//Function Number: 33
func_23F9(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	func_2409(var_02,var_03);
	var_04 = func_23FA();
	self playsound("gear_rattle_" + var_04);
}

//Function Number: 34
func_23FA()
{
	var_00 = "run";
	if(isdefined(self.sprint))
	{
		var_00 = "sprint";
	}

	if(isdefined(self.a))
	{
		if(isdefined(self.a.movement))
		{
			if(self.a.movement == "walk")
			{
				var_00 = "walk";
			}
		}

		if(isdefined(self.a.pose))
		{
			if(self.a.pose == "prone")
			{
				var_00 = "prone";
			}
		}
	}

	return var_00;
}

//Function Number: 35
func_23FB(param_00,param_01)
{
	if(isdefined(self.var_752))
	{
		var_02 = self.var_752;
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
		return;
	}

	if(isai(self))
	{
		playfxontag(var_03.fx,self,var_03.tag);
	}

	if(!isdefined(var_03.var_23FC) && !isdefined(var_03.var_23FD))
	{
		return;
	}

	var_04 = "" + var_03.var_23FC + var_02 + var_03.var_23FD;
	self playsound(var_04);
}

//Function Number: 36
func_23FE(param_00,param_01)
{
	if(isdefined(self.var_752))
	{
		var_02 = self.var_752;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsound("step_scrape_" + var_02);
}

//Function Number: 37
func_23FF(param_00,param_01)
{
	if(isdefined(self.var_752))
	{
		var_02 = self.var_752;
	}
	else
	{
		var_02 = "dirt";
	}

	self playsound("land_" + var_02);
}

//Function Number: 38
func_2400(param_00,param_01)
{
	return "code_move";
}

//Function Number: 39
func_2401(param_00,param_01)
{
	if(self.script != "reactions")
	{
		self orientmode("face enemy");
		return;
	}

	if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.var_731) < 4096)
	{
		self orientmode("face enemy");
		return;
	}

	self orientmode("face point",self.var_731);
}

//Function Number: 40
func_2402(param_00,param_01)
{
	var_02 = "_small";
	if(issubstr(param_00,"large"))
	{
		var_02 = "_large";
	}

	if(isdefined(self.var_752))
	{
		var_03 = self.var_752;
	}
	else
	{
		var_03 = "dirt";
	}

	self playsound("bodyfall_" + var_03 + var_02);
}

//Function Number: 41
func_23CA(param_00,param_01,param_02)
{
	if(isai(self) && self.type == "dog")
	{
		if(func_23D8(param_00))
		{
			return;
		}
	}

	var_03 = level.notetracks[param_00];
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
			thread common_scripts\utility::play_sound_in_space("melee_swing_small",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "swish large":
			thread common_scripts\utility::play_sound_in_space("melee_swing_large",self gettagorigin("TAG_WEAPON_RIGHT"));
			break;

		case "rechamber":
			if(animscripts/utility::func_C97())
			{
				self playsound("weap_reload_shotgun_pump_npc");
			}
	
			self.a.var_114D = 0;
			break;

		case "no death":
			self.a.var_D55 = 1;
			break;

		case "no pain":
			self.allowpain = 0;
			break;

		case "allow pain":
			self.allowpain = 1;
			break;

		case "anim_melee = \"right\":
		case "anim_melee = right":
			self.a.var_110C = "right";
			break;

		case "anim_melee = \"left\":
		case "anim_melee = left":
			self.a.var_110C = "left";
			break;

		case "swap taghelmet to tagleft":
			if(isdefined(self.hatmodel))
			{
				if(isdefined(self.var_2403))
				{
					self detach(self.var_2403,"TAG_HELMETSIDE");
					self.var_2403 = undefined;
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

		default:
			if(isdefined(param_02))
			{
				return [[ param_02 ]](param_00);
			}
			break;
	}
}

//Function Number: 42
func_0D4C(param_00,param_01,param_02)
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

		var_05 = func_23CA(var_03,param_00);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 43
func_1156(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_00,var_02);
		if(!isdefined(var_02))
		{
			var_02 = "undefined";
		}

		var_03 = func_23CA(var_02,param_00);
		[[ param_01 ]](var_02);
		if(isdefined(var_03))
		{
			return var_03;
		}
	}
}

//Function Number: 44
func_2404(param_00,param_01,param_02,param_03)
{
	animscripts/shared::donotetracks(param_00,param_02,param_03);
}

//Function Number: 45
func_239E(param_00,param_01,param_02,param_03)
{
	func_2406(::animscripts/shared::donotetracks,param_00,param_01,param_02,param_03);
}

//Function Number: 46
func_2405(param_00,param_01,param_02,param_03)
{
	func_2406(::func_0D4C,param_00,param_01,param_02,param_03);
}

//Function Number: 47
func_2406(param_00,param_01,param_02,param_03,param_04)
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
				wait 0.05 - var_07;
			}
		}
	}
}

//Function Number: 48
func_106C(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_2408(param_01);
	func_2407(::func_2404,param_00,param_02,param_03,var_04);
}

//Function Number: 49
func_0D4F(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_2408(param_00);
	func_2407(::func_239E,param_01,param_02,param_03,var_04);
}

//Function Number: 50
func_1001(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread func_2408(param_00);
	func_2407(::func_2405,param_01,param_02,param_03,var_04);
}

//Function Number: 51
func_2407(param_00,param_01,param_02,param_03,param_04)
{
	param_04 endon("stop_notetracks");
	[[ param_00 ]](param_01,undefined,param_02,param_03);
}

//Function Number: 52
func_2408(param_00)
{
	wait param_00;
	self notify("stop_notetracks");
}

//Function Number: 53
func_2409(param_00,param_01)
{
	if(!isai(self))
	{
		self playsound("step_run_dirt");
		return;
	}

	var_02 = undefined;
	if(!isdefined(self.var_752))
	{
		if(!isdefined(self.var_240A))
		{
			self playsound("step_run_dirt");
			return;
		}

		var_02 = self.var_240A;
	}
	else
	{
		var_02 = self.var_752;
		self.var_240A = self.var_752;
	}

	var_03 = "J_Ball_RI";
	if(param_00)
	{
		var_03 = "J_Ball_LE";
	}

	var_04 = func_23FA();
	self playsound("step_" + var_04 + "_" + var_02);
	if(param_01)
	{
		if(![[ level.var_20CD ]](var_03,var_02))
		{
			func_20CE(var_03,var_02);
			return;
		}

		return;
	}

	if(![[ level.var_20CF ]](var_03,var_02))
	{
		func_20D0(var_03,var_02);
	}
}

//Function Number: 54
func_20D0(param_00,param_01)
{
	var_02 = 0;
	while(var_02 < level.var_20D1.size)
	{
		if(param_01 != level.var_20D1[var_02])
		{
			continue;
		}

		var_03 = self gettagorigin(param_00);
		var_04 = self.angles;
		var_05 = anglestoforward(var_04);
		var_06 = var_05 * -1;
		var_07 = anglestoup(var_04);
		playfx(level._effect["step_" + level.var_20D1[var_02]],var_03,var_07,var_06);
		return 1;
		var_07++;
	}

	return 0;
}

//Function Number: 55
func_20CE(param_00,param_01)
{
	var_02 = 0;
	while(var_02 < level.var_20D2.size)
	{
		if(param_01 != level.var_20D2[var_02])
		{
			continue;
		}

		var_03 = self gettagorigin(param_00);
		var_04 = self.angles;
		var_05 = anglestoforward(var_04);
		var_06 = var_05 * -1;
		var_07 = anglestoup(var_04);
		playfx(level._effect["step_small_" + level.var_20D2[var_02]],var_03,var_07,var_06);
		return 1;
		var_07++;
	}

	return 0;
}

//Function Number: 56
func_20D7()
{
	waittillframeend;
	if(isdefined(self) && gettime() > self.a.lastshoottime)
	{
		animscripts/utility::func_D5F();
		animscripts/combat_utility::func_2386();
		if(weaponclass(self.weapon) == "rocketlauncher")
		{
			self.a.rockets--;
		}
	}
}

//Function Number: 57
func_20D5()
{
	if(self.a.weaponpos["right"] == "none")
	{
		return;
	}

	if(isdefined(self.var_240B))
	{
		func_20D7();
		return;
	}

	var_00 = self gettagorigin("tag_weapon");
	var_01 = anglestoforward(self getmuzzleangle());
	var_02 = var_00 + var_01 * 1000;
	self shoot(1,var_02);
	animscripts/combat_utility::func_2386();
}

//Function Number: 58
func_240C(param_00,param_01)
{
	if(!isalive(self) && self isbadguy())
	{
		if(isdefined(self.var_240D))
		{
			return;
		}

		self.var_240D = 1;
		var_02["axis"] = "team3";
		self.team = var_7B[self.team];
	}

	if(!issentient(self))
	{
		self notify("fire",var_7B["team3"],"axis");
		return;
	}

	if(self.a.weaponpos["right"] == "none")
	{
		return;
	}

	var_03 = self getmuzzlepos();
	var_04 = anglestoforward(self getmuzzleangle());
	var_05 = 10;
	if(isdefined(self.isrambo))
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
		animscripts/utility::func_D5F();
	}
	else
	{
		var_04 = var_04 + (randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1);
		var_08 = var_03 + var_04 * 1000;
		animscripts/utility::func_2384(var_08);
	}

	animscripts/combat_utility::func_2386();
}