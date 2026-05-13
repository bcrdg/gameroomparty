// blocked_words.js
// Add slurs, racial terms, sexual terms, etc. here (case-insensitive matching)
// The game blocks exact matches AND checks if any of these appear as substrings in the name
// "poopshit" = fine, slurs/hate speech = blocked
// Edit this list anytime - no need to touch the game code

var BLOCKED_WORDS = [
  // Racial slurs
  "nigger", "nigga", "nigg3r", "n1gger", "n1gga",
  "chink", "ch1nk",
  "spic", "sp1c",
  "wetback", "w3tback",
  "kike", "k1ke",
  "gook", "g00k",
  "coon", "c00n",
  "darkie", "darky",
  "beaner",
  "towelhead",
  "raghead",
  "redskin",
  "zipperhead",
  "jigaboo",
  "porch monkey",
  "white power",
  "heil hitler",
  "sieg heil",
  "1488", "14/88",

  // Sexual
  "fuck", "fuk", "fck", "f u c k", "phuck", "phuk",
  "pussy", "pu55y", "puss1",
  "cock", "c0ck",
  "dick", "d1ck",
  "penis", "pen1s",
  "vagina", "vag1na",
  "cunt", "c u n t", "kunt",
  "whore", "wh0re",
  "slut", "sl u t",
  "blowjob", "blow job",
  "handjob", "hand job",
  "dildo", "d1ldo",
  "orgasm",
  "rape", "r4pe",
  "molest",
  "pedophile", "pedo", "ped0",

  // Homophobic
  "faggot", "fag", "f4g", "f4ggot",
  "dyke", "dyk3",
  "tranny", "tr4nny",

  // Hate phrases (substring match catches these)
  "suck", "die ", " die",
  "kill all",
  "gas the",
  "lynch",

  // Misc offensive
  "retard", "r3tard", "ret4rd",
  "nazi", "n4zi"
];
