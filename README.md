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
but SLAP has a couple advantages that should make it appealing to some people:
batching. All actions for the combat will be decided at once and sent in a
single BALLS macro. That means there will only be a single server hit per
combat, assuming you don't run in to an error (I can not promise that it will be
fully effective against complicated boss monsters for example). That means less
lag, AND being extra friendly to KoL's servers! Also in the name of server
friendliness, all script logic is done client-side (where possible). Determining
which skills you have available, what items you can use, etc, is all done in
advance to avoid adding conditional execution to the macro. Otherwise I have
enountered increased lag due to the length and complexity of some of the things
this script can do, and much more importantly, the limit of 37 commands (in a
row?!) without performing an action. If you've ever tried to do anything mildly
fancy with BALLS, you should be intimately familiar with that error... It even
goes the extra distance and boils down all skill and item references to be by ID
in the BALLS macro, to remove any possible mixups, any issues with fancy unicode
characters, and presumably very marginally reduce the processing time used by the
server.

TL;DR: Whereas WHAM focuses on making your combat as optimal as possible, SLAP
focuses on making it as quick as possible (in terms of time, not turns), while
still making use of a wide variety of items and skills.

## Installation
Simply run `svn checkout https://github.com/soolar/slap/release/` in
KoLMafia's gCLI. Then switch your ccs to SLAP.ccs, or add `consult
scripts/SLAP.ash` to your CCS.

## Quest progress this consult script will make
### Olfaction
SLAP will olfact the following quest related monsters (eventually, it will even
do so in avatar paths!):
* dirty old lihc
* dairy goat
* Blue Oyster cultist
* racecar bob
* bob racecar
* tomb rat
 
### Monster/area specific items
* racecar bob and bob racecar will be photographed
* Pirates will be insulted
* Zeppeling protesters will be burned with a cigarette lighter
* Red zeppelin monsters will be glarked, if possible
* Gremlins will be stasised and magneted as appropriate
* Tomb rats will be turned in to rat kings

## Zone specific support
### Underwater zones
* uses pulled red taffy if available
* trains sea lasso if available and unmastered

### Barf Mountain
* sniffs garbage tourist
* sniffs nasty bear

### Deep Machine Tunnels
* mixes abstractions when possible

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
the first available infinite use funkslingable, if available.
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
 
### Always used finite combat skills
* Fire the Jokester's Gun (The Jokester's gun)
* summon mayfly swarm (mayfly bait necklace)

### Unlimited use equipment-based skills
* Shoot Ghost/Trap Ghost (protonic accelerator pack)
* pocket crumbs (Pantsgiving)
* air dirty laundry (Pantsgiving)
* Ply Reality (Thor's Pliers)
* Cowboy Kick (your cowboy boots)

### Other IotM derivative skills
* summon love gnats (bottle of lovebug pheromones)
* summon love mosquito (bottle of lovebug pheromones)
* Extract (source terminal)
* Compress (source terminal)

## Path specific support
### The Source
Source Agent fights will be automated, if you have the appropriate skills and mp
at your disposal.

