% Script de création d'environnements (ensemble de segments) à la souris.
% Le paramètre "dim" donne les dimensions de l'environnement (carré).
% Les quatre segments de droite qui définissent le carré font partie de 
% l'environnement.
% Clic gauche sur les deux points du segment.
% Clic droit pour arrêter. Si clic droit après le 1er point d'un segment, 
% le premier sera ignoré.
% L'ensemble des segments est une matrice n lines (n segments) et quatre 
% colonnes correspondant à x1, y1 (1er point du segment) et x2,y2.
% Le résultat est enregistré dans un fichier environment.mat, qu'on peut
% renommer si on ne veut pas qu'il soit écrasé à la prochaine exécution 
% du script.
%
% Auteur: G. Garcia
%

dim = 100 ;
axis([0 dim 0 dim])
plot( [ 0  dim] , [ 0   0 ] , 'k', 'LineWidth',2 ) ; hold on ;
plot( [ 0  dim] , [dim dim] , 'k', 'LineWidth',2 ) ;
plot( [ 0   0 ] , [ 0  dim] , 'k', 'LineWidth',2 ) ;
plot( [dim dim] , [ 0  dim] , 'k', 'LineWidth',2 ) ;
for i = 1 : 9
    plot( [i*dim/10 i*dim/10] , [0 dim] ) ;
    plot( [0 dim] , [i*dim/10 i*dim/10] ) ;
end
    
segments = [  0   0  dim  0  ;
              0  dim dim dim ;
              0   0   0  dim ;
             dim  0  dim dim ] ;
% Loop, picking up the segments.
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
rightClick = 3 ;
while true % dirty: will exit loop with a break.
    [x1,y1,button] = ginput(1) ;
    if button==rightClick
        break
    end
    plot(x1,y1,'k+')
    [x2,y2,button] = ginput(1) ;
    if button==rightClick
        break
    end
    plot([x1 x2],[y1 y2],'r' , 'LineWidth',2 ) ;
    segments = [segments ; [x1 y1 x2 y2] ] ;
end
save environment segments

