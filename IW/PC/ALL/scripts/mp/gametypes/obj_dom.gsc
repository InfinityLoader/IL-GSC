/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\obj_dom.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 1006 ms
 * Timestamp: 10/27/2023 12:12:56 AM
*******************************************************************/

//Function Number: 1
func_591D(param_00)
{
	var_01 = level.var_C2A8[param_00];
	if(isdefined(var_01.target))
	{
		var_02[0] = getent(var_01.target,"targetname");
	}
	else
	{
		param_00[0] = spawn("script_model",var_02.origin);
		var_02[0].angles = var_01.angles;
	}

	level.var_6E65 = scripts\mp\_utility::dvarfloatvalue("flagCaptureTime",10,0,30);
	var_03 = scripts\mp\_gameobjects::func_4A2E("neutral",var_01,var_02,(0,0,100));
	var_03 scripts\mp\_gameobjects::func_1CAF("enemy");
	var_03 scripts\mp\_gameobjects::cancontestclaim(1);
	var_03 scripts\mp\_gameobjects::func_FB08(level.var_6E65);
	var_03 scripts\mp\_gameobjects::func_FB07(&"MP_SECURING_POSITION");
	var_04 = var_03 scripts\mp\_gameobjects::getlabel();
	var_03.label = var_04;
	var_03 scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + var_04,level.iconneutral + var_04);
	var_03 scripts\mp\_gameobjects::setvisibleteam("any");
	var_03.var_C5BB = ::func_5917;
	var_03.var_C4CB = ::func_5918;
	var_03.var_C5C8 = ::func_591A;
	var_03.var_C50D = ::func_5919;
	var_03.var_C4D9 = ::dompoint_oncontested;
	var_03.var_C5B9 = ::dompoint_onuncontested;
	var_03.var_C18B = 1;
	var_03.var_92B8 = "domFlag";
	var_03.var_3FF7 = level.var_6E65 * 1000;
	var_03.var_6DE3 = 1;
	var_05 = var_02[0].origin + (0,0,32);
	var_06 = var_02[0].origin + (0,0,-32);
	var_07 = scripts\common\trace::func_48BC(1,1,1,1,0,1,1);
	var_08 = [];
	var_09 = scripts\common\trace::func_DCED(var_05,var_06,var_08,var_07);
	var_0A = checkmapoffsets(var_03.label);
	var_03.var_289D = var_09["position"] + var_0A;
	var_0B = vectortoangles(var_09["normal"]);
	var_0C = checkmapfxangles(var_03.label,var_0B);
	var_03.var_289C = anglestoforward(var_0C);
	var_0D = spawn("script_model",var_03.var_289D);
	var_0D setmodel("dom_flag_scriptable");
	var_0D.angles = function_02D7(var_03.var_289C,var_0D.angles);
	var_03.var_289 = var_0D;
	var_03.vfxnamemod = "";
	if(var_03.trigger.var_257 == 160)
	{
		var_03.vfxnamemod = "_160";
	}
	else if(var_03.trigger.var_257 == 90)
	{
		var_03.vfxnamemod = "_90";
	}

	var_03 func_987B();
	var_03 scripts\common\utility::func_5127(1,::func_5912);
	return var_03;
}

//Function Number: 2
checkmapoffsets(param_00)
{
	var_01 = (0,0,0);
	if(level.var_B335 == "mp_quarry")
	{
		if(param_00 == "_c")
		{
			var_01 = var_01 + (0,0,7);
		}
	}

	if(level.var_B335 == "mp_divide")
	{
		if(param_00 == "_a")
		{
			var_01 = var_01 + (0,0,4.5);
		}
	}

	if(level.var_B335 == "mp_afghan")
	{
		if(param_00 == "_a")
		{
			var_01 = var_01 + (0,0,5);
		}

		if(param_00 == "_c")
		{
			var_01 = var_01 + (0,0,1);
		}
	}

	return var_01;
}

