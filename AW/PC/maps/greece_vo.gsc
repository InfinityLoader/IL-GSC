/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 169 ms
 * Timestamp: 4/22/2024 2:31:36 AM
*******************************************************************/

//Function Number: 1
main()
{
	setupdialogue();
	thread init_pcap_vo();
}

//Function Number: 2
setupdialogue()
{
	var_00 = "Test";
	var_01 = "Gideon";
	var_02 = "Ilona";
	var_03 = "KVA_Soldier";
	var_04 = "Prophet";
	var_05 = "Hades";
	var_06 = "Victim";
	var_07 = "planner_right";
	var_08 = "planner_left";
	var_09 = "pacing_guard";
	var_0A = "Bartender";
	var_0B = "TouristMan";
	var_0C = "TouristWoman";
	var_0D = "CafeWoman";
	var_0E = "CafeMan";
	var_0F = "MarketMan";
	var_10 = "MarketWoman";
	var_11 = "MerchantMan";
	var_12 = "MerchantWoman";
	var_13 = "Civillian";
	var_14 = "Torres";
	level.scr_radio["grk_prp_bravostandby"] = "grk_prp_bravostandby";
	level.scr_radio["grk_gdn_alphahaseyes"] = "grk_gdn_alphahaseyes";
	level.scr_radio["grk_prp_copythatalpha"] = "grk_prp_copythatalpha";
	level.scr_radio["grk_iln_yourdateis"] = "grk_iln_yourdateis";
	level.scr_radio["grk_gdn_sorrytointerrupt"] = "grk_gdn_sorrytointerrupt";
	level.scr_sound[var_02]["grk_iln_andwhatdoesthat"] = "grk_iln_andwhatdoesthat";
	level.scr_radio["gre_prp_intiateuplink"] = "gre_prp_intiateuplink";
	level.scr_sound[var_02]["grk_iln_weseehim"] = "grk_iln_weseehim";
	level.scr_radio["gre_gdn_youtappedthecamera"] = "gre_gdn_youtappedthecamera";
	level.scr_radio["gre_prp_uplinkisgood"] = "gre_prp_uplinkisgood";
	level.scr_sound[var_02]["gre_iln_KVAcellphones"] = "gre_iln_KVAcellphones";
	level.scr_sound[var_02]["gre_iln_goodnowwejust"] = "gre_iln_goodnowwejust";
	level.scr_sound[var_02]["gre_iln_makeitquick"] = "gre_iln_makeitquick";
	level.scr_sound[var_02]["gre_iln_shityoupinged"] = "gre_iln_shityoupinged";
	level.scr_sound[var_02]["gre_iln_therecheckhim"] = "gre_iln_therecheckhim";
	level.scr_sound[var_02]["gre_iln_tryhim"] = "gre_iln_tryhim";
	level.scr_sound[var_02]["gre_iln_signalisclose"] = "gre_iln_signalisclose";
	level.scr_sound[var_02]["gre_iln_negativem"] = "gre_iln_negativem";
	level.scr_sound[var_02]["gre_iln_keymanisinhis"] = "gre_iln_keymanisinhis";
	level.scr_sound[var_02]["gre_iln_nomatchmove"] = "gre_iln_nomatchmove";
	level.scr_sound[var_02]["gre_iln_notkva"] = "gre_iln_notkva";
	level.scr_sound[var_02]["gre_iln_notamatch"] = "gre_iln_notamatch";
	level.scr_sound[var_02]["gre_iln_keeplooking"] = "gre_iln_keeplooking";
	level.scr_sound[var_02]["gre_iln_tryswitching"] = "gre_iln_tryswitching";
	level.scr_sound[var_02]["gre_iln_hesnothere"] = "gre_iln_hesnothere";
	level.scr_radio["grk_prp_positiveid"] = "grk_prp_positiveid";
	level.scr_sound[var_02]["grk_iln_findhim"] = "grk_iln_findhim";
	level.scr_sound[var_02]["grk_iln_whyhaventyou"] = "grk_iln_whyhaventyou";
	level.scr_sound[var_02]["grk_iln_weregoingtolose"] = "grk_iln_weregoingtolose";
	level.scr_radio["grk_prp_bravobeadvised"] = "grk_prp_bravobeadvised";
	level.scr_radio["grk_prp_braveyouneed"] = "grk_prp_braveyouneed";
	level.scr_radio["grk_prp_waitingonbravo"] = "grk_prp_waitingonbravo";
	level.scr_radio["grk_prp_bravoyourenot"] = "grk_prp_bravoyourenot";
	level.scr_radio["grk_prp_bravobeadvisedthe"] = "grk_prp_bravobeadvisedthe";
	level.scr_radio["grk_prp_allteamsbeadvised"] = "grk_prp_allteamsbeadvised";
	level.scr_radio["grk_prp_bravoyouarelagging"] = "grk_prp_bravoyouarelagging";
	level.scr_radio["grk_prp_bravoyouneedtoget"] = "grk_prp_bravoyouneedtoget";
	level.scr_radio["grk_prp_bravobeadvisedyour"] = "grk_prp_bravobeadvisedyour";
	level.scr_sound[var_02]["grk_iln_mitchellhurryup"] = "grk_iln_mitchellhurryup";
	level.scr_sound[var_02]["grk_iln_mitchtellgetmoving"] = "grk_iln_mitchtellgetmoving";
	level.scr_sound[var_02]["grk_iln_thatsourticket"] = "grk_iln_thatsourticket";
	level.scr_radio["grk_gdn_dontcockthis"] = "grk_gdn_dontcockthis";
	level.scr_radio["grk_iln_haventlostafish"] = "grk_iln_haventlostafish";
	level.scr_radio["grk_gdn_yesmaam"] = "grk_gdn_yesmaam";
	level.scr_radio["gre_irs_teamidontneedto"] = "gre_irs_teamidontneedto";
	level.scr_radio["gre_irs_teamidontneedtotoo"] = "gre_irs_teamidontneedtotoo";
	level.scr_sound[var_02]["grk_iln_followthefirst"] = "grk_iln_followthefirst";
	level.scr_sound[var_02]["grk_iln_illclearoutthe"] = "grk_iln_illclearoutthe";
	level.scr_sound[var_02]["grk_iln_prophetkeepeyes"] = "grk_iln_prophetkeepeyes";
	level.scr_radio["grk_prp_copythat"] = "grk_prp_copythat";
	level.scr_radio["gre_prp_keymanhasleftarea"] = "gre_prp_keymanhasleftarea";
	level.scr_sound[var_02]["gre_iln_keymanslipped"] = "gre_iln_keymanslipped";
	level.scr_sound[var_02]["gre_iln_welosteyesonkey"] = "gre_iln_welosteyesonkey";
	level.scr_radio["grk_prp_bravothereisnotime"] = "grk_prp_bravothereisnotime";
	level.scr_radio["grk_prp_bravoyourtargetis"] = "grk_prp_bravoyourtargetis";
	level.scr_radio["grk_iln_whatareyoudoing"] = "grk_iln_whatareyoudoing";
	level.scr_sound[var_06]["grk_kva_thisisprivate"] = "grk_kva_thisisprivate";
	level.scr_sound[var_02]["grk_iln_imlookingfor"] = "grk_iln_imlookingfor";
	level.scr_sound[var_06]["grk_kva_itsnothere"] = "grk_kva_itsnothere";
	level.scr_sound[var_02]["grk_iln_canyouatleast"] = "grk_iln_canyouatleast";
	level.scr_sound[var_06]["grk_kva_nostaywhereyou"] = "grk_kva_nostaywhereyou";
	level.scr_radio["grk_prp_bravostayonhim"] = "grk_prp_bravostayonhim";
	level.scr_radio["grk_prp_bravoyourwindow"] = "grk_prp_bravoyourwindow";
	level.scr_radio["grk_prp_braveotaketheguard"] = "grk_prp_braveotaketheguard";
	level.scr_sound[var_02]["grk_iln_nicework"] = "grk_iln_nicework";
	level.scr_sound[var_02]["grk_iln_bravohaskey"] = "grk_iln_bravohaskey";
	level.scr_sound[var_02]["grk_iln_dammitmitchell"] = "grk_iln_dammitmitchell";
	level.scr_sound[var_02]["grk_iln_youjustblew"] = "grk_iln_youjustblew";
	level.scr_radio["grk_prp_abortthemission"] = "grk_prp_abortthemission";
	level.scr_sound[var_02]["grk_iln_weaponsready"] = "grk_iln_weaponsready";
	level.scr_radio["grk_prp_bravohasentered"] = "grk_prp_bravohasentered";
	level.scr_radio["grk_gdn_rogerdodger"] = "grk_gdn_rogerdodger";
	level.scr_sound[var_02]["grk_iln_rollingtheyes"] = "grk_iln_rollingtheyes";
	level.scr_sound[var_02]["grk_iln_patroltakehim"] = "grk_iln_patroltakehim";
	level.scr_sound[var_02]["grk_iln_mineyminemine"] = "grk_iln_mineyminemine";
	level.scr_sound[var_07]["grk_kva_makesurethe"] = "grk_kva_makesurethe";
	level.scr_sound[var_08]["grk_kva_thereisablind"] = "grk_kva_thereisablind";
	level.scr_sound[var_02]["grk_iln_twointhenext"] = "grk_iln_twointhenext";
	level.scr_sound[var_02]["grk_iln_chooseyourtarget"] = "grk_iln_chooseyourtarget";
	level.scr_sound[var_02]["grk_iln_upstairs"] = "grk_iln_upstairs";
	level.scr_sound[var_09]["grk_kva_allstationswill"] = "grk_kva_allstationswill";
	level.scr_radio["grk_hds_ithadbetter"] = "grk_hds_ithadbetter";
	level.scr_sound[var_09]["grk_kva_understood"] = "grk_kva_understood";
	level.scr_radio["grk_hds_hadesout"] = "grk_hds_hadesout";
	level.scr_sound[var_02]["grk_iln_waitforthefinish"] = "grk_iln_waitforthefinish";
	level.scr_sound[var_02]["grk_iln_now"] = "grk_iln_now";
	level.scr_sound[var_02]["grk_iln_takehimmitchell"] = "grk_iln_takehimmitchell";
	level.scr_sound[var_02]["grk_iln_prophetsafehouseis"] = "grk_iln_prophetsafehouseis";
	level.scr_radio["grk_prp_copythatbravoproceed"] = "grk_prp_copythatbravoproceed";
	level.scr_radio["grk_prp_loadinguppartybus"] = "grk_prp_loadinguppartybus";
	level.scr_sound[var_02]["grk_iln_putonyourexosuit"] = "grk_iln_putonyourexosuit";
	level.scr_sound[var_02]["grk_iln_yourexosisfit"] = "grk_iln_yourexosisfit";
	level.scr_sound[var_02]["grk_iln_tryyoursonics"] = "grk_iln_tryyoursonics";
	level.scr_sound[var_02]["grk_iln_deployyoursonics"] = "grk_iln_deployyoursonics";
	level.scr_sound[var_02]["grk_iln_useyoursonics"] = "grk_iln_useyoursonics";
	level.scr_sound[var_02]["grk_iln_stuneemwith"] = "grk_iln_stuneemwith";
	level.scr_sound[var_02]["grk_iln_blastthatgate"] = "grk_iln_blastthatgate";
	level.scr_sound[var_02]["grk_iln_ithastorecharge"] = "grk_iln_ithastorecharge";
	level.scr_sound[var_02]["grk_iln_letitrecharge"] = "grk_iln_letitrecharge";
	level.scr_sound[var_02]["grk_iln_getmovinghades"] = "grk_iln_getmovinghades";
	level.scr_sound[var_02]["grk_iln_timetogearup"] = "grk_iln_timetogearup";
	level.scr_sound[var_06]["grk_kva_hey"] = "grk_kva_hey";
	level.scr_sound[var_06]["grk_kva_whatthe"] = "grk_kva_whatthe";
	level.scr_sound[var_06]["grk_kva_shitintruders"] = "grk_kva_shitintruders";
	level.scr_sound[var_02]["grk_iln_prophetwaspready"] = "grk_iln_prophetwaspready";
	level.scr_radio["grk_gdn_alphainposition"] = "grk_gdn_alphainposition";
	level.scr_radio["grk_prp_copythatstandby"] = "grk_prp_copythatstandby";
	level.scr_sound[var_02]["grk_iln_takethedroneears"] = "grk_iln_takethedroneears";
	level.scr_sound[var_02]["grk_iln_takethedrone"] = "grk_iln_takethedrone";
	level.scr_radio["grk_prp_waspisairborne"] = "grk_prp_waspisairborne";
	level.scr_radio["grk_prp_50meterstotarget"] = "grk_prp_50meterstotarget";
	level.scr_radio["grk_iln_theregotavisual"] = "grk_iln_theregotavisual";
	level.scr_radio["gre_gdn_easyilona"] = "gre_gdn_easyilona";
	level.scr_radio["grk_prp_waspinposition"] = "grk_prp_waspinposition";
	level.scr_radio["grk_iln_goblackuntil"] = "grk_iln_goblackuntil";
	level.scr_radio["grk_iln_youllneedtoneut"] = "grk_iln_youllneedtoneut";
	level.scr_radio["grk_iln_wasptostart"] = "grk_iln_wasptostart";
	level.scr_radio["grk_kva_heyyou"] = "grk_kva_heyyou";
	level.scr_radio["grk_kva_youcannotpark"] = "grk_kva_youcannotpark";
	level.scr_radio["grk_gdn_thisisnt14"] = "grk_gdn_thisisnt14";
	level.scr_radio["grk_kva_thisstreetisoff"] = "grk_kva_thisstreetisoff";
	level.scr_radio["grk_gdn_butwehave"] = "grk_gdn_butwehave";
	level.scr_radio["grk_kva_idontcare"] = "grk_kva_idontcare";
	level.scr_radio["grk_iln_clear"] = "grk_iln_clear";
	level.scr_radio["grk_gdn_alphaatthedoor"] = "grk_gdn_alphaatthedoor";
	level.scr_radio["grk_iln_takeemout"] = "grk_iln_takeemout";
	level.scr_radio["grk_iln_shootheeyes"] = "grk_iln_shootheeyes";
	level.scr_radio["grk_iln_nowtaketheone"] = "grk_iln_nowtaketheone";
	level.scr_radio["grk_kva_somethingsnotright"] = "grk_kva_somethingsnotright";
	level.scr_radio["grk_prp_bravoyouretaking"] = "grk_prp_bravoyouretaking";
	level.scr_radio["grk_kva_dimitriisthat"] = "grk_kva_dimitriisthat";
	level.scr_radio["grk_kva_report"] = "grk_kva_report";
	level.scr_radio["grk_iln_alphamovein"] = "grk_iln_alphamovein";
	level.scr_radio["grk_gdn_holdupnow"] = "grk_gdn_holdupnow";
	level.scr_radio["grk_gdn_courtyardclear"] = "grk_gdn_courtyardclear";
	level.scr_radio["grk_kva_nowehavent"] = "grk_kva_nowehavent";
	level.scr_radio["grk_iln_nowmitchell"] = "grk_iln_nowmitchell";
	level.scr_radio["grk_iln_youhaveanother"] = "grk_iln_youhaveanother";
	level.scr_radio["grk_gdn_holding"] = "grk_gdn_holding";
	level.scr_radio["grk_iln_itsclearalpha"] = "grk_iln_itsclearalpha";
	level.scr_radio["grk_iln_ifyouvegotaclear"] = "grk_iln_ifyouvegotaclear";
	level.scr_radio["grk_iln_remindmenot"] = "grk_iln_remindmenot";
	level.scr_radio["grk_gdn_poolisclear"] = "grk_gdn_poolisclear";
	level.scr_radio["grk_gdn_alphayolo"] = "grk_gdn_alphayolo";
	level.scr_radio["grk_gdn_shit"] = "grk_gdn_shit";
	level.scr_radio["grk_iln_Gideonisintrouble"] = "grk_iln_Gideonisintrouble";
	level.scr_radio["grk_gdn_thanksforthe"] = "grk_gdn_thanksforthe";
	level.scr_radio["grk_gdn_thatwasaclose"] = "grk_gdn_thatwasaclose";
	level.scr_radio["grk_gdn_movingup"] = "grk_gdn_movingup";
	level.scr_radio["grk_iln_mandownthey"] = "grk_iln_mandownthey";
	level.scr_radio["grk_gdn_placingmute"] = "grk_gdn_placingmute";
	level.scr_radio["grk_iln_copythatalpha"] = "grk_iln_copythatalpha";
	level.scr_radio["grk_iln_mitchellmovethe"] = "grk_iln_mitchellmovethe";
	level.scr_radio["grk_iln_jumpthegun"] = "grk_iln_jumpthegun";
	level.scr_radio["grk_iln_nextimewaitidiot"] = "grk_iln_nextimewaitidiot";
	level.scr_radio["grk_gdn_mutechargeready"] = "grk_gdn_mutechargeready";
	level.scr_radio["grk_iln_rememberthecharge"] = "grk_iln_rememberthecharge";
	level.scr_radio["grk_iln_initiatemutecharge"] = "grk_iln_initiatemutecharge";
	level.scr_radio["grk_iln_mitchwhenyourready"] = "grk_iln_mitchwhenyourready";
	level.scr_radio["grk_iln_thatwassome"] = "grk_iln_thatwassome";
	level.scr_radio["grk_iln_younearlyblew"] = "grk_iln_younearlyblew";
	level.scr_radio["grk_iln_mutechargeexpire"] = "grk_iln_mutechargeexpire";
	level.scr_radio["grk_gdn_atriumisclear"] = "grk_gdn_atriumisclear";
	level.scr_radio["grk_prp_allstationsbeadvised"] = "grk_prp_allstationsbeadvised";
	level.scr_radio["grk_iln_prophetpleaseclarify"] = "grk_iln_prophetpleaseclarify";
	level.scr_radio["grk_gdn_copythat"] = "grk_gdn_copythat";
	level.scr_radio["grk_iln_twoonftheroof"] = "grk_iln_twoonftheroof";
	level.scr_radio["grk_iln_dropthemall"] = "grk_iln_dropthemall";
	level.scr_radio["grk_iln_killconfirmed"] = "grk_iln_killconfirmed";
	level.scr_radio["grk_iln_weneedtopull"] = "grk_iln_weneedtopull";
	level.scr_radio["grk_iln_dropemalph"] = "grk_iln_dropemalph";
	level.scr_radio["grk_iln_mitchelltripthecar"] = "grk_iln_mitchelltripthecar";
	level.scr_radio["grk_kva_letscheckit"] = "grk_kva_letscheckit";
	level.scr_radio["grk_gdn_kvaismoving"] = "grk_gdn_kvaismoving";
	level.scr_radio["grk_iln_alphatakeout"] = "grk_iln_alphatakeout";
	level.scr_radio["grk_gdn_stairsareclear"] = "grk_gdn_stairsareclear";
	level.scr_radio["grk_kva_nothinghere"] = "grk_kva_nothinghere";
	level.scr_radio["grk_iln_doitmitchell"] = "grk_iln_doitmitchell";
	level.scr_radio["grk_iln_remembernoone"] = "grk_iln_remembernoone";
	level.scr_radio["grk_iln_shootthosein"] = "grk_iln_shootthosein";
	level.scr_radio["grk_iln_shootintheback"] = "grk_iln_shootintheback";
	level.scr_radio["grk_iln_shootbacktofront"] = "grk_iln_shootbacktofront";
	level.scr_radio["grk_gdn_clearalphasetting"] = "grk_gdn_clearalphasetting";
	level.scr_radio["grk_prp_coverisblown"] = "grk_prp_coverisblown";
	level.scr_radio["grk_prp_waspyouvebeenspotted"] = "grk_prp_waspyouvebeenspotted";
	level.scr_radio["grk_iln_mitchellwaituntil"] = "grk_iln_mitchellwaituntil";
	level.scr_radio["grk_gdn_waitingonwasp"] = "grk_gdn_waitingonwasp";
	level.scr_radio["grk_iln_taketheshot"] = "grk_iln_taketheshot";
	level.scr_radio["grk_prp_bravoalphaiswaiting"] = "grk_prp_bravoalphaiswaiting";
	level.scr_radio["grk_gdn_pickupthepace"] = "grk_gdn_pickupthepace";
	level.scr_radio["grk_gdn_niceshot"] = "grk_gdn_niceshot";
	level.scr_radio["grk_iln_targetdown"] = "grk_iln_targetdown";
	level.scr_radio["grk_prp_thatsakill"] = "grk_prp_thatsakill";
	level.scr_radio["grk_iln_goodwork"] = "grk_iln_goodwork";
	level.scr_radio["grk_prp_killconfirmed"] = "grk_prp_killconfirmed";
	level.scr_radio["grk_iln_tightenitup"] = "grk_iln_tightenitup";
	level.scr_radio["grk_iln_youneedtobefaster"] = "grk_iln_youneedtobefaster";
	level.scr_radio["grk_iln_sloppybutyougot"] = "grk_iln_sloppybutyougot";
	level.scr_radio["grk_gdn_sticktoyour"] = "grk_gdn_sticktoyour";
	level.scr_radio["grk_gdn_mitchellwhat"] = "grk_gdn_mitchellwhat";
	level.scr_radio["grk_iln_thatsnotyourtarget"] = "grk_iln_thatsnotyourtarget";
	level.scr_radio["grk_prp_alphaneedsawasp"] = "grk_prp_alphaneedsawasp";
	level.scr_radio["grk_iln_droptheguard"] = "grk_iln_droptheguard";
	level.scr_radio["grk_gdn_dontlethimsound"] = "grk_gdn_dontlethimsound";
	level.scr_radio["grk_iln_oneoftheguard"] = "grk_iln_oneoftheguard";
	level.scr_radio["grk_iln_geteyesonhades"] = "grk_iln_geteyesonhades";
	level.scr_radio["grk_iln_autotranslation"] = "grk_iln_autotranslation";
	level.scr_radio["grk_prp_copythattranslation"] = "grk_prp_copythattranslation";
	level.scr_radio["grk_iln_lineuphades"] = "grk_iln_lineuphades";
	level.scr_radio["grk_iln_holdfireuntil"] = "grk_iln_holdfireuntil";
	level.scr_radio["grk_iln_allteamsstand"] = "grk_iln_allteamsstand";
	level.scr_radio["grk_kva_thisdoctorwill"] = "grk_kva_thisdoctorwill";
	level.scr_radio["grk_hds_whatdoyouknow"] = "grk_hds_whatdoyouknow";
	level.scr_radio["grk_hds_wehavesecured"] = "grk_hds_wehavesecured";
	level.scr_radio["grk_hds_youhavetwo"] = "grk_hds_youhavetwo";
	level.scr_radio["grk_iln_thatsitwasp"] = "grk_iln_thatsitwasp";
	level.scr_radio["grk_kva_thatposes"] = "grk_kva_thatposes";
	level.scr_radio["grk_hds_youwilldothis"] = "grk_hds_youwilldothis";
	level.scr_radio["grk_hds_hefindsno"] = "grk_hds_hefindsno";
	level.scr_radio["grk_kva_myapologies"] = "grk_kva_myapologies";
	level.scr_radio["grk_hds_wehavecome"] = "grk_hds_wehavecome";
	level.scr_radio["grk_iln_mitchellshoothades"] = "grk_iln_mitchellshoothades";
	level.scr_radio["grk_iln_hadesisdown"] = "grk_iln_hadesisdown";
	level.scr_radio["grk_gdn_scanningretina"] = "grk_gdn_scanningretina";
	level.scr_radio["grk_sld_shithesrigged"] = "grk_sld_shithesrigged";
	level.scr_radio["grk_prp_alphareport"] = "grk_prp_alphareport";
	level.scr_radio["grk_gdn_abodydouble"] = "grk_gdn_abodydouble";
	level.scr_radio["grk_iln_gotastamp"] = "grk_iln_gotastamp";
	level.scr_radio["grk_prp_beadvisedkvaonroof"] = "grk_prp_beadvisedkvaonroof";
	level.scr_radio["grk_gdn_waspweneed"] = "grk_gdn_waspweneed";
	level.scr_radio["grk_prp_enemytechinbound"] = "grk_prp_enemytechinbound";
	level.scr_radio["grk_gdn_weneedcovering"] = "grk_gdn_weneedcovering";
	level.scr_radio["grk_iln_getonitmitchell"] = "grk_iln_getonitmitchell";
	level.scr_radio["grk_gdn_wecantjustsit"] = "grk_gdn_wecantjustsit";
	level.scr_radio["grk_iln_therealhades"] = "grk_iln_therealhades";
	level.scr_radio["grk_prp_allteamsvehicle"] = "grk_prp_allteamsvehicle";
	level.scr_radio["grk_iln_thesourcetruck"] = "grk_iln_thesourcetruck";
	level.scr_radio["grk_gdn_shitmorekva"] = "grk_gdn_shitmorekva";
	level.scr_radio["grk_iln_whatusthappened"] = "grk_iln_whatusthappened";
	level.scr_sound[var_02]["grk_iln_ivelostvisual"] = "grk_iln_ivelostvisual";
	level.scr_radio["grk_prp_allstationsabort"] = "grk_prp_allstationsabort";
	level.scr_sound[var_02]["grk_iln_shitweneed"] = "grk_iln_shitweneed";
	level.scr_radio["grk_prp_allteamsonhades"] = "grk_prp_allteamsonhades";
	level.scr_sound[var_02]["grk_iln_downthestairs"] = "grk_iln_downthestairs";
	level.scr_radio["grk_prp_beadvisedkvahas"] = "grk_prp_beadvisedkvahas";
	level.scr_sound[var_02]["grk_iln_mitchellonme"] = "grk_iln_mitchellonme";
	level.scr_sound[var_03]["grk_kva_theyreinthesafe"] = "grk_kva_theyreinthesafe";
	level.scr_sound[var_02]["grk_iln_popyoursonics"] = "grk_iln_popyoursonics";
	level.scr_sound[var_02]["grk_iln_thatclearedthem"] = "grk_iln_thatclearedthem";
	level.scr_sound[var_02]["grk_iln_comeonwell"] = "grk_iln_comeonwell";
	level.scr_radio["grk_prp_bravowelostcom"] = "grk_prp_bravowelostcom";
	level.scr_sound[var_02]["grk_iln_thesetourists"] = "grk_iln_thesetourists";
	level.scr_sound[var_02]["grk_iln_outoftheway"] = "grk_iln_outoftheway";
	level.scr_radio["grk_prp_kvaclosingin"] = "grk_prp_kvaclosingin";
	level.scr_sound[var_03]["grk_kva_theretheyarewhat"] = "grk_kva_theretheyarewhat";
	level.scr_sound[var_02]["grk_iln_watchyouraim"] = "grk_iln_watchyouraim";
	level.scr_sound[var_02]["grk_iln_shitKVA"] = "grk_iln_shitKVA";
	level.scr_sound[var_02]["grk_iln_wecantkeep"] = "grk_iln_wecantkeep";
	level.scr_sound[var_02]["grk_iln_rocketstakeem"] = "grk_iln_rocketstakeem";
	level.scr_sound[var_02]["grk_iln_alphaton"] = "grk_iln_alphaton";
	level.scr_radio["grk_gdn_werecrawlingwith"] = "grk_gdn_werecrawlingwith";
	level.scr_sound[var_02]["grk_iln_rogerthatroger"] = "grk_iln_rogerthatroger";
	level.scr_sound[var_02]["gre_iln_theyrepullingback"] = "gre_iln_theyrepullingback";
	level.scr_sound[var_02]["gre_iln_theyreclearingout"] = "gre_iln_theyreclearingout";
	level.scr_sound[var_02]["gre_iln_watchthecorners"] = "gre_iln_watchthecorners";
	level.scr_sound[var_02]["gre_iln_clearitoutyo"] = "gre_iln_clearitoutyo";
	level.scr_sound[var_02]["gre_iln_morkvam"] = "gre_iln_morkvam";
	level.scr_sound[var_02]["gre_iln_enemycantspell"] = "gre_iln_enemycantspell";
	level.scr_sound[var_02]["gre_iln_ontheroofm"] = "gre_iln_ontheroofm";
	level.scr_sound[var_02]["gre_iln_onthebalconym"] = "gre_iln_onthebalconym";
	level.scr_sound[var_02]["gre_iln_windowgroundfloor"] = "gre_iln_windowgroundfloor";
	level.scr_sound[var_02]["gre_iln_windowsecondfloor"] = "gre_iln_windowsecondfloor";
	level.scr_sound[var_02]["gre_iln_checkthecafe"] = "gre_iln_checkthecafe";
	level.scr_sound[var_02]["gre_iln_onthestairs"] = "gre_iln_onthestairs";
	level.scr_sound[var_02]["gre_iln_niceshotm"] = "gre_iln_niceshotm";
	level.scr_sound[var_02]["gre_iln_gothimm"] = "gre_iln_gothimm";
	level.scr_sound[var_02]["gre_iln_goodhitm"] = "gre_iln_goodhitm";
	level.scr_sound[var_02]["gre_iln_goodkillm"] = "gre_iln_goodkillm";
	level.scr_sound[var_02]["gre_iln_mitchellonmem"] = "gre_iln_mitchellonmem";
	level.scr_sound[var_02]["gre_iln_stayclosem"] = "gre_iln_stayclosem";
	level.scr_sound[var_02]["gre_iln_followmem"] = "gre_iln_followmem";
	level.scr_sound[var_02]["gre_iln_letsmovem"] = "gre_iln_letsmovem";
	level.scr_sound[var_02]["gre_iln_thiswaym"] = "gre_iln_thiswaym";
	level.scr_sound[var_02]["gre_iln_givemeapplause"] = "gre_iln_givemeapplause";
	level.scr_radio["gre_prp_twomikesout"] = "gre_prp_twomikesout";
	level.scr_sound[var_02]["gre_iln_moveinterceptyo"] = "gre_iln_moveinterceptyo";
	level.scr_sound[var_02]["gre_iln_helpmewithtruck"] = "gre_iln_helpmewithtruck";
	level.scr_sound[var_02]["gre_iln_truckouttaway"] = "gre_iln_truckouttaway";
	level.scr_sound[var_02]["gre_iln_setupambushthere"] = "gre_iln_setupambushthere";
	level.scr_sound[var_02]["gre_iln_clearoutplease"] = "gre_iln_clearoutplease";
	level.scr_radio["gre_prp_hadesinboundminute"] = "gre_prp_hadesinboundminute";
	level.scr_sound[var_02]["gre_iln_placechargesbitch"] = "gre_iln_placechargesbitch";
	level.scr_sound[var_02]["gre_iln_hurrybitch"] = "gre_iln_hurrybitch";
	level.scr_sound[var_02]["gre_iln_findcoverandwaitplease"] = "gre_iln_findcoverandwaitplease";
	level.scr_sound[var_02]["gre_iln_readyplease"] = "gre_iln_readyplease";
	level.scr_sound[var_02]["gre_iln_nowplease"] = "gre_iln_nowplease";
	level.scr_sound[var_02]["gre_iln_pushfowardcontain"] = "gre_iln_pushfowardcontain";
	level.scr_sound[var_02]["gre_iln_jumpdownbeotch"] = "gre_iln_jumpdownbeotch";
	level.scr_sound[var_02]["gre_iln_movemitchmoveplease"] = "gre_iln_movemitchmoveplease";
	level.scr_sound[var_02]["gre_iln_jumpmitchplease"] = "gre_iln_jumpmitchplease";
	level.scr_sound[var_02]["gre_iln_outoftimeplease"] = "gre_iln_outoftimeplease";
	level.scr_sound[var_02]["gre_iln_isaidplacecharges"] = "gre_iln_isaidplacecharges";
	level.scr_sound[var_02]["gre_iln_anysecondplease"] = "gre_iln_anysecondplease";
	level.scr_sound[var_02]["gre_iln_hadesisgettingood"] = "gre_iln_hadesisgettingood";
	level.scr_radio["gre_gdn_donotletupplease"] = "gre_gdn_donotletupplease";
	level.scr_sound[var_02]["gre_iln_watchtheflames"] = "gre_iln_watchtheflames";
	level.scr_sound[var_02]["gre_iln_pushforwardyojoe"] = "gre_iln_pushforwardyojoe";
	level.scr_sound[var_02]["gre_iln_eyesonvehiclealmost"] = "gre_iln_eyesonvehiclealmost";
	level.scr_sound[var_02]["gre_iln_makesurestreets"] = "gre_iln_makesurestreets";
	level.scr_sound[var_02]["gre_iln_streetsareclearplease"] = "gre_iln_streetsareclearplease";
	level.scr_radio["gre_prp_goodhunting"] = "gre_prp_goodhunting";
	level.scr_sound[var_02]["gre_iln_dothehonor"] = "gre_iln_dothehonor";
	level.scr_sound[var_02]["gre_iln_mitchpleaselook"] = "gre_iln_mitchpleaselook";
	level.scr_sound[var_02]["gre_iln_gonnaopenorwhat"] = "gre_iln_gonnaopenorwhat";
	level.scr_sound[var_02]["gre_iln_waitingonurban"] = "gre_iln_waitingonurban";
	level.scr_sound[var_02]["gre_iln_openthefuck"] = "gre_iln_openthefuck";
	level.scr_sound[var_02]["gre_iln_nowfuckmitchell"] = "gre_iln_nowfuckmitchell";
	level.scr_sound[var_02]["gre_iln_gotbastardyes"] = "gre_iln_gotbastardyes";
	level.scr_sound[var_02]["gre_iln_timewentdown"] = "gre_iln_timewentdown";
	level.scr_sound[var_02]["gre_iln_movewellcut"] = "gre_iln_movewellcut";
	level.scr_sound[var_02]["gre_iln_snipertop"] = "gre_iln_snipertop";
	level.scr_sound[var_02]["gre_iln_popsmoke"] = "gre_iln_popsmoke";
	level.scr_sound[var_02]["gre_iln_totheright"] = "gre_iln_totheright";
	level.scr_sound[var_02]["gre_iln_jumpacross"] = "gre_iln_jumpacross";
	level.scr_sound[var_02]["gre_iln_letsmovesmoke"] = "gre_iln_letsmovesmoke";
	level.scr_sound[var_02]["gre_iln_needtomoveit"] = "gre_iln_needtomoveit";
	level.scr_sound[var_02]["gre_iln_quistallandjump"] = "gre_iln_quistallandjump";
	level.scr_sound[var_02]["gre_iln_makethejump"] = "gre_iln_makethejump";
	level.scr_sound[var_02]["gre_iln_nobreathers"] = "gre_iln_nobreathers";
	level.scr_sound[var_02]["gre_iln_getdownstaydown"] = "gre_iln_getdownstaydown";
	level.scr_sound[var_02]["gre_iln_shitthatsalotoground"] = "gre_iln_shitthatsalotoground";
	level.scr_sound[var_02]["gre_iln_keepitbuttoned"] = "gre_iln_keepitbuttoned";
	level.scr_sound[var_02]["gre_iln_clearyourturnon"] = "gre_iln_clearyourturnon";
	level.scr_sound[var_02]["gre_iln_moveitgrooveit"] = "gre_iln_moveitgrooveit";
	level.scr_sound[var_02]["gre_iln_gotimesthree"] = "gre_iln_gotimesthree";
	level.scr_sound[var_02]["gre_iln_illkeephimpinned"] = "gre_iln_illkeephimpinned";
	level.scr_sound[var_02]["gre_iln_nicerunmyturn"] = "gre_iln_nicerunmyturn";
	level.scr_sound[var_02]["gre_iln_moveuphot"] = "gre_iln_moveuphot";
	level.scr_sound[var_02]["gre_iln_clearcheer"] = "gre_iln_clearcheer";
	level.scr_sound[var_02]["gre_iln_bitchingjob"] = "gre_iln_bitchingjob";
	level.scr_sound[var_02]["gre_iln_snipercanthit"] = "gre_iln_snipercanthit";
	level.scr_sound[var_02]["gre_iln_covermeyoyo"] = "gre_iln_covermeyoyo";
	level.scr_sound[var_02]["gre_iln_decideahole"] = "gre_iln_decideahole";
	level.scr_sound[var_02]["gre_iln_wastingtimewhats"] = "gre_iln_wastingtimewhats";
	level.scr_sound[var_02]["gre_iln_suppressthat"] = "gre_iln_suppressthat";
	level.scr_sound[var_02]["gre_iln_whatcovermeyo"] = "gre_iln_whatcovermeyo";
	level.scr_sound[var_02]["gre_iln_whereissuppress"] = "gre_iln_whereissuppress";
	level.scr_sound[var_02]["gre_iln_haulasssmartass"] = "gre_iln_haulasssmartass";
	level.scr_sound[var_02]["gre_iln_pinneddownup"] = "gre_iln_pinneddownup";
	level.scr_sound[var_02]["gre_iln_runwhiteboy"] = "gre_iln_runwhiteboy";
	level.scr_sound[var_02]["gre_iln_mfallback"] = "gre_iln_mfallback";
	level.scr_sound[var_02]["gre_iln_kvadronescoveryip"] = "gre_iln_kvadronescoveryip";
	level.scr_sound[var_02]["gre_iln_dronesdownyall"] = "gre_iln_dronesdownyall";
	level.scr_sound[var_02]["gre_iln_intorestaurant"] = "gre_iln_intorestaurant";
	level.scr_sound[var_02]["gre_iln_watchtheglassass"] = "gre_iln_watchtheglassass";
	level.scr_sound[var_02]["gre_iln_throughthelobby"] = "gre_iln_throughthelobby";
	level.scr_sound[var_02]["gre_iln_stayonmesanchez"] = "gre_iln_stayonmesanchez";
	level.scr_sound[var_02]["gre_iln_staywithmegirl"] = "gre_iln_staywithmegirl";
	level.scr_sound[var_02]["gre_iln_eyesonsanchez"] = "gre_iln_eyesonsanchez";
	level.scr_radio["gre_prp_requestmeds"] = "gre_prp_requestmeds";
	level.scr_sound[var_14]["gre_scz_rpgbytruck"] = "gre_scz_rpgbytruck";
	level.scr_sound[var_02]["gre_iln_headsupdronebones"] = "gre_iln_headsupdronebones";
	level.scr_sound[var_02]["gre_iln_illdistractsniper"] = "gre_iln_illdistractsniper";
	level.scr_sound[var_02]["gre_iln_shitrightkill"] = "gre_iln_shitrightkill";
	level.scr_radio["gre_prp_convoyisfourx"] = "gre_prp_convoyisfourx";
	level.scr_sound[var_02]["gre_iln_bravomoveyogox"] = "gre_iln_bravomoveyogox";
	level.scr_sound[var_02]["gre_iln_lastdronelightup"] = "gre_iln_lastdronelightup";
	level.scr_sound[var_02]["gre_iln_dronesdowngetrpg"] = "gre_iln_dronesdowngetrpg";
	level.scr_sound[var_02]["gre_iln_needrpgomg"] = "gre_iln_needrpgomg";
	level.scr_sound[var_02]["gre_iln_omgneedrpgyet"] = "gre_iln_omgneedrpgyet";
	level.scr_sound[var_02]["gre_iln_clearoutsniperpiper"] = "gre_iln_clearoutsniperpiper";
	level.scr_sound[var_02]["gre_iln_takeshotbigshot"] = "gre_iln_takeshotbigshot";
	level.scr_sound[var_02]["gre_iln_firerpgggg"] = "gre_iln_firerpgggg";
	level.scr_sound[var_02]["gre_iln_oneshotonemission"] = "gre_iln_oneshotonemission";
	level.scr_sound[var_02]["gre_iln_neverhithim"] = "gre_iln_neverhithim";
	level.scr_sound[var_02]["grk_iln_shitfindcover"] = "grk_iln_shitfindcover";
	level.scr_sound[var_02]["grk_iln_shootthedrones"] = "grk_iln_shootthedrones";
	level.scr_sound[var_02]["grk_iln_useyouremp"] = "grk_iln_useyouremp";
	level.scr_sound[var_02]["grk_iln_takethosedrones"] = "grk_iln_takethosedrones";
	level.scr_radio["grk_gdn_mitchellweneed"] = "grk_gdn_mitchellweneed";
	level.scr_radio["grk_iln_keepthemoff"] = "grk_iln_keepthemoff";
	level.scr_radio["grk_gdn_waspclearem"] = "grk_gdn_waspclearem";
	level.scr_sound[var_02]["grk_iln_cantgetabead"] = "grk_iln_cantgetabead";
	level.scr_sound[var_02]["grk_iln_mitchelgetintopos"] = "grk_iln_mitchelgetintopos";
	level.scr_sound[var_02]["grk_kva_daminpropdisengage"] = "grk_kva_daminpropdisengage";
	level.scr_sound[var_02]["gre_iln_youlhavetodo"] = "gre_iln_youlhavetodo";
	level.scr_radio["grp_iln_zoominMitch"] = "grp_iln_zoominMitch";
	level.scr_sound[var_02]["grk_iln_throughhere"] = "grk_iln_throughhere";
	level.scr_sound[var_02]["gre_iln_weneedtobestung"] = "gre_iln_weneedtobestung";
	level.scr_sound[var_03]["grk_kva_keepthemawayfrohell"] = "grk_kva_keepthemawayfrohell";
	level.scr_sound[var_03]["grk_kva_theyaintgonnagetim"] = "grk_kva_theyaintgonnagetim";
	level.scr_sound[var_03]["grk_kva_protecthadesatall"] = "grk_kva_protecthadesatall";
	level.scr_sound[var_02]["grk_iln_holdfireuntilinside"] = "grk_iln_holdfireuntilinside";
	level.scr_radio["grk_prp_allstatsconvoysouth"] = "grk_prp_allstatsconvoysouth";
	level.scr_radio["grk_san_wehavecontactyo"] = "grk_san_wehavecontactyo";
	level.scr_radio["grk_san_wehavecontactyodoa"] = "grk_san_wehavecontactyodoa";
	level.scr_radio["grk_prp_sanchezoverover"] = "grk_prp_sanchezoverover";
	level.scr_radio["grk_san_mandownsniperbell"] = "grk_san_mandownsniperbell";
	level.scr_sound[var_02]["grk_iln_openthegate"] = "gre_iln_waitingonurban";
	level.scr_sound[var_02]["grk_iln_gatethatgateopen"] = "gre_iln_openthefuck";
	level.scr_sound[var_02]["grk_iln_mitchellopenthegate"] = "gre_iln_nowfuckmitchell";
	level.scr_sound[var_02]["grk_iln_fireonthatsniperyo"] = "gre_iln_nicerunmyturn";
	level.scr_sound[var_02]["grk_iln_keepfiringonthat"] = "gre_iln_moveuphot";
	level.scr_sound[var_02]["grk_iln_buttonupthat"] = "gre_iln_keepitbuttoned";
	level.scr_sound[var_02]["grk_iln_thanksbuddy"] = "grk_iln_thanksbuddy";
	level.scr_sound[var_02]["grk_iln_igonnasaveyou"] = "grk_iln_igonnasaveyou";
	level.scr_sound[var_02]["grk_iln_ijustconfirmedhad"] = "grk_iln_ijustconfirmedhad";
	level.scr_sound[var_05]["grk_hds_heknowsheknows"] = "grk_hds_heknowsheknows";
	level.scr_sound[var_02]["grk_iln_whatdoesironsknow"] = "grk_iln_whatdoesironsknow";
	level.scr_sound[var_02]["gre_iln1_useoverdrive"] = "gre_iln1_useoverdrive";
	level.scr_sound[var_02]["gre_iln1_useyourshield"] = "gre_iln1_useyourshield";
	level.scr_sound[var_02]["gre_iln1_tossathreatgrenade"] = "gre_iln1_tossathreatgrenade";
	level.scr_sound[var_02]["gre_iln1_mygod"] = "gre_iln1_mygod";
	level.scr_sound[var_02]["gre_iln1_gothimfuckthatguy"] = "gre_iln1_gothimfuckthatguy";
	level.scr_radio["gre_gdn_boringconversationanyways"] = "gre_gdn_boringconversationanyways";
}

