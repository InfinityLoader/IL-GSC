/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\stop.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 170 ms
 * Timestamp: 10/27/2023 2:30:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(self.no_ai))
	{
		return;
	}

	if(isdefined(self.var_89E))
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
	[[ self.exception["stop_immediate"] ]]();
	thread delayedexception();
	animscripts/utility::initialize("stop");
	specialidleloop();
	animscripts/utility::randomizeidleset();
	thread setlaststoppedtime();
	thread animscripts/reactions::reactionscheckloop();
	var_00 = isdefined(self.customidleanimset);
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
		var_01 = func_0CE3();
		if(var_01 == "prone")
		{
			var_00 = 1;
			pronestill();
			continue;
		}

		if(self.a.var_911 != var_01)
		{
			self clearanim(%root,0.3);
			var_00 = 0;
		}

		animscripts/setposemovement::setposemovement(var_01,"stop");
		if(!var_00)
		{
			transitiontoidle(var_01,self.a.idleset);
			var_00 = 1;
			continue;
		}

		playidle(var_01,self.a.idleset);
	}
}

//Function Number: 2
setlaststoppedtime()
{
	self endon("death");
	self waittill("killanimscript");
	self.laststoppedtime = gettime();
}

//Function Number: 3
specialidleloop()
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
			self setflaggedanimrestart("special_idle",var_00[randomint(var_00.size)],1,0.2,self.animplaybackrate);
			self waittillmatch("end","special_idle");
		}
	}
}

//Function Number: 4
func_0CE3()
{
	var_00 = animscripts/utility::getclaimednode();
	if(isdefined(var_00))
	{
		var_01 = var_00.angles[1];
		var_02 = var_00.type;
	}
	else
	{
		var_01 = self.desiredangle;
		var_02 = "node was undefined";
	}

	animscripts/face::setidleface(level.alertface);
	var_03 = animscripts/utility::choosepose();
	if(var_02 == "Cover Stand" || var_02 == "Conceal Stand")
	{
		var_03 = animscripts/utility::choosepose("stand");
	}
	else if(var_02 == "Cover Crouch" || var_02 == "Conceal Crouch")
	{
		var_03 = animscripts/utility::choosepose("crouch");
	}
	else if(var_02 == "Cover Prone" || var_02 == "Conceal Prone")
	{
		var_03 = animscripts/utility::choosepose("prone");
	}

	return var_03;
}

//Function Number: 5
transitiontoidle(param_00,param_01)
{
	if(animscripts/utility::iscqbwalking() && self.a.var_911 == "stand")
	{
		param_00 = "stand_cqb";
	}

	if(isdefined(level.idleanimtransition[param_00]))
	{
		var_02 = level.idleanimtransition[param_00]["in"];
		self setflaggedanimknoballrestart("idle_transition",var_02,%body,1,0.2,self.animplaybackrate);
		animscripts/shared::donotetracks("idle_transition");
	}
}

//Function Number: 6
playidle(param_00,param_01)
{
	if(animscripts/utility::iscqbwalking() && self.a.var_911 == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = undefined;
	if(isdefined(self.customidleanimset) && isdefined(self.customidleanimset[param_00]))
	{
		var_03 = self.customidleanimset[param_00];
		var_04 = param_00 + "_add";
		if(isdefined(self.customidleanimset[var_04]))
		{
			var_02 = self.customidleanimset[var_04];
		}
	}
	else if(isdefined(level.readyanimarray) && param_01 == "stand" || param_01 == "stand_cqb" && isdefined(self.busereadyidle) && self.busereadyidle == 1)
	{
		var_03 = animscripts/utility::anim_array(level.readyanimarray["stand"][0],level.readyanimweights["stand"][0]);
	}
	else
	{
		var_02 = var_02 % level.idleanimarray[param_01].size;
		var_03 = animscripts/utility::anim_array(level.idleanimarray[param_01][var_02],level.idleanimweights[param_01][var_02]);
	}

	var_05 = 0.2;
	if(gettime() == self.a.scriptstarttime)
	{
		var_05 = 0.5;
	}

	if(isdefined(var_02))
	{
		self setanimknoball(var_03,%body,1,var_05,1);
		self setanim(%add_idle);
		self setflaggedanimknoballrestart("idle",var_02,%add_idle,1,var_05,self.animplaybackrate);
	}
	else
	{
		self setflaggedanimknoballrestart("idle",var_03,%body,1,var_05,self.animplaybackrate);
	}

	animscripts/shared::donotetracks("idle");
}

//Function Number: 7
pronestill()
{
	if(self.a.var_911 != "prone")
	{
		var_00["stand_2_prone"] = %stand_2_prone;
		var_01 = var_41[self.a.var_911 + "_2_prone"];
		self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
		animscripts/shared::donotetracks("trans");
		self.a.movement = "stop";
		self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
		return;
	}

	thread updatepronethread();
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

	self waittillmatch(%crouch_2_prone,var_41["crouch_2_prone"],%prone_twitch_ammocheck,var_41[0],%prone_twitch_look,var_41[1],%prone_twitch_scan,var_41[2],%prone_twitch_lookfast,var_41[3],%prone_twitch_lookup,var_41[4],"end","prone_idle");
	self notify("kill UpdateProneThread");
}

//Function Number: 8
updatepronethread()
{
	self endon("killanimscript");
	self endon("kill UpdateProneThread");
	for(;;)
	{
		animscripts/cover_prone::updatepronewrapper(0.1);
		wait 0.1;
	}
}

//Function Number: 9
delayedexception()
{
	self endon("killanimscript");
	wait 0.05;
	[[ self.exception["stop"] ]]();
}