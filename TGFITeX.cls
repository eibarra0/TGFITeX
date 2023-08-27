%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TGFITeX Thesis Class File
% 
% Based on TMDEI Thesis Class File Version 0.1 (Dec/2015) by Nuno Pereira (nap@isep.ipp.pt) and
% Paulo Baltarejo (pbs@isep.ipp.pt), downloaded from [Overleaf] (https://www.overleaf.com/)
%
% Authors:
%  Nuno Pereira (nap@isep.ipp.pt) and 
%  Paulo Baltarejo (pbs@isep.ipp.pt)
%
% Adapted to TGFITeX style (July/2023) by 
%  Enrique Ibarra
%
% Notes:
% 1) This class file defines the structure and layout of the template file (main.tex).
% 2) It has been written in such a way that under most circumstances you 
% should not need to edit it.
%
% Class license:
% MIT License Copyright (c) 2023 Enrique Ibarra
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%----------------------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{TGFITeX}
\ProvidesClass{\classname}
\providecommand{\baseclass}{book}

\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{hyperreflinkcolor}
\booltrue{hyperreflinkcolor}

\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nohyperreflinkcolor}{\boolfalse{hyperreflinkcolor}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}


% Redefine font size and baselineskip if needed
% \renewcommand{\normalsize}{\fontsize{1.0\dimexpr\f@size pt}{0.8\dimexpr\f@size pt}\selectfont}
% \renewcommand{\large}{\fontsize{1.2\dimexpr\f@size pt}{0.9\dimexpr\f@size pt}\selectfont}






%----------------------------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------------------------

\ifbool{parskip}{\RequirePackage{parskip}} % If the parskip option is passed to the class, require the parskip package

\patchcmd{\chapter}{\thispagestyle{plain}}{}{}{}


% Modify here the headers of chapters in the mainmatter
\patchcmd{\@makechapterhead}{
\if@mainmatter
    \huge\bfseries \@chapapp\space \thechapter
    \par\nobreak
    \vskip 20\p@
\fi
}{
\if@mainmatter
    \vspace{-2pt}
    \centering\large\bfseries\MakeUppercase \@chapapp\space \thechapter\\
    \vskip 15\p@
\fi
}{}{}

\patchcmd{\@makechapterhead}{
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
}{
\interlinepenalty\@M
{\centering\fontsize{1.0\dimexpr\f@size pt}{0.9\dimexpr\f@size pt}\selectfont\bfseries #1\par\nobreak}
\vskip 15\p@
}{}{}


% Modify here the headers of chapters in the frontmatter
\patchcmd{\@makeschapterhead}{
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
}{
    \normalfont
    \interlinepenalty\@M
    \centering\large\bfseries\MakeUppercase #1\\
    \vskip 15\p@
}{}{}


% Modify here the formatting of sections and lower levels from the book base class
\patchcmd{\section}{\normalfont\Large\bfseries}{\normalfont\large\bfseries}{}{}
\patchcmd{\subsection}{\normalfont\large\bfseries}{\normalfont\normalsize\bfseries}{}{}
\patchcmd{\subsubsection}{\normalfont\normalsize\bfseries}{\normalfont\normalsize\bfseries\itshape}{}{}
% \patchcmd{\paragraph}{\normalfont\normalsize\bfseries}{}{}{}
% \patchcmd{\subparagraph}{\normalfont\normalsize\bfseries}{}{}{}


% Adjust spaces between chapters
\patchcmd{\@makechapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\patchcmd{\@makeschapterhead}{\vspace*{50\p@}}{\abovechapterspace}{}{}
\newcommand{\abovechapterspace}{\vspace*{50pt}}


\ifbool{listtoc}{% If the liststotoc option has been passed to the class, add the lists to the table of contents
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}}{}{}%
}

\ifbool{toctoc}{% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
	\patchcmd{\tableofcontents}{\@starttoc{toc}}{%
		\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
}

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}}{%
			\begingroup%
			\singlespace\@starttoc{lof}\endgroup%
		}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}}{%
			\begingroup%
			\singlespace\@starttoc{lot}\endgroup%
		}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}}{%
			\begingroup%
			\singlespace\@starttoc{toc}\endgroup%
		}{}{}%
}{}

% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addchaptertocentry{#3}%
			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
		}{%
			\addchaptertocentry{#2}%
			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%


% Indicate the number of figure in caption to be bold
\patchcmd{\fnum@figure}{
\thefigure%
}{
{\bfseries\thefigure}%
}{}{}

% Indicate the number of table in caption to be bold
\patchcmd{\fnum@table}{
\thetable%
}{
{\bfseries\thetable}%
}{}{}



%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english

\RequirePackage{float}

\RequirePackage{setspace}
\RequirePackage{ragged2e}
\RequirePackage{changepage}
\RequirePackage[titletoc,page]{appendix}
\RequirePackage{datetime2}

\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements

\RequirePackage{scrhack} % Loads fixes for various packages

\RequirePackage{setspace} % Required for changing line spacing

\RequirePackage{lipsum}

\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)

\RequirePackage{siunitx} % Required for \SI commands

\RequirePackage{graphicx} % Required to include images
\graphicspath{{.}}

\RequirePackage[dvipsnames]{xcolor} % Required for extra color names

\RequirePackage{booktabs} % Required for better table rules

\RequirePackage[utf8]{inputenc} % Required for inputting portuguese characters
\RequirePackage[T1]{fontenc} % Output font encoding for portuguese characters
\renewcommand{\rmdefault}{phv} % Arial
\renewcommand{\sfdefault}{phv} % Arial

\RequirePackage[autostyle=true]{csquotes}
% Required to generate language-dependent quotes in the bibliography

\RequirePackage[chapter]{algorithm} % Required for Algorithms
\RequirePackage{algpseudocode} % Part algorithmicx package, required to customize the layout of algorithms.

\RequirePackage{listings} % Required for code listings
\lstdefinestyle{MyPlainText}{
basicstyle=\normalsize\ttfamily,
columns=flexible,
breaklines=true,
}

\lstdefinestyle{MyC}{ %
  backgroundcolor=\color{white},   % choose the background color; 
  basicstyle=\footnotesize,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=b,                    % sets the caption-position to bottom
  commentstyle=\color{green},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=single,	                   % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code 
  keywordstyle=\color{blue},       % keyword style
  language=C,                 % the default language of the code
  otherkeywords={*,...},           % if you want to add more keywords to the set
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{gray}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=1,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{MidnightBlue},     % string literal style
  tabsize=2,	                   % sets default tabsize to 2 spaces
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}

\lstdefinestyle{MyJava}{ %
  backgroundcolor=\color{white},   % choose the background color; 
  basicstyle=\footnotesize,        % the size of the fonts that are used for the code
  breakatwhitespace=false,         % sets if automatic breaks should only happen at whitespace
  breaklines=true,                 % sets automatic line breaking
  captionpos=b,                    % sets the caption-position to bottom
  commentstyle=\color{green},    % comment style
  deletekeywords={...},            % if you want to delete keywords from the given language
  escapeinside={\%*}{*)},          % if you want to add LaTeX within your code
  extendedchars=true,              % lets you use non-ASCII characters; for 8-bits encodings only, does not work with UTF-8
  frame=single,	                   % adds a frame around the code
  keepspaces=true,                 % keeps spaces in text, useful for keeping indentation of code 
  keywordstyle=\color{red},       % keyword style
  language=Java,                 % the default language of the code
  otherkeywords={*,...},           % if you want to add more keywords to the set
  numbers=left,                    % where to put the line-numbers; possible values are (none, left, right)
  numbersep=5pt,                   % how far the line-numbers are from the code
  numberstyle=\tiny\color{gray}, % the style that is used for the line-numbers
  rulecolor=\color{black},         % if not set, the frame-color may be changed on line-breaks within not-black text
  showspaces=false,                % show spaces everywhere adding particular underscores; it overrides 'showstringspaces'
  showstringspaces=false,          % underline spaces within strings only
  showtabs=false,                  % show tabs within strings adding particular underscores
  stepnumber=1,                    % the step between two line-numbers. If it's 1, each line will be numbered
  stringstyle=\color{MidnightBlue},     % string literal style
  tabsize=2,	                   % sets default tabsize to 2 spaces
  title=\lstname                   % show the filename of files included with \lstinputlisting; also try caption instead of title
}

\lstset{language=Java}
\lstset{language=c}

\RequirePackage[acronym,nonumberlist,toc]{glossaries} %Required to define acronyms and make glossaries

\RequirePackage{caption} % Required for customising the captions
\captionsetup{font=normal,labelfont=bf,justification=centering}

\RequirePackage[hyphens]{url}
\RequirePackage{hyperref} % Required for customising links and the PDF


%----------------------------------------------------------------------------------------

\newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active  
\if@openright\cleardoublepage\else\clearpage\fi
}

\newcommand\bhrule{\typeout{--------------------}}
\newcommand\tttypeout[1]{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{\linewidth}{0.5mm}} % New command to make the lines in the title page
\newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures

\renewcommand{\abovechapterspace}{\vspace*{10pt}} % Reduce the whitespace above a chapter heading

\setcounter{tocdepth}{3} % The depth to which the document sections are printed to the table of contents
\providecommand\addchaptertocentry[1]{%
\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
\addcontentsline{toc}{chapter}{#1}%
}

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\RequirePackage[showframe=false,includehead,includefoot]{geometry}
\geometry{
    paper=a4paper,
	inner=35mm, % Inner margin
	outer=25mm, % Outer margin
	top=25mm, % Top margin
	bottom=25mm, % Bottom margin
	headsep=5mm,
    headheight=15mm,
    marginparsep=0cm,
    marginparwidth=0cm,
    footskip=15mm,
}

% Inserted in order to avoid an undesired vertical distribution of 
% text in pages that were not completely filled
\raggedbottom

% In view of the previous command, this returns all footnotes to the bottom position
\renewcommand{\footnoterule}{\vfill\kern -3pt \hrule width 0.4\columnwidth \kern 2.6pt}


% Get the currently selected language and display in log file
\tttypeout{Babel selected language: \languagename}


\iflanguage{english}{
    \renewcommand{\lstlistingname}{Algorithm}
    \renewcommand{\ALG@name}{Algorithm}
    }{
        \iflanguage{spanish}{
        \babelprovide[es-noshorthands,es-noquoting]{spanish}
        \renewcommand{\lstlistingname}{Algoritmo}
        \renewcommand{\ALG@name}{Algoritmo}
        }{
        \GenericError{}{Language employed in document is not allowed}{Stop here: use either english or spanish}
        }
    }


%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000 % No consecutive line hyphens
\brokenpenalty=10000 % No broken words across columns/pages
\widowpenalty=9999 % Almost no widows at bottom of page
\clubpenalty=9999 % Almost no orphans at top of page
\interfootnotelinepenalty=9999 % Almost never break footnotes


\renewcommand{\spanishtablename}{\sf \textbf{Tabla}}
\renewcommand{\spanishfigurename}{\sf \textbf{Figura}}
\renewcommand{\spanishcontentsname}{Índice general}
\renewcommand\spanishchaptername{Capítulo}
\renewcommand{\spanishappendixname}{Anexo}
\renewcommand{\spanishbibname}{Bibliografía}
\renewcommand{\spanishlistfigurename}{Índice de figuras}
\renewcommand{\spanishlisttablename}{Índice de tablas}




%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

\RequirePackage{fancyhdr}

\newcommand{\titleUp}{\MakeUppercase{\@title}}
\newcommand{\userfontsizei}{\fontsize{10pt}{12pt}\selectfont}

% Define the pagestyle
\fancypagestyle{thesis}{
    \fancyhf{} % Clear header and footer
    \fancyhead[C]{%
        \normalfont\userfontsizei%
        {\univname\hfill\facultname}\\
        {\subjectname\hfill Trabajo Final de Grado}\\
        {\bfseries\titleUp}%
    }
    
    \fancyfoot[C]{%
    % vbox strictly necessary to keep the content inside the dedicated area
    \vbox{
        \normalfont\userfontsizei%
        \ifodd\value{page}%
            \RaggedLeft\printallauthorsii\\%
        \else
            \RaggedRight\printallauthorsii\\%
        \fi
        \centering\thepage%
    }
    }
    \renewcommand{\headrulewidth}{1.5pt} % Header rule
    \renewcommand{\footrulewidth}{1.5pt} % Footer rule
}

\newcommand{\blank@p@gestyle}{empty}
\newcommand{\blankpagestyle}[1]{\def\blank@p@gestyle{#1}}

\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
\hbox{}
\thispagestyle{\blank@p@gestyle}
\newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}





%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM THESIS INFORMATION COMMANDS
%----------------------------------------------------------------------------------------

\def\ttitle{}
\newcommand*{\thesistitle}[1]{\def\@title{#1}\def\ttitle{#1}}
\newcommand*{\thesissubtitle}[1]{\def\tsubtitle{#1}}
\newcommand*{\subjectarea}[1]{\def\subjectname{#1}}
\newcommand*{\committeepresident}[1]{\def\presidentname{#1}}
\newcommand*{\committeemembers}[1]{\def\committee{#1}}
\newcommand*{\thesisdate}[1]{\def\tdate{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\faculty}[1]{\def\facultname{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
\newcommand*{\location}[1]{\def\locationname{#1}}




%----------------------------------------------------------------------------------------
%	AUTHORS AND SUPERVISORS
%----------------------------------------------------------------------------------------

% Here some macros to allow for multiple authors and supervisor through lists

\newcounter{ei@authornum}
\setcounter{ei@authornum}{0}
\newcommand{\authorlist}{}

\renewcommand*{\author}[2]{%
    \addtocounter{ei@authornum}{1}%
    \edef\@tempa{\noexpand\the\expandafter\authorlist, \noexpand\arabic{ei@authornum}}%
    \expandafter\gdef\csname author\romannumeral\value{ei@authornum}\endcsname{#2}%
    \expandafter\gdef\csname authorshort\romannumeral\value{ei@authornum}\endcsname{#1}%
    \ifnum\value{ei@authornum}>1%
        \expandafter\g@addto@macro\expandafter\authorlist\expandafter{, \romannumeral\value{ei@authornum}}%
    \else
        \expandafter\g@addto@macro\expandafter\authorlist\expandafter{\romannumeral\value{ei@authornum}}%
    \fi
}

\newcommand*{\getauthor}[1]{%
    \ifcsname author\romannumeral#1\endcsname%
        \csname author\romannumeral#1\endcsname%
    \else
        Author not found%
    \fi
}

\newcommand*{\getauthorshort}[1]{%
    \ifcsname authorshort\romannumeral#1\endcsname%
        \csname authorshort\romannumeral#1\endcsname%
    \else
        Author not found%
    \fi
}

\newcommand*{\printallauthorsi}{%
    \noindent%
    \foreach \i in {1,...,\value{ei@authornum}}{%
        \ifnum\i<\value{ei@authornum}%
            \getauthor{\i}%
            \par%
            \bigskip%
        \else
            \getauthor{\i}%
        \fi
    }%
}

\newcommand*{\printallauthorsii}{%
    \noindent%
    \foreach \i in {1,...,\value{ei@authornum}}{%
        \ifnum\i<\value{ei@authornum}%
            \getauthorshort{\i}, %
        \else
            \getauthorshort{\i}%
        \fi
    }%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{ei@supervisornum}
\setcounter{ei@supervisornum}{0}
\newcommand{\supervisorlist}{}

\newcommand*{\supervisor}[1]{%
    \addtocounter{ei@supervisornum}{1}%
    \edef\@tempa{\noexpand\the\expandafter\supervisorlist, \noexpand\arabic{ei@supervisornum}}%
    \expandafter\gdef\csname supervisor\romannumeral\value{ei@supervisornum}\endcsname{#1}%
    \ifnum\value{ei@supervisornum}>1%
        \expandafter\g@addto@macro\expandafter\supervisorlist\expandafter{, \romannumeral\value{ei@supervisornum}}%
    \else
        \expandafter\g@addto@macro\expandafter\supervisorlist\expandafter{\romannumeral\value{ei@supervisornum}}%
    \fi
}

\newcommand*{\getsupervisor}[1]{%
    \ifcsname supervisor\romannumeral#1\endcsname%
        \csname supervisor\romannumeral#1\endcsname%
    \else
        Supervisor not found%
    \fi
}

\newcommand*{\printallsupervisorsi}{%
    \noindent%
    \foreach \i in {1,...,\value{ei@supervisornum}}{%
        \ifnum\i<\value{ei@supervisornum}%
            \getsupervisor{\i}, %
        \else
            \getsupervisor{\i}%
        \fi
    }%
}


%----------------------------------------------------------------------------------------
%	TITLEPAGE PAGE DESIGN
%----------------------------------------------------------------------------------------


\newcommand{\dissertationdisclamer}{A dissertation submitted in partial fulfillment of ...}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\dissertationdisclamer}{A dissertation submitted in partial fulfillment of ...}
\providecaptionname{spanish}{\dissertationdisclamer}{Disertación para obtener el grado de ...} 


\newcommand{\supervisorlabel}{Supervisor}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\supervisorlabel}{Supervisor}
\providecaptionname{spanish}{\supervisorlabel}{Asesor}


\newcommand{\cosupervisorlabel}{Co-Supervisor}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\cosupervisorlabel}{Co-Supervisor}
\providecaptionname{spanish}{\cosupervisorlabel}{Co-Asesor}


\newcommand{\evallabel}{Evaluation Committee}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\evallabel}{Evaluation Committee}
\providecaptionname{spanish}{\evallabel}{Comité Evaluador}


\newcommand{\presidentlabel}{President}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\presidentlabel}{President}
\providecaptionname{spanish}{\presidentlabel}{Presidente}


\newcommand{\memberslabel}{Members}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\memberslabel}{Members}
\providecaptionname{spanish}{\memberslabel}{Miembros}


% Here the title page

\newcommand{\maketitlepage}{
	\checktoopen
    \begin{titlepage}
    {\centering\fontsize{18pt}{0pt}\selectfont %\setlength{\parskip}{}
    \bfseries\MakeUppercase\univname\\ \null\vspace{18pt} \null\vspace{18pt}}

    {\centering\fontsize{16pt}{0pt}\selectfont %\setlength{\parskip}{}
    \bfseries\facultname\\
    \bfseries\subjectname\\ \null\vspace{16pt} \null\vspace{16pt}}
    
	{\centering\fontsize{16pt}{0pt}\selectfont
    \includegraphics[width=45mm]{frontmatter/assets/crest_university.pdf}\\
    \null\vspace{16pt}}

    {\centering\fontsize{14pt}{0pt}\selectfont %\setlength{\parskip}{}
    \bfseries\ttitle\\ \null\vspace{14pt} \null\vspace{14pt} \null\vspace{14pt}}

    {\centering\fontsize{12pt}{0pt}\selectfont %\setlength{\parskip}{}
    \noindent%
    {\bfseries Autores: \par\vspace{4pt}}
    \foreach \i in {1,...,\value{ei@authornum}}{%
        \ifnum\i<\value{ei@authornum}%
            \getauthor{\i}\par%
        \else
            \getauthor{\i}\\%
        \fi
    }%
    \null\vspace{12pt} \null\vspace{12pt} \null\vspace{12pt}}

    {\centering\fontsize{12pt}{0pt}\selectfont %\setlength{\parskip}{}
    \noindent%
    {\bfseries Asesores: \par\vspace{4pt}}
    \foreach \i in {1,...,\value{ei@authornum}}{%
        \ifnum\i<\value{ei@authornum}%
            \getsupervisor{\i}\par%
        \else
            \getsupervisor{\i}\\%
        \fi
    }%
    }
    
    \null\vfill
    
    {\centering\fontsize{12pt}{0pt}\selectfont %\setlength{\parskip}{}
    \locationname\par
    \tdate\\} \vspace*{3cm}
 
	\end{titlepage}
}



%----------------------------------------------------------------------------------------
%	COUNCIL PAGE
%----------------------------------------------------------------------------------------

\newcommand{\councillabel}{Members of the Council}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\councillabel}{Members of the Council}
\providecaptionname{spanish}{\councillabel}{Miembros del Consejo Directivo}

\newcommand{\titcouncillabel}{Titular Members}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\titcouncillabel}{Titular Members}
\providecaptionname{spanish}{\titcouncillabel}{Consejeros Titulares}

\newcommand{\subscouncillabel}{Substitute Members}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\subscouncillabel}{Substitute Members}
\providecaptionname{spanish}{\subscouncillabel}{Consejeros Suplentes}

\newenvironment{council}{
    \checktoopen
    \clearpage
    \thispagestyle{thesis}
    \vbox{
    \vspace{12pt}
    \begin{center} 
        {\bfseries \large \councillabel}
    \end{center}
    \vspace{12pt}
    }
}{
% nothing
}



%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\dedicationlabel}{Dedicatory}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\dedicationlabel}{Dedicatory}
\providecaptionname{spanish}{\dedicationlabel}{Dedicatoria}


\newenvironment{dedicatory}{
    \checktoopen
	\clearpage
    \thispagestyle{thesis}
    \vbox{
    \vspace{12pt}
    \begin{center} 
        {\bfseries \large \dedicationlabel}
    \end{center}
    \vspace{12pt}
    }
    \begin{adjustwidth}{0.3\textwidth}{0\textwidth} % Adjust the width as desired
}
{
    \end{adjustwidth}
    \vfill\null
}

%----------------------------------------------------------------------------------------
%	ABSTRACT PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\abslabel}{Abstract}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\abslabel}{Abstract}
\providecaptionname{spanish}{\abslabel}{Resumen}

\newcommand{\keywordslabel}{Keywords}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\keywordslabel}{Keywords}
\providecaptionname{spanish}{\keywordslabel}{Palabras-clave}

\newenvironment{abstract}{
	\checktoopen
    \clearpage
    \thispagestyle{thesis}
	\vbox{
    \vspace{12pt}
    \begin{center} 
        {\bfseries \large \abslabel}
    \end{center}
    \vspace{12pt}
    }	
}
{
  \bigskip
  {\bf \keywordslabel:} {\keywordnames}
  \vfill\null
}

\newcommand{\abslabelotherlang}{Resumen}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\abslabelotherlang}{Resumen}
\providecaptionname{spanish}{\abslabelotherlang}{Abstract}

\newenvironment{abstractotherlanguage}{
	\checktoopen
    \clearpage
    \thispagestyle{thesis}
	\vbox{
    \vspace{12pt}
    \begin{center} 
        {\bfseries \large \abslabelotherlang}
    \end{center}
    \vspace{12pt}
    }
}
{
  \vfill\null
}

%----------------------------------------------------------------------------------------
%	ABBREVIATIONS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\abbrevname}{List of Abbreviations}
\providecaptionname{english,british,american}{\abbrevname}{List of Abbreviations}
\providecaptionname{spanish}{\abbrevname}{Lista de Abreviaciones}

\NewDocumentEnvironment{abbreviations}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}



%----------------------------------------------------------------------------------------
%	PHYSICAL CONSTANTS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\constantsname}{Physical Constants}
\providecaptionname{english,british,american}{\constantsname}{Physical Constants}
\providecaptionname{spanish}{\constantsname}{Constantes}

\NewDocumentEnvironment{constants}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\constantsname}}{\addchap*{\constantsname}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}





%----------------------------------------------------------------------------------------
%	SYMBOLS PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\symbolsname}{Symbols}
\providecaptionname{english,british,american}{\symbolsname}{List of Symbols}
\providecaptionname{spanish}{\symbolsname}{Lista de Símbolos}

