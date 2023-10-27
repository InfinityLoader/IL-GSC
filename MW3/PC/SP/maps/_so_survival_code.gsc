/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_code.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 818 ms
 * Timestamp: 10/27/2023 2:21:05 AM
*******************************************************************/

//Function Number: 1
remotemissile_infantry_kills_dialogue_setup()
{
	level.scr_radio["inv_hqr_fivenotenkills"] = "inv_hqr_fivenotenkills";
	level.scr_radio["inv_hqr_tenmoreconfirms"] = "inv_hqr_tenmoreconfirms";
	level.scr_radio["inv_hqr_tenpluskia"] = "inv_hqr_tenpluskia";
	level.scr_radio["inv_hqr_fiveplus"] = "inv_hqr_fiveplus";
	level.scr_radio["inv_hqr_another5plus"] = "inv_hqr_another5plus";
	level.scr_radio["inv_hqr_morethanfive"] = "inv_hqr_morethanfive";
	level.scr_radio["inv_hqr_yougotem"] = "inv_hqr_yougotem";
	level.scr_radio["inv_hqr_goodkills"] = "inv_hqr_goodkills";
	level.scr_radio["inv_hqr_directhit"] = "inv_hqr_directhit";
	level.scr_radio["inv_hqr_hesdown"] = "inv_hqr_hesdown";
}

//Function Number: 2
remotemissile_infantry_kills_dialogue()
{
	var_00 = [];
	var_01 = 0;
	var_02 = [];
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	level.enemies_killed = 0;
	var_06 = 0;
	for(;;)
	{
		level waittill("inv_hqr_tenpluskia",var_7B[var_00.size],"inv_hqr_tenmoreconfirms",var_7B[var_7B.size],"inv_hqr_fivenotenkills",var_7B[var_7B.size],"inv_hqr_fiveplus",var_7B[var_02.size],"inv_hqr_another5plus",var_7B[var_02.size],"inv_hqr_morethanfive",var_7B[var_02.size],"remote_missile_exploded");
		var_07 = level.enemies_killed;
		wait 0.1;
		if(isdefined(level.uav_killstats["ai"]))
		{
			var_06 = level.uav_killstats["ai"];
		}

		if(var_06 == 0)
		{
			continue;
		}

		wait 0.5;
		if(isdefined(level.uav_is_destroyed))
		{
			return;
		}

		if(var_06 == 1)
		{
			if(var_04)
			{
				maps\_utility::radio_dialogue("inv_hqr_yougotem");
				var_04 = 0;
			}
			else
			{
				maps\_utility::radio_dialogue("inv_hqr_hesdown");
				var_04 = 1;
			}

			continue;
		}

		if(var_06 >= 10)
		{
			maps\_utility::radio_dialogue(var_7B[var_01]);
			var_01++;
			if(var_01 >= var_7B.size)
			{
				var_01 = 0;
			}

			continue;
		}

		if(var_06 >= 5)
		{
			maps\_utility::radio_dialogue(var_02[var_03]);
			var_03++;
			if(var_03 >= var_02.size)
			{
				var_03 = 0;
			}

			continue;
		}
		else
		{
			if(var_05)
			{
				maps\_utility::radio_dialogue("inv_hqr_goodkills");
				var_05 = 0;
			}
			else
			{
				maps\_utility::radio_dialogue("inv_hqr_directhit");
				var_05 = 1;
			}

			continue;
		}
	}
}

//Function Number: 3
remotemissile_uav()
{
	level.uav = maps\_vehicle::spawn_vehicle_from_targetname("remotemissile_uav");
	var_00 = getvehiclenode("vnode_remotemissile_uav_start","targetname");
	level.uav attachpath(var_00);
	maps\_vehicle::gopath(level.uav);
	level.uav playloopsound("uav_engine_loop");
	level.uavrig = spawn("script_model",level.uav.origin);
	level.uavrig setmodel("tag_origin");
	level thread uav_rig_aiming();
}

//Function Number: 4
uav_rig_aiming()
{
	level.uav endon("death");
	var_00 = common_scripts\utility::getstructarray("uav_focus_point","targetname");
	for(;;)
	{
		var_01 = level.player.origin;
		if(isdefined(level.uav_user))
		{
			var_01 = level.uav_user.origin;
		}

		var_02 = maps\_utility::getclosest(var_01,var_00);
		var_03 = var_02.origin;
		var_04 = vectortoangles(var_03 - level.uav.origin);
		level.uavrig moveto(level.uav.origin,0.1,0,0);
		level.uavrig rotateto(var_04,0.1,0,0);
		wait 0.05;
	}
}

