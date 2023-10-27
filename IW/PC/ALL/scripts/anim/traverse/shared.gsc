/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\traverse\shared.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 922 ms
 * Timestamp: 10/26/2023 11:59:41 PM
*******************************************************************/

//Function Number: 1
func_18D1(param_00,param_01)
{
	self.var_5270 = "crouch";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	var_02 = self method_8148();
	self method_8221("face angle",var_02.angles[1]);
	var_02.var_126D4 = var_02.origin[2] + var_02.var_126D5;
	var_03 = var_02.var_126D4 - var_02.origin[2];
	thread func_11661(var_03 - param_01);
	var_04 = 0.15;
	self method_806F(%body,var_04);
	self method_82E4("traverse",param_00,%root,1,var_04,1);
	var_05 = 0.2;
	var_06 = 0.2;
	thread scripts\anim\notetracks::func_592D("traverse","no clear");
	if(!animhasnotetrack(param_00,"gravity on"))
	{
		var_07 = 1.23;
		wait(var_07 - var_05);
		self method_83C4("gravity");
		wait(var_05);
		return;
	}

	self waittillmatch("gravity on","traverse");
	self method_83C4("gravity");
	if(!animhasnotetrack(param_00,"blend"))
	{
		wait(var_05);
		return;
	}

	self waittillmatch("blend","traverse");
}

//Function Number: 2
func_11661(param_00)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	var_01 = 5;
	var_02 = (0,0,param_00 / var_01);
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self method_80F1(self.origin + var_02);
		wait(0.05);
	}
}

//Function Number: 3
func_11662(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(param_00 == 0 || param_02 <= 0)
	{
		return;
	}

	if(param_01 > 0)
	{
		wait(param_01);
	}

	var_04 = (0,0,param_00 / param_02);
	if(isdefined(param_03) && param_03 < 1)
	{
		self method_82E3("traverseAnim",self.var_126DB,self.var_126DD,1,0.2,param_03);
	}

	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		self method_80F1(self.origin + var_04);
		wait(0.05);
	}

	if(isdefined(param_03) && param_03 < 1)
	{
		self method_82E3("traverseAnim",self.var_126DB,self.var_126DD,1,0.2,1);
	}
}

//Function Number: 4
func_5AC3(param_00)
{
	self endon("killanimscript");
	var_01 = getdvarint("ai_iw7",0) != 0;
	self.var_5270 = "stand";
	scripts\anim\utility::func_12E5F();
	var_02 = self method_8148();
	var_02.var_126D4 = var_02.origin[2];
	if(isdefined(var_02.var_126D5))
	{
		var_02.var_126D4 = var_02.var_126D4 + var_02.var_126D5;
	}

	var_03 = self method_8145();
	self method_8221("face angle",var_02.angles[1]);
	self.var_126E6 = param_00["traverseHeight"];
	self.var_126EB = var_02;
	var_04 = param_00["traverseAnim"];
	var_05 = param_00["traverseToCoverAnim"];
	if(var_01)
	{
		self method_8016("noclip");
	}
	else
	{
		self method_83C4("nogravity");
		self method_83C4("noclip");
	}

	self.var_126EC = self.origin[2];
	if(!animhasnotetrack(var_04,"traverse_align"))
	{
		func_89F5();
	}

	var_06 = 0;
	if(isdefined(var_05) && isdefined(self.var_205) && self.var_205.type == param_00["coverType"] && distancesquared(self.var_205.origin,var_03.origin) < 625)
	{
		if(scripts\common\utility::func_152F(self.var_205.angles[1] - var_03.angles[1]) > 160)
		{
			var_06 = 1;
			var_04 = var_05;
		}
	}

	if(var_06)
	{
		if(isdefined(param_00["traverseToCoverSound"]))
		{
			thread scripts\sp\_utility::func_CE2F(param_00["traverseToCoverSound"]);
		}
	}
	else if(isdefined(param_00["traverseSound"]))
	{
		thread scripts\sp\_utility::func_CE2F(param_00["traverseSound"]);
	}

	var_07 = undefined;
	if(var_01)
	{
		var_07 = lib_0A1E::func_2339();
	}
	else
	{
		var_07 = %body;
	}

	self.var_126DB = var_04;
	self.var_126DD = var_07;
	self method_82E4("traverseAnim",var_04,var_07,1,0.2,1);
	self.var_126E3 = 0;
	self.var_126E2 = param_00["interruptDeathAnim"];
	scripts\anim\shared::func_592B("traverseAnim",::func_89F8);
	if(var_01)
	{
		self method_8016("gravity");
	}
	else
	{
		self method_83C4("gravity");
	}

	if(self.var_EB)
	{
		if(var_01)
		{
			self notify("external_traverse_complete");
		}

		return;
	}

	self.var_1491.var_C043 = 0;
	if(var_06 && isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 256)
	{
		self.var_1491.var_BCC8 = "stop";
		self method_83B9(self.var_205.origin);
	}
	else if(isdefined(param_00["traverseStopsAtEnd"]))
	{
		self.var_1491.var_BCC8 = "stop";
	}
	else
	{
		self.var_1491.var_BCC8 = "run";
		self method_806F(var_04,0.2);
	}

	self.var_126DD = undefined;
	self.var_126DB = undefined;
	self.var_4E2A = undefined;
	self.var_126EB = undefined;
	if(var_01)
	{
		self notify("external_traverse_complete");
	}
}

