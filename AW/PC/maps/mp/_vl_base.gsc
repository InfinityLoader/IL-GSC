/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_vl_base.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 460 ms
 * Timestamp: 4/22/2024 2:16:44 AM
*******************************************************************/

//Function Number: 1
vlprint(param_00)
{
}

//Function Number: 2
vlprintln(param_00)
{
}

//Function Number: 3
vl_init()
{
	level.vl_onspawnplayer = ::onspawnplayer;
	vl_main();
}

//Function Number: 4
vl_main()
{
	setdvar("r_dof_physical_enable",1);
	setdvar("r_dof_physical_bokehEnable",1);
	setdvar("r_adaptiveSubdiv",0);
	setdvar("r_eyePupil",0.15);
	setdvar("r_uiblurdstmode",3);
	setdvar("r_blurdstgaussianblurradius",1.5);
	resetentplayerxuidforemblems();
	level.partymembers_cb = ::maps\mp\_vl_camera::party_members;
	level.vlavatars = [];
	level.xuid2ownerid = [];
	level.vl_focus = 0;
	level.avatarinfo = [];
	level.vfx_setbonus_crouch_01 = loadfx("vfx/ui/complete_set_crouching");
	level.vfx_setbonus_stand_01 = loadfx("vfx/ui/complete_set_standing");
	var_00 = 18;
	if(level.ps3 || level.xenon)
	{
		var_00 = 12;
	}

	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.avatarinfo[var_01] = spawnstruct();
		level.avatarinfo[var_01].timetodelete = 0;
		level.avatarinfo[var_01].xuid = "";
	}

	level.maxavatars = var_00;
	thread maps\mp\_vl_camera::monitor_member_class_changes();
	thread maps\mp\_vl_camera::monitor_member_timeouts();
	setdvar("virtuallobbymembers",0);
	level.num_lobby_idles = 4;
	maps\mp\_vl_firingrange::init_firingrange();
	maps\mp\_vl_selfiebooth::init_selfiebooth();
}

//Function Number: 5
init_avatars()
{
	var_00 = 4;
	var_01 = level.maxavatars + var_00;
	level.vlavatarpool = [];
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = maps\mp\agents\_agent_utility::getfreeagent();
		level.vlavatarpool[var_02] = var_03;
		var_03 spawnagent((0,0,0),(0,0,0));
		var_03 maps\mp\_vl_camera::set_agent_values("spectator","none");
		var_03 maps\mp\agents\_agent_common::set_agent_health(100);
		var_03 botclearscriptenemy();
		var_03 botclearscriptgoal();
		var_03 maps\mp\_vl_camera::bot_disable_tactical_goals();
		var_03 botsetflag("disable_movement",1);
		var_03 botsetflag("disable_rotation",1);
		var_03.isfree = 1;
	}
}

//Function Number: 6
alloc_avatar()
{
	if(!isdefined(level.vlavatarpool))
	{
		init_avatars();
	}

	foreach(var_01 in level.vlavatarpool)
	{
		if(var_01.isfree)
		{
			var_01.isfree = 0;
			return var_01;
		}
	}
}

//Function Number: 7
free_avatar(param_00)
{
	param_00 notify("free_avatar");
	param_00.isfree = 1;
}

//Function Number: 8
onspawnplayer()
{
	level.agent_funcs["player"]["on_killed"] = ::on_agent_player_killed;
	thread maps\mp\_vl_camera::vlobby_player();
	level.playerstatus[0] = 3;
	thread maps\mp\_vl_camera::monitor_member_focus_change();
	thread maps\mp\_vl_camera::monitor_create_an_operator(0);
	thread maps\mp\_vl_camera::monitor_create_a_class(0);
	thread maps\mp\_vl_camera::monitor_clans();
	thread monitor_move_btn_fr_vl(self);
	disable_player_controls();
	self setdemigod(1);
	self setmlgspectator(0);
}

//Function Number: 9
on_agent_player_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
}

//Function Number: 10
player_sticks_in_lefty_config()
{
	if(common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 = self getlocalplayerprofiledata("gpadSticksConfig");
		return isdefined(var_00) && var_00 == "thumbstick_southpaw" || var_00 == "thumbstick_legacy";
	}

	return 0;
}

//Function Number: 11
player_setup_lefty_angle(param_00)
{
	if(!isdefined(param_00.fakeangle))
	{
		if(isdefined(param_00.storedrightsticky))
		{
			param_00.fakeangle = param_00.storedrightsticky;
			return;
		}

		param_00.fakeangle = 0;
	}
}

//Function Number: 12
player_get_right_stick_y(param_00)
{
	if(player_sticks_in_lefty_config())
	{
		player_setup_lefty_angle(param_00);
		return param_00.fakeangle;
	}

	var_01 = self getunnormalizedcameramovement();
	return var_01[1];
}

