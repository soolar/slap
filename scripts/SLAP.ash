script "Soolar's Lag-Annihilating Pummeler";
//notify "soolar the second";
import <zlib.ash>

static
{
  boolean [item] reusableStaggerItems = $items[
    Time-Spinner,
    Rain-Doh indigo cup,
    Rain-Doh blue balls,
    nasty-smelling moss,
    little red book,
    tomayohawk-style reflex hammer,
    beehive,
  ];
  
  boolean [item] oncePerCombatNonStaggerItems = $items[
    porquoise-handled sixgun,
    HOA citation pad,
    Great Wolf's lice,
    Mayor Ghost's scissors,
    electric boning knife,
    Blue raspberry troll doll,
    Cinnamon troll doll,
    Grape troll doll,
  ];

  boolean [item] fullyReusableNonStaggerItems = $items[
    tin snips,
    Miniborg Destroy-O-Bot,
    time shuriken,
  ];

  boolean [skill] profitableSkills = $skills[
    pocket crumbs,
    Extract,
    summon mayfly swarm,
  ];

  // Fire the Jokester's Gun isn't really a stagger but it's simple this way
  boolean [skill] staggerSkills = $skills[
    Fire the Jokester's Gun,
    summon love mosquito,
    Compress,
    air dirty laundry,
    Ply Reality,
    Cowboy Kick,
  ];

  boolean [item] stasisItems = $items[
    dictionary,
    seal tooth,
    spectre scepter,
  ];

  boolean [monster] toSniff = $monsters[
    dirty old lihc,
    dairy goat,
    Blue Oyster cultist,
    racecar bob,
    bob racecar,
    tomb rat,
    garbage tourist,
    nasty bear,
    grizzled survivor, unhinged survivor, whiny survivor,
  ];

  boolean [skill] banishSkills = $skills[
    Batter Up!,
    pocket crumbs,
    snokebomb,
  ];
  boolean [monster] toBanish = $monsters[
    slick lihc,
    senile lihc,
  ];

  boolean [skill] stunOptions = $skills[
    summon love gnats,
  ]; // TODO: come back and add some shit to this, probably

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

  setvar("SLAP.Digitize.Frequency", 5);
}

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

int TryCast(SLAPState slap, boolean [skill] skills)
{
  int fails;
  foreach s in skills
  {
    boolean success = slap.TryCast(s);
    if(!success)
      ++fails;
  }
  return fails;
}

item GetFunkslingable(SLAPState slap)
{
  foreach it in oncePerCombatNonStaggerItems
  {
    if(item_amount(it) > 0 && be_good(it) && !slap.itemsUsed[it])
      return it;
  }
  foreach it in fullyReusableNonStaggerItems
  {
    if(item_amount(it) > 0 && be_good(it))
      return it;
  }
  return $item[none];
}

boolean TryUseItem(SLAPState slap, item it, item funk)
{
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
  return slap.TryUseItem(it, slap.GetFunkslingable());
}

int TryUseItem(SLAPState slap, boolean [item] items, item funk, int limit)
{
  int fails = 0;
  foreach it in items
  {
    boolean success = slap.TryUseItem(it, funk);
    if(!success)
      ++fails;
    else if(--limit == 0)
      break;
  }
  return fails;
}

int TryUseItem(SLAPState slap, boolean [item] items, int limit)
{
  int fails = 0;
  foreach it in items
  {
    boolean success = slap.TryUseItem(it);
    if(!success)
      ++fails;
    else if(--limit == 0)
      break;
  }
  return fails;
}

int TryUseItem(SLAPState slap, boolean [item] items)
{
  return slap.TryUseItem(items, -1);
}

void HandleUniqueMonsters(SLAPState slap, monster foe)
{
  switch(foe)
  {
    case $monster[Source Agent]:
    {
      int fails = slap.TryCast($skills[humiliating hack, disarmament, reboot]);
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
    slap.TryUseItem($items[rock band flyers, jam band flyers]);
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
  foreach s in stunOptions
  {
    stunSuccess = slap.TryCast(s);
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
  if(toSniff[foe] && have_effect($effect[On the Trail]) < 1)
    slap.TryCast($skill[Transcendent Olfaction]);
  slap.TryUseItem(monsterItems[foe]);
  
  slap.HandleLocation(foe);
  if(foe.sub_types["ghost"])
    slap.TryCast($skills[Shoot Ghost, Shoot Ghost, Shoot Ghost, Trap Ghost]);

  slap.TryCast(profitableSkills);
  slap.TryUseItem(reusableStaggerItems);
  slap.TryCast(staggerSkills);

  slap.TryCast($skill[stuffed mortar shell]);
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

