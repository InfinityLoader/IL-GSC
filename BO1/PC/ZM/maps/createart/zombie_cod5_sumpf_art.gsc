
main()
{
	level.tweakfile = true;
	SetDvar("visionstore_glowTweakEnable", "1");
	setdvar("visionstore_glowTweakRadius0", "2");
	setdvar("visionstore_glowTweakRadius1", "");
	setdvar("visionstore_glowTweakBloomCutoff", "0.5");
	setdvar("visionstore_glowTweakBloomDesaturation", "0");
	setdvar("visionstore_glowTweakBloomIntensity0", "0.9");
	setdvar("visionstore_glowTweakBloomIntensity1", "");
	setdvar("visionstore_glowTweakSkyBleedIntensity0", "");
	setdvar("visionstore_glowTweakSkyBleedIntensity1", "");
	VisionSetNaked("zombie_sumpf", 0);
}

 