"
I iteratively mine associations between classes using a seed set of example instances.
# Summary

The algorithm uses examples and unary methods to iteratively mine associations from classes to classes within a package. Each association has one or more “witnesses” — examples that demonstrate that you can navigate from an object of the source class to one of the target using a unary method. 
The algorithm consists of three phases: 
(i) collect an initial seed set of examples, from example methods, or from factory methods, 
(ii) produce iterations, each of which consists of a set of associations and witnesses, stopping when we run out of examples, we don't produce any new associations for the package, or we reach some heuristic limits, and 
(iii) we process the associations for which a source class can navigate to multiple target classes, to instead target a common superclass.

# Terminology and notation

C is the set of all *classes* in the system.
We assume that classes form a single inheritance hierarchy. 
superclass: C->C is a partial function

P subset C is the *package* of classes we wish to analyze.
An *object* o in O is an instance of a class c = class(o).

A *message* m in M consists of a name (selector) and possibly a payload of arguments that can be sent to an object or a class. We are only concerned with *unary* messages (with no argument).

Every class c has a set of unary class *factory* messages f(c) that may be sent directly to the class c, serving as factories for instances of c, or possibly other classes.
E.g., Object new, Color red.

Every class c in C has a (possibly empty) set of unary messages u(c) that can be sent to instances of c, and used to navigate from one class to another, thus establishing an association.
E.g., 5 factorial.

Ex subset C is a set of *example classes* with (annotated) methods that yield instances of classes in P, but possibly also in C\P.
An *example message* is a unary message in u(c), where c in Ex.
E.g., LudoGameExamples new exampleGame

An *example* is a tuple x = `<`o,e`>` in X, where o = object(x) is an object, an instance of some class(o), and e = expr(x) is an expression cm+, where c is some initial class, and m+ is a sequence of unary messages, or lm+, where l is an initial literal. 
The class of the example class(x) = class(object(x)). An expression is evaluated, o = eval(e), by sending the sequence of messages m+ to the class or literal at the start of the expression.
E.g., `<`6,3 factorial`>`

An *association* a in A is a tuple a = `<`c,m,c'`>` where c = source(a) is a *source class*, c' =target(a) a *target class*, m = message(a) a unary message, m in u(c).

A *witness* w in W for an association a is a tuple `<`x,m,x'`>`, x = example(w), m = message(w), x' = result(w), where class(x) = source(a), m = message(a), and class(x') = target(a).
Alternative: class(x') is a descendent class of target(a).
That is to say, x bears witness to the fact that we can navigate from an instance of source(a) to an instance of target(a) (or a descendent class) by sending the message m.

An *observation map* b in B : A -> W* is a mapping from associations to sets (or lists) of witnesses.
The *observed associations* obs(b) = { a | b(a) != Ø } are the associations with non-empty sets of witnesses.

Two associations are *divergent*, a ~ a', if source(a) = source(a'), message(a) = message(a') but target(a) != target(a'), i.e., the same message may yield instances of different target classes.

An *observation map* b is *ambiguous* if there exist divergent observed associations, a, a' in obs(b), a ~ a', (i.e., they have witnesses mapping to different target types).

An observation map is *monomorphic* if w in b(a) => target(a) = class(result(w)), i.e., the witnessed result is an instance of exactly the target class.

An observation map is *polymorphic* if there exists some a with w1, w2 in b(a), but class(result(w1)) != class(result(w2)) (i.e., so at least one result is an instance of a descendent of the target class).

NB: a map can be independently ambiguous or not, and monomorphic or not. An ambiguous, monomorphic map may be converted to an unambiguous but polymorphic one by joining the target classes to common superclasses and merging the witness sets.
This simplifies the resulting graph, producing fewer edges from the source class to targets.

The association mining algorithm starts with a seed set of examples, and iteratively builds new, observations, until a stop condition is reached. At any stage, the set of observed associations may be transformed to become unambiguous, but possibly polymorphic.

# Phase 1 — creating the initial seed example set

The algorithm starts with a package P subset C of classes of interest, and a set Ex of example classes containing annotated example methods. The example classes may be part of an actual package to analyze, in which case we split it into P and Ex.

We create an initial seed set of examples, Seed subset X, where:

Seed = { x = `<`o,c new m`>` | c in Ex, m in u(c), o = eval(c new m) } 

Variant: there are no example classes, so instead we construct examples using factory messages of classes in P.

Seed = { x = `<`o,c m`>` | c in P, m in f(c), o = eval(c m) }

# Phase 2 — producing an iteration

An *iteration* is a tuple It_n = `<`b_n,Xn`>` of extended observations and new examples to analyze.
Xn is the set of *new examples* produced in that iteration, to be analyzed in the next iteration, and b_n is the association set produced thus far. The initial iteration consists of X_0 = Seed and b0 = A -> {}.

A new iteration It_n+1 = `<`b_n+1, X_n+1`>` = iter(`<`b_n, X_n`>`) consists of
(i) an updated observation map, b_n+1, where, for any a in A, b_n(a) subset b_n+1(a), and
(ii) X_n+1, a set of new examples for analysis in the next iteration.
X_n+1 may be empty (no new examples).

X_n+1 and b_n+1 are defined as follows, by iterating X_n and b_n.

For each example x = `<`o,e`>` in Xn, and unary m in u(class(o)), let x' = `<`o',e'`>` where o' = eval(o m) and e' = em.

Note that the expressions always increase in length, so we can never create the same expression twice (though the resulting instances may be equal to ones we have seen before).

If o' yields an error, a nil (undefined) object, or an empty collection, x' is not in X_n+1.

Let w' = `<`x,m,x'`>` be a new witness for association a' = `<`class(x),m,class(x')`>`.

