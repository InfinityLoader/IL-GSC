/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_artcommon.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

artstartvisionfileexport()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

artendvisionfileexport()
{
	return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\vision\\" + level.script + ".vision", 1);
}

artstartfogfileexport()
{
	common_scripts\utility::fileprint_launcher_start_file();
}

artendfogfileexport()
{
	return common_scripts\utility::fileprint_launcher_end_file("\\share\\raw\\maps\\createart\\" + level.script + "_art.gsc", 1);
}

artcommonfxprintln(string)
{
	common_scripts\utility::fileprint_launcher(string);
}

setfogsliders()
{
}

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
}

updatefogfromscript()
{
	if(!getdvarint("scr_fog_disable"))
	{
		if(level.sunfogenabled)
		{
			setexpfog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0, level.sunfogcolor[0], level.sunfogcolor[1], level.sunfogcolor[2], level.sunfogdir, level.sunfogbeginfadeangle, level.sunfogendfadeangle, level.sunfogscale);
			return;
		}

		setexpfog(level.fognearplane, level.fogexphalfplane, level.fogcolor[0], level.fogcolor[1], level.fogcolor[2], level.fogmaxopacity, 0);
		return;
	}

	setexpfog(1215752192, 1215752193, 0, 0, 0, 0, 0);
}

artfxprintlnfog()
{
	common_scripts\utility::fileprint_launcher("");
	common_scripts\utility::fileprint_launcher("	//* Fog section * ");
	common_scripts\utility::fileprint_launcher("");
	common_scripts\utility::fileprint_launcher("	setDevDvar( \"scr_fog_disable\", \"" + getdvarint("scr_fog_disable") + "\"" + " );");
	common_scripts\utility::fileprint_launcher("");
	if(!getdvarint("scr_fog_disable"))
	{
		if(level.sunfogenabled)
		{
			common_scripts\utility::fileprint_launcher("	setExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0, " + level.sunfogcolor[0] + ", " + level.sunfogcolor[1] + ", " + level.sunfogcolor[2] + ", (" + level.sunfogdir[0] + ", " + level.sunfogdir[1] + ", " + level.sunfogdir[2] + "), " + level.sunfogbeginfadeangle + ", " + level.sunfogendfadeangle + ", " + level.sunfogscale + " );");
			return;
		}

		common_scripts\utility::fileprint_launcher("	setExpFog( " + level.fognearplane + ", " + level.fogexphalfplane + ", " + level.fogcolor[0] + ", " + level.fogcolor[1] + ", " + level.fogcolor[2] + ", " + level.fogmaxopacity + ", 0 );");
		return;
	}
}