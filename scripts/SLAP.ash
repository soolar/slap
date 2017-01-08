script "Soolar's Lag-Annihilating Pummeler";
//notify "soolar the second";
import <zlib.ash>

// data initialization
// some helper functions for data initialization, for items
boolean HasEntry(item [int] list, item entry)
{
  foreach i,it in list
  {
    if(entry == it)
      return true;
  }
  return false;
}
boolean AddEntry(item [int] list, item entry, boolean force)
{
  if(!force && list.HasEntry(entry))
    return false;
  list[list.count()] = entry;
  return true;
}
boolean AddEntry(item [int] list, item entry)
{
  return AddEntry(list, entry, false);
}
int AddEntries(item [int] list, boolean [item] entries, boolean force)
{
  int failCount = 0;

  foreach entry in entries
  {
    boolean success = list.AddEntry(entry, force);
    if(!success)
      ++failCount;
  }

  return failCount;
}
int AddEntries(item [int] list, boolean [item] entries)
{
  return AddEntries(list, entries, false);
}

// same stuff for skills, pls gib templating
boolean HasEntry(skill [int] list, skill entry)
{
  foreach i,sk in list
  {
    if(entry == sk)
      return true;
  }
  return false;
}
boolean AddEntry(skill [int] list, skill entry, boolean force)
{
  if(!force && list.HasEntry(entry))
    return false;
  list[list.count()] = entry;
  return true;
}
boolean AddEntry(skill [int] list, skill entry)
{
  return AddEntry(list, entry, false);
}
int AddEntries(skill [int] list, boolean [skill] entries, boolean force)
{
  int failCount = 0;

  foreach entry in entries
  {
    boolean success = list.AddEntry(entry, force);
    if(!success)
      ++failCount;
  }

  return failCount;
}
int AddEntries(skill [int] list, boolean [skill] entries)
{
  return AddEntries(list, entries, false);
}

// same stuff again for monsters, pls pls gib templates
boolean HasEntry(monster [int] list, monster entry)
{
  foreach i,it in list
  {
    if(entry == it)
      return true;
  }
  return false;
}
boolean AddEntry(monster [int] list, monster entry, boolean force)
{
  if(!force && list.HasEntry(entry))
    return false;
  list[list.count()] = entry;
  return true;
}
boolean AddEntry(monster [int] list, monster entry)
{
  return AddEntry(list, entry, false);
}
int AddEntries(monster [int] list, boolean [monster] entries, boolean force)
{
  int failCount = 0;

  foreach entry in entries
  {
    boolean success = list.AddEntry(entry, force);
    if(!success)
      ++failCount;
  }

  return failCount;
}
int AddEntries(monster [int] list, boolean [monster] entries)
{
  return AddEntries(list, entries, false);
}

item [int] reusableStaggerItems;
reusableStaggerItems.AddEntries($items[
  Time-Spinner,
  Rain-Doh indigo cup,
  Rain-Doh blue balls,
  nasty-smelling moss,
  little red book,
  tomayohawk-style reflex hammer,
  beehive,
], true);

item [int] oncePerCombatNonStaggerItems;
oncePerCombatNonStaggerItems.AddEntries($items[
  porquoise-handled sixgun,
  HOA citation pad,
  Great Wolf's lice,
  Mayor Ghost's scissors,
  electric boning knife,
  Blue raspberry troll doll,
  Cinnamon troll doll,
  Grape troll doll,
], true);

item [int] fullyReusableNonStaggerItems;
fullyReusableNonStaggerItems.AddEntries($items[
  tin snips,
  Miniborg Destroy-O-Bot,
  time shuriken,
], true);

skill [int] profitableSkills;
profitableSkills.AddEntries($skills[
  Open a Big Red Present,
  Pocket Crumbs,
  Extract,
  summon mayfly swarm,
], true);

// Fire the Jokester's Gun isn't really a stagger but it's simple this way
skill [int] staggerSkills;
staggerSkills.AddEntries($skills[
  Fire the Jokester's Gun,
  summon love mosquito,
  Compress,
  air dirty laundry,
  Ply Reality,
  Cowboy Kick,
], true);