//Function Number: 13
player_update_right_stick_y(param_00)
{
	var_01 = 0;
	if(player_sticks_in_lefty_config())
	{
		player_setup_lefty_angle(param_00);
		var_02 = self getnormalizedmovement();
		var_03 = -12;
		var_04 = var_02[1] * var_03;
		param_00.fakeangle = angleclamp(param_00.fakeangle + var_04);
		var_01 = param_00.fakeangle;
	}
	else
	{
		var_02 = self getunnormalizedcameramovement();
		var_01 = var_02[1];
		if(isdefined(param_00.fakeangle))
		{
			param_00.fakeangle = undefined;
		}
	}

	return var_01;
}

//Function Number: 14
prep_for_controls(param_00,param_01)
{
	param_00.storedrightsticky = player_get_right_stick_y(param_00);
	param_00.rotation_total = 0;
	param_00.storedangley = param_00.angles[1];
	param_00.mouserot = 0;
	param_00.positivewrap = 0;
	param_00.negativewrap = 0;
	param_00.addtobaseangle = 0;
	param_01 = (0,param_01[1],0);
	if(isdefined(param_01))
	{
		if(isagent(param_00))
		{
			param_00 maps\mp\_vl_camera::hackagentangles(param_01);
			return;
		}

		param_00.angles = param_01;
	}
}

//Function Number: 15
avatar_scheduled_for_removal(param_00)
{
	return level.avatarinfo[param_00].timetodelete > 0;
}

//Function Number: 16
schedule_remove_avatar(param_00,param_01)
{
	maps\mp\_vl_camera::remove_avatar(param_00);
}

