/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 901 ms
 * Timestamp: 4/22/2024 2:30:37 AM
*******************************************************************/

//Function Number: 1
manhuntintroscreen()
{
	level.player disableweapons();
	var_00 = newclienthudelem(level.player);
	var_00 setshader("black",1280,720);
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00.foreground = 0;
	common_scripts\utility::flag_set("FlagSafeHouseIntro");
	wait(1);
	common_scripts\utility::flag_set("introscreen_complete");
	var_00 fadeovertime(2);
	var_00.alpha = 0;
	common_scripts\utility::flag_set("FlagIntroScreenComplete");
	wait(2);
	var_00 destroy();
}

//Function Number: 2
debugplayerteleport(param_00)
{
	var_01 = "PlayerTeleport" + param_00;
	var_02 = getent(var_01,"targetname");
	var_03 = "PlayerStart" + param_00;
	var_04 = common_scripts\utility::getstruct(var_03,"targetname");
	maps\_utility::trigger_wait_targetname(var_01);
	maps\_utility::teleport_player(var_04);
	iprintln("Teleporting player to " + param_00);
}

//Function Number: 3
settargetandshader(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(!target_istarget(param_00))
	{
		var_04 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 48;
	}

	if(var_04)
	{
		target_alloc(param_00,(0,0,param_03));
	}

	if(isdefined(param_01))
	{
		target_setshader(param_00,param_01);
	}

	if(isdefined(param_02))
	{
		target_setoffscreenshader(param_00,param_02);
	}

	if(var_04)
	{
		target_flush(param_00);
	}
}

//Function Number: 4
killfloodspawnersonflag(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait_either(param_01,param_02);
	}
	else
	{
		common_scripts\utility::flag_wait(param_01);
	}

	maps\_spawner::killspawner(param_00);
}

//Function Number: 5
waittillneargoal(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 50;
	}

	while(distance(self.origin,param_00.origin) > param_01)
	{
		wait(0.05);
	}

	self notify("goal");
}

//Function Number: 6
getinchesinfeet(param_00)
{
	return param_00 * 12;
}

//Function Number: 7
checkvehicleturretuserstatus(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	wait(randomfloatrange(1,5));
	thread _findnewvehicleturretuser(param_00,param_01);
}

//Function Number: 8
_findnewvehicleturretuser(param_00,param_01)
{
	var_02 = maps\_utility::get_living_ai_array(param_01,"script_noteworthy");
	if(var_02.size > 0)
	{
		var_03 = common_scripts\utility::random(var_02);
		var_03 _assignnewvehicleturretuser(param_00,param_01);
	}
}

//Function Number: 9
_assignnewvehicleturretuser(param_00,param_01)
{
	self endon("death");
	self endon("dying");
	param_00 endon("death");
	wait(randomfloatrange(1,5));
	self.script_startingposition = 6;
	param_00 maps\_utility::guy_enter_vehicle(self);
	maps\_hms_utility::printlnscreenandconsole(param_01 + " is now moving to the gunner seat in Turret Vehicle");
	thread checkvehicleturretuserstatus(param_00,param_01);
	thread _vehicleturretreenable(param_00);
}

//Function Number: 10
_vehicleturretreenable(param_00)
{
	param_00 endon("death");
	foreach(var_02 in param_00.mgturret)
	{
		while(!isturretactive(var_02))
		{
			wait(1);
		}

		level notify("TurretInUse");
		var_02 turretfireenable();
	}
}

//Function Number: 11
waittillaineargoal(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 50;
	}

	if(!isdefined(param_01))
	{
		param_01 = "goal";
	}

	self waittill(param_01);
	if(isdefined(self.name))
	{
		maps\_hms_utility::printlnscreenandconsole(self.name + " is now " + param_01);
	}
}