//Function Number: 5
ai_remote_missile_fof_outline()
{
	if(!isai(self))
	{
		return;
	}

	if(isdefined(self.ridingvehicle))
	{
		self endon("death");
		self waittill("jumpedout");
	}

	maps\_remotemissile_utility::setup_remote_missile_target();
}

//Function Number: 6
splash_notify_message(param_00)
{
	self endon("death");
	if(!isdefined(param_00.type))
	{
		param_00.type = "";
	}

	var_01 = param_00.duration;
	var_02 = 0.15;
	self.doingnotify = 1;
	self.splashtitle transitionreset();
	self.splashdesc transitionreset();
	self.var_3E17 transitionreset();
	self.splashdesc2 transitionreset();
	self.splashdesc3 transitionreset();
	self.var_3E1A transitionreset();
	self.splashhint transitionreset();
	self.splashicon transitionreset();
	wait 0.05;
	setsaveddvar("cg_drawBreathHint","0");
	var_03 = [];
	self.splashtitle.label = var_01.title;
	if(isdefined(var_01.title_set_value))
	{
		self.splashtitle setvalue(var_01.title_set_value);
	}

	self.splashtitle setpulsefx(int(5 * var_02),int(var_02 * 1000),1000);
	var_04 = self.splashtitle.font;
	if(isdefined(var_01.title_font))
	{
		self.splashtitle.font = var_01.title_font;
	}

	var_05 = var_01.title;
	if(isdefined(var_01.title_label))
	{
		self.splashtitle.label = var_01.title_label;
	}

	var_06 = self.splashtitle.basefontscale;
	if(isdefined(var_01.title_basefontscale))
	{
		self.splashtitle.basefontscale = var_01.title_basefontscale;
	}

	var_07 = self.splashtitle.glowcolor;
	var_08 = self.splashtitle.glowalpha;
	if(isdefined(var_01.title_glowcolor))
	{
		self.splashtitle.glowcolor = var_01.title_glowcolor;
		self.splashtitle.glowalpha = 1;
	}

	var_09 = self.splashtitle.color;
	if(isdefined(var_01.title_color))
	{
		var_09 = var_01.title_color;
		self.splashtitle.color = var_01.title_color;
	}

	var_0A = self.splashicon.shader;
	if(isdefined(var_01.icon) && var_01.icon != "")
	{
		var_7B[var_7B.size] = self.splashicon;
		self.splashicon.shader = var_01.icon;
	}

	var_0B = undefined;
	var_0C = undefined;
	if(isdefined(var_01.var_189B) && !isstring(var_01.var_189B) || var_01.var_189B != "")
	{
		var_7B[var_7B.size] = self.splashdesc;
		self.splashdesc.label = var_01.var_189B;
		if(isdefined(var_01.desc_set_value))
		{
			self.splashdesc setvalue(var_01.desc_set_value);
		}

		var_0B = self.splashdesc.font;
		if(isdefined(var_01.desc_font))
		{
			self.splashdesc.font = var_01.desc_font;
		}

		var_0C = self.splashdesc.basefontscale;
		if(isdefined(var_01.desc_basefontscale))
		{
			self.splashdesc.basefontscale = var_01.desc_basefontscale;
		}

		if(isdefined(var_01.desc1) && !isstring(var_01.desc1) || var_01.desc1 != "")
		{
			var_7B[var_7B.size] = self.var_3E17;
			self.var_3E17.label = var_01.desc1;
			self.var_3E17.font = self.splashdesc.font;
			if(isdefined(var_01.desc1_set_value))
			{
				self.var_3E17 setvalue(var_01.desc1_set_value);
			}
		}

		if(isdefined(var_01.desc2) && !isstring(var_01.desc2) || var_01.desc2 != "")
		{
			var_7B[var_7B.size] = self.splashdesc2;
			self.splashdesc2.label = var_01.desc2;
			self.splashdesc2.font = self.splashdesc.font;
			if(isdefined(var_01.desc2_set_value))
			{
				self.splashdesc2 setvalue(var_01.desc2_set_value);
			}
		}

		if(isdefined(var_01.desc3) && !isstring(var_01.desc3) || var_01.desc3 != "")
		{
			var_7B[var_7B.size] = self.splashdesc3;
			self.splashdesc3.label = var_01.desc3;
			self.splashdesc3.font = self.splashdesc.font;
			if(isdefined(var_01.desc3_set_value))
			{
				self.splashdesc3 setvalue(var_01.desc3_set_value);
			}
		}

		if(isdefined(var_01.desc4) && !isstring(var_01.desc4) || var_01.desc4 != "")
		{
			var_7B[var_7B.size] = self.var_3E1A;
			self.var_3E1A.label = var_01.desc4;
			self.var_3E1A.font = self.splashdesc.font;
			if(isdefined(var_01.desc4_set_value))
			{
				self.var_3E1A setvalue(var_01.desc4_set_value);
			}
		}
	}

	if(isdefined(var_01.hint) && !isstring(var_01.hint) || var_01.hint != "")
	{
		var_7B[var_7B.size] = self.splashhint;
		self.splashhint.label = var_01.hint;
		if(isdefined(var_01.hintlabel))
		{
			self.splashhint.label = var_01.hintlabel;
		}
	}

	if(isdefined(var_01.fadein))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionfadein(var_03);
		}
	}

	if(isdefined(var_01.zoomin))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionzoomin(var_03);
		}
	}

	if(isdefined(var_01.slidein))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionslidein(var_03,var_01.slidein);
		}
	}

	if(isdefined(var_01.pulsefxin))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionpulsefxin(var_03,var_02);
		}
	}

	if(isdefined(var_01.sound))
	{
		if(isdefined(var_01.playsoundlocally))
		{
			self playlocalsound(var_01.sound);
		}
		else
		{
			foreach(var_17 in level.players)
			{
				var_17 playlocalsound(var_01.sound);
			}
		}
	}

	if(isdefined(var_01.abortflag))
	{
		maps\_utility::ent_flag_wait_or_timeout(var_01.abortflag,var_02);
	}
	else
	{
		wait var_02;
	}

	if(isdefined(var_01.fadeout))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionfadeout(var_03);
		}
	}

	if(isdefined(var_01.var_3E34))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionzoomout(var_03);
		}
	}

	if(isdefined(var_01.slideout))
	{
		foreach(var_0E in var_7B)
		{
			var_0E transitionslideout(var_03,var_01.slideout);
		}
	}

	wait var_03;
	setsaveddvar("cg_drawBreathHint","1");
	self.splashtitle.font = var_04;
	self.splashtitle.label = var_05;
	self.splashtitle.basefontscale = var_06;
	self.splashtitle.glowcolor = var_07;
	self.splashtitle.glowalpha = var_08;
	self.splashtitle.color = var_09;
	self.splashicon.shader = var_0A;
	if(isdefined(var_0B))
	{
		self.splashdesc.font = var_0B;
	}

	if(isdefined(var_0C))
	{
		self.splashdesc.basefontscale = var_0C;
	}

	self.doingnotify = 0;
}

