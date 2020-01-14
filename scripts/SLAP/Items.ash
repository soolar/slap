import <zlib.ash>;

item [int] staggers;
item [phylum,int] phylumStaggers;
item [int] nonStaggers;
boolean [item] infiniteUse;
item [int] stasis;

static
{
	string [string] filemap;
	if(!file_to_map("SLAP/Items.txt", filemap))
		print("SLAP: SLAP/Items.txt could not be loaded", "red");
	foreach itstr,props in filemap
	{
		item it = itstr.to_item();
		string [int] splitprops = props.split_string(";");
		foreach i,prop in splitprops
		{
			string [int] propdata = prop.split_string(":");
			string propname = propdata[0];
			switch(propname)
			{
				case "stagger":
					staggers[staggers.count()] = it;
					break;
				case "funky":
					nonStaggers[nonStaggers.count()] = it;
					break;
				case "reusable":
					infiniteUse[it] = true;
					break;
				case "stasis":
					stasis[stasis.count()] = it;
					infiniteUse[it] = true;
					break;
				case "phylumstagger":
					for(int j = 1; j < propdata.count(); ++i)
					{
						phylum phy = propdata[j].to_phylum();
						phylumStaggers[phy][phylumStaggers[phy].count()] = it;
					}
					break;
				// TODO: banishes and stuff
			}
		}
	}
}

