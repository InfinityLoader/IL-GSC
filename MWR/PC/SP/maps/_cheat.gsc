/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_cheat.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 1113 ms
 * Timestamp: 10/27/2023 2:45:45 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("h1_hud_tutorial_blur");
	precacheshader("h1_hud_tutorial_border");
	precachestring(&"SCRIPT_PLATFORM_CHEAT_USETOSLOWMO");
	precacheshellshock("chaplincheat");
	precachemodel("com_junktire");
	level.random_tire_model = "com_junktire";
	level.vision_cheat_enabled = 0;
	setsaveddvar("using_vision_cheat",0);
	level.tire_explosion = 0;
	level.cheatstates = [];
	level.cheatfuncs = [];
	level.cheatdvars = [];
	level.cheatbobamporiginal = getdvar("bg_bobAmplitudeStanding");
	level.cheatshowslowmohint = 0;
	level.cheattires = [];
	level.cheattires_max = 90;
	level.cheat_super_ragdoll = 0;
	thread melonhead_mode_init();
	thread lemonade_mode_init();
	thread tracksuit_mode_init();
	thread tire_explosionmode_init();
	if(!isdefined(level._effect))
	{
		level._effect = [];
	}

	level._effect["grain_test"] = loadfx("fx/misc/grain_test");
	common_scripts\utility::flag_init("has_cheated");
	level.visionsets["bw"] = 0;
	level.visionsets["invert"] = 0;
	level.visionsets["contrast"] = 0;
	level.visionsets["chaplin"] = 0;
	slowmo_system_init();
	thread death_monitor();
	common_scripts\utility::flag_init("disable_slowmo_cheat");
	if(getdvar("credits_active") == "1")
	{
		return;
	}

	level.player thread specialfeaturesmenu();
}

//Function Number: 2
death_monitor()
{
	setdvars_based_on_varibles();
	for(;;)
	{
		if(issaverecentlyloaded())
		{
			setdvars_based_on_varibles();
		}

		wait(0.1);
	}
}

//Function Number: 3
setdvars_based_on_varibles()
{
	for(var_00 = 0;var_00 < level.cheatdvars.size;var_00++)
	{
		setdvar(level.cheatdvars[var_00],level.cheatstates[level.cheatdvars[var_00]]);
	}

	if(!isdefined(level.credits_active) || !level.credits_active)
	{
		setdvar("credits_active","0");
		setdvar("credits_load","0");
	}
}

//Function Number: 4
getcheatvalue(param_00)
{
	var_01 = getdvarint(param_00,0) && getdvar("arcademode") != "1";
	return var_01;
}

//Function Number: 5
addcheat(param_00,param_01)
{
	setdvarifuninitialized(param_00,0);
	level.cheatstates[param_00] = getcheatvalue(param_00);
	level.cheatfuncs[param_00] = param_01;
	if(level.cheatstates[param_00])
	{
		[[ param_01 ]](level.cheatstates[param_00]);
	}
}

//Function Number: 6
checkcheatchanged(param_00)
{
	var_01 = getcheatvalue(param_00);
	if(level.cheatstates[param_00] == var_01)
	{
		return;
	}

	if(var_01)
	{
		common_scripts\utility::flag_set("has_cheated");
	}

	level.cheatstates[param_00] = var_01;
	[[ level.cheatfuncs[param_00] ]](var_01);
}

//Function Number: 7
specialfeaturesmenu()
{
	level waittill("load_finished");
	addcheat("sf_use_contrast",::contrastmode);
	addcheat("sf_use_bw",::bwmode);
	addcheat("sf_use_invert",::invertmode);
	addcheat("sf_use_slowmo",::slowmomode);
	addcheat("sf_use_chaplin",::chaplinmode);
	addcheat("sf_use_ignoreammo",::ignore_ammomode);
	addcheat("sf_use_clustergrenade",::clustergrenademode);
	addcheat("sf_use_tire_explosion",::tire_explosionmode);
	addcheat("sf_use_melon_mode",::melonhead_mode_update);
	addcheat("sf_use_ragdoll_mode",::ragdoll_mode);
	addcheat("sf_use_lemonade_mode",::lemonade_mode_update);
	addcheat("sf_use_tracksuit_mode",::tracksuit_mode_update);
	level.cheatdvars = getarraykeys(level.cheatstates);
	if(is_cheating())
	{
		common_scripts\utility::flag_set("has_cheated");
	}

	for(;;)
	{
		for(var_00 = 0;var_00 < level.cheatdvars.size;var_00++)
		{
			checkcheatchanged(level.cheatdvars[var_00]);
		}

		wait(0.05);
	}
}

