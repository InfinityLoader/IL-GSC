/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\notetracks_common.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 61
 * Decompile Time: 837 ms
 * Timestamp: 10/27/2023 3:07:53 AM
*******************************************************************/

//Function Number: 1
func_6784(param_00)
{
	if(isdefined(self) && function_0344(param_00))
	{
		self method_8617(param_00);
	}
}

//Function Number: 2
func_430B(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	param_01 = tolower(param_01);
	if(param_00 == "playrumble_")
	{
		var_02 = 11;
	}
	else if(param_00 == "playrumbleloop_")
	{
		var_02 = 15;
	}
	else if(param_00 == "stoprumble_")
	{
		var_02 = 11;
	}

	if(function_02C6(param_01,param_00))
	{
		var_03 = getsubstr(param_01,var_02,999);
	}

	return var_03;
}

//Function Number: 3
func_7BF0()
{
	level.var_67D0["dropgun"] = ::func_67B5;
	level.var_67D0["unlink"] = ::func_67E6;
	level.var_67D0["dismember_left_arm"] = ::func_679D;
	level.var_67D0["dismember_right_arm"] = ::func_67A1;
	level.var_67D0["dismember_left_leg"] = ::func_679F;
	level.var_67D0["dismember_right_leg"] = ::func_67A3;
	level.var_67D0["dismember_novfx_left_arm"] = ::func_679E;
	level.var_67D0["dismember_novfx_right_arm"] = ::func_67A2;
	level.var_67D0["dismember_novfx_left_leg"] = ::func_67A0;
	level.var_67D0["dismember_novfx_right_leg"] = ::func_67A4;
	if(getdvarint("fov_notetracks_code_handling") == 0 && !function_025F())
	{
		level.var_67D4["fov_"] = ::func_67B2;
	}

	level.var_67D4["earthquake_"] = ::func_67A7;
	level.var_67D4["fadetoblack_"] = ::func_67AA;
	level.var_67D4["fadefromblack_"] = ::func_67A9;
	level.var_67D4["fadetoandfromblack"] = ::notetrackfadetoandfromblack;
	level.var_67D4["playrumble_"] = ::func_67C6;
	level.var_67D4["playrumbleloop_"] = ::func_67C7;
	level.var_67D4["stoprumble_"] = ::func_67E2;
	level.var_67D0["stopallrumbles"] = ::func_67DF;
	level.var_67D4["setmodel_"] = ::func_67D6;
	level.var_67D4["attachmodeltotag"] = ::func_6793;
	level.var_67D4["detachmodelfromtag"] = ::func_679A;
	level.var_67D4["dropmodelfromtag"] = ::func_67A6;
	level.var_67D4["delayedlaunchmodelfromtag"] = ::func_6799;
	level.var_67D4["dropgun"] = ::func_67B5;
	level.var_67D4["playfxontag"] = ::notetrackplayfxontag;
	level.var_67D4["stopfxontag"] = ::notetrackstopfxontag;
	level.var_67D4["killfxontag"] = ::notetrackkillfxontag;
	level.var_67D4["playfxontagforclient"] = ::notetrackplayfxontagforclient;
	level.var_67D4["stopfxontagforclient"] = ::notetrackstopfxontagforclient;
	level.var_67D4["killfxontagforclient"] = ::notetrackkillfxontagforclient;
	level.var_67D4["hidepart"] = ::notetrackhidepart;
	level.var_67D4["showpart"] = ::notetrackshowpart;
	if(isdefined(level.var_686))
	{
		var_00 = getarraykeys(level.var_686);
		foreach(var_02 in var_00)
		{
			level.var_67D0[var_02] = ::func_297E;
		}
	}
}

//Function Number: 4
func_A025()
{
	wait(0.1);
	if(isdefined(self))
	{
		self unlink();
	}
}

//Function Number: 5
func_67E6(param_00,param_01)
{
	self unlink();
}

//Function Number: 6
func_67B5(param_00,param_01,param_02)
{
	var_03 = self getlinkedchildren();
	foreach(var_05 in var_03)
	{
		var_05 unlink();
		var_05 physicslaunchserveritem();
	}
}

//Function Number: 7
func_679D(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("left_arm");
	if(isdefined(self.var_65D2) && isdefined(self.var_65D1))
	{
		playfxontag(common_scripts\utility::func_44F5(self.var_65D2),self,self.var_65D1);
	}
}

//Function Number: 8
func_679E(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("left_arm");
}