//Function Number: 5
func_89F8(param_00)
{
	if(param_00 == "traverse_death")
	{
		return func_89F6();
	}

	if(param_00 == "traverse_align")
	{
		return func_89F5();
	}

	if(param_00 == "traverse_drop")
	{
		return func_89F7();
	}
}

//Function Number: 6
func_89F6()
{
	if(isdefined(self.var_126E2))
	{
		var_00 = self.var_126E2[self.var_126E3];
		self.var_4E2A = var_00[randomint(var_00.size)];
		self.var_126E3++;
	}
}

//Function Number: 7
func_89F5()
{
	if(getdvarint("ai_iw7",0) != 0)
	{
		self method_8016("noclip");
	}
	else
	{
		self method_83C4("nogravity");
		self method_83C4("noclip");
	}

	if(isdefined(self.var_126E6) && isdefined(self.var_126EB.var_126D4))
	{
		var_00 = self.var_126EB.var_126D4 - self.var_126EC;
		thread func_11661(var_00 - self.var_126E6);
	}
}

//Function Number: 8
func_89F7()
{
	var_00 = self.origin + (0,0,32);
	var_01 = physicstrace(var_00,self.origin + (0,0,-512));
	var_02 = distance(var_00,var_01);
	var_03 = var_02 - 32 - 0.5;
	var_04 = self method_8102(self.var_126DB);
	var_05 = getmovedelta(self.var_126DB,var_04,1);
	var_06 = getanimlength(self.var_126DB);
	var_07 = 0 - var_05[2];
	var_08 = var_07 - var_03;
	if(var_07 < var_03)
	{
		var_09 = var_07 / var_03;
	}
	else
	{
		var_09 = 1;
	}

	var_0A = var_06 - var_04 / 3;
	var_0B = ceil(var_0A * 20);
	thread func_11662(var_08,0,var_0B,var_09);
	thread func_6CE5(var_01[2]);
}

//Function Number: 9
func_6CE5(param_00)
{
	self endon("killanimscript");
	param_00 = param_00 + 4;
	for(;;)
	{
		if(self.origin[2] < param_00)
		{
			if(getdvarint("ai_iw7",0) != 0)
			{
				self method_8016("gravity");
			}
			else
			{
				self method_83C4("gravity");
			}

			break;
		}

		wait(0.05);
	}
}

//Function Number: 10
func_593C()
{
	self method_8016("zonly_physics");
	self waittill("killanimscript");
}