//Function Number: 3
checkmapfxangles(param_00,param_01)
{
	var_02 = param_01;
	if(level.var_B335 == "mp_quarry")
	{
		if(param_00 == "_c")
		{
			var_02 = (276.5,var_02[1],var_02[2]);
		}
	}

	if(level.var_B335 == "mp_divide")
	{
		if(param_00 == "_a")
		{
			var_02 = (273.5,var_02[1],var_02[2]);
		}
	}

	if(level.var_B335 == "mp_afghan")
	{
		if(param_00 == "_a")
		{
			var_02 = (273.5,200.5,var_02[2]);
		}

		if(param_00 == "_c")
		{
			var_02 = (273.5,var_02[1],var_02[2]);
		}
	}

	return var_02;
}

//Function Number: 4
func_987B()
{
	if(isdefined(level.var_B3FB))
	{
		self.var_AFC1 = [[ level.var_B3F3 ]]();
		var_00 = "A";
		switch(self.label)
		{
			case "_a":
				var_00 = "A";
				break;

			case "_b":
				var_00 = "B";
				break;

			case "_c":
				var_00 = "C";
				break;

			default:
				break;
		}

		self.var_AFB6 = "FLAG_" + var_00;
	}

	if(scripts\mp\_analyticslog::func_1E62())
	{
		self.var_1E63 = scripts\mp\_analyticslog::func_81EE();
		self.var_1E64 = "dom_flag" + self.label;
	}
}

//Function Number: 5
func_5912(param_00)
{
	self notify("flag_neutral");
	scripts\mp\_gameobjects::func_F7D4("neutral");
	scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral + self.label);
	updateflagstate("idle",param_00);
	if(isdefined(level.var_B3FB) && isdefined(self.var_AFC1) && isdefined(self.var_AFB6))
	{
		[[ level.var_B3FB ]](self.var_AFC1,undefined,self.var_AFB6,self.visuals[0].origin[0],self.visuals[0].origin[1],gettime(),0);
	}

	scripts\mp\_analyticslog::func_AFA0(self.var_1E64,self.var_1E63,self.visuals[0].origin,-1,"neutral");
}

//Function Number: 6
func_591B(param_00)
{
	scripts\mp\_gameobjects::func_F7D4(param_00);
	scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
	self.var_BEF4 = 0;
	updateflagstate(param_00,0);
	if(isdefined(level.var_B3FB))
	{
		[[ level.var_B3FB ]](self.var_AFC1,undefined,self.var_AFB6,self.visuals[0].origin[0],self.visuals[0].origin[1],gettime(),scripts\common\utility::func_116D7(param_00 == "allies",1,2));
	}

	scripts\mp\_analyticslog::func_AFA0(self.var_1E64,self.var_1E63,self.visuals[0].origin,-1,"captured_" + param_00);
}

//Function Number: 7
func_5917(param_00)
{
	var_01 = param_00.team;
	var_02 = scripts\mp\_gameobjects::func_803E();
	self.var_3A40 = gettime();
	self.var_BEF4 = 0;
	if(level.var_6E68)
	{
		var_03 = scripts\mp\_gameobjects::func_803E();
		if(var_03 == "neutral")
		{
			func_591B(var_01);
		}
		else
		{
			thread func_5912(1);
			scripts\mp\_utility::playsoundonplayers("mp_dom_flag_lost",var_03);
			level.var_A94F = gettime();
			thread func_8365(self.touchlist[var_01]);
			self.var_BEF4 = 1;
		}
	}
	else
	{
		func_591B(var_01);
	}

	if(!self.var_BEF4)
	{
		var_04 = 3;
		if(self.label == "_a")
		{
			var_04 = 1;
		}
		else if(self.label == "_b")
		{
			var_04 = 2;
		}

		scripts\mp\_utility::func_F79E(19,var_01,param_00 getentitynumber(),var_04);
		if(isdefined(level.var_C561))
		{
			[[ level.var_C561 ]]("dompoint",self.label,param_00,var_01,var_02,self);
		}

		self.var_6DE3 = 0;
	}
}