//Function Number: 8
tire_explosionmode_init()
{
	maps\_utility::add_global_spawn_function("axis",::tirecheat_dogs_enemy_spawned);
	common_scripts\utility::array_thread(getaiarray("axis"),::tirecheat_dogs_enemy_spawned);
}

//Function Number: 9
tirecheat_dogs_enemy_spawned()
{
	if(!isdefined(self.classname))
	{
		return;
	}

	if(self.classname != "actor_enemy_dog")
	{
		return;
	}

	self waittill("death");
	if(isremovedentity(self))
	{
		return;
	}

	if(level.tire_explosion)
	{
		var_00 = self.origin;
		var_01 = self geteye();
		waittillframeend;
		for(var_02 = 0;var_02 < 15;var_02++)
		{
			thread maps\_spawner::random_tire(var_00,var_01);
		}

		if(isdefined(self) && !isremovedentity(self))
		{
			self delete();
		}
	}
}

//Function Number: 10
tire_explosionmode(param_00)
{
	if(param_00)
	{
		level.tire_explosion = 1;
		return;
	}

	level.tire_explosion = 0;
}

//Function Number: 11
clustergrenademode(param_00)
{
	if(param_00)
	{
		level.player thread wait_for_grenades();
		return;
	}

	level notify("end_cluster_grenades");
}

//Function Number: 12
wait_for_grenades()
{
	level endon("end_cluster_grenades");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00.cluster_grenade) && var_00.cluster_grenade)
		{
			continue;
		}

		if(var_01 == "fraggrenade" || var_01 == level.cheat_lemonade_weaponname)
		{
			var_00 thread create_clustergrenade("fraggrenade");
		}
	}
}

//Function Number: 13
create_clustergrenade(param_00)
{
	var_01 = self.origin;
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		var_01 = self.origin;
		wait(0.1);
	}

	var_01 = var_01 + (0,0,5);
	var_02 = 8;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = getclustergrenadevelocity();
		var_05 = 1.5 + var_03 / 6 + randomfloat(0.1);
		var_06 = magicgrenademanual(param_00,var_01,var_04,var_05,level.player);
		var_06.cluster_grenade = 1;
	}
}

//Function Number: 14
getclustergrenadevelocity()
{
	var_00 = randomfloat(360);
	var_01 = randomfloatrange(65,85);
	var_02 = sin(var_01);
	var_03 = cos(var_01);
	var_04 = cos(var_00) * var_03;
	var_05 = sin(var_00) * var_03;
	var_06 = randomfloatrange(400,600);
	var_07 = (var_04,var_05,var_02) * var_06;
	return var_07;
}

//Function Number: 15
ignore_ammomode(param_00)
{
	if(level.script == "ac130")
	{
		return;
	}

	if(param_00)
	{
		setsaveddvar("player_sustainAmmo",1);
		return;
	}

	setsaveddvar("player_sustainAmmo",0);
}

//Function Number: 16
contrastmode(param_00)
{
	if(param_00)
	{
		level.visionsets["contrast"] = 1;
	}
	else
	{
		level.visionsets["contrast"] = 0;
	}

	applyvisionsets();
}

//Function Number: 17
bwmode(param_00)
{
	if(param_00)
	{
		level.visionsets["bw"] = 1;
	}
	else
	{
		level.visionsets["bw"] = 0;
	}

	applyvisionsets();
}

//Function Number: 18
invertmode(param_00)
{
	if(param_00)
	{
		level.visionsets["invert"] = 1;
	}
	else
	{
		level.visionsets["invert"] = 0;
	}

	applyvisionsets();
}

