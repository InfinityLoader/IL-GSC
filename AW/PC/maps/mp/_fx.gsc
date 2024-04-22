/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 93 ms
 * Timestamp: 4/22/2024 2:15:55 AM
*******************************************************************/

//Function Number: 1
script_print_fx()
{
	if(!isdefined(self.script_fxid) || !isdefined(self.script_fxcommand) || !isdefined(self.script_delay))
	{
		self delete();
		return;
	}

	if(isdefined(self.target))
	{
		var_00 = getent(self.target).origin;
	}
	else
	{
		var_00 = "undefined";
	}

	if(self.script_fxcommand == "OneShotfx")
	{
	}

	if(self.script_fxcommand == "loopfx")
	{
	}

	if(self.script_fxcommand == "loopsound")
	{
	}
}

//Function Number: 2
grenadeexplosionfx(param_00)
{
	playfx(level._effect["mechanical explosion"],param_00);
	earthquake(0.15,0.5,param_00,250);
}

//Function Number: 3
soundfx(param_00,param_01,param_02)
{
	var_03 = spawn("script_origin",(0,0,0));
	var_03.origin = param_01;
	var_03 playloopsound(param_00);
	if(isdefined(param_02))
	{
		var_03 thread soundfxdelete(param_02);
	}
}

//Function Number: 4
soundfxdelete(param_00)
{
	level waittill(param_00);
	self delete();
}

//Function Number: 5
blenddelete(param_00)
{
	self waittill("death");
	param_00 delete();
}