//Function Number: 9
func_67A1(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("right_arm");
	if(isdefined(self.var_65D2) && isdefined(self.var_65D1))
	{
		playfxontag(common_scripts\utility::func_44F5(self.var_65D2),self,self.var_65D1);
	}
}

//Function Number: 10
func_67A2(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("right_arm");
}

//Function Number: 11
func_679F(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("left_leg");
	if(isdefined(self.var_65D2) && isdefined(self.var_65D1))
	{
		playfxontag(common_scripts\utility::func_44F5(self.var_65D2),self,self.var_65D1);
	}
}

//Function Number: 12
func_67A0(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("left_leg");
}

//Function Number: 13
func_67A3(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("right_leg");
	if(isdefined(self.var_65D2) && isdefined(self.var_65D1))
	{
		playfxontag(common_scripts\utility::func_44F5(self.var_65D2),self,self.var_65D1);
	}
}

//Function Number: 14
func_67A4(param_00,param_01,param_02)
{
	maps\mp\gametypes\_model_dismemberment::func_4AAB("right_leg");
}

//Function Number: 15
func_297E(param_00,param_01)
{
	if(isdefined(self.var_B5))
	{
		var_02 = self.var_B5;
	}
	else
	{
		var_02 = "dirt";
	}

	var_03 = undefined;
	if(isdefined(level.var_686[param_00][var_02]))
	{
		var_03 = level.var_686[param_00][var_02];
	}
	else if(isdefined(level.var_686[param_00]["all"]))
	{
		var_03 = level.var_686[param_00]["all"];
	}

	if(!isdefined(var_03))
	{
		return;
	}

	if(isai(self) && isdefined(var_03.var_3F2F))
	{
		playfxontag(var_03.var_3F2F,self,var_03.var_95A6);
	}

	if(!isdefined(var_03.var_8F3A) && !isdefined(var_03.var_8F3C))
	{
		return;
	}

	var_04 = "" + var_03.var_8F3A + var_02 + var_03.var_8F3C;
	if(!function_0344(var_04))
	{
		var_04 = "" + var_03.var_8F3A + "default" + var_03.var_8F3C;
	}

	func_6784(var_04);
}

//Function Number: 16
func_6793(param_00,param_01,param_02)
{
	var_03 = func_421A("attachmodeltotag",param_00);
	var_04 = var_03[0];
	var_05 = var_03[1];
	if(!isdefined(var_04))
	{
		return;
	}

	if(isdefined(var_05))
	{
		if(self method_8445(var_05) == -1)
		{
			return;
		}

		if(func_55BA(var_04,var_05))
		{
			return;
		}
		else
		{
			self attach(var_04,var_05);
		}
	}
	else
	{
		self attach(var_04);
	}

	thread func_6794(param_00,param_01,var_04,var_05);
}

//Function Number: 17
func_6794(param_00,param_01,param_02,param_03)
{
	if(isai(self))
	{
		for(;;)
		{
			if(!isdefined(self))
			{
				return;
			}

			if(!isalive(self))
			{
				if(1)
				{
					var_04 = 500;
					func_A6E0(param_02,param_03,var_04);
				}
				else
				{
					func_801F(param_02,param_03);
				}

				return;
			}

			wait 0.05;
		}
	}
}

//Function Number: 18
func_801F(param_00,param_01)
{
	if(isdefined(param_01) && func_55BA(param_00,param_01))
	{
		self method_802E(param_00,param_01);
		return 1;
	}
	else if(!isdefined(param_01) && func_55BA(param_00,undefined))
	{
		self method_802E(param_00);
		return 1;
	}

	return 0;
}

//Function Number: 19
func_55BA(param_00,param_01)
{
	var_02 = self getattachsize();
	return 0;
}

//Function Number: 20
func_679A(param_00,param_01,param_02)
{
	var_03 = func_421A("deachmodelfromtag",param_00);
	var_04 = var_03[0];
	var_05 = var_03[1];
	if(!isdefined(var_04))
	{
		return;
	}

	if(isdefined(var_05))
	{
		if(self method_8445(var_05) == -1)
		{
			return;
		}

		func_801F(var_04,var_05);
		return;
	}

	func_801F(var_04);
}

//Function Number: 21
func_6799(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = func_421A("launchmodelfromtag",param_00);
	var_06 = var_05[0];
	var_07 = var_05[1];
	if(!isdefined(var_06))
	{
		return;
	}

	if(isdefined(var_07))
	{
		if(self method_8445(var_07) == -1)
		{
			return;
		}
	}

	var_08 = 500;
	func_A6E0(var_06,var_07,var_08);
}

