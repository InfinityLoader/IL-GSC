/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_artcommon.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 147 ms
 * Timestamp: 10/27/2023 2:15:29 AM
*******************************************************************/

//Function Number: 1
artstartvisionfileexport()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

//Function Number: 2
artendvisionfileexport()
{
	return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision",1);
}

//Function Number: 3
artstartfogfileexport()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

//Function Number: 4
artendfogfileexport()
{
	return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc",1);
}

//Function Number: 5
artcommonfxprintln(param_00)
{
	common_scripts\utility::fileprint_launcher(param_00);
}

//Function Number: 6
setfogsliders()
{
}

//Function Number: 7
translatefogsliderstoscript()
{
	level.fogexphalfplane = getdvarfloat("scr_fog_exp_halfplane");
	level.fognearplane = getdvarfloat("scr_fog_nearplane");
	level.fogcolor = getdvarvector("scr_fog_color");
	level.fogmaxopacity = getdvarfloat("scr_fog_max_opacity");
	level.sunfogenabled = getdvarint("scr_sunFogEnabled");
	level.sunfogcolor = getdvarvector("scr_sunFogColor");
	level.sunfogdir = getdvarvector("scr_sunFogDir");
	level.sunfogbeginfadeangle = getdvarfloat("scr_sunFogBeginFadeAngle");
	level.sunfogendfadeangle = getdvarfloat("scr_sunFogEndFadeAngle");
	level.sunfogscale = getdvarfloat("scr_sunFogScale");
	level.fogexphalfplane = limit(level.fogexphalfplane);
	level.fognearplane = limit(level.fognearplane);
	var_00 = limit(level.fogcolor[0]);
	var_01 = limit(level.fogcolor[1]);
	var_02 = limit(level.fogcolor[2]);
	level.fogcolor = (var_00,var_01,var_02);
	level.fogmaxopacity = limit(level.fogmaxopacity);
	level.sunfogenabled = limit(level.sunfogenabled);
	var_00 = limit(level.sunfogcolor[0]);
	var_01 = limit(level.sunfogcolor[1]);
	var_02 = limit(level.sunfogcolor[2]);
	level.sunfogcolor = (var_00,var_01,var_02);
	var_03 = limit(level.sunfogdir[0]);
	var_04 = limit(level.sunfogdir[1]);
	var_05 = limit(level.sunfogdir[2]);
	level.sunfogdir = (var_03,var_04,var_05);
	level.sunfogbeginfadeangle = limit(level.sunfogbeginfadeangle);
	level.sunfogendfadeangle = limit(level.sunfogendfadeangle);
	level.sunfogscale = limit(level.sunfogscale);
}

//Function Number: 8
limit(param_00)
{
	var_01 = 0.001;
	if(param_00 < var_01 && param_00 > var_01 * -1)
	{
		param_00 = 0;
	}

	return param_00;
}

//Function Number: 9
updatefogfromscript()
{
	if(!getdvarint("scr_fog_disable"))
	{
		if(level.sunfogenabled)
		{
			setexpfog(level.fognearplane,level.fogexphalfplane,level.fogcolor[0],level.fogcolor[1],level.fogcolor[2],level.fogmaxopacity,0,level.sunfogcolor[0],level.sunfogcolor[1],level.sunfogcolor[2],level.sunfogdir,level.sunfogbeginfadeangle,level.sunfogendfadeangle,level.sunfogscale);
			return;
		}

		setexpfog(level.fognearplane,level.fogexphalfplane,level.fogcolor[0],level.fogcolor[1],level.fogcolor[2],level.fogmaxopacity,0);
		return;
	}

	setexpfog(1215752192,1215752193,0,0,0,0,0);
}

//Function Number: 10
artfxprintlnfog()
{
	common_scripts\utility::fileprint_launcher("");
	common_scripts\utility::fileprint_launcher("\t//* Fog section * ");
	common_scripts\utility::fileprint_launcher("");
	common_scripts\utility::fileprint_launcher("\tsetDevDvar( \"scr_fog_disable\", \" + getdvarint("scr_fog_disable") + "\" + " );");
	common_scripts\utility::fileprint_launcher("");
	if(!getdvarint("scr_fog_disable"))
	{
		if(level.sunfogenabled)
		{
			common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0, " + level.sunfogcolor[0] + ", " + level.sunfogcolor[1] + ", " + level.sunfogcolor[2] + ", (" + level.sunfogdir[0] + ", " + level.sunfogdir[1] + ", " + level.sunfogdir[2] + "), " + level.sunfogbeginfadeangle + ", " + level.sunfogendfadeangle + ", " + level.sunfogscale + " );");
			return;
		}

		common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0 );");
	}
}