/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 88
 * Decompile Time: 1282 ms
 * Timestamp: 4/22/2024 2:33:13 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_vo();
	init_dialogue_flags();
	thread start_dialogue_threads();
}

//Function Number: 2
setup_vo()
{
	var_00 = "burke";
	var_01 = "cormack";
	var_02 = "knox";
	var_03 = "disarm_guy_1";
	var_04 = "PAS";
	level.scr_sound[var_00]["lab_gdn_theyreonus"] = "lab_gdn_theyreonus";
	level.scr_sound[var_00]["lab_gdn_dontletthatsniperdial"] = "lab_gdn_dontletthatsniperdial";
	level.scr_sound[var_00]["lab_gdn_thatempcockedupour"] = "lab_gdn_thatempcockedupour";
	level.scr_sound[var_00]["lab_gdn_exosstillrebooting"] = "lab_gdn_exosstillrebooting";
	level.scr_sound[var_00]["lab_gdn_gogogo"] = "lab_gdn_gogogo";
	level.scr_sound[var_00]["lab_gdn_keepmoving"] = "lab_gdn_keepmoving";
	level.scr_sound[var_00]["lab_gdn_run"] = "lab_gdn_run";
	level.scr_sound[var_00]["lab_gdn_heloscirclingaroundcomeon"] = "lab_gdn_heloscirclingaroundcomeon";
	level.scr_sound[var_00]["lab_gdn_uphere"] = "lab_gdn_uphere";
	level.scr_sound[var_00]["lab_gdn_moveit"] = "lab_gdn_moveit";
	level.scr_sound[var_00]["lab_gdn_overhere"] = "lab_gdn_overhere";
	level.scr_sound[var_00]["lab_gdn_holdon"] = "lab_gdn_holdon";
	level.scr_sound[var_00]["lab_gdn_cmon"] = "lab_gdn_cmon";
	level.scr_sound[var_00]["lab_gdn_exosupcloak"] = "lab_gdn_exosupcloak";
	level.scr_sound[var_00]["lab_gdn_choppersmovinoff"] = "lab_gdn_choppersmovinoff";
	level.scr_sound[var_00]["lab_gdn_syncyourvisortomy"] = "lab_gdn_syncyourvisortomy";
	level.scr_sound[var_00]["lab_gdn_moveslownearhostiles"] = "lab_gdn_moveslownearhostiles";
	level.scr_sound[var_00]["lab_gdn_dronedontmove"] = "lab_gdn_dronedontmove";
	level.scr_sound[var_00]["lab_gdn_dontmove"] = "lab_gdn_dontmove";
	level.scr_sound[var_00]["lab_gdn_stopmovingoritwill"] = "lab_gdn_stopmovingoritwill";
	level.scr_sound[var_00]["lab_gdn_easy"] = "lab_gdn_easy";
	level.scr_sound[var_00]["lab_gdn_damnitheardyou"] = "lab_gdn_damnitheardyou";
	level.scr_sound[var_00]["lab_gdn_letsgo"] = "lab_gdn_letsgo";
	level.scr_sound[var_00]["lab_gdn_watchyourenergycells"] = "lab_gdn_watchyourenergycells";
	level.scr_sound[var_00]["lab_gdn_turnoffcloaktorecharge"] = "lab_gdn_turnoffcloaktorecharge";
	level.scr_sound[var_00]["lab_gdn_mitchellonme"] = "lab_gdn_mitchellonme";
	level.scr_sound[var_00]["lab_gdn_damnitmitchell"] = "lab_gdn_damnitmitchell";
	level.scr_sound[var_00]["lab_gdn_werecompromised"] = "lab_gdn_werecompromised";
	level.scr_sound[var_00]["lab_gdn_theyveseenus"] = "lab_gdn_theyveseenus";
	level.scr_sound[var_00]["lab_gdn_theyvegotusengage"] = "lab_gdn_theyvegotusengage";
	level.scr_sound[var_00]["lab_gdn_choppermustbegoingfor"] = "lab_gdn_choppermustbegoingfor";
	level.scr_sound[var_00]["lab_gdn_moreincoming"] = "lab_gdn_moreincoming";
	level.scr_sound[var_00]["lab_gdn_keepitquietnexttime"] = "lab_gdn_keepitquietnexttime";
	level.scr_sound[var_00]["lab_gdn_takeemout"] = "lab_gdn_takeemout";
	level.scr_sound[var_00]["lab_gdn_slowlynow"] = "lab_gdn_slowlynow";
	level.scr_sound[var_00]["lab_gdn_kingpinthisissentineltwoone"] = "lab_gdn_kingpinthisissentineltwoone";
	level.scr_radio["lab_kpn_thisiskingpin"] = "lab_kpn_thisiskingpin";
	level.scr_sound[var_00]["lab_brk_eemode"] = "lab_brk_eemode";
	level.scr_sound[var_00]["lab_brk_needexfil"] = "lab_brk_needexfil";
	level.scr_radio["lab_kgn_negativesentineltwoone"] = "lab_kgn_negativesentineltwoone";
	level.scr_sound[var_00]["lab_gdn_copyfuckinhell"] = "lab_gdn_copyfuckinhell";
	level.scr_sound[var_00]["lab_gdn_patrolapproaching"] = "lab_gdn_patrolapproaching";
	level.scr_radio["lab_scr_victorzerosevenwhatsyourlocation"] = "lab_scr_victorzerosevenwhatsyourlocation";
	level.scr_sound[var_03]["lab_gr1_thisisvictorsevenwereat"] = "lab_gr1_thisisvictorsevenwereat";
	level.scr_radio["lab_scr_wepickedupthreedead"] = "lab_scr_wepickedupthreedead";
	level.scr_sound[var_03]["lab_gr1_nosignofthemhere"] = "lab_gr1_nosignofthemhere";
	level.scr_radio["lab_scr_holdyourpositionsandwait"] = "lab_scr_holdyourpositionsandwait";
	level.scr_sound[var_03]["lab_gr1_copythat"] = "lab_gr1_copythat";
	level.scr_sound[var_00]["lab_gdn_theseareunsuppressed"] = "lab_gdn_theseareunsuppressed";
	level.scr_sound[var_00]["lab_gdn_toomuchactivity"] = "lab_gdn_toomuchactivity";
	level.scr_sound[var_00]["lab_gdn_waituntiltheypass"] = "lab_gdn_waituntiltheypass";
	level.scr_sound[var_00]["lab_gdn_makemistakeslikethaton"] = "lab_gdn_makemistakeslikethaton";
	level.scr_sound[var_00]["lab_gdn_itsyourfuneralmate"] = "lab_gdn_itsyourfuneralmate";
	level.scr_sound[var_00]["lab_gdn_cormackandknoxshouldbe"] = "lab_gdn_cormackandknoxshouldbe";
	level.scr_sound[var_00]["lab_gdn_twointhevehicle"] = "lab_gdn_twointhevehicle";
	level.scr_sound[var_00]["lab_gdn_takeoutthepassenger"] = "lab_gdn_takeoutthepassenger";
	level.scr_sound[var_00]["lab_gdn_takehimdown"] = "lab_gdn_takehimdown";
	level.scr_sound[var_00]["lab_gdn_mitchellgetthatbastard"] = "lab_gdn_mitchellgetthatbastard";
	level.scr_sound[var_00]["lab_gdn_topjob"] = "lab_gdn_topjob";
	level.scr_sound[var_00]["lab_gdn_convoyaheadholdup"] = "lab_gdn_convoyaheadholdup";
	level.scr_sound[var_00]["lab_gdn_thisway"] = "lab_gdn_thisway";
	level.scr_sound[var_00]["lab_gdn_fiveastsapproaching"] = "lab_gdn_fiveastsapproaching";
	level.scr_sound[var_00]["lab_gdn_forgetaboutshootingourway"] = "lab_gdn_forgetaboutshootingourway";
	level.scr_sound[var_00]["lab_gdn_grabsomecover"] = "lab_gdn_grabsomecover";
	level.scr_sound[var_00]["lab_gdn_keepmovingalmostthere"] = "lab_gdn_keepmovingalmostthere";
	level.scr_sound[var_00]["lab_gdn_waitforthepatrolto"] = "lab_gdn_waitforthepatrolto";
	level.scr_sound[var_00]["lab_gdn_waitforthebeam"] = "lab_gdn_waitforthebeam";
	level.scr_sound[var_00]["lab_gdn_waitwait"] = "lab_gdn_waitwait";
	level.scr_sound[var_00]["lab_gdn_okaygo"] = "lab_gdn_okaygo";
	level.scr_sound[var_00]["lab_gdn_watchthatbeam"] = "lab_gdn_watchthatbeam";
	level.scr_sound[var_00]["lab_gdn_okaynow"] = "lab_gdn_okaynow";
	level.scr_sound[var_00]["lab_gdn_seeker"] = "lab_gdn_seeker";
	level.scr_sound[var_00]["lab_gdn_cloaksuselessagainstit"] = "lab_gdn_cloaksuselessagainstit";
	level.scr_sound[var_00]["lab_gdn_werepastkeepmoving"] = "lab_gdn_werepastkeepmoving";
	level.scr_sound[var_00]["lab_gdn_thisisit"] = "lab_gdn_thisisit";
	level.scr_sound[var_01]["lab_crk_copy"] = "lab_crk_copy";
	level.scr_sound[var_00]["lab_gdn_weneedanexfilsharpish"] = "lab_gdn_weneedanexfilsharpish";
	level.scr_sound[var_01]["lab_crk_missionisntoverkitup"] = "lab_crk_missionisntoverkitup";
	level.scr_sound[var_00]["lab_gdn_themissionwasoverbefore"] = "lab_gdn_themissionwasoverbefore";
	level.scr_sound[var_01]["lab_crk_werenotleavinguntilwe"] = "lab_crk_werenotleavinguntilwe";
	level.scr_sound[var_00]["lab_gdn_idontseeafucking"] = "lab_gdn_idontseeafucking";
	level.scr_sound[var_01]["lab_crmk_switchtermal"] = "lab_crmk_switchtermal";
	level.scr_sound[var_02]["lab_knx_sendingyoumyfeed"] = "lab_knx_sendingyoumyfeed";
	level.scr_sound[var_01]["lab_crk_theyvegotsomethingtohide"] = "lab_crk_theyvegotsomethingtohide";
	level.scr_sound[var_00]["lab_gdn_wevelosttheinitiativewe"] = "lab_gdn_wevelosttheinitiativewe";
	level.scr_sound[var_01]["lab_crk_thereisnootherday"] = "lab_crk_thereisnootherday";
	level.scr_sound[var_00]["lab_gdn_thisthinggoessidewaysits"] = "lab_gdn_thisthinggoessidewaysits";
	level.scr_sound[var_02]["lab_knx_holographiccanopy"] = "lab_knx_holographiccanopy";
	level.scr_sound[var_00]["lab_gdn_mitchelgetclippedon"] = "lab_gdn_mitchelgetclippedon";
	level.scr_sound[var_00]["lab_gdn_hookupmitchel"] = "lab_gdn_hookupmitchel";
	level.scr_sound[var_01]["lab_crk_targetbuildingupahead"] = "lab_crk_targetbuildingupahead";
	level.scr_sound[var_01]["lab_crk_camera"] = "lab_crk_camera";
	level.scr_sound[var_01]["lab_crk_twoguardsbythecamera"] = "lab_crk_twoguardsbythecamera";
	level.scr_sound[var_01]["lab_crk_mitchellpickatarget"] = "lab_crk_mitchellpickatarget";
	level.scr_sound[var_01]["lab_crk_wakeupmitchell"] = "lab_crk_wakeupmitchell";
	level.scr_sound[var_00]["lab_gdn_moveup"] = "lab_gdn_moveup";
	level.scr_sound[var_02]["lab_knx_eyesontheentrypoint"] = "lab_knx_eyesontheentrypoint";
	level.scr_sound[var_01]["lab_crk_thisisourbreachpoint"] = "lab_crk_thisisourbreachpoint";
	level.scr_sound[var_01]["lab_crk_mitchellsetthecharge"] = "lab_crk_mitchellsetthecharge";
	level.scr_sound[var_01]["lab_crk_mitchellmoveit"] = "lab_crk_mitchellmoveit";
	level.scr_sound[var_01]["lab_crk_movemovemove"] = "lab_crk_movemovemove";
	level.scr_sound[var_00]["lab_gdn_twointhehallway"] = "lab_gdn_twointhehallway";
	level.scr_sound[var_01]["lab_crk_takeemout"] = "lab_crk_takeemout";
	level.scr_sound[var_01]["lab_crk_kingpinweveinfiltratedthetarget"] = "lab_crk_kingpinweveinfiltratedthetarget";
	level.scr_radio["lab_kgn_rogerthat"] = "lab_kgn_rogerthat";
	level.scr_sound[var_01]["lab_crk_roger"] = "lab_crk_roger";
	level.scr_sound[var_02]["lab_knx_clear"] = "lab_knx_clear";
	level.scr_sound[var_00]["lab_gdn_clear"] = "lab_gdn_clear";
	level.scr_sound[var_01]["lab_crk_hitthestairs"] = "lab_crk_hitthestairs";
	level.scr_sound[var_02]["lab_knx_gotchacovered"] = "lab_knx_gotchacovered";
	level.scr_sound[var_01]["lab_crk_thisisit"] = "lab_crk_thisisit";
	level.scr_sound[var_00]["lab_gdn_nevermind"] = "lab_gdn_nevermind";
	level.scr_sound[var_00]["lab_gdn_clear2"] = "lab_gdn_clear2";
	level.scr_sound[var_00]["lab_gdn_youreupmitchel"] = "lab_gdn_youreupmitchel";
	level.scr_sound[var_00]["lab_gdn_getonthatconsole"] = "lab_gdn_getonthatconsole";
	level.scr_sound[var_00]["lab_gdn_mitchellgetonthatconsole"] = "lab_gdn_mitchellgetonthatconsole";
	level.scr_sound[var_00]["lab_gdn_getmovingmitchell"] = "lab_gdn_getmovingmitchell";
	level.scr_sound[var_01]["lab_crk_walksrightpastplayergiving"] = "lab_crk_walksrightpastplayergiving";
	level.scr_sound[var_02]["lab_crmk_sse"] = "lab_crmk_sse";
	level.scr_radio["lab_kgn_standingbytoreceivepackage"] = "lab_kgn_standingbytoreceivepackage";
	level.scr_sound[var_02]["lab_knx_bingowevegotthepackage"] = "lab_knx_bingowevegotthepackage";
	level.scr_radio["lab_kgn_uplinkconfirmed"] = "lab_kgn_uplinkconfirmed";
	level.scr_sound[var_01]["lab_crk_okayburnitdown"] = "lab_crk_okayburnitdown";
	level.scr_sound[var_02]["lab_brk_thermite"] = "lab_brk_thermite";
	level.scr_sound[var_01]["lab_crk_approachestheplayertheresmore"] = "lab_crk_approachestheplayertheresmore";
	level.scr_radio["lab_kgn_packagerecievedgoodjob"] = "lab_kgn_packagerecievedgoodjob";
	level.scr_sound[var_01]["lab_crk_copythat"] = "lab_crk_copythat";
	level.scr_radio["lab_kgn_twothreebeadvised"] = "lab_kgn_twothreebeadvised";
	level.scr_sound[var_02]["lab_knx_theyjustactivedasensor"] = "lab_knx_theyjustactivedasensor";
	level.scr_sound[var_01]["lab_crk_okaystealthsnolongeran"] = "lab_crk_okaystealthsnolongeran";
	level.scr_sound[var_01]["lab_crk_go2"] = "lab_crk_go2";
	level.scr_sound[var_00]["lab_gdn_takeoutthatsensor"] = "lab_gdn_takeoutthatsensor";
	level.scr_sound[var_00]["lab_gdn_sensorinthecorner"] = "lab_gdn_sensorinthecorner";
	level.scr_sound[var_01]["lab_crk_eyesonasensor"] = "lab_crk_eyesonasensor";
	level.scr_sound[var_00]["lab_gdn_sensorsdown"] = "lab_gdn_sensorsdown";
	level.scr_sound[var_00]["lab_gdn_sensorsout"] = "lab_gdn_sensorsout";
	level.scr_sound[var_01]["lab_crk_sensorsdown"] = "lab_crk_sensorsdown";
	level.scr_sound[var_01]["lab_crk_sensorsdead"] = "lab_crk_sensorsdead";
	level.scr_sound[var_00]["lab_gdn_contactbelowus"] = "lab_gdn_contactbelowus";
	level.scr_sound[var_01]["lab_crk_flankleftorright"] = "lab_crk_flankleftorright";
	level.scr_sound[var_01]["lab_crk_mitchelltakepoint"] = "lab_crk_mitchelltakepoint";
	level.scr_sound[var_01]["lab_crk_moveup"] = "lab_crk_moveup";
	level.scr_sound[var_00]["lab_gdn_clear2"] = "lab_gdn_clear2";
	level.scr_sound[var_01]["lab_crk_werehere"] = "lab_crk_werehere";
	level.scr_sound[var_02]["lab_knx_biosparqispickinguptrace"] = "lab_knx_biosparqispickinguptrace";
	level.scr_sound[var_01]["lab_crk_mitchellplantthefrbs"] = "lab_crk_mitchellplantthefrbs";
	level.scr_sound[var_01]["lab_crk_wakeupmitchell2"] = "lab_crk_wakeupmitchell2";
	level.scr_sound[var_01]["lab_crk_mitchellgetthefrbready"] = "lab_crk_mitchellgetthefrbready";
	level.scr_sound[var_01]["lab_crk_plantitmitchell"] = "lab_crk_plantitmitchell";
	level.scr_sound[var_01]["lab_crk_everyoneout"] = "lab_crk_everyoneout";
	level.scr_sound[var_01]["lab_crk_mitchellhitit"] = "lab_crk_mitchellhitit";
	level.scr_sound[var_01]["lab_crk_hitit"] = "lab_crk_hitit";
	level.scr_sound[var_01]["lab_crk_kingpinmaterialissecure"] = "lab_crk_kingpinmaterialissecure";
	level.scr_radio["lab_kgn_primarylzistoohot"] = "lab_kgn_primarylzistoohot";
	level.scr_sound[var_01]["lab_crk_understoodweremoving"] = "lab_crk_understoodweremoving";
	level.scr_sound[var_00]["lab_gdn_keepsgettingbetter"] = "lab_gdn_keepsgettingbetter";
	level.scr_sound[var_00]["lab_gdn_chargeyourcloak"] = "lab_gdn_chargeyourcloak";
	level.scr_sound[var_00]["lab_gdn_holdupcharging"] = "lab_gdn_holdupcharging";
	level.scr_sound[var_00]["lab_gdn_chargeup"] = "lab_gdn_chargeup";
	level.scr_sound[var_00]["lab_gdn_moving"] = "lab_gdn_moving";
	level.scr_sound[var_01]["lab_crk_contact"] = "lab_crk_contact";
	level.scr_sound[var_01]["lab_crk_knoxgetthisdooropen"] = "lab_crk_knoxgetthisdooropen";
	level.scr_sound[var_02]["lab_knx_runningabypasscoverme"] = "lab_knx_runningabypasscoverme";
	level.scr_sound[var_02]["lab_knx_imgettinginterferencefromthat"] = "lab_knx_imgettinginterferencefromthat";
	level.scr_sound[var_01]["lab_crk_thatsyoumitchell"] = "lab_crk_thatsyoumitchell";
	level.scr_sound[var_00]["lab_gdn_ast"] = "lab_gdn_ast";
	level.scr_sound[var_01]["lab_crk_shitdrawitsfire"] = "lab_crk_shitdrawitsfire";
	level.scr_sound[var_01]["lab_crk_scramblersontopofthat"] = "lab_crk_scramblersontopofthat";
	level.scr_sound[var_00]["lab_gdn_jammersontopofthat"] = "lab_gdn_jammersontopofthat";
	level.scr_sound[var_00]["lab_gdn_lookforaladder"] = "lab_gdn_lookforaladder";
	level.scr_sound[var_01]["lab_crk_plantthatjammer"] = "lab_crk_plantthatjammer";
	level.scr_sound[var_01]["lab_crk_mitchellgetthatjammerhooked"] = "lab_crk_mitchellgetthatjammerhooked";
	level.scr_sound[var_01]["lab_crk_mitchellplantthejammer"] = "lab_crk_mitchellplantthejammer";
	level.scr_sound[var_02]["lab_knx_signalsclear"] = "lab_knx_signalsclear";
	level.scr_sound[var_01]["lab_crk_moretangosmovingin"] = "lab_crk_moretangosmovingin";
	level.scr_sound[var_02]["lab_knx_doorsopenletsmove"] = "lab_knx_doorsopenletsmove";
	level.scr_sound[var_01]["lab_crk_mitchellregroupdownhere"] = "lab_crk_mitchellregroupdownhere";
	level.scr_sound[var_01]["lab_crk_mitchellrallyup"] = "lab_crk_mitchellrallyup";
	level.scr_radio["lab_pas_wehavehostilesinthe"] = "lab_pas_wehavehostilesinthe";
	level.scr_sound[var_01]["lab_crk_vehiclehangarsthroughhere"] = "lab_crk_vehiclehangarsthroughhere";
	level.scr_radio["lab_pas_coderedinallsectors"] = "lab_pas_coderedinallsectors";
	level.scr_radio["lab_pas_allsecurityteamsreportto"] = "lab_pas_allsecurityteamsreportto";
	level.scr_sound[var_01]["lab_crmk_anotherdoor"] = "lab_crmk_anotherdoor";
	level.scr_sound[var_02]["lab_knx_onit"] = "lab_knx_onit";
	level.scr_sound[var_00]["lab_brk_improvise"] = "lab_brk_improvise";
	level.scr_sound[var_02]["lab_knx_itsopen"] = "lab_knx_itsopen";
	level.scr_sound[var_00]["lab_brk_backup"] = "lab_brk_backup";
	level.scr_sound[var_00]["lab_brk_getout"] = "lab_brk_getout";
	level.scr_sound[var_01]["lab_crk_sweeptheroom"] = "lab_crk_sweeptheroom";
	level.scr_sound[var_00]["lab_gdn_clear3"] = "lab_gdn_clear3";
	level.scr_sound[var_01]["lab_crk_thisisourride"] = "lab_crk_thisisourride";
	level.scr_sound[var_02]["lab_knx_copythat"] = "lab_knx_copythat";
	level.scr_sound[var_00]["lab_gdn_t740stillonlyaprototype"] = "lab_gdn_t740stillonlyaprototype";
	level.scr_sound[var_02]["lab_knx_poweringitup"] = "lab_knx_poweringitup";
	level.scr_sound[var_01]["lab_crk_handsupwhoknowshow"] = "lab_crk_handsupwhoknowshow";
	level.scr_sound[var_00]["lab_gdn_mitchellanditrainedup"] = "lab_gdn_mitchellanditrainedup";
	level.scr_sound[var_02]["lab_knx_disengaging"] = "lab_knx_disengaging";
	level.scr_sound[var_02]["lab_knx_werechargedandfullyarmed"] = "lab_knx_werechargedandfullyarmed";
	level.scr_sound[var_01]["lab_crk_kingpinthisissentineltwothree"] = "lab_crk_kingpinthisissentineltwothree";
	level.scr_radio["lab_kgn_rogerthatsentineltwothree"] = "lab_kgn_rogerthatsentineltwothree";
	level.scr_sound[var_01]["lab_crk_alrighteveryonein"] = "lab_crk_alrighteveryonein";
	level.scr_sound[var_00]["lab_gdn_allsystemscheckgreen"] = "lab_gdn_allsystemscheckgreen";
	level.scr_sound[var_00]["lab_gdn_alrightmitchelljustlikein"] = "lab_gdn_alrightmitchelljustlikein";
	level.scr_sound[var_00]["lab_gdn_moveitoutmitchell"] = "lab_gdn_moveitoutmitchell";
	level.scr_sound[var_02]["lab_knx_fullyarmed"] = "lab_knx_fullyarmed";
	level.scr_sound[var_00]["lab_gdn_theyreontous"] = "lab_gdn_theyreontous";
	level.scr_sound[var_00]["lab_gdn_infantryaheadofus"] = "lab_gdn_infantryaheadofus";
	level.scr_sound[var_00]["lab_gdn_warbirdincoming"] = "lab_gdn_warbirdincoming";
	level.scr_sound[var_00]["lab_gdn_armorapproaching"] = "lab_gdn_armorapproaching";
	level.scr_sound[var_00]["lab_gdn_tankapproaching"] = "lab_gdn_tankapproaching";
	level.scr_sound[var_00]["lab_gdn_warbirdonourleft"] = "lab_gdn_warbirdonourleft";
	level.scr_sound[var_00]["lab_gdn_ourtrophysystemisempty"] = "lab_gdn_ourtrophysystemisempty";
	level.scr_sound[var_00]["lab_brk_reloadtrophy"] = "lab_brk_reloadtrophy";
	level.scr_sound[var_00]["lab_gdn_wecanttakeanotherhit"] = "lab_gdn_wecanttakeanotherhit";
	level.scr_sound[var_00]["lab_gdn_weregettingbeatenup"] = "lab_gdn_weregettingbeatenup";
	level.scr_sound[var_00]["lab_gdn_tankonourleft"] = "lab_gdn_tankonourleft";
	level.scr_sound[var_00]["lab_gdn_tankonourright"] = "lab_gdn_tankonourright";
	level.scr_sound[var_00]["lab_gdn_keepmovingmitchell2"] = "lab_gdn_keepmovingmitchell2";
	level.scr_sound[var_00]["lab_gdn_lzisupahead"] = "lab_gdn_lzisupahead";
	level.scr_sound[var_00]["lab_gdn_switchtomissiles"] = "lab_gdn_switchtomissiles";
	level.scr_sound[var_00]["lab_gdn_useyourcannononthose"] = "lab_gdn_useyourcannononthose";
	level.scr_sound[var_00]["lab_gdn_empthatwarbird"] = "lab_gdn_empthatwarbird";
	level.scr_sound[var_01]["lab_crmk_awaytargetzone"] = "lab_crmk_awaytargetzone";
	level.scr_radio["lab_kpn_cantposid"] = "lab_kpn_cantposid";
	level.scr_sound[var_01]["lab_crmk_biggesttincan"] = "lab_crmk_biggesttincan";
	level.scr_radio["lab_kpn_rogerseeyou"] = "lab_kpn_rogerseeyou";
	level.scr_sound[var_00]["lab_brk_firewhenready"] = "lab_brk_firewhenready";
	level.scr_sound[var_02]["lab_knx_fuelcellslow"] = "lab_knx_fuelcellslow";
	level.scr_sound[var_01]["lab_crk_straightahead"] = "lab_crk_straightahead";
	level.scr_sound[var_01]["lab_crk_headright"] = "lab_crk_headright";
	level.scr_sound[var_01]["lab_crk_turnleft"] = "lab_crk_turnleft";
	level.scr_sound[var_01]["lab_crk_acrosstheriver"] = "lab_crk_acrosstheriver";
	level.scr_sound[var_01]["lab_crk_upthehill"] = "lab_crk_upthehill";
	level.scr_sound[var_01]["lab_crk_throughthegate2"] = "lab_crk_throughthegate2";
	level.scr_sound[var_01]["lab_crk_takingfirefromtheright"] = "lab_crk_takingfirefromtheright";
	level.scr_sound[var_01]["lab_crk_takingfirefromtheleft"] = "lab_crk_takingfirefromtheleft";
	level.scr_sound[var_00]["lab_gdn_firefromtheright"] = "lab_gdn_firefromtheright";
	level.scr_sound[var_00]["lab_gdn_firefromtheleft"] = "lab_gdn_firefromtheleft";
	level.scr_sound[var_01]["lab_crmk_armorcrit"] = "lab_crmk_armorcrit";
	level.scr_sound[var_00]["lab_gdn_reloading"] = "lab_gdn_reloading";
	level.scr_sound[var_00]["lab_gdn_empthechoppers"] = "lab_gdn_empthechoppers";
	level.scr_sound[var_00]["lab_gdn_usemissilesagainstinfantry"] = "lab_gdn_usemissilesagainstinfantry";
	level.scr_sound[var_00]["lab_gdn_empsuselessagainstthosetanks"] = "lab_gdn_empsuselessagainstthosetanks";
	level.scr_sound[var_00]["lab_gdn_niceshot"] = "lab_gdn_niceshot";
	level.scr_sound[var_00]["lab_gdn_gothim"] = "lab_gdn_gothim";
	level.scr_sound[var_00]["lab_gdn_tanksdown"] = "lab_gdn_tanksdown";
	level.scr_sound[var_00]["lab_gdn_warbirdsdown"] = "lab_gdn_warbirdsdown";
	level.scr_sound[var_00]["lab_gdn_hithimagain"] = "lab_gdn_hithimagain";
	level.scr_sound[var_00]["lab_gdn_fireagain"] = "lab_gdn_fireagain";
	level.scr_sound[var_01]["lab_crk_moreinfantrycomingin"] = "lab_crk_moreinfantrycomingin";
	level.scr_sound[var_01]["lab_crk_vrapsinbound"] = "lab_crk_vrapsinbound";
	level.scr_sound[var_01]["lab_crk_vrapahead"] = "lab_crk_vrapahead";
	level.scr_sound[var_01]["lab_crk_armoronourleft"] = "lab_crk_armoronourleft";
	level.scr_sound[var_01]["lab_crk_tankscomingdowntheroad"] = "lab_crk_tankscomingdowntheroad";
	level.scr_sound[var_01]["lab_crk_firefromabove"] = "lab_crk_firefromabove";
	level.scr_sound[var_01]["lab_crk_threatbehindus"] = "lab_crk_threatbehindus";
	level.scr_sound[var_00]["lab_brk_enginesdown"] = "lab_brk_enginesdown";
	level.scr_sound[var_01]["lab_crmk_holdoff"] = "lab_crmk_holdoff";
	level.scr_sound[var_00]["lab_gdn_switchtoslugs"] = "lab_gdn_switchtoslugs";
	level.scr_radio["lab_kgn_sentineltwothreeihaveahelo"] = "lab_kgn_sentineltwothreeihaveahelo";
	level.scr_sound[var_01]["lab_crk_copythatcoordinatesconfirmed"] = "lab_crk_copythatcoordinatesconfirmed";
	level.scr_sound[var_02]["lab_knx_271degrees"] = "lab_knx_271degrees";
	level.scr_sound[var_00]["lab_brk_howsammo"] = "lab_brk_howsammo";
	level.scr_sound[var_02]["lab_knx_dontwannaknow"] = "lab_knx_dontwannaknow";
	level.scr_sound[var_00]["lab_brk_fireeverything"] = "lab_brk_fireeverything";
	level.scr_sound[var_01]["lab_crmk_nearlythere"] = "lab_crmk_nearlythere";
	level.scr_sound[var_00]["lab_brk_cmonmoveit"] = "lab_brk_cmonmoveit";
	level.scr_sound[var_02]["lab_knx_outofjuice"] = "lab_knx_outofjuice";
	level.scr_sound[var_01]["lab_crk_thelzshouldbejust"] = "lab_crk_thelzshouldbejust";
	level.scr_sound[var_00]["lab_brk_goodideas"] = "lab_brk_goodideas";
	level.scr_sound[var_00]["lab_gdn_getreadytobailout"] = "lab_gdn_getreadytobailout";
	level.scr_sound[var_01]["lab_crk_thisisit2"] = "lab_crk_thisisit2";
	level.scr_sound[var_00]["lab_gdn_holdon"] = "lab_gdn_holdon";
	level.scr_sound[var_00]["lab_gdn_everybodyoutmovemovemove"] = "lab_gdn_everybodyoutmovemovemove";
	level.scr_radio["lab_ch5_falcon22cominginfor"] = "lab_ch5_falcon22cominginfor";
	level.scr_sound[var_01]["lab_crk_thatsourbird"] = "lab_crk_thatsourbird";
	level.scr_radio["lab_ch5_standingbytoloadpassengers"] = "lab_ch5_standingbytoloadpassengers";
	level.scr_sound[var_01]["lab_crk_loaduploadup"] = "lab_crk_loaduploadup";
	level.scr_sound[var_00]["lab_gdn_comeon2"] = "lab_gdn_comeon2";
	level.scr_radio["lab_plt_holdon"] = "lab_plt_holdon";
	level.scr_sound[var_01]["lab_crk_shit2"] = "lab_crk_shit2";
	level.scr_sound[var_00]["lab_gdn_onestepaheadofyou"] = "lab_gdn_onestepaheadofyou";
	level.scr_sound[var_01]["lab_crmk_gjsoldier"] = "lab_crmk_gjsoldier";
	level.scr_sound[var_01]["lab_crk_niceworksoldier"] = "lab_crk_niceworksoldier";
	level.scr_radio["lab_plt_extractcompleteheadinghome"] = "lab_plt_extractcompleteheadinghome";
	level.scr_radio["lab_sir_weaponsystemsonline"] = "lab_sir_weaponsystemsonline";
	level.scr_radio["lab_sir_trophysystemcritical"] = "lab_sir_trophysystemcritical";
	level.scr_radio["lab_sir_trophysystemat25"] = "lab_sir_trophysystemat25";
	level.scr_radio["lab_sir_trophysystemat50"] = "lab_sir_trophysystemat50";
	level.scr_radio["lab_gdn_theyvegotusengage"] = "lab_sir_trophysystemat75";
}