//Function Number: 19
applyvisionsets()
{
	if(level.script == "ac130")
	{
		return;
	}

	var_00 = 0;
	var_01 = "";
	if(level.visionsets["bw"])
	{
		var_01 = var_01 + "_bw";
	}

	if(level.visionsets["invert"])
	{
		var_01 = var_01 + "_invert";
		if(isdefined(level.cheat_invert_override))
		{
			var_01 = var_01 + level.cheat_invert_override;
		}
	}

	if(level.visionsets["contrast"])
	{
		var_01 = var_01 + "_contrast";
		if(isdefined(level.cheat_highcontrast_override))
		{
			var_01 = var_01 + level.cheat_highcontrast_override;
		}
	}

	if(level.visionsets["chaplin"])
	{
		level.vision_cheat_enabled = 1;
		setsaveddvar("using_vision_cheat",1);
		visionsetnaked("sepia",var_00);
		return;
	}

	if(var_01 != "")
	{
		level.vision_cheat_enabled = 1;
		setsaveddvar("using_vision_cheat",1);
		visionsetnaked("cheat" + var_01,var_00);
		return;
	}

	level.vision_cheat_enabled = 0;
	setsaveddvar("using_vision_cheat",0);
	maps\_utility::set_vision_set(level.lvl_visionset,var_00);
}

//Function Number: 20
slowmo_system_init()
{
	level.slowmo = spawnstruct();
	slowmo_system_defaults();
	notifyoncommand("_cheat_player_press_slowmo","+melee");
	notifyoncommand("_cheat_player_press_slowmo","+melee_breath");
	notifyoncommand("_cheat_player_press_slowmo","+melee_zoom");
}

//Function Number: 21
slowmo_system_defaults()
{
	level.slowmo.lerp_time_in = 0;
	level.slowmo.lerp_time_out = 0.25;
	level.slowmo.speed_slow = 0.4;
	level.slowmo.speed_norm = 1;
}

//Function Number: 22
slowmo_check_system()
{
	return 1;
}

//Function Number: 23
slowmo_hintprint()
{
	common_scripts\utility::flag_wait("introscreen_complete");
	if(level.cheatshowslowmohint != 0)
	{
		level.cheatshowslowmohint = 0;
		return;
	}

	if(level.console)
	{
		var_00 = 5;
	}
	else
	{
		var_00 = 6;
	}

	level.cheatshowslowmohint = 1;
	var_01 = 180;
	var_02 = maps\_hud_util::createicon("h1_hud_tutorial_blur",400,25);
	var_03 = maps\_hud_util::createicon("h1_hud_tutorial_border",400,1);
	var_04 = maps\_hud_util::createicon("h1_hud_tutorial_border",400,1);
	var_02 maps\_hud_util::setpoint("TOP",undefined,0,var_01);
	var_02.sort = 1;
	var_02.hidewheninmenu = 1;
	var_02.hidewhendead = 1;
	var_02.alpha = 0.9;
	var_03 maps\_hud_util::setpoint("TOP",undefined,0,var_01);
	var_03.sort = 1;
	var_03.hidewheninmenu = 1;
	var_03.hidewhendead = 1;
	var_03.alpha = 0.05;
	var_04 maps\_hud_util::setpoint("TOP",undefined,0,var_01 + 24);
	var_04.sort = 1;
	var_04.hidewheninmenu = 1;
	var_04.hidewhendead = 1;
	var_04.alpha = 0.05;
	var_05 = maps\_hud_util::createfontstring("timer",0.5);
	var_05.hidewheninmenu = 1;
	var_05 maps\_hud_util::setpoint("TOP",undefined,0,var_01 + var_00);
	var_05.sort = 0.5;
	var_05 settext(&"SCRIPT_PLATFORM_CHEAT_USETOSLOWMO");
	for(var_06 = 0;var_06 < 100;var_06++)
	{
		if(level.cheatshowslowmohint != 1)
		{
			break;
		}

		wait(0.1);
	}

	level.cheatshowslowmohint = 0;
	var_02 fadeovertime(0.5);
	var_02.alpha = 0;
	var_03 fadeovertime(0.5);
	var_03.alpha = 0;
	var_04 fadeovertime(0.5);
	var_04.alpha = 0;
	var_05 fadeovertime(0.5);
	var_05.alpha = 0;
	wait(0.5);
	var_02 destroy();
	var_03 destroy();
	var_04 destroy();
	var_05 destroy();
}

