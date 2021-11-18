# Guidelines for writing clean and fast code in MATLAB

> This document is aimed at MATLAB beginners who already know the syntax but
> feel are not yet quite experienced with it. Its goal is to give a number of
> hints which enable the reader to write quality MATLAB programs and to avoid
> commonly made mistakes.
> 
> There are three major independent chapters which may very well be read
> separately. Also, the individual chapters each split up into one or two
> handful of chunks of information. In that sense, this document is really a
> slightly extended list of dos and don'ts.
> 
> Chapter 1 describes some aspects of _clean_ code. The impact of a
> subsection for the cleanliness of the code is indicated by one to five
> 🚿-symbols, where five 🚿's want to say that following
> the given suggestion is of great importance for the comprehensibility of the
> code.
> 
> Chapter 2 describes how to speed up the code and is largely a list of mistakes
> that beginners may tend to make. This time, the 🏃-symbol represents
> the amount of speed that you could gain when sticking to the hints given in
> the respective section.
> 
> This guide is written as part of a basic course in numerical analysis, most
> examples and codes will hence tend to refer to numerical integration or
> differential equations. However, almost all aspects are of general nature and
> will also be of interest to anyone using MATLAB.


## MATLAB alternatives

When writing MATLAB code, you need to realize that unlike C, Fortran, or
Python code, you will always need the _commercial_ MATLAB environment
to have it run. Right now, that might not be much of a problem to you as you
are at a university or have some other free access to the software, but
sometime in the future, this might change.

The current cost for the basic MATLAB kit, which does not include
_any_ toolbox nor Simulink, is €500 for academic institutions;
around €60 for students; _thousands_ of Euros for commercial
operations. Considering this, there is a not too small chance that you will
not be able to use MATLAB after you quit from university, and that would
render all of your own code virtually useless to you.

