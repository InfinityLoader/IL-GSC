/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_props.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 258 ms
 * Timestamp: 10/27/2023 1:25:04 AM
*******************************************************************/

//Function Number: 1
func_6217(param_00,param_01)
{
	if(!isdefined(level.var_6218))
	{
		level.var_6218 = [];
	}

	if(!isdefined(level.var_6218[param_00]))
	{
		level.var_6218[param_00] = [];
	}

	if(isdefined(level.var_6218[param_00][param_01]))
	{
		return 1;
	}

	level.var_6218[param_00][param_01] = 1;
	return 0;
}

//Function Number: 2
add_smoking_notetracks(param_00)
{
	if(func_6217(param_00,"add_smoking_notetracks"))
	{
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach cig",::attach_cig);
	maps\_anim::addnotetrack_customfunction(param_00,"detach cig",::detach_cig);
	maps\_anim::addnotetrack_customfunction(param_00,"puff",::func_7638);
	maps\_anim::addnotetrack_customfunction(param_00,"exhale",::func_7634);
	level._effect["cigar_glow"] = loadfx("fx/fire/cigar_glow_far");
	level._effect["cigar_glow_puff"] = loadfx("fx/fire/cigar_glow_puff");
	level._effect["cigar_smoke_puff"] = loadfx("fx/smoke/cigarsmoke_puff_far");
	level._effect["cigar_exhale"] = loadfx("fx/smoke/cigarsmoke_exhale_far");
	level.var_6AF3["cigar"] = "prop_price_cigar";
}

//Function Number: 3
detach_idle_clip(param_00)
{
	if(isdefined(param_00.var_1D65))
	{
		param_00.var_1D65 delete();
	}
}

//Function Number: 4
add_sit_load_ak_notetracks(param_00)
{
	if(func_6217(param_00,"add_cellphone_notetracks"))
	{
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach clip left",::func_0FAF);
	maps\_anim::addnotetrack_customfunction(param_00,"detach clip left",::detach_idle_clip);
	level.var_6AF3["clip"] = "weapon_ak47_clip";
}

//Function Number: 5
func_0FAF(param_00)
{
	param_00 notify("new_prop_rotation");
	var_01 = spawn("script_model",(0,0,0));
	var_01 linkto(param_00,"tag_inhand",(0,0,0),(0,0,0));
	var_01 setmodel(maps\_utility::func_3B30("clip"));
	param_00.var_1D65 = var_01;
	thread func_6212(var_01,param_00);
}

//Function Number: 6
add_cellphone_notetracks(param_00)
{
	if(func_6217(param_00,"add_cellphone_notetracks"))
	{
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach phone",::attach_phone);
	maps\_anim::addnotetrack_customfunction(param_00,"detach phone",::detach_phone);
	level.var_6AF3["cellphone"] = "com_cellphone_off";
}

//Function Number: 7
attach_phone(param_00)
{
	param_00 notify("new_phone_rotation");
	var_01 = spawn("script_model",(0,0,0));
	var_01 linkto(param_00,"tag_inhand",(0,0,0),(0,0,0));
	var_01 setmodel(maps\_utility::func_3B30("cellphone"));
	param_00.phone = var_01;
	thread func_6212(var_01,param_00);
}

//Function Number: 8
detach_phone(param_00)
{
	if(isdefined(param_00.phone))
	{
		param_00.phone delete();
	}
}

//Function Number: 9
attach_cig(param_00)
{
	param_00 notify("new_cigar_rotation");
	var_01 = spawn("script_model",(0,0,0));
	var_01 linkto(param_00,"tag_inhand",(0,0,0),(0,0,0));
	var_01 setmodel(maps\_utility::func_3B30("cigar"));
	playfxontag(common_scripts\utility::func_3AB9("cigar_glow"),var_01,"tag_cigarglow");
	param_00.var_1C71 = var_01;
	thread func_6213(var_01,param_00);
}

//Function Number: 10
detach_cig(param_00)
{
	if(isdefined(param_00.var_1C71))
	{
		param_00.var_1C71 thread func_6211();
	}
}

//Function Number: 11
func_6212(param_00,param_01)
{
	param_01 notify("new_prop_rotation" + param_00.model);
	param_01 endon("new_prop_rotation" + param_00.model);
	param_00 endon("death");
	param_01 maps\_utility::add_endon("new_prop_rotation" + param_00.model);
	param_00 maps\_utility::add_endon("death");
	maps\_utility::add_wait(::maps\_utility::func_8B71,"stop_loop");
	param_01 maps\_utility::add_wait(::maps\_utility::func_8B71,"death");
	maps\_utility::func_2852();
	param_00 delete();
}

//Function Number: 12
func_6213(param_00,param_01)
{
	param_01 notify("new_prop_rotation" + param_00.model);
	param_01 endon("new_prop_rotation" + param_00.model);
	param_00 endon("death");
	param_01 maps\_utility::add_endon("new_prop_rotation" + param_00.model);
	param_00 maps\_utility::add_endon("death");
	maps\_utility::add_wait(::maps\_utility::func_8B71,"stop_loop");
	param_01 maps\_utility::add_wait(::maps\_utility::func_8B71,"death");
	maps\_utility::func_2852();
	param_00 thread func_6211();
}

//Function Number: 13
func_6211()
{
	self endon("death");
	if(!isdefined(self))
	{
	}

	if(isdefined(self.cig_throwing) && self.cig_throwing)
	{
	}

	self.cig_throwing = 1;
	stopfxontag(common_scripts\utility::func_3AB9("cigar_glow"),self,"tag_cigarglow");
	var_00 = 3;
	var_01 = anglestoforward(self.angles);
	self unlink();
	self movegravity(var_01 * 100,var_00);
	self rotatevelocity((400,0,0),var_00,0,var_00);
	wait(var_00);
	self delete();
}

//Function Number: 14
func_7638(param_00)
{
	if(!isdefined(param_00.var_1C71))
	{
	}

	param_00 endon("death");
	param_00.var_1C71 endon("death");
	playfxontag(common_scripts\utility::func_3AB9("cigar_glow_puff"),param_00.var_1C71,"tag_cigarglow");
	wait(1);
	playfxontag(common_scripts\utility::func_3AB9("cigar_smoke_puff"),param_00,"tag_eye");
}

//Function Number: 15
func_7634(param_00)
{
	if(!isdefined(param_00.var_1C71))
	{
	}

	playfxontag(common_scripts\utility::func_3AB9("cigar_exhale"),param_00,"tag_eye");
}

//Function Number: 16
func_3C93()
{
	var_00 = [];
	var_00[var_00.size] = "J_MainRoot";
	var_00[var_00.size] = "J_CoatFront_LE";
	var_00[var_00.size] = "J_Hip_LE";
	var_00[var_00.size] = "J_CoatRear_RI";
	var_00[var_00.size] = "J_CoatRear_LE";
	var_00[var_00.size] = "J_CoatFront_RI";
	var_00[var_00.size] = "J_Cheek_RI";
	var_00[var_00.size] = "J_Brow_LE";
	var_00[var_00.size] = "J_Shoulder_RI";
	var_00[var_00.size] = "J_Head";
	var_00[var_00.size] = "J_ShoulderRaise_LE";
	var_00[var_00.size] = "J_Neck";
	var_00[var_00.size] = "J_Clavicle_RI";
	var_00[var_00.size] = "J_Ball_LE";
	var_00[var_00.size] = "J_Knee_Bulge_LE";
	var_00[var_00.size] = "J_Ankle_RI";
	var_00[var_00.size] = "J_Ankle_LE";
	var_00[var_00.size] = "J_SpineUpper";
	var_00[var_00.size] = "J_Knee_RI";
	var_00[var_00.size] = "J_Knee_LE";
	var_00[var_00.size] = "J_HipTwist_RI";
	var_00[var_00.size] = "J_HipTwist_LE";
	var_00[var_00.size] = "J_SpineLower";
	var_00[var_00.size] = "J_Hip_RI";
	var_00[var_00.size] = "J_Elbow_LE";
	var_00[var_00.size] = "J_Wrist_RI";
	self endon("death");
	for(;;)
	{
		while(self.movemode != "run")
		{
			wait(0.2);
			continue;
		}

		playfxontag(level._effect["ghillie_leaves"],self,common_scripts\utility::func_6306(var_00));
		wait(randomfloatrange(0.1,2.5));
	}
}

//Function Number: 17
attach_cig_self()
{
	attach_cig(self);
}