//Function Number: 3
init_dialogue_flags()
{
	common_scripts\utility::flag_init("flag_intro_run_dialogue_start");
	common_scripts\utility::flag_init("flag_exos_rebooting_dialogue");
	common_scripts\utility::flag_init("flag_emp_cocked_exo_dialogue");
	common_scripts\utility::flag_init("flag_gogogo_dialogue_start");
	common_scripts\utility::flag_init("flag_run_dialogue_start");
	common_scripts\utility::flag_init("flag_hold_on_dialogue");
	common_scripts\utility::flag_init("flag_search_drone_warning_dialogue");
	common_scripts\utility::flag_init("flag_aproach_vehicle_dialogue_complete");
	common_scripts\utility::flag_init("flag_start_vehicle_takedown_dialogue_complete");
	common_scripts\utility::flag_init("flag_cliff_rappel_dialogue_start");
	common_scripts\utility::flag_init("flag_cliff_rappeling_dialogue_start");
	common_scripts\utility::flag_init("flag_search_drone_complete_dialogue_start");
	common_scripts\utility::flag_init("flag_forest_takedown_01_dialogue_start");
	common_scripts\utility::flag_init("flag_post_server_room_dialogue_complete");
	common_scripts\utility::flag_init("flag_slowly_dialogue_start");
	common_scripts\utility::flag_init("flag_courtyard_door_hack_dialogue");
	common_scripts\utility::flag_init("flag_courtyard_door_hack_dialogue_complete");
	common_scripts\utility::flag_init("flag_courtyard_cover_Knox_dialogue_complete");
	common_scripts\utility::flag_init("flag_research_facility_combat_dialogue_complete");
	common_scripts\utility::flag_init("flag_foam_room_complete_dialogue");
	common_scripts\utility::flag_init("flag_foam_corridor_exit_door_open_dialogue");
	common_scripts\utility::flag_init("flag_foam_corridor_another_door_dialogue");
	common_scripts\utility::flag_init("flag_foam_corridor_improvise_dialogue");
	common_scripts\utility::flag_init("flag_tank_hangar_sweep_dialogue");
	common_scripts\utility::flag_init("flag_tank_hangar_reveal_dialogue");
	common_scripts\utility::flag_init("flag_tank_board_dialogue");
	common_scripts\utility::flag_init("flag_player_in_hovertank_dialogue");
	common_scripts\utility::flag_init("flag_tank_courtyard_dialogue");
	common_scripts\utility::flag_init("flag_tank_road_log_enemies_dialogue");
	common_scripts\utility::flag_init("flag_tank_field_lz_over_ridge_dialogue");
	common_scripts\utility::flag_init("flag_tank_clearing_infantry_dialogue");
	common_scripts\utility::flag_init("flag_tank_ascent_dialogue");
	common_scripts\utility::flag_init("flag_tank_exit_dialogue");
	common_scripts\utility::flag_init("flag_exfil_start_dialogue");
	common_scripts\utility::flag_init("flag_exfil_loadup_dialogue");
	common_scripts\utility::flag_init("flag_exfil_dialogue");
	common_scripts\utility::flag_init("flag_important_dialogue_playing");
}

