/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 92
 * Decompile Time: 1397 ms
 * Timestamp: 4/22/2024 2:34:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_vo();
	thread init_pcap_vo();
}

//Function Number: 2
setup_vo()
{
	level.scr_radio["lag_brk_youreup"] = "lag_brk_youreup";
	level.scr_radio["lag_gdn_approachingtargetbuilding"] = "lag_gdn_approachingtargetbuilding";
	level.scr_radio["lag_gdn_hades"] = "lag_gdn_hades";
	level.scr_radio["lag_jkr_wegonnabaghim"] = "lag_jkr_wegonnabaghim";
	level.scr_radio["lag_gdn_thepmsourfirstpriority"] = "lag_gdn_thepmsourfirstpriority";
	level.scr_radio["lag_jkr_flydronelive"] = "lag_jkr_flydronelive";
	level.scr_radio["lag_brk_gotit"] = "lag_brk_gotit";
	level.scr_radio["lag_jkr_fivekva"] = "lag_jkr_fivekva";
	level.scr_radio["lag_brk_keepmoving"] = "lag_brk_keepmoving";
	level.scr_radio["lag_jkr_roomahead"] = "lag_jkr_roomahead";
	level.scr_radio["lag_brk_bingo"] = "lag_brk_bingo";
	level.scr_sound["drone_intro"]["lag_kva_ineedtwomenby"] = "lag_kva_ineedtwomenby";
	level.scr_sound["drone_intro"]["lag_kva_movemove"] = "lag_kva_movemove";
	level.scr_sound["drone_intro"]["lag_kva_coverthatdoor"] = "lag_kva_coverthatdoor";
	level.scr_sound["drone_intro"]["lag_kva_getinposition"] = "lag_kva_getinposition";
	level.scr_radio["lagos_pmr_iamtheonlyperson"] = "lagos_pmr_iamtheonlyperson";
	level.scr_radio["lagos_hade_wearemenborntodie"] = "lagos_hade_wearemenborntodie";
	level.scr_radio["lagos_pmr_wealllivebygods"] = "lagos_pmr_wealllivebygods";
	level.scr_radio["lagos_hade_youaremistaken"] = "lagos_hade_youaremistaken";
	level.scr_sound["burke"]["lag_brk_throwsspanner"] = "lag_brk_throwsspanner";
	level.scr_radio["lagos_prt_copyatlastwooneyouhave"] = "lagos_prt_copyatlastwooneyouhave";
	level.scr_sound["joker"]["lag_jkr_waitforsundown"] = "lag_jkr_waitforsundown";
	level.scr_sound["burke"]["lagos_brk_threemikestophaseline"] = "lagos_brk_threemikestophaseline";
	level.scr_sound["ajani"]["lagos_brk_ifweattacknowtheyll"] = "lagos_brk_ifweattacknowtheyll";
	level.scr_sound["burke"]["lag_brk_gametime"] = "lag_brk_gametime";
	level.scr_sound["joker"]["lag_jkr_losecherry"] = "lag_jkr_losecherry";
	level.scr_radio["lag_prpt_readyonmark"] = "lag_prpt_readyonmark";
	level.scr_sound["burke"]["lag_brk_checkpointzed"] = "lag_brk_checkpointzed";
	level.scr_radio["lag_prpt_vidlink"] = "lag_prpt_vidlink";
	level.scr_radio["lag_irs_letsshowthemwhatatlas2"] = "lag_irs_letsshowthemwhatatlas2";
	level.scr_radio["lag_irs_ahandshakewiththeprime"] = "lag_irs_ahandshakewiththeprime";
	level.scr_sound["burke"]["lag_brk_pressure"] = "lag_brk_pressure";
	level.scr_radio["lag_irns_goodluck"] = "lag_irns_goodluck";
	level.scr_sound["joker"]["lag_jkr_locked"] = "lag_jkr_locked";
	level.scr_sound["burke"]["lag_brk_feelforexo"] = "lag_brk_feelforexo";
	level.scr_sound["burke"]["lag_brk_getdoor"] = "lag_brk_getdoor";
	level.scr_sound["ajani"]["lag_ajn_mymenareinposition"] = "lag_ajn_mymenareinposition";
	level.scr_sound["burke"]["lag_gdn_noonefiresunlesswe"] = "lag_gdn_noonefiresunlesswe";
	level.scr_sound["ajani"]["lag_ajn_understood"] = "lag_ajn_understood";
	level.scr_sound["burke"]["lag_gdn_letsgo"] = "lag_gdn_letsgo";
	level.scr_sound["ajani"]["lag_ajni_uphere"] = "lag_ajni_uphere";
	level.scr_sound["nigerian_army"]["lag_finalwarning"] = "lag_finalwarning";
	level.scr_sound["nigerian_army"]["lagos_ngr_thisisthenigerianarmy"] = "lagos_ngr_thisisthenigerianarmy";
	level.scr_sound["nigerian_army"]["lagos_ngr_youwillnotbeharmed"] = "lagos_ngr_youwillnotbeharmed";
	level.scr_sound["burke"]["lag_brk_overhere"] = "lag_brk_overhere";
	level.scr_sound["burke"]["lag_brk_activatemaggrip"] = "lag_brk_activatemaggrip";
	level.scr_sound["burke"]["lag_brk_alrightajani"] = "lag_brk_alrightajani";
	level.scr_sound["ajani"]["lag_ajni_ceasefire"] = "lag_ajni_ceasefire";
	level.scr_radio["lagos_ngr_yessireveryoneholdfire"] = "lagos_ngr_yessireveryoneholdfire";
	level.scr_sound["burke"]["lag_brk_readymute"] = "lag_brk_readymute";
	level.scr_sound["burke"]["lag_brk_placecharge"] = "lag_brk_placecharge";
	level.scr_sound["burke"]["lag_brk_moveit"] = "lag_brk_moveit";
	level.scr_sound["joker"]["lag_jkr_hostageroom"] = "lag_jkr_hostageroom";
	level.scr_sound["burke"]["lag_brk_clearedperimeter"] = "lag_brk_clearedperimeter";
	level.scr_radio["lag_prt_copytwoone"] = "lag_prt_copytwoone";
	level.scr_sound["burke"]["lag_brk_move"] = "lag_brk_move";
	level.scr_sound["joker"]["lag_jkr_clear"] = "lag_jkr_clear";
	level.scr_sound["burke"]["lag_brk_takelook"] = "lag_brk_takelook";
	level.scr_sound["burke"]["lag_brk_eyesontarget"] = "lag_brk_eyesontarget";
	level.scr_sound["ajani"]["lag_ajni_whatisthis"] = "lag_ajni_whatisthis";
	level.scr_sound["ajani"]["lag_ajni_whatbethis"] = "lag_ajni_whatbethis";
	level.scr_sound["burke"]["lag_brk_harmonicpulse"] = "lag_brk_harmonicpulse";
	level.scr_sound["joker"]["lag_jkr_showtime"] = "lag_jkr_showtime";
	level.scr_sound["burke"]["lag_brk_markem"] = "lag_brk_markem";
	level.scr_sound["burke"]["lag_brk_targetconfirmed"] = "lag_brk_targetconfirmed";
	level.scr_sound["burke"]["lag_brk_gothim"] = "lag_brk_gothim";
	level.scr_sound["burke"]["lagos_brk_targetlocked"] = "lagos_brk_targetlocked";
	level.scr_sound["burke"]["lag_brk_yousurehostile"] = "lag_brk_yousurehostile";
	level.scr_sound["burke"]["lag_brk_untaghim"] = "lag_brk_untaghim";
	level.scr_sound["burke"]["lag_brk_marktargets"] = "lag_brk_marktargets";
	level.scr_sound["burke"]["lag_brk_markfuckintargets"] = "lag_brk_markfuckintargets";
	level.scr_sound["burke"]["lag_brk_executehostage"] = "lag_brk_executehostage";
	level.scr_sound["burke"]["lag_brk_takethem"] = "lag_brk_takethem";
	level.scr_sound["burke"]["lag_brk_hitem"] = "lag_brk_hitem";
	level.scr_sound["burke"]["lag_brk_hostilesonly"] = "lag_brk_hostilesonly";
	level.scr_sound["joker"]["lag_jkr_hostilestagged"] = "lag_jkr_hostilestagged";
	level.scr_sound["burke"]["lag_brk_onyourgo"] = "lag_brk_onyourgo";
	level.scr_sound["burke"]["lag_brk_payattention"] = "lag_brk_payattention";
	level.scr_sound["burke"]["lag_brk_hitemnow"] = "lag_brk_hitemnow";
	level.scr_sound["joker"]["lag_jkr_targetsdown"] = "lag_jkr_targetsdown";
	level.scr_sound["ajani"]["lag_ajni_nigerianarmy"] = "lag_ajni_nigerianarmy";
	level.scr_sound["burke"]["lag_brk_ontheground"] = "lag_brk_ontheground";
	level.scr_sound["burke"]["lag_brk_positiveid"] = "lag_brk_positiveid";
	level.scr_radio["lag_brk_taptrafficcams"] = "lag_brk_taptrafficcams";
	level.scr_sound["burke"]["lag_brk_rogerthat"] = "lag_brk_rogerthat";
	level.scr_radio["lag_pm_techsummit"] = "lag_pm_techsummit";
	level.scr_sound["burke"]["lag_gdn_mitchellsecurethepm"] = "lag_gdn_mitchellsecurethepm";
	level.scr_sound["burke"]["lag_brk_ajani"] = "lag_brk_ajani";
	level.scr_sound["ajani"]["lag_ajni_whiteboxtruck"] = "lag_ajni_whiteboxtruck";
	level.scr_sound["burke"]["lag_brk_safehere"] = "lag_brk_safehere";
	level.scr_radio["lag_pm_tysoldier"] = "lag_pm_tysoldier";
	level.scr_sound["joker"]["lag_jkr_rushhour"] = "lag_jkr_rushhour";
	level.scr_sound["ajani"]["lag_ajni_outofway"] = "lag_ajni_outofway";
	level.scr_sound["ajani"]["lag_ajni_outderoad"] = "lag_ajni_outderoad";
	level.scr_sound["joker"]["lag_jkr_rpg"] = "lag_jkr_rpg";
	level.scr_sound["street_drop_bike"]["lag_civ2_dontshoot"] = "lag_civ2_dontshoot";
	level.scr_sound["lobby_security"]["lagos_cv1_mygod"] = "lagos_cv1_mygod";
	level.scr_sound["lobby_security"]["lagos_cv1_whatsgoingon"] = "lagos_cv1_whatsgoingon";
	level.scr_sound["joker"]["lag_jkr_kvabalcony"] = "lag_jkr_kvabalcony";
	level.scr_sound["burke"]["lag_brk_threatgrenade"] = "lag_brk_threatgrenade";
	level.scr_sound["joker"]["lag_jkr_kvaright"] = "lag_jkr_kvaright";
	level.scr_sound["joker"]["lag_jkr_tangosbehind"] = "lag_jkr_tangosbehind";
	level.scr_sound["joker"]["lag_jkr_kvaatsix"] = "lag_jkr_kvaatsix";
	level.scr_sound["ajani"]["lag_ajni_snipersbalcony"] = "lag_ajni_snipersbalcony";
	level.scr_sound["burke"]["lag_brk_areaclear"] = "lag_brk_areaclear";
	level.scr_sound["burke"]["lag_brk_throughhere"] = "lag_brk_throughhere";
	level.scr_radio["lag_prpt_truckhalfmilewest"] = "lag_prpt_truckhalfmilewest";
	level.scr_sound["burke"]["lag_brk_wereonit"] = "lag_brk_wereonit";
	level.scr_sound["burke"]["lagos_brk_areaclear"] = "lagos_brk_areaclear";
	level.scr_sound["ajani"]["lagos_ajn_throughthegatehere"] = "lagos_ajn_throughthegatehere";
	level.scr_sound["joker"]["lag_jkr_ivegotit"] = "lag_jkr_ivegotit";
	level.scr_sound["burke"]["lag_brk_thisway"] = "lag_brk_thisway";
	level.scr_sound["burke"]["lag_brk_hookright"] = "lag_brk_hookright";
	level.scr_sound["burke"]["lag_brk_upstairs"] = "lag_brk_upstairs";
	level.scr_sound["burke"]["lag_brk_throughhere2"] = "lag_brk_throughhere2";
	level.scr_sound["ajani"]["lag_ajn_independenceroadisthroughhere"] = "lag_ajn_independenceroadisthroughhere";
	level.scr_sound["joker"]["lag_jkr_technical"] = "lag_jkr_technical";
	level.scr_sound["burke"]["lag_brk_inside"] = "lag_brk_inside";
	level.scr_sound["joker"]["lag_jkr_turretshielded"] = "lag_jkr_turretshielded";
	level.scr_sound["burke"]["lag_brk_flanktechnical"] = "lag_brk_flanktechnical";
	level.scr_sound["joker"]["lag_jkr_getbehind"] = "lag_jkr_getbehind";
	level.scr_sound["burke"]["lag_brk_decentwork"] = "lag_brk_decentwork";
	level.scr_radio["lag_prpt_libertyhwy"] = "lag_prpt_libertyhwy";
	level.scr_sound["ajani"]["lag_ajni_wereclosehere"] = "lag_ajni_wereclosehere";
	level.scr_sound["burke"]["lag_brk_getacross"] = "lag_brk_getacross";
	level.scr_sound["burke"]["lag_brk_watchyourself"] = "lag_brk_watchyourself";
	level.scr_sound["joker"]["lag_jkr_roadkill"] = "lag_jkr_roadkill";
	level.scr_sound["joker"]["lagos_jkr_dontwantroadkillon"] = "lagos_jkr_dontwantroadkillon";
	level.scr_radio["lagos_prt_targettruckisapproachingyour"] = "lagos_prt_targettruckisapproachingyour";
	level.scr_sound["burke"]["lag_brk_copythat"] = "lag_brk_copythat";
	level.scr_sound["burke"]["lag_brk_onme"] = "lag_brk_onme";
	level.scr_sound["burke"]["lag_brk_mitchellhere"] = "lag_brk_mitchellhere";
	level.scr_radio["lag_prpt_eyesontruck"] = "lag_prpt_eyesontruck";
	level.scr_sound["burke"]["lag_brk_iseeit"] = "lag_brk_iseeit";
	level.scr_sound["burke"]["lag_brk_nocleanshot"] = "lag_brk_nocleanshot";
	level.scr_sound["burke"]["lag_brk_fuckit"] = "lag_brk_fuckit";
	level.scr_sound["burke"]["lag_brk_jump"] = "lag_brk_jump";
	level.scr_radio["lag_jkr_whereyougo"] = "lag_jkr_whereyougo";
	level.scr_sound["burke"]["lag_brk_followus"] = "lag_brk_followus";
	level.scr_radio["lag_jkr_rogerthat"] = "lag_jkr_rogerthat";
	level.scr_sound["burke"]["lag_brk_maggripbalance"] = "lag_brk_maggripbalance";
	level.scr_sound["burke"]["lag_brk_usemaggrip"] = "lag_brk_usemaggrip";
	level.scr_sound["burke"]["lag_brk_stayclose"] = "lag_brk_stayclose";
	level.scr_sound["burke"]["lag_brk_kvaonbus"] = "lag_brk_kvaonbus";
	level.scr_sound["burke"]["lag_brk_takeoutsuv"] = "lag_brk_takeoutsuv";
	level.scr_sound["burke"]["lag_brk_readyjump"] = "lag_brk_readyjump";
	level.scr_sound["burke"]["lag_brk_go"] = "lag_brk_go";
	level.scr_sound["burke"]["lag_brk_jumpnow"] = "lag_brk_jumpnow";
	level.scr_sound["burke"]["lag_brk_thereitis"] = "lag_brk_thereitis";
	level.scr_sound["burke"]["lag_brk_mitchelljump"] = "lag_brk_mitchelljump";
	level.scr_sound["burke"]["lagos_brk_nodozing"] = "lagos_brk_nodozing";
	level.scr_sound["joker"]["lagos_jkr_pleasetellmehesfuckin"] = "lagos_jkr_pleasetellmehesfuckin";
	level.scr_sound["burke"]["lagos_brk_stopstressinghesbreathingbarely"] = "lagos_brk_stopstressinghesbreathingbarely";
	level.scr_sound["joker"]["lagos_jkr_thehelltheywantwith"] = "lagos_jkr_thehelltheywantwith";
	level.scr_sound["burke"]["lagos_brk_dontknowdontcare"] = "lagos_brk_dontknowdontcare";
	level.scr_radio["lagos_ajn_youdeliveredexactlyaspromised"] = "lagos_ajn_youdeliveredexactlyaspromised";
	level.scr_sound["burke"]["lagos_brk_lookstojokerandmitchell"] = "lagos_brk_lookstojokerandmitchell";
	level.scr_sound["burke"]["lag_gdn_fuckme"] = "lag_gdn_fuckme";
	level.scr_radio["lag_gdn_comeonmitchell"] = "lag_gdn_comeonmitchell";
	level.scr_sound["burke"]["lag_gdn_movearoundthatwindow2"] = "lag_gdn_movearoundthatwindow2";
	level.scr_sound["burke"]["lag_gdn_markthetargets"] = "lag_gdn_markthetargets";
	level.scr_sound["burke"]["lag_gdn_welltakethemdowntogether"] = "lag_gdn_welltakethemdowntogether";
	level.scr_sound["joker"]["lag_jkr_lookslikehadesrabbitted"] = "lag_jkr_lookslikehadesrabbitted";
	level.scr_sound["burke"]["lag_gdn_notourproblem"] = "lag_gdn_notourproblem";
	level.scr_sound["burke"]["lag_gdn_mitchellfreetheprimeminister"] = "lag_gdn_mitchellfreetheprimeminister";
	level.scr_sound["burke"]["lag_gdn_whatareyouwaitingfor"] = "lag_gdn_whatareyouwaitingfor";
	level.scr_sound["burke"]["lag_gdn_tangowithrpgontop"] = "lag_gdn_tangowithrpgontop";
	level.scr_sound["burke"]["lag_gdn_theyreusingmmgsstayclear"] = "lag_gdn_theyreusingmmgsstayclear";
	level.scr_sound["burke"]["lag_gdn_useyouroverdrive"] = "lag_gdn_useyouroverdrive";
	level.scr_sound["joker"]["lag_jkr_morecominginbythe"] = "lag_jkr_morecominginbythe";
	level.scr_sound["joker"]["lag_gdr_enemiesbytheshops"] = "lag_gdr_enemiesbytheshops";
	level.scr_sound["joker"]["lag_jkr_boooom"] = "lag_jkr_boooom";
	level.scr_sound["ajani"]["lag_ajn_wecantakeashortcut2"] = "lag_ajn_wecantakeashortcut2";
	level.scr_sound["burke"]["lag_gdn_needtogetoverthis"] = "lag_gdn_needtogetoverthis";
	level.scr_sound["burke"]["lag_gdn_getacrossthestreetmitchell2"] = "lag_gdn_getacrossthestreetmitchell2";
	level.scr_sound["burke"]["lag_gdn_crossthestreet2"] = "lag_gdn_crossthestreet2";
	level.scr_sound["burke"]["lag_gdn_clearcrossover"] = "lag_gdn_clearcrossover";
	level.scr_sound["burke"]["lag_gdn_mitchellgetoverherenow"] = "lag_gdn_mitchellgetoverherenow";
	level.scr_sound["burke"]["lag_gdn_enemychoppertakeitdown2"] = "lag_gdn_enemychoppertakeitdown2";
	level.scr_sound["burke"]["lag_gdn_holdon"] = "lag_gdn_holdon";
	level.scr_sound["burke"]["lag_gdn_mitchellstayonmission2"] = "lag_gdn_mitchellstayonmission2";
	level.scr_sound["burke"]["lag_gdn_wherethehellareyou2"] = "lag_gdn_wherethehellareyou2";
	level.scr_radio["lag_gdn_activatethedronemitchell"] = "lag_gdn_activatethedronemitchell";
	level.scr_sound["burke"]["lag_gdn_startclimbingmitchell"] = "lag_gdn_startclimbingmitchell";
	level.scr_sound["burke"]["lag_brk_moveit"] = "lag_brk_moveit";
}

