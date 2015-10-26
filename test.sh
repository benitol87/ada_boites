# Test du package fichier
echo "Test du package fichier"
gnatmake test_fichier.adb
rm test.svg 2>/dev/null
./test_fichier
echo "Contenu du fichier : "
cat test.svg
rm test_fichier
rm test.svg
echo

# Test 

# Test


rm *.ali
rm *.o
