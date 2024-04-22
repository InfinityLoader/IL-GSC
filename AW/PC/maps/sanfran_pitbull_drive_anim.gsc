/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_pitbull_drive_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 267 ms
 * Timestamp: 4/22/2024 2:35:55 AM
*******************************************************************/

//Function Number: 1
handle_player_pitbull_driving()
{
	self endon("death");
	self endon("dismount_player_pitbull");
	if(!maps\_utility::ent_flag("pitbull_scripted_anim"))
	{
		childthread link_player_and_start_driving_anims();
	}

	for(;;)
	{
		if(maps\_utility::ent_flag("pitbull_scripted_anim"))
		{
			maps\_utility::ent_flag_waitopen("pitbull_scripted_anim");
			self.fake_vehicle_model maps\_utility::anim_stopanimscripted();
			self.player_rig maps\_utility::anim_stopanimscripted();
			childthread link_player_and_start_driving_anims();
			wait(0.05);
			continue;
		}

		play_pitbull_anim();
		wait(0.05);
	}
}

//Function Number: 2
link_player_and_start_driving_anims()
{
	link_player_and_play_idle();
	childthread adjust_pitbull_add_idle();
	childthread play_pitbull_camera_speed_anim();
	childthread play_pitbull_gear_shift_anim();
}

//Function Number: 3
clear_anims()
{
	self.fake_vehicle_model clearanim(get_pitbull_anim_node("root"),0);
	self.player_rig clearanim(get_player_anim_node("root"),0);
	self.drive_anim_add_idle = undefined;
}

//Function Number: 4
link_player_and_play_idle()
{
	var_00 = self.fake_vehicle_model;
	var_01 = self.player_rig;
	self.drive_anim_name = "cockpit_static_idle";
	var_00 setanimknoball(var_00 maps\_utility::getanim(self.drive_anim_name),get_pitbull_anim_node("root"),1,0,1);
	var_01 dontinterpolate();
	var_01 unlink();
	var_02 = var_00 gettagorigin("tag_body");
	var_03 = var_00 gettagangles("tag_body");
	var_04 = getstartorigin(var_02,var_03,var_01 maps\_utility::getanim(self.drive_anim_name));
	var_05 = getstartangles(var_02,var_03,var_01 maps\_utility::getanim(self.drive_anim_name));
	var_01.origin = var_04;
	var_01.angles = var_05;
	var_01 linkto(var_00,"tag_player");
	var_01 setanimknoball(var_01 maps\_utility::getanim(self.drive_anim_name),get_player_anim_node("root"),1,0,1);
	self.drive_yaw_sign = 1;
	self.drive_anim_centering = 0;
	self.drive_cam_anim_name = "cockpit_static_idle_cam";
	self.player_rig setanimknob(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,0,1);
	self.drive_cam_yaw_sign = 1;
	self.drive_cam_centering = 0;
	self.drive_anim_add_idle = undefined;
}

//Function Number: 5
play_pitbull_anim()
{
	self endon("pitbull_scripted_anim");
	play_pitbull_steer_anim();
	if(1)
	{
		play_pitbull_camera_anim();
		return;
	}

	self.player_rig setanimknob(self.player_rig maps\_utility::getanim("cockpit_static_idle_cam"),1,0,1);
}

