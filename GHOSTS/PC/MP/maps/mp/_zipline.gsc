/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_zipline.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 117 ms
 * Timestamp: 10/27/2023 1:22:51 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = [];
	var_01 = getentarray("zipline","targetname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = maps\mp\gametypes\_gameobjects::func_212D("neutral",var_01[var_02],var_00,(0,0,0));
		var_03 maps\mp\gametypes\_gameobjects::allowuse("any");
		var_03 maps\mp\gametypes\_gameobjects::func_720E(0.25);
		var_03 maps\mp\gametypes\_gameobjects::func_720D(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_720C(&"MP_ZIPLINE_USE");
		var_03 maps\mp\gametypes\_gameobjects::func_7212("any");
		var_03.onbeginuse = ::onbeginuse;
		var_03.onuse = ::onuse;
		var_04 = [];
		var_05 = getent(var_01[var_02].target,"targetname");
		if(!isdefined(var_05))
		{
		}

		while(isdefined(var_05))
		{
			var_04[var_04.size] = var_05;
			if(isdefined(var_05.target))
			{
				var_05 = getent(var_05.target,"targetname");
				continue;
			}

			break;
		}

		var_03.targets = var_04;
	}

	precachemodel("tag_player");
}

//Function Number: 2
onbeginuse(param_00)
{
	param_00 playsound("scrambler_pullout_lift_plr");
}

//Function Number: 3
onuse(param_00)
{
	param_00 thread func_8EA7(self);
}

//Function Number: 4
func_8EA7(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("zipline_drop");
	level endon("game_ended");
	var_01 = spawn("script_origin",param_00.trigger.origin);
	var_01.origin = param_00.trigger.origin;
	var_01.angles = self.angles;
	var_01 setmodel("tag_player");
	self playerlinktodelta(var_01,"tag_player",1,180,180,180,180);
	thread func_8CD6(var_01);
	thread func_8CDC(var_01);
	var_02 = param_00.targets;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = distance(var_01.origin,var_02[var_03].origin) / 600;
		var_05 = 0;
		if(var_03 == 0)
		{
			var_05 = var_04 * 0.2;
		}

		var_01 moveto(var_02[var_03].origin,var_04,var_05);
		if(var_01.angles != var_02[var_03].angles)
		{
			var_01 rotateto(var_02[var_03].angles,var_04 * 0.8);
		}

		wait(var_04);
	}

	self notify("destination");
	self unlink();
	var_01 delete();
}

//Function Number: 5
func_8CDC(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("destination");
	level endon("game_ended");
	self notifyonplayercommand("zipline_drop","+gostand");
	self waittill("zipline_drop");
	self unlink();
	param_00 delete();
}

//Function Number: 6
func_8CD6(param_00)
{
	self endon("disconnect");
	self endon("destination");
	self endon("zipline_drop");
	level endon("game_ended");
	self waittill("death");
	self unlink();
	param_00 delete();
}