item [int] stasisItems;
stasisItems.AddEntries($items[
  dictionary,
  seal tooth,
  spectre scepter,
], true);

monster [int] toSniff;
toSniff.AddEntries($monsters[
  dirty old lihc,

  dairy goat,

  elephant (meatcar?) topiary animal,
  spider (duck?) topiary animal,
  bearpig topiary animal,

  Quiet Healer,

  Blue Oyster cultist,
  racecar bob,
  bob racecar,
  tomb rat,
  pygmy shaman,
  pygmy witch surgeon,

  blooper,

  garbage tourist,
  nasty bear,

  grizzled survivor, unhinged survivor, whiny survivor,
  overarmed survivor, primitive survivor, unlikely survivor,
], true);

monster [int] toBanish;
toBanish.AddEntries($monsters[
  slick lihc,
  senile lihc,

  chatty pirate,
  crusty pirate,

  Irritating Series of Random Encounters,

  pygmy witch lawyer,

  A.M.C. gremlin,

  bullet bill,
], true);

// TODO: Support Peel Out, Beancannon, and other equip-skill banishes
// TODO: Possibly sort banishing skills in to tiers (til rollover vs finite turns)
//       and only use long term banishes against high priority banish targets
//       (targets where you will likely be in their zone for quite a while)
//       Additionall, possibly set some banishes that should only be done with
//       readily available banishes, like Batter Up! and path banishes
skill [int] banishSkills;
banishSkills.AddEntry($skill[Batter Up!]);
if(have_effect($effect[Nanobrawny]) > 40)
  banishSkills.AddEntry($skill[Unleash Nanites]);
banishSkills.AddEntries($skills[
  Creepy Grin,
  Give Your Opponent the Stinkeye,
  Talk About Politics,
  Snokebomb,
  Banishing Shout,
  Howl of the Alpha,
  Walk Away From Explosion,
  Thunder Clap,
  Curse of Vacation,
], true);
// TODO: classy monkey
// TODO: sort banishing items in to tiers (free runaway, etc)
//       and choose the cheapest inactive banisher in the first available tier
item [int] banishItems;
if(my_location().environment == "underwater")
  banishItems.AddEntry($item[pulled indigo taffy]);
banishItems.AddEntries($items[
  Louder Than Bomb,
  tennis ball,
  divine champagne popper,
  dirty stinkbomb,
  deathchucks,
  smoke grenade,
  crystal skull,
], true);
// mafia names banishes from skills granted by familiars or items after the familiar or item, which
// is p dumb imo, but whatever, this handles that
string [string] banishNameFixes;
banishNameFixes["pantsgiving"] = "Talk About Politics";
banishNameFixes["nanorhino"] = "Unleash Nanites";
// TODO: get namefixes for other equip banishes, since I'm not sure they're just item.to_string()
//       some don't really matter though since they can only be used once a day anyway

// TODO: add more stun options
// NOTE: class stun skills are intentionally not included,
//       they are handled as a special case
skill [int] stunOptions;
stunOptions.AddEntries($skills[
  Summon Love Gnats,
], true);

string [location,string] gremlins;
gremlins[$location[Next to that Barrel with Something Burning in it], "batwinged gremlin"] = "does a bombing run over your head";
gremlins[$location[Over Where the Old Tires Are], "erudite gremlin"] = "uses the random junk around him";
gremlins[$location[Near an Abandoned Refrigerator], "spider gremlin"] = "bites you in the fibula";
gremlins[$location[Out By that Rusted-Out Car], "vegetable gremlin"] = "picks a radish off of itself";

item [monster] monsterItems;
monsterItems[$monster[racecar bob]] = $item[disposable instant camera];
monsterItems[$monster[bob racecar]] = $item[disposable instant camera];
monsterItems[$monster[clingy pirate (male)]] = $item[cocktail napkin];
monsterItems[$monster[clingy pirate (female)]] = $item[cocktail napkin];
monsterItems[$monster[tomb rat]] = $item[tangle of rat tails];
monsterItems[$monster[perceiver of sensations]] = $item[abstraction: thought];
monsterItems[$monster[performer of actions]] = $item[abstraction: sensation];
monsterItems[$monster[thinker of thoughts]] = $item[abstraction: action];