//Function Number: 7
player_reward_splash_init()
{
	var_00 = 15;
	if(issplitscreen())
	{
		var_01 = "objective";
		var_02 = 2.25;
		if(getdvarint("survival_chaos") == 1)
		{
			if(self == level.player)
			{
				var_03 = 10;
			}
			else
			{
				var_03 = 37;
			}
		}
		else
		{
			var_03 = 10;
		}

		var_04 = 0;
		var_05 = "objective";
		var_06 = 1;
		var_07 = 57;
		var_08 = 0;
		var_09 = "small";
		var_0A = 1.4;
		var_0B = 72;
		var_0C = 0;
		var_0D = 24;
		var_0E = 5;
		var_0F = 0;
		var_10 = "TOP";
		var_11 = "BOTTOM";
	}
	else
	{
		var_01 = "objective";
		var_02 = 2.5;
		var_03 = 10;
		var_04 = 0;
		var_05 = "objective";
		var_06 = 1.1;
		var_07 = 42;
		var_08 = 0;
		var_09 = "small";
		var_0A = 1.5;
		var_0B = 300;
		var_0C = 0;
		var_0D = 42;
		var_0E = 250;
		var_0F = 0;
		var_10 = "TOP";
		var_11 = "BOTTOM";
	}

	var_12 = createfontstring_mp(var_01,var_02);
	var_12 maps\_hud_util::setpoint(var_10,undefined,var_04,var_03);
	var_12.glowcolor = (0.3,0.6,0.3);
	var_12.glowalpha = 1;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.splashtitle = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp(var_05,var_06);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_08,var_07);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.splashdesc = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp(var_05,var_06);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_08,var_07 + 1 * var_00);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.var_3E17 = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp(var_05,var_06);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_08,var_07 + 2 * var_00);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.splashdesc2 = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp(var_05,var_06);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_08,var_07 + 3 * var_00);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.splashdesc3 = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp(var_05,var_06);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_08,var_07 + 4 * var_00);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.var_3E1A = var_12;
	var_12 = undefined;
	var_12 = createfontstring_mp("hudbig",0.75);
	var_12 maps\_hud_util::setparent(self.splashdesc);
	var_12 maps\_hud_util::setpoint(var_10,var_11,var_0C,var_0B);
	var_12.glowcolor = (0,0,0);
	var_12.glowalpha = 0;
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	var_12.color = (0.75,1,0.75);
	self.splashhint = var_12;
	var_12 = undefined;
	var_12 = createicon_mp("white",var_0D,var_0D);
	var_12 maps\_hud_util::setparent(self.splashtitle);
	var_12 maps\_sp_airdrop::setpoint(var_10,var_11,var_0F,var_0E);
	var_12.hidewheninmenu = 1;
	var_12.archived = 0;
	var_12.alpha = 0;
	self.splashicon = var_12;
}

