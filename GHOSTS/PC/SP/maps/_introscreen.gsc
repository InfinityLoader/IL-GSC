/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_introscreen.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 743 ms
 * Timestamp: 10/27/2023 1:27:50 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	precacheshader("black");
	var_00 = 0;
	level thread func_36E9();
	common_scripts\utility::flag_wait("start_is_set");
	if(!isdefined(level.introscreen) || !maps\_utility::func_47DB() || var_00)
	{
		maps\_utility::func_252F(0.05,::common_scripts\utility::flag_set,"introscreen_complete");
		return;
	}

	if(isdefined(level.introscreen.var_2243))
	{
		[[ level.introscreen.var_2243 ]]();
		return;
	}

	introscreen();
}

//Function Number: 2
func_4781()
{
	if(!isdefined(level.introscreen))
	{
		return 0;
	}

	var_00 = level.introscreen.lines;
	var_01 = getarraykeys(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = 1;
		var_05 = var_02 * var_04 + 1;
		maps\_utility::func_252F(var_05,::func_477E,var_00[var_03],var_00.size - var_02 - 1,var_04,var_03);
	}

	return 1;
}

//Function Number: 3
func_4783(param_00,param_01,param_02)
{
	func_4785("black",param_00,param_01,param_02);
}

//Function Number: 4
func_4785(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	if(!isdefined(param_03))
	{
		maps\_hud_util::func_7A75();
	}
	else
	{
		maps\_hud_util::fade_out(param_03);
	}

	wait(param_01);
	maps\_hud_util::func_3131(param_02);
	wait(param_02);
	setsaveddvar("com_cinematicEndInWhite",0);
}

//Function Number: 5
func_477E(param_00,param_01,param_02,param_03)
{
	level notify("new_introscreen_element");
	if(!isdefined(level.intro_offset))
	{
		level.intro_offset = 0;
	}
	else
	{
		level.intro_offset++;
	}

	var_04 = cornerline_height();
	var_05 = newhudelem();
	var_05.x = 20;
	var_05.y = var_04;
	var_05.alignx = "left";
	var_05.aligny = "bottom";
	var_05.horzalign = "left";
	var_05.vertalign = "bottom";
	var_05.sort = 1;
	var_05.foreground = 1;
	var_05 settext(param_00);
	var_05.alpha = 0;
	var_05 fadeovertime(0.2);
	var_05.alpha = 1;
	var_05.hidewheninmenu = 1;
	var_05.fontscale = 2;
	var_05.color = (0.8,1,0.8);
	var_05.font = "default";
	var_05.glowcolor = (0.3,0.6,0.3);
	var_05.glowalpha = 1;
	var_06 = int(param_01 * param_02 * 1000 + 4000);
	var_05 setpulsefx(30,var_06,700);
	thread func_435E(var_05);
}

//Function Number: 6
cornerline_height()
{
	return level.intro_offset * 20 - 82;
}

//Function Number: 7
func_435E(param_00)
{
	wait(16);
	param_00 notify("destroying");
	level.intro_offse = undefined;
	var_01 = 0.5;
	param_00 fadeovertime(var_01);
	param_00.alpha = 0;
	wait(var_01);
	param_00 notify("destroy");
	param_00 destroy();
}

//Function Number: 8
func_589D()
{
	level.player freezecontrols(1);
	thread func_4783(level.introscreen.var_1EA0,level.introscreen.fade_out_time,level.introscreen.var_3137);
	if(!func_4781())
	{
		wait(0.05);
	}

	wait(level.introscreen.var_1EA0);
	common_scripts\utility::flag_set("introscreen_complete");
	level.player freezecontrols(0);
}

