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

# Suppression des fichiers créés par la compilation
rm *.ali
rm *.o