//Function Number: 12
waittillaiarrayneargoal(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "goal";
	}

	var_02 = spawnstruct();
	var_02.threads = 0;
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04))
		{
			var_04 thread common_scripts\utility::waittill_string(param_01,var_02);
			var_02.threads++;
		}
	}

	while(var_02.threads)
	{
		var_02 waittill("returned");
		var_02.threads--;
	}
}

//Function Number: 13
waittillplayeristouchinganytrigger(param_00)
{
	var_01 = spawnstruct();
	foreach(var_03 in param_00)
	{
		var_03 thread common_scripts\utility::waittill_string("trigger",var_01);
	}

	var_01 waittill("returned");
}

//Function Number: 14
kill_no_react(param_00,param_01)
{
	self.a.nodeath = 1;
	if(isdefined(param_01))
	{
		thread kill_with_delay(param_00,param_01);
		return;
	}

	thread kill_with_delay(param_00);
}

//Function Number: 15
kill_with_delay(param_00,param_01)
{
	if(!isalive(self))
	{
		return;
	}

	if(isdefined(param_00))
	{
		wait(param_00);
	}

	self.allowdeath = 1;
	thread maps\_utility::set_battlechatter(0);
	if(isdefined(param_01))
	{
		self kill(self.origin,param_01);
		return;
	}

	self kill();
}

//Function Number: 16
clear_set_goal()
{
	self endon("death");
	self notify("new_anim_reach");
	self notify("goal");
	maps\_utility::unset_forcegoal();
	self.last_set_goalnode = undefined;
	self.last_set_goalpos = undefined;
	self.last_set_goalent = undefined;
	maps\_utility::unset_forcegoal();
}

//Function Number: 17
setragdolldeath(param_00,param_01)
{
	self endon("delete");
	self endon("no_ragdoll");
	self waittill("death");
	if(isdefined(param_00))
	{
		if(isdefined(param_01))
		{
			param_01 notify(param_00);
		}
		else
		{
			level notify(param_00);
		}
	}

	self.noragdoll = undefined;
	self.a.nodeath = 1;
	animscripts\notetracks::notetrackstartragdoll("ragdoll");
	self stopanimscripted();
}

//Function Number: 18
clearragdolldeath()
{
	self notify("no_ragdoll");
	self.ragdoll_immediate = undefined;
}

//Function Number: 19
shootguy(param_00,param_01,param_02)
{
	var_03 = self.baseaccuracy;
	maps\_utility::disable_dontevershoot();
	self.ignoreall = 0;
	self.baseaccuracy = 5000;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isdefined(param_00) && isalive(param_00))
	{
		param_00 endon("death");
		if(param_02 == 1)
		{
			thread shootguytargetmustdie(param_00);
		}

		if(!isdefined(param_01))
		{
			param_01 = 1;
		}

		if(param_01 == 1)
		{
			if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield == 1)
			{
				param_00 maps\_utility::stop_magic_bullet_shield();
			}

			param_00.maxhealth = 1;
			param_00.health = 1;
		}

		param_00 maps\_utility::set_ignoreme(0);
		param_00.dontattackme = undefined;
		self.favoriteenemy = param_00;
		if(param_01 == 1)
		{
			param_00 waittill("death");
		}
		else
		{
			param_00 waittill("damage");
		}
	}

	self.baseaccuracy = var_03;
	self.favoriteenemy = undefined;
	self.ignoreall = 1;
	maps\_utility::enable_dontevershoot();
}

//Function Number: 20
shootguytargetmustdie(param_00)
{
	while(isalive(param_00))
	{
		self endon("death");
		param_00 endon("death");
		wait(2);
		magicbullet("iw5_sn6_sp_silencer01",self gettagorigin("TAG_WEAPON"),param_00 geteye());
	}
}

