/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: notetracks.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 67
 * Decompile Time: 988 ms
 * Timestamp: 4/22/2024 2:00:42 AM
*******************************************************************/

//Function Number: 1
notetrack_playsound(param_00)
{
	if(isdefined(self) && soundexists(param_00))
	{
		self playsound(param_00);
	}
}

//Function Number: 2
handledogfootstepnotetracks(param_00)
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
				self.lastgroundtype = var_01;
			}
			else if(isdefined(self.lastgroundtype))
			{
				var_01 = self.lastgroundtype;
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
	
			var_02 = self.moveanimtype;
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
						if(!isdefined(self.drivenmovemode) || self.drivenmovemode == "walk")
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

//Function Number: 3
handledogsoundnotetracks(param_00)
{
	if(handledogfootstepnotetracks(param_00))
	{
		return 1;
	}

	if(param_00 == "sound_dogstep_run_default")
	{
		notetrack_playsound("dogstep_run_default");
		return 1;
	}

	var_01 = getsubstr(param_00,0,5);
	if(var_01 != "sound")
	{
		return 0;
	}

	var_02 = "anml" + getsubstr(param_00,5);
	if(soundexists(var_02))
	{
		if(isalive(self))
		{
			thread maps\_utility::play_sound_on_tag_endon_death(var_02,"tag_eye");
		}
		else
		{
			thread common_scripts\utility::play_sound_in_space(var_02,self geteye());
		}
	}

	return 1;
}

//Function Number: 4
growling()
{
	return isdefined(self.script_growl);
}

//Function Number: 5
registernotetracks()
{
	level.notetracks["anim_pose = \"stand\"] = ::notetrackposestand;
	level.notetracks["anim_pose = \"crouch\"] = ::notetrackposecrouch;
	level.notetracks["anim_pose = \"prone\"] = ::notetrackposeprone;
	level.notetracks["anim_pose = \"crawl\"] = ::notetrackposecrawl;
	level.notetracks["anim_pose = \"back\"] = ::notetrackposeback;
	level.notetracks["anim_movement = \"stop\"] = ::notetrackmovementstop;
	level.notetracks["anim_movement = \"walk\"] = ::notetrackmovementwalk;
	level.notetracks["anim_movement = \"run\"] = ::notetrackmovementrun;
	level.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
	level.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert;
	level.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
	level.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
	level.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
	level.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"left\"] = ::notetrackgunhand;
	level.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"right\"] = ::notetrackgunhand;
	level.notetracks["anim_gunhand = \"none\"] = ::notetrackgunhand;
	level.notetracks["gun drop"] = ::notetrackgundrop;
	level.notetracks["dropgun"] = ::notetrackgundrop;
	level.notetracks["gun_2_chest"] = ::notetrackguntochest;
	level.notetracks["gun_2_back"] = ::notetrackguntoback;
	level.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
	level.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
	level.notetracks["drop clip"] = ::notetrackdropclip;
	level.notetracks["refill clip"] = ::notetrackrefillclip;
	level.notetracks["reload done"] = ::notetrackrefillclip;
	level.notetracks["load_shell"] = ::notetrackloadshell;
	level.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber;
	level.notetracks["gravity on"] = ::notetrackgravity;
	level.notetracks["gravity off"] = ::notetrackgravity;
	level.notetracks["footstep_right_large"] = ::notetrackfootstep;
	level.notetracks["footstep_right_small"] = ::notetrackfootstep;
	level.notetracks["footstep_left_large"] = ::notetrackfootstep;
	level.notetracks["footstep_left_small"] = ::notetrackfootstep;
	level.notetracks["footscrape"] = ::notetrackfootscrape;
	level.notetracks["land"] = ::notetrackland;
	level.notetracks["bodyfall large"] = ::notetrackbodyfall;
	level.notetracks["bodyfall small"] = ::notetrackbodyfall;
	level.notetracks["pain_small"] = ::notetrackpain;
	level.notetracks["pain_large"] = ::notetrackpain;
	level.notetracks["meleeattack_eft"] = ::notetrackmeleeattackeft;
	level.notetracks["code_move"] = ::notetrackcodemove;
	level.notetracks["face_enemy"] = ::notetrackfaceenemy;
	level.notetracks["laser_on"] = ::notetracklaser;
	level.notetracks["laser_off"] = ::notetracklaser;
	level.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
	level.notetracks["fire"] = ::notetrackfire;
	level.notetracks["fire_spray"] = ::notetrackfirespray;
	level.notetracks["bloodpool"] = ::animscripts\death::play_blood_pool;
	level.notetracks["space_jet_top"] = ::notetrackspacejet;
	level.notetracks["space_jet_top_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_top_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_bottom"] = ::notetrackspacejet;
	level.notetracks["space_jet_bottom_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_bottom_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_left"] = ::notetrackspacejet;
	level.notetracks["space_jet_left_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_left_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_right"] = ::notetrackspacejet;
	level.notetracks["space_jet_right_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_right_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_front"] = ::notetrackspacejet;
	level.notetracks["space_jet_front_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_front_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_back"] = ::notetrackspacejet;
	level.notetracks["space_jet_back_1"] = ::notetrackspacejet;
	level.notetracks["space_jet_back_2"] = ::notetrackspacejet;
	level.notetracks["space_jet_back_3"] = ::notetrackspacejet;
	level.notetracks["space_jet_back_4"] = ::notetrackspacejet;
	level.notetracks["space_jet_random"] = ::notetrackspacejet;
	if(isdefined(level._notetrackfx))
	{
		var_00 = getarraykeys(level._notetrackfx);
		foreach(var_02 in var_00)
		{
			level.notetracks[var_02] = ::customnotetrackfx;
		}
	}
}

//Function Number: 6
notetrackfire(param_00,param_01)
{
	if(isdefined(level.fire_notetrack_functions[self.script]))
	{
		thread [[ level.fire_notetrack_functions[self.script] ]]();
		return;
	}

	thread [[ ::shootnotetrack ]]();
}

//Function Number: 7
notetracklaser(param_00,param_01)
{
	if(issubstr(param_00,"on"))
	{
		self.a.laseron = 1;
	}
	else
	{
		self.a.laseron = 0;
	}

	animscripts\shared::updatelaserstatus();
}

//Function Number: 8
notetrackstopanim(param_00,param_01)
{
}

//Function Number: 9
unlinknextframe()
{
	wait(0.1);
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 10
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

	if(!isdefined(self.dont_unlink_ragdoll))
	{
		thread unlinknextframe();
	}

	self startragdoll();
}

//Function Number: 11
notetrackmovementstop(param_00,param_01)
{
	self.a.movement = "stop";
}

//Function Number: 12
notetrackmovementwalk(param_00,param_01)
{
	self.a.movement = "walk";
}

//Function Number: 13
notetrackmovementrun(param_00,param_01)
{
	self.a.movement = "run";
}

//Function Number: 14
notetrackalertnessaiming(param_00,param_01)
{
}

//Function Number: 15
notetrackalertnesscasual(param_00,param_01)
{
}

//Function Number: 16
notetrackalertnessalert(param_00,param_01)
{
}

//Function Number: 17
stoponback()
{
	animscripts\utility::exitpronewrapper(1);
	self.a.onback = undefined;
}

//Function Number: 18
setpose(param_00)
{
	self.a.pose = param_00;
	if(isdefined(self.a.onback))
	{
		stoponback();
	}

	self notify("entered_pose" + param_00);
}

//Function Number: 19
notetrackposestand(param_00,param_01)
{
	if(self.a.pose == "prone")
	{
		self orientmode("face default");
		animscripts\utility::exitpronewrapper(1);
	}

	setpose("stand");
}

//Function Number: 20
notetrackposecrouch(param_00,param_01)
{
	if(self.a.pose == "prone")
	{
		self orientmode("face default");
		animscripts\utility::exitpronewrapper(1);
	}

	setpose("crouch");
}

//Function Number: 21
notetrackposeprone(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts\utility::enterpronewrapper(1);
	setpose("prone");
	if(isdefined(self.a.goingtoproneaim))
	{
		self.a.proneaiming = 1;
		return;
	}

	self.a.proneaiming = undefined;
}

//Function Number: 22
notetrackposecrawl(param_00,param_01)
{
	if(!issentient(self))
	{
		return;
	}

	self setproneanimnodes(-45,45,%prone_legs_down,%exposed_aiming,%prone_legs_up);
	animscripts\utility::enterpronewrapper(1);
	setpose("prone");
	self.a.proneaiming = undefined;
}

//Function Number: 23
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
	animscripts\utility::enterpronewrapper(1);
}

//Function Number: 24
notetrackgunhand(param_00,param_01)
{
	if(issubstr(param_00,"left"))
	{
		animscripts\shared::placeweaponon(self.weapon,"left");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"right"))
	{
		animscripts\shared::placeweaponon(self.weapon,"right");
		self notify("weapon_switch_done");
		return;
	}

	if(issubstr(param_00,"none"))
	{
		animscripts\shared::placeweaponon(self.weapon,"none");
		return;
	}
}

//Function Number: 25
notetrackgundrop(param_00,param_01)
{
	animscripts\shared::dropaiweapon();
	self.lastweapon = self.weapon;
}

//Function Number: 26
notetrackguntochest(param_00,param_01)
{
	animscripts\shared::placeweaponon(self.weapon,"chest");
}

//Function Number: 27
notetrackguntoback(param_00,param_01)
{
	animscripts\shared::placeweaponon(self.weapon,"back");
	self.weapon = animscripts\utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 28
notetrackpistolpickup(param_00,param_01)
{
	animscripts\shared::placeweaponon(self.sidearm,"right");
	self.bulletsinclip = weaponclipsize(self.weapon);
	self notify("weapon_switch_done");
}

//Function Number: 29
notetrackpistolputaway(param_00,param_01)
{
	animscripts\shared::placeweaponon(self.weapon,"none");
	self.weapon = animscripts\utility::getpreferredweapon();
	self.bulletsinclip = weaponclipsize(self.weapon);
}

//Function Number: 30
notetrackdropclip(param_00,param_01)
{
	thread animscripts\shared::handledropclip(param_01);
}

//Function Number: 31
notetrackrefillclip(param_00,param_01)
{
	animscripts\weaponlist::refillclip();
	self.a.needstorechamber = 0;
}

//Function Number: 32
notetrackloadshell(param_00,param_01)
{
	notetrack_playsound("weap_reload_shotgun_loop_npc");
}

//Function Number: 33
notetrackpistolrechamber(param_00,param_01)
{
	notetrack_playsound("weap_reload_pistol_chamber_npc");
}

//Function Number: 34
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

//Function Number: 35
notetrackfootstep(param_00,param_01)
{
	var_02 = issubstr(param_00,"left");
	var_03 = issubstr(param_00,"large");
	playfootstep(var_02,var_03);
}

//Function Number: 36
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

//Function Number: 37
notetrackspacejet(param_00,param_01)
{
	thread notetrackspacejet_proc(param_00,param_01);
}

//Function Number: 38
notetrackspacejet_proc(param_00,param_01)
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

	if(common_scripts\utility::fxexists("space_jet_small") && isdefined(var_02))
	{
		if(isdefined(var_02))
		{
			if(param_00 == "space_jet_random")
			{
				for(var_04 = 0;var_04 < 6;var_04++)
				{
					var_05 = randomint(8);
					var_06 = var_02[var_05];
					if(maps\_utility::hastag(self.model,var_06))
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

				return;
			}

			foreach(var_06 in var_03)
			{
				if(isdefined(var_06) && maps\_utility::hastag(self.model,var_06))
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

			return;
		}
	}
}

//Function Number: 39
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

	if(isai(self) && isdefined(var_03.fx))
	{
		playfxontag(var_03.fx,self,var_03.tag);
	}

	if(!isdefined(var_03.sound_prefix) && !isdefined(var_03.sound_suffix))
	{
		return;
	}

	var_04 = "" + var_03.sound_prefix + var_02 + var_03.sound_suffix;
	if(!soundexists(var_04))
	{
		var_04 = "" + var_03.sound_prefix + "default" + var_03.sound_suffix;
	}

	notetrack_playsound(var_04);
}

//Function Number: 40
notetrackfootscrape(param_00,param_01)
{
	if(isdefined(self.groundtype))
	{
		var_02 = self.groundtype;
	}
	else
	{
		var_02 = "default";
	}

	self playfoley("scrape",var_02);
}

//Function Number: 41
notetrackland(param_00,param_01)
{
	if(isdefined(self.groundtype))
	{
		var_02 = self.groundtype;
	}
	else
	{
		var_02 = "default";
	}

	self playfoley("land",var_02);
}

//Function Number: 42
notetrackcodemove(param_00,param_01)
{
	return "code_move";
}

//Function Number: 43
notetrackfaceenemy(param_00,param_01)
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
		var_03 = "default";
	}

	var_04 = "bodyfall_" + var_03 + var_02;
	if(!soundexists(var_04))
	{
		var_04 = "bodyfall_default" + var_02;
	}

	notetrack_playsound(var_04);
}

//Function Number: 45
notetrackpain(param_00,param_01)
{
	var_02 = "_small";
	if(issubstr(param_00,"large"))
	{
		var_02 = "";
	}

	animscripts\face::saygenericdialogue("pain" + var_02);
}

//Function Number: 46
notetrackmeleeattackeft(param_00,param_01)
{
	animscripts\face::saygenericdialogue("meleeattack");
}

//Function Number: 47
handlerocketlauncherammoondeath()
{
	self endon("detached");
	self waittill("death");
	if(isdefined(self.rocketlauncherammo))
	{
		self.rocketlauncherammo delete();
	}
}

//Function Number: 48
notetrackrocketlauncherammoattach()
{
	self.rocketlauncherammo = spawn("script_model",self.origin);
	if(issubstr(tolower(self.weapon),"panzerfaust"))
	{
		self.rocketlauncherammo setmodel("weapon_panzerfaust3_missle");
	}
	else
	{
		self.rocketlauncherammo setmodel("projectile_rpg7");
	}

	self.rocketlauncherammo linkto(self,"tag_inhand",(0,0,0),(0,0,0));
	thread handlerocketlauncherammoondeath();
}

//Function Number: 49
notetrackrocketlauncherammodelete()
{
	self notify("detached");
	if(isdefined(self.rocketlauncherammo))
	{
		self.rocketlauncherammo delete();
	}

	self.a.rocketvisible = 1;
	if(isai(self) && !isalive(self))
	{
		return;
	}

	if(maps\_utility::hastag(getweaponmodel(self.weapon),"tag_rocket"))
	{
		self showpart("tag_rocket");
	}
}

//Function Number: 50
handlenotetrack(param_00,param_01,param_02,param_03)
{
	if(isai(self) && self.type == "dog")
	{
		if(handledogsoundnotetracks(param_00))
		{
			return;
		}
	}

	var_04 = level.notetracks[param_00];
	if(isdefined(var_04))
	{
		return [[ var_04 ]](param_00,param_01);
	}

	if(!isdefined(param_03) || !param_03)
	{
		var_05 = getsubstr(param_00,0,3);
		if(var_05 == "ps_")
		{
			var_06 = getsubstr(param_00,3);
			notetrack_playsound(var_06);
		}
	}

	switch(param_00)
	{
		case "undefined":
		case "end":
		case "finish":
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

		case "torso_mvmnt":
			thread common_scripts\utility::play_sound_in_space("foly_mvmnt_cloth_npc",self.origin);
			break;

		case "rechamber":
			if(animscripts\utility::weapon_pump_action_shotgun())
			{
				notetrack_playsound("weap_reload_shotgun_pump_npc");
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
			if(animscripts\utility::usingrocketlauncher())
			{
				notetrackrocketlauncherammoattach();
			}
			break;

		case "detach clip left":
			if(animscripts\utility::usingrocketlauncher())
			{
				notetrackrocketlauncherammodelete();
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

//Function Number: 51
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

		var_05 = handlenotetrack(var_03,param_00);
		if(isdefined(var_05))
		{
			return var_05;
		}
	}
}

//Function Number: 52
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

//Function Number: 53
donotetracksfortimeout(param_00,param_01,param_02,param_03)
{
	animscripts\shared::donotetracks(param_00,param_02,param_03);
}

//Function Number: 54
donotetracksforever(param_00,param_01,param_02,param_03)
{
	donotetracksforeverproc(::animscripts\shared::donotetracks,param_00,param_01,param_02,param_03);
}

//Function Number: 55
donotetracksforeverintercept(param_00,param_01,param_02,param_03)
{
	donotetracksforeverproc(::donotetracksintercept,param_00,param_01,param_02,param_03);
}

//Function Number: 56
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
				wait(0.05 - var_07);
			}
		}
	}
}

//Function Number: 57
donotetrackswithtimeout(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_01);
	donotetracksfortimeproc(::donotetracksfortimeout,param_00,param_02,param_03,var_04);
}

//Function Number: 58
donotetracksfortime(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_00);
	donotetracksfortimeproc(::donotetracksforever,param_01,param_02,param_03,var_04);
}

//Function Number: 59
donotetracksfortimeintercept(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04 thread donotetracksfortimeendnotify(param_00);
	donotetracksfortimeproc(::donotetracksforeverintercept,param_01,param_02,param_03,var_04);
}

//Function Number: 60
donotetracksfortimeproc(param_00,param_01,param_02,param_03,param_04)
{
	param_04 endon("stop_notetracks");
	[[ param_00 ]](param_01,undefined,param_02,param_03);
}

//Function Number: 61
donotetracksfortimeendnotify(param_00)
{
	wait(param_00);
	self notify("stop_notetracks");
}

//Function Number: 62
playfootstep(param_00,param_01)
{
	if(isdefined(self.playfootstepoverride))
	{
		self thread [[ self.playfootstepoverride ]](param_00,param_01);
		return;
	}

	if(!isai(self))
	{
		notetrack_playsound("step_run_default");
		return;
	}

	var_02 = get_notetrack_movement();
	var_03 = undefined;
	if(!isdefined(self.groundtype))
	{
		if(!isdefined(self.lastgroundtype))
		{
			self playfoley(var_02,"default");
			return;
		}

		var_03 = self.lastgroundtype;
	}
	else
	{
		var_03 = self.groundtype;
		self.lastgroundtype = self.groundtype;
	}

	var_04 = "J_Ball_RI";
	if(param_00)
	{
		var_04 = "J_Ball_LE";
	}

	var_05 = self gettagorigin(var_04);
	var_06 = bullettrace(var_05 + (0,0,16),var_05 + (0,0,-4),0);
	if(var_06["fraction"] < 1 && var_06["fraction"] > 0 && var_06["surfacetype"] != "none")
	{
		var_03 = var_06["surfacetype"];
		var_05 = var_06["position"];
	}

	self playfoley(var_02,var_03);
	if(param_01)
	{
		if(![[ level.optionalstepeffectfunction ]](var_04,var_03,var_05))
		{
			playfootstepeffectsmall(var_04,var_03,var_05);
			return;
		}

		return;
	}

	if(![[ level.optionalstepeffectsmallfunction ]](var_04,var_03,var_05))
	{
		playfootstepeffect(var_04,var_03,var_05);
	}
}

//Function Number: 63
playfootstepeffect(param_00,param_01,param_02)
{
	if(!isdefined(level.optionalstepeffects[param_01]))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = self gettagorigin(param_00);
	}

	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = var_04 * -1;
	var_06 = anglestoup(var_03);
	playfx(level._effect["step_" + param_01],param_02,var_06,var_05);
	return 1;
}

//Function Number: 64
playfootstepeffectsmall(param_00,param_01,param_02)
{
	if(!isdefined(level.optionalstepeffectssmall[param_01]))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = self gettagorigin(param_00);
	}

	var_03 = self.angles;
	var_04 = anglestoforward(var_03);
	var_05 = var_04 * -1;
	var_06 = anglestoup(var_03);
	playfx(level._effect["step_small_" + param_01],param_02,var_06,var_05);
	return 1;
}

//Function Number: 65
shootnotetrack()
{
	waittillframeend;
	if(isdefined(self) && gettime() > self.a.lastshoottime)
	{
		animscripts\utility::shootenemywrapper();
		animscripts\combat_utility::decrementbulletsinclip();
		if(weaponclass(self.weapon) == "rocketlauncher")
		{
			self.a.rockets--;
		}
	}
}

//Function Number: 66
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
	animscripts\combat_utility::decrementbulletsinclip();
}

//Function Number: 67
notetrackfirespray(param_00,param_01)
{
	if(!isalive(self) && self isbadguy())
	{
		if(isdefined(self.changed_team))
		{
			return;
		}

		self.changed_team = 1;
		var_02["axis"] = "team3";
		var_02["team3"] = "axis";
		self.team = var_02[self.team];
	}

	if(!issentient(self))
	{
		self notify("fire");
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
		animscripts\utility::shootenemywrapper();
	}
	else
	{
		var_04 = var_04 + (randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1,randomfloat(2) - 1 * 0.1);
		var_08 = var_03 + var_04 * 1000;
		self [[ level.shootposwrapper_func ]](var_08);
	}

	animscripts\combat_utility::decrementbulletsinclip();
}