A backend most kétféleképp jelzi a sikert: a HTTP-kód mellett egy "OK" vagy
"ERROR" string is megjelenik a válasz törzsében. Ezt egyszerűbb lenne csak a
HTTP-kódra építeni — kevesebb hely van, ahol valami nem stimmel.

Az API-leírásban nincs egyértelműen jelölve, hogy mely mezők kötelezők egy
rendelésnél. Érdemes lenne ezt tisztázni — könnyebb lenne hozzá klienst írni
és olvasható is lenne, mi opcionális.

A backend URL most a kódba van beírva (127.0.0.1:8080). Production-szinten
ezt környezetenként (debug, staging, release) különböző értékre kéne tudni
állítani — egyetlen build-flag-en keresztül.

A felhasználó nem kap visszajelzést, amíg az app adatot tölt, és hibánál se.
Egy egyszerű "betöltés folyamatban" jelzés és egy újrapróbálás-gomb hiba
esetén sokat dobna a felhasználói élményen.

A vizuális konstansok (színek, paddingek, sarok-méretek) most minden
képernyőn külön definícióban élnek. A szövegeket már egy közös fájlba
szerveztem, és ugyanezt érdemes lenne megtenni a designnal is. Így ha a
márkaszín változna, egy helyen kéne átírni.

A vásárlási folyamat a mostani állapotban végigmegy mindkét úton (országos
és vármegyei), de további csiszolás lehetséges: pl. a sikertelen rendelés
esetén kifejtettebb visszajelzés, animációk a megye-kijelölésnél, vagy
haptikus visszajelzés tap-eknél.
