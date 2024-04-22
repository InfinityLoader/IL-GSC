/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_h_breach.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 62
 * Decompile Time: 881 ms
 * Timestamp: 4/22/2024 2:33:48 AM
*******************************************************************/

//Function Number: 1
precacheharmonicbreach()
{
	precacheharmonicbreachfx();
	precacheharmonicbreachitems();
	precacheharmonicbreachplayerrig();
	precacheharmonicbreachanimations();
}

//Function Number: 2
startharmonicbreach(param_00)
{
	initplayerforharmonicbreach();
	initallysquad(param_00);
	thread initdistortionfx();
	foreach(var_02 in level.allysquad)
	{
		var_02.ignoreall = 1;
	}

	thread breachtargetarraymonitor();
	thread breachtrigger();
	thread breachfailstate();
	thread breachdialogreminders();
	thread locktargets();
	thread hostagecorner();
	thread hostagebeatup();
	thread hostagepm();
	thread hostageexecution();
	thread h_breach_timer();
}

//Function Number: 3
precacheharmonicbreachitems()
{
	precacheitem("ak47");
	precacheitem("glock");
	precachemodel("viewhands_sentinel");
	precacheshader("nightvision_overlay_goggles");
	precacheshader("line_vertical");
	precacheshader("remote_chopper_hud_target_hit");
}

//Function Number: 4
precacheharmonicbreachfx()
{
	level._effect["distortion"] = loadfx("vfx/distortion/distortion_harmonic_breach");
	level._effect["pulse"] = loadfx("vfx/weaponimpact/charged_shot_impact_3");
	level._effect["execution_blood"] = loadfx("fx/maps/warlord/execution_blood_fx");
}

//Function Number: 5
precacheharmonicbreachplayerrig()
{
	level.scr_anim["player_hbreach_wrist"]["h_breach_on"] = %vm_turn_on_cloak;
	level.scr_animtree["player_hbreach_wrist"] = #animtree;
	level.scr_model["player_hbreach_wrist"] = "worldhands_atlas_pmc_smp_custom";
}