Because of that, free and open source MATLAB alternatives have emerged,
three of which are shortly introduced here. Octave and Scilab try to stick to
MATLAB syntax as closely as possible, resulting in all of the code in this
document being legal for the two packages as well.  When it comes to the
specialized toolboxes, however, neither of the alternatives may be able to
provide the same capabilities that MATLAB offers. However, these are mostly
functions related to Simulink and the like which are hardly used by beginners
anyway.  Also note none of the alternatives ships with its own text editor (as
MATLAB does), so you are free yo use the editor of your choice (see, for
example, [vim](http://www.vim.org/),
[emacs](http://www.gnu.org/software/emacs/), Kate,
[gedit](http://projects.gnome.org/gedit/) for Linux;
[Notepad++](http://notepad-plus.sourceforge.net/uk/site.htm),
[Crimson Editor](http://www.crimsoneditor.com/) for Windows).

### Python

Python is the most modern programming language as of 2013: Amongst the many
award the language as received stands the TIOBE Programming Language Award of
2010. It is yearly given to the programming language that has gained the
largest market market share during that year.

Python is used in all kinds of different contexts, and its versatility and
ease of use has made it attractive to many. There are tons packages for all
sorts of tasks, and the huge community and its open development help the
enormous success of Python.

In the world of scientific computing, too, Python has already risen to be a
major player. This is mostly due to the packages SciPy and Numpy which provide
all data structures and algorithms that are used in numerical code. Plotting
is most easily handled by matplotlib, a huge library which in many ways excels
MATLAB's graphical engine.

Being a language rather than an application, Python is supported in virtually
every operating system.

The author of this document highly recommends to take a look at Python for
your own (scientific) programming projects.


### Julia

> Julia is a high-level, high-performance dynamic programming language for
> technical computing, with syntax that is familiar to users of other technical
> computing environments. It provides a sophisticated compiler, distributed
> parallel execution, numerical accuracy, and an extensive mathematical function
> library. The library, largely written in Julia itself, also integrates mature,
> best-of-breed C and Fortran libraries for linear algebra, random number
> generation, signal processing, and string processing. In addition, the Julia
> developer community is contributing a number of external packages through
> Julia’s built-in package manager at a rapid pace. IJulia, a collaboration
> between the IPython and Julia communities, provides a powerful browser-based
> graphical notebook interface to Julia.


### GNU Octave

GNU Octave is a high-level language, primarily intended for numerical
computations. It provides a convenient command line interface for solving
linear and nonlinear problems numerically, and for performing other numerical
experiments using a language that is mostly compatible with MATLAB. It may also
be used as a batch-oriented language.

Internally, Octave relies on other independent and well-recognized packages
such as gnuplot (for plotting) or UMFPACK (for calculating with sparse
matrices). In that sense, Octave is extremely well integrated into the free
and open source software (FOSS) landscape.

Octave has extensive tools for solving common numerical linear algebra
problems, finding the roots of nonlinear equations, integrating ordinary
functions, manipulating polynomials, and integrating ordinary differential and
differential-algebraic equations. It is easily extensible and customizable via
user-defined functions written in Octave's own language, or using dynamically
loaded modules written in C++, C, Fortran, or other languages.

GNU Octave is also freely redistributable software. You may redistribute it
and/or modify it under the terms of the GNU General Public License (GPL) as
published by the Free Software Foundation.

The project if originally GNU/Linux, but versions for MacOS, Windows, Sun
Solaris, and OS/2 exist.

## Clean code

There is a plethora of reasons why code that _just works™_
is not good enough. Take a peek at listing~\ref{listing:prime1} and admit:

- Fixing bugs, adding features, and working with the code in all other
  aspects get a lot easier when the code is not messy.
- Imagine someone else looking at your code, and trying to figure out what
  it does. In case you have you did not keep it clean, that will certainly be a
  huge waste of time.
- You might be planning to code for a particular purpose now, not planning
  on ever using it again, but experience tells that there is virtually no
  computational task that you come across only once in your programming life.
  Imagine yourself looking at your own code, a week, a month, or a year from
  now: Would you still be able to understand why the code works as it does?
  Clean code will make sure you do.

Examples of messy, unstructured, and generally ugly programs are plenty, but
there are also places where you are almost guaranteed to find well-structured
code. Take, for example the MATLAB internals: Many of the functions that
you might make use of when programming MATLAB are implemented in MATLAB
syntax themselves -- by professional MathWorks programmers. To look at such
the contents of the \lstinline!mean()! function (which calculates the average
mean value of an array), type \lstinline!edit mean! on the MATLAB command
line. You might not be able to understand what's going on, but the way the
file looks like may give you hints on how to write clean code.

```matlab
function lll(ll1,l11,l1l);if floor(l11/ll1)<=1;...
lll(ll1,l11+1,l1l );elseif mod(l11,ll1)==0;lll(...
ll1,l11+1,0);elseif mod(l11,ll1)==floor(l11/...
ll1)&&~l1l;floor(l11/ll1),lll(ll1,l11+1,0);elseif...
mod(l11,ll1)>1&&mod(l11,ll1)<floor(l11/ll1),...
lll(ll1,l11+1,l1l+~mod(floor(l11/ll1),mod(l11,ll1)) );
elseif l11<ll1*ll1;lll(ll1,l11+1,l1l);end;end
```
<caption>
Perfectly legal MATLAB code, with all rules of style ignored. Can you guess what this function does?
</caption>

#### Multiple functions per file - 🚿🚿🚿
It is a common and false prejudice that MATLAB cannot cope with several
functions per file. The truth is: There _may_ be more than one function
in a file, but just the first one in the file will be \emph{visible} to
functions in other files or to the command line. In that sense, those
functions in a file which do not take the first position can (only) act as a
helper for the function on top (see listing~\ref{listing:multiple-functions}).

When writing code, think about whether or not a particular function is really
just a helper, or if needs to be allowed to be called from somewhere else.
Doing so, you can avoid a cluttered mess of dozens of M-files in your program
folder.
```matlab
% callable from outside:
function topFun
  % [...]
  % calls helperFun1 and helperFun2
  % [...]
end

% only visible to all functions in this file:
function helperFun1
  % [...]
end

% only visible to all functions in this file:
function helperFun2
  % [...]
end
```
\begin{lstlisting}[framerule=2pt,rulecolor=\color{goodgreen},float,label={listing:multiple-functions},caption={One source containing three functions: Useful when \lstinline!helperFun1! and \lstinline!helperFun2! are only needed by \lstinline!topFun!.}]


##### Subfunctions - 🚿🚿
An issue that may come up if you have quite a lot of functions per file might
be that you lose sight of which function actually requires which other
function.

In case one of the functions is a helper function for not more than one other
function, a clean place to put it would be _inside_ the other function.
This way, it will only be visible to the surrounding function and its name
will not interfere with the name of any other subfunction. The biggest
advantage, however, is certainly that the subfunction is then syntactically
_clearly associated_ with its parent function. When looking at the code
for the first time, the relations between the functions are immediately
visible.

```matlab
\begin{lstlisting}[framerule=2pt,rulecolor=\color{badred}]
% [...]

function fun1
  % call helpFun1 here
end

function fun2
  % call helpFun2 here
end

function helpFun1
   % [...]
end

function helpFun2
   % [...]
end

% [...]
```
The routines \lstinline!fun1!, \lstinline!fun2!, \lstinline!helpFun1!, and \lstinline!helpFun2! are sitting next to each other and no hierarchy is visible.

```matlab
% [...]

function fun1
  % call helpFun here

  function helpFun
     % [...]
  end
end

function fun2
  % call helpFun here

  function helpFun
     % [...]
  end
end

% [...]
```
Immediately obvious: The first \lstinline!helpFun! helps \lstinline!fun1!, the
second \lstinline!fun2! -- and does nothing else.


### Variable and function names - 🚿🚿🚿

One key ingredient for a consistent source code is a consistent naming scheme
for the variables in use. From the dawn of programming languages in the 1950s,
schemes have developed and decayed and are generally subject to evolution.
There are, however, some general rules which have proven useful over the years
in all kinds of various contexts. In \cite{Johnson:2002:MPS}, a crisp and yet
comprehensive overview on many aspects of variable naming is given; a few of
the most useful ones are stated here.

##### Variable names tell what the variable does
Undoubtedly, this is the first and foremost rule in variable naming, and it
implies several things.

- Of course, you would not name a variable \lstinline!pi! when it really holds the value \lstinline!2.718128!, right?

- In mathematics and computer science, some names are connected to certain
  meanings. Table~\ref{table:typical-variable-usage} lists a number of widely
  used conventions.

```
\begin{table}
\centering
\begin{tabular}{ll}
\toprule
Variable name                                                 & Usual purpose\\\midrule
\lstinline!m!, \lstinline!n!                                  & integer sizes (,e.g., the dimension of a matrix)\\
\lstinline!i!, \lstinline!j!, \lstinline!k! (, \lstinline!l!) & integer numbers (mostly loop indices)\\
\lstinline!x!, \lstinline!y!                                  & real values ($x$-, $y$-axis)\\
\lstinline!z!                                                 & complex value or $z$-axis\\
\lstinline!c!                                                 & complex value or constant (or both)\\
\lstinline!t!                                                 & time value\\
\lstinline!e!                                                 & the Eulerian number or `unit' entities\\
\lstinline!f!, \lstinline!g! (, \lstinline!h!)                & generic function names\\
\lstinline!h!                                                 & spatial discretization parameter (in numerical analysis)\\
\lstinline!epsilon!, \lstinline!delta!                        & small real entities\\
\lstinline!alpha!, \lstinline!beta!                           & angles or parameters\\
\lstinline!theta!, \lstinline!tau!                            & parameters, time discretization parameter (in n.a.)\\
\lstinline!kappa!, \lstinline!sigma!, \lstinline!omega!       & parameters\\
\lstinline!u!, \lstinline!v!, \lstinline!w!                   & vectors\\
\lstinline!A!, \lstinline!M!                                  & matrices\\
\lstinline!b!                                                 & right-hand side of an equation system\\\bottomrule
\end{tabular}
\caption{Variable names and their usual purposes in source codes. These guidelines are not particularly strict, but for example one would never use \lstinline!i! to hold a float number, nor \lstinline!x! for an integer.}
\label{table:typical-variable-usage}
\end{table}
\end{itemize}
```

##### Short variable names
Short, non-descriptive variable names are quite common in mathematical
computing as the variable names in the corresponding (pen and paper)
calculations are hardly ever longer then one character either (see
table~\ref{table:typical-variable-usage}). To be able to distinguish between
vector and matrix entities, it is common practice in programming as well as
mathematics to denote matrices by upper-case, vectors and scalars by lower-case
characters.

```matlab
K = 20;
a = zeros(K,K);
B = ones(K,1);

U = a*B;
```
```matlab
k = 20;
A = zeros(k,k);
b = ones(k,1);

u = A*b;
```


###### Long variable names
A widely used convention mostly in the C++ development community to write
long, descriptive variables in mixed case (camel case) starting with lower
case, such as
```matlab
linearity, distanceToCircle, figureLabel.
```
Alternatively, one could use the underscore to separate parts of a compound
variable name:
```matlab
linearity, distance_to_circle, figure_label.
```
This convention is sometimes called _snake case_ and used, for example,
in the GNU C++ standard libraries.

When using the snake case notation, watch out for variable names in
MATLAB's plots: its TeX-interpreter will treat the underscore as a switch
to subscript and a variable name such as `distance_to_circle` will
read
\lstinline!distance!$_{\text{\lstinline!t!}}$\lstinline!o!$_{\text{\lstinline!c!}}$\lstinline!ircle!
in the plot.


> Using the hyphen `-` as a separator cannot be considered: MATLAB will
> immediately interpret `-` as the minus sign, `distance-to-circle` is
> `distance` minus `to` minus `circle`. The same holds for function names.

##### Logical variable names
If a variable is supposed to only hold the values `0` or `1` to represent
`true` or `false`, then the variable name should express that. A common
technique is to prepend the variable name by `is` and, less common, by `flag`.
```
isPrime, isInside, flagCircle
```

### Indentation -  🚿🚿🚿🚿

If you ever dealt with nested `for`- and `if` constructs,
then you probably noticed that it may sometimes be hard to distinguish those
nested constructions from other code at first sight. Also, if the contents of
a loop extend over more than just a few lines, a visual aid may be helpful for
indicating what is inside and what is outside the loop -- and this is where
indentation comes into play.

Usually, one would indent everything within a loop, a function, a conditional,
a `switch` statement and so on. Depending on who you ask, you will be
told to indent by two, three, or four spaces, or one tab. As a general rule,
the indentation should yield a clear visual distinction while not using up all
your space on the line (see next paragraph).

```matlab
for i=1:n
for j=1:n
if A(i,j)<0
A(i,j) = 0;
end
end
end
```
No visual distinction between the loop levels makes it hard to recognize where the first loop ends.[^1]

```matlab
for i=1:n
  for j=1:n
    if A(i,j)<0
      A(i,j) = 0;
    end
  end
end
```
With indentation, the code looks a lot clearer.\footnotemark[\value{footnote}]

[^1]: What the code does is replacing all negative entries of an `n`×`n`-matrix
  by `0`. There is, however, a much better (shorter, faster) way to achieve
  this: `A( A<0 ) = 0`; (see page \pageref{sec:logicalIndexing}).



### Line length - 🚿

There is de facto no limit on how much you can write on a single line of MATLAB
code. In fact, you could condense every MATLAB code to a "one-liner" by
separating two commands by a `;` or a `,`, and suppress the newline character
between them. However, a single line with one million characters will
potentially not be very readable.

But, how many characters can you fit onto a single line without obscuring its
content? This is certainly debatable, but commonly this value sits somewhere
between 70 and 80; MATLAB's own text editor suggests 75 characters per
line. This way, one makes also sure that it is not necessary to have a
widescreen monitor to be able to display the code without artificial line
breaks or horizontal scrolling in the editor.

Sometimes of course your lines need to stretch longer than this, but that's why
MATLAB contains the ellipses `...` which makes sure the line following the line
with the ellipsis is read as if there was no line break at all.

```matlab
a = sin( exp(x) ) ...
  - alpha* 4^6    ...
  + u'*v;
```
```matlab
a = sin( exp(x) ) - alpha* 4^6 + u'*v;


```


### Spaces and alignment - 🚿🚿🚿

In some situations, it makes sense to break a line although it has not up to
the limit, yet. This may be the case when you are dealing with an expression
that -- because of its length -- has to break anyway further to the right;
then, one would like to choose the line break point such that it coincides with
_semantic_ or _syntactic_ break in the syntax. For examples, see the
code below.
```matlab
A = [ 1, 0.5 , 5; 4, ...
42.23, 33; 0.33, ...
pi, 1];

a = alpha*(u+v)+beta*...
sin(p'*q)-t...
*circleArea(10);
```
Unsemantic line breaks decrease the readability. Neither the shape of the
matrix, nor the number of summands in the second expression is clear.

```matlab
A = [ 1   , 0.5  , 5 ; ...
      4   , 42.23, 33; ...
      0.33, pi   , 1   ];

a = alpha* (u+v)     ...
  + beta*  sin(p'*q) ...
  - t*     circleArea(10);
```
The shape and contents of the matrix, as well as the elements of the second expression, are immediately visible to the programmer.

##### Spaces in expressions
Closely related to this is the usage of spaces in expressions. The rule is,
again: put spaces there where MATLAB's syntax would. Consider the following
example.
```matlab
aValue = 5+6 / 3*4;
```
This spacing suggests that the value of `aValue` will be 11/12, which is of
course not the case.

```matlab
aValue = 5 + 6/3*4;
```
Much better, as the the fact that the addition is executed last gets reflected
by according spacing.


### Magic numbers -- 🚿🚿🚿

When coding, sometimes you consider a value constant because you do not intend
to change it anytime soon. Take, for example, a program that determines whether
or not a given point sits outside a circle of radius 1 with center (1,1) and at
the same time inside a square of edge length 2, right enclosing the circle (see
\cite{Hull:2006:CCM}).

When finished, the code will contain a couple of `1`s but it will not be clear
if they are distinct or refer to the same abstract value (see below).  Those
hard coded numbers are frequently called _magic numbers_, as they do what they
are supposed to do, but one cannot easily tell why. When you, after some time,
change your mind and you do want to change the value of the radius, it will be
rather difficult to identify those `1`s which actually refer to it.

```matlab
x = 2; y = 0;

pointsDistance = ...
  norm( [x,y]-[1,1] );

isInCircle = ...
      (pointsDistance < 1);
isInSquare = ...
     ( abs(x-1)<1 ) && ...
     ( abs(y-1)<1 );

if ~isInCircle && isInSquare
% [...]
```
It is not immediately clear if the various `1`s do in the code and
whether or not they represent one entity. These numbers are called _magic
numbers._

```matlab
x = 2; y = 0;

radius = 1;
xc = 1; yc = 1;

pointsDistance = ...
  norm( [x,y]-[xc,yc] );

isInCircle = ...
 (pointsDistance < radius);
isInSquare = ...
 ( abs(x-xc)<radius ) && ...
 ( abs(y-yc)<radius );

if ~isInCircle && isInSquare
% [...]
\end{lstlisting}
The meaning of the variable \lstinline!radius! is can be instantly seen and its
value easily altered.
```

### Comments - 🚿🚿🚿🚿🚿

The most valuable character for clean MATLAB code is `%`, the comment
character. All tokens after it on the same line are ignored, and the space can
be used to explain the source code in English (or your tribal language, if you
prefer).

##### Documentation - 🚿🚿🚿🚿🚿
There should be a big fat neon-red blinking frame around this paragraph, as
documentation is _the_ single most important aspect about clean and
readable code. Unfortunately, it also takes the longest to write which is why
you will find undocumented source code everywhere you go.

Look at listing~\ref{listing:fences} for a suggestion for quick and clear
documentation, and see if you can do it yourself!


##### Structuring elements - 🚿🚿🚿
It is always useful to have the beginning and the end of the function not only
indicated by the respective keywords, but also by something more visible.
Consider building 'fences' with commented `#`, `!=`, or `-` characters, to
visually separate distinct parts of the code.  This comes in very handy when
there are multiple functions in one source file, for example, or when there is
a `for`-loop that stretches over that many lines that you cannot easily find
the corresponding `end` anymore.

For a (slightly exaggerated) example, see listing~\ref{listing:fences}.

```matlab
function out = timeIteration( u, n )
  % Takes a starting vector u and performs n time steps.
  %

  % set the parameters
  tau   = 1.0;
  kappa = 1.0;
  out   = u;

  % do the iteration
  for k = 1:n

      [out, flag] = proceedStep( out, tau, kappa );

      % warn if something went wrong
      if ~flag
          warning( [ 'timeIteration:errorFlag', ...
                     'proceedStep returns flag ', flag ] );
      end
  end
end
```
<caption>
Function in which `-`-fences are used to emphasize the functionally separate sections of the code.
</caption>


### Usage of brackets - 🚿🚿
Of course, there is a clearly defined operator precedence list in MATLAB
(see table~\ref{table:operator-precedence}) that makes sure that for every
MATLAB expression, involving any unary or binary operator, there is a
unique way of evaluation. It is quite natural to remember that MATLAB
treats multiplication (\lstinline!*!) before addition (\lstinline!+!), but
things may get less intuitive when it comes to logical operators, or a mix of
numerical and logical ones (although this case is admittedly very rare).

Of course one can always look those up (see
table~\ref{table:operator-precedence}), but to save the work one could equally
quick just insert a pair of bracket at the right spot, although they may be
unnecessary -- this will certainly help avoiding confusion.

```matlab
isGood =  a<0 ...
       && b>0 || k~=0;
```
<caption>
Without knowing if MATLAB first evaluates the short-circuit AND `\lstinline!&&!' or the short-circuit OR `\lstinline!||!', it is impossible to predict the value of \lstinline!isGood!.
</caption>
```matlab
isGood = ( a<0 && b>0 ) ...
       || k~=0;
```
<caption>
With the (unnecessary) brackets, the situation is clear.
</caption>

```
\begin{table}
\begin{enumerate}
\item Parentheses \lstinline!()!
\item Transpose (\lstinline!.'!), power (\lstinline!.^!), complex conjugate transpose (\lstinline!'!), matrix power (\lstinline!^!)
\item Unary plus (\lstinline!+!), unary minus (\lstinline!-!), logical negation (\lstinline!~!)
\item Multiplication (\lstinline!.*!), right division (\lstinline!./!), left division (\lstinline!.\!), matrix multiplication (\lstinline!*!), matrix right division (\lstinline!/!), matrix left division (\lstinline!\!)
\item Addition (\lstinline!+!), subtraction (\lstinline!-!)
\item Colon operator (\lstinline!:!)
\item Less than (\lstinline!<!), less than or equal to (\lstinline!<=!), greater than (\lstinline!>!), greater than or equal to (\lstinline!>=!), equal to (\lstinline!==!), not equal to (\lstinline!~=!)
\item Element-wise AND (\lstinline!&!)
\item Element-wise OR (\lstinline!|!)
\item Short-circuit AND (\lstinline!&&!)
\item Short-circuit OR (\lstinline!||!)
\end{enumerate}
\caption{MATLAB operator precedence list.}
\label{table:operator-precedence}
\end{table}
```

### Errors and warnings - 🚿🚿

No matter how careful you design your code, there will probably be users who
manage to crash it, maybe with bad input data. As a matter of fact, this is not
really uncommon in numerical computation that things go fundamentally wrong.

> You write a routine that defines an iterative process to find the solution
> $u^* = A^{-1}b$ of a linear equation system (think of conjugate gradients).
> For some input vector $u$, you hope to find $u^*$ after a finite number of
> iterations. However, the iteration will only converge under certain conditions
> on $A$; and if $A$ happens not to fulfill those, the code will misbehave in
> some way.

It would be bad practice to assume that the user (or, you) always provides
input data to your routine fulfilling all necessary conditions, so you would
certainly like to conditionally intercept. Notifying the user that something
went wrong can certainly be done by `disp()` or `fprintf()` commands, but the
clean way out is using `warning()` and `error()`. - The latter differs from the
former only in that it terminates the execution of the program right after
having issued its message.

```matlab
tol = 1e-15;
rho = norm(r);

while abs(rho)>tol
  r   = oneStep( r );
  rho = norm( r );
end

% process solution
```
Iteration over a variable `r` that is supposed to be smaller than `tol` after
some iterations. If that fails, the loop will never exit and occupy the CPU
forever.
```matlab
tol  = 1e-15;
rho  = norm(r);
kmax = 1e4;

k = 0;
while abs(rho)>tol && k<kmax
  k   = k+1;
  r   = oneStep( r );
  rho = norm( r );
end

if k==kmax
  warning('myFun:noConv',...
        'Did not converge.')
else
  % process solution
end
```
<caption>
Good practice: there is a maximum number of iterations. When it has been reached, the iteration failed. Throw a warning in that case.
</caption>

Although you could just evoke \lstinline!warning()! and \lstinline!error()! with a single string as argument (such as \lstinline~error('Something went wrong!')~), good style programs will leave the user with a clue \emph{where} the error has occurred, and of what type the error is (as mnemonic). This information is contained in the so-called \emph{message ID}.

The MATLAB help page contain quite a bit about message IDs, for example:

> The `msgID` argument is a unique message identifier string that MATLAB
> attaches to the error message when it throws the error. A message identifier
> has the format `component:mnemonic`. Its purpose is to better identify the
> source of the error.

### Switch statements - 🚿🚿

\lstinline!switch! statements are in use whenever one would otherwise have to write a conditional statement with several \lstinline!elseif! statements. They are also particularly popular when the conditional is a string comparison (see example below).

```matlab
switch pet
  case 'Bucky'
    feedCarrots();
  case 'Hector'
    feedSausages();
end
```
<caption>
When none of the cases matches, the algorithm will just skip and continue.
</caption>

```matlab
switch pet
  case 'Bucky'
    feedCarrots();
  case 'Hector'
    feedSausages();
  otherwise
    error('petCare:feed',...
          'Unknown pet.'
end
```
<caption>
The unexpected case is intercepted.
</caption>


```matlab
function p = prime( N )
  % Returns all prime numbers below or equal to N.
  %

  for i = 2:N
      % checks if a number is prime
      isPrime = 1;
      for j = 2:i-1
          if ~mod(i, j)
              isPrime = 0;
              break
          end
      end

      % print to screen if true
      if isPrime
          fprintf( '%d is a prime number.\n', i );
      end
  end

end
```
<caption>
The same code as in listing~\ref{listing:prime1}, with rules of style applied.
It should now be somewhat easier to maintain and improve the code. Do you have
ideas how to speed it up?
</caption>
