/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\face.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 365 ms
 * Timestamp: 10/27/2023 2:44:10 AM
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
		case "xslice":
		case "pmc":
		case "czech":
		case "french":
		case "taskforce":
		case "seal":
		case "american":
		case "delta":
			break;

		default:
			break;
	}
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
				break;

			case "pain":
				break;

			case "death":
				break;
		}
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
clearfacialanim()
{
	self clearanim(%head,0.2);
}

//Function Number: 17
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

	if(self method_84EA())
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
		if(isdefined(param_00))
		{
			thread end_facial_on_death(getanimlength(param_00));
		}
		else
		{
			thread end_facial_on_death();
		}
	}

	return var_03;
}

//Function Number: 18
end_facial_on_death(param_00)
{
	var_01 = 1;
	var_02 = 0.2;
	if(isdefined(param_00))
	{
		var_01 = clamp(param_00,var_02 + 0.5,var_01 + var_02) - var_02;
	}

	wait(var_01);
	if(isdefined(self))
	{
		self clearanim(%head,var_02);
	}
}

//Function Number: 19
get_eye_relative_dir()
{
	if(self method_843E("jnt_eyelid_TL") == -1 || self method_843E("tag_eye") == -1)
	{
		return;
	}

	if(self method_843E("jnt_eyelid_TR") == -1)
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

	if(isdefined(self.eye_move_counter) && self.eye_move_counter > 4 && isdefined(self.script) && self.script != "scripted" && self.script != "death")
	{
		var_05 = playfacialanim(undefined,"idle",undefined);
		if(isdefined(var_05))
		{
			wait(getanimlength(level.facial["idle"][var_05]));
		}

		self.eye_move_counter = 0;
	}
}

//Function Number: 20
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