//Function Number: 24
slowmomode(param_00)
{
	level.slowmo_mode_enabled = common_scripts\utility::ter_op(param_00,1,0);
	if(level.slowmo_mode_enabled)
	{
		level.slowmo thread gamespeed_proc();
		level.player allowmelee(0);
		thread slowmo_hintprint();
		return;
	}

	level notify("disable_slowmo");
	level.player allowmelee(1);
	level.slowmo thread gamespeed_reset();
	level.cheatshowslowmohint = 0;
}

//Function Number: 25
gamespeed_proc()
{
	level endon("disable_slowmo");
	thread gamespeed_reset_on_death();
	for(;;)
	{
		level.player waittill("_cheat_player_press_slowmo");
		level.cheatshowslowmohint = 0;
		slowmo_system_defaults();
		if(!common_scripts\utility::flag("disable_slowmo_cheat"))
		{
			if(gettimescale() < level.slowmo.speed_norm)
			{
				thread gamespeed_reset();
			}
			else
			{
				thread gamespeed_slowmo();
			}
		}

		waittillframeend;
	}
}

//Function Number: 26
gamespeed_reset_on_death()
{
	level notify("gamespeed_reset_on_death");
	level endon("gamespeed_reset_on_death");
	level.player waittill("death");
	thread gamespeed_reset();
}

//Function Number: 27
gamespeed_slowmo()
{
	level.player thread common_scripts\utility::play_loop_sound_on_entity("h1_slowmo_cheat_heartbeat");
	setslowmotion(self.speed_norm,self.speed_slow,self.lerp_time_in);
}

//Function Number: 28
gamespeed_reset()
{
	level.player thread common_scripts\utility::stop_loop_sound_on_entity("h1_slowmo_cheat_heartbeat");
	if(!common_scripts\utility::flag("disable_slowmo_cheat"))
	{
		setslowmotion(self.speed_slow,self.speed_norm,self.lerp_time_out);
	}
}

//Function Number: 29
slowmomodesuspend()
{
	level endon("slowmo_resume");
	if(gettimescale() < level.slowmo.speed_norm)
	{
		level.sloweddown = 1;
	}

	for(;;)
	{
		if(isdefined(level.slowmo_mode_enabled) && level.slowmo_mode_enabled)
		{
			level notify("disable_slowmo");
			level.slowmo thread gamespeed_reset();
			level.player allowmelee(1);
		}

		wait(0.05);
	}
}

//Function Number: 30
slowmomoderesume()
{
	if(isdefined(level.slowmo_mode_enabled) && level.slowmo_mode_enabled)
	{
		level notify("slowmo_resume");
		if(isdefined(level.sloweddown))
		{
			level.slowmo thread gamespeed_slowmo();
		}

		level.slowmo thread gamespeed_proc();
		level.player allowmelee(0);
		level.sloweddown = undefined;
	}
}

//Function Number: 31
chaplinmode(param_00)
{
	if(level.script == "ac130")
	{
		return;
	}

	if(param_00)
	{
		setsaveddvar("chaplincheat","1");
		level.cheatbobamporiginal = getdvar("bg_weaponBobAmplitudeStanding");
		setsaveddvar("bg_weaponBobAmplitudeStanding","0.08 0.04");
		setomnvar("ui_ragtimewarefare_overlay",1);
		level.visionsets["chaplin"] = 1;
		visionsetnight("cheat_chaplinnight");
		chaplin_grain_start();
		thread chaplin_proc();
	}
	else
	{
		level notify("disable_chaplin");
		level notify("disable_chaplin_grain");
		chaplin_grain_end();
		level.player stopshellshock();
		visionsetnight("default_night");
		setomnvar("ui_ragtimewarefare_overlay",0);
		level.visionsets["chaplin"] = 0;
		soundscripts\_snd::snd_message("aud_stop_ragtime_warfare");
		setsaveddvar("bg_weaponBobAmplitudeStanding",level.cheatbobamporiginal);
		setsaveddvar("chaplincheat","0");
		if(!common_scripts\utility::flag("disable_slowmo_cheat"))
		{
			settimescale(1);
		}
	}

	applyvisionsets();
}

