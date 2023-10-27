/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\stop.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 216 ms
 * Timestamp: 10/27/2023 2:44:50 AM
*******************************************************************/

//Function Number: 1
init_animset_idle()
{
	var_00 = [];
	var_00["stand"][0] = [%casual_stand_idle,%casual_stand_idle_twitch,%casual_stand_idle_twitchb];
	var_00["stand_combat"][0] = [%cqb_stand_idle,%cqb_stand_twitch];
	var_00["stand_cqb"][0] = [%cqb_stand_idle,%cqb_stand_twitch];
	var_00["crouch"][0] = [%casual_crouch_idle];
	var_00["crouch_combat"][0] = [%exposed_crouch_aim_5];
	var_01 = [];
	var_01["crouch_combat"][0] = %exposed_crouch_idle_alert_v1;
	var_01["crouch_combat"][1] = %exposed_crouch_idle_alert_v2;
	var_01["crouch_combat"][2] = %exposed_crouch_idle_alert_v3;
	level.archetypes["soldier"]["idle"] = var_00;
	level.archetypes["soldier"]["idle_add"] = var_01;
	var_00 = [];
	var_00["stand"][0] = [2,1,1];
	var_00["stand"][1] = [10,4,7,4];
	var_00["stand_combat"][0] = [2,1];
	var_00["stand_cqb"][0] = [2,1];
	var_00["crouch"][0] = [6];
	var_00["crouch_combat"][0] = [6];
	level.archetypes["soldier"]["idle_weights"] = var_00;
	var_00 = [];
	var_00["stand"] = %casual_stand_idle_trans_in;
	var_00["crouch"] = %casual_crouch_idle_in;
	var_00["stand_smg"] = %smg_casual_stand_idle_trans_in;
	level.archetypes["soldier"]["idle_transitions"] = var_00;
}

//Function Number: 2
main()
{
	if(isdefined(self.no_ai))
	{
		return;
	}

	if(isdefined(self.custom_animscript))
	{
		if(isdefined(self.custom_animscript["stop"]))
		{
			[[ self.custom_animscript["stop"] ]]();
			return;
		}
	}

	self notify("stopScript");
	self endon("killanimscript");
	[[ self.exception["stop_immediate"] ]]();
	thread delayedexception();
	animscripts\utility::initialize("stop");
	if(isdefined(self.specialidleanim))
	{
		specialidleloop();
	}

	animscripts\utility::randomizeidleset();
	thread setlaststoppedtime();
	thread animscripts\reactions::reactionscheckloop();
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

	if(self.swimmer && !isdefined(self.enemy))
	{
		var_01 = animscripts\exit_node::getexitnode();
		if(isdefined(var_01))
		{
			self setflaggedanimknoballrestart("idle",self.customidleanimset["stand"],%body,1,0.5,self.animplaybackrate);
			turntoangle(var_01.angles[1]);
		}
		else
		{
			self orientmode("face angle",self.angles[1]);
		}
	}

	for(;;)
	{
		var_02 = getdesiredidlepose();
		if(var_02 == "prone")
		{
			var_00 = 1;
			pronestill();
			continue;
		}

		if(self.a.pose != var_02)
		{
			self clearanim(%animscript_root,0.3);
			var_00 = 0;
		}

		if(animscripts\setposemovement::setposemovement(var_02,"stop"))
		{
			continue;
		}

		if(!var_00)
		{
			transitiontoidle(var_02,self.a.idleset);
			var_00 = 1;
			continue;
		}

		playidle(var_02,self.a.idleset);
	}
}

//Function Number: 3
turntoangle(param_00)
{
	var_01 = self.angles[1];
	var_02 = angleclamp180(param_00 - var_01);
	if(-20 < var_02 && var_02 < 20)
	{
		rotatetoangle(param_00,2);
		return;
	}

	var_03 = animscripts\swim::getswimanim("idle_turn");
	if(var_02 < -80)
	{
		var_04 = var_03[2];
	}
	else if(var_03 < -20)
	{
		var_04 = var_04[3];
	}
	else if(var_03 < 80)
	{
		var_04 = var_04[5];
	}
	else
	{
		var_04 = var_04[6];
	}

	var_05 = getanimlength(var_04);
	var_06 = abs(var_02) / self.turnrate;
	var_06 = var_06 / 1000;
	var_07 = var_05 / var_06;
	self orientmode("face angle",param_00);
	self setflaggedanimrestart("swim_turn",var_04,1,0.2,var_07 * self.moveplaybackrate);
	animscripts\shared::donotetracks("swim_turn");
	self clearanim(var_04,0.2);
}

