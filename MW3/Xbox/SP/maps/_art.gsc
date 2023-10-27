/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_art.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 40
 * Decompile Time: 696 ms
 * Timestamp: 10/27/2023 2:34:06 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("scr_cmd_plr_sun") == "")
	{
	}

	if(getdvar("scr_dof_enable") == "")
	{
		setsaveddvar("scr_dof_enable","1");
	}

	if(getdvar("scr_cinematic_autofocus") == "")
	{
		setdvar("scr_cinematic_autofocus","1");
	}

	setdvarifuninitialized("scr_glowTweakEnable",1);
	setdvarifuninitialized("scr_glowTweakRadius0",7);
	setdvarifuninitialized("scr_glowTweakBloomCutoff",0.99);
	setdvarifuninitialized("scr_glowTweakBloomDesaturation",0.65);
	setdvarifuninitialized("scr_glowTweakBloomIntensity0",0.36);
	setdvarifuninitialized("scr_filmTweakEnable",1);
	setdvarifuninitialized("scr_filmTweakContrast",1.45);
	setdvarifuninitialized("scr_filmTweakBrightness",0.15);
	setdvarifuninitialized("scr_filmTweakDesaturation",0.4);
	setdvarifuninitialized("scr_filmTweakDesaturationDark",0.4);
	setdvarifuninitialized("scr_filmTweakInvert",0);
	setdvarifuninitialized("scr_filmTweakLightTint","1.14 1.07 0.877");
	setdvarifuninitialized("scr_filmTweakMediumTint","1.16 .74 .69");
	setdvarifuninitialized("scr_filmTweakDarkTint","0.7 0.76 0.86");
	setdvarifuninitialized("scr_primaryLightUseTweaks",1);
	setdvarifuninitialized("scr_primaryLightTweakDiffuseStrength",1);
	setdvarifuninitialized("scr_primaryLightTweakSpecularStrength",1);
	level._clearalltextafterhudelem = 0;
	level.dofdefault["nearStart"] = 1;
	level.dofdefault["nearEnd"] = 1;
	level.dofdefault["farStart"] = 500;
	level.dofdefault["farEnd"] = 500;
	level.dofdefault["nearBlur"] = 4.5;
	level.dofdefault["farBlur"] = 0.05;
	precachemenu("dev_vision_noloc");
	precachemenu("dev_vision_exec");
	var_00 = getdvarint("scr_dof_enable");
	level.special_weapon_dof_funcs = [];
	level.var_167E = [];
	if(!isdefined(level.vision_set_vision))
	{
		level.vision_set_vision = [];
	}

	if(!isdefined(level.vision_set_transition_ent))
	{
		level.vision_set_transition_ent = spawnstruct();
		level.vision_set_transition_ent.vision_set = "";
		level.vision_set_transition_ent.time = 0;
	}

	if(!isdefined(level.vision_set_fog))
	{
		level.vision_set_fog = [];
		func_16AF(level.script);
		common_scripts\_artcommon::func_166D();
	}

	foreach(var_03, var_02 in level.vision_set_fog)
	{
		create_vision_set_vision(var_03);
	}

	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		var_05 = level.players[var_04];
		var_05.curdof = level.dofdefault["farStart"] - level.dofdefault["nearEnd"] / 2;
		if(var_00)
		{
			var_05 thread adsdof();
		}
	}

	thread func_1684();
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}
}

//Function Number: 2
func_1684()
{
}

//Function Number: 3
button_down(param_00,param_01)
{
	var_02 = level.player buttonpressed(param_00);
	if(!var_02)
	{
		var_02 = level.player buttonpressed(param_01);
	}

	if(!isdefined(level.var_167E[param_00]))
	{
		level.var_167E[param_00] = 0;
	}

	if(gettime() < level.var_167E[param_00])
	{
		return 0;
	}

	level.var_167E[param_00] = gettime() + 400;
	return var_02;
}

//Function Number: 4
create_vision_set_vision(param_00)
{
	if(!isdefined(level.vision_set_vision))
	{
		level.vision_set_vision = [];
	}

	var_01 = spawnstruct();
	var_01.name = param_00;
	level.vision_set_vision[param_00] = var_01;
	return var_01;
}