//Function Number: 6
play_pitbull_steer_anim()
{
	var_00 = 56;
	var_01 = 1 / var_00;
	var_02 = self.fake_vehicle_model;
	var_03 = self.player_rig;
	var_04 = 0;
	if(self.drive_anim_name != "cockpit_static_idle")
	{
		var_04 = var_03 getanimtime(var_03 maps\_utility::getanim(self.drive_anim_name));
		if(self.drive_anim_centering)
		{
			var_04 = 1 - var_04;
		}

		var_04 = var_04 * self.drive_yaw_sign;
	}

	var_05 = self vehicle_getsteering() * 1;
	var_05 = clamp(var_05,-1,1);
	play_pitbull_add_idle(var_05,var_01);
	if(abs(var_05) < var_01 && abs(var_04) < var_01)
	{
		var_06 = 0.2;
		if(self.drive_anim_name != "cockpit_static_idle")
		{
			var_06 = 0;
			var_02 setanim(var_02 maps\_utility::getanim(self.drive_anim_name),0,0,0);
			var_03 setanim(var_03 maps\_utility::getanim(self.drive_anim_name),0,0,0);
		}

		self.drive_anim_name = "cockpit_static_idle";
		set_pitbull_anim(::setanimknob,self.drive_anim_name,1,var_06,1);
		self.drive_yaw_sign = 1;
		self.drive_anim_centering = 0;
		return;
	}

	var_07 = 0;
	var_08 = 1;
	var_09 = var_05 - var_04;
	if((var_05 > 0 && var_04 < 0) || var_05 < 0 && var_04 > 0)
	{
		var_08 = abs(var_05) * var_00 * 0.5;
		var_07 = 1;
	}
	else
	{
		var_08 = abs(var_09) * var_00 * 0.5;
	}

	if(var_08 == 0)
	{
		var_02 setanim(var_02 maps\_utility::getanim(self.drive_anim_name),1,0,var_08);
		var_03 setanim(var_03 maps\_utility::getanim(self.drive_anim_name),1,0,var_08);
		return;
	}

	if((var_05 <= 0 && var_09 > 0) || var_05 >= 0 && var_09 < 0)
	{
		var_0A = 1;
	}
	else
	{
		var_0A = 0;
	}

	var_0B = undefined;
	var_0C = 1;
	if(var_09 < 0)
	{
		if(var_0A)
		{
			var_0B = "left2center";
			var_0C = 1;
		}
		else
		{
			var_0B = "center2right";
			var_0C = -1;
		}
	}
	else if(var_0A)
	{
		var_0B = "right2center";
		var_0C = -1;
	}
	else
	{
		var_0B = "center2left";
		var_0C = 1;
	}

	if(self.drive_anim_name != var_0B)
	{
		if(self.drive_anim_name == "cockpit_static_idle")
		{
			self.drive_anim_name = var_0B;
			self.drive_yaw_sign = var_0C;
			self.drive_anim_centering = var_0A;
			set_pitbull_anim(::setanimknobrestart,self.drive_anim_name,1,0,1);
			return;
		}

		var_0D = var_02 getanimtime(var_02 maps\_utility::getanim(self.drive_anim_name));
		var_0E = var_03 getanimtime(var_03 maps\_utility::getanim(self.drive_anim_name));
		self.drive_anim_name = var_0B;
		self.drive_yaw_sign = var_0C;
		set_pitbull_anim(::setanimknob,self.drive_anim_name,1,0.2,var_08);
		if(!var_07 && self.drive_anim_centering != var_0A)
		{
			self.drive_anim_jump_to_time = 1;
			var_0D = 1 - var_0D;
			var_0E = 1 - var_0E;
			var_0D = clamp(var_0D,0,1);
			var_0E = clamp(var_0E,0,1);
			var_02 setanimtime(var_02 maps\_utility::getanim(self.drive_anim_name),var_0D);
			var_03 setanimtime(var_03 maps\_utility::getanim(self.drive_anim_name),var_0E);
		}

		self.drive_anim_centering = var_0A;
		return;
	}

	self.fake_vehicle_model setanimrate(self.fake_vehicle_model maps\_utility::getanim(self.drive_anim_name),var_0A);
	self.player_rig setanimrate(self.player_rig maps\_utility::getanim(self.drive_anim_name),var_0A);
}

//Function Number: 7
set_pitbull_anim(param_00,param_01,param_02,param_03,param_04)
{
	self.fake_vehicle_model [[ param_00 ]](self.fake_vehicle_model maps\_utility::getanim(param_01),param_02,param_03,param_04);
	self.player_rig [[ param_00 ]](self.player_rig maps\_utility::getanim(param_01),param_02,param_03,param_04);
}

//Function Number: 8
set_pitbull_anim_node(param_00,param_01,param_02,param_03,param_04)
{
	self.fake_vehicle_model [[ param_00 ]](self.fake_vehicle_model get_pitbull_anim_node(param_01),param_02,param_03,param_04);
	self.player_rig [[ param_00 ]](self.player_rig get_player_anim_node(param_01),param_02,param_03,param_04);
}

