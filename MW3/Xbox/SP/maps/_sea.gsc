/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_sea.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 18
 * Decompile Time: 375 ms
 * Timestamp: 10/27/2023 2:34:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.var_3CA9 = 1;
	level.var_3CAA = getent("sea","targetname");
	level._sea_org = spawn("script_origin",level.var_3CAA.origin);
	level._sea_org.offset = level.var_3CAA.origin * -1;
	level._sea_org.var_3CAC = "sway2";
	level.var_3CAD = spawn("script_origin",level.var_3CAA.origin);
	level.var_3CAD.offset = level._sea_org.offset;
	level.var_3CAA linkto(level.var_3CAD);
	level.var_3CAE = getent("sea_foam","targetname");
	if(isdefined(level.var_3CAE))
	{
		level.var_3CAE linkto(level.var_3CAD);
		level.var_3CAE hide();
	}

	level.var_3CAF = getent("sea_black","targetname");
	if(isdefined(level.var_3CAF))
	{
		level.var_3CAF linkto(level.var_3CAD);
	}

	common_scripts\utility::flag_init("_sea_waves");
	common_scripts\utility::flag_init("_sea_viewbob");
	common_scripts\utility::flag_init("_sea_bob");
	common_scripts\utility::flag_set("_sea_bob");
	common_scripts\utility::flag_set("_sea_viewbob");
	var_00 = getentarray("boat_sway","script_noteworthy");
	if(isdefined(var_00))
	{
		common_scripts\utility::array_thread(var_00,::sea_objectbob,level._sea_org);
	}

	thread sea_logic();
}

//Function Number: 2
sea_logic()
{
	wait 0.05;
	var_00 = getmapsundirection();
	setsundirection(var_00);
	level.lite_settings = vectortoangles(var_00);
	level.var_3CB2 = level.lite_settings;
	level._sea_org thread func_3CC1();
	level._sea_org thread sea_waves();
	level._sea_org thread func_3CCE();
}

//Function Number: 3
func_3CB3(param_00,param_01)
{
	self.waittime = randomfloatrange(0.5,1);
	if(isdefined(self.var_3CB4))
	{
		self.scale = self.var_3CB4;
	}
	else
	{
		self.scale = randomfloatrange(2,3);
	}

	var_02 = 0;
	var_03 = 0;
	switch(param_01)
	{
		case "sway1":
			var_02 = self.var_3CB5;
			break;

		case "sway2":
			var_02 = self.var_3CB6;
			break;
	}

	if(self.var_3CB7)
	{
		var_04 = param_00.var_3CB8[0] * self.pratio * self.scale + param_00.var_3CB8[2] * self.var_3CBA * self.scale;
		if(var_02 < abs(var_04))
		{
			if(var_04 < 1)
			{
				var_03 = var_02 * -1;
			}
			else
			{
				var_03 = var_02;
			}
		}
		else
		{
			var_03 = var_04;
		}

		self.ang = (self.angles[0],self.angles[1],var_03);
		return;
	}

	self.ang = param_00.var_3CB8 * self.scale;
}

//Function Number: 4
sea_objectbob(param_00)
{
	if(isdefined(self.targetname))
	{
		var_01 = getentarray(self.targetname,"target");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_01[var_02] linkto(self);
		}
	}

	var_03 = common_scripts\utility::getstructarray(self.target,"targetname");
	var_04 = var_03[0].origin;
	var_05 = undefined;
	var_06 = spawn("script_origin",(0,0,0));
	var_06.var_3CB7 = 0;
	if(isdefined(var_03[1]))
	{
		var_05 = var_03[1].origin;
		var_06.var_3CB7 = 1;
	}
	else
	{
		var_07 = anglestoup(var_03[0].angles);
		var_07 = var_07 * 10;
		var_05 = var_04 + var_07;
	}

	var_06.origin = var_04;
	var_06.angles = vectortoangles(var_05 - var_04);
	var_06.pratio = 1;
	var_06.var_3CBA = 1;
	var_06.var_3CB5 = 100;
	var_06.var_3CB6 = 100;
	var_06.var_3CB4 = undefined;
	if(isdefined(var_03[0].script_parameters))
	{
		var_08 = strtok(var_03[0].script_parameters,":;, ");
		for(var_02 = 0;var_02 < var_08.size;var_02++)
		{
			switch(var_08[var_02])
			{
				case "axial":
					var_06.var_3CB7 = 1;
					break;

				case "sway1":
					var_02++;
					var_06.var_3CB5 = int(var_08[var_02]);
					break;

				case "sway2":
					var_02++;
					var_06.var_3CB6 = int(var_08[var_02]);
					break;

				case "setscale":
					var_02++;
					if(var_08[var_02] == "randomrange")
					{
						var_02++;
						var_09 = int(var_08[var_02]);
						var_02++;
						var_0A = int(var_08[var_02]);
						var_06.var_3CB4 = randomfloatrange(var_09,var_0A);
					}
					else
					{
						var_06.var_3CB4 = int(var_08[var_02]);
					}
					break;
			}
		}
	}

	if(var_06.var_3CB7)
	{
		var_0B = undefined;
		var_0C = (0,360,0);
		if(!isdefined(var_03[1]))
		{
			var_0B = var_03[0].angles;
		}
		else
		{
			var_0B = vectortoangles(var_05 - var_04);
		}

		var_06.var_3CBA = vectordot(anglestoright(var_0B),anglestoright(var_0C));
		var_06.pratio = vectordot(anglestoright(var_0B),anglestoforward(var_0C));
	}

	self.link = var_06;
	self notify("got_link");
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_03[var_02] thread sea_objectbob_findparent(var_06,param_00);
	}

	wait 0.05;
	self linkto(var_06);
	if(isdefined(self.script_parameters))
	{
	}

	thread func_3CBE(param_00,var_06);
}

