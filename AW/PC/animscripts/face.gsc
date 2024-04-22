/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: face.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 272 ms
 * Timestamp: 4/22/2024 2:00:29 AM
*******************************************************************/

//Function Number: 1
initcharacterface()
{
	if(!level.usefacialanims)
	{
		return;
	}

	if(!isdefined(self.a.currentdialogimportance))
	{
		self.a.currentdialogimportance = 0;
		self.a.idleface = level.alertface;
		self.facewaiting = [];
		self.facelastnotifynum = 0;
	}
}

//Function Number: 2
saygenericdialogue(param_00)
{
	var_01 = undefined;
	switch(self.voice)
	{
		case "czech":
		case "french":
		case "seal":
		case "taskforce":
		case "delta":
		case "pmc":
		case "xslice":
		case "american":
			var_02 = "friendly";
			var_03 = level.numfriendlyvoices;
			break;

		default:
			var_02 = "enemy";
			var_03 = level.numenemyvoices;
			break;
	}

	var_01 = 1 + self getentitynumber() % var_03;
	var_02 = var_02 + "_" + var_01;
	var_04 = undefined;
	switch(param_00)
	{
		case "meleecharge":
		case "meleeattack":
			var_05 = 0.5;
			break;

		case "flashbang":
			var_05 = 0.7;
			break;

		case "pain":
			var_05 = 0.9;
			break;

		case "pain_small":
			var_05 = 0.9;
			break;

		case "dogdeathlongplr":
		case "dogdeathshortplr":
		case "dogdeathlong":
		case "dogdeathshort":
		case "melee_death":
		case "death":
			var_05 = 1;
			break;

		default:
			var_05 = 0.3;
			break;
	}

	var_06 = undefined;
	if(isdefined(self.generic_voice_override))
	{
		var_06 = self.generic_voice_override + "_" + param_00 + "_" + var_02;
		if(!soundexists(var_06))
		{
			var_06 = "generic_" + param_00 + "_" + var_02;
		}
	}
	else
	{
		var_06 = "generic_" + param_00 + "_" + var_02;
	}

	thread playfacethread(var_04,var_06,var_05);
}

//Function Number: 3
setidlefacedelayed(param_00)
{
	animscripts\battlechatter::playbattlechatter();
	self.a.idleface = param_00;
}

//Function Number: 4
setidleface(param_00)
{
	if(!level.usefacialanims)
	{
		return;
	}

	animscripts\battlechatter::playbattlechatter();
	self.a.idleface = param_00;
	playidleface();
}

