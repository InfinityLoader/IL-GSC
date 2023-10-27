/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\stop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 165 ms
 * Timestamp: 10/27/2023 2:18:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.var_10EF))
	{
		return;
	}

	if(isdefined(self.onsnowmobile))
	{
		animscripts/snowmobile::main();
		return;
	}

	if(isdefined(self.custom_animscript_table))
	{
		if(isdefined(self.custom_animscript_table["stop"]))
		{
			[[ self.custom_animscript_table["stop"] ]]();
			return;
		}
	}

	self notify("stopScript");
	self endon("killanimscript");
	[[ self.var_8BE["stop_immediate"] ]]();
	thread func_1104();
	animscripts/utility::func_D15("stop");
	func_10F5();
	animscripts/utility::func_10F0();
	thread func_10F3();
	thread animscripts/reactions::func_F20();
	var_00 = isdefined(self.var_C89);
	if(!var_00)
	{
		if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none")
		{
			var_00 = 1;
		}
		else if(angleclamp180(self getmuzzleangle()[0]) > 20)
		{
			var_00 = 1;
		}
	}

	for(;;)
	{
		var_01 = func_10F8();
		if(var_01 == "prone")
		{
			var_00 = 1;
			func_1102();
			continue;
		}

		if(self.a.pose != var_01)
		{
			self clearanim(%root,0.3);
			var_00 = 0;
		}

		animscripts/setposemovement::func_10F1(var_01,"stop");
		if(!var_00)
		{
			func_10F9(var_01,self.a.var_10F2);
			var_00 = 1;
			continue;
		}

		func_10FB(var_01,self.a.var_10F2);
	}
}

//Function Number: 2
func_10F3()
{
	self endon("death");
	self waittill("killanimscript");
	self.var_10F4 = gettime();
}

//Function Number: 3
func_10F5()
{
	self endon("stop_specialidle");
	if(isdefined(self.specialidleanim))
	{
		var_00 = self.specialidleanim;
		self.specialidleanim = undefined;
		self notify("clearing_specialIdleAnim");
		self animmode("gravity");
		self orientmode("face current");
		self clearanim(%root,0.2);
		for(;;)
		{
			self setflaggedanimrestart("special_idle",var_00[randomint(var_00.size)],1,0.2,self.var_10F7);
			self waittillmatch("end","special_idle");
		}
	}
}

//Function Number: 4
func_10F8()
{
	var_00 = animscripts/utility::func_BEE();
	if(isdefined(var_00))
	{
		var_01 = var_00.angles[1];
		var_02 = var_00.type;
	}
	else
	{
		var_01 = self.var_72B;
		var_02 = "node was undefined";
	}

	animscripts/face::func_C45(level.var_C3D);
	var_03 = animscripts/utility::func_10AF();
	if(var_02 == "Cover Stand" || var_02 == "Conceal Stand")
	{
		var_03 = animscripts/utility::func_10AF("stand");
	}
	else if(var_02 == "Cover Crouch" || var_02 == "Conceal Crouch")
	{
		var_03 = animscripts/utility::func_10AF("crouch");
	}
	else if(var_02 == "Cover Prone" || var_02 == "Conceal Prone")
	{
		var_03 = animscripts/utility::func_10AF("prone");
	}

	return var_03;
}

//Function Number: 5
func_10F9(param_00,param_01)
{
	if(animscripts/utility::func_C98() && self.a.pose == "stand")
	{
		param_00 = "stand_cqb";
	}

	if(isdefined(level.var_10FA[param_00]))
	{
		var_02 = level.var_10FA[param_00]["in"];
		self setflaggedanimknoballrestart("idle_transition",var_02,%body,1,0.2,self.var_10F7);
		animscripts/shared::donotetracks("idle_transition");
	}
}

//Function Number: 6
func_10FB(param_00,param_01)
{
	if(animscripts/utility::func_C98() && self.a.pose == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = undefined;
	if(isdefined(self.var_C89) && isdefined(self.var_C89[param_00]))
	{
		var_03 = self.var_C89[param_00];
		var_04 = param_00 + "_add";
		if(isdefined(self.var_C89[var_04]))
		{
			var_02 = self.var_C89[var_04];
		}
	}
	else if(isdefined(level.var_10FC) && param_01 == "stand" || param_01 == "stand_cqb" && isdefined(self.busereadyidle) && self.busereadyidle == 1)
	{
		var_03 = animscripts/utility::func_10FF(level.var_10FC["stand"][0],level.var_10FE["stand"][0]);
	}
	else
	{
		var_02 = var_02 % level.var_1100[param_01].size;
		var_03 = animscripts/utility::func_10FF(level.var_1100[param_01][var_02],level.var_1101[param_01][var_02]);
	}

	var_05 = 0.2;
	if(gettime() == self.a.var_1019)
	{
		var_05 = 0.5;
	}

	if(isdefined(var_02))
	{
		self setanimknoball(var_03,%body,1,var_05,1);
		self setanim(%add_idle);
		self setflaggedanimknoballrestart("idle",var_02,%add_idle,1,var_05,self.var_10F7);
	}
	else
	{
		self setflaggedanimknoballrestart("idle",var_03,%body,1,var_05,self.var_10F7);
	}

	animscripts/shared::donotetracks("idle");
}

//Function Number: 7
func_1102()
{
	if(self.a.pose != "prone")
	{
		var_00["stand_2_prone"] = %stand_2_prone;
		var_01 = var_7B[self.a.pose + "_2_prone"];
		self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
		animscripts/shared::donotetracks("trans");
		self.a.movement = "stop";
		self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
		return;
	}

	thread func_1103();
	if(randomint(10) < 3)
	{
		var_02 = [];
		var_03 = var_02[randomint(var_02.size)];
		self setflaggedanimknoball("prone_idle",var_03,%exposed_modern,1,0.2);
	}
	else
	{
		self setanimknoball(%prone_aim_5,%exposed_modern,1,0.2);
		self setflaggedanimknob("prone_idle",%prone_idle,1,0.2);
	}

	self waittillmatch(%crouch_2_prone,var_7B["crouch_2_prone"],%prone_twitch_ammocheck,var_7B[0],%prone_twitch_look,var_7B[1],%prone_twitch_scan,var_7B[2],%prone_twitch_lookfast,var_7B[3],%prone_twitch_lookup,var_7B[4],"end","prone_idle");
	self notify("kill UpdateProneThread");
}

//Function Number: 8
func_1103()
{
	self endon("killanimscript");
	self endon("kill UpdateProneThread");
	for(;;)
	{
		animscripts/cover_prone::func_10E2(0.1);
		wait 0.1;
	}
}

//Function Number: 9
func_1104()
{
	self endon("killanimscript");
	wait 0.05;
	[[ self.var_8BE["stop"] ]]();
}