//Function Number: 21
disableawareness()
{
	self.ignoreall = 1;
	self.dontmelee = 1;
	self.suppressionwait_old = self.suppressionwait;
	self.suppressionwait = 0;
	maps\_utility::disable_surprise();
	self.ignorerandombulletdamage = 1;
	maps\_utility::disable_bulletwhizbyreaction();
	maps\_utility::disable_pain();
	maps\_utility::disable_danger_react();
	self.grenadeawareness = 0;
	self.ignoreme = 1;
	maps\_utility::enable_dontevershoot();
	self.disablefriendlyfirereaction = 1;
}

//Function Number: 22
enableawareness()
{
	self.ignoreall = 0;
	self.dontmelee = undefined;
	if(isdefined(self.suppressionwait_old))
	{
		self.suppressionwait = self.suppressionwait_old;
	}

	self.suppressionwait_old = undefined;
	maps\_utility::enable_surprise();
	self.ignorerandombulletdamage = 0;
	maps\_utility::enable_bulletwhizbyreaction();
	maps\_utility::enable_pain();
	self.grenadeawareness = 1;
	self.ignoreme = 0;
	maps\_utility::disable_dontevershoot();
	self.disablefriendlyfirereaction = undefined;
}

//Function Number: 23
rumbleplayerlight()
{
	level.player playrumbleonentity("damage_light");
	earthquake(0.1,0.2,level.player.origin,100);
}

//Function Number: 24
rumbleplayerheavy()
{
	level.player playrumbleonentity("damage_heavy");
	earthquake(0.3,0.2,level.player.origin,100);
}

//Function Number: 25
clearstencil()
{
	if(!isdefined(self))
	{
		return;
	}

	common_scripts\utility::waittill_any("death","remove_outline");
	if(!isdefined(self))
	{
		return;
	}

	self setthreatdetection("enhanceable");
}

//Function Number: 26
settargetoutline()
{
	if(isdefined(self.outlinecolor) && self.outlinecolor == "red")
	{
		return;
	}

	self hudoutlineenable(5);
	self.outlinecolor = "yellow";
}

//Function Number: 27
setalertoutline(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self hudoutlineenable(1,param_00);
	self.outlinecolor = "red";
}

//Function Number: 28
clearalertoutline()
{
	if(!isdefined(self))
	{
		return;
	}

	common_scripts\utility::waittill_any("death","remove_outline");
	if(!isdefined(self))
	{
		return;
	}

	self hudoutlinedisable();
}

//Function Number: 29
initfanprops()
{
	common_scripts\utility::array_thread(getentarray("turbine_blades","targetname"),::_rotateprop,5,25,1);
	common_scripts\utility::array_thread(getentarray("ac_fan","targetname"),::_rotateprop,720,1000,1);
	common_scripts\utility::array_thread(getentarray("ceiling_fan_blades","targetname"),::_rotateprop,15,30,0,1);
	common_scripts\utility::array_thread(getentarray("ceiling_fan_blades","targetname"),::_attachfanclip);
}

//Function Number: 30
_rotateprop(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 20000;
	var_06 = randomfloatrange(param_00,param_01);
	for(;;)
	{
		if(param_02 == 1)
		{
			self rotatevelocity((var_06,0,0),var_05);
		}
		else if(param_03 == 1)
		{
			self rotatevelocity((0,var_06,0),var_05);
		}

		wait(0.05);
	}
}

//Function Number: 31
_attachfanclip()
{
	var_00 = getentarray("ceiling_fan_blades_clip","targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(self);
	}
}