//Function Number: 4
rotatetoangle(param_00,param_01)
{
	self orientmode("face angle",param_00);
	while(angleclamp(param_00 - self.angles[1]) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 5
setlaststoppedtime()
{
	self endon("death");
	self waittill("killanimscript");
	self.laststoppedtime = gettime();
}

//Function Number: 6
specialidleloop()
{
	self endon("stop_specialidle");
	self.a.movement = "stop";
	var_00 = self.specialidleanim;
	self animmode("gravity");
	self orientmode("face current");
	self clearanim(%animscript_root,0.2);
	if(var_00.size == 0)
	{
		return;
	}

	var_01 = [];
	var_02 = var_00[0];
	for(;;)
	{
		if(var_01.size == 0)
		{
			var_01 = common_scripts\utility::array_randomize(var_00);
		}

		if(var_01[0] == var_02 && var_01.size > 1)
		{
			var_02 = var_01[1];
		}
		else
		{
			var_02 = var_01[0];
		}

		var_01 = common_scripts\utility::array_remove(var_01,var_02);
		self setflaggedanimrestart("special_idle",var_02,1,0.2,self.animplaybackrate);
		childthread animscripts\shared::donotetracks("special_idle");
		self waittillmatch("end","special_idle");
		if(var_00.size > 1)
		{
			self clearanim(var_02,0.2);
		}
	}
}

//Function Number: 7
getdesiredidlepose()
{
	var_00 = animscripts\utility::getclaimednode();
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

	animscripts\face::setidleface(level.alertface);
	var_03 = animscripts\utility::choosepose();
	if(var_02 == "Cover Stand" || var_02 == "Conceal Stand")
	{
		var_03 = animscripts\utility::choosepose("stand");
	}
	else if(var_02 == "Cover Crouch" || var_02 == "Conceal Crouch")
	{
		var_03 = animscripts\utility::choosepose("crouch");
	}
	else if(var_02 == "Cover Prone" || var_02 == "Conceal Prone")
	{
		var_03 = animscripts\utility::choosepose("prone");
	}

	return var_03;
}

//Function Number: 8
transitiontoidle(param_00,param_01)
{
	var_02 = self getisforcedincombat();
	if(isdefined(self.node))
	{
		if(self.node doesnodeforcecombat())
		{
			var_02 = 1;
		}

		if(self.node method_8564())
		{
			var_02 = 0;
		}
	}

	if(animscripts\utility::iscqbwalking() && self.a.pose == "stand" && animscripts\utility::isincombat() || var_02)
	{
		param_00 = "stand_cqb";
	}
	else if(animscripts\utility::usingsmg() && self.a.pose == "stand")
	{
		param_00 = "stand_smg";
	}
	else if(self.a.pose == "stand" && var_02)
	{
		param_00 = "stand_combat";
	}
	else if(self.a.pose == "crouch" && var_02)
	{
		param_00 = "crouch_combat";
	}

	var_03 = animscripts\utility::lookupanimarray("idle_transitions");
	if(isdefined(var_03[param_00]))
	{
		var_04 = var_03[param_00];
		self setflaggedanimknoballrestart("idle_transition",var_04,%body,1,0.2,self.animplaybackrate);
		animscripts\shared::donotetracks("idle_transition");
	}
}

//Function Number: 9
playidle(param_00,param_01)
{
	var_02 = self getisforcedincombat();
	if(isdefined(self.node))
	{
		if(self.node doesnodeforcecombat())
		{
			var_02 = 1;
		}

		if(self.node method_8564())
		{
			var_02 = 0;
		}
	}

	if(animscripts\utility::iscqbwalking() && self.a.pose == "stand" && animscripts\utility::isincombat() || var_02)
	{
		param_00 = "stand_cqb";
	}
	else if(self.a.pose == "stand" && var_02)
	{
		param_00 = "stand_combat";
	}
	else if(self.a.pose == "crouch" && var_02)
	{
		param_00 = "crouch_combat";
	}

	var_03 = undefined;
	if(isdefined(self.customidleanimset) && isdefined(self.customidleanimset[param_00]))
	{
		if(isarray(self.customidleanimset[param_00]))
		{
			var_04 = animscripts\utility::anim_array(self.customidleanimset[param_00],self.customidleanimweights[param_00]);
		}
		else
		{
			var_04 = self.customidleanimset[param_01];
			var_05 = param_00 + "_add";
			if(isdefined(self.customidleanimset[var_05]))
			{
				var_03 = self.customidleanimset[var_05];
			}
		}
	}
	else if(isdefined(level.readyanimarray) && param_01 == "stand" || param_01 == "stand_cqb" && isdefined(self.busereadyidle) && self.busereadyidle == 1)
	{
		var_04 = animscripts\utility::anim_array(level.readyanimarray["stand"][0],level.readyanimweights["stand"][0]);
	}
	else
	{
		var_06 = animscripts\utility::lookupanimarray("idle");
		var_07 = animscripts\utility::lookupanimarray("idle_weights");
		param_01 = param_01 % var_06[param_00].size;
		var_04 = animscripts\utility::anim_array(var_06[param_00][param_01],var_07[param_00][param_01]);
		var_08 = animscripts\utility::lookupanimarray("idle_add");
		if(isdefined(var_08[param_00]))
		{
			var_09 = var_08[param_00].size * 6;
			var_0A = randomint(var_09);
			if(var_0A < var_08[param_00].size)
			{
				var_03 = var_08[param_00][var_0A];
			}
		}
	}

	var_0B = 0.2;
	if(gettime() == self.a.scriptstarttime)
	{
		var_0B = 0.5;
	}

	if(isdefined(var_03))
	{
		self setanimknoball(var_04,%body,1,var_0B,1);
		self setanim(%add_idle);
		self setflaggedanimknoballrestart("idle",var_03,%add_idle,1,var_0B,self.animplaybackrate);
	}
	else
	{
		self setflaggedanimknoballrestart("idle",var_04,%body,1,var_0B,self.animplaybackrate);
	}

	animscripts\shared::donotetracks("idle");
}

//Function Number: 10
pronestill()
{
	var_00 = [];
	var_01 = undefined;
	var_02 = undefined;
	if(self.a.pose != "prone")
	{
		var_00["stand_2_prone"] = %stand_2_prone;
		var_00["crouch_2_prone"] = %crouch_2_prone;
		var_01 = var_00[self.a.pose + "_2_prone"];
	}
	else if(self.a.movement != "stop")
	{
		if(self.prevscript == "move" && isdefined(self.movetransitionanimation) && isdefined(self.movetransitionendpose) && self.movetransitionendpose == "prone")
		{
			var_03 = getanimlength(self.movetransitionanimation) * 1 - self getanimtime(self.movetransitionanimation);
			if(var_03 > 0.05)
			{
				var_02 = self getanimtime(self.movetransitionanimation);
				var_01 = self.movetransitionanimation;
			}
		}
		else
		{
			var_01 = %h1_crawl_2_prone;
		}
	}

	if(isdefined(var_01))
	{
		self setflaggedanimknoballrestart("trans",var_01,%body,1,0.2,1);
		if(isdefined(var_02))
		{
			self setanimtime(var_01,var_02);
		}

		animscripts\shared::donotetracks("trans");
		self.a.movement = "stop";
		self setproneanimnodes(-45,45,%prone_legs_down,%exposed_modern,%prone_legs_up);
		return;
	}

	thread updatepronethread();
	if(randomint(10) < 3)
	{
		var_04 = animscripts\utility::lookupanim("cover_prone","twitch");
		var_05 = var_04[randomint(var_04.size)];
		self setflaggedanimknoball("prone_idle",var_05,%exposed_modern,1,0.2);
	}
	else
	{
		self setanimknoball(animscripts\utility::lookupanim("cover_prone","straight_level"),%exposed_modern,1,0.2);
		self setflaggedanimknob("prone_idle",animscripts\utility::lookupanim("cover_prone","exposed_idle")[0],1,0.2);
	}

	self waittillmatch("end","prone_idle");
	self notify("kill UpdateProneThread");
}

//Function Number: 11
updatepronethread()
{
	self endon("killanimscript");
	self endon("kill UpdateProneThread");
	for(;;)
	{
		animscripts\cover_prone::updatepronewrapper(0.1);
		wait(0.1);
	}
}

//Function Number: 12
delayedexception()
{
	self endon("killanimscript");
	wait(0.05);
	[[ self.exception["stop"] ]]();
}