//Function Number: 4
start_dialogue_threads()
{
	thread tank_systems_dialogue();
	switch(level.start_point)
	{
		case "demo_with_itiot":
		case "crash":
		case "default":
			intro_dialogue();
			into_the_forest_dialogue();
			break;

		case "forest_start":
			helo_coming_back_dialogue();
			heading_your_way_dialogue();
			break;

		case "forest_takedown":
			takedown_01_dialogue();
			takedown_01_complete_dialogue();
			break;

		case "logging_road":
			flank_right_dialogue();
			vehicle_takedown_01_dialogue();
			break;

		case "mech_march":
			thread stealth_broken_dialogue();
			mech_convoy_dialogue();
			seeker_dialogue();
			break;

		case "cliff_rappel":
			cliff_rappel_dialogue();
			break;

		case "facility_breach":
			facility_breach_dialogue();
			research_facility_interior_dialogue();
			break;

		case "server_room":
		case "server_room_promo":
			server_room_approach_dialogue();
			server_room_dialogue();
			research_facility_combat_dialogue();
			break;

		case "research_facility_bridge":
			river_room_combat_dialouge();
			break;

		case "foam_room":
			foam_room_dialogue();
			break;

		case "courtyard":
			foam_room_complete_dialogue();
			courtyard_entry_dialogue();
			courtyard_mech_start_dialogue();
			break;

		case "courtyard_jammer":
			courtyard_door_hack_start_dialogue();
			courtyard_jammer_complete_dialogue();
			courtyard_door_hack_complete_dialogue();
			tank_hangar_pas_dialogue();
			break;

		case "tank_hangar":
			tank_hangar_dialogue();
			break;

		case "tank_board":
			tank_board_dialogue();
			tank_courtyard_dialogue();
			break;

		case "tank_road":
			tank_road_dialogue();
			break;

		case "tank_field":
			tank_field_dialogue();
			break;

		case "tank_field_right_fork":
		case "tank_field_left_fork":
			tank_clearing_dialogue();
			break;

		case "tank_ascent":
			tank_ascent_dialogue();
			tank_exit_dialogue();
			break;

		case "exfil":
			exfil_dialogue();
			break;

		default:
			break;
	}
}

