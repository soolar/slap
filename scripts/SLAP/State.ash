import <SLAP/Action.ash>

record SLAPState
{
  SLAPAction [int] actions;
  int mpSpent;
  int [item] itemsUsed;
  string page;
  monster foe;
};

boolean AddAction(SLAPState state, SLAPAction action)
{
	// TODO: Do some checking on one-use skills and such
	actions[actions.count()] = action;
	return true;
}

string to_string(SLAPState state, boolean intify)
{
	buffer res;
	foreach i,a in state.actions
	{
		res.append(a.to_string(intify));
	}
	return res.to_string();
}

string to_string(SLAPState state)
{
	return state.to_string(true);
}