//Function Number: 11
func_5864(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	var_03 = 0;
	if(param_00 == "traverse_jump_start")
	{
		var_02 = 1;
		var_04 = getnotetracktimes(self.var_126DB,"traverse_align");
		if(var_04.size > 0)
		{
			var_01 = var_04;
		}
		else
		{
			var_01 = getnotetracktimes(self.var_126DB,"traverse_jump_end");
			var_03 = 1;
		}
	}
	else if(param_00 == "gravity on")
	{
		var_02 = 1;
		var_01 = getnotetracktimes(self.var_126DB,"traverse_jump_end");
		var_03 = 1;
	}

	if(var_02)
	{
		var_05 = getnotetracktimes(self.var_126DB,param_00);
		var_06 = var_05[0];
		var_07 = getmovedelta(self.var_126DB,0,var_05[0]);
		var_08 = var_07[2];
		var_07 = getmovedelta(self.var_126DB,0,var_01[0]);
		var_09 = var_07[2];
		var_0A = var_01[0];
		var_0B = getanimlength(self.var_126DB);
		var_0C = int(var_0A - var_06 * var_0B * 30);
		var_0D = max(1,var_0C - 2);
		var_0E = var_09 - var_08;
		if(var_03)
		{
			var_07 = getmovedelta(self.var_126DB,0,1);
			var_0F = var_07[2] - var_09;
			var_10 = self.var_126E4.origin[2] - self.origin[2] - var_0F;
		}
		else
		{
			var_11 = self.var_126EB;
			var_10 = var_11.var_126D5 - self.origin[2] - var_11.origin[2];
		}

		thread func_11662(var_10 - var_0E,0,var_0D);
		return 1;
	}
}

//Function Number: 12
func_586C()
{
	self waittill("killanimscript");
	self.var_126EB = undefined;
	self.var_126E4 = undefined;
}

//Function Number: 13
func_586D(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	thread func_586C();
	var_03 = self method_8148();
	self method_8221("face angle",var_03.angles[1]);
	if(!isdefined(param_02))
	{
		var_04 = var_03.var_126D4 - var_03.origin[2];
		thread func_11661(var_04 - param_01);
	}

	self.var_126DB = level.var_58C7[param_00];
	self.var_126EB = var_03;
	self.var_126E4 = self method_8145();
	self method_806F(%body,0.2);
	self method_82EA("dog_traverse",self.var_126DB,1,0.2,1);
	self.var_BCA6 = "land";
	scripts\anim\notetracks::func_5936("dog_traverse",::func_5864);
	self.var_BCA6 = undefined;
	self.var_126DB = undefined;
}

//Function Number: 14
func_5867(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self method_83C4("noclip");
	thread func_586C();
	var_04 = self method_8148();
	var_05 = self method_8145();
	self method_8221("face angle",var_04.angles[1]);
	if(!isdefined(param_02))
	{
		param_02 = "jump_down_40";
	}

	self.var_126DB = level.var_58C7[param_02];
	self.var_126DD = %body;
	self.var_126EB = var_04;
	self.var_126E4 = var_05;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		var_06 = var_04.origin[2] - var_05.origin[2];
		thread func_11662(40 - var_06,0.1,param_00,param_01);
	}

	self.var_BCA6 = "land";
	self method_806F(%body,0.2);
	self method_82EA("traverseAnim",self.var_126DB,1,0.2,1);
	if(!param_03)
	{
		scripts\anim\shared::func_592B("traverseAnim");
	}
	else
	{
		scripts\anim\notetracks::func_5936("traverseAnim",::func_5864);
	}

	self.var_BCA6 = undefined;
	self method_83C4("gravity");
	self.var_126DD = undefined;
	self.var_126DB = undefined;
}

//Function Number: 15
func_5868(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self method_83C4("noclip");
	thread func_586C();
	var_04 = self method_8148();
	self method_8221("face angle",var_04.angles[1]);
	if(!isdefined(param_02))
	{
		param_02 = "jump_up_40";
	}

	self.var_126DB = level.var_58C7[param_02];
	self.var_126DD = %body;
	self.var_126EB = var_04;
	self.var_126E4 = self method_8145();
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!param_03)
	{
		thread func_11662(param_00 - 40,0.2,param_01);
	}

	self.var_BCA6 = "land";
	self method_806F(%body,0.2);
	self method_82EA("traverseAnim",self.var_126DB,1,0.2,1);
	if(!param_03)
	{
		scripts\anim\shared::func_592B("traverseAnim");
	}
	else
	{
		scripts\anim\notetracks::func_5936("traverseAnim",::func_5864);
	}

	self.var_BCA6 = undefined;
	self method_83C4("gravity");
	self.var_126DB = undefined;
	self.var_126DD = undefined;
}