//Function Number: 9
introscreen(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
		var_02 = 1;
	}

	if(isdefined(param_01))
	{
		param_00 = 1;
		maps\_hud_util::func_7A75();
		level.player freezecontrols(1);
		level.player common_scripts\utility::delaycall(param_01,::freezecontrols,0);
		maps\_utility::func_252F(param_01,::maps\_hud_util::func_3131,2);
	}

	level.chyron = spawnstruct();
	level.chyron.huds = [];
	level.chyron.var_7CEB = [];
	level.chyron.last_strips = [];
	level.chyron.artifacts = [];
	level.chyron.var_8067 = 20;
	level.chyron.var_8068 = -82;
	level.chyron.var_805E = 0;
	level.chyron.var_7CEC = 0;
	level.chyron.var_770E = spawn("script_origin",level.player.origin);
	level.chyron.var_770E linkto(level.player);
	level.chyron.no_bg = param_00;
	if(!param_00)
	{
		level.player freezecontrols(1);
		maps\_hud_util::func_7A75();
		thread artifacts(0);
	}

	chyron_sound(0,"ui_chyron_on");
	thread func_7CEB(0);
	var_03 = 0.4;
	thread func_629C(0,var_03);
	wait(var_03);
	func_8141(level.introscreen.lines[0]);
	chyron_sound(0,"ui_chyron_firstline");
	func_7D23(level.introscreen.lines[1],0);
	wait(2);
	var_04 = func_7D23(level.introscreen.lines[2],1,"default",1,1);
	var_04.color = (0.68,0.744,0.736);
	var_05 = undefined;
	if(isdefined(level.introscreen.lines[3]))
	{
		var_05 = func_7D23(level.introscreen.lines[3],2,"default",1,1);
		var_05.color = (0.68,0.744,0.736);
		level.chyron.huds = common_scripts\utility::array_remove(level.chyron.huds,var_05);
	}

	wait(1);
	level.chyron.var_7CEC = 1;
	wait(2);
	level.chyron.var_7CEC = 0;
	if(isdefined(var_05))
	{
		var_05 thread name_drift();
	}

	wait(1);
	func_31FA(0,param_00);
	if(!param_00)
	{
		chyron_sound(0,"ui_chyron_off");
		thread maps\_hud_util::func_3131(2);
		level.player freezecontrols(0);
	}

	common_scripts\utility::flag_set("introscreen_complete");
	level notify("stop_chyron");
	level.chyron.var_770E delete();
	level.chyron = undefined;
}

//Function Number: 10
name_drift()
{
	var_00 = self.color;
	var_01 = self.alpha;
	self notify("stop_quick_pulse");
	var_02 = 2;
	self.glowalpha = 1;
	self.glowcolor = (1,1,1);
	thread fade_glow((0.10625,0.11625,0.115),0.1,var_02);
	self.color = (1,1,1);
	self.alpha = 1;
	self fadeovertime(var_02);
	self.color = var_00;
	self.alpha = 0.8;
	var_02 = 4;
	self moveovertime(var_02 * 3);
	self changefontscaleovertime(var_02 * 1.5);
	self.x = self.x + randomintrange(5,10);
	self.y = self.y - randomintrange(3,12);
	self.fontscale = self.fontscale * randomfloatrange(1.2,1.3);
	wait(var_02);
	self fadeovertime(2);
	self.alpha = 0;
	wait(2);
	self destroy();
}

//Function Number: 11
fade_glow(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = param_02 * 20;
	var_04 = param_00 - self.glowcolor / var_03;
	var_05 = param_01 - self.glowalpha / var_03;
	for(var_06 = 0;var_06 < var_03;var_06++)
	{
		self.glowcolor = self.glowcolor + var_04;
		self.glowalpha = self.glowalpha + var_05;
		wait(0.05);
	}

	self.glowcolor = param_00;
	self.glowalpha = param_01;
}

//Function Number: 12
chyron_sound(param_00,param_01)
{
	if(param_00 == 0)
	{
		level.chyron.var_770E playsound(param_01);
	}

	level.var_36E9.var_770E playsound(param_01);
}

//Function Number: 13
func_4319(param_00)
{
	self endon("death");
	self fadeovertime(param_00);
	self.alpha = 0;
	wait(param_00);
	self destroy();
}