//Function Number: 8
createfontstring_mp(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.hidden = 0;
	var_02.elemtype = "font";
	var_02.font = param_00;
	var_02.fontscale = param_01;
	var_02.basefontscale = var_02.fontscale;
	var_02.x = 0;
	var_02.y = 0;
	var_02.width = 0;
	var_02.height = int(level.fontheight * var_02.fontscale);
	var_02.xoffset = 0;
	var_02.yoffset = 0;
	var_02.children = [];
	var_02 maps\_hud_util::setparent(level.uiparent);
	return var_02;
}

//Function Number: 9
createicon_mp(param_00,param_01,param_02)
{
	var_03 = newclienthudelem(self);
	var_03.elemtype = "icon";
	var_03.x = 0;
	var_03.y = 0;
	var_03.width = param_01;
	var_03.height = param_02;
	var_03.basewidth = var_03.width;
	var_03.baseheight = var_03.height;
	var_03.xoffset = 0;
	var_03.yoffset = 0;
	var_03.children = [];
	var_03 maps\_hud_util::setparent(level.uiparent);
	var_03.hidden = 0;
	if(isdefined(param_00))
	{
		var_03 setshader(param_00,param_01,param_02);
		var_03.shader = param_00;
	}

	return var_03;
}

//Function Number: 10
waittill_players_ready_for_splash(param_00)
{
	var_01 = gettime() + milliseconds(param_00);
	for(;;)
	{
		if(gettime() >= var_01)
		{
			break;
		}

		var_02 = 0;
		foreach(var_04 in level.players)
		{
			if(var_04.doingnotify || var_04.using_uav)
			{
				var_02 = 1;
				break;
			}
		}

		if(var_02)
		{
			wait 0.1;
			continue;
		}

		break;
	}
}

//Function Number: 11
transitionreset()
{
	self settext("");
	self.x = self.xoffset;
	self.y = self.yoffset;
	if(self.elemtype == "font")
	{
		self.fontscale = self.basefontscale;
		self.label = &"";
	}
	else if(self.elemtype == "icon")
	{
		self setshader(self.shader,self.width,self.height);
	}

	self.alpha = 0;
}

//Function Number: 12
transitionzoomin(param_00)
{
	switch(self.elemtype)
	{
		case "timer":
		case "font":
			self.fontscale = 6.3;
			self changefontscaleovertime(param_00);
			self.fontscale = self.basefontscale;
			break;

		case "icon":
			self setshader(self.shader,self.width * 6,self.height * 6);
			self scaleovertime(param_00,self.width,self.height);
			break;
	}
}