//Function Number: 5
sayspecificdialogue(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread playfacethread(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 6
chooseanimfromset(param_00)
{
}

//Function Number: 7
playidleface()
{
}

//Function Number: 8
playfacethread(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.a.facialanimdone = 1;
	self.a.facialsounddone = 1;
	if(isdefined(param_03))
	{
		if(isdefined(param_01))
		{
			if(!soundexists(param_01))
			{
				wait(0);
				self notify(param_03);
			}

			self playsoundatviewheight(param_01,"animscript facesound" + param_03,1);
			thread waitforfacesound(param_03);
		}
	}
	else
	{
		self playsoundatviewheight(param_01);
	}

	if(!level.usefacialanims)
	{
		return;
	}

	initcharacterface();
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		if(isdefined(param_03))
		{
			wait(0);
			self.faceresult = "failed";
			self notify(param_03);
		}

		return;
	}

	self endon("death");
	if(isstring(param_02))
	{
		switch(param_02)
		{
			case "any":
				param_02 = 0.1;
				break;

			case "pain":
				param_02 = 0.9;
				break;

			case "death":
				param_02 = 1;
				break;
		}
	}

	if(param_02 <= self.a.currentdialogimportance && isdefined(param_04) && param_04 == "wait")
	{
		var_06 = self.facewaiting.size;
		var_07 = self.facelastnotifynum + 1;
		self.facewaiting[var_06]["facialanim"] = param_00;
		self.facewaiting[var_06]["soundAlias"] = param_01;
		self.facewaiting[var_06]["importance"] = param_02;
		self.facewaiting[var_06]["notifyString"] = param_03;
		self.facewaiting[var_06]["waitOrNot"] = param_04;
		self.facewaiting[var_06]["timeToWait"] = param_05;
		self.facewaiting[var_06]["notifyNum"] = var_07;
		thread playface_waitfornotify("animscript face stop waiting " + self.facewaiting[var_06]["notifyNum"],"Face done waiting","Face done waiting");
		if(isdefined(param_05))
		{
			thread playface_waitfortime(param_05,"Face done waiting","Face done waiting");
		}

		self waittill("Face done waiting");
		var_06 = undefined;
		for(var_08 = 0;var_08 < self.facewaiting.size;var_08++)
		{
			if(self.facewaiting[var_08]["notifyNum"] == var_07)
			{
				var_06 = var_08;
				break;
			}
		}

		if(self.a.facewaitforresult == "notify")
		{
			playfacethread(self.facewaiting[var_06]["facialanim"],self.facewaiting[var_06]["soundAlias"],self.facewaiting[var_06]["importance"],self.facewaiting[var_06]["notifyString"]);
		}
		else if(isdefined(param_03))
		{
			self.faceresult = "failed";
			self notify(param_03);
		}

		for(var_08 = var_06 + 1;var_08 < self.facewaiting.size;var_08++)
		{
			self.facewaiting[var_08 - 1]["facialanim"] = self.facewaiting[var_08]["facialanim"];
			self.facewaiting[var_08 - 1]["soundAlias"] = self.facewaiting[var_08]["soundAlias"];
			self.facewaiting[var_08 - 1]["importance"] = self.facewaiting[var_08]["importance"];
			self.facewaiting[var_08 - 1]["notifyString"] = self.facewaiting[var_08]["notifyString"];
			self.facewaiting[var_08 - 1]["waitOrNot"] = self.facewaiting[var_08]["waitOrNot"];
			self.facewaiting[var_08 - 1]["timeToWait"] = self.facewaiting[var_08]["timeToWait"];
			self.facewaiting[var_08 - 1]["notifyNum"] = self.facewaiting[var_08]["notifyNum"];
		}

		self.facewaiting[self.facewaiting.size - 1] = undefined;
		return;
	}

	if(param_02 >= self.a.currentdialogimportance)
	{
		self notify("end current face");
		self endon("end current face");
		if(isdefined(param_03))
		{
			if(isdefined(self.a.currentdialognotifystring))
			{
				self.faceresult = "interrupted";
				self notify(self.a.currentdialognotifystring);
			}
		}

		self.a.currentdialogimportance = param_02;
		self.a.currentdialogsound = param_01;
		self.a.currentdialognotifystring = param_03;
		self.a.facialanimdone = 1;
		self.a.facialsounddone = 1;
		if(isdefined(param_00))
		{
			maps\_anim::disabledefaultfacialanims();
			self setflaggedanimknobrestart("animscript faceanim",param_00,1,0.1,1);
			self.a.facialanimdone = 0;
			thread waitforfacialanim();
		}
		else
		{
			maps\_anim::disabledefaultfacialanims(0);
		}

		if(isdefined(param_01))
		{
			self playsoundatviewheight(param_01,"animscript facesound",1);
			self.a.facialsounddone = 0;
			thread waitforfacesound();
		}

		while(!self.a.facialanimdone || !self.a.facialsounddone)
		{
			self waittill("animscript facedone");
		}

		self.a.currentdialogimportance = 0;
		self.a.currentdialogsound = undefined;
		self.a.currentdialognotifystring = undefined;
		if(isdefined(param_03))
		{
			self.faceresult = "finished";
			self notify(param_03);
		}

		if(isdefined(self.facewaiting) && self.facewaiting.size > 0)
		{
			var_09 = 0;
			var_0A = 1;
			for(var_08 = 0;var_08 < self.facewaiting.size;var_08++)
			{
				if(self.facewaiting[var_08]["importance"] > var_09)
				{
					var_09 = self.facewaiting[var_08]["importance"];
					var_0A = var_08;
				}
			}

			self notify("animscript face stop waiting " + self.facewaiting[var_0A]["notifyNum"]);
			return;
		}

		if(isai(self))
		{
			playidleface();
			return;
		}

		return;
	}

	if(isdefined(param_03))
	{
		self.faceresult = "failed";
		self notify(param_03);
		return;
	}
}

//Function Number: 9
waitforfacialanim()
{
	self endon("death");
	self endon("end current face");
	animscripts\shared::donotetracks("animscript faceanim");
	self.a.facialanimdone = 1;
	self notify("animscript facedone");
	maps\_anim::disabledefaultfacialanims(0);
}

//Function Number: 10
waitforfacesound(param_00)
{
	self endon("death");
	self waittill("animscript facesound" + param_00);
	self notify(param_00);
}

//Function Number: 11
playface_waitfornotify(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	self waittill(param_00);
	self.a.facewaitforresult = "notify";
	self notify(param_01);
}

//Function Number: 12
playface_waitfortime(param_00,param_01,param_02)
{
	self endon("death");
	self endon(param_02);
	wait(param_00);
	self.a.facewaitforresult = "time";
	self notify(param_01);
}

//Function Number: 13
initlevelface()
{
	anim.numfriendlyvoices = 8;
	anim.numenemyvoices = 8;
	initfacialanims();
}

//Function Number: 14
initfacialanims()
{
	anim.facial = [];
	level.facial["pain"] = [%facial_pain_1,%facial_pain_2,%facial_pain_3,%facial_pain_4];
	level.facial["aim"] = [%facial_aim_1,%facial_aim_2];
	level.facial["run"] = [%facial_run_1,%facial_run_2];
	level.facial["corner_stand_L"] = [%facial_corner_stand_l_1,%facial_corner_stand_l_2];
	level.facial["corner_stand_R"] = [%facial_corner_stand_r_1,%facial_corner_stand_r_2];
	level.facial["death"] = [%facial_death_1,%facial_death_2,%facial_death_3,%facial_death_4];
	level.facial["idle"] = [%facial_idle_1,%facial_idle_2,%facial_idle_3];
	level.facial["pain_blend"] = [%facial_pain_blend_1,%facial_pain_blend_2,%facial_pain_blend_3,%facial_pain_blend_4];
	level.facial["aim_blend"] = [%facial_aim_blend_1,%facial_aim_blend_2];
	level.facial["run_blend"] = [%facial_run_blend_1,%facial_run_blend_2];
	level.facial["corner_stand_L_blend"] = [%facial_corner_stand_l_blend_1,%facial_corner_stand_l_blend_2];
	level.facial["corner_stand_R_blend"] = [%facial_corner_stand_r_blend_1,%facial_corner_stand_r_blend_2];
	level.facial["death_blend"] = [%facial_death_blend_1,%facial_death_blend_2,%facial_death_blend_3,%facial_death_blend_4];
	level.facial["idle_blend"] = [%facial_idle_blend_1,%facial_idle_blend_2,%facial_idle_blend_3];
}

//Function Number: 15
animhasfacialoverride(param_00)
{
	return animhasnotetrack(param_00,"facial_override");
}

//Function Number: 16
playfacialanim(param_00,param_01,param_02)
{
	if(!isdefined(self.facialidlemonitor))
	{
		thread facial_idle_monitor_thread();
	}

	if(isdefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims)
	{
		self clearanim(%head,0.2);
		return;
	}

	if(isdefined(param_00) && animhasfacialoverride(param_00))
	{
		self clearanim(%head,0.2);
		return;
	}

	if(self hasblendshapes())
	{
		param_01 = param_01 + "_blend";
	}

	if(!isdefined(level.facial[param_01]))
	{
		return;
	}

	if(isdefined(param_02) && param_02 >= 0 && param_02 < level.facial[param_01].size)
	{
		var_03 = param_02;
	}
	else
	{
		var_03 = randomint(level.facial[param_02].size);
	}

	var_04 = level.facial[param_01][var_03];
	self setanimknob(var_04);
	if(param_01 == "death")
	{
		thread end_facial_on_death();
	}

	return var_03;
}

//Function Number: 17
end_facial_on_death()
{
	wait(1);
	if(isdefined(self))
	{
		self clearanim(%head,0.2);
	}
}

//Function Number: 18
get_eye_relative_dir()
{
	if(self gettagindex("jnt_eyelid_TL") == -1 || self gettagindex("tag_eye") == -1)
	{
		return;
	}

	if(self gettagindex("jnt_eyelid_TR") == -1)
	{
		return;
	}

	var_00 = self gettagangles("tag_eye");
	var_01 = self gettagangles("jnt_eyelid_TR");
	var_02 = self gettagangles("jnt_eyelid_TL");
	var_03 = angleclamp180(abs(var_00[0] - var_01[0]));
	var_04 = angleclamp180(abs(var_00[0] - var_02[0]));
	if(!isdefined(self.prev_eyel_diff))
	{
		self.prev_eyel_diff = var_03;
	}

	if(!isdefined(self.prev_eyer_diff))
	{
		self.prev_eyer_diff = var_04;
	}

	if(!isdefined(self.eye_move_counter))
	{
		self.eye_move_counter = 0;
	}

	if(angleclamp180(var_03 - self.prev_eyel_diff) > 5 || angleclamp180(var_04 - self.prev_eyer_diff) > 5)
	{
		self.prev_eyel_diff = var_03;
		self.prev_eyer_diff = var_04;
	}
	else
	{
		self.eye_move_counter++;
	}

	if(isdefined(self.eye_move_counter) && self.eye_move_counter > 4 && isdefined(self.script) && self.script != "scripted")
	{
		var_05 = playfacialanim(undefined,"idle",undefined);
		if(isdefined(var_05))
		{
			wait(getanimlength(level.facial["idle"][var_05]));
		}

		self.eye_move_counter = 0;
	}
}

//Function Number: 19
facial_idle_monitor_thread()
{
	self endon("death");
	self endon("killanimscript");
	self.facialidlemonitor = 1;
	for(;;)
	{
		get_eye_relative_dir();
		wait(0.35);
	}
}