//Function Number: 5
intro_dialogue()
{
	common_scripts\utility::flag_wait("flag_increase_sinper_shots_01");
	level.burke maps\_utility::dialogue_queue("lab_gdn_dontletthatsniperdial");
}

//Function Number: 6
into_the_forest_dialogue()
{
	common_scripts\utility::flag_wait("flag_emp_cocked_exo_dialogue");
	wait(0.5);
	common_scripts\utility::flag_wait("flag_gogogo_dialogue_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_gogogo");
	common_scripts\utility::flag_wait("flag_run_dialogue_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_run");
	common_scripts\utility::flag_wait("flag_burke_cross_river");
	wait(16);
	level.burke maps\_utility::dialogue_queue("lab_gdn_exosstillrebooting");
}

//Function Number: 7
helo_coming_back_dialogue()
{
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	wait(2);
	level.burke maps\_utility::dialogue_queue("lab_gdn_heloscirclingaroundcomeon");
	common_scripts\utility::flag_wait("flag_forest_climb_wall_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_uphere");
	thread climb_wall_nag_dialogue();
	common_scripts\utility::flag_wait("player_climbing_wall");
	wait(1.3);
	level.burke maps\_utility::dialogue_queue("lab_gdn_moveit");
	common_scripts\utility::flag_wait("flag_hold_on_dialogue");
	level.burke maps\_utility::dialogue_queue("lab_gdn_holdon");
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	wait(2);
	level.burke maps\_utility::dialogue_queue("lab_gdn_choppersmovinoff");
}

