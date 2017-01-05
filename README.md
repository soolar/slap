# SLAP.ash
## What is this?
This is a consult script I recently converted from a CCS I recently converted
from a standard KoL BALLS macro I've been cultivating over the course of several
years. It'll utilize a variety of reusable combat items, so you don't feel bad
about letting them gather dust in the corner of your inventory. It'll also use a
variety of staggering skills and other useful things, and make progress on a
decent number of quests.

It also takes the stance that if you have something equipped that grants limited
use of a combat skill, you have it equipped because you want to use it. Don't
use this ccs while you have something like that equipped if you want to use it
on a specific enemy. Except for things that you would very obviously care about
what enemy you used it on, like limited banishes.

## Why use this instead of WHAM?
WHAM is a wonderful consult script and I highly recommend you check it out if
you haven't already. It does a lot of things that my consult script does not,
and generally focuses on making your combat as optimal as possible, including
adapting as rounds progress. SLAP, on the other hand, does all of its decision
making at once, and sends it all in a single command, meaning it will only make
a single server hit instead of quite a few.Basically, whereas WHAM focuses on
making your combat as optimal as possible, SLAP focuses on making it as quick
as possible (in terms of time, not turns), while still making use of a wide
variety of items and skills.

## Installation
Simply run `svn checkout https://github.com/soolar/slap/branches/release/` in
KoLMafia's gCLI. Then switch your ccs to slap.ccs, or add `consult
scripts/SLAP.ash` to your CCS.

## Ascension relevant quest progress this consult script will make
### Olfaction
* dirty old lihc
* dairy goat
* twin peak topiary animals
* Quiet Healer
* Blue Oyster cultist
* racecar bob
* bob racecar
* tomb rat

### Banishing
* slick lihc
* senile lihc
* chatty pirate
* crusty pirate
* Irritating Series of Random Encounters
 
### Monster/area specific items
* racecar bob and bob racecar will be photographed
* Pirates will be insulted
* Zeppelin protesters will be burned with a cigarette lighter
* Red zeppelin monsters will be glarked, if possible
* Gremlins will be stasised and magneted as appropriate
* Tomb rats will be turned in to rat kings

## Zone specific support
### Underwater zones
* uses pulled red taffy if available
* trains sea lasso if available and unmastered
* use pulled indigo taffy as a banisher if one is needed

### Barf Mountain
* sniffs garbage tourist
* sniffs nasty bear

### Deep Machine Tunnels
* mixes abstractions when possible

### Spaaace
* sniffs map droppers

## Things this ccs will utilize
### Reusable staggering combat items
* Time-Spinner
* Rain-Doh indigo cup
* Rain-Doh blue balls
* nasty-smelling moss
* little red book
* tomayohawk-style reflex hammer
* beehive

### Funkslinging
Whenever a combat item is used (outside of stasising gremlins), a reusable but
non-staggering combat item will be chosen to accompany it. If all available
once-per-battle funkslingables have been used in the battle, it will then pick
the first available infinite use funkslingable, if available. If a non-staggering
combat item is going to be used such as abstractions of the big book of pirate
insults, a staggering item will be chosen to accompany it.
#### Once-per-battle funkslingables
* porquoise-handled sixgun
* HOA citation pad
* Great Wolf's lice
* Mayor Ghost's scissors
* electric boning knife
* Blue raspberry troll doll
* Cinnamon troll doll
* Grape troll doll

#### Infinite use funkslingables
* tin snips
* Miniborg Destroy-O-Bot
* time shuriken

### Banishers
Skills will be prefered over items when possible. Avoids using any banisher
that is still currently in effect.
#### Skills
* Unleash Nanites (Nanorhino, only with >40 turns of Nanobrawny)
* Creepy Grin (V for Vivala mask)
* Give Your Opponent the Stinkeye (stinky cheese eye)
* Talk About Politics (Pantsgiving)
* Snokebomb
* Banishing Shout (Avatar of Boris)
* Howl of the Alpha (Zombie Master)
* Walk Away From Explosion (Avatar of Sneaky Pete)
* Thunder Clap (Heavy Rains)
* Curse of Vacation (Actually Ed the UNDYING!!!)

#### Items
* pulled indigo taffy (Summon Pulled Taffy, underwater only)
* Louder Than Bomb (Smith's Tome)
* tennis ball (Hallowiener Dog)
* divine champagne popper (Summon Divine Favors)
* dirty stinkbomb (KoL High School)
* deathchucks (KoL High School)
* smoke grenade (Avatar of Sneaky Pete)
* crystal skull (Skeleton Garden)
 
### Always used finite combat skills
* Fire the Jokester's Gun (The Jokester's gun)
* summon mayfly swarm (mayfly bait necklace)

### Unlimited use equipment-based skills
* Shoot Ghost/Trap Ghost (protonic accelerator pack)
* pocket crumbs (Pantsgiving)
* air dirty laundry (Pantsgiving)
* Ply Reality (Thor's Pliers)
* Cowboy Kick (your cowboy boots)
* Jiggles Chefstaves, if you have one equipped!

### Other IotM derivative skills
* summon love gnats (bottle of lovebug pheromones)
* summon love mosquito (bottle of lovebug pheromones)
* Extract (source terminal)
* Compress (source terminal)
* Open a Big Red Present (crimbo shrub)
* Digitize (source terminal, SLAP will automatically renew existing digitizations
  in aftercore)

## Path specific support
### The Source
Source Agent fights will be automated, if you have the appropriate skills and mp
at your disposal.

## Other random stuff
* If a monster is phys immune, spam spells at it instead of attacking repeatedly

## In the works!
* Proper support for banishes that can apply to multiple monsters simultaneously
* Support for path specific olfaction
* Yellow Ray support
* More olfaction and banish targets
* Weirdeaux monster combat
* Digitizing smartly based on adventures spent compared to adventures remaining to
  to your turngen for the day automatically instead of just using a zlib variable
* Once I decide exactly how I want to store the data I will probably move things
  like sniff/banish targets and such out in to zlib variables