//Function Number: 5
func_3CBE(param_00,param_01)
{
	for(;;)
	{
		if(param_00.var_3CAC == "sway2")
		{
			param_00 waittill("sway1");
		}

		param_01 func_3CB3(param_00,"sway1");
		param_01 notify("precalcdone1");
		if(!isdefined(param_01.parent))
		{
			wait param_01.waittime;
		}

		param_01 rotateto(param_01.ang,param_00.time,param_00.time * 0.5,param_00.time * 0.5);
		if(param_00.var_3CAC == "sway1")
		{
			param_00 waittill("sway2");
		}

		param_01 func_3CB3(param_00,"sway2");
		param_01 notify("precalcdone2");
		if(!isdefined(param_01.parent))
		{
			wait param_01.waittime;
		}

		param_01 rotateto(param_01.ang,param_00.time,param_00.time * 0.5,param_00.time * 0.5);
	}
}

//Function Number: 6
func_3CBF(param_00)
{
	for(;;)
	{
		self moveto(param_00.origin,0.1);
		wait 0.1;
	}
}

//Function Number: 7
sea_objectbob_findparent(param_00,param_01)
{
	if(!isdefined(self.target))
	{
		return;
	}

	param_00.parent = getent(self.target,"targetname");
	if(!isdefined(param_00.parent.link))
	{
		param_00.parent waittill("got_link");
	}

	var_02 = param_00.parent.link;
	var_03 = param_00.origin;
	var_04 = spawn("script_origin",var_02.origin);
	var_04.angles = var_02.angles;
	var_05 = spawn("script_origin",param_00.origin);
	var_05.angles = param_00.angles;
	var_05 linkto(var_04);
	param_00 thread func_3CBF(var_05);
	for(;;)
	{
		var_02 waittill("precalcdone1");
		wait var_02.waittime - 0.05;
		var_04 rotateto(var_02.ang,param_01.time,param_01.time * 0.5,param_01.time * 0.5);
		var_02 waittill("precalcdone2");
		wait var_02.waittime - 0.05;
		var_04 rotateto(var_02.ang,param_01.time,param_01.time * 0.5,param_01.time * 0.5);
	}
}

//Function Number: 8
func_3CC1()
{
	self endon("manual_override");
	common_scripts\utility::flag_wait("_sea_bob");
	thread func_3CC3();
	wait 0.05;
	for(;;)
	{
		var_00 = 0;
		var_01 = 0;
		var_02 = randomfloatrange(2,4) * level.var_3CA9;
		self.time = randomfloatrange(3,4);
		self.var_3CB8 = (var_01,var_00,var_02);
		self.var_3CAC = "sway1";
		self notify("sway1");
		if(common_scripts\utility::flag("_sea_bob"))
		{
			level.var_3CAD rotateto(self.var_3CB8,self.time,self.time * 0.5,self.time * 0.5);
		}

		self rotateto(self.var_3CB8,self.time,self.time * 0.5,self.time * 0.5);
		wait self.time;
		self.var_3CB8 = self.var_3CB8 * -1;
		self.var_3CAC = "sway2";
		self notify("sway2");
		if(common_scripts\utility::flag("_sea_bob"))
		{
			level.var_3CAD rotateto(self.var_3CB8,self.time,self.time * 0.5,self.time * 0.5);
		}

		self rotateto(self.var_3CB8,self.time,self.time * 0.5,self.time * 0.5);
		wait self.time;
	}
}

//Function Number: 9
sea_bob_reset_loop()
{
	self endon("manual_override");
	common_scripts\utility::flag_wait("_sea_bob");
	thread func_3CC3();
}

//Function Number: 10
func_3CC3()
{
	self endon("manual_override");
	level waittill("_sea_bob");
	thread sea_bob_reset_loop();
	level endon("_sea_bob");
	var_00 = 1.5;
	var_01 = (0,0,0);
	level.var_3CAD rotateto(var_01,var_00,var_00 * 0.5,var_00 * 0.5);
	wait var_00;
	wait 0.05;
	level.var_3CB2 = level.lite_settings;
	level.var_3CAD.angles = (0,0,0);
}

