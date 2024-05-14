%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               TP1 de Traitement Numérique du Signal
%                   SCIENCES DU NUMERIQUE 1A
%                       Fevrier 2024 
%                        Laérian Bontinck
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PARAMETRES GENERAUX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=1;        %amplitude du cosinus
f0=1100;       %fréquence du cosinus en Hz
T0="à completer";       %période du cosinus en secondes
N=90;        %nombre d'échantillons souhaités pour le cosinus
Te=1/10000;       %période d'échantillonnage en secondes
Fe=1/Te;       %fréquence d'échantillonnage en Hz
SNR="à completer";      %SNR souhaité en dB pour le cosinus bruité


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATION DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Définition de l'échelle temporelle
temps=linspace(0,N*Te, N);
%Génération de N échantillons de cosinus à la fréquence f0
x=A*cos(2*pi*f0*temps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sans se préoccuper de l'échelle temporelle
% figure
% plot(x)

%Tracé avec une échelle temporelle en secondes
%des labels sur les axes et un titre (utilisation de xlabel, ylabel et
%title)
figure
plot(temps,x);
grid
xlabel('Temps (s)')
ylabel('signal')
title(['Tracé d''un cosinus numérique de fréquence ' num2str(f0) 'Hz']);

% Avec une fréquence de cosinus f0 = 1100Hz et une fréquence
% d'échantillonage fe = 1000 Hz, on ne retrouve pas f0 dans le
% signal final.
% C'est parce que le critère d'échantillonage "fe > 2*f0" n'est
% pas vérifié. On a donc des données beaucoup trop peu détaillée
% pour retrouver la fréquence de base du signal.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA TRANSFORMEE DE FOURIER NUMERIQUE (TFD) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sans zero padding 
X=fft(x);
X_s=fftshift(x);
%Avec zero padding (ZP : paramétre de zero padding à définir)
L = 1024; % Taille du padding
X_ZP = fft(x,L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU MODULE DE LA TFD DU COSINUS NUMERIQUE EN ECHELLE LOG
%SANS PUIS AVEC ZERO PADDING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Avec une échelle fréquentielle en Hz
%des labels sur les axes et des titres
%Tracés en utilisant plusieurs zones de la figure (utilisation de subplot) 
% figure('name',['Tracé du module de la TFD d''un cosinus numérique de fréquence ' num2str(f0) 'Hz'])

% subplot(2,1,1)
% echelle_frequentielle=linspace(0,1/Te, length(X));
% semilogy(echelle_frequentielle, abs(X));
% grid
% title('Sans zero padding')
% xlabel('Fréquence (Hz)')
% ylabel('|TFD|')

% subplot(2,1,2)
% echelle_frequentielle_zp=linspace(0,1/Te, length(X_ZP));
% semilogy(echelle_frequentielle_zp, abs(X_ZP));
% grid
% title('Avec zero padding')
% xlabel('Fréquence (Hz)')
% ylabel('|TFD|')

%Avec une échelle fréquentielle en Hz
%des labels sur les axes et des titres
%Tracés superposés sur une méme figure 
% (utilisation de hold, de couleurs différentes et de legend)
% !! UTILISER ICI fftshift POUR LE TRACE !!
figure
echelle_frequentielle=linspace(0,1/Te, length(X));
semilogy(echelle_frequentielle, abs(X),'b');    %Tracé en bleu : 'b'
hold on
echelle_frequentielle=linspace(-Fe/2,Fe/2, length(X_s));
semilogy(echelle_frequentielle, abs(X_s),'g');    %Tracé en vert : 'g'
echelle_frequentielle=linspace(0,1/Te, L);
semilogy(echelle_frequentielle, abs(X_ZP),'r'); %Tracé en rouge : 'r'
grid
legend('Sans zero padding','Sans zero padding (shift)','Avec zero padding')
xlabel('Fréquence (Hz)')
ylabel('|TFD|')
title(['Tracé du module de la TFD d''un cosinus numérique de fréquence ' num2str(f0) 'Hz'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA TFD DU COSINUS NUMERIQUE AVEC FENETRAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Application de la fenétre de pondération de Hamming
x_fenetre_hamming=x.*hamming(length(x)).';
%Calcul de la TFD pondérée, avec zeros padding
X_ZP_hamming=fft("à completer");
%Application de la fenétre de pondération de Blackman
x_fenetre_blackman="à completer";
%Calcul de la TFD pondérée, avec zeros padding
X_ZP_blackman=fft("à completer");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DU MODULE DE LA TFD DU COSINUS NUMERIQUE AVEC FENETRAGE EN ECHELLE LOG
%POUR DIFFERENTES FENETRES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "à réaliser : tracés superposés sur la méme figure de la TFD non fenétrée, 
% de la TFD avec fenétrage de Hamming, de la TFD avec fenétrage de Blackman
% Le tout avec une échelle fréquentielle en Hz, un titre, des labels sur les axes, 
% une légende et en utilisant fftshift"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL DE LA DENSITE SPECTRALE DE PUISSANCE (DSP) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Estimation par périodogramme
Sx_periodogramme="à completer";

%Estimation par périodogramme de Welch
Sx_Welch=pwelch(x, [],[],[],Fe,'twosided');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRACE DE LA DENSITE SPECTRALE DE PUISSANCE (DSP) DU COSINUS NUMERIQUE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Tracés superposés sur une méme figure en utilisant fftshift
%Avec une échelle fréquentielle en Hz
%des labels sur les axes, un titre, une légende
figure
echelle_frequentielle="à completer";
semilogy("à completer",'b')
hold on
echelle_frequentielle="a completer";
semilogy("à completer",'r')
legend('Periodogramme','Periodogramme de Welch')
xlabel('Fréquences (Hz)')
ylabel('DSP')
title('Tracés de la DSP d''un cosinus numérique de fréquence 1100 Hz');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCUL ET TRACE DE LA FONCTION D'AUTOCORRELATION DU COSINUS BRUITE AVEC LE
%BON SNR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       

%Calcul de la puissance du signal
P_signal=mean(abs(x).^2);
%Calcul de la puissance du bruit pour obtenir le SNR souhaité
P_bruit="à completer";

%Génération du bruit gaussien à la puissance Pb
bruit=sqrt(P_bruit)*randn(1,length(x));
%Ajout du bruit sur le signal
x_bruite=x+bruit;

%Calcul de la fonction d'autocorrélation du signal bruite
%attention pas le 1/N quand on utilise xcorr => à rajouter
Rx=(1/length(x_bruite))*xcorr(x_bruite); 

%Tracé du signal bruité avec une échelle temporelle en secondes
figure
plot("à completer")
grid
xlabel('Temps (s)')
ylabel('Signal')
title('Tracé du cosinus bruité');

%Tracé de la fonction d'autocorrélation du signal bruite avec une échelle 
%temporelle en secondes
figure
echelle_tau="à completer";
plot("à completer")
grid
xlabel('\tau (s)')
ylabel('R_x(\tau)')
title('Tracé de la fonction d''autocorrélation du cosinus bruité');