//Function Number: 3
init_dialogue_flags()
{
}

//Function Number: 4
start_dialogue_threads()
{
	switch(level.start_point)
	{
		case "outro":
		case "flank alley":
		case "alley 2":
		case "oncoming alley":
		case "alley 1":
		case "default":
		case "van_takedown":
		case "traffic_traverse":
		case "traffic_frogger":
		case "government_building":
		case "intro_squad":
		case "intro_drone":
		case "roundabout":
			break;

		default:
			break;
	}
}

//Function Number: 5
pcap_drone_opening()
{
}

//Function Number: 6
pcap_squad_briefing()
{
}

//Function Number: 7
pcap_pm_rescue()
{
}

//Function Number: 8
pcap_shore_outro()
{
}

//Function Number: 9
fly_drone_intro_dialogue()
{
	radio_dialogue_queue_global("lag_brk_youreup");
	wait(1);
	radio_dialogue_queue_global("lag_jkr_flydronelive");
	level notify("DroneCameraAudioStart");
	thread fly_drone_nag();
	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	thread fly_drone_intro_kva_dialogue();
	radio_dialogue_queue_global("lag_brk_gotit");
	wait(4);
	radio_dialogue_queue_global("lag_gdn_approachingtargetbuilding");
	wait(8);
	radio_dialogue_queue_global("lag_jkr_fivekva");
	wait(1);
	radio_dialogue_queue_global("lag_brk_keepmoving");
	wait(4);
	radio_dialogue_queue_global("lag_jkr_roomahead");
	wait(6);
	soundscripts\_snd::snd_message("lag_intro_vo_overlap_mix");
	radio_dialogue_queue_global("lag_brk_bingo");
	radio_dialogue_queue_global("lag_gdn_hades");
	radio_dialogue_queue_global("lag_jkr_wegonnabaghim");
	radio_dialogue_queue_global("lag_gdn_thepmsourfirstpriority");
	level notify("lag_intro_vo_overlap_mix_done");
}

