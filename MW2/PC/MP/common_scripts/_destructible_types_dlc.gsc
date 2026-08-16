/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types_dlc.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

maketype_dlc(destructibletype)
{
	infoindex = common_scripts\_destructible_types::getinfoindex(destructibletype);
	if(infoindex >= 0)
	{
		return infoindex;
	}

	found_dlc_destructible = 1;
	switch(destructibletype)
	{
		case "toy_new_dlc_destructible":
			common_scripts\_destructible_types::toy_glass("120x110");
			break;

		case "toy_security_camera":
			toy_security_camera(destructibletype);
			break;

		case "toy_arcade_machine_1":
			toy_arcade_machine("_1");
			break;

		case "toy_arcade_machine_2":
			toy_arcade_machine("_2");
			break;

		case "toy_pinball_machine_1":
			toy_pinball_machine("_1");
			break;

		case "toy_pinball_machine_2":
			toy_pinball_machine("_2");
			break;

		default:
			found_dlc_destructible = 0;
			break;
	}

	if(!found_dlc_destructible)
	{
		return undefined;
	}

	infoindex = common_scripts\_destructible_types::getinfoindex(destructibletype);
	return infoindex;
}

toy_security_camera(destructibletype)
{
	common_scripts\_destructible::destructible_create(destructibletype, "tag_camera_tilt", 0, undefined, 32);
	common_scripts\_destructible::destructible_anim(common_scripts\_destructible_types::get_precached_anim("security_camera_idle"), 4, "setanimknob", undefined, undefined, "security_camera_idle");
	common_scripts\_destructible::destructible_state("tag_camera_tilt", "com_security_camera_tilt_animated", 75);
	common_scripts\_destructible::destructible_anim(common_scripts\_destructible_types::get_precached_anim("security_camera_destroy"), 4, "setanimknob", undefined, undefined, "security_camera_destroy");
	common_scripts\_destructible::destructible_fx("tag_fx", "props/security_camera_explosion_moving");
	common_scripts\_destructible::destructible_sound("security_camera_sparks");
	common_scripts\_destructible::destructible_state(undefined, "com_security_camera_d_tilt_animated", undefined, undefined, "no_melee");
}

toy_arcade_machine(version)
{
	common_scripts\_destructible::destructible_create("toy_arcade_machine" + version, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_state("tag_origin", "arcade_machine" + version, 75);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/arcade_machine_exp");
	common_scripts\_destructible::destructible_fx("tag_fx2", "props/arcade_machine_coins");
	common_scripts\_destructible::destructible_sound("arcade_machine_destroy");
	common_scripts\_destructible::destructible_state(undefined, "arcade_machine" + version + "_des", undefined, undefined, "no_melee");
}

toy_pinball_machine(version)
{
	common_scripts\_destructible::destructible_create("toy_pinball_machine" + version, "tag_origin", 0, undefined, 32);
	common_scripts\_destructible::destructible_state("tag_origin", "pinball_machine" + version, 75);
	common_scripts\_destructible::destructible_fx("tag_fx", "props/pinball_machine_exp", undefined, undefined, undefined, 1);
	common_scripts\_destructible::destructible_fx("tag_fx2", "props/arcade_machine_coins");
	common_scripts\_destructible::destructible_fx("tag_fx3", "props/pinball_machine_glass");
	common_scripts\_destructible::destructible_sound("pinball_machine_destroy");
	common_scripts\_destructible::destructible_state(undefined, "pinball_machine" + version + "_des", undefined, undefined, "no_melee");
}