//Function Number: 3
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%hms_greece_market_intro_ilana,"aud_start_cafe_pt1_ilona",::gre_cafe_intro_pt1_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%hms_greece_market_outro_ilana,"aud_start_cafe_pt2_ilona",::gre_cafe_intro_pt2_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%hms_greece_finale_end_ilana,"aud_start_finale_ilona",::gre_hades_death_outro_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%hms_greece_finale_end_hades,"aud_start_finale_hades",::gre_hades_death_outro_hades);
}

//Function Number: 4
gre_cafe_intro_pt1_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("grk_gdn_sorrytointerrupt",4.5);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_andwhatdoesthat",9);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("gre_prp_intiateuplink",12.33);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_weseehim",14.56);
}

//Function Number: 5
gre_cafe_intro_pt2_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_thatsourticket",0.66);
}

//Function Number: 6
gre_hades_death_outro_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_thanksbuddy",4.1);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_igonnasaveyou",10.05);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_ijustconfirmedhad",25.2);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_iln_whatdoesironsknow",55.4);
}

//Function Number: 7
gre_hades_death_outro_hades(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("grk_hds_heknowsheknows",38.25);
}

//Function Number: 8
cafe_irons_speech_bink()
{
	level.player playscheduledcinematicsound(131,"gre_irs_teamidontneedto");
	level.player playscheduledcinematicsound(351,"gre_irs_webringhimdownwe");
}

//Function Number: 9
startdialoguethreads()
{
	switch(level.start_point)
	{
		case "start_levelintro":
		case "default":
			thread dialoguelevelintro();
			var_00 = "burke";
			var_01 = "joker";
			break;

		default:
			break;
	}
}

//Function Number: 10
dialoguelevelintro()
{
}