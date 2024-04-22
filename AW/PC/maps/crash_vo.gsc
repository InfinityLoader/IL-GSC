/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_vo.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 183 ms
 * Timestamp: 4/22/2024 2:27:24 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_dialogue_flags();
	setup_vo();
	thread start_dialogue_threads();
	thread init_pcap_vo();
}

//Function Number: 2
init_dialogue_flags()
{
}

//Function Number: 3
setup_vo()
{
}

//Function Number: 4
start_dialogue_threads()
{
}

//Function Number: 5
init_pcap_vo()
{
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_atlas_plane_crash_ilona,"aud_crash_atlas_plane_crash_ilona_start",::crash_plane_crash_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_gideon,"aud_crash_gideon_rescue_gideon_start",::crash_gideon_rescue_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_gideon,"aud_crash_gideon_rescue_gideon_start2",::crash_gideon_rescue2_gideon);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_cormack,"aud_crash_gideon_rescue_cormack_start",::crash_gideon_rescue_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_cormack,"aud_crash_gideon_rescue_cormack_start2",::crash_gideon_rescue2_cormack);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_ilana,"aud_crash_gideon_rescue_ilona_start",::crash_gideon_rescue_ilona);
	soundscripts\_snd_pcap::snd_pcap_add_notetrack_mapping(%crash_gideon_rescue_ilana,"aud_crash_gideon_rescue_ilona_start2",::crash_gideon_rescue2_ilona);
}

//Function Number: 6
crash_plane_crash_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_iln_securingcargo",2.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_iln_punctual",13.21);
}

//Function Number: 7
crash_gideon_rescue_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_trustme",1.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_exertion1",5.03);
}

//Function Number: 8
crash_gideon_rescue2_gideon(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_exertion2",0.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_thisisatlaszeroone",6.27);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_andweallwouldbe",17.24);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_ironsisplanninga",23.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_gdn_ironshasbetrayed",35.24);
}

//Function Number: 9
crash_gideon_rescue_cormack(param_00)
{
}

//Function Number: 10
crash_gideon_rescue2_cormack(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_crk_ifhewantedtokillus",31.18);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_crk_okaythenleadtheway",45.18);
}

//Function Number: 11
crash_gideon_rescue_ilona(param_00)
{
}

//Function Number: 12
crash_gideon_rescue2_ilona(param_00)
{
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_iln_gideon",2.24);
	soundscripts\_snd_pcap::snd_pcap_play_radio_vo_30fps("crsh_atr_report",4.21);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_as1_what",10.15);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_iln_whynowgideon",14);
	param_00 soundscripts\_snd_pcap::snd_pcap_play_vo_30fps("crsh_iln_andweresupposedtofollow",29.15);
}