//Function Number: 11
sea_waves()
{
	var_00 = sea_waves_setup();
	if(!isdefined(var_00))
	{
		return;
	}

	self.var_3CC5 = [];
	for(;;)
	{
		common_scripts\utility::flag_wait("_sea_waves");
		self waittill("sway1");
		thread sea_waves_fx(var_00,"right");
		common_scripts\utility::flag_wait("_sea_waves");
		self waittill("sway2");
		thread sea_waves_fx(var_00,"left");
	}
}

//Function Number: 12
sea_waves_fx(param_00,param_01)
{
	wait self.time * 0.5;
	var_02 = 2;
	var_03 = common_scripts\utility::random(sea_closestwavearray(param_00[param_01],var_02));
	if(!isdefined(self.var_3CC5[param_01]))
	{
		self.var_3CC5[param_01] = var_03;
	}

	while(self.var_3CC5[param_01] == var_03)
	{
		wait 0.05;
		var_03 = common_scripts\utility::random(sea_closestwavearray(param_00[param_01],var_02));
	}

	self.var_3CC5[param_01] = var_03;
	var_03 thread sea_waves_fx2();
	thread common_scripts\utility::play_sound_in_space("elm_wave_crash_ext",var_03.origin);
}

//Function Number: 13
sea_waves_fx2()
{
	wait randomfloat(0.15);
	common_scripts\utility::exploder(self.exploder.v["exploder"]);
}

//Function Number: 14
sea_closestwavearray(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03].var_3CC9 = distancesquared(param_00[var_03].origin,level.player.origin);
	}

	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_02 = func_3CCA(var_02,param_00[var_03]);
	}

	var_04 = [];
	var_03 = 0;
	while(var_03 < param_01)
	{
		var_04++ = var_41[var_03];
	}

	return var_41;
}

//Function Number: 15
func_3CCA(param_00,param_01)
{
	if(!param_00.size)
	{
		param_00[0] = param_01;
		return param_00;
	}

	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02].var_3CC9 > param_01.var_3CC9)
		{
			param_00 = maps\_utility::array_insert(param_00,param_01,var_02);
			break;
		}
	}

	if(var_02 == param_00.size)
	{
		param_00 = maps\_utility::array_add(param_00,param_01);
	}

	return param_00;
}

//Function Number: 16
sea_waves_setup()
{
	var_00 = common_scripts\utility::getstructarray("wave_fx","targetname");
	var_01 = common_scripts\utility::getstruct("wave_fx_center","targetname");
	if(!var_00.size)
	{
		return undefined;
	}

	var_02 = anglestoforward(var_01.angles);
	var_03 = anglestoright(var_01.angles);
	var_04 = [];
	for(var_05 = 0;var_05 < var_01.size;var_05++ = var_41["left"])
	{
		var_01[var_05].forward = anglestoforward(var_01[var_05].angles);
		var_01[var_05].up = anglestoup(var_01[var_05].angles);
		var_01[var_05].right = anglestoright(var_01[var_05].angles);
	}

	for(var_05 = 0;var_05 < var_01.size;var_05++ = [])
	{
		if(vectordot(var_01[var_05].forward,var_04) > 0)
		{
			var_41["right"][var_41["right"].size] = var_01[var_05];
			continue;
		}

		var_41["left"][var_41["left"].size] = var_01[var_05];
	}

	var_06 = level.var_3CCC;
	for(var_05 = 0;var_05 < var_06.size;var_05++ = var_41["right"])
	{
		var_06[var_05].origin = var_06[var_05].v["origin"];
	}

	for(var_05 = 0;var_05 < var_41["right"].size;var_05++ = [])
	{
		var_07 = maps\_utility::getclosest(var_41["right"][var_05].origin,var_06,64);
		var_06 = common_scripts\utility::array_remove(var_06,var_07);
		if(isdefined(var_41["right"][var_05].angles))
		{
			var_07.v["forward"] = anglestoup(var_41["right"][var_05].angles);
		}

		var_41["right"][var_05].exploder = var_07;
	}

	for(var_05 = 0;var_05 < var_41["left"].size;var_05++)
	{
		var_07 = maps\_utility::getclosest(var_41["left"][var_05].origin,var_06,64);
		var_06 = common_scripts\utility::array_remove(var_06,var_07);
		if(isdefined(var_41["left"][var_05].angles))
		{
			var_07.v["forward"] = anglestoup(var_41["left"][var_05].angles);
		}

		var_41["left"][var_05].exploder = var_07;
	}

	return var_41;
}

//Function Number: 17
sea_litebob()
{
	for(;;)
	{
		wait 0.2;
		var_00 = self.angles * 2;
		var_00 = (var_00[0],var_00[1],var_00[2]);
		var_01 = level.var_3CB2;
		level.var_3CB2 = combineangles(var_00,level.lite_settings);
		var_02 = level.var_3CB2;
		var_03 = anglestoforward(var_01);
		var_04 = anglestoforward(var_02);
		lerpsundirection(var_03,var_04,0.2);
	}
}

//Function Number: 18
func_3CCE()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("_sea_viewbob");
		level.player playersetgroundreferenceent(self);
		if(common_scripts\utility::flag("_sea_viewbob"))
		{
			level waittill("_sea_viewbob");
		}

		level.player playersetgroundreferenceent(undefined);
	}
}