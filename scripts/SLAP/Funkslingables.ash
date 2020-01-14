import <SLAP/State.ash>



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