//Function Number: 32
chaplin_titlecard_create_background()
{
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("black",640,480);
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00.foreground = 1;
	var_00.sort = 0;
	return var_00;
}

//Function Number: 33
chaplin_titlecard_create_text(param_00)
{
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = -40;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.foreground = 1;
	var_01 settext(param_00);
	var_01.fontscale = 3;
	var_01.alpha = 1;
	var_01.sort = 1;
	var_01.color = (0.976,0.796,0.412);
	return var_01;
}

//Function Number: 34
chaplin_titlecard(param_00)
{
	if(getdvar("chaplincheat") != "1")
	{
		return;
	}

	if(getdvar("cheat_chaplin_titlecardshowing") == "1")
	{
		return;
	}

	if(common_scripts\utility::flag("disable_slowmo_cheat"))
	{
		return;
	}

	setdvar("cheat_chaplin_titlecardshowing",1);
	var_01 = chaplin_titlecard_create_background();
	var_02 = chaplin_titlecard_create_text(param_00);
	settimescale(0.05);
	wait(0.15);
	settimescale(1);
	var_01 destroy();
	var_02 destroy();
	setdvar("cheat_chaplin_titlecardshowing",0);
}

//Function Number: 35
chaplin_proc()
{
	level endon("disable_chaplin");
	soundscripts\_snd::snd_message("aud_start_ragtime_warfare");
	for(;;)
	{
		level.player shellshock("chaplincheat",60,1);
		wait(0.5);
		if(!common_scripts\utility::flag("disable_slowmo_cheat"))
		{
			if(getdvar("cheat_chaplin_titlecardshowing") == "1")
			{
				settimescale(0.05);
				continue;
			}

			settimescale(1.7);
		}
	}
}

//Function Number: 36
chaplin_grain_start()
{
	level.cheatgrainlooper = spawn("script_model",level.player geteye());
	level.cheatgrainlooper setmodel("tag_origin");
	level.cheatgrainlooper hide();
	playfxontag(level._effect["grain_test"],level.cheatgrainlooper,"tag_origin");
	thread chaplin_grain_proc();
}

//Function Number: 37
chaplin_grain_end()
{
	if(!isdefined(level.cheatgrainlooper))
	{
		return;
	}

	level.cheatgrainlooper delete();
}

//Function Number: 38
chaplin_grain_proc()
{
	level endon("disable_chaplin_grain");
	for(;;)
	{
		level.cheatgrainlooper.origin = level.player geteye() + 50 * anglestoforward(level.player getplayerangles());
		wait(0.01);
	}
}

