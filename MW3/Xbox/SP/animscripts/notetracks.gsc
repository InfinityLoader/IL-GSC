/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\notetracks.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 58
 * Decompile Time: 934 ms
 * Timestamp: 10/27/2023 2:30:35 AM
*******************************************************************/

//Function Number: 1
handledogsoundnotetracks(param_00)
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
		thread maps\_utility::func_1F5B(var_02,"tag_eye");
	}
	else
	{
		thread common_scripts\utility::play_sound_in_space(var_02,self geteye());
	}

	return 1;
}

//Function Number: 2
growling()
{
	return isdefined(self.script_growl);
}

//Function Number: 3
registernotetracks()
{
	level.notetracks["anim_pose = \"stand\"] = ::func_1F6B;
	level.notetracks["anim_pose = \"crouch\"] = ::notetrackposecrouch;
	level.notetracks["anim_pose = \"prone\"] = ::notetrackposeprone;
	level.notetracks["anim_pose = \"crawl\"] = ::func_1F6E;
	level.notetracks["anim_pose = \"back\"] = ::notetrackposeback;
	level.notetracks["anim_movement = \"stop\"] = ::notetrackmovementstop;
	level.notetracks["anim_movement = \"walk\"] = ::func_1F65;
	level.notetracks["anim_movement = \"run\"] = ::notetrackmovementrun;
	level.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
	level.notetracks["anim_aiming = 0"] = ::func_1F69;
	level.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
	level.notetracks["anim_alertness = alert"] = ::func_1F69;
	level.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
	level.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"left\"] = ::notetrackgunhand;
	level.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"right\"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"none\"] = ::notetrackgunhand;
	level.notetracks["gun drop"] = ::func_1F70;
	level.notetracks["dropgun"] = ::func_1F70;
	level.notetracks["gun_2_chest"] = ::notetrackguntochest;
	level.notetracks["gun_2_back"] = ::notetrackguntoback;
	level.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
	level.notetracks["pistol_putaway"] = ::func_1F75;
	level.notetracks["drop clip"] = ::notetrackdropclip;
	level.notetracks["refill clip"] = ::notetrackrefillclip;
	level.notetracks["reload done"] = ::notetrackrefillclip;
	level.notetracks["load_shell"] = ::notetrackloadshell;
	level.notetracks["pistol_rechamber"] = ::func_1F79;
	level.notetracks["gravity on"] = ::notetrackgravity;
	level.notetracks["gravity off"] = ::notetrackgravity;
	level.notetracks["footstep_right_large"] = ::func_1F7B;
	level.notetracks["footstep_right_small"] = ::func_1F7B;
	level.notetracks["footstep_left_large"] = ::func_1F7B;
	level.notetracks["footstep_left_small"] = ::func_1F7B;
	level.notetracks["footscrape"] = ::notetrackfootscrape;
	level.notetracks["land"] = ::func_1F81;
	level.notetracks["bodyfall large"] = ::notetrackbodyfall;
	level.notetracks["bodyfall small"] = ::notetrackbodyfall;
	level.notetracks["code_move"] = ::notetrackcodemove;
	level.notetracks["face_enemy"] = ::func_1F83;
	level.notetracks["laser_on"] = ::func_1F5F;
	level.notetracks["laser_off"] = ::func_1F5F;
	level.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
	level.notetracks["fire"] = ::notetrackfire;
	level.notetracks["fire_spray"] = ::func_1F8E;
	level.notetracks["bloodpool"] = ::animscripts/death::play_blood_pool;
	if(isdefined(level._notetrackfx))
	{
		var_00 = getarraykeys(level._notetrackfx);
		foreach(var_02 in var_00)
		{
			level.notetracks[var_02] = ::customnotetrackfx;
		}
	}
}

//Function Number: 4
notetrackfire(param_00,param_01)
{
	if(isdefined(level.fire_notetrack_functions[self.script]))
	{
		thread [[ level.fire_notetrack_functions[self.script] ]]();
		return;
	}

	thread [[ ::shootnotetrack ]]();
}

//Function Number: 5
func_1F5F(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self.a.laseron = 1;
	}
	else
	{
		self.a.laseron = 0;
	}

	animscripts/shared::updatelaserstatus();
}

//Function Number: 6
notetrackstopanim(param_00,param_01)
{
}

//Function Number: 7
unlinknextframe()
{
	wait 0.1;
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 8
notetrackstartragdoll(param_00,param_01)
{
	if(isdefined(self.noragdoll))
	{
		return;
	}

	if(isdefined(self.ragdolltime))
	{
		return;
	}

	if(!isdefined(self.var_1F63))
	{
		thread unlinknextframe();
	}

	self startragdoll();
}

//Function Number: 9
notetrackmovementstop(param_00,param_01)
{
	self.a.movement = "stop";
}

//Function Number: 10
func_1F65(param_00,param_01)
{
	self.a.movement = "walk";
}

//Function Number: 11
notetrackmovementrun(param_00,param_01)
{
	self.a.movement = "run";
}

//Function Number: 12
notetrackalertnessaiming(param_00,param_01)
{
}

//Function Number: 13
notetrackalertnesscasual(param_00,param_01)
{
}

//Function Number: 14
func_1F69(param_00,param_01)
{
}

//Function Number: 15
stoponback()
{
	animscripts/utility::exitpronewrapper(1);
	self.a.onback = undefined;
}

//Function Number: 16
setpose(param_00)
{
	self.a.var_911 = param_00;
	if(isdefined(self.a.onback))
	{
		stoponback();
	}

	self notify("entered_pose" + param_00);
}

//Function Number: 17
func_1F6B(param_00,param_01)
{
	if(self.a.var_911 == "prone")
	{
		self orientmode("face default");
		animscripts/utility::exitpronewrapper(1);
	}

	setpose("stand");
}

//Function Number: 18
notetrackposecrouch(param_00,param_01)
{
	if(self.a.var_911 == "prone")
	{
		self orientmode("face default");
		animscripts/utility::exitpronewrapper(1);
	}

	setpose("crouch");
}

//Function Number: 19
notetrackposeprone(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	setpose("prone");
	if(isdefined(self.a.goingtoproneaim))
	{
		self.a.var_ACB = 1;
		return;
	}

	self.a.var_ACB = undefined;
}

//Function Number: 20
func_1F6E(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
	setpose("prone");
	self.a.var_ACB = undefined;
}

//Function Number: 21
notetrackposeback(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	setpose("crouch");
	self.a.onback = 1;
	self.a.movement = "stop";
	self setproneanimnodes(-90,90,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts/utility::enterpronewrapper(1);
}

//Function Number: 22
notetrackgunhand(param_00,param_01)
{
	if(issubstr(param_00,"left"))
	{
		animscripts/shared::placeweaponon(self.weapon,"left");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"right"))
	{
		animscripts/shared::placeweaponon(self.weapon,"right");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"none"))
	{
		animscripts/shared::placeweaponon(self.weapon,"none");
		return;
	}
}

//Function Number: 23
func_1F70(param_00,param_01)
{
	animscripts/shared::dropaiweapon();
	self.lastweapon = self.weapon;
}

//Function Number: 24
notetrackguntochest(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"chest");
}

//Function Number: 25
notetrackguntoback(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"back");
	self.weapon = animscripts/utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 26
notetrackpistolpickup(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.sidearm,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 27
func_1F75(param_00,param_01)
{
	animscripts/shared::placeweaponon(self.weapon,"none");
	self.weapon = animscripts/utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 28
notetrackdropclip(param_00,param_01)
{
	thread animscripts/shared::handledropclip(param_01);
}

//Function Number: 29
notetrackrefillclip(param_00,param_01)
{
	if(weaponclass(self.weapon) == "rocketlauncher")
	{
		animscripts/combat_utility::showrocket();
	}

	animscripts/weaponlist::refillclip();
	self.a.needstorechamber = 0;
}

//Function Number: 30
notetrackloadshell(param_00,param_01)
{
	self playsound("weap_reload_shotgun_loop_npc");
}

//Function Number: 31
func_1F79(param_00,param_01)
{
	self playsound("weap_reload_pistol_chamber_npc");
}

//Function Number: 32
notetrackgravity(param_00,param_01)
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
func_1F7B(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	func_1F8B(var_02,var_03);
	var_04 = get_notetrack_movement();
	self playsound("gear_rattle_" + var_04);
}

//Function Number: 34
get_notetrack_movement()
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

		if(isdefined(self.a.var_911))
		{
			if(self.a.var_911 == "prone")
			{
				var_00 = "prone";
			}
		}
	}

	return var_00;
}

//Function Number: 35
customnotetrackfx(param_00,param_01)
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
		return;
	}

	if(isai(self))
	{
		playfxontag(var_03.fx,self,var_03.tag);
	}

	if(!isdefined(var_03.sound_prefix) && !isdefined(var_03.sound_suffix))
	{
		return;
	}

	var_04 = "" + var_03.sound_prefix + var_02 + var_03.sound_suffix;
	self playsound(var_04);
}

//Function Number: 36
notetrackfootscrape(param_00,param_01)
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

//Function Number: 37
func_1F81(param_00,param_01)
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
}

//Function Number: 38
notetrackcodemove(param_00,param_01)
{
	return "code_move";
}

//Function Number: 39
func_1F83(param_00,param_01)
{
	if(self.script != "reactions")
	{
		self orientmode("face enemy");
		return;
	}

	if(isdefined(self.enemy) && distancesquared(self.enemy.origin,self.reactiontargetpos) < 4096)
	{
		self orientmode("face enemy");
		return;
	}

	self orientmode("face point",self.reactiontargetpos);
}

//Function Number: 40
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

//Function Number: 41
func_1F4C(param_00,param_01,param_02)
{
	if(isai(self) && self.type == "dog")
	{
		if(handledogsoundnotetracks(param_00))
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
			if(animscripts/utility::weapon_pump_action_shotgun())
			{
				self playsound("weap_reload_shotgun_pump_npc");
			}
	
			self.a.needstorechamber = 0;
			break;

		case "no death":
			self.a.nodeath = 1;
			break;

		case "no pain":
			self.allowpain = 0;
			break;

		case "allow pain":
			self.allowpain = 1;
			break;

		case "anim_melee = \"right\":
		case "anim_melee = right":
			self.a.meleestate = "right";
			break;

		case "anim_melee = \"left\":
		case "anim_melee = left":
			self.a.meleestate = "left";
			break;

		case "swap taghelmet to tagleft":
			if(isdefined(self.var_ABA))
			{
				if(isdefined(self.var_1F85))
				{
					self detach(self.var_1F85,"TAG_HELMETSIDE");
					self.var_1F85 = undefined;
				}
	
				self detach(self.var_ABA,"");
				self attach(self.var_ABA,"TAG_WEAPON_LEFT");
				self.var_ABA = undefined;
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
donotetracksintercept(param_00,param_01,param_02)
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

		var_05 = func_1F4C(var_03,param_00);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 43
donotetrackspostcallback(param_00,param_01)
{
	for(;;)
	{
		self waittill(param_00,var_02);
		if(!isdefined(var_02))
		{
			var_02 = "undefined";
		}

		var_03 = func_1F4C(var_02,param_00);
		[[ param_01 ]](var_02);
		if(isdefined(var_03))
		{
			return var_03;
		}
	}
}

//Function Number: 44
donotetracksfortimeout(param_00,param_01,param_02,param_03)
{
	animscripts/shared::donotetracks(param_00,param_02,param_03);
}

//Function Number: 45
donotetracksforever(param_00,param_01,param_02,param_03)
{
	donotetracksforeverproc(::animscripts/shared::donotetracks,param_00,param_01,param_02,param_03);
}

//Function Number: 46
func_1F87(param_00,param_01,param_02,param_03)
{
	donotetracksforeverproc(::donotetracksintercept,param_00,param_01,param_02,param_03);
}

//Function Number: 47
donotetracksforeverproc(param_00,param_01,param_02,param_03,param_04)
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
func_0C57(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_01);
	func_1F89(::donotetracksfortimeout,param_00,param_02,param_03,var_04);
}

//Function Number: 49
donotetracksfortime(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_00);
	func_1F89(::donotetracksforever,param_01,param_02,param_03,var_04);
}

//Function Number: 50
donotetracksfortimeintercept(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_00);
	func_1F89(::func_1F87,param_01,param_02,param_03,var_04);
}

//Function Number: 51
func_1F89(param_00,param_01,param_02,param_03,param_04)
{
	param_04 endon("stop_notetracks");
	[[ param_00 ]](param_01,undefined,param_02,param_03);
}

//Function Number: 52
donotetracksfortimeendnotify(param_00)
{
	wait param_00;
	self notify("stop_notetracks");
}

//Function Number: 53
func_1F8B(param_00,param_01)
{
	if(!isai(self))
	{
		self playsound("step_run_dirt");
		return;
	}

	var_02 = undefined;
	if(!isdefined(self.groundtype))
	{
		if(!isdefined(self.lastgroundtype))
		{
			self playsound("step_run_dirt");
			return;
		}

		var_02 = self.lastgroundtype;
	}
	else
	{
		var_02 = self.groundtype;
		self.lastgroundtype = self.groundtype;
	}

	var_03 = "J_Ball_RI";
	if(param_00)
	{
		var_03 = "J_Ball_LE";
	}

	var_04 = get_notetrack_movement();
	self playsound("step_" + var_04 + "_" + var_02);
	if(param_01)
	{
		if(![[ level.optionalstepeffectfunction ]](var_03,var_02))
		{
			playfootstepeffectsmall(var_03,var_02);
			return;
		}

		return;
	}

	if(![[ level.optionalstepeffectsmallfunction ]](var_03,var_02))
	{
		playfootstepeffect(var_03,var_02);
	}
}

//Function Number: 54
playfootstepeffect(param_00,param_01)
{
	var_02 = 0;
	while(var_02 < level.var_1C53.size)
	{
		if(param_01 != level.var_1C53[var_02])
		{
			continue;
		}

		var_03 = self gettagorigin(param_00);
		var_04 = self.angles;
		var_05 = anglestoforward(var_04);
		var_06 = var_05 * -1;
		var_07 = anglestoup(var_04);
		playfx(level._effect["step_" + level.var_1C53[var_02]],var_03,var_07,var_06);
		return 1;
		var_07++;
	}

	return 0;
}

//Function Number: 55
playfootstepeffectsmall(param_00,param_01)
{
	var_02 = 0;
	while(var_02 < level.optionalstepeffectssmall.size)
	{
		if(param_01 != level.optionalstepeffectssmall[var_02])
		{
			continue;
		}

		var_03 = self gettagorigin(param_00);
		var_04 = self.angles;
		var_05 = anglestoforward(var_04);
		var_06 = var_05 * -1;
		var_07 = anglestoup(var_04);
		playfx(level._effect["step_small_" + level.optionalstepeffectssmall[var_02]],var_03,var_07,var_06);
		return 1;
		var_07++;
	}

	return 0;
}

//Function Number: 56
shootnotetrack()
{
	waittillframeend;
	if(isdefined(self) && gettime() > self.a.lastshoottime)
	{
		animscripts/utility::shootenemywrapper();
		animscripts/combat_utility::decrementbulletsinclip();
		if(weaponclass(self.weapon) == "rocketlauncher")
		{
			self.a.rockets--;
		}
	}
}

//Function Number: 57
fire_straight()
{
	if(self.a.weaponpos["right"] == "none")
	{
		return;
	}

	if(isdefined(self.dontshootstraight))
	{
		shootnotetrack();
		return;
	}

	var_00 = self gettagorigin("tag_weapon");
	var_01 = anglestoforward(self getmuzzleangle());
	var_02 = var_00 + var_01 * 1000;
	self shoot(1,var_02);
	animscripts/combat_utility::decrementbulletsinclip();
}

//Function Number: 58
func_1F8E(param_00,param_01)
{
	if(!isalive(self) && self isbadguy())
	{
		if(isdefined(self.var_1F8F))
		{
			return;
		}

		self.var_1F8F = 1;
		var_02["axis"] = "team3";
		self.team = var_41[self.team];
	}

	if(!issentient(self))
	{
		self notify("fire",var_41["team3"],"axis");
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
		animscripts/utility::shootenemywrapper();
	}
	else
	{
		var_04 = var_04 + (randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1);
		var_08 = var_03 + var_04 * 1000;
		animscripts/utility::shootposwrapper(var_08);
	}

	animscripts/combat_utility::decrementbulletsinclip();
}