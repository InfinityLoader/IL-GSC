/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\flashed.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 110 ms
 * Timestamp: 10/27/2023 2:18:19 AM
*******************************************************************/

//Function Number: 1
func_208E()
{
	level.var_208F[0] = %exposed_flashbang_v1;
	level.var_208F[1] = %exposed_flashbang_v2;
	level.var_208F[2] = %exposed_flashbang_v3;
	level.var_208F[3] = %exposed_flashbang_v4;
	level.var_208F[4] = %exposed_flashbang_v5;
	func_2091();
	anim.var_2090 = 0;
}

//Function Number: 2
func_2091()
{
	for(var_00 = 0;var_00 < level.var_208F.size;var_00++)
	{
		var_01 = randomint(level.var_208F.size);
		var_02 = level.var_208F[var_00];
		level.var_208F[var_00] = level.var_208F[var_01];
		level.var_208F[var_01] = var_02;
	}
}

//Function Number: 3
func_2092()
{
	level.var_2090++;
	if(level.var_2090 >= level.var_208F.size)
	{
		anim.var_2090 = 0;
		func_2091();
	}

	return level.var_208F[level.var_2090];
}

//Function Number: 4
func_2093(param_00)
{
	self endon("killanimscript");
	self setflaggedanimknoball("flashed_anim",param_00,%body,0.2,randomfloatrange(0.9,1.1));
	animscripts/shared::donotetracks("flashed_anim");
}

//Function Number: 5
main()
{
	self endon("death");
	self endon("killanimscript");
	animscripts/utility::func_D15("flashed");
	var_00 = maps\_utility::flashbanggettimeleftsec();
	if(var_00 <= 0)
	{
		return;
	}

	animscripts/face::func_C41("flashbang");
	if(isdefined(self.var_2095))
	{
		self [[ self.var_2095 ]]();
		return;
	}

	var_01 = func_2092();
	func_2096(var_01,var_00);
}

//Function Number: 6
func_2096(param_00,param_01)
{
	self endon("death");
	self endon("killanimscript");
	if(self.a.pose == "prone")
	{
		animscripts/utility::func_F7D(1);
	}

	self.a.pose = "stand";
	self.allowdeath = 1;
	thread func_2093(param_00);
	wait param_01;
	self notify("stop_flashbang_effect");
	self.var_2097 = 0;
}