---
title: "A Poem in Prolog"
last_modified_at: 2019-10-03
comments: true
categories:
  - blog
tags:
  - prolog
---

## For Want of a Nail

I thought it would be fun to translate a poem, _For Want of a Nail_ which has an
interesting history<sup>[1](#for-want-of-a-nail)</sup> which I came across while
reading about _The Five Whys_<sup>[2](#five-whys)</sup> technique. The version
of the poem reproduced in this post is attributed to Welsh poet George
Herbert<sup>[3](#george-herbert)</sup>.

This is a poem which illustrates The Five Whys analysis to find the
cause-and-effect relationship underlying a problem in an easy to remember form.
Since the verses are quite simple, it is the kind of poem one can easily encode
in Prolog as logical rules.

### Poem

    For want of a nail the shoe is lost;
    For want of a shoe the horse is lost;
    For want of a horse the rider is lost;
    For want of a rider the battle is lost;
    For want of a battle the kingdom is lost;
    And all for the want of a horseshoe nail.

    - George Herbert
    
## In Prolog

To translate the poem for Prolog we can start with the facts in this poem. This
story is very simple as it is only talking about a single incident type: loosing
something because of something else. We can easily encode this information using
a single predicate, `itemlost_becauseof`, as shown below.

### Facts

```prolog
itemlost_becauseof(shoe, nail).
itemlost_becauseof(horse, shoe).
itemlost_becauseof(rider, horse).
itemlost_becauseof(battle, rider).
itemlost_becauseof(kingdom, battle).
```

### Predicates

```prolog
write_poem(ItemLost) :-
    write_poem_aux(ItemLost);
    write_last_line(ItemLost).

write_poem_aux(ItemLost) :-
    itemlost_becauseof(Impacted, ItemLost),
    write_line(ItemLost, Impacted),
    write_poem_aux(Impacted).

write_line(Item, Impacted) :-
    write("For want of a "), write(Item), write(" a "), write(Impacted), write(" was lost;"), nl.

write_last_line(Item) :-
    write("And all for the want of a "), write(Item), write("."), nl.
```

To get the full poem<sup>[4](#last-line)</sup>, we can ask Prolog - `write_poem(nail)`. Nice thing about
encoding the poem in Prolog is that we can get parts of the poem just as easily.
For example, to see the impact of a lost horse - `write_poem(horse)`, which will
produce the following poem!

    ?- write_poem(horse).
    For want of a horse a rider was lost;
    For want of a rider a battle was lost;
    For want of a battle a kingdom was lost;
    And all for the want of a horse


### Finding root cause

We can use following predicates for root cause analysis from the facts database.

```prolog
loss_rootcause(ItemLost, Cause) :- 
    itemlost_becauseof(ItemLost, Z), loss_rootcause(Z, Cause), !.
loss_rootcause(ItemLost, Cause) :- 
    itemlost_becauseof(ItemLost, Cause).

item_impacted(Cause, ItemLost) :-
    itemlost_becauseof(ItemLost, Cause).
item_impacted(Cause, ItemLost) :-
    itemlost_becauseof(ItemLost, X),
    item_impacted(Cause, X).
```

With the `loss_rootcause` predicate, we can check whether the bard was correct
in contending that, ultimately, a lost horse-nail was responsible for the fall
of the kingdom, and indeed that is the case, as Prolog confirms for the
following query.

    ?- loss_rootcause(kingdom, RootCause).
    RootCause = nail.
    
We are using a Red Cut<sup>[5](#red-cut)</sup> in the definition of
`loss_rootcause` predicate since we want Prolog to stop looking for alternatives
if it cannot unify to end up with _the_ root cause for a given failure
situation. This cut basically makes Prolog find the first Domino which fell down
to cause the cascading failures.
    
For impact analysis, we can also use `forall`<sup>[6](#forall)</sup> predicate from Prolog built-ins,
to get a list of all the items impacted by a given item.

    ?- findall(X, item_impacted(nail, X), NailImpacted).
    NailImpacted = [shoe, horse, rider, battle, kingdom].
    
All code used for this post can be found here - 
[For Want of a Nail.pl](https://gist.github.com/dewaka/36f24c3c1d527af30ae3944a994274c3).

## Footnote

Annotated names, such as the `nail => horse-nail`, can be written with the use
of another predicate as follows.

```prolog
annotated_name(nail,  horse-nail).
annotated_name(X,  X).

write_annotated(X) :-
    annotated_name(X, Annotated), write(Annotated).
```

Then we can modify the `write_last_line` as follows to get a more faithful
reproduction of the poem.

```prolog
write_last_line(Item) :-
    write("And all for the want of a "), write_annotated(Item), write("."), nl.
```

Annotations are a set of predicates which matches a given item to a more
embellished version. For example, we can add an embelishment for the
`rider` with `annotated_name(rider, 'brave rider')`. With the updated database
database, the last line of a poem starting with the rider would
be - "_And all for the want of a brave rider_.", and so on.

## References

- <a name="for-want-of-a-nail">1</a>: [For Want of a Nail](https://en.wikipedia.org/wiki/For_Want_of_a_Nail)
- <a name="five-whys">2</a>: [The Five Whys](https://www.adb.org/sites/default/files/publication/27641/five-whys-technique.pdf)
- <a name="george-herbert">3</a>: [George Herbert](https://en.wikipedia.org/wiki/George_Herbert)
- <a name="last-line">4</a>: _Last line is not a verbatim reproduction since the
  original poem contains an embelishment which is beyond the scope of this (silly) exercise_
- <a name="red-cut">5</a>: [Logic Programming Red Cut](https://en.wikipedia.org/wiki/Cut_(logic_programming)#Red_cut)
- <a name="forall">6</a>: [forall - SWI Prolog documentation](https://www.swi-prolog.org/pldoc/man?predicate=forall/2)
