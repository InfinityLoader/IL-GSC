/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_raid_ss_serum_util.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 392 ms
 * Timestamp: 10/27/2023 3:12:10 AM
*******************************************************************/

//Function Number: 1
serumhadperk(param_00)
{
	if(isdefined(self.raidpreserumperkslist[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
serumcreateoverlay(param_00)
{
	var_01 = newclienthudelem(self);
	var_01.maxsightdistsqrd = 0;
	var_01.var_1D7 = 0;
	var_01.ignoreme = -5;
	var_01.var_C6 = "fullscreen";
	var_01.var_1CA = "fullscreen";
	var_01 setshader(param_00,640,480);
	var_01.var_C2 = 1;
	var_01.var_180 = 0;
	var_01.var_18 = 1;
	return var_01;
}

//Function Number: 3
serumtimerupdate(param_00)
{
	self endon("force_stop_serum");
	self endon("disconnect");
	self endon("death");
	self setclientomnvar("serum_active_percent",1);
	self setclientomnvar("serum_active_streakIndex",self.lastusedkillstreakslotindex);
	self.currenttimervalue = param_00;
	self waittill("altered_state_start");
	while(self.currenttimervalue > 0)
	{
		self.currenttimervalue = self.currenttimervalue - 0.15;
		self setclientomnvar("serum_active_percent",max(0,self.currenttimervalue - 0.15 / param_00));
		maps\mp\gametypes\_hostmigration::func_A6F5(0.15);
	}

	self setclientomnvar("serum_active_percent",0);
	self setclientomnvar("serum_active_streakIndex",-1);
	maps\mp\killstreaks\_killstreaks::func_A170();
	self notify("serum_finished");
}

//Function Number: 4
altered_state_apply(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	level endon("game_ended");
	var_06 endon("disconnect");
	var_06 endon("death");
	if(common_scripts\utility::func_562E(var_06.in_altered_state))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 30;
	}

	if(!isdefined(param_02))
	{
		param_02 = "blue";
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.25;
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	var_06 notify("altered_state_apply");
	var_06 thread altered_state_death_listener();
	var_06 thread altered_state_game_end_listener();
	var_06 thread altered_state_activate(param_03,param_04,param_05,param_02);
	var_06 waittill("altered_state_start");
	if(!common_scripts\utility::func_562E(param_00))
	{
		var_06.altered_state_duration = param_01;
		wait(var_06.altered_state_duration - param_03);
		var_06 altered_state_deactivate(param_03,param_04,param_05,param_02);
	}
}

//Function Number: 5
altered_state_start(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_04 altered_state_start_fx(param_03);
	var_04.in_altered_state = 1;
	var_04.altered_state_start_time = gettime() * 0.001;
	var_04 notify("altered_state_start");
}

//Function Number: 6
altered_state_end()
{
	var_00 = self;
	var_00 altered_state_kill_fx();
	var_00.in_altered_state = 0;
	var_00.altered_state_start_time = undefined;
	var_00 notify("altered_state_end");
}

//Function Number: 7
altered_state_death_listener()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00 waittill("death");
	var_00 altered_state_end();
	var_00 altered_state_hide_client_overlay();
}

//Function Number: 8
altered_state_game_end_listener()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00 endon("death");
	var_00 endon("altered_state_end");
	level waittill("game_ended");
	var_00 altered_state_end();
	var_00 altered_state_hide_client_overlay();
}

//Function Number: 9
altered_state_activate(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_04 endon("death");
	var_04 endon("disconnect");
	level endon("game_ended");
	var_04 altered_state_fade_in(param_00,param_02);
	var_04 altered_state_start(param_00,param_01,param_02,param_03);
	var_04 altered_state_fade_out(param_01,param_02);
	var_04 notify("altered_state_active");
}

//Function Number: 10
altered_state_deactivate(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_04 endon("death");
	var_04 endon("disconnect");
	level endon("game_ended");
	lib_0378::func_8D74("aud_serum_buff_end");
	var_04 altered_state_fade_in(param_00,param_02);
	var_04 altered_state_end();
	var_04 altered_state_fade_out(param_01,param_02);
	var_04 altered_state_hide_client_overlay();
	var_04 notify("altered_state_inactive");
}

//Function Number: 11
altered_state_fade_in(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	var_02 endon("disconnect");
	level endon("game_ended");
	if(!maps\mp\_utility::func_57A0(var_02))
	{
		return;
	}

	if(!isdefined(var_02.altered_state_overlay_fade))
	{
		var_02.altered_state_overlay_fade = altered_state_create_client_overlay("white",param_01,var_02);
	}

	var_02.altered_state_overlay_fade.var_18 = 0;
	var_02.altered_state_overlay_fade fadeovertime(param_00);
	var_02.altered_state_overlay_fade.var_18 = param_01;
	wait(param_00);
}

//Function Number: 12
altered_state_fade_out(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	var_02 endon("disconnect");
	level endon("game_ended");
	if(!maps\mp\_utility::func_57A0(var_02))
	{
		return;
	}

	if(!isdefined(var_02.altered_state_overlay_fade))
	{
		return;
	}

	var_02.altered_state_overlay_fade.var_18 = param_01;
	var_02.altered_state_overlay_fade fadeovertime(param_00);
	var_02.altered_state_overlay_fade.var_18 = 0;
	wait(param_00);
}

//Function Number: 13
altered_state_create_client_overlay(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	if(isdefined(param_02))
	{
		var_05 = newclienthudelem(param_02);
	}
	else
	{
		var_05 = newhudelem();
	}

	var_05.maxsightdistsqrd = 0;
	var_05.var_1D7 = 0;
	var_05 setshader(param_00,640,480);
	var_05.accuracy = "left";
	var_05.var_11 = "top";
	var_05.ignoreme = 1;
	var_05.var_C6 = "fullscreen";
	var_05.var_1CA = "fullscreen";
	var_05.var_18 = param_01;
	var_05.var_A0 = var_04;
	return var_05;
}

//Function Number: 14
altered_state_hide_client_overlay()
{
	var_00 = self;
	if(isdefined(var_00.altered_state_overlay_fade))
	{
		var_00.altered_state_overlay_fade.var_18 = 0;
	}
}

//Function Number: 15
altered_state_start_fx(param_00)
{
	var_01 = self;
	switch(param_00)
	{
		case "green":
			var_02 = "mp_dlc4_1st_person_serum_green";
			var_03 = "mp_dlc4_3rd_person_serum_green";
			break;

		case "purple":
			var_02 = "mp_dlc4_1st_person_serum_purple";
			var_03 = "mp_dlc4_3rd_person_serum_purple";
			break;

		case "orange":
			var_02 = "mp_dlc4_1st_person_serum_orange";
			var_03 = "mp_dlc4_3rd_person_serum_orange";
			break;

		default:
			var_02 = "mp_dlc4_1st_person_serum_blue";
			var_03 = "mp_dlc4_3rd_person_serum_blue";
			break;
	}

	if(isdefined(var_01) && maps\mp\_utility::func_57A0(var_01))
	{
		var_01.altered_state_fx = spawnlinkedfxforclient(common_scripts\utility::func_44F5(var_02),var_01,"tag_origin",var_01);
		function_014E(var_01.altered_state_fx,1);
		triggerfx(var_01.altered_state_fx);
		var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.altered_state_fx);
		if(0)
		{
			var_01.altered_state_fx_3rd = spawnlinkedfx(common_scripts\utility::func_44F5(var_03),var_01,"tag_origin");
			triggerfx(var_01.altered_state_fx_3rd);
			var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_01.altered_state_fx_3rd);
		}
	}
}