//Function Number: 10
fly_drone_nag()
{
	var_00 = 0;
	var_01 = 2;
	while(!common_scripts\utility::flag("flag_player_input_for_drone_start"))
	{
		wait(randomintrange(8,10));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_player_input_for_drone_start"))
				{
					radio_dialogue_queue_global("lag_gdn_activatethedronemitchell");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("flag_player_input_for_drone_start"))
				{
					radio_dialogue_queue_global("lag_gdn_comeonmitchell");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 11
fly_drone_intro_kva_dialogue()
{
	wait(10);
	level.kva_opening_vo dialogue_queue_global("lag_kva_ineedtwomenby");
	wait(0.5);
	level.kva_opening_vo dialogue_queue_global("lag_kva_movemove");
	wait(4);
	level.kva_opening_vo dialogue_queue_global("lag_kva_coverthatdoor");
	wait(2);
	level.kva_opening_vo dialogue_queue_global("lag_kva_getinposition");
}

//Function Number: 12
squad_move_out_dialogue()
{
	thread play_irons_pip();
	wait(1);
	radio_dialogue_queue_global("lag_prpt_vidlink");
	thread exo_door_dialogue();
}

//Function Number: 13
play_irons_pip()
{
	lagos_irons_speech_bink();
	thread maps\_shg_utility::play_videolog("lagos_videolog_02","screen_add");
	wait(24);
	common_scripts\utility::flag_set("flag_irons_videolog_complete");
}

//Function Number: 14
lagos_irons_speech_bink()
{
	level.player playscheduledcinematicsound(126,"lag_irs_letsshowthemwhatatlas2");
	level.player playscheduledcinematicsound(345,"lag_irs_ahandshakewiththeprime");
	level.burke playscheduledcinematicsound(555,"lag_brk_pressure");
	level.player playscheduledcinematicsound(625,"lag_irns_goodluck");
}

//Function Number: 15
play_hostage_vehicle_pip()
{
	maps\_shg_utility::play_videolog("lagos_videolog_01","screen_add",undefined,undefined,undefined,undefined,undefined,0.5);
}

//Function Number: 16
exo_door_dialogue()
{
	common_scripts\utility::flag_wait("flag_irons_videolog_complete");
	common_scripts\utility::flag_wait("exo_door_trigger");
	level.joker dialogue_queue_global("lag_jkr_locked");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_feelforexo");
	wait(5);
	while(!common_scripts\utility::flag("done_exo_door_kick"))
	{
		if(!common_scripts\utility::flag("done_exo_door_kick"))
		{
			level.burke dialogue_queue_global("lag_brk_getdoor");
			continue;
		}

		return;
		wait(8);
	}
}

//Function Number: 17
government_building_reveal_dialogue()
{
	level.nigerian_bullhorn dialogue_queue_global("lagos_ngr_thisisthenigerianarmy");
	level.ajani dialogue_queue_global("lag_ajn_mymenareinposition");
	wait(0.33);
	level.burke dialogue_queue_global("lag_gdn_noonefiresunlesswe");
	wait(0.33);
	level.ajani dialogue_queue_global("lag_ajn_understood");
	wait(0.33);
	level.burke dialogue_queue_global("lag_gdn_letsgo");
	wait(1);
	level.ajani dialogue_queue_global("lag_ajni_uphere");
	wait(2);
	thread government_building_rail_walk_dialogue();
	wait(10);
	while(!common_scripts\utility::flag("done_rail_walk_start"))
	{
		if(!common_scripts\utility::flag("done_rail_walk_start"))
		{
			level.burke dialogue_queue_global("lag_brk_overhere");
			continue;
		}

		return;
		wait(10);
	}
}

//Function Number: 18
government_building_rail_walk_dialogue()
{
	for(var_00 = 0;!common_scripts\utility::flag("vo_government_building_mag_exo_dialogue");var_00++)
	{
		if(var_00 == 0)
		{
			level.nigerian_bullhorn dialogue_queue_global("lagos_ngr_youwillnotbeharmed");
			wait(6);
		}
		else if(var_00 == 1)
		{
			level.nigerian_bullhorn dialogue_queue_global("lag_finalwarning");
			wait(6);
		}
		else if(var_00 == 2)
		{
			level.nigerian_bullhorn dialogue_queue_global("lagos_ngr_thisisthenigerianarmy");
			wait(6);
		}

		if(var_00 >= 2)
		{
			var_00 = 0;
			continue;
		}
	}
}

//Function Number: 19
government_building_mag_exo_dialogue()
{
	wait(1.33);
	level.burke dialogue_queue_global("lag_brk_activatemaggrip");
	thread government_building_mag_exo_dialogue_nag();
	common_scripts\utility::flag_wait("vo_government_building_mag_exo_past_window");
	level.burke dialogue_queue_global("lag_gdn_movearoundthatwindow2");
}

//Function Number: 20
government_building_mag_exo_dialogue_nag()
{
	var_00 = 0;
	var_01 = 3;
	while(!common_scripts\utility::flag("flag_start_mag_climb"))
	{
		wait(randomintrange(8,10));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_start_mag_climb"))
				{
					level.burke dialogue_queue_global("lag_gdn_startclimbingmitchell");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("flag_start_mag_climb"))
				{
					level.burke dialogue_queue_global("lag_brk_moveit");
				}
				break;

			case 2:
				if(!common_scripts\utility::flag("flag_start_mag_climb"))
				{
					level.burke dialogue_queue_global("lag_brk_payattention");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 21
notetrack_vo_exo_climb(param_00)
{
	common_scripts\utility::flag_set("flag_exo_climb_started");
}

//Function Number: 22
government_building_roof_breach_dialogue()
{
	wait(0.85);
	level notify("cease_fire_init");
	wait(0.15);
	level notify("gov_breach_init");
	wait(7);
	level.burke dialogue_queue_global("lag_brk_readymute");
	level notify("roof_breach_plant");
	thread government_building_roof_breach_dialogue_nag();
}

//Function Number: 23
government_building_roof_breach_dialogue_nag()
{
	var_00 = 0;
	var_01 = 3;
	while(!common_scripts\utility::flag("done_roof_breach_start"))
	{
		wait(randomintrange(8,10));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("done_roof_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_placecharge");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("done_roof_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_moveit");
				}
				break;

			case 2:
				if(!common_scripts\utility::flag("done_roof_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_payattention");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 24
government_building_interior_dialogue()
{
	wait(3);
	level.joker dialogue_queue_global("lag_jkr_hostageroom");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_clearedperimeter");
	wait(0.33);
	level maps\_utility::dialogue_queue("lag_prt_copytwoone");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_move");
	wait(2);
	level.joker dialogue_queue_global("lag_jkr_clear");
	wait(0.33);
	harmonic_breach_prep_dialogue();
}

//Function Number: 25
harmonic_breach_prep_dialogue()
{
	level.burke dialogue_queue_global("lag_brk_takelook");
	thread harmonic_breach_prep_dialogue_nag();
}

//Function Number: 26
harmonic_breach_prep_dialogue_nag()
{
	var_00 = 0;
	var_01 = 3;
	while(!common_scripts\utility::flag("done_gov_building_h_breach_start"))
	{
		wait(randomintrange(9,15));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("done_gov_building_h_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_eyesontarget");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("done_gov_building_h_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_moveit");
				}
				break;

			case 2:
				if(!common_scripts\utility::flag("done_gov_building_h_breach_start"))
				{
					level.burke dialogue_queue_global("lag_brk_payattention");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 27
harmonic_breach_start_dialogue()
{
	wait(6.5);
	level.ajani dialogue_queue_global("lag_ajni_whatbethis");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_harmonicpulse");
	wait(1.6);
	level.joker dialogue_queue_global("lag_jkr_showtime");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_markem");
	wait(0.33);
	level.burke dialogue_queue_global("lag_gdn_welltakethemdowntogether");
	thread harmonic_breach_confirmation_dialogue();
	thread harmonic_breach_correction_dialogue();
	thread harmonic_breach_nag_dialogue();
}

//Function Number: 28
harmonic_breach_nag_timer()
{
	level endon("BreachComplete");
	level endon("execution_start");
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_notify_or_timeout_return("check_target_confirm",6);
		if(isdefined(var_00) && issubstr(var_00,"timeout"))
		{
			level notify("nag_h_breach");
		}
	}
}

//Function Number: 29
harmonic_breach_nag_dialogue()
{
	level endon("BreachComplete");
	level endon("execution_start");
	var_00 = 0;
	var_01 = 3;
	thread harmonic_breach_nag_timer();
	for(;;)
	{
		level waittill("nag_h_breach");
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_marktargets");
				}
				break;
	
			case 1:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_markfuckintargets");
				}
				break;
	
			case 2:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_payattention");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 1;
		}
	}
}

//Function Number: 30
harmonic_breach_correction_dialogue()
{
	level endon("BreachComplete");
	level endon("execution_start");
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		level waittill("check_target_correction");
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_yousurehostile");
				}
				break;
	
			case 1:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_untaghim");
				}
				break;
	
			case 2:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_hostilesonly");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 31
harmonic_breach_confirmation_dialogue()
{
	level endon("BreachComplete");
	level endon("execution_start");
	var_00 = 0;
	var_01 = 2;
	for(;;)
	{
		level waittill("check_target_confirm");
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_targetconfirmed");
				}
				break;
	
			case 1:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_gothim");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 32
harmonic_breach_shoot_now_dialogue()
{
	level endon("BreachComplete");
	var_00 = 0;
	var_01 = 3;
	wait(1);
	for(;;)
	{
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.joker dialogue_queue_global("lag_jkr_hostilestagged");
				}
				break;
	
			case 1:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_onyourgo");
				}
				break;
	
			case 2:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_takethem");
				}
				break;
	
			case 3:
				if(!common_scripts\utility::flag("flag_h_breach_complete"))
				{
					level.burke dialogue_queue_global("lag_brk_hitemnow");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}

		wait(2);
	}
}

//Function Number: 33
harmonic_breach_timer_warning_dialogue()
{
	level waittill("execution_start");
	level.burke dialogue_queue_global("lag_brk_executehostage");
}

//Function Number: 34
harmonic_breach_secure_pm()
{
	level.joker dialogue_queue_global("lag_jkr_lookslikehadesrabbitted");
	wait(0.33);
	level.burke dialogue_queue_global("lag_gdn_notourproblem");
	wait(0.5);
	level.burke dialogue_queue_global("lag_gdn_mitchellsecurethepm");
	level notify("scan_idle_go");
	level endon("player_end_scan");
	var_00 = 0;
	var_01 = 3;
	for(;;)
	{
		wait(randomintrange(7,10));
		switch(var_00)
		{
			case 0:
				level.burke dialogue_queue_global("lag_gdn_mitchellfreetheprimeminister");
				break;
	
			case 1:
				level.burke dialogue_queue_global("lag_gdn_mitchellsecurethepm");
				break;
	
			case 2:
				level.burke dialogue_queue_global("lag_gdn_whatareyouwaitingfor");
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 35
harmonic_breach_complete_dialogue()
{
	wait(2);
	level.joker dialogue_queue_global("lag_jkr_targetsdown");
}

//Function Number: 36
leaving_gov_building()
{
	common_scripts\utility::flag_wait("flag_leaving_gov_building");
	wait(1);
	thread play_hostage_vehicle_pip();
	wait(4);
	radio_dialogue_queue_global("lag_brk_taptrafficcams");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_rogerthat");
}

//Function Number: 37
approaching_roundabout_dialogue()
{
	common_scripts\utility::flag_wait("flag_roundabout_player_move_1");
	wait(1);
	level.civilian_roundabout_vo_1 dialogue_queue_global("lagos_cv1_mygod");
	wait(2);
	level.civilian_roundabout_vo_2 dialogue_queue_global("lagos_cv1_whatsgoingon");
	common_scripts\utility::flag_wait("flag_roundabout_move_3");
	level.joker dialogue_queue_global("lag_jkr_rushhour");
	wait(1);
	level.ajani dialogue_queue_global("lag_ajni_outofway");
	wait(4);
	level.ajani dialogue_queue_global("lag_ajni_outderoad");
}

//Function Number: 38
roundabout_combat_dialogue()
{
	common_scripts\utility::flag_wait("roundabout_RPG_start");
	wait(0.25);
	level.joker dialogue_queue_global("lag_jkr_rpg");
	level notify("roundabout_lag_jkr_rpg");
	wait(1.75);
	if(isdefined(level.civilian_roundabout_vo_3) && isalive(level.civilian_roundabout_vo_3))
	{
		level.civilian_roundabout_vo_3 dialogue_queue_global("lag_civ2_dontshoot");
	}

	wait(2);
	level.burke dialogue_queue_global("lag_gdn_tangowithrpgontop");
	wait(1);
	level.burke dialogue_queue_global("lag_brk_threatgrenade");
	common_scripts\utility::flag_wait("flag_roundabout_magic_MWG");
	wait(1);
	level.burke dialogue_queue_global("lag_gdn_theyreusingmmgsstayclear");
	common_scripts\utility::flag_wait("roundabout_wave_1A_complete");
	wait(1.25);
	level.ajani dialogue_queue_global("lag_ajni_snipersbalcony");
	wait(1);
	level.burke dialogue_queue_global("lag_gdn_useyouroverdrive");
	common_scripts\utility::flag_wait("roundabout_wave_2_all_spawned");
	wait(4);
	level.joker dialogue_queue_global("lag_jkr_morecominginbythe");
	common_scripts\utility::flag_wait("roundabout_wave_2B_complete");
	wait(1.5);
	level.joker dialogue_queue_global("lag_gdr_enemiesbytheshops");
	common_scripts\utility::flag_wait("roundabout_wave_3_complete");
	wait(5);
	level.joker dialogue_queue_global("lag_jkr_boooom");
	level.burke dialogue_queue_global("lag_brk_areaclear");
	wait(1);
	level.ajani dialogue_queue_global("lag_ajn_wecantakeashortcut2");
	wait(3);
	level.burke dialogue_queue_global("lag_brk_throughhere");
}

//Function Number: 39
alley_a_dialogue()
{
	radio_dialogue_queue_global("lag_prpt_truckhalfmilewest");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_wereonit");
	common_scripts\utility::flag_wait("roundabout_wave_2_all_spawned");
}

//Function Number: 40
alley_1_complete_dialogue()
{
	wait(2);
	level.burke dialogue_queue_global("lagos_brk_areaclear");
	wait(0.5);
	level.ajani dialogue_queue_global("lagos_ajn_throughthegatehere");
	wait(0.33);
	level.joker dialogue_queue_global("lag_jkr_ivegotit");
}

//Function Number: 41
alley_oncoming_dialogue()
{
	level.burke dialogue_queue_global("lag_brk_thisway");
	level waittill("oncoming_truck_go");
	wait(0.66);
	level.burke dialogue_queue_global("lag_brk_hookright");
	wait(3.5);
	level.burke dialogue_queue_global("lag_brk_upstairs");
	wait(1);
}

//Function Number: 42
alley_b_dialogue()
{
	wait(6);
	level.ajani dialogue_queue_global("lag_ajn_independenceroadisthroughhere");
}

//Function Number: 43
alley_flank_dialogue()
{
	wait(1.5);
	level.joker dialogue_queue_global("lag_jkr_technical");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_inside");
	wait(3);
	level.joker dialogue_queue_global("lag_jkr_turretshielded");
	wait(3);
	level.burke dialogue_queue_global("lag_brk_flanktechnical");
	thread alley_flank_dialogue_nag();
	common_scripts\utility::flag_wait("flank_alley_complete");
	wait(1);
	level.burke dialogue_queue_global("lag_brk_decentwork");
	wait(1);
	thread highway_frogger_dialogue();
}

//Function Number: 44
alley_flank_dialogue_nag()
{
	wait(8);
	while(!common_scripts\utility::flag("done_flank_alley_flank_start"))
	{
		if(!common_scripts\utility::flag("done_flank_alley_flank_start"))
		{
			level.joker dialogue_queue_global("lag_jkr_getbehind");
			continue;
		}

		return;
		wait(20);
	}
}

//Function Number: 45
highway_frogger_dialogue()
{
	radio_dialogue_queue_global("lag_prpt_libertyhwy");
	wait(0.33);
	level.ajani dialogue_queue_global("lag_ajni_wereclosehere");
	wait(0.33);
	level.burke dialogue_queue_global("lag_gdn_needtogetoverthis");
	common_scripts\utility::flag_wait("trigger_start_frogger_kva");
	wait(1);
	level.burke dialogue_queue_global("lag_brk_getacross");
	thread highway_frogger_middle_ai_check();
	thread highway_frogger_middle_nag();
	common_scripts\utility::flag_wait("trigger_start_frogger_kva_B");
	level.burke dialogue_queue_global("lag_brk_watchyourself");
	thread highway_frogger_end_nag();
	common_scripts\utility::flag_wait("frogger_flag_player_end");
	wait(4);
	level.joker dialogue_queue_global("lag_jkr_roadkill");
}

//Function Number: 46
highway_frogger_middle_ai_check()
{
	common_scripts\utility::flag_wait("flag_frogger_middle_spawned");
	while(level.frogger_middle_guys.size > 0)
	{
		level.frogger_middle_guys = maps\_utility::array_removedead_or_dying(level.frogger_middle_guys);
		wait 0.05;
	}

	wait(1);
	if(!common_scripts\utility::flag("frogger_flag_player_middle"))
	{
		level.burke dialogue_queue_global("lag_gdn_clearcrossover");
	}
}

//Function Number: 47
highway_frogger_middle_nag()
{
	var_00 = 0;
	var_01 = 2;
	while(!common_scripts\utility::flag("frogger_flag_player_middle"))
	{
		wait(randomintrange(8,12));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("frogger_flag_player_middle"))
				{
					level.burke dialogue_queue_global("lag_gdn_getacrossthestreetmitchell2");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("frogger_flag_player_middle"))
				{
					level.burke dialogue_queue_global("lag_gdn_crossthestreet2");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 48
highway_frogger_end_nag()
{
	var_00 = 0;
	var_01 = 2;
	while(!common_scripts\utility::flag("frogger_flag_player_end"))
	{
		wait(randomintrange(10,15));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("frogger_flag_player_end"))
				{
					level.burke dialogue_queue_global("lag_gdn_getacrossthestreetmitchell2");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("frogger_flag_player_end"))
				{
					level.burke dialogue_queue_global("lag_gdn_crossthestreet2");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 49
highway_ledge_jump_prep_dialogue()
{
	level maps\_utility::dialogue_queue("lagos_prt_targettruckisapproachingyour");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_copythat");
	wait(2);
	level.burke dialogue_queue_global("lag_brk_onme");
	soundscripts\_snd::snd_message("lag_brk_onme_done");
	var_00 = 0;
	var_01 = 2;
	while(!common_scripts\utility::flag("done_traffic_ledge_jump_start"))
	{
		wait(randomintrange(5,11));
		switch(var_00)
		{
			case 0:
				if(!common_scripts\utility::flag("done_traffic_ledge_jump_start"))
				{
					level.burke dialogue_queue_global("lag_brk_mitchellhere");
				}
				break;

			case 1:
				if(!common_scripts\utility::flag("done_traffic_ledge_jump_start"))
				{
					level.burke dialogue_queue_global("lag_gdn_mitchellgetoverherenow");
				}
				break;
		}

		var_00++;
		if(var_00 >= var_01)
		{
			var_00 = 0;
		}
	}
}

//Function Number: 50
highway_ledge_jump_go_dialogue()
{
}

//Function Number: 51
traverse_start_you_should_have_eyes(param_00)
{
	radio_dialogue_queue_global("lag_prpt_eyesontruck");
}

//Function Number: 52
traverse_start_i_see_it(param_00)
{
}

//Function Number: 53
traverse_start_damn_no_clear_shot(param_00)
{
}

//Function Number: 54
traverse_start_fuck_it(param_00)
{
}

//Function Number: 55
highway_traffic_traverse_dialogue()
{
	radio_dialogue_queue_global("lag_jkr_whereyougo");
	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_followus");
	wait(0.33);
	radio_dialogue_queue_global("lag_jkr_rogerthat");
}

//Function Number: 56
highway_traffic_jump_2_dialogue()
{
	if(!common_scripts\utility::flag("flag_bus_traverse_2"))
	{
		level.burke dialogue_queue_global("lag_brk_readyjump");
	}

	wait(6.5);
	highway_traffic_traverse_dialogue();
}

//Function Number: 57
highway_traffic_jump_3_dialogue()
{
	if(!common_scripts\utility::flag("flag_bus_traverse_3"))
	{
		level.burke dialogue_queue_global("lag_brk_stayclose");
	}

	soundscripts\_snd::snd_message("lag_brk_stayclose_done");
}

//Function Number: 58
highway_traffic_jump_4_dialogue()
{
	if(!common_scripts\utility::flag("flag_bus_traverse_4"))
	{
		level.burke dialogue_queue_global("lag_brk_go");
	}
}

//Function Number: 59
highway_traffic_jump_5_dialogue()
{
	if(!common_scripts\utility::flag("flag_bus_traverse_5_start_takedown"))
	{
		level.burke dialogue_queue_global("lag_brk_jumpnow");
	}

	wait(0.33);
	level.burke dialogue_queue_global("lag_brk_thereitis");
}

//Function Number: 60
highway_traffic_takedown_dialogue()
{
	if(!common_scripts\utility::flag("takedown_playerstart"))
	{
		level.burke dialogue_queue_global("lag_brk_mitchelljump");
	}
}

//Function Number: 61
highway_traffic_first_suvs()
{
	wait(4);
	level.burke dialogue_queue_global("lag_brk_takeoutsuv");
}

//Function Number: 62
highway_traffic_middle_takedown_dialogue()
{
	wait(4);
	soundscripts\_snd::snd_message("lag_brk_takeoutsuv_done");
}

//Function Number: 63
highway_traffic_helo_callout()
{
	wait(2);
	level.burke dialogue_queue_global("lag_gdn_enemychoppertakeitdown2");
}

//Function Number: 64
highway_traffic_final_takedown_hold_on()
{
	wait(1);
	level.burke dialogue_queue_global("lag_gdn_holdon");
}

//Function Number: 65
level_bounds_nag_vo(param_00)
{
	switch(param_00)
	{
		case 0:
			level.burke dialogue_queue_global("lag_gdn_mitchellstayonmission2");
			break;

		case 1:
			level.burke dialogue_queue_global("lag_gdn_wherethehellareyou2");
			break;

		case 2:
			level.burke dialogue_queue_global("lag_brk_payattention");
			break;
	}
}

//Function Number: 66
dialogue_queue_global(param_00,param_01)
{
	if(isdefined(level.scr_sound[self.animname][param_00]) && soundexists(level.scr_sound[self.animname][param_00]))
	{
		global_dialogue_internal(param_00,self,param_01);
	}
}

//Function Number: 67
radio_dialogue_queue_global(param_00,param_01)
{
	if(isdefined(level.scr_radio[param_00]) && soundexists(level.scr_radio[param_00]))
	{
		global_dialogue_internal(param_00,undefined,param_01);
	}
}

//Function Number: 68
global_dialogue_internal(param_00,param_01,param_02)
{
	if(!isdefined(level.global_dialogue_function_stack))
	{
		level.global_dialogue_function_stack = spawnstruct();
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			level.global_dialogue_function_stack maps\_utility::function_stack_timeout(param_02,::global_dialogue_internal_play_dialogue,param_00,param_01);
			return;
		}

		level.global_dialogue_function_stack maps\_utility::function_stack(::global_dialogue_internal_play_dialogue,param_00,param_01);
		return;
	}

	if(isdefined(param_02))
	{
		level.global_dialogue_function_stack maps\_utility::function_stack_timeout(param_02,::global_dialogue_internal_play_radio,param_00);
		return;
	}

	level.global_dialogue_function_stack maps\_utility::function_stack(::global_dialogue_internal_play_radio,param_00);
}

//Function Number: 69
global_dialogue_internal_play_dialogue(param_00,param_01)
{
	if(isdefined(param_01))
	{
		common_scripts\utility::flag_set("dialogue_playing");
		maps\_utility::bcs_scripted_dialogue_start();
		param_01 maps\_anim::anim_single_queue(param_01,param_00);
		common_scripts\utility::flag_clear("dialogue_playing");
	}
}

//Function Number: 70
global_dialogue_internal_play_radio(param_00)
{
	common_scripts\utility::flag_set("dialogue_playing");
	level maps\_utility::dialogue_queue(param_00);
	common_scripts\utility::flag_clear("dialogue_playing");
}

//Function Number: 71
init_pcap_vo()
{
	thread init_pcap_vo_hostage_scene();
	thread init_pcap_vo_intro_briefing();
	thread init_pcap_vo_video_log();
	thread init_pcap_vo_hostage_breach();
	thread init_pcap_vo_freeway_jump_gideon();
	thread init_pcap_vo_truck_takedown();
}

//Function Number: 72
init_pcap_vo_hostage_scene()
{
	if(level.currentgen)
	{
		if(level.transient_zone != "intro")
		{
			return;
		}
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_flythrough_guy2,"aud_lag_start_hostage_scene",::lag_hostage_pm);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_flythrough_guy1,"aud_lag_start_hostage_scene",::lag_hostage_hades);
}

//Function Number: 73
init_pcap_vo_intro_briefing()
{
	if(level.currentgen)
	{
		if(level.transient_zone != "intro")
		{
			return;
		}
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_intro_briefing_burke,"aud_lag_intro_briefing_burke_start",::lag_intro_brief_gdn);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_intro_briefing_joker,"aud_lag_intro_briefing_joker_start",::lag_intro_brief_jkr);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_intro_briefing_ajani,"aud_lag_intro_briefing_ajani_start",::lag_intro_brief_ajn);
}

//Function Number: 74
init_pcap_vo_video_log()
{
	if(level.currentgen)
	{
		if(level.transient_zone != "intro")
		{
			return;
		}
	}
}

//Function Number: 75
init_pcap_vo_hostage_breach()
{
	if(level.currentgen)
	{
		if(level.transient_zone != "intro")
		{
			return;
		}
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_breach_pt1_burke,"aud_lag_pm_rescue",::lag_pm_rescue_pt1_gdn);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_breach_pt2_burke,"aud_lag_pm_rescue_02",::lag_pm_rescue_pt2_gdn);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_breach_pt2_guy2,"aud_lag_pm_rescue_02",::lag_pm_rescue_pt2_pm);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_gov_hostage_room_breach_pt2_guy3,"aud_lag_pm_rescue_02",::lag_pm_rescue_pt2_ajn);
}

//Function Number: 76
init_pcap_vo_freeway_jump_gideon()
{
	if(level.currentgen)
	{
		if(level.transient_zone != "intro")
		{
			return;
		}
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_pullbackfence_jump_burke_pt2,"aud_start_gideon_freeway_jump",::lag_freeway_jump_gideon);
}

//Function Number: 77
init_pcap_vo_truck_takedown()
{
	if(level.currentgen && level.transient_zone != "outro")
	{
		level waittill("tff_post_alley_to_outro");
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_truck_takedown_pt5_burke,"aud_lag_takedown_pt5_rescue_start",::lag_shore_rescue_burke);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_truck_takedown_pt5_ajani,"aud_lag_takedown_pt5_rescue_start_ajani",::lag_shore_rescue_ajani);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lag_truck_takedown_pt5_guy3,"aud_lag_takedown_pt5_rescue_start_joker",::lag_shore_rescue_joker);
}

//Function Number: 78
lag_hostage_pm(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_pmr_iamtheonlyperson",0.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_pmr_wealllivebygods",24.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_pmr_gasp",38);
}

//Function Number: 79
lag_hostage_hades(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_hade_wearemenborntodie",12.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_hade_youaremistaken",33.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_hade_itwillachieveagreat",41.12);
}

//Function Number: 80
lag_intro_brief_gdn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_brk_throwsspanner",1.21);
	level maps\_utility::delaythread(4.8,::maps\_utility::dialogue_queue,"lagos_prt_copyatlastwooneyouhave");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_brk_threemikestophaseline",9.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_theyllkillhimanyway",13.06);
}

