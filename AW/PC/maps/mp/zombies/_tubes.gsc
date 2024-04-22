/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_tubes.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 86 ms
 * Timestamp: 4/22/2024 2:14:03 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = common_scripts\utility::getstructarray("zombie_tube","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getentarray(var_02.target,"targetname");
		var_04 = common_scripts\utility::getstructarray(var_02.target,"targetname");
		var_05 = common_scripts\utility::array_combine(var_03,var_04);
		foreach(var_07 in var_05)
		{
			var_08 = var_07.script_noteworthy;
			if(!isdefined(var_08))
			{
				continue;
			}

			switch(var_08)
			{
				case "door_rotate":
					var_02.door = var_07;
					var_02.door linktargets();
					var_02.door.closeangles = var_07.angles;
					var_02.door.openangles = var_07.angles + (0,180,0);
					break;

				case "trigger":
					var_02.trigger = var_07;
					break;

				case "start":
					var_02.start = var_07;
					var_02.startend = common_scripts\utility::getstruct(var_02.start.target,"targetname");
					var_02.endstart = common_scripts\utility::getstruct(var_02.startend.target,"targetname");
					var_02.end = common_scripts\utility::getstruct(var_02.endstart.target,"targetname");
					break;

				default:
					break;
			}
		}

		var_02 thread runtube();
	}
}

//Function Number: 2
linktargets()
{
	if(!isdefined(self.target))
	{
		return;
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 linkto(self);
	}
}

//Function Number: 3
runtube()
{
	var_00 = 0.3;
	var_01 = 200;
	if(isdefined(self.script_flag_true))
	{
		common_scripts\utility::flag_wait(self.script_flag_true);
	}

	if(isdefined(self.door))
	{
		var_02 = 0.5;
		self.door rotateto(self.door.openangles,var_02);
		wait(var_02);
	}

	for(;;)
	{
		self.trigger sethintstring(&"ZOMBIE_H2O_USE_TUBE");
		self.trigger setcursorhint("HINT_NOICON");
		self.trigger waittill("trigger",var_03);
		self.trigger sethintstring("");
		var_03 setstance("stand");
		var_03.inteleport = 1;
		if(isdefined(self.door))
		{
			self.door rotateto(self.door.closeangles,var_00);
		}

		var_04 = spawn("script_model",var_03.origin);
		var_04.angles = (0,var_03.angles[1],0);
		var_04 setmodel("tag_origin");
		var_03 playerlinkto(var_04,"tag_origin",var_00);
		thread maps\mp\mp_zombie_h2o_aud::sndtubestart(var_04,var_03);
		var_04 moveto(self.start.origin,var_00);
		wait(var_00);
		var_05 = distance(var_04.origin,self.startend.origin) / var_01;
		var_04 moveto(self.startend.origin,var_05,var_05,0);
		var_06 = anglesdelta(var_04.angles,self.startend.angles);
		if(var_06 > 0)
		{
			var_04 rotateto(self.startend.angles,var_05);
		}

		var_03 thread playertubevo();
		wait(var_05);
		if(isdefined(self.door))
		{
			self.door rotateto(self.door.openangles,var_00);
		}

		thread endtube(var_04,var_03,var_01);
	}
}

//Function Number: 4
endtube(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 dontinterpolate();
	}

	param_00 dontinterpolate();
	param_00.origin = self.endstart.origin;
	param_00.angles = self.endstart.angles;
	var_03 = distance(param_00.origin,self.end.origin) / param_02;
	param_00 moveto(self.end.origin,var_03,var_03,0);
	thread maps\mp\mp_zombie_h2o_aud::sndtubeend(self.end.origin,param_01);
	var_04 = anglesdelta(param_00.angles,self.end.angles);
	if(var_04 > 0)
	{
		param_00 rotateto(self.end.angles,var_03);
	}

	wait(var_03);
	if(isdefined(param_01))
	{
		param_01 unlink();
		param_01.inteleport = 0;
	}

	param_00 delete();
}

//Function Number: 5
playertubevo()
{
	thread maps\mp\zombies\_zombies_audio::create_and_play_dialog_delay("monologue","tube",undefined,undefined,undefined,0.5);
}