If b_n(a') = Ø, then a' is a new association, so we let b_n+1(a') ‎ =  { w' }.
If class(x') is in P, then x' is in X_n+1, otherwise it is discarded (not useful for further iterations).

NB: Even if a' is a new association, it might introduce an ambiguity if the shares the same source class and message but a different target for another witnessed association.

If b_n(a') is not empty, then w' is a new witness for an existing map.

We let b_n+1(a') = b_n(a') U { w' }, adding the new witness.
Again, if class(x') is in P, then x' is in Xn+1, otherwise it is discarded.

Alternative: if size(b_n(a')) exceeds some threshold, discard x' and let b_n+1(a') = b_n(a'), i.e., not updating the set of witnesses.

If Xn+1 is empty, then no new examples of interest have been mined, and we can stop iterating.

Let new(b, b') ‎ = { a | b(a) = Ø, b'(a) != Ø } be the new associations observed in b' relative to b.

If new(b_n,b+n+1) ‎ = Ø , then no new associations have been mined, and we can stop iterating. 

Note that since there is a finite number of possible navigations within a package P, eventually we will reach this stop condition.

# Phase 3 — removing ambiguity

If a given observation map b is ambiguous, we remove ambiguity by transforming it to b' = disambiguate(b) as follows.

Let Amb(b) = obs(b)|~ partition the observed associations into sets of divergent ones, i.e., d in Amb(b), a, a' in d <=> a ~ a'.

For every d in Amb(b), let merge(d) = `<`c,m,c'`>`, where c' = V { target(a) | a in d }. That is, we construct a new association representing all associations in the same divergent partition, with the target being least common superclass of all their targets.

Now define b'(a) ‎ =  merge(d), for all d in Amb(b), else b'(a) ‎ =  Ø.

# Phase 4 — cleaning

In practice, only one witness is needed for each association, so the first (shortest) witness can be kept and the rest discarded.
Other heuristics could be used to keep a selection of witnesses.

In addition, we may have multiple associations between a source and target class, via different methods. These could be combined into a common, abstract set of navigation methods.
"
Class {
	#name : #AssociationMiner,
	#superclass : #Object,
	#instVars : [
		'package',
		'exampleMethods',
		'exampleClasses',
		'seeds',
		'packageClasses'
	],
	#category : #'GToolkit-Scenery-Mining'
}

{ #category : #accessing }
AssociationMiner class >> forClasses: aClassCollection [
	^ self new
		classes: aClassCollection;
		initializeSeedsFromExamples;
		yourself
]

{ #category : #accessing }
AssociationMiner class >> forClassesWithFactories: aClassCollection [
	^ self new
		classes: aClassCollection;
		initializeSeedsFromFactories;
		yourself
]

{ #category : #'instance creation' }
AssociationMiner class >> forPackage: aSymbolOrRPackage [
	"We assume that the argument package has gtExample classes."

	^ self new
		package: aSymbolOrRPackage;
		initializeSeedsFromExamples;
		yourself
]

{ #category : #accessing }
AssociationMiner >> classes: aClassCollection [
	packageClasses := aClassCollection asOrderedCollection sortedAs: #name
]

{ #category : #accessing }
AssociationMiner >> exampleClasses [
	^ exampleClasses
]

{ #category : #querying }
AssociationMiner >> factoryMethods [
	"Unary class methods that are presumed to be factory methods."

	^ self packageClasses
		flatCollect: [ :c | c class methods select: [ :m | m selector isUnary ] ]
]

{ #category : #views }
AssociationMiner >> gtSeedObjectsFor: aView [
	<gtView>
	^ aView forward
		title: 'Seed objects';
		priority: 20;
		object: [ seeds collect: #object ];
		view: #gtItemsFor:
]

{ #category : #views }
AssociationMiner >> gtSeedsFor: aView [
	<gtView>
	seeds ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Seeds';
		priority: 10;
		items: [ seeds ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Time to run'
			text: [ :each  | each timeToRun ]
			width: 100;
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #initialization }
AssociationMiner >> initializeSeedsFromExamples [
	self assert: self packageClasses isNotNil.
	self triageExamples.
	seeds := (exampleMethods collect: [ :m | AMExample forGtExample: m ])
			reject: #isError
]

{ #category : #initialization }
AssociationMiner >> initializeSeedsFromFactories [
	self assert: self packageClasses isNotNil.
	seeds := (self factoryMethods collect: [ :m | AMExample forFactoryMethod: m ])
			reject: #isError.
	seeds
		addAll: ((self packageClasses collect: [ :c | AMExample forClass: c ]) reject: #isError)
]

{ #category : #querying }
AssociationMiner >> navigationMethods [
	^ self packageClasses
		flatCollect: [ :c | c methods select: [ :m | m selector isUnary ] ]
]

{ #category : #accessing }
AssociationMiner >> package [
	"May be nil if the classes are set explicitly."
	^ package
]

{ #category : #accessing }
AssociationMiner >> package: aSymbolOrRPackage [
	package := aSymbolOrRPackage asPackage.
	packageClasses := package classes asOrderedCollection sortedAs: #name
]

{ #category : #accessing }
AssociationMiner >> packageClasses [
	^ packageClasses
]

{ #category : #accessing }
AssociationMiner >> regularClasses [
	^ packageClasses
]

{ #category : #initialization }
AssociationMiner >> triageExamples [
	"exampleMethods := (#gtExample gtPragmas & package gtPackageMatches) contents."

	exampleMethods := packageClasses
			flatCollect: [ :c | c methods select: [ :m | m hasPragmaNamed: #gtExample ] ].
	exampleClasses := (exampleMethods collect: #methodClass) asSet
			asOrderedCollection.
	packageClasses := packageClasses difference: exampleClasses
]
