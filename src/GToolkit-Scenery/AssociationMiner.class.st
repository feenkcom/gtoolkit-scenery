"
I iteratively mine associations between classes using a seed set of example instances.
# Summary

The algorithm uses examples and unary methods to iteratively mine associations from classes to classes within a package. Each association has one or more “witnesses” — examples that demonstrate that you can navigate from an object of the source class to one of the target using a unary method. 
The algorithm consists of three phases: 
(i) collect an initial seed set of examples, from example methods, or from factory methods, 
(ii) produce iterations, each of which consists of a set of associations and witnesses, stopping when we run out of examples, we don't produce any new associations for the package, or we reach some heuristic limits, and 
(iii) we process the associations for which a source class example instance can navigate to multiple target classes, to instead target a common superclass.
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

We create an initial seed set of examples, Seed_0 subset X, where:

Seed_0 = { x = `<`o,c new m`>` | c in Ex, m in u(c), o = eval(c new m) } 

Variant: there are no example classes, so instead we construct examples using factory messages of classes in P.

Seed_0 = { x = `<`o,c m`>` | c in P, m in f(c), o = eval(c m) }

We then *clean* the initial set with a partial function clean : X -> X that filters out uninteresting examples, and transforms those that map to collections.
Let x = `<`o,e`>`. Then we define x"" = clean(x) as follows.
If class(x) = Error or Undefined, then clean(x) = ⊥ (bottom).
If class(x) is a collection, then let x' = `<`o,e•#any`>`. if class(x') = Error or Undefined or collection, then clean(x) = ⊥, else clean(x) = x'.
If class(x) is not a collection, then clean(x) = x.

We now define Seed = clean(Seed_0) = { clean(x) | x in Seed_0, clean(x) != ⊥ }
# Phase 2 — producing an iteration

An *iteration* is a tuple It_n = `<`b_n,X_n`>` of extended observations and new examples to analyze.
X_n is the set of *new examples* produced in that iteration, to be analyzed in the next iteration, and b_n is the association set produced thus far. The initial iteration consists of X_0 = Seed and b_0 = A -> {}.
We also define new(b_n,X_n) to be the *new asssociations* discovered in iteration n+1.

A new iteration It_n+1 = `<`b_n+1, X_n+1`>` = iter(`<`b_n, X_n`>`) consists of
(i) an updated observation map, b_n+1, where, for any a in A, b_n(a) subset b_n+1(a), and
(ii) X_n+1, a set of new examples for analysis in the next iteration.
X_n+1 may be empty (no new examples).

X_n+1 and b_n+1 are defined as follows, by iterating over X_n.

For each example x = `<`o,e`>` in Xn, and unary m in u(class(o)), let x' = `<`o',e'`>` where o' = eval(o m) and e' = e•m.

Let x"" = clean(x'). If x"" is nil, discard it. 
Otherwise let w = <x,m,x""> and a = <class(x),m,class(x"")>.

If b_n(a) = Ø, then let a in new(b_n,X_n), and b_n+1(a) = {w}.
Else let b_n+1(a) = b_n(a) U {w}.

NB: Even if a is a new association, it might introduce an ambiguity if it shares the same source class and message but a different target for another witnessed association.

Alternative: if size(b_n(a)) exceeds some threshold, discard x' and let b_n+1(a) = b_n(a), i.e., not updating the set of witnesses.

Let x"" in X_n+1 if class(x"") in P, o/w discard it.

We keep witnesses that map outside of P, but not new examples.

If Xn+1 is empty, then no new examples of interest have been mined, and we can stop iterating.

If new(b_n,X_n) ‎ =  Ø, then no new associations have been mined, and we can stop iterating. 

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
	#traits : 'TAMUtility',
	#classTraits : 'TAMUtility classTrait',
	#instVars : [
		'package',
		'exampleMethods',
		'exampleClasses',
		'seeds',
		'packageClasses',
		'iterations',
		'announcer'
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
AssociationMiner >> addIteration [
	self iterations addLast: self iterations last iterate.
	self announcer
		announce: (AMIterationAdded new
				iteration: self iterations last;
				yourself)
]

{ #category : #accessing }
AssociationMiner >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
AssociationMiner >> classes: aClassCollection [
	packageClasses := aClassCollection asOrderedCollection sortedAs: #name
]

{ #category : #accessing }
AssociationMiner >> exampleClasses [
	^ exampleClasses
]

{ #category : #accessing }
AssociationMiner >> exampleMethods [
	^ exampleMethods
]

{ #category : #querying }
AssociationMiner >> factoryMethods [
	"Unary class methods that are presumed to be factory methods."

	^ self packageClasses
		flatCollect: [ :c | c class methods select: [ :m | m selector isUnary ] ]
]

{ #category : #'as yet unclassified' }
AssociationMiner >> gtIterateActionFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Generate new iteration';
		priority: 10;
		icon: BrGlamorousIcons play;
		action: [ :aButton | self addIteration ]
]

{ #category : #views }
AssociationMiner >> gtIterationsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Iterations';
		priority: 30;
		items: [ self iterations ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: '# Classes'
			text: [ :each | each classes size ]
			width: 100;
		column: '# Observations'
			text: [ :each | each observations size ]
			width: 100;
		column: '# Examples'
			text: [ :each | each examples size ]
			width: 100;
		column: '# New associations'
			text: [ :each | each newAssociations size ]
			width: 1560;
		actionUpdateButton;
		updateWhen: AMIterationAdded in: self announcer
]

{ #category : #views }
AssociationMiner >> gtSeedsFor: aView [
	<gtView>
	^ (self gtExamplesFor: aView with: self seeds)
		title: 'Seeds';
		priority: 10
]

{ #category : #initalization }
AssociationMiner >> initialize [
	super initialize.
	iterations := OrderedCollection new
]

{ #category : #initialization }
AssociationMiner >> initializeSeedsFromExamples [
	"Seeds are created from all the <gtExample> methods found in the package classes."

	| examples |
	self assert: self packageClasses isNotNil.
	self triageExamples.
	examples := exampleMethods collect: [ :m | AMExample forGtExample: m ].
	
	self seeds: examples
]

{ #category : #initialization }
AssociationMiner >> initializeSeedsFromFactories [
	"Seeds are created from any factory (class) methods found in the [ackage classes, as well as by sending #new to every package class. Errors are filtered out."

	| examples |
	self assert: self packageClasses isNotNil.
	examples := self factoryMethods collect: [ :m | AMExample forFactoryMethod: m ].
	examples addAll: (self packageClasses collect: [ :c | AMExample forClass: c ]).

	self seeds: examples
]

{ #category : #accessing }
AssociationMiner >> iterations [
	"NB: Updated by #seeds:"
	^ iterations
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

{ #category : #accessing }
AssociationMiner >> seeds [
	^ seeds
]

{ #category : #accessing }
AssociationMiner >> seeds: anExampleCollection [
	"Process the initial collection, cleaning examples, removing discards, and keeping only relevant examples from the packageClasses of interest."

	seeds := anExampleCollection
			collect: #clean
			thenSelect: [ :eg | eg notNil and: [ self packageClasses includes: eg objectClass ] ].

	iterations := {AMIteration forSeeds: seeds andClasses: self packageClasses}
			asOrderedCollection
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
