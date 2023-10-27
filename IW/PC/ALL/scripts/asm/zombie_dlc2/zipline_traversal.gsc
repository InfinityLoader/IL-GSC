/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\zombie_dlc2\zipline_traversal.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 512 ms
 * Timestamp: 10/27/2023 12:02:41 AM
*******************************************************************/

//Function Number: 1
playtraversezipline(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	scripts\mp\agents\_scriptedagents::func_F85E(1,"DoTraverse");
	self.do_immediate_ragdoll_save = self.do_immediate_ragdoll;
	self.do_immediate_ragdoll = 1;
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	playtraverseziplineinternal(param_00,param_01,var_04);
}

//Function Number: 2
get_closest_zipline_traversal(param_00)
{
	var_01 = 16384;
	foreach(var_03 in level.zipline_traversals)
	{
		if(distance2dsquared(var_03.traversal_start,param_00) < var_01)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 3
playtraverseziplineinternal(param_00,param_01,param_02)
{
	var_03 = param_02;
	var_04 = self method_80FD(param_01,var_03);
	var_05 = getnotetracktimes(var_04,"flex_height_up_end");
	var_06 = get_closest_zipline_traversal(self.origin);
	self.zipline = var_06;
	var_07 = var_06.var_13EFC.origin + (0,0,-84);
	var_08 = lib_0A1A::func_2341(param_00,param_01);
	var_09 = vectortoangles(var_06.var_13EFB.origin - var_06.var_13EFC.origin);
	var_09 = (0,var_09[1],0);
	self method_8289("face angle abs",var_09);
	self method_828A("noclip");
	self method_8281("anim deltas");
	scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_03,param_01,"flex_height_up_start",undefined);
	scripts\mp\agents\_scriptedagents::func_5AC2(param_01,var_03,param_01,var_04,"flex_height_up_start","flex_height_up_end",var_07,var_05[0]);
	attach_to_zipline_and_go();
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_03,1,param_01,"end",undefined);
	self.angles = var_09;
}

//Function Number: 4
attach_to_zipline_and_go()
{
	self.zipline_ent = spawn("script_model",self.origin);
	self.zipline_ent setmodel("tag_origin");
	self.zipline_ent.angles = self.angles;
	self linkto(self.zipline_ent,"tag_origin");
	var_00 = self.zipline.var_13EFC.origin + (0,0,-84);
	var_01 = self.zipline.var_13EFB.origin + (0,0,-84);
	var_02 = distance(var_00,var_01);
	var_03 = 500;
	var_04 = int(var_02 / var_03);
	self.zipline_ent moveto(var_01,var_04,2);
	self.zipline.var_6393 = gettime() + int(var_04 * 1000);
}

//Function Number: 5
playtraverseziplineloop(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	self method_82AF(param_01,var_04,1);
	var_06 = self.zipline.var_6393 - gettime();
	if(var_06 > 0)
	{
		wait(var_06 / 1000);
	}

	lib_0A1A::func_2330(param_01,"loop_finished");
}

//Function Number: 6
playtraverseziplinedrop(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = self method_80FD(param_01,var_04);
	var_06 = getnotetracktimes(var_05,"flex_height_down_end");
	var_07 = self.zipline.traversal_end;
	self method_8282(1,1);
	scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_04,param_01,"flex_height_down_start",undefined);
	scripts\mp\agents\_scriptedagents::func_5AC2(param_01,var_04,param_01,var_05,"flex_height_down_start","flex_height_down_end",var_07,var_06[0],undefined);
	scripts\mp\agents\_scriptedagents::func_CED2(param_01,var_04,1,param_01,"end",undefined);
	thread lib_0C75::func_11701(param_00,param_01);
}

//Function Number: 7
terminateziplineintro(param_00,param_01,param_02)
{
	if(!isalive(self) && isdefined(self.zipline_ent))
	{
		self unlink();
		self.zipline_ent delete();
	}
}

//Function Number: 8
terminateziplineloop(param_00,param_01,param_02)
{
	if(isdefined(self.zipline_ent))
	{
		self unlink();
		self.zipline_ent delete();
	}
}

//Function Number: 9
terminatezipline(param_00,param_01,param_02)
{
	self.do_immediate_ragdoll = self.do_immedate_ragdoll_save;
	self.do_immedate_ragdoll_save = undefined;
	self method_8282(1,1);
	scripts\mp\agents\_scriptedagents::func_F85E(0,"Traverse end_script");
	self.var_8C35 = 1;
	self.var_126CB = undefined;
	self.zipline = undefined;
}

//Function Number: 10
chooseanimzipline(param_00,param_01,param_02)
{
	return lib_0F3C::func_3EF4(param_00,param_01,param_02);
}