//Function Number: 32
bloodsprayexitwoundtrace(param_00,param_01,param_02,param_03)
{
	self endon("delete");
	self endon("bloodless");
	if(!isdefined(param_00))
	{
		param_00 = 1000;
	}

	if(!isdefined(param_02))
	{
		param_02 = "TAG_WEAPON_CHEST";
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(param_03 == 1)
	{
		self waittill("damage",var_04,var_05);
	}
	else
	{
		self waittill("death",var_05);
	}

	if(!isdefined(var_05) || isdefined(param_01) && param_01 != var_05)
	{
		return;
	}

	var_06 = level.player geteye();
	var_07 = level.player getplayerangles();
	var_08 = anglestoforward(var_07);
	var_09 = self gettagorigin(param_02);
	var_0A = var_09 + var_08 * param_00;
	var_0B = bullettrace(var_09,var_0A,0);
	if(isdefined(var_0B["position"]))
	{
		var_0C = var_0B["position"];
		playfx(common_scripts\utility::getfx("blood_impact_splat"),var_0C);
	}
}

//Function Number: 33
aiarrayidleloop(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	foreach(var_03 in param_00)
	{
		var_03 thread aiidleloop(param_01);
	}
}

//Function Number: 34
aiidleloop(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = "Idle" + self.script_noteworthy;
	self.idlepoint = common_scripts\utility::getstruct(var_01,"script_noteworthy");
	if(isdefined(self.idlepoint))
	{
		self.allowdeath = param_00;
		self.allowpain = param_00;
		self.idlepoint thread maps\_anim::anim_loop_solo(self,self.idlepoint.animation,"stop_loop");
		self.idlepointreached = 1;
	}
}

//Function Number: 35
aioverridemodelrandom(param_00,param_01)
{
	var_02 = common_scripts\utility::random(param_01);
	var_03 = common_scripts\utility::random(param_00);
	aioverridemodel(var_03,var_02);
}

//Function Number: 36
aioverridemodel(param_00,param_01)
{
	thread codescripts\character::setheadmodel(param_01);
	self setmodel(param_00);
}

//Function Number: 37
aiarrayoverridemodelrandom(param_00,param_01,param_02)
{
	param_01 = common_scripts\utility::array_randomize(param_01);
	param_02 = common_scripts\utility::array_randomize(param_02);
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] aioverridemodel(param_01[var_03],param_02[var_03]);
	}
}

//Function Number: 38
setdefaulthudoutlinedvars()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",0);
}

//Function Number: 39
warning(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = 1.5 * param_03;
	var_05 = 0.5;
	level endon("clearing_warnings");
	if(isdefined(level.warningelement))
	{
		level.warningelement maps\_hud_util::destroyelem();
	}

	level.warningelement = maps\_hud_util::createfontstring("default",var_04);
	level.warningelement maps\_hud_util::setpoint("TOP",undefined,0,30 + param_02);
	level.warningelement.color = (1,0.1,0.1);
	level.warningelement settext(param_00);
	level.warningelement.alpha = 0;
	level.warningelement fadeovertime(0.5);
	level.warningelement.alpha = 1;
	wait(0.5);
	level.warningelement endon("death");
	childthread warning_pulse();
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	level notify("FadeWarning");
	level.warningelement fadeovertime(var_05);
	level.warningelement.alpha = 0;
	wait(var_05);
	level.warningelement maps\_hud_util::destroyelem();
}

//Function Number: 40
warning_pulse()
{
	level endon("FadeWarning");
	while(isdefined(level.warningelement))
	{
		wait(0.25);
		for(var_00 = 0;var_00 < 9;var_00++)
		{
			var_01 = level.warningelement.alpha - 0.1;
			level.warningelement.alpha = clamp(var_01,0.1,1);
			wait 0.05;
		}

		wait 0.05;
		for(var_00 = 0;var_00 < 9;var_00++)
		{
			var_01 = level.warningelement.alpha + 0.1;
			level.warningelement.alpha = clamp(var_01,0.1,1);
			wait 0.05;
		}
	}
}

//Function Number: 41
warning_fade()
{
	var_00 = 1;
	if(isdefined(level.warningelement))
	{
		level notify("clearing_warnings");
		level.warningelement fadeovertime(var_00);
		level.warningelement.alpha = 0;
		wait(var_00);
	}
}

