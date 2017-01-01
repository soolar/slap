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
  pocket crumbs,
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
  Blue Oyster cultist,
  racecar bob,
  bob racecar,
  tomb rat,
  garbage tourist,
  nasty bear,
  grizzled survivor, unhinged survivor, whiny survivor,
], true);

// TODO: add more banishing skills
skill [int] banishSkills;
banishSkills.AddEntries($skills[
  Batter Up!,
  pocket crumbs,
  snokebomb,
], true);
// TODO: add more banishing items
// TODO: sort banishing items in to tiers (free runaway, etc)
//       and choose the cheapest inactive banisher in the first available tier
item [int] banishItems;
banishItems.AddEntries($items[
  Louder Than Bomb,
  tennis ball,
], true);

monster [int] toBanish;
toBanish.AddEntries($monsters[
  slick lihc,
  senile lihc,
], true);

// TODO: add more stun options
// NOTE: class stun skills are intentionally not included,
//       they are handled as a special case
skill [int] stunOptions;
stunOptions.AddEntries($skills[
  summon love gnats,
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
string Intify(item it)
{
  if(vars["verbosity"].to_int() < 6)
    return it.to_int();
  return it;
}

string Intify(skill s)
{
  if(vars["verbosity"].to_int() < 6)
    return s.to_int();
  return s;
}

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
};

void AddAction(SLAPState slap, string action)
{
  slap.actions[slap.actions.count()] = action;
}

void Cast(SLAPState slap, skill s)
{
  slap.mpSpent += mp_cost(s);
  slap.AddAction("skill " + Intify(s));
}

boolean TryCast(SLAPState slap, skill s)
{
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
    string act = "use " + Intify(it);
    slap.itemsUsed[it] = true;
    if(funk != $item[none])
      act += "," + Intify(funk);
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

void HandleUniqueMonsters(SLAPState slap, monster foe)
{
  switch(foe)
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
  string noMolyIdentifier = gremlins[my_location(), foe.manuel_name];
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

void HandleLocation(SLAPState slap, monster foe)
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
          foe != $monster[Ron "The Weasel" Copperhead])
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

string GetMacro(int initround, monster foe, string page)
{
  SLAPState slap;

  slap.AddAction("scrollwhendone");
  slap.AddAction("abort missed 5");
  slap.AddAction("abort hppercentbelow 25");
  slap.AddAction("abort pastround 25");

  slap.HandleUniqueMonsters(foe);

  slap.AddAction("pickpocket");

  if(get_property("_sourceTerminalDigitizeMonsterCount") >= vars["SLAP.Digitize.Frequency"].to_int()
     && page.contains_text("Looks like you must have hit CTRL+V,")
     && qprop("questL13Final"))
  {
    vprint("DIGITIZING", 8);
    slap.TryCast($skill[Digitize]);
  }

  slap.TryStun();
  if(toSniff.HasEntry(foe) && have_effect($effect[On the Trail]) < 1)
    slap.TryCast($skill[Transcendent Olfaction]);
  slap.TryUseItem(monsterItems[foe]);
  
  slap.HandleLocation(foe);
  if(foe.sub_types["ghost"])
  {
    skill [int] getDatGhost;
    getDatGhost.AddEntries($skills[Shoot Ghost, Shoot Ghost, Shoot Ghost, Trap Ghost], true);
    slap.TryCast(getDatGhost);
  }

  slap.TryCast(profitableSkills);
  slap.TryUseItem(reusableStaggerItems);
  slap.TryCast(staggerSkills);

  slap.TryCast($skill[stuffed mortar shell]);
  // I know I could just always put that there, but I don't want to see the "you don't have a
  // chefstaff equipped" message
  if(ChefstaffEquipped())
    slap.AddAction("jiggle");
  if(foe.physical_resistance == 100)
    slap.AddAction("while hasskill Saucegeyser;skill Saucegeyser;endwhile");
  slap.AddAction("attack");
  slap.AddAction("repeat");
  return join(slap.actions, ";");
}

void main(int initround, monster foe, string page)
{
  string macro = GetMacro(initround, foe, page);
  vprint("Macro about to be executed: " + macro, "blue", 7);
  visit_url("fight.php?action=macro&macrotext=" + url_encode(macro), true, true);
  vprint("Macro just executed: " + macro, "blue", 6);
}

