/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_audio.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 188 ms
 * Timestamp: 10/27/2023 1:22:04 AM
*******************************************************************/

//Function Number: 1
init_audio()
{
	if(!isdefined(level.audio))
	{
		level.audio = spawnstruct();
	}

	init_reverb();
	init_whizby();
	level.onplayerconnectaudioinit = ::onplayerconnectaudioinit;
}

//Function Number: 2
onplayerconnectaudioinit()
{
	func_0EA2("default");
}

//Function Number: 3
init_reverb()
{
	add_reverb("default","generic",0.15,0.9,2);
}

//Function Number: 4
add_reverb(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	func_4835(param_01);
	var_05["roomtype"] = param_01;
	var_05["wetlevel"] = param_02;
	var_05["drylevel"] = param_03;
	var_05["fadetime"] = param_04;
	level.audio.reverb_settings[param_00] = var_05;
}

//Function Number: 5
func_4835(param_00)
{
}

//Function Number: 6
func_0EA2(param_00)
{
	if(!isdefined(level.audio.reverb_settings[param_00]))
	{
		var_01 = level.audio.reverb_settings["default"];
	}
	else
	{
		var_01 = level.audio.reverb_settings[var_01];
	}

	self setreverb("snd_enveffectsprio_level",var_01["roomtype"],var_01["drylevel"],var_01["wetlevel"],var_01["fadetime"]);
}

//Function Number: 7
init_whizby()
{
	level.audio.whizby_settings = [];
	func_6FCA(15,30,50);
	func_6FCB(150,250,350);
}

//Function Number: 8
func_6FCA(param_00,param_01,param_02)
{
	level.audio.whizby_settings["radius"] = [param_00,param_01,param_02];
}

//Function Number: 9
func_6FCB(param_00,param_01,param_02)
{
	level.audio.whizby_settings["spread"] = [param_00,param_01,param_02];
}

//Function Number: 10
apply_whizby()
{
	var_00 = level.audio.whizby_settings;
	var_01 = var_00["spread"];
	var_02 = var_00["radius"];
	self setwhizbyspreads(var_01[0],var_01[1],var_01[2]);
	self setwhizbyradii(var_02[0],var_02[1],var_02[2]);
}