if !(isClass(configFile/"CfgPatches"/"BWA3_Common")) exitwith {};
private "_crate";
_crate = _this;

_crate call NTA_fnc_crate_clear_all;
_crate addBackpackcargoGlobal ["B_Parachute", 4];
_crate addItemcargoGlobal ["ToolKit", 1];
_crate addMagazinecargoGlobal ["BWA3_30Rnd_556x45_G36",6];
_crate addMagazinecargoGlobal ["BWA3_200Rnd_556x45", 2];
_crate addMagazinecargoGlobal ["BWA3_20Rnd_762x51_G28", 2];
_crate addMagazinecargoGlobal ["BWA3_10Rnd_762x51_G28", 2];
_crate addmagazinecargoGlobal ["DemoCharge_Remote_Mag", 2];
_crate addMagazinecargoGlobal ["BWA3_120Rnd_762x51", 2];
_crate addmagazinecargoGlobal ["DemoCharge_Remote_Mag", 2];
_crate addBackpackCargoGlobal ["BWA3_AssaultPack_Medic",1];