//Function Number: 5
updatefogentfromscript()
{
	if(!isdefined(level.vision_set_fog))
	{
	}

	var_00 = level.vision_set_fog[level.vision_set_transition_ent.vision_set];
	if(isdefined(var_00.name))
	{
		var_00.var_1688 = level.fognearplane;
		var_00.var_1689 = level.fogexphalfplane;
		var_00.red = level.fogcolor[0];
		var_00.green = level.fogcolor[1];
		var_00.blue = level.fogcolor[2];
		var_00.maxopacity = level.fogmaxopacity;
		var_00.sunfogenabled = 0;
		if(level.sunfogenabled)
		{
			var_00.sunfogenabled = 1;
			var_00.var_168E = level.sunfogcolor[0];
			var_00.sungreen = level.sunfogcolor[1];
			var_00.sunblue = level.sunfogcolor[2];
			var_00.sundir = level.var_1675;
			var_00.sunbeginfadeangle = level.var_1676;
			var_00.var_1693 = level.sunfogendfadeangle;
			var_00.normalfogscale = level.sunfogscale;
		}

		if(getdvarint("scr_fog_disable"))
		{
			var_00.var_1688 = 1215752192;
			var_00.var_1689 = 1215752193;
			var_00.red = 0;
			var_00.green = 0;
			var_00.blue = 0;
			var_00.maxopacity = 0;
		}

		maps\_utility::set_fog_to_ent_values(var_00,0);
	}
}

//Function Number: 6
func_1696()
{
	if(!isdefined(level.vision_set_vision))
	{
		return;
	}

	if(!isdefined(level.vision_set_transition_ent))
	{
		return;
	}

	if(!isdefined(level.vision_set_transition_ent.vision_set))
	{
		return;
	}

	if(!isdefined(level.vision_set_vision[level.vision_set_transition_ent.vision_set]))
	{
		return;
	}

	var_00 = level.vision_set_vision[level.vision_set_transition_ent.vision_set];
	if(!isdefined(var_00.selected))
	{
		return;
	}

	var_00.r_glow = getdvar("r_glowTweakEnable");
	var_00.r_glowradius0 = getdvar("r_glowTweakRadius0");
	var_00.r_glowbloomcutoff = getdvar("r_glowTweakBloomCutoff");
	var_00.r_glowbloomdesaturation = getdvar("r_glowTweakBloomDesaturation");
	var_00.r_glowbloomintensity0 = getdvar("r_glowTweakBloomIntensity0");
	var_00.r_filmenable = getdvar("r_filmTweakEnable");
	var_00.r_filmcontrast = getdvar("r_filmTweakContrast");
	var_00.var_169F = getdvar("r_filmTweakBrightness");
	var_00.var_16A0 = getdvar("r_filmTweakDesaturation");
	var_00.r_filmdesaturationdark = getdvar("r_filmTweakDesaturationDark");
	var_00.r_filminvert = getdvar("r_filmTweakInvert");
	var_00.var_16A3 = getdvar("r_filmTweakLightTint");
	var_00.r_filmmediumtint = getdvar("r_filmTweakMediumTint");
	var_00.r_filmdarktint = getdvar("r_filmTweakDarkTint");
	var_00.r_primarylightusetweaks = getdvar("r_primaryLightUseTweaks");
	var_00.r_primarylighttweakdiffusestrength = getdvar("r_primaryLightTweakDiffuseStrength");
	var_00.var_16A8 = getdvar("r_primaryLightTweakSpecularStrength");
}

//Function Number: 7
fovslidercheck()
{
	if(level.dofdefault["nearStart"] >= level.dofdefault["nearEnd"])
	{
		level.dofdefault["nearStart"] = level.dofdefault["nearEnd"] - 1;
		setdvar("scr_dof_nearStart",level.dofdefault["nearStart"]);
	}

	if(level.dofdefault["nearEnd"] <= level.dofdefault["nearStart"])
	{
		level.dofdefault["nearEnd"] = level.dofdefault["nearStart"] + 1;
		setdvar("scr_dof_nearEnd",level.dofdefault["nearEnd"]);
	}

	if(level.dofdefault["farStart"] >= level.dofdefault["farEnd"])
	{
		level.dofdefault["farStart"] = level.dofdefault["farEnd"] - 1;
		setdvar("scr_dof_farStart",level.dofdefault["farStart"]);
	}

	if(level.dofdefault["farEnd"] <= level.dofdefault["farStart"])
	{
		level.dofdefault["farEnd"] = level.dofdefault["farStart"] + 1;
		setdvar("scr_dof_farEnd",level.dofdefault["farEnd"]);
	}

	if(level.dofdefault["farBlur"] >= level.dofdefault["nearBlur"])
	{
		level.dofdefault["farBlur"] = level.dofdefault["nearBlur"] - 0.1;
		setdvar("scr_dof_farBlur",level.dofdefault["farBlur"]);
	}

	if(level.dofdefault["farStart"] <= level.dofdefault["nearEnd"])
	{
		level.dofdefault["farStart"] = level.dofdefault["nearEnd"] + 1;
		setdvar("scr_dof_farStart",level.dofdefault["farStart"]);
	}
}

