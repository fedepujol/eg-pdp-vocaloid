% vocaloid(Cantante).
vocaloid(megurineLuka).
vocaloid(hatsumeMiku).
vocaloid(gumi).
vocaloid(seeU).
vocaloid(kaito).
vocaloid(fede).

% sabeCantar(Vocaloid, Cancion)
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsumeMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(tellYourWorld, 5)).
sabeCantar(fede, cancion(aloha, 20)).

% esNovedoso(Vocaloid)
esNovedoso(Vocaloid):-
    tiene2Canciones(Vocaloid),
    cancionesConDuracionMayorA(Vocaloid).

esNovedoso(Vocaloid):-
    cancionesConDuracionMayorA(Vocaloid).

% cancionesConDuracionMayorA(Vocaloid, Minutos)
cancionesConDuracionMayorA(Vocaloid):-
    vocaloid(Vocaloid),
    foreach(sabeCantar(Vocaloid, Cancion), duracionSuperiorA(Cancion, 5)).

% cantidadCanciones(Vocaloid)
cantidadCanciones(Vocaloid):-
    aggregate(count, sabeCantar(Vocaloid, _), Count).

% tiene2Canciones(Vocaloid)
tiene2Canciones(Vocaloid):-
    aggregate(count, cantidadCanciones(Vocaloid), Count),
    Count is 2.

% duracionSuperiorA(Cancion, Minutos)
duracionSuperiorA(cancion(_, Duracion), Minutos):-
    Duracion > Minutos.

% esAcelerado(Vocaloid)
esAcelerado(Vocaloid):-
    vocaloid(Vocaloid),
    forall(sabeCantar(Vocaloid, Cancion), duracionMenorA4(Cancion)).

duracionMenorA4(cancion(_, Duracion)):-
    Duracion =< 4.

% concierto(Concierto).
concierto(mikuExpo, caracteristicas(pais(estadosUnidos), 2000, gigante(5))).
concierto(magicalMirai, pais(japon), 3000, gitante(10)).
concierto(vocalektVisions, pais(estadosUnidos), 1000, mediano(novemberRain)).
concierto(mikuFest, pais(argentina), 100, pequenio(4)).

% puedeParticiparEn(Vocaloid, Concierto).
puedeParticiparEn(hatsumeMiku, _).

% cancionesDiferentes(Cancion, Cancion)
% cancionesDiferentes(cancion(Nombre, _), cancion(OtroNombre, _)):-
%   Nombre \= OtroNombre.