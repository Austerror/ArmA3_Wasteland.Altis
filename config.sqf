//	@file Version: 1.0
//	@file Name: config.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, [GoT] JoSchaap, AgentRev
//	@file Created: 20/11/2012 05:13
//	@file Description: Main config.

// For SERVER CONFIG, values are in server\init.sqf

// Towns and cities array
// Marker Name, Diameter, City Name
cityList = compileFinal str
[
	["Town_1", 400, "Kavala"],
	["Town_2", 300, "Agios Dionysios"],
	["Town_3", 150, "Abdera"],
	["Town_4", 250, "Athira"],
	["Town_5", 200, "Telos"],
	["Town_6", 200, "Sofia"],
	["Town_7", 200, "Paros"],
	["Town_8", 300, "Pyrgos"],
	["Town_9", 150, "Selakano"],
	["Town_10", 200, "Vikos"],
	["Town_11", 250, "Zaros"],
	["Town_12", 250, "Neochori"],
	["Town_13", 250, "Aggelochori"],
	["Town_14", 200, "Panochori"],
	["Town_15", 200, "Charkia"],
	["Town_16", 150, "Chalkeia"],
	["Town_17", 150, "Oreokastro"],
	["Town_18", 100, "Dump"],
	["Town_19", 125, "Negades"],
	["Town_20", 100, "Frini"],
	["Town_21", 100, "Thronos"],
	["Town_22", 50, "Faros"],
	["Town_23", 100, "Krya Nera"],
	["Town_24", 200, "Gelati"],
	["Town_25", 150, "Ifestiona"],
	["Town_26", 50, "Cap Zefyris"],
	["Town_27", 150, "Kalithea"],
	["Town_28", 150, "Ioannina"],
	["Town_29", 250, "Pefkas Bay"],
	["Town_30", 250, "Molos"],
	["Town_31", 200, "Gatolia"],
	["Town_32", 100, "Power Plant"],
	["Town_33", 150, "Cap Kategidis"],
	["Town_34", 200, "Dorida"],
	["Town_35", 250, "Aktinarki"],
	["Town_36", 50, "Surf Club"],
	["Town_37", 300, "Panagia"],
	["Town_38", 150, "Feres"],
	["Town_39", 100, "Trachia"],
	["Town_40", 50, "Magos"],
	["Town_41", 100, "Agia Triada"],
	["Town_42", 100, "Gori"],
	["Town_43", 250, "Agios Konstantinos"],
	["Town_44", 100, "Orino"],
	["Town_45", 300, "Gravia"],
	["Town_46", 200, "Kalochori"],
	["Town_47", 200, "Rodopoli"],
	["Town_48", 150, "Anthrakia"],
	["Town_49", 200, "Power Plant"],
	["Town_50", 150, "Factory"],
	["Town_51", 150, "Kore"],
	["Town_52", 100, "Topolia"],
	["Town_53", 200, "Lakka"],
	["Town_54", 150, "Stavros"],
	["Town_55", 100, "Alikampos"],
	["Town_56", 50, "Agia Stemma"],
	["Town_57", 100, "Factory"],
	["Town_58", 200, "Poliakko"],
	["Town_59", 100, "Katalaki"],
	["Town_60", 150, "Therisa"],
	["Town_61", 200, "Nari"],
	["Town_62", 100, "Edessai"],
	["Town_63", 100, "Athanos"]
];

cityLocations = [];

config_items_jerrycans_max = compileFinal "1";
config_items_syphon_hose_max = compileFinal "1";

config_refuel_amount_default = compileFinal "0.25";
config_refuel_amounts = compileFinal str
[
	["Quadbike_01_base_F", 0.50],
	["Tank", 0.10],
	["Air", 0.10]
];

// Territory system definitions. See territory/README.md for more details.
//
// Format is:
// 1 - Territory marker name. Must begin with 'TERRITORY_'
// 2 - Descriptive name
// 3 - Monetary value
// 4 - Territory category, currently unused. See territory/README.md for details.
config_territory_markers = compileFinal str
[
	//["TERRITORY_AIRPORT_TEST", "Main Airport", 500, "AIRFIELD"] // Also add to the map to test
];