//Function Number: 22
func_A6E0(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	if(isdefined(param_01))
	{
		var_03 = self gettagorigin(param_01);
		var_04 = self gettagangles(param_01);
	}
	else
	{
		var_03 = self.var_116;
		var_04 = self.var_1D;
	}

	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_01))
	{
		var_05 = self gettagorigin(param_01);
		var_06 = self gettagangles(param_01);
	}
	else
	{
		var_05 = self.var_116;
		var_06 = self.var_1D;
	}

	var_07 = var_03 - var_05;
	func_6FA0(param_00,param_01,var_05,var_06,var_07,param_02);
}

//Function Number: 23
func_6FA0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(func_801F(param_00,param_01))
	{
		var_06 = vectornormalize(param_04) * param_05;
		var_07 = spawn("script_model",param_02);
		var_07 setmodel(param_00);
		var_07.var_1D = param_03;
		var_08 = var_07.var_116;
		var_07 method_82C5(var_08,var_06);
	}
}

//Function Number: 24
func_67A6(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = func_421A("dropmodelfromtag",param_00);
	var_06 = var_05[0];
	var_07 = var_05[1];
	if(!isdefined(var_06))
	{
		return;
	}

	if(isdefined(var_07))
	{
		if(self method_8445(var_07) == -1)
		{
			return;
		}

		var_03 = self gettagorigin(var_07);
		var_04 = self gettagangles(var_07);
	}
	else
	{
		var_03 = self.var_116;
		var_04 = self.var_1D;
	}

	var_08 = (0,0,-1);
	var_09 = 5;
	func_6FA0(var_06,var_07,var_03,var_04,var_08,var_09);
}

//Function Number: 25
func_421A(param_00,param_01)
{
	var_02 = strtok(param_01,"\'");
	var_03 = var_02[1];
	var_04 = var_02[3];
	return [var_03,var_04];
}

//Function Number: 26
notetrackplayfxontag(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("PlayFxOnTag",param_00,param_01,param_02);
}

//Function Number: 27
notetrackstopfxontag(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("StopFxOnTag",param_00,param_01,param_02);
}

//Function Number: 28
notetrackkillfxontag(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("KillFxOnTag",param_00,param_01,param_02);
}

//Function Number: 29
notetrackplayfxontagforclient(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("PlayFxOnTagForClient",param_00,param_01,param_02);
}

//Function Number: 30
notetrackstopfxontagforclient(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("StopFxOnTagForClient",param_00,param_01,param_02);
}

//Function Number: 31
notetrackkillfxontagforclient(param_00,param_01,param_02)
{
	return notetrackplayfxontag_internal("KillFxOnTagForClient",param_00,param_01,param_02);
}

//Function Number: 32
notetrackplayfxontag_internal(param_00,param_01,param_02,param_03)
{
	var_04 = func_421A("playfxontag",param_01);
	var_05 = var_04[0];
	var_06 = var_04[1];
	if(!isdefined(var_05))
	{
		return;
	}

	if(!isdefined(level.var_611[var_05]))
	{
		level.var_611[var_05] = loadfx(var_05);
		if(!isdefined(level.var_611[var_05]))
		{
			return;
		}
	}

	if(isdefined(var_06))
	{
		if(self method_8445(var_06) == -1)
		{
			return;
		}
	}
	else
	{
		var_06 = "TAG_ORIGIN";
	}

	var_07 = 1;
	if(param_00 == "PlayFxOnTag")
	{
		playfxontag(level.var_611[var_05],self,var_06);
		return;
	}

	if(param_00 == "StopFxOnTag")
	{
		stopfxontag(level.var_611[var_05],self,var_06);
		return;
	}

	if(param_00 == "KillFXOnTag")
	{
		killfxontag(level.var_611[var_05],self,var_06);
		return;
	}

	if(param_00 == "PlayFXOnTagForClient")
	{
		foreach(var_09 in param_03)
		{
			playfxontagforclients(level.var_611[var_05],self,var_06,var_09);
		}

		return;
	}

	if(param_00 == "StopFXOnTagForClient")
	{
		foreach(var_09 in param_03)
		{
			function_0294(level.var_611[var_05],self,var_06,var_09);
		}

		return;
	}

	if(param_00 == "KillFXOnTagForClient")
	{
		foreach(var_09 in param_03)
		{
			function_0295(level.var_611[var_05],self,var_06,var_09);
		}

		return;
	}

	var_07 = 0;
}