//Function Number: 13
transitionpulsefxin(param_00,param_01)
{
	var_02 = int(param_00) * 1000;
	var_03 = int(param_01) * 1000;
	switch(self.elemtype)
	{
		case "timer":
		case "font":
			self setpulsefx(var_02 + 250,var_03 + var_02,var_02 + 250);
			break;

		default:
			break;
	}
}

//Function Number: 14
transitionslidein(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "left";
	}

	switch(param_01)
	{
		case "left":
			self.x = self.x + 1000;
			break;

		case "right":
			self.x = self.x - 1000;
			break;

		case "up":
			self.y = self.y - 1000;
			break;

		case "down":
			self.y = self.y + 1000;
			break;
	}

	self moveovertime(param_00);
	self.x = self.xoffset;
	self.y = self.yoffset;
}

//Function Number: 15
transitionslideout(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "left";
	}

	var_02 = self.xoffset;
	var_03 = self.yoffset;
	switch(param_01)
	{
		case "left":
			var_02 = var_02 + 1000;
			break;

		case "right":
			var_02 = var_02 - 1000;
			break;

		case "up":
			var_03 = var_03 - 1000;
			break;

		case "down":
			var_03 = var_03 + 1000;
			break;
	}

	self.alpha = 1;
	self moveovertime(param_00);
	self.x = var_02;
	self.y = var_03;
}

//Function Number: 16
transitionzoomout(param_00)
{
	switch(self.elemtype)
	{
		case "timer":
		case "font":
			self changefontscaleovertime(param_00);
			self.fontscale = 6.3;
			break;

		case "icon":
			self scaleovertime(param_00,self.width * 6,self.height * 6);
			break;
	}
}

//Function Number: 17
transitionfadein(param_00)
{
	self fadeovertime(param_00);
	if(isdefined(self.maxalpha))
	{
		self.alpha = self.maxalpha;
		return;
	}

	self.alpha = 1;
}

//Function Number: 18
transitionfadeout(param_00)
{
	self fadeovertime(0.15);
	self.alpha = 0;
}