//Function Number: 8
climb_wall_nag_dialogue()
{
	level endon("player_climbing_wall");
	wait(5);
	if(!common_scripts\utility::flag("player_climbing_wall"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_overhere");
	}

	wait(3);
	if(!common_scripts\utility::flag("player_climbing_wall"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_moveit");
	}
}

//Function Number: 9
heading_your_way_dialogue()
{
	maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_search_drone_burke_anim_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_syncyourvisortomy");
	level.burke maps\lab_utility::cloak_stencil_on(1.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_moveslownearhostiles");
	wait(3);
	level.burke maps\_utility::dialogue_queue("lab_gdn_dronedontmove");
	wait(7.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_easy");
	common_scripts\utility::flag_wait("flag_search_drone_complete_dialogue_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_letsgo");
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_watchyourenergycells");
}

//Function Number: 10
search_drone_warning_dialogue()
{
	level notify("dont_move_while_drones_are_near");
}

//Function Number: 11
burke_drone_warning_dialogue()
{
	level endon("flag_cormack_meet_start");
	var_00 = undefined;
	for(;;)
	{
		level waittill("dont_move_while_drones_are_near");
		var_01 = undefined;
		for(;;)
		{
			var_01 = common_scripts\utility::random(["lab_gdn_dontmove","lab_gdn_stopmovingoritwill","lab_gdn_easy"]);
			if(!isdefined(var_00) || var_01 != var_00)
			{
				break;
			}
		}

		var_00 = var_01;
		wait(1);
		level.burke maps\_utility::dialogue_queue(var_01);
		wait(5);
	}
}

//Function Number: 12
search_drone_alerted_dialogue()
{
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_damnitheardyou");
}

//Function Number: 13
takedown_01_dialogue()
{
	common_scripts\utility::flag_wait("flag_forest_takedown_01_dialogue_start");
	level endon("se_takedown_01_failed");
	level.guy_1 thread guy_1_takedown_01_dialogue();
	wait(1.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_patrolapproaching");
	common_scripts\utility::flag_wait("flag_slowly_dialogue_start");
	level.burke maps\_utility::dialogue_queue("lab_gdn_slowlynow");
	wait(5);
	if(!common_scripts\utility::flag("flag_se_takedown_01_started"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_takeemout");
	}
}

//Function Number: 14
guy_1_takedown_01_dialogue()
{
	self endon("death");
	self endon("takedown_01_start");
	level endon("se_takedown_01_failed");
	wait(2);
	level maps\_utility::dialogue_queue("lab_scr_victorzerosevenwhatsyourlocation");
	maps\_utility::dialogue_queue("lab_gr1_thisisvictorsevenwereat");
	level maps\_utility::dialogue_queue("lab_scr_wepickedupthreedead");
	maps\_utility::dialogue_queue("lab_gr1_nosignofthemhere");
	level maps\_utility::dialogue_queue("lab_scr_holdyourpositionsandwait");
	maps\_utility::dialogue_queue("lab_gr1_copythat");
}

//Function Number: 15
takedown_01_complete_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	wait(1);
	common_scripts\utility::flag_wait("flag_se_takedown_01_complete");
	level.burke maps\_utility::dialogue_queue("lab_gdn_theseareunsuppressed");
	level.burke maps\_utility::dialogue_queue("lab_gdn_kingpinthisissentineltwoone");
	level maps\_utility::dialogue_queue("lab_kgn_negativesentineltwoone");
	level.burke maps\_utility::dialogue_queue("lab_gdn_copyfuckinhell");
}

//Function Number: 16
flank_right_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	if(common_scripts\utility::flag("flag_forest_player_alt_path_01"))
	{
		return;
	}

	level endon("flag_forest_player_alt_path_01");
	common_scripts\utility::flag_wait_all("flag_patroler_takedown_02_follow_a","flag_forest_drive_by_01","flag_burke_forest_01_moveup");
	level.burke maps\_utility::dialogue_queue("lab_gdn_toomuchactivity");
	soundscripts\_snd::snd_message("flank_right_dialogue");
}

//Function Number: 17
stealth_broken_dialogue()
{
	level endon("flag_cormack_meet_init");
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_vo_stealth_broken");
	var_00[0] = "lab_gdn_damnitmitchell";
	var_00[1] = "lab_gdn_werecompromised";
	var_00[2] = "lab_gdn_theyveseenus";
	var_00[3] = "lab_gdn_theyvegotusengage";
	var_01 = randomintrange(0,var_00.size);
	wait 0.05;
	level.burke maps\_utility::dialogue_queue(var_00[var_01]);
	wait(5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_moreincoming");
}

//Function Number: 18
vehicle_takedown_01_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	level endon("flag_se_vehicle_takedown_01_failed");
	level endon("flag_ready_burke_for_mech_march");
	common_scripts\utility::flag_wait("flag_recharge_cloak_01");
	wait(5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_cormackandknoxshouldbe");
	common_scripts\utility::flag_set("flag_aproach_vehicle_dialogue_complete");
	if(!common_scripts\utility::flag("flag_forest_player_alt_path_01"))
	{
		common_scripts\utility::flag_wait("flag_vehicle_takedown_01");
		soundscripts\_snd::snd_message("lab_brk_illtakedriver");
		level.burke maps\_utility::dialogue_queue("lab_gdn_twointhevehicle");
		level.burke maps\_utility::dialogue_queue("lab_gdn_takeoutthepassenger");
		thread vehicle_takedown_01_nag_dialogue();
		common_scripts\utility::flag_set("flag_start_vehicle_takedown_dialogue_complete");
		common_scripts\utility::flag_wait("flag_se_vehicle_takedown_01_complete");
		if(!common_scripts\utility::flag("flag_se_vehicle_takedown_01_failed") || !common_scripts\utility::flag("flag_forest_player_alt_path_01"))
		{
			level.burke maps\_utility::dialogue_queue("lab_gdn_topjob");
		}

		soundscripts\_snd::snd_message("vehicle_takedown_01_complete");
	}
}

//Function Number: 19
vehicle_takedown_01_nag_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	level endon("flag_vehicle_takedown_01_start");
	level endon("flag_se_vehicle_takedown_01_failed");
	wait(6);
	level.burke maps\_utility::dialogue_queue("lab_gdn_takehimdown");
	wait(8);
	level.burke maps\_utility::dialogue_queue("lab_gdn_mitchellgetthatbastard");
}

//Function Number: 20
mech_convoy_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	common_scripts\utility::flag_wait("flag_se_mech_march_start");
	wait(2);
	level.burke maps\_utility::dialogue_queue("lab_gdn_convoyaheadholdup");
	level common_scripts\utility::waittill_any("burke_recharge_mech_done","flag_five_ast_approaching");
	if(!common_scripts\utility::flag("flag_five_ast_approaching"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_thisway");
	}

	common_scripts\utility::flag_wait("flag_five_ast_approaching");
	soundscripts\_snd::snd_message("forest_mech_spawn");
	level.burke maps\_utility::dialogue_queue("lab_gdn_fiveastsapproaching");
	level.burke maps\_utility::dialogue_queue("lab_gdn_forgetaboutshootingourway");
	level.burke maps\_utility::dialogue_queue("lab_gdn_grabsomecover");
}

//Function Number: 21
seeker_dialogue()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	level endon("flag_move_up_seeker_03");
	common_scripts\utility::flag_wait_any("flag_mech_march_hide_right_complete","flag_gaz_01_scanner_on");
	if(!common_scripts\utility::flag("flag_gaz_01_scanner_on"))
	{
		wait(1);
		level.burke maps\_utility::dialogue_queue("lab_gdn_keepmovingalmostthere");
	}

	common_scripts\utility::flag_wait("flag_gaz_01_scanner_on");
	common_scripts\utility::flag_wait("flag_seeker_checkpoint");
	level.burke maps\_utility::dialogue_queue("lab_gdn_seeker");
	level.burke maps\_utility::dialogue_queue("lab_gdn_cloaksuselessagainstit");
	maps\lab_utility::flag_wait_any_or_timeout(2,"flag_logging_road_seeker_01","flag_player_burke_seeker_01");
	wait(1);
	if(!common_scripts\utility::flag("flag_seeker_patrol_01_clear"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_waitforthepatrolto");
	}

	common_scripts\utility::flag_wait("flag_seeker_patrol_01_clear");
	for(;;)
	{
		if(common_scripts\utility::flag("flag_player_near_burke_seeker_01"))
		{
			level.burke maps\_utility::dialogue_queue("lab_gdn_watchthatbeam");
			common_scripts\utility::flag_wait("flag_seeker_cone_safe_right");
			common_scripts\utility::flag_set("flag_move_up_seeker_01");
			level.burke maps\_utility::dialogue_queue("lab_gdn_okaygo");
			break;
		}
		else if(common_scripts\utility::flag("flag_player_burke_seeker_01"))
		{
			level.burke maps\_utility::dialogue_queue("lab_gdn_watchthatbeam");
			common_scripts\utility::flag_wait("flag_seeker_cone_safe_right");
			common_scripts\utility::flag_set("flag_move_up_seeker_01");
			level.burke maps\_utility::dialogue_queue("lab_gdn_moving");
			break;
		}

		wait(0.25);
	}

	common_scripts\utility::flag_wait("flag_player_near_burke_seeker_02");
	wait(0.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_waitwait");
	common_scripts\utility::flag_wait("flag_seeker_cone_safe_left");
	common_scripts\utility::flag_set("flag_move_up_seeker_02");
	wait(0.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_okaynow");
}

//Function Number: 22
cliff_rappel_dialogue()
{
	common_scripts\utility::flag_wait("flag_seeker_clear");
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_werepastkeepmoving");
	soundscripts\_snd::snd_message("seeker_clear");
	if(common_scripts\utility::flag("flag_vo_stealth_recovered"))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_keepitquietnexttime");
	}

	common_scripts\utility::flag_wait("flag_cormack_meet_start");
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_thisisit");
	level.cormack maps\_utility::dialogue_queue("lab_crk_copy");
	common_scripts\utility::flag_wait("flag_cliff_rappeling_dialogue_start");
	common_scripts\utility::flag_wait("flag_canopy_dialogue_start");
	level.knox maps\_utility::dialogue_queue("lab_knx_holographiccanopy");
}

//Function Number: 23
cliff_rappel_dialogue_nag()
{
	var_00 = ["lab_gdn_mitchelgetclippedon","lab_gdn_hookupmitchel"];
	thread maps\_shg_utility::dialogue_reminder(level.burke,"flag_rappel_start",var_00);
}

//Function Number: 24
facility_breach_dialogue()
{
	common_scripts\utility::flag_wait("flag_facility_breach_start");
	wait(2);
	level.cormack maps\_utility::dialogue_queue("lab_crk_targetbuildingupahead");
	common_scripts\utility::flag_wait("flag_facility_security_camera");
	if(!common_scripts\utility::flag("flag_breach_guards_alerted"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_twoguardsbythecamera");
	}

	wait(3);
	if(!common_scripts\utility::flag("flag_breach_guards_alerted"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellpickatarget");
	}

	thread pick_target_nag_dialogue();
	common_scripts\utility::flag_wait("flag_breach_guards_clear");
	wait(1);
	level.knox maps\_utility::dialogue_queue("lab_knx_clear");
	common_scripts\utility::flag_wait("burke_is_in_position_for_facility_breach");
	level.cormack maps\_utility::dialogue_queue("lab_crk_thisisourbreachpoint");
	thread facility_breach_nag_dialogue();
}

//Function Number: 25
pick_target_nag_dialogue()
{
	wait(8);
	if(!common_scripts\utility::flag("flag_breach_guards_alerted"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_wakeupmitchell");
	}
}

//Function Number: 26
facility_breach_nag_dialogue()
{
	level endon("breaching");
	var_00 = ["lab_crk_mitchellsetthecharge","lab_crk_mitchellmoveit"];
	thread maps\_shg_utility::dialogue_reminder(level.cormack,"breach_start",var_00);
}

//Function Number: 27
research_facility_interior_dialogue()
{
	common_scripts\utility::flag_wait("flag_post_breach_patrol");
	wait(3);
	level.burke maps\_utility::dialogue_queue("lab_gdn_twointhehallway");
	common_scripts\utility::flag_wait_or_timeout("flag_breach_patrol_01_clear",2);
	level.cormack maps\_utility::dialogue_queue("lab_crk_takeemout");
	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead");
	wait(1.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_clear");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_kingpinweveinfiltratedthetarget");
	level maps\_utility::dialogue_queue("lab_kgn_rogerthat");
	level.cormack maps\_utility::dialogue_queue("lab_crk_roger");
}

//Function Number: 28
server_room_approach_dialogue()
{
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_04");
	if(!common_scripts\utility::flag("flag_enemy_server_room_se_dead"))
	{
		if(!common_scripts\utility::flag("flag_obj_bio_weapons_05"))
		{
			level.cormack maps\_utility::dialogue_queue("lab_crk_hitthestairs");
			level.knox maps\_utility::dialogue_queue("lab_knx_gotchacovered");
		}

		common_scripts\utility::flag_wait("flag_se_server_room_start");
		level.cormack thread maps\_utility::dialogue_queue("lab_crk_thisisit");
		thread server_room_guy_killed_by_knox();
	}

	common_scripts\utility::flag_wait("flag_enemy_server_room_se_dead");
	level.knox maps\_utility::dialogue_queue("lab_knx_clear");
}

//Function Number: 29
server_room_guy_killed_by_knox()
{
	level endon("flag_server_room_enemy_killed_by_player");
	common_scripts\utility::flag_wait("flag_server_room_enemy_killed_by_knox");
	level.burke maps\_utility::dialogue_queue("lab_gdn_nevermind");
}

//Function Number: 30
server_room_dialogue()
{
	wait(2);
	level.burke maps\_utility::dialogue_queue("lab_gdn_getonthatconsole");
	thread server_room_nag_dialogue();
}

//Function Number: 31
server_room_nag_dialogue()
{
	var_00 = ["lab_gdn_youreupmitchel","lab_gdn_getmovingmitchell","lab_gdn_mitchellgetonthatconsole"];
	thread maps\_shg_utility::dialogue_reminder(level.burke,"flag_obj_bio_weapons_hack",var_00);
}

//Function Number: 32
research_facility_combat_dialogue()
{
	common_scripts\utility::flag_wait("flag_combat_research_start");
	wait(1);
	level maps\_utility::dialogue_queue("lab_kgn_twothreebeadvised");
	level.knox maps\_utility::dialogue_queue("lab_knx_theyjustactivedasensor");
	level.cormack maps\_utility::dialogue_queue("lab_crk_okaystealthsnolongeran");
	common_scripts\utility::flag_set("flag_research_facility_combat_dialogue_complete");
	wait(0.5);
	common_scripts\utility::flag_set("flag_post_server_room_dialogue_complete");
	level.cormack maps\_utility::dialogue_queue("lab_crk_go2");
}

//Function Number: 33
security_camera_dialogue()
{
	common_scripts\utility::flag_wait("flag_combat_research_bridge_01");
	var_00 = getent("camera_interior_01","script_noteworthy");
	if(isalive(var_00) && level.player maps\_utility::can_see_origin(var_00.origin))
	{
		level.burke maps\_utility::dialogue_queue("lab_gdn_takeoutthatsensor");
	}
}

//Function Number: 34
camera_scanner_interior_trigger_think()
{
	self waittill("trigger");
	if(!isdefined(level.camera_scanner_interior_spotted))
	{
		level.camera_scanner_interior_spotted = 0;
	}

	var_00 = common_scripts\utility::get_linked_ents()[0];
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 endon("stop_scanner_vo_loop");
	var_00 endon("death");
	var_00 thread maps\_utility::notify_delay("stop_scanner_vo_loop",10);
	while(var_00.destructible_parts[0].v["health"] > 0)
	{
		if(level.player maps\_utility::can_see_origin(var_00.origin))
		{
			switch(level.camera_scanner_interior_spotted)
			{
				case 0:
					level.burke important_dialogue_queue("lab_gdn_sensorinthecorner");
					break;

				case 1:
					level.cormack important_dialogue_queue("lab_crk_eyesonasensor");
					break;

				default:
					level.burke important_dialogue_queue("lab_gdn_takeoutthatsensor");
					break;
			}

			level.camera_scanner_interior_spotted++;
			if(level.camera_scanner_interior_spotted > 3)
			{
				level.camera_scanner_interior_spotted = 0;
			}

			var_00 notify("stop_scanner_vo_loop");
		}

		wait(0.05);
	}
}

//Function Number: 35
camera_scanner_interior_killed()
{
	if(!isdefined(level.camera_scanner_interior_killed))
	{
		level.camera_scanner_interior_killed = 0;
	}
	else if(randomfloat(1) < 0.4)
	{
		return;
	}

	wait(randomfloatrange(0.75,1.25));
	switch(level.camera_scanner_interior_killed)
	{
		case 0:
			level.cormack important_dialogue_queue("lab_crk_sensorsdown");
			break;

		case 1:
			level.burke important_dialogue_queue("lab_gdn_sensorsdown");
			break;

		case 2:
			level.cormack important_dialogue_queue("lab_crk_sensorsdead");
			break;

		default:
			level.burke important_dialogue_queue("lab_gdn_sensorsout");
			break;
	}

	level.camera_scanner_interior_killed++;
	if(level.camera_scanner_interior_killed > 3)
	{
		level.camera_scanner_interior_killed = 0;
	}
}

//Function Number: 36
river_room_combat_dialouge()
{
	common_scripts\utility::flag_wait("flag_combat_river_roomt_01");
	level.cormack important_dialogue_queue("lab_crk_flankleftorright",1);
	wait(1);
	common_scripts\utility::flag_wait_any("flag_combat_research_right_01","flag_combat_research_left_01");
	level.burke important_dialogue_queue("lab_gdn_contactbelowus",1);
}

//Function Number: 37
foam_room_dialogue()
{
	common_scripts\utility::flag_wait_all("flag_research_building_combat_complete","flag_player_inside_foam_room");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_werehere");
	wait(1.5);
	level.knox maps\_utility::dialogue_queue("lab_knx_biosparqispickinguptrace");
	level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellplantthefrbs");
	soundscripts\_snd::snd_message("foam_room_crmk_plant_these_frvs");
	thread plant_foam_nag_dialogue();
	common_scripts\utility::flag_wait("flag_obj_neutralize_bio_weapons_planted");
	wait(4);
	level.cormack maps\_utility::dialogue_queue("lab_crk_everyoneout");
	common_scripts\utility::flag_wait("flag_foam_room_clear");
	thread detonate_foam_nag_dialogue();
	wait(1);
	if(!common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_complete"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellhitit");
	}
}

//Function Number: 38
detonate_foam_nag_dialogue()
{
	level endon("flag_obj_neutralize_bio_weapons_complete");
	wait(6);
	if(!common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_complete"))
	{
		while(!common_scripts\utility::flag("flag_foam_room_clear"))
		{
			wait(1);
		}

		level.cormack maps\_utility::dialogue_queue("lab_crk_hitit");
	}
}

//Function Number: 39
plant_foam_nag_dialogue()
{
	var_00[0] = "lab_crk_wakeupmitchell2";
	var_00[1] = "lab_crk_mitchellgetthefrbready";
	var_00[2] = "lab_crk_plantitmitchell";
	wait(randomintrange(5,10));
	while(!common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_planted"))
	{
		var_01 = randomintrange(0,var_00.size);
		level.cormack maps\_utility::dialogue_queue(var_00[var_01]);
		wait(randomintrange(5,10));
	}
}

//Function Number: 40
foam_room_complete_dialogue()
{
	common_scripts\utility::flag_wait("flag_obj_neutralize_bio_weapons_complete");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_kingpinmaterialissecure");
	thread foam_room_video_log();
	level maps\_utility::dialogue_queue("lab_kgn_primarylzistoohot");
	level.cormack maps\_utility::dialogue_queue("lab_crk_understoodweremoving");
	common_scripts\utility::flag_set("flag_foam_room_complete_dialogue");
	soundscripts\_snd::snd_message("foam_room_complete_dialogue");
	level notify("courtyard_red_strobe");
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_keepsgettingbetter");
	common_scripts\utility::flag_set("flag_obj_locate_atlas_tank");
}

//Function Number: 41
foam_room_video_log()
{
	wait(1);
	thread maps\_shg_utility::play_videolog("lab_videolog_02","screen_add");
}

//Function Number: 42
courtyard_entry_dialogue()
{
	common_scripts\utility::flag_wait("flag_combat_courtyard_general_01");
	wait(4);
	level.cormack maps\_utility::dialogue_queue("lab_crk_contact");
}

//Function Number: 43
courtyard_mech_start_dialogue()
{
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_block");
	wait(2);
	level.burke maps\_utility::dialogue_queue("lab_gdn_ast");
	level.cormack maps\_utility::dialogue_queue("lab_crk_shitdrawitsfire");
}

//Function Number: 44
courtyard_door_hack_start_dialogue()
{
	common_scripts\utility::flag_wait("flag_hangar_mech_01_dead");
	soundscripts\_snd::snd_message("courtyard_door_hack_start_dialogue");
	wait(2);
	level.cormack maps\_utility::dialogue_queue("lab_crk_knoxgetthisdooropen");
	common_scripts\utility::flag_wait("flag_courtyard_door_hack_dialogue");
	level.knox maps\_utility::dialogue_queue("lab_knx_runningabypasscoverme");
	wait(1);
	level.knox maps\_utility::dialogue_queue("lab_knx_imgettinginterferencefromthat");
	level.cormack maps\_utility::dialogue_queue("lab_crk_thatsyoumitchell");
	common_scripts\utility::flag_set("flag_courtyard_door_hack_dialogue_complete");
	common_scripts\utility::flag_set("flag_obj_courtyard_jammer_start");
	thread courtyard_jammer_plant_nag_dialogue();
}

//Function Number: 45
courtyard_jammer_plant_nag_dialogue()
{
	level endon("flag_obj_jammer_interact");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	for(var_05 = 0;var_05 < 5;var_05++)
	{
		wait(12);
		if(!common_scripts\utility::flag("flag_courtyard_on_roof"))
		{
			if(var_00 == 0)
			{
				level.burke maps\_utility::dialogue_queue("lab_gdn_lookforaladder");
				var_00 = 1;
			}
			else if(var_02 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellplantthejammer");
				var_02 = 1;
			}
			else if(var_01 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_scramblersontopofthat");
				var_01 = 1;
			}
			else if(var_03 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_plantthatjammer");
				var_03 = 1;
			}
			else if(var_04 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellgetthatjammerhooked");
				var_04 = 1;
			}

			continue;
		}

		if(common_scripts\utility::flag("flag_courtyard_on_roof"))
		{
			if(var_02 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellplantthejammer");
				var_02 = 1;
				continue;
			}

			if(var_03 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_plantthatjammer");
				var_03 = 1;
				continue;
			}

			if(var_04 == 0)
			{
				level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellgetthatjammerhooked");
				var_04 = 1;
			}
		}
	}
}

//Function Number: 46
courtyard_jammer_complete_dialogue()
{
	common_scripts\utility::flag_wait("flag_obj_jammer_complete");
	wait(1);
	level.knox maps\_utility::dialogue_queue("lab_knx_signalsclear");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_moretangosmovingin");
	common_scripts\utility::flag_set("flag_courtyard_cover_Knox_dialogue_complete");
	common_scripts\utility::flag_set("flag_obj_courtyard_defend_start");
	soundscripts\_snd::snd_message("courtyard_defend_start");
}

//Function Number: 47
courtyard_squad_defend_nag_dialogue()
{
	level endon("flag_obj_tank_02");
	var_00 = getent("courtyard_defend_volume","targetname");
	var_01 = 0;
	wait(1);
	if(common_scripts\utility::flag("flag_courtyard_on_roof"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellregroupdownhere");
		var_01 = 1;
	}
	else
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellrallyup");
	}

	wait(6);
	common_scripts\utility::flag_waitopen("flag_courtyard_defending");
	if(var_01 == 1)
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellrallyup");
		return;
	}

	common_scripts\utility::flag_wait("flag_courtyard_on_roof");
	level.cormack maps\_utility::dialogue_queue("lab_crk_mitchellregroupdownhere");
}

//Function Number: 48
courtyard_door_hack_complete_dialogue()
{
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_hack_success");
	wait(1);
	level.knox maps\_utility::dialogue_queue("lab_knx_doorsopenletsmove");
	courtyard_squad_defend_nag_dialogue();
}

//Function Number: 49
tank_hangar_pas_dialogue()
{
	level endon("flag_tank_hangar_sweep_dialogue");
	common_scripts\utility::flag_wait("flag_hangar_pas_01");
	level maps\_utility::dialogue_queue("lab_pas_wehavehostilesinthe");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_vehiclehangarsthroughhere");
	common_scripts\utility::flag_wait("flag_hangar_pas_02");
	level maps\_utility::dialogue_queue("lab_pas_allsecurityteamsreportto");
	common_scripts\utility::flag_wait("flag_hangar_pas_03");
	maps\_utility::dialogue_queue("lab_pas_coderedinallsectors");
}

//Function Number: 50
foam_corridor_dialogue()
{
	common_scripts\utility::flag_wait("flag_foam_corridor_another_door_dialogue");
	wait(8);
	level.cormack maps\_utility::dialogue_queue("lab_crmk_anotherdoor");
	wait(0.5);
	level.knox maps\_utility::dialogue_queue("lab_knx_onit");
	thread foam_corridor_nag_dialogue();
	common_scripts\utility::flag_wait("flag_foam_corridor_improvise_dialogue");
	wait(2);
	common_scripts\utility::flag_wait("flag_foam_corridor_exit_door_open_dialogue");
	level.knox maps\_utility::dialogue_queue("lab_knx_itsopen");
}

//Function Number: 51
foam_corridor_nag_dialogue()
{
	level endon("flag_foam_corridor_improvise_dialogue");
	common_scripts\utility::flag_wait("flag_player_inside_foam_corridor");
	level.burke maps\_utility::dialogue_queue("lab_brk_backup");
	wait(4);
	common_scripts\utility::flag_wait("flag_player_inside_foam_corridor");
	level.burke maps\_utility::dialogue_queue("lab_brk_getout");
}

//Function Number: 52
tank_hangar_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_hangar_sweep_dialogue");
	level.cormack maps\_utility::dialogue_queue("lab_crk_sweeptheroom");
	wait(4.5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_clear3");
	wait(1);
	level.cormack maps\_utility::dialogue_queue("lab_crk_thisisourride");
	common_scripts\utility::flag_set("flag_move_knox_to_console");
	level.knox maps\_utility::dialogue_queue("lab_knx_copythat");
	wait(0.1);
	level.burke thread maps\_utility::dialogue_queue("lab_gdn_t740stillonlyaprototype");
	common_scripts\utility::flag_wait("flag_tank_hangar_reveal_dialogue");
	level.knox maps\_utility::delaythread(2.4,::maps\_utility::dialogue_queue,"lab_knx_poweringitup");
	level.cormack maps\_utility::delaythread(7,::maps\_utility::dialogue_queue,"lab_crk_handsupwhoknowshow");
	level.burke maps\_utility::delaythread(11,::maps\_utility::dialogue_queue,"lab_gdn_mitchellanditrainedup");
	level.knox maps\_utility::delaythread(16.1,::maps\_utility::dialogue_queue,"lab_knx_disengaging");
	level.knox maps\_utility::delaythread(19,::maps\_utility::dialogue_queue,"lab_knx_werechargedandfullyarmed");
	level.cormack maps\_utility::delaythread(21,::maps\_utility::dialogue_queue,"lab_crk_kingpinthisissentineltwothree");
	level maps\_utility::delaythread(29,::maps\_utility::dialogue_queue,"lab_kgn_rogerthatsentineltwothree");
	level.cormack maps\_utility::delaythread(34,::maps\_utility::dialogue_queue,"lab_crk_alrighteveryonein");
}

//Function Number: 53
tank_board_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_board_dialogue");
	wait(5);
	level.burke maps\_utility::dialogue_queue("lab_gdn_allsystemscheckgreen");
	level.burke maps\_utility::dialogue_queue("lab_gdn_alrightmitchelljustlikein");
	common_scripts\utility::flag_wait("flag_player_in_hovertank_dialogue");
	wait(1);
	level maps\_utility::dialogue_queue("lab_sir_weaponsystemsonline");
	wait(1);
	level.burke maps\_utility::dialogue_queue("lab_gdn_moveitoutmitchell");
	thread tank_courtyard_gate_dialogue();
	if(isdefined(level.hovertank))
	{
		common_scripts\utility::waittill_any_ents(level.player,"LISTEN_attack_button_pressed",level.hovertank,"trophy_deployed");
	}

	wait(0.75);
	common_scripts\utility::flag_set("flag_tank_courtyard_dialogue");
	soundscripts\_snd::snd_music_message("begin_tank_combat");
}

//Function Number: 54
tank_courtyard_gate_dialogue()
{
	wait(4);
	if(!common_scripts\utility::flag("flag_tank_courtyard_dialogue"))
	{
		level.cormack maps\_utility::dialogue_queue("lab_crk_throughthegate2");
		return;
	}

	common_scripts\utility::flag_wait("flag_courtyard_gate_2_dialogue");
	level.cormack maps\_utility::dialogue_queue("lab_crk_throughthegate2");
}

//Function Number: 55
tank_courtyard_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_courtyard_dialogue");
	wait(0.5);
	level.burke important_dialogue_queue("lab_gdn_theyreontous",1);
	level.burke important_dialogue_queue("lab_gdn_usemissilesagainstinfantry",1);
	wait(4);
	if(!issubstr(level.current_weapon,"missile"))
	{
		level.burke important_dialogue_queue("lab_gdn_switchtomissiles",1);
	}
}

//Function Number: 56
tank_road_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_road_infantry_dialogue");
	wait(2);
	level.burke important_dialogue_queue("lab_gdn_infantryaheadofus",1);
	thread tank_road_tank_killed_dialogue();
	common_scripts\utility::flag_wait("flag_tank_road_log_enemies_dialogue");
	if(!common_scripts\utility::flag("flag_log_pile_scripted_destroyed"))
	{
		if(!issubstr(level.current_weapon,"missile"))
		{
			level.burke important_dialogue_queue("lab_gdn_switchtomissiles",1);
		}
	}
}

//Function Number: 57
tank_road_enemy_tank_dialogue(param_00)
{
	param_00 endon("death");
	var_01 = param_00.health;
	wait(5);
	level.burke important_dialogue_queue("lab_gdn_armorapproaching",1);
	if(!issubstr(level.current_weapon,"cannon"))
	{
		level.burke important_dialogue_queue("lab_gdn_switchtoslugs",1);
	}
}

//Function Number: 58
tank_road_tank_killed_dialogue()
{
	common_scripts\utility::flag_wait("flag_first_tank_killed");
	wait(2);
	level important_dialogue_queue("lab_kgn_sentineltwothreeihaveahelo",1);
	level.cormack important_dialogue_queue("lab_crk_copythatcoordinatesconfirmed",1);
}

//Function Number: 59
tank_field_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_field_dialogue");
	thread tank_field_vraps_dialogue();
	common_scripts\utility::flag_wait("flag_tank_field_lz_ahead_dialogue");
	common_scripts\utility::flag_wait_any("flag_tank_field_turn_right_dialogue","flag_tank_field_turn_left_dialogue");
	if(common_scripts\utility::flag("flag_tank_field_turn_right_dialogue"))
	{
		level.cormack important_dialogue_queue("lab_crk_headright",1);
	}
	else
	{
		level.cormack important_dialogue_queue("lab_crk_turnleft",1);
	}

	level.cormack important_dialogue_queue("lab_crk_acrosstheriver",1);
	common_scripts\utility::flag_wait("flag_tank_field_tank_dialogue");
	wait(4);
	level.burke important_dialogue_queue("lab_gdn_tankapproaching",1);
}

//Function Number: 60
tank_field_vraps_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_vraps_dialogue");
	level.cormack important_dialogue_queue("lab_crk_vrapsinbound",1);
}

//Function Number: 61
tank_field_choppers_dialogue(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isalive(var_02) && issubstr(var_02.classname,"warbird"))
		{
			level.burke important_dialogue_queue("lab_gdn_warbirdonourleft",1);
		}
	}

	wait(3);
	if(issubstr(level.current_weapon,"antiair"))
	{
		return;
	}

	var_04 = 0;
	foreach(var_02 in param_00)
	{
		if(isalive(var_02))
		{
			var_04++;
		}
	}

	if(var_04 > 0)
	{
		level.burke important_dialogue_queue("lab_gdn_empthechoppers",1);
	}
}

//Function Number: 62
tank_clearing_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_field_lz_over_ridge_dialogue");
	level.cormack important_dialogue_queue("lab_crk_thelzshouldbejust",1);
	wait(2);
	level.burke important_dialogue_queue("lab_gdn_warbirdincoming",1);
	common_scripts\utility::flag_wait("flag_tank_clearing_tanks");
	wait(2);
	level.cormack important_dialogue_queue("lab_crk_tankscomingdowntheroad",1);
	common_scripts\utility::flag_wait("flag_tank_clearing_infantry_dialogue");
	level.cormack important_dialogue_queue("lab_crk_moreinfantrycomingin",1);
}