//Function Number: 8
fogslidercheck()
{
	if(level.var_1676 >= level.sunfogendfadeangle)
	{
		level.var_1676 = level.sunfogendfadeangle - 1;
		setdvar("scr_sunFogBeginFadeAngle",level.var_1676);
	}

	if(level.sunfogendfadeangle <= level.var_1676)
	{
		level.sunfogendfadeangle = level.var_1676 + 1;
		setdvar("scr_sunFogEndFadeAngle",level.sunfogendfadeangle);
	}
}

//Function Number: 9
construct_vision_ents()
{
	if(!isdefined(level.vision_set_fog))
	{
		level.vision_set_fog = [];
	}

	var_00 = getentarray("trigger_multiple_visionset","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_visionset))
		{
			func_16AE(var_02.script_visionset);
		}

		if(isdefined(var_02.script_visionset_start))
		{
			func_16AE(var_02.script_visionset_start);
		}

		if(isdefined(var_02.script_visionset_end))
		{
			func_16AE(var_02.script_visionset_end);
		}
	}
}

//Function Number: 10
func_16AE(param_00)
{
	if(isdefined(level.vision_set_fog[param_00]))
	{
		return;
	}

	func_16AF(param_00);
	create_vision_set_vision(param_00);
	iprintlnbold("new vision: " + param_00);
}

//Function Number: 11
func_16AF(param_00)
{
	var_01 = maps\_utility::func_16B0(param_00);
	var_01.var_1688 = 3764.17;
	var_01.var_1689 = 19391;
	var_01.red = 0.661137;
	var_01.green = 0.554261;
	var_01.blue = 0.454014;
	var_01.maxopacity = 0.7;
	var_01.transitiontime = 0;
}

//Function Number: 12
func_16B2()
{
}