//Function Number: 33
get_model_tag_from_hideparts(param_00)
{
	var_01 = strtok(param_00,"\'");
	var_02 = var_01[3];
	var_03 = var_01[1];
	return [var_03,var_02];
}

//Function Number: 34
notetrackhidepart(param_00,param_01,param_02)
{
	return notetrackhideorshow_internal("hidepart",param_00,param_01,param_02);
}

//Function Number: 35
notetrackshowpart(param_00,param_01,param_02)
{
	return notetrackhideorshow_internal("showpart",param_00,param_01,param_02);
}

//Function Number: 36
notetrackhideorshow_internal(param_00,param_01,param_02,param_03)
{
	var_04 = get_model_tag_from_hideparts(param_01);
	var_05 = var_04[0];
	var_06 = var_04[1];
	if(!isdefined(var_05))
	{
		return;
	}

	if(isdefined(var_05))
	{
		if(self method_8445(var_05) == -1)
		{
			return;
		}
	}

	var_07 = 1;
	if(param_00 == "hidepart")
	{
		if(isdefined(var_06))
		{
			self hidepart(var_05,var_06);
			return;
		}

		self hidepart(var_05);
		return;
	}

	if(param_00 == "showpart")
	{
		if(isdefined(var_06))
		{
			self showpart(var_05,var_06);
			return;
		}

		self showpart(var_05);
		return;
	}

	var_07 = 0;
}

//Function Number: 37
func_67D6(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::func_9462(param_00,"_");
	if(!isdefined(var_03) || var_03 == -1)
	{
		return;
	}

	var_04 = getsubstr(param_00,var_03 + 1,99999);
	if(!isdefined(var_04))
	{
		return;
	}

	self setmodel(var_04);
}

//Function Number: 38
func_67C6(param_00,param_01,param_02)
{
	var_03 = func_430B("playrumble_",param_00);
	if(isdefined(self))
	{
		foreach(var_05 in param_02)
		{
			var_05 playrumbleonentity(var_03);
		}
	}
}

//Function Number: 39
func_67C7(param_00,param_01,param_02)
{
	var_03 = func_430B("playrumbleloop_",param_00);
	if(isdefined(self))
	{
		foreach(var_05 in param_02)
		{
			var_05 playrumblelooponentity(var_03);
		}
	}
}

//Function Number: 40
func_67E2(param_00,param_01,param_02)
{
	var_03 = func_430B("stoprumble_",param_00);
	if(isdefined(self))
	{
		foreach(var_05 in param_02)
		{
			var_05 stoprumble(var_03);
		}
	}
}

//Function Number: 41
func_67DF(param_00,param_01,param_02)
{
	function_01BD();
}

//Function Number: 42
notetrackfadetoandfromblack(param_00,param_01,param_02)
{
	thread func_67AC(param_00,param_01,param_02);
}

//Function Number: 43
func_67AA(param_00,param_01,param_02)
{
	thread func_67AD(param_00,param_01,1,param_02);
}

//Function Number: 44
func_67A9(param_00,param_01,param_02)
{
	thread func_67AD(param_00,param_01,0,param_02);
}

//Function Number: 45
func_67AC(param_00,param_01,param_02)
{
	var_03 = strtok(param_00,"_;");
	var_04 = var_03[1];
	var_05 = var_03[2];
	var_06 = var_03[3];
	var_07 = var_03[4];
	if(!isdefined(var_03[3]))
	{
		return;
	}

	var_04 = float(var_04);
	var_05 = float(var_05);
	var_06 = float(var_06);
	if(isdefined(var_07) && var_07 == "mayaframes")
	{
		var_04 = var_04 / 30;
		var_05 = var_05 / 30;
		var_06 = var_06 / 30;
	}

	foreach(var_09 in param_02)
	{
		var_09 thread func_30B4(var_04);
	}

	wait(var_04);
	wait(var_05);
	foreach(var_09 in param_02)
	{
		var_09 thread do_fade_from_black(var_06);
	}
}

//Function Number: 46
func_67AD(param_00,param_01,param_02,param_03)
{
	var_04 = strtok(param_00,"_;");
	var_05 = var_04[1];
	var_06 = var_04[2];
	if(!isdefined(var_05))
	{
		return;
	}

	var_07 = float(var_05);
	if(isdefined(var_06) && var_06 == "mayaframes")
	{
		var_07 = var_07 / 30;
	}

	foreach(var_09 in param_03)
	{
		if(param_02)
		{
			var_09 thread func_30B4(var_07);
			continue;
		}

		var_09 thread do_fade_from_black(var_07);
	}
}