//Function Number: 63
tank_ascent_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_ascent_hill_dialogue");
	level.cormack important_dialogue_queue("lab_crk_upthehill",1);
	common_scripts\utility::flag_wait("flag_tank_ascent_dialogue");
	level.burke important_dialogue_queue("lab_gdn_lzisupahead",1);
	wait(2);
	if(!common_scripts\utility::flag("flag_ascent_warbird_dead"))
	{
		level.burke important_dialogue_queue("lab_gdn_empthatwarbird",1);
	}

	wait(4);
	if(!issubstr(vehicle_scripts\_hovertank::get_current_weapon_name(),"cannon"))
	{
		level.burke important_dialogue_queue("lab_gdn_useyourcannononthose",1);
	}

	common_scripts\utility::flag_wait("flag_tank_ascent_bail_dialogue");
	level.burke important_dialogue_queue("lab_gdn_getreadytobailout",1);
}

//Function Number: 64
tank_systems_dialogue()
{
	thread tank_reloading_dialogue();
}

//Function Number: 65
tank_status_dialogue()
{
	level.burke maps\_utility::dialogue_queue("lab_gdn_ourtrophysystemisempty");
	level.burke maps\_utility::dialogue_queue("lab_brk_reloadtrophy");
	level.burke maps\_utility::dialogue_queue("lab_gdn_wecanttakeanotherhit");
	level.burke maps\_utility::dialogue_queue("lab_gdn_weregettingbeatenup");
	level.burke maps\_utility::dialogue_queue("lab_gdn_keepmovingmitchell2");
}