//Function Number: 16
altered_state_kill_fx()
{
	var_00 = self;
	if(isdefined(var_00.altered_state_fx))
	{
		var_00.altered_state_fx delete();
	}

	if(isdefined(var_00.altered_state_fx_3rd))
	{
		var_00.altered_state_fx_3rd delete();
	}
}

//Function Number: 17
pickupisserum(param_00)
{
	return param_00 == "raid_ss_serum_a" || param_00 == "raid_ss_serum_b" || param_00 == "raid_ss_serum_c";
}

//Function Number: 18
handleserumpickup(param_00)
{
	var_01 = 1;
	if(common_scripts\utility::func_562E(param_00.raidserumactive) && !common_scripts\utility::func_562E(param_00.basictrainingserumactive))
	{
		param_00 iclientprintlnbold(&"KILLSTREAKS_DLC4_ONE_SERUM_AT_A_TIME");
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 19
handledisableserumonpickup(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(common_scripts\utility::func_562E(param_01.basictrainingserumactive))
	{
		var_02 = param_01 getserumkillstreakslot(param_00);
		param_01 disableserum(var_02);
	}
}

//Function Number: 20
getserumkillstreakslot(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	for(var_05 = 0;var_05 < self.var_12C["killstreaks"].size;var_05++)
	{
		if(isdefined(self.var_12C["killstreaks"][var_05]) && isdefined(self.var_12C["killstreaks"][var_05].var_944C))
		{
			if(self.var_12C["killstreaks"][var_05].var_944C == param_00 || (isdefined(param_01) && self.var_12C["killstreaks"][var_05].var_944C == param_01) || (isdefined(param_02) && self.var_12C["killstreaks"][var_05].var_944C == param_02) || isdefined(param_03) && self.var_12C["killstreaks"][var_05].var_944C == param_03)
			{
				var_04 = var_05;
				break;
			}
		}
	}

	return var_04;
}

//Function Number: 21
disableserumdeathlistener(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self.var_12C["killstreaks"][param_00].var_13AF = 1;
	maps\mp\killstreaks\_killstreaks::func_A170();
}

//Function Number: 22
disableserum(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	thread disableserumdeathlistener(param_00);
	self.var_12C["killstreaks"][param_00].var_13AF = 0;
	maps\mp\killstreaks\_killstreaks::func_A170();
	self waittill("serum_finished");
	self.var_12C["killstreaks"][param_00].var_13AF = 1;
	maps\mp\killstreaks\_killstreaks::func_A170();
}