//Function Number: 14
func_629C(param_00,param_01)
{
	wait(0.5);
	var_02 = newhudelem();
	if(param_00 == 0)
	{
		var_02.x = level.chyron.var_8067 - 5;
		var_02.y = level.chyron.var_8068;
		var_02.vertalign = "bottom";
	}
	else
	{
		var_02.x = level.var_36E9.var_8067 - 5;
		var_02.y = level.var_36E9.var_8068;
		var_02.vertalign = "top";
	}

	var_02.fontscale = 3;
	var_02.horzalign = "left";
	var_02.sort = 1;
	var_02.foreground = 1;
	var_02.hidewheninmenu = 1;
	var_02.alpha = 0.8;
	var_02 setshader("white",1,35);
	var_02.color = (0.85,0.93,0.92);
	var_02 moveovertime(param_01);
	var_02 fadeovertime(param_01 * 0.5);
	var_02.alpha = 0;
	var_02.x = var_02.x + 300;
	wait(0.4);
	var_02 destroy();
}

//Function Number: 15
artifacts(param_00)
{
	if(param_00 == 0)
	{
		level endon("chyron_faze_out_text_intro");
	}
	else
	{
		level endon("chyron_faze_out_text_gamenotify");
	}

	var_01 = [".","-","_","|","+"];
	var_02 = 0.7;
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = create_chyron_text("");
		var_04.fontscale = var_02;
		var_04.alpha = 0;
		var_04.sort = 2;
		var_04.color = (0.75,0.83,0.89);
		var_04.var_6239 = 0;
		level.chyron.artifacts[level.chyron.artifacts.size] = var_04;
	}

	level.chyron.artifacts_fade = 0;
	thread artifact_pulse(param_00);
	var_05 = 0;
	var_06 = level.chyron.var_8068 - 10;
	for(;;)
	{
		var_07 = 0;
		var_01 = common_scripts\utility::array_randomize(var_01);
		foreach(var_04 in level.chyron.artifacts)
		{
			chyron_sound(param_00,"ui_chyron_plusminus");
			var_04.fontscale = var_02;
			if(var_01[var_07] == "+")
			{
				var_04.fontscale = 0.55;
			}

			var_04 settext(var_01[var_07]);
			var_04.x = var_05 + randomint(200);
			var_04.y = var_06 + randomint(60);
			var_04.var_6239 = 1;
			var_07++;
			wait(randomfloatrange(0.05,0.1));
		}

		wait(randomfloatrange(4,7));
		level.chyron.artifacts_fade = 1;
		level waittill("chyron_artifact_faded");
	}
}

//Function Number: 16
artifact_pulse(param_00)
{
	if(param_00 == 0)
	{
		level endon("chyron_faze_out_text_intro");
	}
	else
	{
		level endon("chyron_faze_out_text_gamenotify");
	}

	var_01 = 0.6;
	var_02 = 1;
	for(;;)
	{
		if(level.chyron.artifacts_fade)
		{
			var_01 = var_01 - 0.07;
		}
		else
		{
			if(var_01 < 0.15 || var_01 > 0.6)
			{
				var_02 = var_02 * -1;
			}

			var_01 = var_01 + 0.02 + randomfloat(0.04) * var_02;
		}

		var_01 = max(var_01,0);
		foreach(var_04 in level.chyron.artifacts)
		{
			if(var_04.var_6239)
			{
				if(var_01 == 0)
				{
					var_04.alpha = 0;
					continue;
				}

				var_04.alpha = randomfloatrange(var_01 * 0.6,var_01);
			}
		}

		if(var_01 == 0)
		{
			level notify("chyron_artifact_faded");
			var_01 = 0.8;
			level.chyron.artifacts_fade = 0;
			foreach(var_04 in level.chyron.artifacts)
			{
				var_04.var_6239 = 0;
			}
		}

		wait(0.05);
	}
}

//Function Number: 17
func_7CEB(param_00)
{
	if(param_00 == 0)
	{
		level endon("chyron_faze_out_text_intro");
	}
	else
	{
		level endon("chyron_faze_out_text_gamenotify");
	}

	var_01 = 5;
	var_02 = 0;
	var_03 = 1;
	for(;;)
	{
		if((param_00 == 0 && level.chyron.var_7CEC) || param_00 == 1 && level.var_36E9.var_7CEC)
		{
			wait(0.05);
			continue;
		}

		var_02++;
		var_04 = int(min(var_02,var_01));
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			thread func_20B6(param_00);
			wait(randomfloatrange(0,0.1));
		}

		if((param_00 == 0 && level.chyron.var_805E) || param_00 == 1 && level.var_36E9.var_805E)
		{
			wait(0.05);
			continue;
		}

		wait(randomfloatrange(var_03 * 0.5,var_03));
		var_03 = var_03 - 0.05;
		var_03 = max(var_03,0.2);
	}
}