//Function Number: 66
tank_reloading_dialogue()
{
	level endon("hovertank_end");
	level waittill("hovertank_cannon_reloading");
	level.burke important_dialogue_queue("lab_gdn_reloading");
	for(;;)
	{
		level waittill("hovertank_cannon_reloading");
		if(randomfloat(1) < 0.15)
		{
			level.burke important_dialogue_queue("lab_gdn_reloading");
		}
	}
}

//Function Number: 67
tank_exit_dialogue()
{
	common_scripts\utility::flag_wait("flag_tank_exit_dialogue");
	level.cormack maps\_utility::dialogue_queue("lab_crk_thisisit2");
	level.burke maps\_utility::dialogue_queue("lab_gdn_everybodyoutmovemovemove");
	wait(1);
	level maps\_utility::dialogue_queue("lab_ch5_falcon22cominginfor");
}

//Function Number: 68
exfil_dialogue()
{
	common_scripts\utility::flag_wait("flag_exfil_start_dialogue");
	level.cormack maps\_utility::dialogue_queue("lab_crk_thatsourbird");
	wait(5);
	level maps\_utility::dialogue_queue("lab_ch5_standingbytoloadpassengers");
	common_scripts\utility::flag_wait("flag_exfil_loadup_dialogue");
	level.cormack maps\_utility::dialogue_queue("lab_crk_loaduploadup");
}