\NewDocumentEnvironment{symbols}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
	\begin{longtable}{#1}
}{%
\end{longtable}
\addtocounter{table}{-1} % Don't count this table as one of the document tables
\ifbool{nolistspace}{\endgroup}{}
}




%----------------------------------------------------------------------------------------
%	ACKNOWLEDGEMENT PAGE DESIGN
%----------------------------------------------------------------------------------------

\newcommand{\acknowledgementlabel}{Acknowledgement}
\providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementlabel}{Acknowledgement} % Acknowledgement text for English countries
\providecaptionname{spanish}{\acknowledgementlabel}{Agradecimientos}

\newenvironment{acknowledgements}{
	\checktoopen
	\clearpage
    \thispagestyle{thesis}
    \vbox{
    \vspace{12pt}
    \begin{center} 
        {\bfseries \large \acknowledgementlabel}
    \end{center}
    \vspace{12pt}
    }
}
{
  \vfil\vfil\vfil\null
}




%----------------------------------------------------------------------------------------

\ifbool{hyperreflinkcolor}{\newcommand{\hreflinkcolor}{true}}{\newcommand{\hreflinkcolor}{false}}


\ifbool{hyperrefsupport}{% If the nohyperref class option has not been specified
\AfterPackage{biblatex}{ % Load the hyperref package after the biblatex package for compatibility 
\hypersetup{pdfpagemode={UseOutlines},
bookmarksopen=true,
bookmarksopenlevel=0,
hypertexnames=false,
colorlinks=\hreflinkcolor, % Set coloring of links
citecolor=CadetBlue, % The color of citations
linkcolor=NavyBlue, % The color of references to document elements (sections, figures, etc)
urlcolor=CadetBlue, % The color of hyperlinks (URLs)
pdfstartview={FitV},
unicode,
breaklinks=true,
}

\pdfstringdefDisableCommands{% If there is an explicit linebreak in a section heading (or anything printed to the pdf-bookmarks), it is replaced by a space
   \let\\\space%
}
}
}{%nothing
}




%----------------------------------------------------------------------------------------

% Define some commands to keep the formatting separated from the content 
\newcommand{\keyword}[1]{\textbf{#1}}
\newcommand{\tabhead}[1]{\textbf{#1}}
\newcommand{\code}[1]{\texttt{#1}}
\newcommand{\file}[1]{\texttt{\bfseries#1}}
\newcommand{\option}[1]{\texttt{\itshape#1}}




%----------------------------------------------------------------------------------------

\endinput