//Function Number: 18
func_8141(param_00,param_01)
{
	var_02 = create_chyron_text(param_00);
	level.chyron.var_805F = var_02.x;
	level.chyron.var_8060 = var_02.y;
	level.chyron.var_805E = 1;
	wait(0.5);
	level.chyron.var_805E = 0;
	var_03 = dupe_hud(var_02,1);
	var_04 = 4;
	var_03[0] thread func_4EBE(var_04);
	var_02.y = var_02.y - 10;
	var_02.glowalpha = 0.05;
	var_02.glowcolor = (0.425,0.465,0.46) * glowcolor_mult();
	var_05 = 0.3;
	var_02 moveovertime(var_05);
	var_02 fadeovertime(var_05 * 3);
	var_02.y = var_02.y + 10;
	var_06 = 0.5;
	var_06 = var_06 - var_05;
	wait(var_05);
	var_02 thread func_629F(0);
	wait(var_06);
	if(randomint(100) > 10)
	{
		var_02 thread func_586B(-30,30,20,-8,8,4);
	}
}

//Function Number: 19
func_586B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = randomintrange(1,2);
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		var_08 = func_6335(param_00,param_01,param_02);
		var_09 = func_6335(param_03,param_04,param_05);
		var_0A[0] = [var_08,var_09];
		var_0A[1] = [var_08 - 10,var_09];
		thread hud_offset(var_0A);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 20
func_31FA(param_00,param_01)
{
	var_02 = undefined;
	if(!param_01)
	{
		var_02 = newhudelem();
		if(param_00 == 0)
		{
			var_02.x = level.chyron.var_8067 + 60;
			var_02.y = level.chyron.var_8068 + 30;
			var_02.vertalign = "bottom";
		}
		else
		{
			var_02.x = level.var_36E9.var_8067 + 60;
			var_02.y = level.var_36E9.var_8068 + 10;
			var_02.vertalign = "top";
		}

		var_02.alignx = "center";
		var_02.aligny = "middle";
		var_02.horzalign = "left";
		var_02.sort = 1;
		var_02.foreground = 1;
		var_02.hidewheninmenu = 1;
		var_02.alpha = 0;
		var_02 setshader("white",1,60);
		var_02.color = (0.85,0.93,0.92);
		var_02 fadeovertime(0.25);
		var_02.alpha = 0.1;
		var_02 scaleovertime(0.1,2000,60);
		wait(0.1);
	}

	var_03 = 0.15;
	func_3144(param_00,var_03 * 0.4);
	if(!param_01)
	{
		var_02 fadeovertime(0.25);
		var_02.alpha = 0.2;
		var_02.color = (1,1,1);
		var_02 scaleovertime(var_03,2000,2);
		wait(var_03);
		var_03 = 0.15;
		var_02 scaleovertime(var_03,2,2);
		var_02 thread faze_out_finish(var_03);
	}
}

//Function Number: 21
faze_out_finish(param_00)
{
	self fadeovertime(param_00);
	self.alpha = 0;
	wait(param_00);
	self destroy();
}

//Function Number: 22
func_3144(param_00,param_01)
{
	if(param_00 == 0)
	{
		level notify("chyron_faze_out_text_intro");
		foreach(var_03 in level.chyron.huds)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_03 thread func_4319(param_01);
		}

		foreach(var_03 in level.chyron.var_7CEB)
		{
			var_03 thread func_4319(param_01);
		}
	}

	level notify("chyron_faze_out_text_gamenotify");
	foreach(var_03 in level.var_36E9.huds)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_03 thread func_4319(param_01);
	}

	foreach(var_03 in level.var_36E9.var_7CEB)
	{
		var_03 thread func_4319(param_01);
	}
}