//Function Number: 69
init_pcap_vo()
{
	var_00 = 1;
	if(level.currentgen)
	{
		if(!istransientloaded("lab_intro_tr"))
		{
			var_00 = 0;
		}
	}

	if(var_00)
	{
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_intro_guy1,"aud_lab_intro_guy1_start",::pcap_vo_lab_intro_guy1);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_wallclimb_player_hero_01,"aud_lab_wallclimb_player_hero_01_start",::pcap_vo_lab_wallclimb_player_hero_01);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_cliff_rappel_meetup_burke,"aud_lab_cliff_rappel_meetup_burke_start",::pcap_vo_lab_cliff_rappel_meetup_burke);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_cliff_rappel_meetup_cormack,"aud_lab_cliff_rappel_meetup_cormack_start",::pcap_vo_lab_cliff_rappel_meetup_cormack);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_cliff_rappel_meetup_knox,"aud_lab_cliff_rappel_meetup_knox_start",::pcap_vo_lab_cliff_rappel_meetup_knox);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_cliff_rappel_jump_burke,"aud_lab_cliff_rappel_jump_burke_start",::pcap_vo_lab_cliff_jump_burke);
	}

	var_00 = 1;
	if(level.currentgen)
	{
		if(istransientloaded("lab_intro_tr"))
		{
			level waittill("tff_post_intro_to_middle");
		}
		else if(!istransientloaded("lab_middle_tr"))
		{
			var_00 = 0;
		}
	}

	if(var_00)
	{
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_serverroom_guy1,"aud_lab_serverroom_guy1_start",::pcap_vo_lab_serverroom_burke);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_serverroom_guy2,"aud_lab_serverroom_guy2_start",::pcap_vo_lab_serverroom_cormack);
		soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_serverroom_guy3,"aud_lab_serverroom_guy3_start",::pcap_vo_lab_serverroom_knox);
	}

	if(level.currentgen)
	{
		if(!istransientloaded("lab_outro_tr"))
		{
			level waittill("tff_post_middle_to_outro");
		}
	}

	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_chopper_evac_enter_burke,"aud_lab_chopper_exfil_burke_start",::pcap_vo_lab_chopper_evac_enter_burke);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%lab_chopper_evac_enter_cormack,"aud_lab_chopper_exfil_cormack_start",::pcap_vo_lab_chopper_evac_enter_cormack);
}

//Function Number: 70
pcap_vo_lab_intro_guy1(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_theyreonus",2);
	wait(2);
	common_scripts\utility::flag_set("flag_intro_run_dialogue_start");
}

//Function Number: 71
pcap_vo_lab_wallclimb_player_hero_01(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_cmon",0);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_exosupcloak",3.12);
}

//Function Number: 72
pcap_vo_lab_cliff_rappel_meetup_burke(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_weneedanexfilsharpish",2.09);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_themissionwasoverbefore",9.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_idontseeafucking",15.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_wevelosttheinitiativewe",27.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_thisthinggoessidewaysits",32.03);
}

//Function Number: 73
pcap_vo_lab_cliff_rappel_meetup_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_yougood",1.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_missionisntoverkitup",7.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_werenotleavinguntilwe",11.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_knoxshowem",17.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_theyvegotsomethingtohide",26.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_thereisnootherday",29.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_itsalwaysbeenonme",34.24);
}

//Function Number: 74
pcap_vo_lab_cliff_rappel_meetup_knox(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_sendingyoumyfeed",20.15);
}

//Function Number: 75
pcap_vo_lab_cliff_jump_burke(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_hesahardbastardill",6.03);
}

//Function Number: 76
pcap_vo_lab_serverroom_burke(param_00)
{
}

//Function Number: 77
pcap_vo_lab_serverroom_cormack(param_00)
{
	soundscripts\_snd::snd_message("begin_pcap_vo_lab_serverroom_cormack");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_walksrightpastplayergiving",2.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_okayburnitdown",21.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_approachestheplayertheresmore",25.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_copythat",36.13);
}

//Function Number: 78
pcap_vo_lab_serverroom_knox(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_runsuptoaterminal",8.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_hurriesovertocormackpats",12.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_bingowevegotthepackage",17.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_thermiteout",23.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_onme",39.12);
	level maps\_utility::delaythread(11.4,::maps\_utility::dialogue_queue,"lab_kgn_standingbytoreceivepackage");
	level maps\_utility::delaythread(19.9,::maps\_utility::dialogue_queue,"lab_kgn_uplinkconfirmed");
	level maps\_utility::delaythread(33.1,::maps\_utility::dialogue_queue,"lab_kgn_packagerecievedgoodjob");
}

//Function Number: 79
pcap_vo_lab_serverroom_promo_knox(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_runsuptoaterminal",8.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_hurriesovertocormackpats",12.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_bingowevegotthepackage",17.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_thermiteout",23.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_knx_promo_om",39.12);
	level maps\_utility::delaythread(11.4,::maps\_utility::dialogue_queue,"lab_kgn_standingbytoreceivepackage");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_kgn_uplinkconfirmed",19.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_kpn_promo_st",33.03);
}

//Function Number: 80
pcap_vo_lab_serverroom_promo_cormack(param_00)
{
	soundscripts\_snd::snd_message("begin_pcap_vo_lab_serverroom_cormack");
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_walksrightpastplayergiving",2.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_okayburnitdown",21.03);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_prepromo",25.12);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo1",28);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo2",33.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo3",41.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo4",47.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo5",54.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo6",63.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crmk_promo7",69.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_copythat",79.13);
}

//Function Number: 81
pcap_vo_lab_chopper_evac_enter_burke(param_00)
{
	level.player soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_plt_confirmfourpaxonboard",6.06);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_onestepaheadofyou",12.03);
	level.player soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_plt_extractcompleteheadinghome",23.12);
}

//Function Number: 82
pcap_vo_lab_chopper_evac_enter_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_gdn_wereupfour",3.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_shit2",9.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_niceworksoldier",17.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("lab_crk_toknoxoncethisstuff",19.27);
	maps\_utility::delaythread(20,::soundscripts\_snd::snd_music_message,"lab_finale");
}

//Function Number: 83
ai_toggle_cloak_start_vo(param_00)
{
	if(isdefined(param_00) && param_00 == 0)
	{
		return;
	}

	var_01 = undefined;
	if(!isdefined(param_00) || param_00 == -1)
	{
		var_01 = common_scripts\utility::random(["lab_gdn_chargeyourcloak","lab_gdn_holdupcharging","lab_gdn_chargeup"]);
	}
	else if(param_00 == 1)
	{
		var_01 = "lab_gdn_chargeyourcloak";
	}
	else if(param_00 == 2)
	{
		var_01 = "lab_gdn_holdupcharging";
	}
	else if(param_00 == 3)
	{
		var_01 = "lab_gdn_chargeup";
	}

	maps\_utility::dialogue_queue(var_01);
}

//Function Number: 84
ai_toggle_cloak_complete_vo(param_00)
{
	if(isdefined(param_00) && param_00 == 0)
	{
		return;
	}

	var_01 = undefined;
	if(!isdefined(param_00) || param_00 == -1)
	{
		var_01 = common_scripts\utility::random(["lab_gdn_moving","lab_gdn_okaygo"]);
	}
	else if(param_00 == 1)
	{
		var_01 = "lab_gdn_moving";
	}
	else if(param_00 == 2)
	{
		var_01 = "lab_gdn_okaygo";
	}

	maps\_utility::dialogue_queue(var_01);
}

//Function Number: 85
important_dialogue_queue(param_00,param_01)
{
	if(!common_scripts\utility::flag("flag_important_dialogue_playing") || isdefined(param_01) && param_01)
	{
		level maps\_utility::function_stack(::important_dialogue,self,param_00,param_01);
	}
}

//Function Number: 86
important_dialogue(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag("flag_se_hovertank_exit"))
	{
		return;
	}

	if(isdefined(param_02) && param_02)
	{
		common_scripts\utility::flag_set("flag_important_dialogue_playing");
	}

	param_00 maps\_utility::dialogue_queue(param_01);
	if(isdefined(param_02) && param_02)
	{
		common_scripts\utility::flag_clear("flag_important_dialogue_playing");
	}
}

//Function Number: 87
player_out_of_bounds_warning_vo()
{
	var_00 = 0;
	for(;;)
	{
		if(level.player_out_of_bounds_warning == 1)
		{
			if(var_00 <= 0)
			{
				var_00 = randomfloatrange(3,5);
				play_out_of_bounds_vo(level.burke);
			}
			else
			{
				var_00 = var_00 - 0.05;
			}
		}

		wait(0.05);
	}
}

//Function Number: 88
play_out_of_bounds_vo(param_00)
{
	var_01 = 3;
	if(!isdefined(level.last_warning_line))
	{
		level.last_warning_line = -1;
		level.warning_lines = ["lab_gdn_mitchellonme","lab_gdn_letsgo","lab_gdn_thisway"];
	}

	for(var_02 = randomint(var_01);var_02 == level.last_warning_line;var_02 = randomint(var_01))
	{
	}

	level.last_warning_line = var_02;
	var_03 = level.warning_lines[var_02];
	param_00 maps\_utility::dialogue_queue(var_03);
}