//Function Number: 9
play_pitbull_speed_anim()
{
	var_00 = self vehicle_getspeed();
	if(!isdefined(self.drive_speed))
	{
		self.drive_speed = var_00;
		return;
	}

	var_01 = var_00 - self.drive_speed;
	if(var_01 > 0)
	{
		self.fake_vehicle_model setanimknob(self.fake_vehicle_model maps\_utility::getanim("accelerate"),1,0,1);
		self.player_rig setanimknob(self.player_rig maps\_utility::getanim("accelerate"),1,0,1);
	}
	else if(var_01 < 0)
	{
		self.fake_vehicle_model setanimknob(self.fake_vehicle_model maps\_utility::getanim("decelerate"),1,0,1);
		self.player_rig setanimknob(self.player_rig maps\_utility::getanim("decelerate"),1,0,1);
	}
	else
	{
		self.fake_vehicle_model clearanim(get_pitbull_anim_node("speed_anims"),0.2);
		self.player_rig clearanim(get_player_anim_node("speed_anims"),0.2);
	}

	self.drive_speed = var_00;
}

//Function Number: 10
play_pitbull_camera_anim()
{
	var_00 = 56;
	var_01 = 1 / var_00;
	var_02 = self.player_rig;
	var_03 = 0;
	if(self.drive_cam_anim_name != "cockpit_static_idle_cam")
	{
		var_03 = var_02 getanimtime(var_02 maps\_utility::getanim(self.drive_cam_anim_name));
		if(self.drive_cam_centering)
		{
			var_03 = 1 - var_03;
		}

		var_03 = var_03 * self.drive_cam_yaw_sign;
	}

	var_04 = self vehicle_getsteering();
	var_04 = clamp(var_04,-1,1);
	if((var_04 <= 0 && var_04 > var_03) || var_04 >= 0 && var_04 < var_03)
	{
		var_05 = 1;
	}
	else
	{
		var_05 = 0;
	}

	if(abs(var_04) < var_01 && abs(var_03) < var_01)
	{
		var_06 = 0;
		if(self.drive_cam_anim_name != "cockpit_static_idle_cam")
		{
			var_06 = 0.2;
		}

		self.drive_cam_anim_name = "cockpit_static_idle_cam";
		self.player_rig setanimknob(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,var_06,1);
		self.drive_cam_yaw_sign = 1;
		self.drive_cam_centering = 0;
		return;
	}

	var_07 = 0;
	var_08 = 1;
	var_09 = 0.1;
	var_0A = 0.4;
	if(!isdefined(self.drive_cam_vel))
	{
		self.drive_cam_vel = 0;
	}

	var_0B = var_09;
	if(var_05)
	{
		var_0B = var_0A;
	}

	var_0C = var_04 - var_03;
	if(var_0C < 0)
	{
		self.drive_cam_vel = self.drive_cam_vel - var_0B * 0.05;
		self.drive_cam_vel = clamp(self.drive_cam_vel,var_0C,0);
	}
	else if(var_0C > 0)
	{
		self.drive_cam_vel = self.drive_cam_vel + var_0B * 0.05;
		self.drive_cam_vel = clamp(self.drive_cam_vel,0,var_0C);
	}

	var_04 = var_03 + self.drive_cam_vel;
	var_0D = self.drive_cam_vel;
	if((var_04 <= 0 && var_04 > var_03) || var_04 >= 0 && var_04 < var_03)
	{
		var_05 = 1;
	}
	else
	{
		var_05 = 0;
	}

	if((var_04 > 0 && var_03 < 0) || var_04 < 0 && var_03 > 0)
	{
		var_08 = abs(var_04) * var_00 * 0.5;
		var_07 = 1;
	}
	else
	{
		var_08 = abs(var_0D) * var_00 * 0.5;
	}

	if(var_08 == 0)
	{
		self.player_rig setanim(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,0,var_08);
		return;
	}

	var_0E = undefined;
	var_0F = 1;
	if(var_0D < 0)
	{
		if(var_05)
		{
			var_0E = "left2center_cam";
			var_0F = 1;
		}
		else
		{
			var_0E = "center2right_cam";
			var_0F = -1;
		}
	}
	else if(var_05)
	{
		var_0E = "right2center_cam";
		var_0F = -1;
	}
	else
	{
		var_0E = "center2left_cam";
		var_0F = 1;
	}

	if(self.drive_cam_anim_name != var_0E)
	{
		if(self.drive_cam_anim_name == "cockpit_static_idle_cam")
		{
			self.drive_cam_anim_name = var_0E;
			self.drive_cam_yaw_sign = var_0F;
			self.drive_cam_centering = var_05;
			self.player_rig setanimknob(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,0,1);
			return;
		}

		var_10 = self.player_rig getanimtime(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name));
		self.drive_cam_anim_name = var_0E;
		self.drive_cam_yaw_sign = var_0F;
		if(!var_07 && self.drive_cam_centering != var_05)
		{
			var_10 = 1 - var_10;
			var_10 = clamp(var_10,0,1);
			self.player_rig setanimknob(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,0.2,var_08);
			self.player_rig setanimtime(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),var_10);
		}
		else
		{
			self.player_rig setanimknob(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),1,0.2,var_08);
		}

		self.drive_cam_centering = var_05;
		return;
	}

	self.player_rig setanimrate(self.player_rig maps\_utility::getanim(self.drive_cam_anim_name),var_09);
}