// Almost all chefstaves have names that start with "Staff of "
// These don't.
item [int] irregularChefstaves;
irregularChefstaves.AddEntries($items[
  Spooky Putty snake,
  The Necbromancer's Wizard Staff,
], true);

setvar("SLAP.Digitize.Frequency", 5);

// Some PvP oriented sniffs and banishes
// Only happens in aftercore, to avoid wasting crucial resource in run
if(hippy_stone_broken() && qprop("questL13Final"))
{
  if(current_pvp_stances() contains "Basket Reaver")
  {
    toSniff.AddEntry($monster[Black widow]);
    toBanish.AddEntries($monsters[Black magic woman, Black adder, Black panther, Black friar]);
  }
}

// Helper functions
boolean ChefstaffEquipped()
{
  item mainhand = equipped_item($slot[weapon]);
  return irregularChefstaves.HasEntry(mainhand) || (index_of(mainhand, "Staff of ") == 0);
}

record SLAPState
{
  string [int] actions;
  int mpSpent;
  boolean [item] itemsUsed;
  string page;
  monster foe;
};

void AddAction(SLAPState slap, string action)
{
  slap.actions[slap.actions.count()] = action;
}

void Cast(SLAPState slap, skill s)
{
  slap.mpSpent += mp_cost(s);
  slap.AddAction("skill " + s.to_int());
}

boolean TryCast(SLAPState slap, skill s)
{
  if(s == $skill[none])
  {
    vprint("How did $skill[none] get in here?!", "red", 9);
    return false;
  }
  vprint("Trying to cast " + s, "green", 10);
  if(have_skill(s) && be_good(s) && (mp_cost(s) <= (my_mp() - slap.mpSpent)))
  {
    slap.Cast(s);
    return true;
  }
  return false;
}

int TryCast(SLAPState slap, skill [int] skills)
{
  int fails;
  foreach i,sk in skills
  {
    boolean success = slap.TryCast(sk);
    if(!success)
      ++fails;
  }
  return fails;
}

void RepeatCast(SLAPState slap, skill s)
{
  slap.AddAction("while hasskill " + s.to_int());
  slap.AddAction("skill " + s.to_int());
  slap.AddAction("endwhile");
}

item GetFunkslingable(SLAPState slap, item other)
{
  if(!reusableStaggerItems.HasEntry(other))
  {
    foreach i,it in reusableStaggerItems
    {
      if(item_amount(it) > 0 && be_good(it) && !slap.itemsUsed[it])
        return it;
    }
  }
  foreach i,it in oncePerCombatNonStaggerItems
  {
    if(item_amount(it) > 0 && be_good(it) && !slap.itemsUsed[it])
      return it;
  }
  foreach i,it in fullyReusableNonStaggerItems
  {
    if(item_amount(it) > 0 && be_good(it))
      return it;
  }
  return $item[none];
}

boolean TryUseItem(SLAPState slap, item it, item funk)
{
  if((reusableStaggerItems.HasEntry(it) || oncePerCombatNonStaggerItems.HasEntry(it)) &&
     slap.itemsUsed[it])
    return false;
  if(item_amount(it) > 0 && be_good(it))
  {
    string act = "use " + it.to_int();
    slap.itemsUsed[it] = true;
    if(funk != $item[none])
      act += "," + funk.to_int();
    slap.itemsUsed[funk] = true;
    slap.AddAction(act);
    return true;
  }
  return false;
}

boolean TryUseItem(SLAPState slap, item it)
{
  return slap.TryUseItem(it, slap.GetFunkslingable(it));
}

int TryUseItem(SLAPState slap, item [int] items, item funk, int limit)
{
  int fails = 0;
  foreach i,it in items
  {
    boolean success = slap.TryUseItem(it, funk);
    if(!success)
      ++fails;
    else if(--limit == 0)
      break;
  }
  return fails;
}

int TryUseItem(SLAPState slap, item [int] items, int limit)
{
  int fails = 0;
  foreach i,it in items
  {
    boolean success = slap.TryUseItem(it);
    if(!success)
      ++fails;
    else if(--limit == 0)
      break;
  }
  return fails;
}