//Function Number: 81
lag_intro_brief_jkr(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_jkr_waitforsundown",7.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_jkr_losecherry",16.09);
}

//Function Number: 82
lag_intro_brief_ajn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_brk_ifweattacknowtheyll",11);
}

//Function Number: 83
lag_video_log_irs(param_00)
{
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("lag_irs_letsshowthemwhatatlas2",2.21);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("lag_irs_ahandshakewiththeprime",10);
	level.burke maps\_utility::delaythread(17,::dialogue_queue_global,"lag_brk_pressure");
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("lag_irns_goodluck",19.09);
}

//Function Number: 84
lag_pm_rescue_pt1_gdn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_atlasrescueforcenobodymove",5.15);
	wait(9);
	harmonic_breach_secure_pm();
}

//Function Number: 85
lag_pm_rescue_pt2_gdn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_ajani",5.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_color",9.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_position",12.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_alrightletsmove",16);
}

//Function Number: 86
lag_pm_rescue_pt2_pm(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_pmr_theyvetakenallofthe2",0);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_pmr_thetechnologistsfromoursummit",1.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_pmr_thekvawantedthemnot",3.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_pmr_thankyousoldier",21.03);
	soundscripts\_snd::snd_message("leaving_gov_building_post_vo");
}

//Function Number: 87
lag_pm_rescue_pt2_ajn(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_ajn_ehehwhat",6.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_ajn_ehehwhawhatcolor",10.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_ajn_whawhere",13.09);
}

//Function Number: 88
lag_freeway_jump_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_brk_iseeit",4.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_brk_nocleanshot",6.27,"lag_brk_nocleanshot_done");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_brk_fuckit",9.06);
	thread start_freeway_music();
}

//Function Number: 89
start_freeway_music()
{
	level waittill("lag_brk_nocleanshot_done");
	soundscripts\_snd::snd_message("lag_brk_nocleanshot_done");
}

//Function Number: 90
lag_shore_rescue_burke(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_oyenodozing",0.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_stopstessinghesbreathingbarely",8.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_dontknowdontcare2",13.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_drinksonmetonight",21.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lag_gdn_youdidalrightmitchell",25.15);
}

//Function Number: 91
lag_shore_rescue_ajani(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_ajn_youdeliveredexactlyaspromised",18.12);
}

//Function Number: 92
lag_shore_rescue_joker(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_jkr_pleasetellmehesfuckin",6.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lagos_jkr_thehelltheywantwith",11.18);
}