//Function Number: 8
func_5918(param_00)
{
	var_01 = scripts\mp\_gameobjects::func_803E();
	self.neutralizing = level.var_6E68 && var_01 != "neutral";
	if(!scripts\mp\_utility::func_9FB3(self.var_BEF4))
	{
		self.var_54C5 = 0;
	}

	var_02 = scripts\common\utility::func_116D7(level.var_6E68,level.var_6E65 * 0.5,level.var_6E65);
	scripts\mp\_gameobjects::func_FB08(var_02);
	thread scripts\mp\_gameobjects::func_130AE(param_00.team);
	if(var_02 > 0)
	{
		self.var_D8BA = level.var_C74B[param_00.team];
		updateflagcapturestate(param_00.team);
		scripts\mp\_gameobjects::setzonestatusicons(level.iconlosing + self.label,level.icontaking + self.label);
	}
}

//Function Number: 9
func_591A(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_gameobjects::func_803E();
	if(param_01 > 0.05 && param_02 && !self.var_54C5)
	{
		if(var_04 == "neutral")
		{
			if(level.var_6E65 > 0.05)
			{
				scripts\mp\_utility::func_10E60("securing" + self.label,param_00);
			}
		}
		else if(level.var_6E65 > 0.05)
		{
			scripts\mp\_utility::func_10E60("losing" + self.label,var_04,1);
			scripts\mp\_utility::func_10E60("securing" + self.label,param_00);
		}

		self.var_54C5 = 1;
	}
}

//Function Number: 10
func_5919(param_00,param_01,param_02)
{
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_objective_state",0);
		param_01.var_12B1D = undefined;
	}

	var_03 = scripts\mp\_gameobjects::func_803E();
	if(var_03 == "neutral")
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral + self.label);
		updateflagstate("idle",0);
	}
	else
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
		updateflagstate(var_03,0);
	}

	if(!param_02)
	{
		self.var_BEF4 = 0;
	}
}

//Function Number: 11
dompoint_oncontested()
{
	scripts\mp\_gameobjects::setzonestatusicons(level.iconcontested + self.label);
	updateflagstate("contested",0);
}

//Function Number: 12
dompoint_onuncontested(param_00)
{
	var_01 = scripts\mp\_gameobjects::func_803E();
	if(param_00 == "none" || var_01 == "neutral")
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.iconneutral + self.label);
		self.var_54C5 = 0;
	}
	else
	{
		scripts\mp\_gameobjects::setzonestatusicons(level.icondefend + self.label,level.iconcapture + self.label);
	}

	var_02 = scripts\common\utility::func_116D7(var_01 == "neutral","idle",var_01);
	updateflagstate(var_02,0);
}

//Function Number: 13
func_F6A9(param_00)
{
	if(isdefined(level.var_112C0) && level.var_112C0 && isdefined(param_00.var_47ED) && param_00.var_47ED)
	{
		param_00 scripts\mp\_utility::func_F6A8("assist");
	}
}

//Function Number: 14
func_591C()
{
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = scripts\mp\_teams::func_81AE("allies");
	game["flagmodels"]["axis"] = scripts\mp\_teams::func_81AE("axis");
}

//Function Number: 15
updateflagstate(param_00,param_01)
{
	self.var_289 setscriptablepartstate("flag",param_00 + self.vfxnamemod);
	if(!scripts\mp\_utility::func_9FB3(param_01))
	{
		self.var_289 setscriptablepartstate("pulse","off");
	}
}

//Function Number: 16
updateflagcapturestate(param_00)
{
	self.var_289 setscriptablepartstate("pulse",param_00 + self.vfxnamemod);
}

//Function Number: 17
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_11E8 = [];
		var_00.var_11E9 = [];
		var_00 thread func_C4F5();
	}
}

//Function Number: 18
func_C4F5()
{
	self waittill("disconnect");
	foreach(var_01 in self.var_11E8)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}

	foreach(var_04 in self.var_11E9)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}
}

//Function Number: 19
func_8365(param_00)
{
	level endon("game_ended");
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = param_00[var_01[var_02]].player;
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.var_222))
		{
			var_03 = var_03.var_222;
		}

		if(!isplayer(var_03))
		{
			continue;
		}

		var_03 thread scripts\mp\_awards::func_8380("mode_dom_neutralized");
		var_03 setclientomnvar("ui_objective_progress",0.01);
		var_03 func_F6A9(var_03);
		wait(0.05);
	}
}