//Function Number: 23
func_7D23(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = create_chyron_text(param_00);
	var_05.y = var_05.y + 20 + param_01 * 15;
	if(isdefined(param_02))
	{
		var_05.font = param_02;
	}

	var_05.fontscale = 1;
	if(isdefined(param_03))
	{
		var_05.fontscale = param_03;
	}

	level.chyron.var_805F = var_05.x;
	level.chyron.var_8060 = var_05.y;
	level.chyron.var_805E = 1;
	wait(0.5);
	var_05.glowalpha = 0.05;
	var_05.glowcolor = (0.425,0.465,0.46) * glowcolor_mult();
	var_05 thread func_629F(0,param_04);
	var_05.alpha = 1;
	if(isdefined(param_04))
	{
		var_05.alpha = param_04;
	}

	var_05 setpulsefx(30,-15536,700);
	if(randomint(100) > 70)
	{
		var_05 maps\_utility::func_252F(2,::func_586B,-7,7,3,-5,5,3);
	}

	level.chyron.var_805E = 0;
	return var_05;
}

//Function Number: 24
glowcolor_mult()
{
	var_00 = 1;
	if(isdefined(level.chyron) && level.chyron.no_bg)
	{
		var_00 = 0.3;
	}

	return var_00;
}

//Function Number: 25
hud_offset(param_00)
{
	var_01 = self.x;
	var_02 = self.y;
	foreach(var_04 in param_00)
	{
		self.x = var_01 + var_04[0];
		self.y = var_02 + var_04[1];
		wait(randomfloatrange(0.05,0.2));
	}

	self.x = var_01;
	self.y = var_02;
}

//Function Number: 26
func_629F(param_00,param_01)
{
	self endon("death");
	self endon("stop_quick_pulse");
	if(param_00 == 0)
	{
		level endon("chyron_faze_out_text_intro");
	}
	else
	{
		level endon("chyron_faze_out_text_gamenotify");
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	for(;;)
	{
		wait(0.05);
		self.alpha = randomfloatrange(param_01 * 0.7,param_01);
	}
}

//Function Number: 27
func_4EBE(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self endon("death");
	var_02 = self.x;
	var_03 = self.y;
	var_04 = 0.15;
	if(!param_01)
	{
		self.x = self.x + randomintrange(-30,-10);
		self.y = self.y + randomintrange(10,20);
		self moveovertime(var_04);
		self.x = var_02;
		self.y = var_03;
		self fadeovertime(var_04);
		self.alpha = 0.1;
		wait(var_04);
	}

	self moveovertime(param_00);
	self.x = self.x + randomintrange(15,20);
	self.y = self.y + randomintrange(-4,4);
	wait(param_00);
	var_04 = 0.05;
	self moveovertime(var_04);
	self.x = var_02;
	self.y = var_03;
	wait(var_04);
	self fadeovertime(var_04);
	self.alpha = 0;
}

//Function Number: 28
func_6335(param_00,param_01,param_02)
{
	var_03 = randomintrange(param_00,param_01);
	var_04 = 1;
	if(var_03 < 0)
	{
		var_04 = -1;
	}

	var_03 = max(abs(var_03),param_02);
	return var_03 * var_04;
}

//Function Number: 29
create_chyron_text(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = level.chyron.var_8067;
	}

	if(!isdefined(param_02))
	{
		param_02 = level.chyron.var_8068;
	}

	var_03 = newhudelem();
	var_03.x = param_01;
	var_03.y = param_02;
	var_03.horzalign = "left";
	var_03.vertalign = "bottom";
	var_03.aligny = "bottom";
	var_03.sort = 3;
	var_03.foreground = 1;
	var_03 settext(param_00);
	var_03.text = param_00;
	var_03.alpha = 0;
	var_03.hidewheninmenu = 1;
	var_03.fontscale = 1.4;
	if(level.console)
	{
		var_03.fontscale = 1.2;
	}

	var_03.color = (0.85,0.93,0.92);
	var_03.font = "default";
	if(isdefined(level.chyron))
	{
		level.chyron.huds[level.chyron.huds.size] = var_03;
	}

	return var_03;
}

