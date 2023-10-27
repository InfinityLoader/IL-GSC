/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_props.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 216 ms
 * Timestamp: 10/27/2023 2:20:15 AM
*******************************************************************/

//Function Number: 1
prop_notetrack_exist(param_00,param_01)
{
	if(!isdefined(level.prop_notetracks))
	{
		level.prop_notetracks = [];
	}

	if(!isdefined(level.prop_notetracks[param_00]))
	{
		level.prop_notetracks[param_00] = [];
	}

	if(isdefined(level.prop_notetracks[param_00][param_01]))
	{
		return 1;
	}

	level.prop_notetracks[param_00][param_01] = 1;
	return 0;
}

//Function Number: 2
add_smoking_notetracks(param_00)
{
	if(prop_notetrack_exist(param_00,"add_smoking_notetracks"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach cig",::attach_cig);
	maps\_anim::addnotetrack_customfunction(param_00,"detach cig",::detach_cig);
	maps\_anim::addnotetrack_customfunction(param_00,"puff",::smoke_puff);
	maps\_anim::addnotetrack_customfunction(param_00,"exhale",::smoke_exhale);
	level._effect["cigar_glow"] = loadfx("fire/cigar_glow_far");
	level._effect["cigar_glow_puff"] = loadfx("fire/cigar_glow_puff");
	level._effect["cigar_smoke_puff"] = loadfx("smoke/cigarsmoke_puff_far");
	level._effect["cigar_exhale"] = loadfx("smoke/cigarsmoke_exhale_far");
	level.scr_model["cigar"] = "prop_price_cigar";
}

//Function Number: 3
detach_idle_clip(param_00)
{
	if(isdefined(param_00.clip))
	{
		param_00.clip delete();
	}
}

//Function Number: 4
add_sit_load_ak_notetracks(param_00)
{
	if(prop_notetrack_exist(param_00,"add_cellphone_notetracks"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach clip left",::attach_clip);
	maps\_anim::addnotetrack_customfunction(param_00,"detach clip left",::detach_idle_clip);
	level.scr_model["clip"] = "weapon_ak47_clip";
}

//Function Number: 5
attach_clip(param_00)
{
	param_00 notify("new_prop_rotation");
	var_01 = spawn("script_model",(0,0,0));
	var_01 linkto(param_00,"tag_inhand",(0,0,0),(0,0,0));
	var_01 setmodel(maps\_utility::getmodel("clip"));
	param_00.clip = var_01;
	thread prop_delete(var_01,param_00);
}

//Function Number: 6
add_cellphone_notetracks(param_00)
{
	if(prop_notetrack_exist(param_00,"add_cellphone_notetracks"))
	{
		return;
	}

	maps\_anim::addnotetrack_customfunction(param_00,"attach phone",::attach_phone);
	maps\_anim::addnotetrack_customfunction(param_00,"detach phone",::detach_phone);
	level.scr_model["cellphone"] = "com_cellphone_off";
}

//Function Number: 7
attach_phone(param_00)
{
	param_00 notify("new_phone_rotation");
	var_01 = spawn("script_model",(0,0,0));
	var_01 linkto(param_00,"tag_inhand",(0,0,0),(0,0,0));
	var_01 setmodel(maps\_utility::getmodel("cellphone"));
	param_00.phone = var_01;
	thread prop_delete(var_01,param_00);
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
	var_01 setmodel(maps\_utility::getmodel("cigar"));
	playfxontag(common_scripts\utility::getfx("cigar_glow"),var_01,"tag_cigarglow");
	param_00.cigar = var_01;
	thread prop_delete_cig(var_01,param_00);
}

//Function Number: 10
detach_cig(param_00)
{
	if(isdefined(param_00.cigar))
	{
		param_00.cigar thread prop_cig_throw();
	}
}

//Function Number: 11
prop_delete(param_00,param_01)
{
	param_01 notify("new_prop_rotation" + param_00.model);
	param_01 endon("new_prop_rotation" + param_00.model);
	param_00 endon("death");
	param_01 maps\_utility::add_endon("new_prop_rotation" + param_00.model);
	param_00 maps\_utility::add_endon("death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"stop_loop");
	param_01 maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::do_wait_any();
	param_00 delete();
}

//Function Number: 12
prop_delete_cig(param_00,param_01)
{
	param_01 notify("new_prop_rotation" + param_00.model);
	param_01 endon("new_prop_rotation" + param_00.model);
	param_00 endon("death");
	param_01 maps\_utility::add_endon("new_prop_rotation" + param_00.model);
	param_00 maps\_utility::add_endon("death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"stop_loop");
	param_01 maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::do_wait_any();
	param_00 thread prop_cig_throw();
}

//Function Number: 13
prop_cig_throw()
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.cig_throwing) && self.cig_throwing)
	{
		return;
	}

	self.cig_throwing = 1;
	stopfxontag(common_scripts\utility::getfx("cigar_glow"),self,"tag_cigarglow");
	var_00 = 3;
	var_01 = anglestoforward(self.angles);
	self unlink();
	self movegravity(var_01 * 100,var_00);
	self rotatevelocity((400,0,0),var_00,0,var_00);
	wait var_00;
	self delete();
}

//Function Number: 14
smoke_puff(param_00)
{
	if(!isdefined(param_00.cigar))
	{
		return;
	}

	param_00 endon("death");
	param_00.cigar endon("death");
	playfxontag(common_scripts\utility::getfx("cigar_glow_puff"),param_00.cigar,"tag_cigarglow");
	wait 1;
	playfxontag(common_scripts\utility::getfx("cigar_smoke_puff"),param_00,"tag_eye");
}

//Function Number: 15
smoke_exhale(param_00)
{
	if(!isdefined(param_00.cigar))
	{
		return;
	}

	playfxontag(common_scripts\utility::getfx("cigar_exhale"),param_00,"tag_eye");
}

//Function Number: 16
ghillie_leaves()
{
	var_00 = [];
	self endon("death",var_7B[var_7B.size],"J_Wrist_RI",var_7B[var_7B.size],"J_Elbow_LE",var_7B[var_7B.size],"J_Hip_RI",var_7B[var_7B.size],"J_SpineLower",var_7B[var_7B.size],"J_HipTwist_LE",var_7B[var_7B.size],"J_HipTwist_RI",var_7B[var_7B.size],"J_Knee_LE",var_7B[var_7B.size],"J_Knee_RI",var_7B[var_7B.size],"J_SpineUpper",var_7B[var_7B.size],"J_Ankle_LE",var_7B[var_7B.size],"J_Ankle_RI",var_7B[var_7B.size],"J_Knee_Bulge_LE",var_7B[var_7B.size],"J_Ball_LE",var_7B[var_7B.size],"J_Clavicle_RI",var_7B[var_7B.size],"J_Neck",var_7B[var_7B.size],"J_ShoulderRaise_LE",var_7B[var_7B.size],"J_Head",var_7B[var_7B.size],"J_Shoulder_RI",var_7B[var_7B.size],"J_Brow_LE",var_7B[var_7B.size],"J_Cheek_RI",var_7B[var_7B.size],"J_CoatFront_RI",var_7B[var_7B.size],"J_CoatRear_LE",var_7B[var_7B.size],"J_CoatRear_RI",var_7B[var_7B.size],"J_Hip_LE",var_7B[var_7B.size],"J_CoatFront_LE",var_7B[var_00.size],"J_MainRoot");
	for(;;)
	{
		while(self.movemode != "run")
		{
			wait 0.2;
			continue;
		}

		playfxontag(level._effect["ghillie_leaves"],self,common_scripts\utility::random(var_7B));
		wait randomfloatrange(0.1,2.5);
	}
}

//Function Number: 17
attach_cig_self()
{
	attach_cig(self);
}