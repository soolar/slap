script "Soolar's Lag-Annihilating Pummeler";
notify "soolar the second";
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

string GetMacro(int initround, monster foe, string page)
{
  // helper functions and stuff
  string [int] actions;
  void AddAction(string action)
  {
    actions[actions.count()] = action;
  }
  int mpSpent;
  void cast(skill s)
  {
    mpSpent += mp_cost(s);
    AddAction("skill " + Intify(s));
  }
  boolean tryCast(skill s)
  {
    if(have_skill(s) && be_good(s) && (mp_cost(s) <= (my_mp() - mpSpent)))
    {
      cast(s);
      return true;
    }
    return false;
  }
  int tryCast(boolean [skill] skills)
  {
    int fails;
    foreach s in skills
    {
      boolean success = tryCast(s);
      if(!success)
        ++fails;
    }
    return fails;
  }
  boolean [item] itemsUsed;
  item getFunkslingable()
  {
    foreach it in oncePerCombatNonStaggerItems
    {
      if(item_amount(it) > 0 && be_good(it) && !itemsUsed[it])
        return it;
    }
    foreach it in fullyReusableNonStaggerItems
    {
      if(item_amount(it) > 0 && be_good(it))
        return it;
    }
    return $item[none];
  }
  boolean tryUseItem(item it, item funk)
  {
    if(item_amount(it) > 0 && be_good(it))
    {
      string act = "use " + Intify(it);
      if(funk != $item[none])
        act += "," + Intify(funk);
      itemsUsed[funk] = true;
      AddAction(act);
      return true;
    }
    return false;
  }
  boolean tryUseItem(item it)
  {
    return tryUseItem(it, getFunkslingable());
  }
  int tryUseItem(boolean [item] items, item funk, int limit)
  {
    int fails = 0;
    foreach it in items
    {
      boolean success = tryUseItem(it, funk);
      if(!success)
        ++fails;
      else if(--limit == 0)
        break;
    }
    return fails;
  }
  int tryUseItem(boolean [item] items, int limit)
  {
    int fails = 0;
    foreach it in items
    {
      boolean success = tryUseItem(it);
      if(!success)
        ++fails;
      else if(--limit == 0)
        break;
    }
    return fails;
  }
  int tryUseItem(boolean [item] items)
  {
    return tryUseItem(items, -1);
  }

  // Actual stuff to do
  AddAction("scrollwhendone");
  AddAction("abort missed 5");
  AddAction("abort hppercentbelow 25");
  AddAction("abort pastround 25");

  // gremlins
  string noMolyIdentifier = gremlins[my_location(), foe.manuel_name];
  if(noMolyIdentifier != "")
  {
    //if(item_amount($item[molybdenum magnet]) == 0)
    //  AddAction('abort "You forgot to get the magnet you doofus"');
    AddAction('if !match " whips out a"');
    tryUseItem($items[rock band flyers, jam band flyers]);
    AddAction("endif");
    AddAction('while !(match " whips out a " || match "' + noMolyIdentifier + '")');
    if(tryUseItem(stasisItems, $item[none], 1) == stasisItems.count())
      AddAction('abort "you don\'t have anything to stasis with you goon, go get a seal tooth or something"');
    AddAction("endwhile");
    AddAction('if match " whips out a "');
    tryUseItem($item[molybdenum magnet]);
    AddAction("endif");
  }

  AddAction("pickpocket");
  boolean stunSuccess;
  foreach s in stunOptions
  {
    stunSuccess = tryCast(s);
    if(stunSuccess)
      break;
  }
  if(!stunSuccess)
    tryCast(stun_skill());
  if(toSniff[foe] && have_effect($effect[On the Trail]) < 1)
    tryCast($skill[Transcendent Olfaction]);
  tryUseItem(monsterItems[foe]);
  switch(foe)
  {
    case $monster[Source Agent]:
    {
      int fails = tryCast($skills[humiliating hack, disarmament, reboot]);
      if(fails > 0)
      {
        actions.clear();
        AddAction('abort "You don\'t have the proper skills and/or enough mp to safely automate fighting an agent"');
      }
      tryCast($skill[compress]);
      AddAction('while hasskill source kick;if hppercentbelow 35 && hasskill restor && !mpbelow 125;skill restore;endif;skill source kick;endwhile;abort "You\'re hosed."');
      break;
    }
  }
  switch(my_location())
  {
    case $location[Barrrney's Barrr]:
      tryUseItem($item[The Big Book of Pirate Insults]);
      break;
    case $location[A Mob of Zeppelin Protesters]:
      tryUseItem($item[cigarette lighter]);
      break;
    case $location[The Red Zeppelin]:
      if(get_property("_glarkCableUses").to_int() < 5 &&
          foe != $monster[Ron "The Weasel" Copperhead])
        tryUseItem($item[glark cable]);
  }
  if(foe.sub_types["ghost"])
    tryCast($skills[Shoot Ghost, Shoot Ghost, Shoot Ghost, Trap Ghost]);
  if(my_location().environment == "underwater")
  {
    tryUseItem($item[pulled red taffy]);
    if(get_property("lassoTraining") != "expertly")
      tryUseItem($item[sea lasso]);
  }

  tryCast(profitableSkills);
  tryUseItem(reusableStaggerItems);
  tryCast(staggerSkills);



  tryCast($skill[stuffed mortar shell]);
  AddAction("attack");
  AddAction("repeat");
  return join(actions, ";");
}

void main(int initround, monster foe, string page)
{
  string macro = GetMacro(initround, foe, page);
  vprint("Macro about to be executed: " + macro, "blue", 7);
  visit_url("fight.php?action=macro&macrotext=" + url_encode(macro), true, true);
  vprint("Macro just executed: " + macro, "blue", 6);
}

