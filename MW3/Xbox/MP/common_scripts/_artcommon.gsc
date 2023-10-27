/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_artcommon.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 161 ms
 * Timestamp: 10/27/2023 2:29:04 AM
*******************************************************************/

//Function Number: 1
artstartvisionfileexport()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

//Function Number: 2
func_1669()
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
func_166D()
{
}

//Function Number: 7
func_166E()
{
	level.fogexphalfplane = getdvarfloat("scr_fog_exp_halfplane");
	level.fognearplane = getdvarfloat("scr_fog_nearplane");
	level.fogcolor = getdvarvector("scr_fog_color");
	level.fogmaxopacity = getdvarfloat("scr_fog_max_opacity");
	level.sunfogenabled = getdvarint("scr_sunFogEnabled");
	level.sunfogcolor = getdvarvector("scr_sunFogColor");
	level.var_1675 = getdvarvector("scr_sunFogDir");
	level.var_1676 = getdvarfloat("scr_sunFogBeginFadeAngle");
	level.sunfogendfadeangle = getdvarfloat("scr_sunFogEndFadeAngle");
	level.sunfogscale = getdvarfloat("scr_sunFogScale");
	level.fogexphalfplane = func_1679(level.fogexphalfplane);
	level.fognearplane = func_1679(level.fognearplane);
	var_00 = func_1679(level.fogcolor[0]);
	var_01 = func_1679(level.fogcolor[1]);
	var_02 = func_1679(level.fogcolor[2]);
	level.fogcolor = (var_00,var_01,var_02);
	level.fogmaxopacity = func_1679(level.fogmaxopacity);
	level.sunfogenabled = func_1679(level.sunfogenabled);
	var_00 = func_1679(level.sunfogcolor[0]);
	var_01 = func_1679(level.sunfogcolor[1]);
	var_02 = func_1679(level.sunfogcolor[2]);
	level.sunfogcolor = (var_00,var_01,var_02);
	var_03 = func_1679(level.var_1675[0]);
	var_04 = func_1679(level.var_1675[1]);
	var_05 = func_1679(level.var_1675[2]);
	level.var_1675 = (var_03,var_04,var_05);
	level.var_1676 = func_1679(level.var_1676);
	level.sunfogendfadeangle = func_1679(level.sunfogendfadeangle);
	level.sunfogscale = func_1679(level.sunfogscale);
}

//Function Number: 8
func_1679(param_00)
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
			setexpfog(level.fognearplane,level.fogexphalfplane,level.fogcolor[0],level.fogcolor[1],level.fogcolor[2],level.fogmaxopacity,0,level.sunfogcolor[0],level.sunfogcolor[1],level.sunfogcolor[2],level.var_1675,level.var_1676,level.sunfogendfadeangle,level.sunfogscale);
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
			common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0, " + level.sunfogcolor[0] + ", " + level.sunfogcolor[1] + ", " + level.sunfogcolor[2] + ", (" + level.var_1675[0] + ", " + level.var_1675[1] + ", " + level.var_1675[2] + "), " + level.var_1676 + ", " + level.sunfogendfadeangle + ", " + level.sunfogscale + " );");
			return;
		}

		common_scripts\utility::fileprint_launcher("\tsetExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0 );");
	}
}