# Test du package fichier
echo "Test du package fichier"
gnatmake -q test_fichier.adb
rm test.svg 2>/dev/null

./test_fichier
if test `cat test.svg` = "<svg></svg>"
then
	echo "  Test OK"
else
	echo "  Echec du test"
fi

rm test_fichier
rm test.svg
echo

# Test du package svg
echo "Test du package svg"
gnatmake -q test_svg.adb
./test_svg 
if test $? -eq 0
then
	echo "  Un fichier etoile.svg représentant une étoile a été créé"
	echo "  Test OK jusqu'ici"
else
	echo "  Echec du test"
fi
rm test_svg
echo

# Test du package boites
echo "Test du package boites"
gnatmake -q test_boites.adb
./test_boites
if test $? -eq 0
then
	echo "  Les fichiers test01.svg à test06.svg ont été créés"
	echo "  Test OK jusqu'ici"
else
	echo "  Echec du test"
fi
rm test_boites
echo

# Test du fichier main.adb
echo "Test du programme"
gnatmake -q main.adb
dir="test_main"
mkdir $dir 2>/dev/null

  # Test des arguments manquants + cas quelconque à la fin
echo "  Test de la commande avec des arguments manquants"
./main >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 -w 140 >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 -w 140 -h 80 >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 -w 140 -h 80 -b 50 >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 -w 140 -h 80 -b 50 -t 5 >/dev/null && echo "  Echec du test"
./main -f ${dir}/fichier.svg -l 200 -w 140 -h 80 -b 50 -t 5 -q 10 >/dev/null || echo "  Echec du test"
./main -f ${dir}/fichier2.svg -l 140 -w 200 -h 80 -b 50 -t 5 -q 10 >/dev/null || echo "  Echec du test"

  # Test des cas limites
echo "  Cas b<=h/2-t"
./main -f ${dir}/lim1_fail1.svg -l 200 -w 140 -h 80 -b 34 -t 5 -q 10 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim1_fail2.svg -l 200 -w 140 -h 80 -b 35 -t 5 -q 10 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim1.svg -l 200 -w 140 -h 80 -b 36 -t 5 -q 10 >/dev/null || echo "  Echec du test"
 
echo "  Cas b>=h-2t"
./main -f ${dir}/lim2_fail1.svg -l 200 -w 140 -h 80 -b 71 -t 5 -q 10 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim2_fail2.svg -l 200 -w 140 -h 80 -b 70 -t 5 -q 10 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim2.svg -l 200 -w 140 -h 80 -b 69 -t 5 -q 10 >/dev/null || echo "  Echec du test"

echo "  Cas h<=3t"
./main -f ${dir}/lim3_fail1.svg -l 200 -w 140 -h 80 -b 20 -t 28 -q 1 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim3_fail2.svg -l 200 -w 140 -h 80 -b 20 -t 27 -q 1 >/dev/null && echo "  Echec du test"

echo "  Cas l<=4t"
./main -f ${dir}/lim4_fail1.svg -l 80 -w 80 -h 80 -b 35 -t 21 -q 1 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim4_fail2.svg -l 80 -w 80 -h 80 -b 35 -t 20 -q 1 >/dev/null && echo "  Echec du test"

echo "  Cas w<=4t"
./main -f ${dir}/lim5_fail1.svg -l 200 -w 80 -h 80 -b 40 -t 21 -q 1 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim5_fail2.svg -l 200 -w 80 -h 80 -b 40 -t 20 -q 1 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim5.svg -l 200 -w 80 -h 80 -b 40 -t 19 -q 1 >/dev/null || echo "  Echec du test"

echo "  Cas q>=l-2t"
./main -f ${dir}/lim6_fail1.svg -l 100 -w 100 -h 205 -b 100 -t 10 -q 81 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim6_fail2.svg -l 100 -w 100 -h 205 -b 100 -t 10 -q 80 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim6.svg -l 100 -w 100 -h 205 -b 100 -t 10 -q 79 >/dev/null || echo "  Echec du test"

echo "  Cas q>=w-2t"
./main -f ${dir}/lim7_fail1.svg -l 100 -w 40 -h 80 -b 50 -t 5 -q 31 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim7_fail2.svg -l 100 -w 40 -h 80 -b 50 -t 5 -q 30 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim7.svg -l 100 -w 40 -h 80 -b 50 -t 5 -q 29 >/dev/null || echo "  Echec du test"

echo "  Cas q>=h/2-2t"
./main -f ${dir}/lim8_fail1.svg -l 200 -w 140 -h 80 -b 50 -t 10 -q 21 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim8_fail2.svg -l 200 -w 140 -h 80 -b 50 -t 10 -q 20 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim3.svg -l 200 -w 140 -h 80 -b 50 -t 10 -q 19 >/dev/null || echo "  Echec du test"

echo "  Cas q>=b-2t"
./main -f ${dir}/lim9_fail1.svg -l 200 -w 140 -h 104 -b 50 -t 5 -q 41 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim9_fail2.svg -l 200 -w 140 -h 104 -b 50 -t 5 -q 40 >/dev/null && echo "  Echec du test"
./main -f ${dir}/lim4.svg -l 200 -w 140 -h 104 -b 50 -t 5 -q 39 >/dev/null || echo "  Echec du test"

# Valeurs non numériques
echo "  Cas des paramètres non numériques"
./main -f ${dir}/fail.svg -l -w 140 -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b 50 -t -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b 50 -t 5 -q -f >/dev/null && echo "  Echec du test"

# Valeurs négatives
echo "  Cas des paramètres négatifs"
./main -f ${dir}/fail.svg -l -1 -w 140 -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w -2 -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h -3 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b -4 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b 50 -t -5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail.svg -l 200 -w 140 -h 80 -b 50 -t 5 -q -6 >/dev/null && echo "  Echec du test"

# Valeurs nulles
echo "  Cas des paramètres nuls"
./main -f ${dir}/fail1.svg -l 0 -w 140 -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail2.svg -l 200 -w 0 -h 80 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail3.svg -l 200 -w 140 -h 0 -b 50 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail4.svg -l 200 -w 140 -h 80 -b 0 -t 5 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail5.svg -l 200 -w 140 -h 80 -b 50 -t 0 -q 10 >/dev/null && echo "  Echec du test"

./main -f ${dir}/fail6.svg -l 200 -w 140 -h 80 -b 50 -t 5 -q 0 >/dev/null && echo "  Echec du test"

rm main
echo

# Suppression des fichiers créés par la compilation
rm *.ali
rm *.o