//Function Number: 47
notetrackresetfades()
{
	foreach(var_01 in level.var_744A)
	{
		if(isdefined(var_01) && isdefined(var_01.var_6772))
		{
			var_01 thread do_fade_from_black(0);
		}
	}
}

//Function Number: 48
func_30B4(param_00)
{
	self notify("do_fade_from_black");
	self notify("do_fade_to_black");
	self endon("do_fade_to_black");
	if(!isdefined(self.var_6772))
	{
		self.var_6772 = newclienthudelem(self);
		self.var_6772 setshader("black",640,480);
		self.var_6772.ignoreme = 1;
		self.var_6772.var_C6 = "fullscreen";
		self.var_6772.var_1CA = "fullscreen";
		self.var_6772.var_A0 = 1;
	}

	if(param_00 > 0)
	{
		self.var_6772.var_18 = 0;
		self.var_6772 fadeovertime(param_00);
	}

	self.var_6772.var_18 = 1;
	wait(param_00);
}

//Function Number: 49
do_fade_from_black(param_00)
{
	self notify("do_fade_from_black");
	self notify("do_fade_to_black");
	self endon("do_fade_from_black");
	if(!isdefined(self.var_6772))
	{
		self.var_6772 = newclienthudelem(self);
		self.var_6772 setshader("black",640,480);
		self.var_6772.ignoreme = 1;
		self.var_6772.var_C6 = "fullscreen";
		self.var_6772.var_1CA = "fullscreen";
		self.var_6772.var_A0 = 1;
	}

	if(param_00 > 0)
	{
		self.var_6772.var_18 = 1;
		self.var_6772 fadeovertime(param_00);
	}

	self.var_6772.var_18 = 0;
	wait(param_00);
	self.var_6772 destroy();
}

//Function Number: 50
func_67B2(param_00,param_01,param_02)
{
	var_03 = strtok(param_00,"_;");
	var_04 = var_03[1];
	var_05 = var_03[2];
	var_06 = var_03[3];
	if(!isdefined(var_04))
	{
		return;
	}

	if(var_04 == "reset")
	{
		var_04 = 65;
	}
	else if(var_04 == "vehicle")
	{
		if(!isdefined(level.var_67D3))
		{
			return;
		}

		var_04 = level.var_67D3;
	}
	else if(var_04 == "start")
	{
		return;
	}
	else if(var_04 == "end")
	{
		return;
	}
	else if(func_561B(var_04))
	{
		var_04 = int(var_04);
	}
	else
	{
		return;
	}

	if(isdefined(var_06))
	{
		if(func_561B(var_06))
		{
			var_06 = float(var_06);
			if(isdefined(var_05) && var_05 == "mayaframes")
			{
				var_06 = var_06 / 30;
			}
		}
		else if(isdefined(var_06))
		{
			return;
		}
	}
	else if(isdefined(var_05) && func_561B(var_05))
	{
		var_06 = float(var_05);
	}
	else
	{
		var_06 = 0;
	}

	foreach(var_08 in param_02)
	{
		var_09 = var_04 / 65;
		var_0A = int(var_06 * 10) / 10;
		var_08 method_8036(var_09,var_0A);
	}
}

//Function Number: 51
func_67A7(param_00,param_01,param_02)
{
	var_03 = strtok(param_00,"_;");
	var_04 = var_03[1];
	var_05 = var_03[2];
	var_06 = var_03[3];
	if(!isdefined(var_04) || !isdefined(var_05) || !isdefined(var_06))
	{
		return;
	}

	if(isdefined(param_02))
	{
		foreach(var_08 in param_02)
		{
			earthquake(var_04,var_05,self.var_116,var_06,var_08);
		}

		return;
	}

	earthquake(var_04,var_05,self.var_116,var_06);
}