//Function Number: 30
get_strip_settings(param_00)
{
	var_01 = spawnstruct();
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	if(param_00 == 0)
	{
		var_05 = -85;
		var_02 = level.chyron.var_805E;
		var_03 = level.chyron.var_805F;
		var_04 = level.chyron.var_8060;
	}
	else
	{
		var_05 = 0;
		var_02 = level.var_36E9.var_805E;
		var_03 = level.var_36E9.var_805F;
		var_04 = level.var_36E9.var_8060;
	}

	var_06 = 200;
	var_07 = 60;
	var_01.width = randomintrange(20,var_06);
	var_08 = [5,10,15];
	var_01.height = var_08[randomint(var_08.size)];
	var_01.x = randomintrange(0,var_06 - var_01.width);
	var_01.y = var_05 + randomint(var_07 - var_01.height);
	var_01.alpha = randomfloatrange(0.3,0.7);
	var_01.color = get_strip_color();
	var_01.time = randomfloatrange(0.05,0.1);
	if(var_02)
	{
		var_01.x = int(var_03 + randomintrange(-1,1));
		var_01.y = int(var_04 + randomintrange(0,7));
		var_01.width = randomintrange(100,var_06);
		var_01.height = randomintrange(10,15);
		var_01.color = (0.85,0.93,0.92) * randomfloatrange(0.2,0.4);
	}

	return var_01;
}

//Function Number: 31
get_strip_color()
{
	var_00 = [];
	var_00[var_00.size] = (0.15,0.14,0.22);
	var_00[var_00.size] = (0.09,0.11,0.13);
	var_00[var_00.size] = (0.34,0.22,0.22);
	var_00[var_00.size] = (0.29,0.34,0.22);
	return var_00[randomint(var_00.size)];
}

//Function Number: 32
func_20B6(param_00)
{
	if(param_00 == 0)
	{
		level endon("chyron_faze_out_text_intro");
		if(level.chyron.var_7CEB.size < 8)
		{
			var_01 = newhudelem();
			var_01.var_89F4 = 0;
			level.chyron.var_7CEB[level.chyron.var_7CEB.size] = var_01;
		}

		var_02 = undefined;
		foreach(var_04 in level.chyron.var_7CEB)
		{
			if(var_04.var_89F4)
			{
				continue;
			}

			var_02 = var_04;
		}

		if(!isdefined(var_02))
		{
		}

		var_06 = get_strip_settings(param_00);
		if(!level.chyron.var_805E)
		{
			if(level.chyron.last_strips.size > 0 && level.chyron.last_strips.size < 3 && randomint(100) > 10)
			{
				var_07 = level.chyron.last_strips[level.chyron.last_strips.size - 1];
				var_06.x = var_07.x;
				var_06.y = var_07.y + var_07.height;
				if(common_scripts\utility::func_1DE9())
				{
					var_06.y = var_07.y - var_06.height;
				}
			}
			else
			{
				level.chyron.last_strips = [];
			}

			level.chyron.last_strips[level.chyron.last_strips.size] = var_02;
		}
	}
	else
	{
		level endon("chyron_faze_out_text_gamenotify");
		if(level.var_36E9.var_7CEB.size < 8)
		{
			var_01 = newhudelem();
			var_01.var_89F4 = 0;
			level.var_36E9.var_7CEB[level.var_36E9.var_7CEB.size] = var_01;
		}

		var_02 = undefined;
		foreach(var_04 in level.var_36E9.var_7CEB)
		{
			if(var_04.var_89F4)
			{
				continue;
			}

			var_02 = var_04;
		}

		if(!isdefined(var_02))
		{
		}

		var_06 = get_strip_settings(param_00);
		if(!level.var_36E9.var_805E)
		{
			if(level.var_36E9.last_strips.size > 0 && level.var_36E9.last_strips.size < 3 && randomint(100) > 10)
			{
				var_07 = level.var_36E9.last_strips[level.var_36E9.last_strips.size - 1];
				var_06.x = var_07.x;
				var_06.y = var_07.y + var_07.height;
				if(common_scripts\utility::func_1DE9())
				{
					var_06.y = var_07.y - var_06.height;
				}
			}
			else
			{
				level.var_36E9.last_strips = [];
			}

			level.var_36E9.last_strips[level.var_36E9.last_strips.size] = var_02;
		}
	}

	var_02.x = var_06.x;
	var_02.y = var_06.y;
	var_02.width = var_06.width;
	var_02.height = var_06.height;
	var_02 setshader("white",var_06.width,var_06.height);
	var_02.alpha = var_06.alpha;
	var_02.color = var_06.color;
	if(var_02.alpha > 0.6)
	{
		chyron_sound(param_00,"ui_chyron_line_static");
	}

	var_02.horzalign = "left";
	var_02.vertalign = "bottom";
	if(param_00 == 1)
	{
		var_02.vertalign = "top";
	}

	var_02.sort = 1;
	var_02.foreground = 1;
	var_02.hidewheninmenu = 1;
	var_02.var_89F4 = 1;
	wait(var_06.time);
	var_02.alpha = 0;
	var_02.var_89F4 = 0;
}