//Function Number: 6
precacheharmonicbreachanimations()
{
	level.scr_animtree["generic"] = #animtree;
	level.scr_anim["kva_guard_corner"]["hostage_corner"][0] = %prague_interrogate_1_soldier_idle;
	level.scr_anim["kva_hostage_corner"]["flythrough_hostage_corner_idle"][0] = %paris_ac130_hostage_cover_idle;
	level.scr_anim["kva_guard_corner"]["flythrough_hostage_corner_idle"][0] = %prague_interrogate_2_soldier_idle;
	level.scr_anim["kva_pm_guard"]["hostage_drag_idle"][0] = %prague_interrogate_2_soldier_idle;
	level.scr_anim["kva_pm_guard"]["execution_onknees_loop"][0] = %prague_interrogate_3_soldier_idle;
	level.scr_anim["kva_guard_beatup"]["flythrough_hostage_beatup_idle"][0] = %prague_interrogate_2_soldier_idle;
	level.scr_anim["kva_hostage_beatup"]["flythrough_hostage_beatup_idle"][0] = %paris_ac130_hostage_cover_idle;
	level.scr_anim["kva_hostage_execution_1"]["execution_onknees_loop"][0] = %africa_execution_prisoner_1_loop;
	level.scr_anim["kva_hostage_execution_2"]["execution_onknees_loop"][0] = %africa_execution_prisoner_2_loop;
	level.scr_anim["kva_hostage_execution_3"]["execution_onknees_loop"][0] = %africa_execution_prisoner_3_loop;
	level.scr_anim["kva_hostage_leader"]["civilian_smoking_A"][0] = %civilian_smoking_a;
	level.scr_anim["kva_hostage_leader"]["civilian_smoking_B"][0] = %civilian_smoking_b;
	level.scr_anim["kva_hostage_leader"]["civilian_hurried_walk"][0] = %civilian_walk_hurried_1;
	level.scr_anim["kva_hostage_leader"]["civilian_hurried_walk"][1] = %civilian_walk_hurried_2;
	level.scr_anim["kva_pm_guard"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_01;
	level.scr_anim["kva_hostage_leader"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_02;
	level.scr_anim["kva_guard_beatup"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_03;
	level.scr_anim["kva_guard_corner"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_kva_04;
	level.scr_anim["kva_hostage_execution_1"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_01;
	level.scr_anim["kva_hostage_execution_2"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_02;
	level.scr_anim["kva_hostage_execution_3"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_03;
	level.scr_anim["kva_hostage_minister"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_04;
	level.scr_anim["kva_hostage_beatup"]["h_breach_marking"][0] = %lag_gov_hostage_room_breach_idle_hostage_05;
	level.scr_anim["kva_hostage_execution_3"]["h_breach_execution"] = %lag_gov_hostage_room_breach_execute_hostage_03;
	level.scr_anim["kva_guard_corner"]["h_breach_execution"] = %lag_gov_hostage_room_breach_execute_kva_04;
	maps\_anim::addnotetrack_customfunction("kva_guard_corner","fire",::hostageexecutionseqvfx,"h_breach_execution");
	maps\_anim::addnotetrack_customfunction("kva_guard_corner","execute",::hostageexecutionseq,"h_breach_execution");
}

//Function Number: 7
drone_intro_conf_flythrough_actors(param_00)
{
	level.kva_guard_beatup = maps\_utility::spawn_targetname("kva_guard_beatup");
	level.kva_guard_beatup.animname = "kva_guard_beatup";
	level.kva_guard_corner = maps\_utility::spawn_targetname("kva_guard_corner");
	level.kva_guard_corner.animname = "kva_guard_corner";
	level.kva_pm_guard = maps\_utility::spawn_targetname("kva_pm_guard");
	level.kva_pm_guard.animname = "kva_pm_guard";
	level.kva_hostage_beatup = maps\_utility::spawn_targetname("kva_hostage_beatup");
	level.kva_hostage_beatup.animname = "kva_hostage_beatup";
	param_00 thread maps\_anim::anim_single_solo(level.kva_guard_beatup,"drone_opening");
	param_00 thread maps\_anim::anim_single_solo(level.kva_guard_corner,"drone_opening");
	param_00 thread maps\_anim::anim_single_solo(level.kva_pm_guard,"drone_opening");
	param_00 thread maps\_anim::anim_single_solo(level.kva_hostage_beatup,"drone_opening");
	level.intro_actors = [level.kva_guard_beatup,level.kva_guard_corner,level.kva_hostage_beatup,level.kva_pm_guard];
	level.kva_hostage_execution_array = maps\_utility::array_spawn_targetname("kva_hostage_execution");
	var_01 = 1;
	foreach(var_03 in level.kva_hostage_execution_array)
	{
		var_03.animname = "kva_hostage_execution_" + var_01;
		var_01++;
		level.intro_actors = common_scripts\utility::array_add(level.intro_actors,var_03);
		param_00 thread maps\_anim::anim_single_solo(var_03,"drone_opening");
	}

	level waittill("drone_opening_finished");
	foreach(var_06 in level.intro_actors)
	{
		var_06 delete();
	}
}

//Function Number: 8
swapwalldelayed()
{
	level thread maps\lagos_fx::harmonic_breach_turn_on();
	wait(1);
	level.xraywall_static = getentarray("xraywall_static","targetname");
	level.xraywall_on = getentarray("xraywall_on","targetname");
	common_scripts\utility::array_call(level.xraywall_static,::hide);
	common_scripts\utility::array_call(level.xraywall_static,::notsolid);
	common_scripts\utility::array_call(level.xraywall_on,::show);
}

//Function Number: 9
initdistortionfx()
{
	var_00 = common_scripts\utility::getstruct("XrayPulse","targetname");
	thread swapwalldelayed();
	var_01 = [];
	var_02 = common_scripts\utility::getstructarray("distortionfx","targetname");
	foreach(var_04 in var_02)
	{
		var_05 = var_04 common_scripts\utility::spawn_tag_origin();
		var_01 = common_scripts\utility::array_add(var_01,var_05);
	}

	foreach(var_05 in var_01)
	{
		var_08 = playfxontag(common_scripts\utility::getfx("distortion"),var_05,"tag_origin");
	}

	var_0A = newclienthudelem(level.player);
	var_0A.color = (1,0,1);
	var_0A.alpha = 1;
	var_0B = 200;
	var_0C = 25;
	if(level.currentgen)
	{
		var_0B = 175;
		var_0C = 3;
	}

	var_0A setharmonicbreach(2,var_0C,var_0B,2,1);
	maps\_player_exo::setharmonicbreachhudoutlinestyle();
	level waittill("BreachComplete");
	foreach(var_05 in var_01)
	{
		var_08 = stopfxontag(common_scripts\utility::getfx("distortion"),var_05,"tag_origin");
	}

	level waittill("kill_lcd_material");
	maps\_player_exo::setdefaulthudoutlinestyle();
	var_0A destroy();
}

//Function Number: 10
distortionfxtoggle()
{
}

//Function Number: 11
initplayerforharmonicbreach()
{
	setupplayerhud();
	level.kva = [];
	level.hostages = [];
	level.breachtargets = [];
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehaloblurradius",0.5);
	level.player.primaryweapon = "iw5_bal27_sp_variablereddot";
	thread playerhbreachwristequipment();
	level.player disableweapons();
	level.player allowjump(0);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player disableweaponswitch();
	thread hostagemarktargetstext();
	level.player notifyonplayercommand("MarkTarget","+attack");
	level.player notifyonplayercommand("MarkTarget","+attack_akimbo_accessible");
	level.player thread tracelocation();
	level.player thread restoreplayeractions();
}

//Function Number: 12
restoreplayeractions()
{
	level waittill("BreachComplete");
	level.player allowjump(1);
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
}

//Function Number: 13
initallysquad(param_00)
{
	level.allysquad = param_00;
}

//Function Number: 14
setupplayerhud()
{
	level.bpm = level.player maps\_hud_util::createclientfontstring("default",1.5);
	level.bpm maps\_hud_util::setpoint("CENTER",undefined,0,60);
	level.bpm settext("");
	thread biometrichud();
}

//Function Number: 15
biometrichud()
{
	level endon("BreachFailed");
	level endon("LockTargets");
	level endon("Breach_Actor_Dead");
	for(;;)
	{
		if(isdefined(level.currenttarget) && isai(level.currenttarget) && level.currenttarget.team != "allies")
		{
			var_00 = level.currenttarget.script_parameters;
			var_00 = int(var_00);
			var_00 = var_00 + randomintrange(-2,2);
			if(isdefined(var_00))
			{
				if(!isdefined(level.hudelem_lagos_heart_rate))
				{
					level.hudelem_lagos_heart_rate = get_heart_rate_hud(-505,300);
					level.hudelem_lagos_heart_rate.label = &"LAGOS_HEART_RATE";
					level.hudelem_lagos_heart_rate.fontscale = 1.5;
					level.hudelem_lagos_heart_rate.color = (1,1,1);
					level.hudelem_lagos_heart_rate.alignx = "left";
				}

				if(!isdefined(level.hudelem_lagos_heart_rate_bpmvar))
				{
					level.hudelem_lagos_heart_rate_bpmvar = get_heart_rate_hud(-395,300);
					level.hudelem_lagos_heart_rate_bpmvar.label = var_00;
					level.hudelem_lagos_heart_rate_bpmvar.fontscale = 1.5;
					level.hudelem_lagos_heart_rate_bpmvar.color = (1,1,1);
				}

				if(isdefined(level.hudelem_lagos_heart_rate_bpmvar))
				{
					level.hudelem_lagos_heart_rate_bpmvar.label = var_00;
				}

				if(!isdefined(level.hudelem_lagos_heart_rate_bpm))
				{
					level.hudelem_lagos_heart_rate_bpm = get_heart_rate_hud(-355,300);
					level.hudelem_lagos_heart_rate_bpm.label = &"LAGOS_BEATS_PER_MINUTE";
					level.hudelem_lagos_heart_rate_bpm.fontscale = 1.5;
					level.hudelem_lagos_heart_rate_bpm.color = (1,1,1);
					level.hudelem_lagos_heart_rate_bpm.alignx = "right";
				}
			}
		}
		else
		{
			delete_heartrate_hud();
		}

		wait(0.5);
	}
}

//Function Number: 16
get_heart_rate_hud(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = param_01;
	if(isdefined(param_02))
	{
		var_06 = newclienthudelem(param_02);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.alignx = "right";
	var_06.aligny = "middle";
	var_06.horzalign = "right";
	var_06.vertalign = "top";
	var_06.x = var_04;
	var_06.y = var_05;
	var_06.fontscale = 1.6;
	var_06.color = (0.8,1,0.8);
	var_06.font = "objective";
	var_06.glowcolor = (0.3,0.6,0.3);
	var_06.glowalpha = 1;
	var_06.foreground = 1;
	var_06.hidewheninmenu = 1;
	var_06.hidewhendead = 1;
	return var_06;
}

//Function Number: 17
delete_heartrate_hud()
{
	if(isdefined(level.hudelem_lagos_heart_rate))
	{
		level.hudelem_lagos_heart_rate destroy();
	}

	if(isdefined(level.hudelem_lagos_heart_rate_bpmvar))
	{
		level.hudelem_lagos_heart_rate_bpmvar destroy();
	}

	if(isdefined(level.hudelem_lagos_heart_rate_bpm))
	{
		level.hudelem_lagos_heart_rate_bpm destroy();
	}
}

//Function Number: 18
setupaitargetmarkingvariables()
{
	self.currenttarget = 0;
	self.targetmarked = 0;
	self.health = 1;
}

//Function Number: 19
disableaicombatreactions()
{
	maps\_utility::enable_dontevershoot();
	self.alertlevel = "noncombat";
	self.ignoreall = 1;
	self.favoriteenemy = undefined;
}

//Function Number: 20
enableragdolldeath()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	self waittill("death");
	self.a.nodeath = 1;
	animscripts\notetracks::notetrackstartragdoll("ragdoll");
}

//Function Number: 21
deathcleanup()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	self waittill("death");
	self hudoutlinedisable();
	if(maps\_utility::is_in_array(level.breachtargets,self))
	{
		level.breachtargets = common_scripts\utility::array_remove(level.breachtargets,self);
	}

	level notify("Breach_Actor_Dead");
}

//Function Number: 22
hostagepm()
{
	var_00 = getent("anim_org_drone_opening","targetname");
	level.kva_hostage_leader = maps\_utility::spawn_targetname("kva_hostage_leader_post_pcap");
	level.kva_hostage_leader setthreatdetection("disable");
	level.kva = common_scripts\utility::array_add(level.kva,level.kva_hostage_leader);
	level.kva_hostage_leader.animname = "kva_hostage_leader";
	level.kva_hostage_leader.maxhealth = 1;
	level.kva_hostage_leader.health = 1;
	level.kva_hostage_minister = maps\_utility::spawn_targetname("kva_hostage_minister");
	level.hostages = common_scripts\utility::array_add(level.hostages,level.kva_hostage_minister);
	level.kva_hostage_minister.animname = "kva_hostage_minister";
	level.kva_hostage_minister maps\_utility::add_damage_function(::hostagedeathdetection);
	level.kva_hostage_minister.name = "";
	var_01 = [level.kva_hostage_leader,level.kva_hostage_minister];
	common_scripts\utility::array_thread(var_01,::setupaitargetmarkingvariables);
	common_scripts\utility::array_thread(var_01,::deathcleanup);
	if(isalive(level.kva_hostage_leader) && isalive(level.kva_hostage_minister))
	{
		var_00 thread maps\_anim::anim_loop(var_01,"h_breach_marking");
		foreach(var_03 in var_01)
		{
			var_03 maps\_utility::set_allowdeath(1);
		}
	}
}

//Function Number: 23
hostagebeatup()
{
	var_00 = getent("anim_org_drone_opening","targetname");
	level.kva_guard_beatup = maps\_utility::spawn_targetname("kva_guard_beatup");
	level.kva_guard_beatup setthreatdetection("disable");
	level.kva = common_scripts\utility::array_add(level.kva,level.kva_guard_beatup);
	level.kva_guard_beatup.animname = "kva_guard_beatup";
	level.kva_guard_beatup maps\_utility::gun_remove();
	level.kva_guard_beatup.maxhealth = 1;
	level.kva_guard_beatup.health = 1;
	level.kva_hostage_beatup = maps\_utility::spawn_targetname("kva_hostage_beatup");
	level.hostages = common_scripts\utility::array_add(level.hostages,level.kva_hostage_beatup);
	level.kva_hostage_beatup.animname = "kva_hostage_beatup";
	level.kva_hostage_beatup thread enableragdolldeath();
	level.kva_hostage_beatup maps\_utility::add_damage_function(::hostagedeathdetection);
	var_01 = [level.kva_guard_beatup,level.kva_hostage_beatup];
	common_scripts\utility::array_thread(var_01,::setupaitargetmarkingvariables);
	common_scripts\utility::array_thread(var_01,::deathcleanup);
	var_00 thread maps\_anim::anim_loop(var_01,"h_breach_marking");
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::set_allowdeath(1);
	}
}

//Function Number: 24
hostagecorner()
{
	var_00 = getent("anim_org_drone_opening","targetname");
	level.kva_pm_guard = maps\_utility::spawn_targetname("kva_pm_guard");
	level.kva_pm_guard setthreatdetection("disable");
	level.kva = common_scripts\utility::array_add(level.kva,level.kva_pm_guard);
	level.kva_pm_guard.animname = "kva_pm_guard";
	level.kva_pm_guard.maxhealth = 1;
	level.kva_pm_guard.health = 1;
	var_01 = [level.kva_pm_guard];
	common_scripts\utility::array_thread(var_01,::setupaitargetmarkingvariables);
	common_scripts\utility::array_thread(var_01,::deathcleanup);
	var_00 thread maps\_anim::anim_loop(var_01,"h_breach_marking");
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::set_allowdeath(1);
	}
}

//Function Number: 25
hostageexecution()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	level.kva_guard_corner = maps\_utility::spawn_targetname("kva_guard_corner");
	level.kva_guard_corner setthreatdetection("disable");
	level.kva_guard_corner endon("death");
	level.kva_guard_corner.animname = "kva_guard_corner";
	level.kva_guard_corner.battlechatter = 0;
	level.kva_guard_corner.sidearm = "glock";
	level.kva_guard_corner thread deathcleanup();
	level.kva_guard_corner maps\_utility::set_allowdeath(1);
	level.kva_guard_corner.maxhealth = 1;
	level.kva_guard_corner.health = 1;
	level.kva = common_scripts\utility::array_add(level.kva,level.kva_guard_corner);
	level.executionhostages = maps\_utility::array_spawn_targetname("kva_hostage_execution");
	level.hostages = maps\_utility::array_merge(level.hostages,level.executionhostages);
	level.executionhostages[0] thread hostageexecutiondeath();
	level.executionhostages[1] thread hostageexecutiondeath();
	level.executionhostages[2] thread hostageexecutiondeath();
	var_00 = 1;
	foreach(var_02 in level.executionhostages)
	{
		var_02.animname = "kva_hostage_execution_" + var_00;
		var_00++;
		var_02.team = "axis";
		var_02 thread enableragdolldeath();
		var_02 thread deathcleanup();
		var_02 maps\_utility::add_damage_function(::hostagedeathdetection);
	}

	var_04 = common_scripts\utility::array_add(level.executionhostages,level.kva_guard_corner);
	common_scripts\utility::array_thread(var_04,::setupaitargetmarkingvariables);
	var_05 = getent("anim_org_drone_opening","targetname");
	var_05 thread maps\_anim::anim_loop(level.executionhostages,"h_breach_marking","hostage_start_execution");
	var_05 thread maps\_anim::anim_loop_solo(level.kva_guard_corner,"h_breach_marking","guard_start_execution");
	level waittill("h_breach_timer_done");
	var_05 notify("guard_start_execution");
	var_05 maps\_anim::anim_reach_solo(level.kva_guard_corner,"h_breach_execution");
	var_05 thread maps\_anim::anim_single_solo(level.executionhostages[2],"h_breach_execution");
	var_05 maps\_anim::anim_single_solo(level.kva_guard_corner,"h_breach_execution");
	foreach(var_07 in var_04)
	{
		var_07 maps\_utility::set_allowdeath(1);
	}
}

//Function Number: 26
h_breach_timer()
{
	level endon("BreachComplete");
	wait(23);
	level notify("execution_start");
	wait(5);
	level notify("h_breach_timer_done");
}

//Function Number: 27
hostageexecutionseq(param_00)
{
	level endon("BreachComplete");
	wait(0.5);
	level notify("BreachFailed");
}

//Function Number: 28
hostageexecutionseqvfx(param_00)
{
	playfxontag(common_scripts\utility::getfx("execution_blood"),level.executionhostages[2],"J_Head");
}

//Function Number: 29
hostageexecutiondeath()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	self waittill("death");
	wait(0.75);
	level notify("BreachFailed");
}

//Function Number: 30
tracelocation()
{
	level endon("Breach_Actor_Dead");
	level endon("BreachFailed");
	level endon("LockTargets");
	for(;;)
	{
		var_00 = self geteye();
		var_01 = self getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = var_00 + var_02 * 250000;
		var_04 = bullettrace(var_00,var_03,1,self,0,1,0,0,0);
		var_05 = var_04["entity"];
		level.currenttarget = var_05;
		if(isdefined(var_05) && isai(var_05) && var_05.team != "allies")
		{
			if(var_05.currenttarget == 0)
			{
				var_05 thread activetarget();
			}
		}
		else if(!isdefined(var_05) || !isai(var_05))
		{
			level.player notify("TargetLostAll");
		}

		wait 0.05;
	}
}

//Function Number: 31
activetarget()
{
	self endon("death");
	level endon("BreachComplete");
	level endon("BreachFailed");
	thread targetmonitor();
	thread tagtarget();
	if(self.targetmarked == 0)
	{
		soundscripts\_snd::snd_message("hb_highlight_enable");
		self hudoutlineenable(3,1);
	}

	waittill_either_differnt_senders(level.player,"TargetLostAll",self,"TargetLost");
	if(self.targetmarked == 0)
	{
		soundscripts\_snd::snd_message("hb_highlight_disable");
		self hudoutlinedisable();
	}
}

//Function Number: 32
waittill_either_differnt_senders(param_00,param_01,param_02,param_03)
{
	param_00 endon(param_01);
	param_02 waittill(param_03);
}

//Function Number: 33
targetmonitor()
{
	self endon("death");
	level endon("BreachComplete");
	level endon("BreachFailed");
	self.currenttarget = 1;
	if(isdefined(level.currenttarget))
	{
		while(isdefined(level.currenttarget) && level.currenttarget == self)
		{
			wait 0.05;
		}
	}

	self.currenttarget = 0;
	self notify("TargetLost");
}

//Function Number: 34
tagtarget()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	level endon("LockTargets");
	level.player endon("TargetLostAll");
	self endon("TargetLost");
	for(;;)
	{
		level.player waittill("MarkTarget");
		level notify("player_marking_targets");
		if(self.targetmarked == 0)
		{
			if(level.breachtargets.size <= 4)
			{
				level.breachtargets = common_scripts\utility::array_add(level.breachtargets,self);
				soundscripts\_snd::snd_message("hb_target_tagged");
				self.targetmarked = 1;
				self hudoutlineenable(1,1);
				if(self.script_noteworthy == "KVA")
				{
					level notify("check_target_confirm");
				}

				if(self.script_noteworthy == "Hostage")
				{
					level notify("check_target_correction");
				}
			}
		}
		else if(self.targetmarked == 1)
		{
			self.targetmarked = 0;
			soundscripts\_snd::snd_message("hb_target_untagged");
			self hudoutlineenable(3,1);
			level.breachtargets = common_scripts\utility::array_remove(level.breachtargets,self);
		}

		if(self.targetmarked == 1)
		{
			wait 0.05;
		}
	}
}

//Function Number: 35
breachtargetarraymonitor()
{
	level endon("BreachComplete");
	level endon("BreachFailed");
	level endon("LockTargets");
	var_00 = 0;
	for(;;)
	{
		if(level.breachtargets.size >= 4)
		{
			if(var_00 == 0)
			{
				thread hostagelocktargetstext();
				var_00 = 1;
			}
		}
		else if(var_00 == 1)
		{
			thread hostagemarktargetstext();
			var_00 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 36
locktargets()
{
	for(;;)
	{
		for(var_00 = 0;level.breachtargets.size >= 4;var_00 = 1)
		{
			if(level.player usebuttonpressed())
			{
				level notify("LockTargets");
				soundscripts\_snd::snd_message("hb_lock_targets");
				thread hostageclearmarklocktext();
				level.bpm settext("");
				level waittill("arms_down");
				level.player enableweapons();
				level.player disableoffhandweapons();
				level.player switchtoweapon(level.player.primaryweapon);
				level.player thread h_breach_bullet_decals();
				return;
			}

			wait 0.05;
		}

		if(!var_00)
		{
			wait 0.05;
		}
	}
}

//Function Number: 37
breachdialogreminders()
{
	level endon("BreachFailed");
	level endon("Breach_Actor_Dead");
	for(;;)
	{
		if(level.breachtargets.size == 4)
		{
			thread maps\lagos_vo::harmonic_breach_shoot_now_dialogue();
			wait(randomfloatrange(5,10));
		}

		wait 0.05;
	}
}

//Function Number: 38
breachtrigger()
{
	level endon("BreachFailed");
	level waittill("Breach_Actor_Dead");
	thread hostageclearmarklocktext();
	level.bpm settext("");
	if(level.breachtargets.size > 0)
	{
		var_00 = getentarray("NoSight","targetname");
		foreach(var_02 in var_00)
		{
			var_02 delete();
		}

		thread togglebreachslomo();
		wait 0.05;
		thread h_breach_hostile_elim();
		thread h_breach_multi_sync_kill_player_god();
		maps\_utility::waittill_dead_or_dying(level.breachtargets);
	}

	var_04 = returnfilterednoteworthyarray("KVA");
	if(var_04.size == 0)
	{
		soundscripts\_snd::snd_message("hb_shots_fired");
		level notify("BreachComplete");
		level notify("player_god_off");
		wait(1);
		level notify("HostageMonitorOff");
		soundscripts\_snd::snd_message("hb_sensor_flash_off");
		common_scripts\utility::array_call(level.xraywall_static,::show);
		common_scripts\utility::array_call(level.xraywall_static,::solid);
		common_scripts\utility::array_call(level.xraywall_on,::hide);
		level notify("h_breach_wall_solid");
		thread remove_h_breach_hostages();
		return;
	}

	soundscripts\_snd::snd_message("hb_shots_fired");
	level notify("BreachFailed");
}

//Function Number: 39
remove_h_breach_hostages()
{
	if(!common_scripts\utility::flag("post_h_breach_playerstart"))
	{
		foreach(var_01 in level.hostages)
		{
			if(isdefined(var_01))
			{
				var_01 notify("internal_stop_magic_bullet_shield");
				var_01 delete();
			}
		}

		foreach(var_04 in level.kva)
		{
			if(isdefined(var_04))
			{
				var_04 delete();
			}
		}
	}
}

//Function Number: 40
shootenemy(param_00)
{
	self endon("death");
	maps\_utility::disable_surprise();
	maps\_utility::disable_bulletwhizbyreaction();
	self.alertlevel = "combat";
	var_01 = self.baseaccuracy;
	maps\_utility::disable_dontevershoot();
	self.ignoreall = 0;
	self.baseaccuracy = 50000;
	if(isdefined(param_00) && isalive(param_00))
	{
		self.favoriteenemy = param_00;
		param_00 waittill("death");
	}

	self.baseaccuracy = var_01;
	self.favoriteenemy = undefined;
	self.ignoreall = 1;
	maps\_utility::enable_dontevershoot();
}

//Function Number: 41
shootkva_enemyindexer(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return var_02;
		}
	}
}

//Function Number: 42
shootkva()
{
	self endon("death");
	maps\_utility::disable_surprise();
	maps\_utility::disable_bulletwhizbyreaction();
	self.alertlevel = "combat";
	self.old_accuracy = self.baseaccuracy;
	maps\_utility::disable_dontevershoot();
	self.ignoreall = 0;
	self.baseaccuracy = 50000;
	if(self.animname == "burke")
	{
		if(isalive(level.kva[0]))
		{
			self.favoriteenemy = level.kva[0];
			level.kva[0] waittill("death");
			wait 0.05;
		}
	}

	if(self.animname == "joker")
	{
		if(isalive(level.kva[1]))
		{
			self.favoriteenemy = level.kva[1];
			level.kva[1] waittill("death");
			wait 0.05;
		}
	}

	if(self.animname == "ajani")
	{
		if(isalive(level.kva[2]))
		{
			self.favoriteenemy = level.kva[2];
			level.kva[2] waittill("death");
			wait 0.05;
		}
	}

	self.baseaccuracy = self.old_accuracy;
	self.favoriteenemy = undefined;
	self.ignoreall = 1;
	maps\_utility::enable_dontevershoot();
}

//Function Number: 43
h_breach_hostile_elim()
{
	var_00 = common_scripts\utility::getstructarray("magic_bullet_loc_h","targetname");
	var_00 = common_scripts\utility::array_randomize(var_00);
	thread h_breach_multi_sync_kills(level.breachtargets,var_00);
}

//Function Number: 44
togglebreachslomo()
{
	setslowmotion(1,0.65,0.45);
	wait(2);
	setslowmotion(0.45,1,0.65);
}

//Function Number: 45
breachfailstate()
{
	level endon("BreachComplete");
	level waittill("BreachFailed");
	level notify("DisableBreachTrigger");
	thread togglebreachslomo();
	level.player disableweapons();
	setsaveddvar("r_hudoutlineenable",0);
	thread hostageclearmarklocktext();
	level.bpm settext("");
	common_scripts\utility::array_thread(level.hostages,::teamswap,"allies");
	common_scripts\utility::array_thread(level.allysquad,::disableaicombatreactions);
	delete_heartrate_hud();
	setdvar("ui_deadquote",&"LAGOS_HBREACH_FAILED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 46
removeharmonicbreachhostages()
{
	foreach(var_01 in level.hostages)
	{
		var_01 delete();
	}
}

//Function Number: 47
returnfilterednoteworthyarray(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	var_01 = maps\_utility::array_removedead_or_dying(var_01);
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	return var_01;
}

//Function Number: 48
stopscriptedanimations()
{
	if(isdefined(self) && isalive(self))
	{
		self stopanimscripted();
	}
}

//Function Number: 49
teamswap(param_00)
{
	if(isdefined(self) && isalive(self))
	{
		self.team = param_00;
	}
}

//Function Number: 50
hostagedeathdetection(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	delete_heartrate_hud();
	setdvar("ui_deadquote",&"LAGOS_HBREACH_FAILED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 51
hostagemarktargetstext()
{
	maps\_utility::hint(&"LAGOS_HBREACH_TARGET");
}

//Function Number: 52
hostagelocktargetstext()
{
	maps\_utility::hint(&"LAGOS_HBREACH_LOCK");
}

//Function Number: 53
hostageclearmarklocktext()
{
	maps\_utility::hint("");
}

//Function Number: 54
playerhbreachwristequipment()
{
	thread playerhudelements();
	thread playerwristmodelanim();
}

//Function Number: 55
playerhudelements()
{
	var_00 = "remote_chopper_hud_target_hit";
	var_01 = newclienthudelem(level.player);
	var_01 setshader(var_00,32,32);
	var_01.x = 0;
	var_01.y = 0;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.alpha = 1;
	level waittill("LockTargets");
	var_01 maps\_hud_util::destroyelem();
	delete_heartrate_hud();
}

//Function Number: 56
playerwristmodelanim()
{
	var_00 = maps\_utility::spawn_anim_model("player_hbreach_wrist",level.player.origin);
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,-2),(0,0,0),1);
	level.player thread maps\_anim::anim_single_solo(var_00,"h_breach_on");
	level waittill("LockTargets");
	level.player maps\_anim::anim_set_rate_single(var_00,"h_breach_on",1);
	wait(0.7);
	var_00 delete();
	level notify("arms_down");
}

//Function Number: 57
h_breach_multi_sync_kills(param_00,param_01)
{
	level.target_array = param_00;
	level.shoot_point_array = [];
	level.shoot_point_array[level.shoot_point_array.size] = level.burke gettagorigin("tag_flash");
	level.shoot_point_array[level.shoot_point_array.size] = level.joker gettagorigin("tag_flash");
	level.shoot_point_array[level.shoot_point_array.size] = level.ajani gettagorigin("tag_flash");
	thread h_breach_multi_sync_kills_timeout();
	while(level.target_array.size > 0)
	{
		level.target_array = maps\_utility::array_removedead_or_dying(level.target_array);
		if(isalive(level.target_array[0]))
		{
			var_02 = level.target_array[0];
			var_03 = level.shoot_point_array[0];
			level.target_array = common_scripts\utility::array_remove(level.target_array,level.target_array[0]);
			level.shoot_point_array = common_scripts\utility::array_remove(level.shoot_point_array,level.shoot_point_array[0]);
			thread h_breach_multi_sync_kill_shooter(var_02,var_03);
		}

		wait 0.05;
	}
}

//Function Number: 58
h_breach_multi_sync_kills_timeout()
{
	wait(0.15);
	foreach(var_01 in level.kva)
	{
		if(isalive(var_01))
		{
			var_01 kill();
		}
	}
}

//Function Number: 59
h_breach_multi_sync_kill_shooter(param_00,param_01)
{
	param_00.maxhealth = 1;
	param_00.health = 1;
	var_02 = param_00 gettagorigin("TAG_EYE");
	while(isalive(param_00))
	{
		if(!isdefined(param_01))
		{
			wait 0.05;
			continue;
		}

		magicbullet("iw5_bal27_sp",param_01,var_02);
		level notify("h_breach_shot",param_01,var_02);
		wait(randomfloatrange(0.07,0.1));
	}

	level.shoot_point_array = common_scripts\utility::array_add(level.shoot_point_array,param_01);
	level.shoot_point_array = common_scripts\utility::array_randomize(level.shoot_point_array);
}

//Function Number: 60
h_breach_multi_sync_kill_player_god()
{
	level.player enableinvulnerability();
	level waittill("player_god_off");
	level.player disableinvulnerability();
}

//Function Number: 61
h_breach_bullet_decals()
{
	self waittill("weapon_fired");
	var_00 = [];
	var_00[var_00.size] = spawnstruct();
	var_01 = self geteye();
	var_02 = self geteye() + anglestoforward(self getgunangles()) * 100;
	var_00[0].start = var_01;
	var_00[0].end = var_02;
	switch(level.breachtargets.size)
	{
		case 3:
			level waittill("h_breach_shot",var_01,var_02);
			var_03 = var_00.size;
			var_00[var_03] = spawnstruct();
			var_00[var_03].start = var_01;
			var_00[var_03].end = var_02;
			break;

		case 2:
			level waittill("h_breach_shot",var_01,var_02);
			var_03 = var_00.size;
			var_00[var_03] = spawnstruct();
			var_00[var_03].start = var_01;
			var_00[var_03].end = var_02;
			break;

		case 1:
			level waittill("h_breach_shot",var_01,var_02);
			var_03 = var_00.size;
			var_00[var_03] = spawnstruct();
			var_00[var_03].start = var_01;
			var_00[var_03].end = var_02;
			break;

		default:
			break;
	}

	level waittill("h_breach_wall_solid");
	foreach(var_05 in var_00)
	{
		h_breach_bullet_spawn_decal(var_05.start,var_05.end);
		h_breach_bullet_spawn_decal(var_05.end,var_05.start);
	}
}

//Function Number: 62
h_breach_bullet_spawn_decal(param_00,param_01)
{
	var_02 = bullettrace(param_00,param_01,0);
	var_03 = var_02["position"];
	var_04 = var_02["normal"] * 360 + (0,90,0);
	var_05 = var_02["normal"] * 360;
	if(!isdefined(var_02["entity"]) || isdefined(var_02["entity"].targetname) && var_02["entity"].targetname == "xraywall_static")
	{
		playfx(common_scripts\utility::getfx("lag_harmonic_breach_bullet_decal_" + randomint(4) + 1),var_03,var_04,var_05);
	}
}