//Function Number: 13
print_current_vision()
{
	var_00 = level.vision_set_vision[level.vision_set_transition_ent.vision_set];
	if(!isdefined(var_00.name))
	{
		return;
	}

	common_scripts\utility::fileprint_launcher_start_file();
	common_scripts\utility::fileprint_launcher("r_glow                    \" + getdvar("r_glowTweakEnable") + "\");
	common_scripts\utility::fileprint_launcher("r_glowRadius0             \" + getdvar("r_glowTweakRadius0") + "\");
	common_scripts\utility::fileprint_launcher("r_glowBloomCutoff         \" + getdvar("r_glowTweakBloomCutoff") + "\");
	common_scripts\utility::fileprint_launcher("r_glowBloomDesaturation   \" + getdvar("r_glowTweakBloomDesaturation") + "\");
	common_scripts\utility::fileprint_launcher("r_glowBloomIntensity0     \" + getdvar("r_glowTweakBloomIntensity0") + "\");
	common_scripts\utility::fileprint_launcher(" ");
	common_scripts\utility::fileprint_launcher("r_filmEnable              \" + getdvar("r_filmTweakEnable") + "\");
	common_scripts\utility::fileprint_launcher("r_filmContrast            \" + getdvar("r_filmTweakContrast") + "\");
	common_scripts\utility::fileprint_launcher("r_filmBrightness          \" + getdvar("r_filmTweakBrightness") + "\");
	common_scripts\utility::fileprint_launcher("r_filmDesaturation        \" + getdvar("r_filmTweakDesaturation") + "\");
	common_scripts\utility::fileprint_launcher("r_filmDesaturationDark    \" + getdvar("r_filmTweakDesaturationDark") + "\");
	common_scripts\utility::fileprint_launcher("r_filmInvert              \" + getdvar("r_filmTweakInvert") + "\");
	common_scripts\utility::fileprint_launcher("r_filmLightTint           \" + getdvar("r_filmTweakLightTint") + "\");
	common_scripts\utility::fileprint_launcher("r_filmMediumTint          \" + getdvar("r_filmTweakMediumTint") + "\");
	common_scripts\utility::fileprint_launcher("r_filmDarkTint            \" + getdvar("r_filmTweakDarkTint") + "\");
	common_scripts\utility::fileprint_launcher(" ");
	common_scripts\utility::fileprint_launcher("r_primaryLightUseTweaks              \" + getdvar("r_primaryLightUseTweaks") + "\");
	common_scripts\utility::fileprint_launcher("r_primaryLightTweakDiffuseStrength   \" + getdvar("r_primaryLightTweakDiffuseStrength") + "\");
	common_scripts\utility::fileprint_launcher("r_primaryLightTweakSpecularStrength  \" + getdvar("r_primaryLightTweakSpecularStrength") + "\");
	common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\vision\\" + var_00.name + ".vision",1);
}

//Function Number: 14
print_fog_ents()
{
	foreach(var_01 in level.vision_set_fog)
	{
		if(!isdefined(var_01.name))
		{
			continue;
		}

		common_scripts\utility::fileprint_launcher("\tent = maps\\_utility::create_vision_set_fog( \" + var_01.name + "\" );");
		if(isdefined(var_01.var_1688))
		{
			common_scripts\utility::fileprint_launcher("\tent.startDist = " + var_01.var_1688 + ";");
		}

		if(isdefined(var_01.var_1689))
		{
			common_scripts\utility::fileprint_launcher("\tent.halfwayDist = " + var_01.var_1689 + ";");
		}

		if(isdefined(var_01.red))
		{
			common_scripts\utility::fileprint_launcher("\tent.red = " + var_01.red + ";");
		}

		if(isdefined(var_01.green))
		{
			common_scripts\utility::fileprint_launcher("\tent.green = " + var_01.green + ";");
		}

		if(isdefined(var_01.blue))
		{
			common_scripts\utility::fileprint_launcher("\tent.blue = " + var_01.blue + ";");
		}

		if(isdefined(var_01.maxopacity))
		{
			common_scripts\utility::fileprint_launcher("\tent.maxOpacity = " + var_01.maxopacity + ";");
		}

		if(isdefined(var_01.transitiontime))
		{
			common_scripts\utility::fileprint_launcher("\tent.transitionTime = " + var_01.transitiontime + ";");
		}

		if(isdefined(var_01.sunfogenabled))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunFogEnabled = " + var_01.sunfogenabled + ";");
		}

		if(isdefined(var_01.var_168E))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunRed = " + var_01.var_168E + ";");
		}

		if(isdefined(var_01.sungreen))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunGreen = " + var_01.sungreen + ";");
		}

		if(isdefined(var_01.sunblue))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunBlue = " + var_01.sunblue + ";");
		}

		if(isdefined(var_01.sundir))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunDir = " + var_01.sundir + ";");
		}

		if(isdefined(var_01.sunbeginfadeangle))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunBeginFadeAngle = " + var_01.sunbeginfadeangle + ";");
		}

		if(isdefined(var_01.var_1693))
		{
			common_scripts\utility::fileprint_launcher("\tent.sunEndFadeAngle = " + var_01.var_1693 + ";");
		}

		if(isdefined(var_01.normalfogscale))
		{
			common_scripts\utility::fileprint_launcher("\tent.normalFogScale = " + var_01.normalfogscale + ";");
		}

		common_scripts\utility::fileprint_launcher(" ");
	}
}

//Function Number: 15
print_fog_ents_csv()
{
	foreach(var_01 in level.vision_set_fog)
	{
		if(!isdefined(var_01.name))
		{
			continue;
		}

		common_scripts\utility::fileprint_launcher("rawfile,vision/" + var_01.name + ".vision");
	}
}

//Function Number: 16
cloudlight(param_00,param_01,param_02,param_03)
{
	level.sunlight_bright = param_00;
	level.sunlight_dark = param_01;
	level.var_16B9 = param_02;
	level.var_16BA = param_03;
	setdvar("r_lighttweaksunlight",level.sunlight_dark);
	setdvar("r_lighttweakdiffusefraction",level.var_16BA);
	var_04 = "up";
	for(;;)
	{
		var_05 = getdvarfloat("r_lighttweaksunlight");
		var_06 = scale(1 + randomint(21));
		var_07 = randomint(2);
		if(var_07)
		{
			var_06 = var_06 * -1;
		}

		if(var_04 == "up")
		{
			var_08 = var_05 + scale(30) + var_06;
		}
		else
		{
			var_08 = var_05 - scale(30) + var_06;
		}

		if(var_08 >= level.sunlight_bright)
		{
			var_08 = level.sunlight_bright;
			var_04 = "down";
		}

		if(var_08 <= level.sunlight_dark)
		{
			var_08 = level.sunlight_dark;
			var_04 = "up";
		}

		if(var_08 > var_05)
		{
			brighten(var_08,3 + randomint(3),0.05);
			continue;
		}

		func_16BC(var_08,3 + randomint(3),0.05);
	}
}

//Function Number: 17
brighten(param_00,param_01,param_02)
{
	var_03 = getdvarfloat("r_lighttweaksunlight");
	var_04 = param_00 - var_03;
	var_05 = var_04 / param_01 / param_02;
	while(param_01 > 0)
	{
		param_01 = param_01 - param_02;
		var_03 = var_03 + var_05;
		setdvar("r_lighttweaksunlight",var_03);
		var_06 = var_03 - level.sunlight_dark / level.sunlight_bright - level.sunlight_dark;
		var_07 = level.var_16B9 + level.var_16BA - level.var_16B9 * var_06;
		setdvar("r_lighttweakdiffusefraction",var_07);
		wait param_02;
	}
}

//Function Number: 18
func_16BC(param_00,param_01,param_02)
{
	var_03 = getdvarfloat("r_lighttweaksunlight");
	var_04 = var_03 - param_00;
	var_05 = var_04 / param_01 / param_02;
	while(param_01 > 0)
	{
		param_01 = param_01 - param_02;
		var_03 = var_03 - var_05;
		setdvar("r_lighttweaksunlight",var_03);
		var_06 = var_03 - level.sunlight_dark / level.sunlight_bright - level.sunlight_dark;
		var_07 = level.var_16B9 + level.var_16BA - level.var_16B9 * var_06;
		setdvar("r_lighttweakdiffusefraction",var_07);
		wait param_02;
	}
}

//Function Number: 19
scale(param_00)
{
	var_01 = param_00 / 100;
	return level.sunlight_dark + var_01 * level.sunlight_bright - level.sunlight_dark - level.sunlight_dark;
}

//Function Number: 20
adsdof()
{
	self.dof = level.dofdefault;
	var_00 = 0;
	for(;;)
	{
		wait 0.05;
		if(level.level_specific_dof)
		{
			continue;
		}

		if(getdvarint("scr_cinematic"))
		{
			func_16C1();
			continue;
		}

		if(getdvarint("scr_dof_enable") && !var_00)
		{
			func_16C2();
			continue;
		}

		setdefaultdepthoffield();
	}
}

//Function Number: 21
func_16C1()
{
	var_00 = self playerads();
	if(var_00 == 1 && getdvarint("scr_cinematic_autofocus"))
	{
		var_01 = vectornormalize(anglestoforward(self getplayerangles()));
		var_02 = bullettrace(self geteye(),self geteye() + var_01 * 100000,1,self);
		var_03 = getaiarray();
		var_04 = 10000;
		var_05 = -1;
		var_06 = self geteye();
		var_07 = self getplayerangles();
		var_08 = 0;
		var_09 = undefined;
		for(var_0A = 0;var_0A < var_03.size;var_0A++)
		{
			var_0B = var_03[var_0A].origin;
			var_0C = vectornormalize(var_0B - var_06);
			var_0D = anglestoforward(var_07);
			var_0E = vectordot(var_0D,var_0C);
			if(var_0E > var_08)
			{
				var_08 = var_0E;
				var_09 = var_03[var_0A].origin;
			}
		}

		if(var_08 < 0.923)
		{
			var_0F = distance(var_06,var_02["position"]);
		}
		else
		{
			var_0F = distance(var_06,var_09);
		}

		changedofvalue("nearStart",1,200);
		changedofvalue("nearEnd",var_0F,200);
		changedofvalue("farStart",var_0F + 196,200);
		changedofvalue("farEnd",var_0F + 196 * 2,200);
		changedofvalue("nearBlur",6,0.1);
		changedofvalue("farBlur",3.6,0.1);
	}
	else
	{
		var_0F = getdvarint("scr_cinematic_doffocus") * 39;
		if(self.curdof != var_0F)
		{
			changedofvalue("nearStart",1,100);
			changedofvalue("nearEnd",var_0F,100);
			changedofvalue("farStart",var_0F + 196,100);
			changedofvalue("farEnd",var_0F + 196 * 2,100);
			changedofvalue("nearBlur",6,0.1);
			changedofvalue("farBlur",3.6,0.1);
		}
	}

	self.curdof = self.dof["farStart"] - self.dof["nearEnd"] / 2;
	self setdepthoffield(self.dof["nearStart"],self.dof["nearEnd"],self.dof["farStart"],self.dof["farEnd"],self.dof["nearBlur"],self.dof["farBlur"]);
}

//Function Number: 22
func_16C2()
{
	var_00 = self playerads();
	if(var_00 == 0)
	{
		setdefaultdepthoffield();
		return;
	}

	var_01 = self geteye();
	var_02 = self getplayerangles();
	var_03 = vectornormalize(anglestoforward(var_02));
	var_04 = bullettrace(var_01,var_01 + var_03 * 8192,1,self,1);
	var_05 = getaiarray("axis");
	var_06 = self getcurrentweapon();
	if(isdefined(level.special_weapon_dof_funcs[var_06]))
	{
		[[ level.special_weapon_dof_funcs[var_06] ]](var_04,var_05,var_01,var_03,var_00);
		return;
	}

	var_07 = 10000;
	var_08 = -1;
	for(var_09 = 0;var_09 < var_05.size;var_09++)
	{
		var_0A = vectornormalize(var_05[var_09].origin - var_01);
		var_0B = vectordot(var_03,var_0A);
		if(var_0B < 0.923)
		{
			continue;
		}

		var_0C = distance(var_01,var_05[var_09].origin);
		if(var_0C - 30 < var_07)
		{
			var_07 = var_0C - 30;
		}

		if(var_0C + 30 > var_08)
		{
			var_08 = var_0C + 30;
		}
	}

	if(var_07 > var_08)
	{
		var_07 = 256;
		var_08 = 2500;
	}
	else
	{
		if(var_07 < 50)
		{
			var_07 = 50;
		}
		else if(var_07 > 512)
		{
			var_07 = 512;
		}

		if(var_08 > 2500)
		{
			var_08 = 2500;
		}
		else if(var_08 < 1000)
		{
			var_08 = 1000;
		}
	}

	var_0D = distance(var_01,var_04["position"]);
	if(var_07 > var_0D)
	{
		var_07 = var_0D - 30;
	}

	if(var_07 < 1)
	{
		var_07 = 1;
	}

	if(var_08 < var_0D)
	{
		var_08 = var_0D;
	}

	setdoftarget(var_00,1,var_07,var_08,var_08 * 4,6,1.8);
}

//Function Number: 23
func_16C3(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 < 0.88)
	{
		setdefaultdepthoffield();
		return;
	}

	var_05 = 10000;
	var_06 = -1;
	var_05 = 2400;
	var_07 = 2400;
	for(var_08 = 0;var_08 < param_01.size;var_08++)
	{
		var_09 = vectornormalize(param_01[var_08].origin - param_02);
		var_0A = vectordot(param_03,var_09);
		if(var_0A < 0.923)
		{
			continue;
		}

		var_0B = distance(param_02,param_01[var_08].origin);
		if(var_0B < 2500)
		{
			var_0B = 2500;
		}

		if(var_0B - 30 < var_05)
		{
			var_05 = var_0B - 30;
		}

		if(var_0B + 30 > var_06)
		{
			var_06 = var_0B + 30;
		}
	}

	if(var_05 > var_06)
	{
		var_05 = 2400;
		var_06 = 3000;
	}
	else
	{
		if(var_05 < 50)
		{
			var_05 = 50;
		}

		if(var_06 > 2500)
		{
			var_06 = 2500;
		}
		else if(var_06 < 1000)
		{
			var_06 = 1000;
		}
	}

	var_0C = distance(param_02,param_00["position"]);
	if(var_0C < 2500)
	{
		var_0C = 2500;
	}

	if(var_05 > var_0C)
	{
		var_05 = var_0C - 30;
	}

	if(var_05 < 1)
	{
		var_05 = 1;
	}

	if(var_06 < var_0C)
	{
		var_06 = var_0C;
	}

	if(var_07 >= var_05)
	{
		var_07 = var_05 - 1;
	}

	setdoftarget(param_04,var_07,var_05,var_06,var_06 * 4,4,1.8);
}

//Function Number: 24
setdoftarget(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_00 == 1)
	{
		changedofvalue("nearStart",param_01,50);
		changedofvalue("nearEnd",param_02,50);
		changedofvalue("farStart",param_03,400);
		changedofvalue("farEnd",param_04,400);
		changedofvalue("nearBlur",param_05,0.1);
		changedofvalue("farBlur",param_06,0.1);
	}
	else
	{
		func_16C6("nearStart",param_01,param_00);
		func_16C6("nearEnd",param_02,param_00);
		func_16C6("farStart",param_03,param_00);
		func_16C6("farEnd",param_04,param_00);
		func_16C6("nearBlur",param_05,param_00);
		func_16C6("farBlur",param_06,param_00);
	}

	self setdepthoffield(self.dof["nearStart"],self.dof["nearEnd"],self.dof["farStart"],self.dof["farEnd"],self.dof["nearBlur"],self.dof["farBlur"]);
}

//Function Number: 25
changedofvalue(param_00,param_01,param_02)
{
	if(self.dof[param_00] > param_01)
	{
		var_03 = self.dof[param_00] - param_01 * 0.5;
		if(var_03 > param_02)
		{
			var_03 = param_02;
		}
		else if(var_03 < 1)
		{
			var_03 = 1;
		}

		if(self.dof[param_00] - var_03 < param_01)
		{
			self.dof[param_00] = param_01;
			return;
		}

		self.dof[param_00] = self.dof[param_00] - var_03;
		return;
	}

	if(self.dof[param_00] < param_01)
	{
		var_03 = param_01 - self.dof[param_00] * 0.5;
		if(var_03 > param_02)
		{
			var_03 = param_02;
		}
		else if(var_03 < 1)
		{
			var_03 = 1;
		}

		if(self.dof[param_00] + var_03 > param_01)
		{
			self.dof[param_00] = param_01;
			return;
		}

		self.dof[param_00] = self.dof[param_00] + var_03;
		return;
	}
}

//Function Number: 26
func_16C6(param_00,param_01,param_02)
{
	self.dof[param_00] = level.dofdefault[param_00] + param_01 - level.dofdefault[param_00] * param_02;
}

//Function Number: 27
dofvarupdate()
{
	level.dofdefault["nearStart"] = getdvarint("scr_dof_nearStart");
	level.dofdefault["nearEnd"] = getdvarint("scr_dof_nearEnd");
	level.dofdefault["farStart"] = getdvarint("scr_dof_farStart");
	level.dofdefault["farEnd"] = getdvarint("scr_dof_farEnd");
	level.dofdefault["nearBlur"] = getdvarfloat("scr_dof_nearBlur");
	level.dofdefault["farBlur"] = getdvarfloat("scr_dof_farBlur");
}

//Function Number: 28
setdefaultdepthoffield()
{
	if(isdefined(self.dofdefault))
	{
		self setdepthoffield(self.dofdefault["nearStart"],self.dofdefault["nearEnd"],self.dofdefault["farStart"],self.dofdefault["farEnd"],self.dofdefault["nearBlur"],self.dofdefault["farBlur"]);
		return;
	}

	self setdepthoffield(level.dofdefault["nearStart"],level.dofdefault["nearEnd"],level.dofdefault["farStart"],level.dofdefault["farEnd"],level.dofdefault["nearBlur"],level.dofdefault["farBlur"]);
}

//Function Number: 29
isdofdefault()
{
	if(level.dofdefault["nearStart"] != getdvarint("scr_dof_nearStart"))
	{
		return 0;
	}

	if(level.dofdefault["nearEnd"] != getdvarint("scr_dof_nearEnd"))
	{
		return 0;
	}

	if(level.dofdefault["farStart"] != getdvarint("scr_dof_farStart"))
	{
		return 0;
	}

	if(level.dofdefault["farEnd"] != getdvarint("scr_dof_farEnd"))
	{
		return 0;
	}

	if(level.dofdefault["nearBlur"] != getdvarint("scr_dof_nearBlur"))
	{
		return 0;
	}

	if(level.dofdefault["farBlur"] != getdvarint("scr_dof_farBlur"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
func_16CA()
{
	var_00 = 7;
	var_01 = [];
	var_02 = 15;
	var_03 = int(var_00 / 2);
	var_04 = 240 + var_03 * var_02;
	var_05 = 0.5 / var_03;
	var_06 = var_05;
	for(var_07 = 0;var_07 < var_00;var_07++)
	{
		var_01[var_07] = _newhudelem();
		var_01[var_07].location = 0;
		var_01[var_07].alignx = "left";
		var_01[var_07].aligny = "middle";
		var_01[var_07].foreground = 1;
		var_01[var_07].fontscale = 2;
		var_01[var_07].sort = 20;
		if(var_07 == var_03)
		{
			var_01[var_07].alpha = 1;
		}
		else
		{
			var_01[var_07].alpha = var_06;
		}

		var_01[var_07].x = 20;
		var_01[var_07].y = var_04;
		var_01[var_07] _settext(".");
		if(var_07 == var_03)
		{
			var_05 = var_05 * -1;
		}

		var_06 = var_06 + var_05;
		var_04 = var_04 - var_02;
	}

	level.var_16CB = var_01;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "center";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 1;
	var_08.x = 320;
	var_08.y = 244;
	var_08 _settext(".");
	level.var_16CC = var_08;
	var_08 = _newhudelem();
	var_08.location = 0;
	var_08.alignx = "center";
	var_08.aligny = "bottom";
	var_08.foreground = 1;
	var_08.fontscale = 2;
	var_08.sort = 20;
	var_08.alpha = 0;
	var_08.x = 320;
	var_08.y = 244;
	var_08 setvalue(0);
	level.crosshair_value = var_08;
}

//Function Number: 31
controler_hud_add(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 520;
	var_06 = 120;
	var_07 = 18;
	var_08 = 0.8;
	var_09 = 20;
	var_0A = 1.4;
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(level.hud_controler) || !isdefined(level.hud_controler[param_00]))
	{
		level.hud_controler[param_00] = _newhudelem();
		var_0B = _newhudelem();
	}
	else
	{
		var_0B = level.hud_controler[param_01].var_16D0;
	}

	level.hud_controler[param_00].location = 0;
	level.hud_controler[param_00].alignx = "right";
	level.hud_controler[param_00].aligny = "middle";
	level.hud_controler[param_00].foreground = 1;
	level.hud_controler[param_00].fontscale = 1.5;
	level.hud_controler[param_00].sort = 20;
	level.hud_controler[param_00].alpha = var_08;
	level.hud_controler[param_00].x = var_05 + var_09;
	level.hud_controler[param_00].y = var_06 + param_01 * var_07;
	level.hud_controler[param_00] _settext(param_02);
	level.hud_controler[param_00].base_button_text = param_02;
	var_0B.location = 0;
	var_0B.alignx = "left";
	var_0B.aligny = "middle";
	var_0B.foreground = 1;
	var_0B.fontscale = var_0A;
	var_0B.sort = 20;
	var_0B.alpha = var_08;
	var_0B.x = var_05 + var_09;
	var_0B.y = var_06 + param_01 * var_07;
	if(isdefined(param_04))
	{
		var_0B setvalue(param_04);
	}

	if(isdefined(param_03))
	{
		var_0B _settext(param_03);
	}

	level.hud_controler[param_00].var_16D0 = var_0B;
}

//Function Number: 32
_newhudelem()
{
	if(!isdefined(level.var_16D3))
	{
		level.var_16D3 = [];
	}

	var_00 = newhudelem();
	level.var_16D3[level.var_16D3.size] = var_00;
	return var_00;
}

//Function Number: 33
_settext(param_00)
{
	self.realtext = param_00;
	self settext("_");
	thread _clearalltextafterhudelem();
	var_01 = 0;
	foreach(var_03 in level.var_16D3)
	{
		if(isdefined(var_03.realtext))
		{
			var_01 = var_01 + var_03.realtext.size;
			var_03 settext(var_03.realtext);
		}
	}
}

//Function Number: 34
_clearalltextafterhudelem()
{
	if(level._clearalltextafterhudelem)
	{
		return;
	}

	level._clearalltextafterhudelem = 1;
	self clearalltextafterhudelem();
	wait 0.05;
	level._clearalltextafterhudelem = 0;
}

//Function Number: 35
setgroup_up()
{
	func_16D8();
	var_00 = undefined;
	var_01 = getarraykeys(level.vision_set_vision);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.vision_set_transition_ent.vision_set)
		{
			var_00 = var_02 + 1;
			break;
		}
	}

	if(var_00 == var_01.size)
	{
		return;
	}

	setcurrentgroup(var_01[var_00]);
}

//Function Number: 36
setgroup_down()
{
	func_16D8();
	var_00 = undefined;
	var_01 = getarraykeys(level.vision_set_vision);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] == level.vision_set_transition_ent.vision_set)
		{
			var_00 = var_02 - 1;
			break;
		}
	}

	if(var_00 < 0)
	{
		return;
	}

	setcurrentgroup(var_01[var_00]);
}

//Function Number: 37
func_16D8()
{
}

//Function Number: 38
setcurrentgroup(param_00)
{
	level.spam_model_current_group = param_00;
	var_01 = getarraykeys(level.vision_set_vision);
	var_02 = 0;
	var_03 = int(level.var_16CB.size / 2);
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(var_01[var_04] == param_00)
		{
			var_02 = var_04;
			break;
		}
	}

	level.var_16CB[var_03] _settext(var_01[var_02]);
	for(var_04 = 1;var_04 < level.var_16CB.size - var_03;var_04++)
	{
		if(var_02 - var_04 < 0)
		{
			level.var_16CB[var_03 + var_04] _settext(".");
			continue;
		}

		level.var_16CB[var_03 + var_04] _settext(var_01[var_02 - var_04]);
	}

	for(var_04 = 1;var_04 < level.var_16CB.size - var_03;var_04++)
	{
		if(var_02 + var_04 > var_01.size - 1)
		{
			level.var_16CB[var_03 - var_04] _settext(".");
			continue;
		}

		level.var_16CB[var_03 - var_04] _settext(var_01[var_02 + var_04]);
	}

	maps\_utility::vision_set_fog_changes(var_01[var_02],0);
}

//Function Number: 39
init_fog_transition()
{
	if(!isdefined(level.fog_transition_ent))
	{
		level.fog_transition_ent = spawnstruct();
		level.fog_transition_ent.var_16DE = "";
		level.fog_transition_ent.time = 0;
	}
}

//Function Number: 40
playerinit()
{
	var_00 = level.vision_set_transition_ent.vision_set;
	level.vision_set_transition_ent.vision_set = "";
	level.vision_set_transition_ent.time = "";
	init_fog_transition();
	level.fog_transition_ent.var_16DE = "";
	level.fog_transition_ent.time = "";
	setcurrentgroup(var_00);
}