//Function Number: 39
is_cheating()
{
	for(var_00 = 0;var_00 < level.cheatdvars.size;var_00++)
	{
		if(level.cheatstates[level.cheatdvars[var_00]])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
ragdoll_mode(param_00)
{
	level.cheat_super_ragdoll = common_scripts\utility::ter_op(param_00,1,0);
}

//Function Number: 41
melonhead_mode_init()
{
	level.melonhead_mode_enabled = 0;
	level.melonhead_mode_fx = loadfx("fx/props/watermelon");
	level.melonhead_mode_attachtag = "j_head";
	level.melonhead_mode_model = "me_fruit_watermelon_oblong";
	precachemodel(level.melonhead_mode_model);
	maps\_utility::add_global_spawn_function("axis",::melonhead_monitor);
	common_scripts\utility::array_thread(getaiarray("axis"),::melonhead_monitor);
}

//Function Number: 42
melonhead_mode_update(param_00)
{
	level.melonhead_mode_enabled = common_scripts\utility::ter_op(param_00,1,0);
	level notify("melonhead_mode_updated");
}

//Function Number: 43
melonhead_monitor()
{
	self endon("death");
	self notify("melonhead_monitor");
	self endon("melonhead_monitor");
	wait 0.05;
	if(isdefined(self.melonhead_ignore) && self.melonhead_ignore)
	{
		return;
	}

	for(;;)
	{
		if(level.melonhead_mode_enabled)
		{
			melonhead_add_melon();
		}
		else
		{
			melonhead_remove_melon();
		}

		level waittill("melonhead_mode_updated");
	}
}

//Function Number: 44
melonhead_add_melon()
{
	if(isremovedentity(self))
	{
		return;
	}

	if(isdefined(self.melonhead_disabled) && self.melonhead_disabled)
	{
		return;
	}

	if(isdefined(self.melonhead_attached))
	{
		return;
	}

	self attach(level.melonhead_mode_model,level.melonhead_mode_attachtag,1);
	self.melonhead_attached = 1;
	thread melonhead_detect_death();
	thread melonhead_detect_hit();
}

//Function Number: 45
melonhead_remove_melon(param_00,param_01)
{
	if(isremovedentity(self))
	{
		return;
	}

	if(isdefined(param_01) && param_01)
	{
		self.melonhead_disabled = 1;
	}

	if(!isdefined(self.melonhead_attached))
	{
		return;
	}

	self detach(level.melonhead_mode_model,level.melonhead_mode_attachtag);
	self.melonhead_attached = undefined;
	if(isdefined(param_00) && param_00)
	{
		playfx(level.melonhead_mode_fx,self gettagorigin(level.melonhead_mode_attachtag),anglestoforward(self.angles));
		thread common_scripts\utility::play_sound_in_space("h1_hit_watermelon",self gettagorigin(level.melonhead_mode_attachtag));
	}

	self notify("melonhead_removed");
}

//Function Number: 46
melonhead_detect_death()
{
	self endon("melonhead_removed");
	self waittill("death");
	melonhead_remove_melon(1);
}

//Function Number: 47
melonhead_detect_hit()
{
	self endon("melonhead_removed");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isdefined(self.damagelocation))
		{
			continue;
		}

		if((self.damagelocation == "head" || self.damagelocation == "helmet") && var_04 != "MOD_IMPACT")
		{
			melonhead_remove_melon(1);
			break;
		}
	}
}

//Function Number: 48
handgun_mode_init()
{
	level.cheat_handgun = 0;
	level.cheat_handgun_weaponname = "h1_cheathandgun";
	level.cheat_handgun_currentweapon = undefined;
	precacheitem(level.cheat_handgun_weaponname);
	level waittill("load_finished");
}

//Function Number: 49
handgun_mode_update(param_00)
{
	if(level.script == "ac130")
	{
		return;
	}

	level.cheat_handgun = common_scripts\utility::ter_op(param_00,1,0);
	level notify("handgun_mode_updated");
	if(level.cheat_handgun)
	{
		givehandgun();
		return;
	}

	takehandgun();
}

//Function Number: 50
handgun_monitor()
{
	self endon("handgun_removed");
	self endon("death");
	for(;;)
	{
		if(level.player issplitscreenplayer() == 1 && level.player getcurrentweapon() == level.cheat_handgun_weaponname)
		{
			level.player maps\_utility::playerallowweaponpickup(0,"cheat_handgun");
		}
		else if(level.player issplitscreenplayer() == 0 && level.player getcurrentweapon() != level.cheat_handgun_weaponname)
		{
			level.player maps\_utility::playerallowweaponpickup(1,"cheat_handgun");
		}

		wait(0.05);
	}
}

//Function Number: 51
handgun_monitor_reload()
{
	self endon("handgun_removed");
	self endon("death");
	for(;;)
	{
		if(level.player isreloading())
		{
			level.player givemaxammo(level.cheat_handgun_weaponname);
			level.player setweaponammoclip(level.cheat_handgun_weaponname,weaponclipsize(level.cheat_handgun_weaponname));
		}

		wait(0.05);
	}
}

//Function Number: 52
givehandgun()
{
	level.cheat_handgun_currentweapon = level.player getcurrentweapon();
	level.player giveweapon(level.cheat_handgun_weaponname);
	level.player givemaxammo(level.cheat_handgun_weaponname);
	level.player switchtoweaponimmediate(level.cheat_handgun_weaponname);
	thread handgun_monitor();
	thread handgun_monitor_reload();
}