int TryUseItem(SLAPState slap, item [int] items)
{
  return slap.TryUseItem(items, -1);
}

void HandleUniqueMonsters(SLAPState slap)
{
  switch(slap.foe)
  {
    case $monster[Source Agent]:
    {
      skill [int] sourceSkills;
      sourceSkills.AddEntries($skills[humiliating hack, disarmament, reboot]);
      int fails = slap.TryCast(sourceSkills);
      if(fails > 0)
      {
        slap.actions.clear();
        slap.AddAction('abort "You don\'t have the proper skills and/or enough mp to safely automate fighting an agent"');
      }
      slap.TryCast($skill[compress]);
      slap.AddAction('while hasskill source kick');
      slap.AddAction('if hppercentbelow 35 && hasskill restore && !mpbelow 125');
      slap.AddAction('skill restore');
      slap.AddAction('endif');
      slap.AddAction('skill source kick');
      slap.AddAction('endwhile');
      slap.AddAction('abort "You\'re hosed."');
      break;
    }
  }
  // gremlins
  string noMolyIdentifier = gremlins[my_location(), slap.foe.manuel_name];
  if(noMolyIdentifier != "")
  {
    if(item_amount($item[molybdenum magnet]) == 0)
      slap.AddAction('abort "You forgot to get the magnet you doofus"');
    slap.AddAction('if !match " whips out a"');
    slap.TryUseItem($item[rock band flyers]);
    slap.AddAction("endif");
    slap.AddAction('if !match " whips out a"');
    slap.TryUseItem($item[jam band flyers]);
    slap.AddAction("endif");
    slap.AddAction('while !(match " whips out a " || match "' + noMolyIdentifier + '")');
    if(slap.TryUseItem(stasisItems, $item[none], 1) == stasisItems.count())
      slap.AddAction('abort "you don\'t have anything to stasis with you goon, go get a seal tooth or something"');
    slap.AddAction("endwhile");
    slap.AddAction('if match " whips out a "');
    slap.TryUseItem($item[molybdenum magnet]);
    slap.AddAction("endif");
  }
}

boolean TryPickpocket(SLAPState slap)
{
  boolean ShouldPickpocket()
  {
    foreach i,info in item_drops_array(slap.foe)
    {
      switch(info.type)
      {
        case "n": case "b":
          continue;
        case "0": case "p":
          return true;
        default:
          if(info.rate > 0 && info.rate < 100)
            return true;
          break;
      }
    }
    return false;
  }

  if(ShouldPickpocket())
  {
    slap.AddAction("pickpocket");
    return true;
  }
  return false;
}

boolean TryStun(SLAPState slap)
{
  boolean stunSuccess;
  foreach i,sk in stunOptions
  {
    stunSuccess = slap.TryCast(sk);
    if(stunSuccess)
      break;
  }
  if(!stunSuccess)
    stunSuccess = slap.TryCast(stun_skill());

  return stunSuccess;
}