//Function Number: 11
play_pitbull_add_idle(param_00,param_01)
{
	var_02 = 0;
	if(abs(param_00) < 0.25)
	{
		var_02 = 1;
	}

	if(!isdefined(self.drive_anim_add_idle) || self.drive_anim_add_idle != var_02)
	{
		self.drive_anim_add_idle = var_02;
		if(self.drive_anim_add_idle)
		{
			set_pitbull_anim_node(::setanim,"idle_add",1,0.1,1);
			var_03 = randomfloatrange(0,1);
			self.fake_vehicle_model setanimtime(self.fake_vehicle_model maps\_utility::getanim("cockpit_idle"),var_03);
			self.player_rig setanimtime(self.player_rig maps\_utility::getanim("cockpit_idle"),var_03);
			return;
		}

		set_pitbull_anim_node(::setanim,"idle_add",0,0.1,1);
	}
}

//Function Number: 12
adjust_pitbull_add_idle()
{
	self endon("pitbull_scripted_anim");
	for(;;)
	{
		var_00 = self vehicle_getspeed();
		var_01 = var_00 / 60;
		var_01 = clamp(var_01,0,1);
		set_pitbull_anim(::setanimlimited,"cockpit_idle",1,0,var_01);
		if(1)
		{
			var_02 = var_00 / 60;
			var_02 = clamp(var_02,0,1.25);
			self.player_rig setanim(self.player_rig maps\_utility::getanim("cockpit_shake_cam"),1,0,var_02);
		}

		wait(0.05);
	}
}

//Function Number: 13
play_pitbull_camera_speed_anim()
{
	self endon("pitbull_scripted_anim");
	if(!1)
	{
		return;
	}

	self.drive_speed = 0;
	self.drive_cam_accel = 0;
	self.drive_cam_anim_accel = "none";
	var_00 = 0;
	for(;;)
	{
		var_01 = self vehicle_getspeed();
		var_02 = self vehicle_getbodyvelocity();
		if(var_02[0] < -0.0001)
		{
			var_01 = var_01 * -1;
		}

		var_03 = var_01 - self.drive_speed;
		var_04 = var_03 - self.drive_cam_accel;
		var_05 = 0;
		var_06 = 1;
		var_07 = "none";
		var_08 = 0;
		if(var_03 < 0)
		{
			var_00 = 0;
		}

		if(self.drive_cam_anim_accel == "accelerate_cam")
		{
			var_09 = self.player_rig getanimtime(self.player_rig maps\_utility::getanim(self.drive_cam_anim_accel));
			if(var_09 < 1 && var_03 > 0.1)
			{
				var_07 = "accelerate_cam";
			}
			else
			{
				var_07 = "accelerate2idle_cam";
				var_08 = 1 - var_09;
				var_08 = clamp(var_08,0,1);
			}
		}
		else if(self.drive_cam_anim_accel == "accelerate2idle_cam")
		{
			var_09 = self.player_rig getanimtime(self.player_rig maps\_utility::getanim(self.drive_cam_anim_accel));
			if(var_09 < 1)
			{
				var_07 = "accelerate2idle_cam";
				if(abs(var_04) > 0.5)
				{
					var_06 = 2;
				}
			}
		}
		else if(self.drive_cam_anim_accel == "decelerate_cam")
		{
			var_09 = self.player_rig getanimtime(self.player_rig maps\_utility::getanim(self.drive_cam_anim_accel));
			if(var_09 < 1)
			{
				var_07 = "decelerate_cam";
				if(var_03 > 1)
				{
					var_06 = 3;
				}
				else if(var_03 > -0.5)
				{
					var_06 = 2.5;
				}
				else if(var_03 > -0.1)
				{
					var_06 = 2;
				}

				if(var_03 > 1 && var_04 >= 1)
				{
					var_00 = 1;
				}
			}
		}

		if(self.drive_cam_anim_accel == "none" || var_07 == "none")
		{
			if(var_01 > 0)
			{
				var_05 = 0.2;
				if((var_00 && var_03 > 0) || var_03 > 0.9 && self.drive_cam_accel > 0.9)
				{
					var_07 = "accelerate_cam";
				}
				else if(var_03 < -1.5 && abs(var_04) >= 1)
				{
					var_07 = "decelerate_cam";
				}
			}
		}

		self.drive_cam_accel = var_03;
		if(self.drive_cam_anim_accel != var_07)
		{
			if(var_07 == "none")
			{
				if(self.drive_cam_anim_accel != "none")
				{
					self.player_rig clearanim(self.player_rig maps\_utility::getanim(self.drive_cam_anim_accel),0.2);
				}
			}
			else
			{
				var_0A = self.player_rig maps\_utility::getanim(var_07);
				self.player_rig setanimknob(var_0A,1,var_05,var_06);
				if(var_08 > 0)
				{
					self.player_rig setanimtime(var_0A,var_08);
				}
			}

			self.drive_cam_anim_accel = var_07;
		}

		self.drive_speed = var_01;
		wait(0.05);
	}
}