//Function Number: 19
get_spawners_by_classname(param_00)
{
	var_01 = getentarray(param_00,"classname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isspawner(var_04))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 20
get_spawners_by_targetname(param_00)
{
	var_01 = getspawnerarray();
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.targetname) && var_04.targetname == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 21
get_furthest_from_these(param_00,param_01,param_02)
{
	param_02 = common_scripts\utility::ter_op(isdefined(param_02),param_02,1);
	param_02 = max(1,param_02);
	while(param_00.size > param_02)
	{
		foreach(var_04 in param_01)
		{
			var_05 = maps\_utility::getclosest(var_04.origin,param_00);
			if(param_00.size > param_02)
			{
				param_00 = common_scripts\utility::array_remove(param_00,var_05);
				continue;
			}

			var_05 = param_00[0];
			thread maps\_squad_enemies::draw_debug_marker(var_05.origin,(1,1,1));
			break;
		}
	}

	return param_00[randomint(param_00.size)];
}

//Function Number: 22
throw_grenade_at_player(param_00)
{
	self endon("death");
	param_00 endon("stopped camping");
	if(common_scripts\utility::cointoss())
	{
		self.grenadeweapon = "flash_grenade";
	}
	else
	{
		self.grenadeweapon = "fraggrenade";
	}

	self.grenadeammo = 2;
	self.script_forcegrenade = 1;
	wait 8;
	self.script_forcegrenade = 0;
	self.grenadeweapon = "fraggrenade";
}

//Function Number: 23
clear_from_boss_array_when_dead()
{
	self waittill("death");
	var_00 = [];
	foreach(var_02 in level.bosses)
	{
		if(isdefined(var_02) && !isdefined(self) || self != var_02)
		{
			var_00[var_00.size] = var_02;
		}
	}

	level.bosses = var_00;
}

//Function Number: 24
clear_from_special_ai_array_when_dead()
{
	self waittill("death");
	var_00 = [];
	foreach(var_02 in level.special_ai)
	{
		if(isalive(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	level.special_ai = var_00;
}

//Function Number: 25
was_headshot()
{
	if(isdefined(self.died_of_headshot) && self.died_of_headshot)
	{
		return 1;
	}

	if(!isdefined(self.damagelocation))
	{
		return 0;
	}

	return self.damagelocation == "helmet" || self.damagelocation == "head" || self.damagelocation == "neck";
}

//Function Number: 26
chopper_spawn_from_targetname_and_drive(param_00,param_01,param_02)
{
	var_03 = "passed start struct without targetname: " + param_00;
	param_02.in_use = 1;
	var_04 = chopper_spawn_from_targetname(param_00,param_01);
	var_04.loc_current = param_02;
	var_04 thread maps\_vehicle::vehicle_paths(param_02);
	return var_04;
}

//Function Number: 27
chopper_spawn_from_targetname(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = maps\_so_survival_ai::get_ai_health(param_00);
	if(isdefined(var_03))
	{
		var_02.script_startinghealth = var_03;
	}

	while(isdefined(var_02.vehicle_spawned_thisframe))
	{
		wait 0.05;
	}

	if(isdefined(param_01))
	{
		var_02.origin = param_01;
	}

	var_04 = maps\_vehicle::spawn_vehicle_from_targetname(param_00);
	return var_04;
}

//Function Number: 28
chopper_spawn_pilot_from_targetname(param_00,param_01)
{
	var_02 = getspawnerarray();
	var_03 = undefined;
	foreach(var_03 in var_02)
	{
		if(isdefined(var_03.targetname) && var_03.targetname == param_00)
		{
			break;
		}
	}

	var_06 = chopper_spawn_passenger(var_03,param_01,1);
	var_06.health = 9999;
	return var_06;
}

//Function Number: 29
chopper_spawn_passenger(param_00,param_01,param_02)
{
	var_03 = undefined;
	for(;;)
	{
		param_00.count = 1;
		if(isdefined(param_02) && param_02)
		{
			var_03 = maps\_utility::dronespawn(param_00);
			break;
		}
		else
		{
			var_03 = param_00 maps\_utility::spawn_ai(1);
			if(!maps\_utility::spawn_failed(var_03))
			{
				break;
			}
		}

		wait 0.5;
	}

	if(isdefined(param_01))
	{
		var_03.forced_startingposition = param_01;
	}

	maps\_utility::guy_enter_vehicle(var_03);
	return var_03;
}

//Function Number: 30
chopper_drop_smoke_at_unloading()
{
	self endon("death");
	self waittill("unloading");
	var_00 = self.origin - vectornormalize(anglestoforward(self.angles)) * 145;
	var_01 = maps\_utility::groundpos(var_00);
	magicgrenademanual("smoke_grenade_fast",var_01,(0,0,-1),0);
}

//Function Number: 31
chopper_wait_for_cloest_open_path_start(param_00,param_01,param_02)
{
	var_03 = undefined;
	for(;;)
	{
		var_03 = chopper_closest_open_path_start(param_00,param_01,param_02);
		if(isdefined(var_03))
		{
			break;
		}

		wait 0.25;
	}

	return var_03;
}

//Function Number: 32
chopper_closest_open_path_start(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstructarray(param_01,"targetname");
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	foreach(var_08 in var_03)
	{
		if(isdefined(var_08.in_use))
		{
			continue;
		}

		var_09 = var_08;
		switch(param_02)
		{
			case "script_unload":
				while(!isdefined(var_09.script_unload))
				{
					var_09 = common_scripts\utility::getstruct(var_09.target,"targetname");
				}
	
				if(!isdefined(var_09.script_unload))
				{
					break;
				}
				break;

			case "script_stopnode":
				while(!isdefined(var_09.script_stopnode))
				{
					var_09 = common_scripts\utility::getstruct(var_09.target,"targetname");
				}
	
				if(!isdefined(var_09.script_stopnode))
				{
					break;
				}
				break;

			default:
				break;
		}

		if(!isdefined(var_06))
		{
			var_06 = var_09;
			var_05 = distance2d(param_00,var_09.origin);
			var_04 = var_08;
			continue;
		}

		var_0A = distance2d(param_00,var_09.origin);
		if(var_0A < var_05)
		{
			var_06 = var_09;
			var_05 = distance2d(param_00,var_06.origin);
			var_04 = var_08;
		}
	}

	return var_04;
}

//Function Number: 33
mp_ents_cleanup()
{
	var_00 = getentarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].script_gameobjectname))
		{
			var_00[var_01] delete();
		}
	}
}

//Function Number: 34
precache_loadout_item(param_00)
{
	if(isdefined(param_00) && param_00 != "")
	{
		precacheitem(param_00);
	}
}

//Function Number: 35
int_capped(param_00,param_01,param_02)
{
	return int(max(param_01,min(param_02,param_00)));
}

//Function Number: 36
float_capped(param_00,param_01,param_02)
{
	return max(param_01,min(param_02,param_00));
}

//Function Number: 37
delete_on_load()
{
	var_00 = getentarray("delete","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 38
milliseconds(param_00)
{
	return param_00 * 1000;
}

//Function Number: 39
seconds(param_00)
{
	return param_00 / 1000;
}

//Function Number: 40
random_player_origin()
{
	return level.players[randomint(level.players.size)].origin;
}

//Function Number: 41
highest_player_rank()
{
	var_00 = -1;
	foreach(var_02 in level.players)
	{
		var_03 = var_02 maps\_rank::getrank();
		if(var_03 > var_00)
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 42
ent_linked_delete()
{
	self endon("death");
	self unlink();
	wait 0.05;
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 43
so_survival_kill_ai(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(isdefined(param_01) && isdefined(param_02))
		{
			self notify("death",param_00,param_01,param_02);
			self kill();
			return;
		}

		self kill(param_00.origin,param_00);
		return;
	}

	self kill();
}

//Function Number: 44
break_glass()
{
	var_00 = common_scripts\utility::getstructarray("struct_break_glass","targetname");
	foreach(var_02 in var_00)
	{
		glassradiusdamage(var_02.origin,64,100,99);
	}
}

//Function Number: 45
so_survival_validate_entities()
{
	var_00 = getentarray("armory_script_brushmodel","targetname");
	foreach(var_02 in var_00)
	{
		var_02 notsolid();
	}

	var_04 = (0,0,0);
	var_05 = 60;
	var_06 = 60;
	var_07 = [];
	var_7B = common_scripts\utility::array_combine(var_7B,common_scripts\utility::getstructarray("so_claymore_loc","targetname"));
	var_7B = common_scripts\utility::array_combine(var_7B,common_scripts\utility::getstructarray("leader","script_noteworthy"));
	var_7B = common_scripts\utility::array_combine(var_7B,common_scripts\utility::getstructarray("follower","script_noteworthy"));
	foreach(var_09 in var_7B)
	{
		var_09 so_survival_validate_entity(var_05,var_06,var_07);
	}

	foreach(var_03 in var_01)
	{
		var_03 solid();
	}

	wait 2;
	if(isdefined(level.debug_survival_error_msgs) && level.debug_survival_error_msgs.size)
	{
		foreach(var_0E in level.debug_survival_error_msgs)
		{
		}
	}
}

//Function Number: 46
so_survival_validate_entity(param_00,param_01,param_02)
{
	if(!isdefined(level.debug_survival_error_msgs))
	{
		level.debug_survival_error_msgs = [];
	}

	if(!isdefined(level.debug_survival_error_locs))
	{
		level.debug_survival_error_locs = [];
	}

	var_03 = self.origin + param_00 + (0,0,param_01);
	var_04 = self.origin + param_00;
	var_05 = physicstrace(var_03,var_04);
	if(distance(var_05,var_04) > 0.1)
	{
		level.debug_survival_error_msgs[level.debug_survival_error_msgs.size] = "Error: Survival Entity may be in solid at: " + self.origin;
		level.debug_survival_error_locs[level.debug_survival_error_locs.size] = self.origin;
		return;
	}

	var_03 = self.origin + param_00;
	var_04 = self.origin + param_00 - (0,0,param_02);
	var_05 = physicstrace(var_03,var_04);
	if(distance(var_05,var_04) < 0.1)
	{
		level.debug_survival_error_msgs[level.debug_survival_error_msgs.size] = "Error: Survival Entity floating or under floor: " + self.origin;
		level.debug_survival_error_locs[level.debug_survival_error_locs.size] = self.origin;
	}
}

//Function Number: 47
so_survival_display_entity_error_3d()
{
	if(!isdefined(level.debug_survival_error_locs) || !level.debug_survival_error_locs.size)
	{
		return;
	}

	level endon("special_op_terminated");
	for(;;)
	{
		foreach(var_01 in level.debug_survival_error_locs)
		{
		}

		wait 10;
	}
}