//Function Number: 53
takehandgun()
{
	if(level.player issplitscreenplayer() == 0)
	{
		level.player maps\_utility::playerallowweaponpickup(1,"cheat_handgun");
	}

	var_00 = level.player getcurrentweapon();
	var_01 = 0;
	if(var_00 == level.cheat_handgun_weaponname && level.cheat_handgun_currentweapon != "none")
	{
		var_02 = level.player getweaponslistall();
		foreach(var_04 in var_02)
		{
			if(var_04 == level.cheat_handgun_currentweapon)
			{
				level.player switchtoweaponimmediate(var_04);
				var_01 = 1;
				break;
			}
		}

		if(!var_01 && var_02.size > 0)
		{
			level.player switchtoweaponimmediate(var_02[0]);
		}
	}

	level.player takeweapon(level.cheat_handgun_weaponname);
	self notify("handgun_removed");
}

//Function Number: 54
lemonade_mode_init()
{
	level.cheat_lemonade = 0;
	level.cheat_lemonade_weaponname = "h1_cheatlemonade";
	level.cheat_lemonade_currentlethal = undefined;
	precacheitem(level.cheat_lemonade_weaponname);
	level waittill("load_finished");
}

//Function Number: 55
lemonade_mode_update(param_00)
{
	level.cheat_lemonade = common_scripts\utility::ter_op(param_00,1,0);
	if(level.cheat_lemonade)
	{
		givelemonade();
		return;
	}

	takelemonade();
}

//Function Number: 56
givelemonade()
{
	level.cheat_lemonade_currentlethal = level.player getoffhandprimaryclass();
	if(isdefined(level.cheat_lemonade_currentlethal) && level.cheat_lemonade_currentlethal != "none")
	{
		var_00 = level.player getweaponammoclip(level.cheat_lemonade_currentlethal);
		level.player takeweapon(level.cheat_lemonade_currentlethal);
		level.player setoffhandprimaryclass(level.cheat_lemonade_weaponname);
		level.player giveweapon(level.cheat_lemonade_weaponname);
		level.player setweaponammoclip(level.cheat_lemonade_weaponname,var_00);
	}
}

//Function Number: 57
takelemonade()
{
	var_00 = level.player getweaponammoclip(level.cheat_lemonade_weaponname);
	level.player takeweapon(level.cheat_lemonade_weaponname);
	if(isdefined(level.cheat_lemonade_currentlethal))
	{
		level.player setoffhandprimaryclass(level.cheat_lemonade_currentlethal);
		level.player giveweapon(level.cheat_lemonade_currentlethal);
		level.player setweaponammoclip(level.cheat_lemonade_currentlethal,var_00);
	}
}

//Function Number: 58
tracksuit_mode_init()
{
	level.tracksuit_mode_enabled = 0;
	if(level.script == "ac130")
	{
		level.tracksuit_mode_model = "body_zakhaev_viktor_collar_ac130";
		level.tracksuit_mode_head = "head_zakhaev_viktor_ac130";
	}
	else
	{
		level.tracksuit_mode_model = "body_zakhaev_viktor_collar";
		level.tracksuit_mode_head = "head_zakhaev_viktor";
	}

	level.tracksuit_mode_weapon = "rpg";
	precachemodel(level.tracksuit_mode_model);
	precachemodel(level.tracksuit_mode_head);
	precacheitem(level.tracksuit_mode_weapon);
	precacheitem("rpg_player");
	maps\_utility::add_global_spawn_function("axis",::tracksuit_monitor);
	common_scripts\utility::array_thread(getaiarray("axis"),::tracksuit_monitor);
}

//Function Number: 59
tracksuit_mode_update(param_00)
{
	level.tracksuit_mode_enabled = common_scripts\utility::ter_op(param_00,1,0);
	level notify("tracksuit_mode_updated");
}

//Function Number: 60
tracksuit_monitor()
{
	self endon("death");
	wait 0.05;
	if(isdefined(self.tracksuit_ignore) && self.tracksuit_ignore)
	{
		return;
	}

	if(isdefined(self.animtree) && self.animtree == "dog.atr")
	{
		return;
	}

	for(;;)
	{
		if(level.tracksuit_mode_enabled)
		{
			add_tracksuit();
		}
		else
		{
			remove_tracksuit();
		}

		level waittill("tracksuit_mode_updated");
	}
}