//Function Number: 33
dupe_hud(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_02[var_02.size] = create_chyron_text(param_00.text);
	}

	return var_02;
}

//Function Number: 34
func_36E9()
{
	level.var_36E9 = spawnstruct();
	level.var_36E9.active = 0;
	level.var_36E9.var_8061 = [];
	level thread func_36E8("chyron_message1");
	level thread func_36E8("chyron_message2");
	level thread func_36E8("chyron_message3");
}

//Function Number: 35
func_36E8(param_00)
{
	for(;;)
	{
		level waittill(param_00,var_01,var_02);
		func_36E6(var_01);
	}
}

//Function Number: 36
func_36E6(param_00)
{
	level.var_36E9.var_8061[level.var_36E9.var_8061.size] = param_00;
	if(!level.var_36E9.active)
	{
		level thread func_36EA();
	}
}

//Function Number: 37
func_36EC()
{
	level.var_36E9.active = 1;
	level.var_36E9.var_805E = 0;
	level.var_36E9.var_7CEC = 0;
	level.var_36E9.var_8067 = 6;
	level.var_36E9.var_8068 = 10;
	level.var_36E9.huds = [];
	level.var_36E9.var_7CEB = [];
	level.var_36E9.last_strips = [];
	level.var_36E9.artifacts = [];
	level.var_36E9.var_770E = spawn("script_origin",level.player.origin);
	level.var_36E9.var_770E linkto(level.player);
}

//Function Number: 38
func_36EB()
{
	level.var_36E9.var_770E delete();
	level.var_36E9 = spawnstruct();
	level.var_36E9.active = 0;
	level.var_36E9.var_8061 = [];
}

//Function Number: 39
func_36EA()
{
	func_36EC();
	chyron_sound(1,"ui_chyron_on");
	thread func_7CEB(1);
	var_00 = 0.4;
	thread func_629C(1,var_00);
	wait(var_00);
	var_01 = 0;
	while(level.var_36E9.var_8061.size)
	{
		level thread func_36E7(level.var_36E9.var_8061[0],var_01);
		var_01++;
		wait(0.5);
		level.var_36E9.var_8061 = maps\_utility::func_EFF(level.var_36E9.var_8061,0);
	}

	level.var_36E9.var_805E = 0;
	wait(1);
	level.var_36E9.var_7CEC = 1;
	wait(2);
	level.var_36E9.var_7CEC = 0;
	wait(1);
	chyron_sound(1,"ui_chyron_off");
	func_31FA(1,0);
	if(level.var_36E9.var_8061.size)
	{
		level.var_36E9.var_770E delete();
		thread func_36EA();
	}

	func_36EB();
}

//Function Number: 40
func_36E7(param_00,param_01)
{
	var_02 = create_gamemessage_text(param_00,param_01);
	level.var_36E9.var_805F = var_02.x;
	level.var_36E9.var_8060 = var_02.y;
	level.var_36E9.var_805E = 1;
	var_02 thread func_629F(1);
	var_02.alpha = 1;
	var_02 setpulsefx(30,-15536,700);
	if(randomint(100) < 10)
	{
		var_02 maps\_utility::func_252F(2,::func_586B,-7,7,3,-5,5,3);
	}
}