//Function Number: 42
get_farthest_living(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 9999999;
	}

	if(param_01.size < 1)
	{
		return;
	}

	var_03 = undefined;
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		if(!isalive(param_01[var_04]))
		{
			continue;
		}

		var_05 = distance(param_01[var_04].origin,param_00);
		if(var_05 <= param_02)
		{
			continue;
		}

		param_02 = var_05;
		var_03 = param_01[var_04];
	}

	return var_03;
}

//Function Number: 43
calculateleftstickdeadzone()
{
	var_00 = level.player getnormalizedmovement();
	var_00 = (scalestickinput(var_00[0]),scalestickinput(var_00[1]),var_00[2]);
	return var_00;
}

//Function Number: 44
stickinputindeadzone(param_00,param_01)
{
	return abs(param_00) < param_01;
}

//Function Number: 45
scalestickinput(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	if(stickinputindeadzone(param_00,param_01))
	{
		return 0;
	}

	return param_00 * abs(param_00) - param_01 / 1 - param_01;
}

//Function Number: 46
hint_quick(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.5;
	}

	level endon("clearing_hints");
	if(isdefined(level.hintelement))
	{
		level.hintelement maps\_hud_util::destroyelem();
	}

	level.hintelement = maps\_hud_util::createfontstring("default",1.5);
	level.hintelement maps\_hud_util::setpoint("MIDDLE",undefined,0,30 + param_02);
	level.hintelement.color = (1,1,1);
	level.hintelement settext(param_00);
	level.hintelement.alpha = 0;
	level.hintelement fadeovertime(param_03);
	level.hintelement.alpha = 1;
	wait(param_03);
	level.hintelement endon("death");
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	level.hintelement fadeovertime(param_03);
	level.hintelement.alpha = 0;
	wait(param_03);
	level.hintelement maps\_hud_util::destroyelem();
}

//Function Number: 47
hint_quickfade(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(level.hintelement))
	{
		level notify("clearing_hints");
		level.hintelement fadeovertime(param_00);
		level.hintelement.alpha = 0;
		wait(param_00);
	}
}

//Function Number: 48
sneaky_reload()
{
	var_00 = level.player getcurrentweapon();
	var_01 = level.player getammocount(var_00);
	var_02 = level.player getcurrentweaponclipammo();
	var_03 = weaponclipsize(var_00);
	var_04 = var_03 - var_02;
	level.player setweaponammoclip(var_00,var_03);
	level.player setweaponammostock(var_00,var_01 - var_04);
}

//Function Number: 49
blimp_animation(param_00,param_01)
{
	if(level.nextgen)
	{
		if(isdefined(level.blimp))
		{
			level.blimp delete();
		}

		var_02 = getent(param_00,"targetname");
		level.blimp = maps\_utility::spawn_anim_model("greece_blimp");
		var_02 thread maps\_anim::anim_loop_solo(level.blimp,param_01);
	}
}

//Function Number: 50
sunflareswap(param_00)
{
	common_scripts\utility::flag_set("fx_spot_flare_kill");
	wait(0.5);
	common_scripts\utility::flag_clear("fx_spot_flare_kill");
	thread maps\_shg_fx::fx_spot_lens_flare_dir(param_00,(-15.2216,146.493,0),10000);
}

//Function Number: 51
tff_cleanup_vehicle(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "intro":
			var_01 = "tff_pre_intro_to_confcenter";
			break;

		case "middle":
			var_01 = "tff_pre_intro_to_middle";
			break;

		case "outro":
			var_01 = "tff_pre_middle_to_outro";
			break;

		case "confcenter":
			var_01 = "tff_pre_confcenter_to_intro";
			break;

		case "hades_fight":
			var_01 = "tff_pre_outro_to_hades_fight";
			break;
	}

	if(var_01 == "")
	{
		return;
	}

	level waittill(var_01);
	if(isdefined(self))
	{
		maps\_vehicle_code::_freevehicle();
		self delete();
	}
}

//Function Number: 52
giveplayerchallengekillpoint()
{
	if(self.damagelocation == "helmet" || self.damagelocation == "head")
	{
		level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
	}

	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}