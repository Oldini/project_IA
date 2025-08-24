% ================================
% Projet : Enquête policière en PROLOG (Version avancée interactive)
% ================================

% --- Types de crimes ---
crime_type(assassinat).
crime_type(vol).
crime_type(escroquerie).

% --- Suspects ---
suspect(john).
suspect(mary).
suspect(alice).
suspect(bruno).
suspect(sophie).

% --- Faits ---
has_motive(john, vol).
was_near_crime_scene(john, vol).
has_fingerprint_on_weapon(john, vol).

has_motive(mary, assassinat).
was_near_crime_scene(mary, assassinat).
has_fingerprint_on_weapon(mary, assassinat).

has_motive(alice, escroquerie).
has_bank_transaction(alice, escroquerie).

has_bank_transaction(bruno, escroquerie).
owns_fake_identity(sophie, escroquerie).

% ================================
% Règles
% ================================

is_guilty(Suspect, vol) :-
    has_motive(Suspect, vol),
    was_near_crime_scene(Suspect, vol),
    has_fingerprint_on_weapon(Suspect, vol).

is_guilty(Suspect, assassinat) :-
    has_motive(Suspect, assassinat),
    was_near_crime_scene(Suspect, assassinat),
    ( has_fingerprint_on_weapon(Suspect, assassinat)
    ; eyewitness_identification(Suspect, assassinat) ).

is_guilty(Suspect, escroquerie) :-
    ( has_motive(Suspect, escroquerie),
      has_bank_transaction(Suspect, escroquerie)
    )
    ;
    owns_fake_identity(Suspect, escroquerie).

% ================================
% Outils d'affichage
% ================================

list_suspects :-
    writeln('--- Liste des suspects disponibles ---'),
    forall(suspect(S), format(' - ~w~n', [S])).

list_crimes :-
    writeln('--- Liste des crimes disponibles ---'),
    forall(crime_type(C), format(' - ~w~n', [C])).

% ================================
% Entrée interactive
% ================================

main :-
    writeln('=== Systeme Expert : Enquete Policiere ==='), nl,
    list_suspects, nl,
    writeln('Entrez le nom du suspect :'),
    read(Suspect),
    ( suspect(Suspect) ->
        true
    ;   writeln('⚠️ Erreur : ce suspect n\'existe pas dans la base.'), halt
    ),
    nl,
    list_crimes, nl,
    writeln('Entrez le type de crime :'),
    read(CrimeType),
    ( crime_type(CrimeType) ->
        true
    ;   writeln('⚠️ Erreur : ce type de crime n\'existe pas dans la base.'), halt
    ),
    nl,
    ( is_guilty(Suspect, CrimeType) ->
        format('✅ ~w est COUPABLE de ~w.~n', [Suspect, CrimeType])
    ;   format('❌ ~w est NON COUPABLE de ~w.~n', [Suspect, CrimeType])
    ),
    halt.