void HandleLocation(SLAPState slap)
{
  switch(my_location())
  {
    case $location[Barrrney's Barrr]:
      slap.TryUseItem($item[The Big Book of Pirate Insults]);
      break;
    case $location[A Mob of Zeppelin Protesters]:
      slap.TryUseItem($item[cigarette lighter]);
      break;
    case $location[The Red Zeppelin]:
      if(get_property("_glarkCableUses").to_int() < 5 &&
          slap.foe != $monster[Ron "The Weasel" Copperhead])
        slap.TryUseItem($item[glark cable]);
      break;
  }
  if(my_location().environment == "underwater")
  {
    slap.TryUseItem($item[pulled red taffy]);
    if(get_property("lassoTraining") != "expertly")
      slap.TryUseItem($item[sea lasso]);
  }
}

boolean TryBanish(SLAPState slap)
{
  vprint("Attempting to banish", "green", 8);

  monster [skill] activeSkillBanishes;
  monster [item] activeItemBanishes;

  string [int] banishData = get_property("banishedMonsters").split_string(":");
  for(int i = 0; i < banishData.count(); i += 3)
  {
    monster banished = to_monster(banishData[i]);
    string banisher = banishData[i + 1];
    if(banishNameFixes contains banisher)
      banisher = banishNameFixes[banisher];

    skill sk = banisher.to_skill();
    if(sk != $skill[none])
      activeSkillBanishes[sk] = banished;

    item it = banisher.to_item();
    if(it != $item[none])
      activeItemBanishes[it] = banished;
  }

  foreach i,sk in banishSkills
  {
    if(!(activeSkillBanishes contains sk))
    {
      boolean success = slap.TryCast(sk);
      if(success)
        return true;
    }
  }

  foreach i,it in banishItems
  {
    if(!(activeItemBanishes contains it))
    {
      boolean success = slap.TryUseItem(it);
      if(success)
        return true;
    }
  }

  return false;
}

void TryFlyer(SLAPState slap)
{
  if(qprop("questL12War") || qprop("questL12War == 0") ||
      get_property("sidequestArenaCompleted") != "none" ||
      get_property("flyeredML").to_int() > 10000)
    return;
  slap.TryUseItem($item[rock band flyers]);
  slap.TryUseItem($item[jam band flyers]);
}

string GetMacro(int initround, monster foe, string page)
{
  SLAPState slap;
  slap.page = page;
  slap.foe = foe;

  slap.AddAction("scrollwhendone");
  slap.AddAction("abort missed 5");
  slap.AddAction("abort hppercentbelow 25");
  slap.AddAction("abort pastround 25");

  slap.HandleUniqueMonsters();

  slap.TryPickpocket();

  if(get_property("_sourceTerminalDigitizeMonsterCount") >= vars["SLAP.Digitize.Frequency"].to_int()
     && page.contains_text("Looks like you must have hit CTRL+V,")
     && qprop("questL13Final"))
  {
    vprint("DIGITIZING", "green", 8);
    slap.TryCast($skill[Digitize]);
  }

  slap.TryStun();
  slap.TryFlyer();
  if(foe == $monster[gaudy pirate])
    slap.TryCast($skill[Duplicate]);
  if(toSniff.HasEntry(foe) && have_effect($effect[On the Trail]) < 1)
    slap.TryCast($skill[Transcendent Olfaction]);
  if(toBanish.HasEntry(foe))
    slap.TryBanish();
  slap.TryUseItem(monsterItems[foe]);
  
  slap.HandleLocation();
  if(foe.sub_types["ghost"])
  {
    skill [int] getDatGhost;
    getDatGhost.AddEntries($skills[Shoot Ghost, Shoot Ghost, Shoot Ghost], true);
    int fails = slap.TryCast(getDatGhost);
    if(fails == 0)
      slap.AddAction("skill 7280"); // Trap Ghost isn't initially available
  }

  if(foe.defense_element != $element[none])
    slap.TryCast($skill[Extract Jelly]);
  slap.TryCast(profitableSkills);
  slap.TryUseItem(reusableStaggerItems);
  slap.TryCast(staggerSkills);

  slap.TryCast($skill[stuffed mortar shell]);
  // I know I could just always put that there, but I don't want to see the "you don't have a
  // chefstaff equipped" message
  if(ChefstaffEquipped())
    slap.AddAction("jiggle");
  if(foe.physical_resistance == 100)
    slap.RepeatCast($skill[Saucegeyser]);
  slap.AddAction("attack");
  slap.AddAction("repeat");
  return join(slap.actions, ";");
}

string Deintify(string s)
{
  foreach sk in $skills[]
    s = s.replace_string("skill " + sk.to_int() + ";", "skill " + sk + ";");
  foreach it in $items[]
  {
    s = s.replace_string("use " + it.to_int() + ",", "use " + it + ",");
    s = s.replace_string("use " + it.to_int() + ";", "use " + it + ";");
    s = s.replace_string("," + it.to_int() + ";", "," + it + ";");
  }

  return s;
}

void main(int initround, monster foe, string page)
{
  string macro = GetMacro(initround, foe, page);
  visit_url("fight.php?action=macro&macrotext=" + url_encode(macro), true, true);
  vprint("Macro just executed: " + macro, "blue", 6);
  vprint("Macro deintified: " + Deintify(macro), "blue", 7);
}