//Function Number: 41
create_gamemessage_text(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = level.var_36E9.var_8067;
	var_02.y = level.var_36E9.var_8068 + param_01 * 20;
	var_02.horzalign = "left";
	var_02.vertalign = "top";
	var_02.sort = 3;
	var_02.foreground = 1;
	var_02 settext(param_00);
	var_02.text = param_00;
	var_02.alpha = 0;
	var_02.hidewheninmenu = 1;
	var_02.font = "default";
	var_02.fontscale = 1.25;
	if(level.console)
	{
		var_02.fontscale = 1;
	}

	var_02.color = (0.85,0.93,0.92);
	var_02.glowalpha = 0;
	level.var_36E9.huds[level.var_36E9.huds.size] = var_02;
	return var_02;
}

//Function Number: 42
stylized_line(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = create_chyron_text(param_00,param_02,param_03);
	var_07.fontscale = 2;
	var_07.horzalign = "subleft";
	var_07.vertalign = "subtop";
	var_07.aligny = "middle";
	var_07.alignx = "center";
	var_07.alpha = 1;
	var_07.sort = 3;
	if(isdefined(param_05))
	{
		var_07.glowcolor = param_05;
	}

	if(!isdefined(param_06))
	{
		param_06 = 20;
	}

	var_07 setpulsefx(param_06,-15536,700);
	var_08 = [var_07];
	var_09 = func_2B94(var_07,2);
	foreach(var_0B in var_09)
	{
		var_0B.alpha = 0;
		var_0B thread func_4309(randomfloatrange(0.5,1.5),randomfloatrange(0.05,0.2),param_01 - 0.5);
	}

	var_07 thread func_629F(0);
	var_08 = common_scripts\utility::array_combine(var_09,var_08);
	return var_08;
}

//Function Number: 43
func_4309(param_00,param_01,param_02)
{
	wait(param_00);
	self.alpha = param_01;
	thread func_4EBE(param_02 - 0.5,1);
}

//Function Number: 44
func_2B94(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_04 = newhudelem();
		var_04.x = param_00.x;
		var_04.y = param_00.y;
		var_04.alpha = param_00.alpha;
		var_04.aligny = param_00.aligny;
		var_04.alignx = param_00.alignx;
		var_04.horzalign = param_00.horzalign;
		var_04.vertalign = param_00.vertalign;
		var_04.foreground = param_00.foreground;
		var_04.hidewheninmenu = param_00.hidewheninmenu;
		var_04.fontscale = param_00.fontscale;
		var_04.sort = param_00.sort;
		var_04.color = param_00.color;
		var_04 settext(param_00.text);
		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 45
func_7D20(param_00,param_01,param_02,param_03)
{
	var_04 = newhudelem();
	var_04.x = param_01;
	var_04.y = param_02 + param_03 - 1 * 10;
	var_04.alignx = "center";
	var_04.aligny = "middle";
	var_04.horzalign = "subleft";
	var_04.vertalign = "subtop";
	var_04.sort = 1;
	var_04.foreground = 1;
	var_04.hidewheninmenu = 1;
	var_04.alpha = 0;
	var_05 = param_03 * 40 + 20;
	var_04 setshader("white",1,var_05);
	var_04.color = (0.85,0.93,0.92);
	var_04 fadeovertime(0.25);
	var_04.alpha = 0.1;
	var_04 scaleovertime(0.1,2000,var_05);
	wait(0.1);
	common_scripts\utility::func_F1B(param_00,::func_4319,0.1);
	var_06 = 0.15;
	var_04 fadeovertime(0.25);
	var_04.alpha = 0.2;
	var_04.color = (1,1,1);
	var_04 scaleovertime(var_06,2000,2);
	wait(var_06);
	var_04 scaleovertime(var_06,2,2);
	var_04 fadeovertime(var_06);
	var_04.alpha = 0;
	wait(var_06);
	var_04 destroy();
}