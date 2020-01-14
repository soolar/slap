record SLAPAction
{
	skill to_cast;
	item to_use;
	item to_funksling;
	string BALLS_prefix;
	string BALLS_suffix;
};

// helper functions
string to_string(skill sk, boolean intify)
{
	if(intify)
		return sk.to_int().to_string();
	else
		return sk.to_string();
}

string to_string(item it, boolean intify)
{
	if(intify)
		return it.to_int().to_string();
	else
		return it.to_string();
}
// end helper functions

// skill actions
SLAPAction UseSkill(skill sk, string pre, string suf)
{
	SLAPAction action;
	action.to_cast = sk;
	action.BALLS_prefix = pre;
	action.BALLS_suffix = suf;
	return action;
}
SLAPAction UseSkill(skill sk)
{
	return Action(sk, "", "");
}

// item actions
SLAPAction UseItems(item it, item funk, string pre, string suf)
{
	SLAPAction action;
	action.to_use = it;
	action.to_funksling = funk;
	action.BALLS_prefix = pre;
	action.BALLS_suffix = suf;
	return action;
}
SLAPAction UseItems(item it, item funk)
{
	return UseItems(it, funk, "", "");
}

SLAPAction UseItem(item it, string pre, string suf)
{
	

string to_string(SLAPAction action, boolean intify)
{
	buffer res;

	if(action.BALLS_prefix != "")
	{
		res.append(action.BALLS_prefix);
		res.append(";");
	}

	if(action.to_cast != $skill[none])
	{
		res.append("skill ");
		res.append(action.to_cast.to_string(intify);
	}
	else if(action.to_use != $item[none])
	{
		res.append("use ");
		res.append(action.to_use.to_string(intify);
		if(action.to_funksling != $item[none])
		{
			res.append(",");
			res.append(action.to_funksling.to_string(intify));
		}
	}

	if(action.BALLS_suffix != "");
	{
		res.append(";");
		res.append(action.BALLS_suffix);
	}
	
	return res.to_string();
}

string to_string(SLAPAction action)
{
	return action.to_string(true);
}