//Function Number: 16
func_5869(param_00,param_01)
{
	self endon("killanimscript");
	self method_83C4("nogravity");
	self method_83C4("noclip");
	thread func_586C();
	var_02 = self method_8148();
	self method_8221("face angle",var_02.angles[1]);
	if(!isdefined(var_02.var_126D4))
	{
		var_02.var_126D4 = var_02.origin[2];
	}

	var_03 = var_02.var_126D4 - var_02.origin[2];
	thread func_11661(var_03 - param_01);
	self.var_BCA6 = "land";
	self method_806F(%body,0.2);
	self method_82E4("dog_traverse",level.var_58C7[param_00],1,0.2,1);
	scripts\anim\shared::func_592B("dog_traverse");
	self.var_BCA6 = undefined;
}

//Function Number: 17
func_F163()
{
	self waittill("killanimscript");
}

//Function Number: 18
func_F9C6()
{
	foreach(var_01 in function_00B4("traverse","targetname"))
	{
		var_01 thread func_126ED();
	}
}

//Function Number: 19
func_D999(param_00)
{
	self.var_5AE2 = param_00.origin;
	self.var_10DCE = self.angles;
	if(function_02A6(param_00))
	{
		param_00 delete();
		return;
	}

	scripts\sp\_utility::func_51D4(param_00);
}

//Function Number: 20
func_D9BD(param_00)
{
	var_01 = getent(param_00.target,"targetname");
	if(!isdefined(var_01))
	{
		var_01 = scripts\common\utility::getstruct(param_00.target,"targetname");
	}

	self.var_138A6 = spawnstruct();
	var_03 = param_00;
	var_04 = 0;
	self.var_138A6.var_10DCE = self.angles;
	var_06 = undefined;
	while(isdefined(var_03))
	{
		self.var_138A6.var_C050[var_04] = var_03.origin - self.origin;
		var_04++;
		var_07 = scripts\common\utility::getstruct(var_03.target,"targetname");
		scripts\sp\_utility::func_51D4(var_03);
		var_03 = var_07;
		self.var_138A6.var_C050[var_04] = var_03.origin - self.origin;
		var_04++;
		if(isdefined(var_03.target))
		{
			var_0A = scripts\common\utility::getstruct(var_03.target,"targetname");
		}
		else
		{
			var_0A = undefined;
		}

		scripts\sp\_utility::func_51D4(var_03);
		var_03 = var_0A;
		if(isdefined(var_03) && isdefined(var_03.var_EF1D))
		{
			if(var_03.var_EF1D == "wallrun_mantle")
			{
				self.var_138A6.var_B313 = var_03.origin - self.origin;
				if(isdefined(var_03.angles))
				{
					self.var_138A6.var_B312 = var_03.angles;
				}

				scripts\sp\_utility::func_51D4(var_03);
				break;
			}
			else if(var_03.var_EF1D == "wallrun_vault")
			{
				self.var_138A6.var_B313 = var_03.origin - self.origin;
				self.var_138A6.var_331A = 1;
				scripts\sp\_utility::func_51D4(var_03);
				break;
			}
		}
	}
}

//Function Number: 21
func_126ED()
{
	var_00 = getent(self.target,"targetname");
	if(!isdefined(var_00))
	{
		var_00 = scripts\common\utility::getstruct(self.target,"targetname");
	}

	switch(self.var_48)
	{
		case "wall_run":
			func_D9BD(var_00);
			break;

		case "double_jump_mantle":
		case "double_jump_vault":
			func_D999(var_00);
			break;

		case "double_jump":
			self.var_10DCE = self.angles;
			if(!isdefined(var_00))
			{
				return;
			}
	
			self.var_A4C9 = var_00.origin - self.origin;
			self.var_A4C8 = var_00.origin;
			break;

		case "rail_hop_double_jump_down":
			self.var_10DCE = self.angles;
			break;

		default:
			break;
	}

	self.var_126D4 = var_00.origin[2];
	self.var_126D5 = var_00.origin[2] - self.origin[2];
	if(function_02A6(var_00))
	{
		var_00 delete();
		return;
	}

	scripts\sp\_utility::func_51D4(var_00);
}