//Function Number: 52
func_0EC0(param_00,param_01)
{
	var_02 = getnotetracks(param_00,param_01,1);
	if(var_02.size > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
func_45B8(param_00)
{
	foreach(var_03, var_02 in level.var_67D4)
	{
		var_03 = tolower(var_03);
		if(function_02C6(param_00,var_03))
		{
			return level.var_67D4[var_03];
		}
	}

	var_04 = level.var_67D0[tolower(param_00)];
	return var_04;
}

//Function Number: 54
func_4AD9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	if(!isdefined(param_05) || isstring(param_05))
	{
		var_06 = func_4627(param_05);
	}
	else if(isarray(param_05))
	{
		var_06 = param_05;
	}
	else if(isplayer(param_05))
	{
		var_06 = [param_05];
	}

	var_07 = func_45B8(param_00);
	if(isdefined(var_07))
	{
		return thread [[ var_07 ]](param_00,param_01,var_06);
	}

	switch(param_00)
	{
		case "undefined":
		case "end":
			return param_00;

		default:
			if(isdefined(param_02))
			{
				return [[ param_02 ]](param_00,param_03);
			}
			break;
	}
}

//Function Number: 55
func_3222(param_00,param_01,param_02,param_03,param_04,param_05)
{
	for(;;)
	{
		self waittill(param_01,var_06);
		if(!isdefined(var_06))
		{
			var_06 = "undefined";
		}

		if(!isdefined(param_05))
		{
			param_05 = "undefined";
		}

		var_07 = func_4AD9(var_06,param_01,param_02,param_05,param_04,param_00);
		if(isdefined(var_07))
		{
			return var_07;
		}
	}
}

//Function Number: 56
func_945F(param_00)
{
	return "" + param_00;
}

//Function Number: 57
func_561B(param_00)
{
	var_01 = float(param_00);
	if(function_02C6(param_00," "))
	{
		while(function_02C6(param_00," "))
		{
			param_00 = getsubstr(param_00,1,9999);
		}
	}

	if(function_02C6(param_00,"-.") || function_02C6(param_00,"."))
	{
		param_00 = "0" + func_945F(param_00);
	}

	if(issubstr(param_00,"."))
	{
		while(isendstr(param_00,"0"))
		{
			param_00 = function_02FF(param_00,"0");
		}
	}
	else
	{
		param_00 = func_945F(param_00);
	}

	return func_945F(var_01) == param_00;
}

//Function Number: 58
func_4627(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(param_01))
	{
		if(param_00 == "all")
		{
			param_01 = 1;
		}
		else if(param_00 == "non_spectator")
		{
			param_01 = 0;
			param_00 = "all";
		}
		else
		{
			param_01 = 0;
		}
	}
	else if(param_00 == "non_spectator" && param_01)
	{
	}

	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		if(!isdefined(var_04.var_1A7))
		{
			continue;
		}

		if(!param_01 && var_04.var_178 == "spectator" || var_04.var_1A7 == "spectator")
		{
			continue;
		}

		if(param_00 == "all" || var_04.var_1A7 == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 59
give_player_xp(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03) && isdefined(param_00))
	{
		param_03 = "default_notifyname" + param_00;
	}

	thread fov_notetrack_team_setter(param_04);
	self method_8495(param_00,param_01,param_02,param_03);
	thread func_3222(param_04,param_03);
}

//Function Number: 60
fov_notetrack_team_setter(param_00)
{
	if(getdvarint("fov_notetracks_code_handling") == 0 && !function_025F())
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(isstring(param_00))
	{
		var_01 = param_00;
		if(var_01 == "all")
		{
			return;
		}

		thread func_8C21(var_01,0);
		return;
	}

	if(isarray(param_00))
	{
		self method_805C();
		foreach(var_03 in param_00)
		{
			var_04 = var_03.var_178 == "spectator";
			if(!var_04)
			{
				self showtoclient(var_03);
			}
		}

		return;
	}

	if(isplayer(param_00))
	{
		self method_805C();
		self showtoclient(param_00);
		return;
	}
}

//Function Number: 61
func_8C21(param_00,param_01)
{
	self notify("showToTeam");
	self endon("showToTeam");
	self endon("clear");
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self method_805C();
	foreach(var_03 in level.var_744A)
	{
		var_04 = var_03.var_178 == "spectator";
		if(var_03.var_1A7 == param_00 && !var_04)
		{
			self showtoclient(var_03);
		}

		if(param_01 && (var_03.var_1A7 == "spectator" || var_04) && param_00 == "allies")
		{
			self showtoclient(var_03);
		}
	}

	for(;;)
	{
		level common_scripts\utility::knock_off_battery("joined_team","joined_spectators","spawn_after_spectator","class_select_cancel_spectator");
		self method_805C();
		foreach(var_03 in level.var_744A)
		{
			var_04 = var_03.var_178 == "spectator";
			if(var_03.var_1A7 == param_00 && !var_04)
			{
				self showtoclient(var_03);
			}

			if(param_01 && (var_03.var_1A7 == "spectator" || var_04) && param_00 == "allies")
			{
				self showtoclient(var_03);
			}
		}
	}
}