//Function Number: 14
pick_best_gear(param_00)
{
	if(param_00 < 10)
	{
		return 1;
	}

	if(param_00 < 40)
	{
		return 2;
	}

	return 3;
}

//Function Number: 15
play_pitbull_gear_shift_anim()
{
	self endon("pitbull_scripted_anim");
	var_00 = self vehicle_getspeed();
	var_01 = self vehicle_getbodyvelocity();
	if(var_01[0] < -0.0001)
	{
		var_00 = var_00 * -1;
	}

	var_02 = pick_best_gear(var_00);
	var_03 = "none";
	var_04 = 0;
	var_05 = 0;
	for(;;)
	{
		var_00 = self vehicle_getspeed();
		var_01 = self vehicle_getbodyvelocity();
		if(var_01[0] < -0.0001)
		{
			var_00 = var_00 * -1;
		}

		var_06 = 0;
		var_07 = 0;
		var_08 = "none";
		if(var_02 == 1)
		{
			var_06 = -99999;
			var_07 = 30;
		}
		else if(var_02 == 2)
		{
			var_06 = 20;
			var_07 = 55;
		}
		else if(var_02 == 3)
		{
			var_06 = 40;
			var_07 = 9999;
		}

		if(var_00 < var_06)
		{
			var_04 = pick_best_gear(var_00);
			var_08 = "gear_down";
		}
		else if(var_00 > var_07)
		{
			var_04 = pick_best_gear(var_00);
			var_08 = "gear_up";
			self vehicle_setspeedimmediate(var_07,60,60);
		}

		if(var_03 != "none")
		{
			var_09 = self.player_rig getanimtime(self.player_rig maps\_utility::getanim(var_03));
			if(var_09 >= 0.3 && var_05 > 0)
			{
				var_02 = var_05;
				var_05 = 0;
			}

			if(var_09 >= 1)
			{
				var_03 = "none";
				var_02 = var_04;
			}
		}
		else if(var_03 != var_08)
		{
			var_03 = var_08;
			var_05 = var_04;
			if(isdefined(level.player_pitbull))
			{
				level.player_pitbull notify("audio_shift",var_03);
			}

			set_pitbull_anim(::setanimknobrestart,var_03,1,0.2,1);
		}

		wait(0.05);
	}
}

//Function Number: 16
get_pitbull_anim_node(param_00)
{
	if(param_00 == "root")
	{
		return %root;
	}

	if(param_00 == "speed_anims")
	{
		return %speed_anims;
	}

	if(param_00 == "idle_add")
	{
		return %idle_add;
	}
}

//Function Number: 17
get_player_anim_node(param_00)
{
	if(param_00 == "root")
	{
		return %root;
	}

	if(param_00 == "speed_anims")
	{
		return %speed_anims;
	}

	if(param_00 == "idle_add")
	{
		return %idle_add;
	}

	if(param_00 == "camera_accel_anims")
	{
		return %camera_accel_anims;
	}
}