//Function Number: 61
add_tracksuit()
{
	if(isremovedentity(self))
	{
		return;
	}

	self.tracksuitmode = 1;
	if(isdefined(self.weapon) && !isdefined(self.ignoreweaponintracksuitmode) && self.classname != "script_model")
	{
		if(isdefined(self.a) && isdefined(self.a.aimidlethread))
		{
			animscripts\combat_utility::endfireandanimidlethread();
		}

		self.tracksuitmode_previousprimary = animscripts\utility::getaiprimaryweapon();
		var_00 = tracksuit_should_equipweapon();
		maps\_utility::forceuseweapon(level.tracksuit_mode_weapon,"primary");
		if(!var_00)
		{
			maps\_utility::gun_remove();
		}

		self.tracksuitmode_previousneverlean = self.a.neverlean;
		self.a.neverlean = 1;
		self.tracksuitmode_previousrocketvisible = self.a.rocketvisible;
		self.a.rocketvisible = 1;
		thread animscripts\shared::rpgplayerrepulsor();
		self.primaryweapon = level.tracksuit_mode_weapon;
		self.weapon = level.tracksuit_mode_weapon;
		self.lastweapon = level.tracksuit_mode_weapon;
		self.tracksuitmode_previoussecondary = self.secondaryweapon;
		self.secondaryweapon = "none";
	}

	if(self.model == level.tracksuit_mode_model || self.model == "body_zakhaev_viktor")
	{
		return;
	}

	if(isdefined(self.hatmodel))
	{
		self.tracksuitmode_previoushatmodel = self.hatmodel;
		self detach(self.hatmodel);
		self.hatmodel = undefined;
	}

	if(isdefined(self.headmodel))
	{
		self.tracksuitmode_previousheadmodel = self.headmodel;
		self detach(self.headmodel);
	}

	self.tracksuitmode_previousmodel = self.model;
	self setmodel(level.tracksuit_mode_model);
	self attach(level.tracksuit_mode_head);
	self.headmodel = level.tracksuit_mode_head;
}

//Function Number: 62
remove_tracksuit()
{
	if(isremovedentity(self))
	{
		return;
	}

	if(!isdefined(self.tracksuitmode))
	{
		return;
	}

	if(isdefined(self.tracksuitmode_previousmodel))
	{
		self detach(self.headmodel);
		self.headmodel = undefined;
		self setmodel(self.tracksuitmode_previousmodel);
		self.tracksuitmode_previousmodel = undefined;
	}

	if(isdefined(self.tracksuitmode_previousheadmodel))
	{
		self attach(self.tracksuitmode_previousheadmodel);
		self.headmodel = self.tracksuitmode_previousheadmodel;
		self.tracksuitmode_previousheadmodel = undefined;
	}

	if(isdefined(self.tracksuitmode_previoushatmodel))
	{
		self attach(self.tracksuitmode_previoushatmodel);
		self.hatmodel = self.tracksuitmode_previoushatmodel;
		self.tracksuitmode_previoushatmodel = undefined;
	}

	if(isdefined(self.tracksuitmode_previousprimary) && !isdefined(self.ignoreweaponintracksuitmode))
	{
		if(isdefined(self.a) && isdefined(self.a.aimidlethread))
		{
			animscripts\combat_utility::endfireandanimidlethread();
		}

		if(tracksuit_should_equipweapon())
		{
			maps\_utility::forceuseweapon(self.tracksuitmode_previousprimary,"primary");
		}

		self.secondaryweapon = self.tracksuitmode_previoussecondary;
		self.a.neverlean = self.tracksuitmode_previousneverlean;
		self.a.rocketvisible = self.tracksuitmode_previousrocketvisible;
	}

	self.tracksuitmode = 0;
	self notify("tracksuit_removed");
}

//Function Number: 63
tracksuit_should_equipweapon()
{
	foreach(var_01 in self.weaponinfo)
	{
		if(var_01.position != "none")
		{
			return 1;
		}
	}

	return 0;
}