//Function Number: 17
all_avatars_scheduled_for_delete()
{
	if(level.vlavatars.size == 0)
	{
		return 0;
	}

	foreach(var_02, var_01 in level.avatarinfo)
	{
		if(!isdefined(level.vlavatars[var_02]))
		{
			continue;
		}

		if(var_01.timetodelete == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 18
reuse_avatar(param_00)
{
	var_01 = undefined;
	foreach(var_04, var_03 in level.xuid2ownerid)
	{
		var_01 = level.vlavatars[var_03];
		level.vlavatars[var_03] = undefined;
		setentplayerxuidforemblem(var_01,var_04,1);
		level.xuid2ownerid[var_04] = undefined;
	}

	level.xuid2ownerid[param_00] = 0;
	level.avatarinfo[0].timetodelete = 0;
	level.avatarinfo[0].xuid = param_00;
	if(isdefined(var_01))
	{
		setentplayerxuidforemblem(var_01,param_00);
		level.vlavatars[0] = var_01;
	}
}

//Function Number: 19
add_avatar(param_00)
{
	var_01 = -1;
	var_02 = -1;
	while(var_02 == var_01)
	{
		var_01++;
		foreach(var_02 in level.xuid2ownerid)
		{
			if(var_02 == var_01)
			{
				break;
			}
		}
	}

	vlprint("Adding new xuid " + param_00 + " with ownerId=" + var_01 + "\n");
	level.xuid2ownerid[param_00] = var_01;
	level.avatarinfo[var_01].xuid = param_00;
	level.avatarinfo[var_01].timetodelete = 0;
	return var_01;
}

//Function Number: 20
avatar_after_spawn(param_00)
{
	if(isdefined(level.needtopresent))
	{
		thread maps\mp\_vl_camera::setvirtuallobbypresentable();
	}
}

//Function Number: 21
update_avatars()
{
	var_00 = 0;
	foreach(var_03, var_02 in level.avatarinfo)
	{
		if(var_02.timetodelete > 0 && gettime() > var_02.timetodelete)
		{
			vlprint("update_avatars removing ownerId" + var_03 + "\n");
			maps\mp\_vl_camera::remove_avatar(var_03);
			var_00 = 1;
		}
	}

	if(var_00)
	{
		wait(0.1);
	}
}

//Function Number: 22
hide_non_owner_avatars()
{
	foreach(var_02, var_01 in level.vlavatars)
	{
		if(var_02 == 0)
		{
			continue;
		}

		maps\mp\_vl_camera::hide_avatar(var_01);
	}

	if(level.camparams.mode != "prelobby")
	{
		level.camparams.camera.cut = 1;
	}

	level.vl_focus = 0;
	level.old_vl_focus = level.vl_focus;
}

//Function Number: 23
show_non_owner_avatars()
{
	foreach(var_02, var_01 in level.vlavatars)
	{
		if(var_02 == 0)
		{
			continue;
		}

		maps\mp\_vl_camera::show_avatar(var_01);
	}
}

//Function Number: 24
rightstickrotateavatar(param_00,param_01)
{
	var_02 = player_update_right_stick_y(param_00);
	var_03 = angleclamp(var_02 - param_00.storedrightsticky);
	var_04 = getdvarfloat("ui_mouse_char_rot",0);
	if(var_04 != 0)
	{
		param_00.mouserot = angleclamp(param_00.mouserot + var_04);
		setdynamicdvar("ui_mouse_char_rot",0);
	}

	var_05 = maps\mp\_vl_camera::getmodifiedrotationangle(param_00,var_03,param_01);
	var_05 = var_05 * -1;
	var_06 = angleclamp(param_00.storedangley + var_05 + param_00.mouserot);
	var_07 = (0,var_06,0);
	if(isagent(param_00))
	{
		param_00 setplayerangles(var_07);
		return;
	}

	param_00.angles = var_07;
}

//Function Number: 25
playerhastouchedstick(param_00)
{
	var_01 = player_get_right_stick_y(param_00);
	var_02 = angleclamp(var_01 - param_00.storedrightsticky);
	if(self.hastouchedstick == 0)
	{
		if(abs(var_02) >= 1)
		{
			param_00.storedangley = param_00.angles[1];
			return 1;
		}

		return 0;
	}

	return 1;
}

//Function Number: 26
disable_player_controls()
{
	self notify("kill_enable_weapons");
	self allowfire(0);
}

//Function Number: 27
enable_player_controls()
{
	self endon("enter_lobby");
	self endon("kill_enable_weapons");
	var_00 = getdvarint("virtualLobbyInFiringRange",0);
	if(var_00 == 1 && level.in_firingrange == 1)
	{
		self allowfire(1);
	}
}

//Function Number: 28
enter_vlobby(param_00)
{
	maps\mp\_vl_firingrange::deactivate_targets();
	var_01 = param_00.camera;
	param_00 setorigin(var_01.origin);
	param_00 playerlinkto(var_01,"tag_player");
	param_00 cameralinkto(var_01,"tag_player");
	param_00 setclientdvar("cg_fovscale","0.6153");
	param_00 visionsetnakedforplayer("mp_virtual_lobby_cac",0);
	if(isdefined(level.vlavatars) && isdefined(level.old_vl_focus) && isdefined(level.vlavatars[level.old_vl_focus]))
	{
		param_00 prep_for_controls(level.vlavatars[level.old_vl_focus],level.vlavatars[level.old_vl_focus].angles);
	}

	level.in_firingrange = 0;
	param_00 allowfire(0);
	maps\mp\_utility::updatesessionstate("spectator");
}

//Function Number: 29
monitor_move_btn_fr_vl(param_00)
{
	for(;;)
	{
		if(isdefined(level.in_firingrange))
		{
			var_01 = getdvarint("virtualLobbyInFiringRange",0);
			if(var_01 == 1 && !level.in_firingrange)
			{
				var_02 = maps\mp\_utility::getclassindex("lobby" + param_00.currentselectedclass + 1);
				var_03 = maps\mp\_utility::cac_getcustomclassloc();
				var_04 = param_00.loadouts[var_03][var_02];
				var_05 = var_04["primary"];
				var_06 = var_04["secondary"];
				if(isdefined(level.vlavatars) && isdefined(level.old_vl_focus) && isdefined(level.vlavatars[level.old_vl_focus]))
				{
					param_00 prep_for_controls(level.vlavatars[level.old_vl_focus],level.vlavatars[level.old_vl_focus].angles);
				}

				var_07 = [];
				if(isdefined(var_05) && var_05 != "specialty_null")
				{
					var_07[var_07.size] = maps\mp\gametypes\_class::buildweaponname(var_05,var_04["primaryAttachment1"],var_04["primaryAttachment2"],var_04["primaryAttachment3"],0,0);
				}

				if(isdefined(var_06) && var_06 != "specialty_null")
				{
					var_07[var_07.size] = maps\mp\gametypes\_class::buildweaponname(var_06,var_04["secondaryAttachment1"],var_04["secondaryAttachment2"],var_04["secondaryAttachment3"],0,0);
				}

				while(var_07.size > 0)
				{
					var_08 = param_00 loadweapons(var_07);
					if(var_08 == 1)
					{
						break;
					}

					wait(0.05);
				}

				param_00 showviewmodel();
				maps\mp\_vl_firingrange::enter_firingrange(param_00);
				param_00 clientclearsoundsubmix("mp_no_foley",1);
				setdvar("r_dof_physical_bokehEnable",0);
				setdvar("r_dof_physical_enable",0);
				setdvar("r_uiblurdstmode",0);
				setdvar("r_blurdstgaussianblurradius",1);
			}
			else if(var_01 == 0 && level.in_firingrange)
			{
				param_00 hideviewmodel();
				param_00 firingrangecleanup();
				param_00 disable_player_controls();
				if(isdefined(param_00.primaryweapon))
				{
					param_00 switchtoweapon(param_00.primaryweapon);
				}

				param_00 notify("enter_lobby");
				enter_vlobby(param_00);
				param_00 clientaddsoundsubmix("mp_no_foley",1);
				setdvar("r_dof_physical_enable",1);
				setdvar("r_dof_physical_bokehEnable",1);
				setdvar("r_uiblurdstmode",3);
				setdvar("r_blurdstgaussianblurradius",1.5);
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
firingrangecleanup()
{
	var_00 = self;
	var_00 maps\mp\_vl_firingrange::grenadecleanup();
	var_00 thread maps\mp\_vl_firingrange::riotshieldcleanup();
	var_01 = var_00 getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		var_00 maps\mp\gametypes\_class::takeoffhand(var_03);
	}
}