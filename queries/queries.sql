-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre 
FROM producto;

-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio 
FROM producto;

-- 3. Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- 4. Llista el nom dels productes, el preu en euros (precio_eur) i el preu en dòlars estatunidencs (precio_usd) amb un tipus de canvi de 1 € = 1 $.
SELECT nombre, precio AS precio_eur, precio * 1.10 AS precio_usd
FROM producto;

-- 5. Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (amb un tipus de canvi de 1 € = 1,1 $ i arrodonint el resultat a dues xifres decimals). Utilitza els següents àlies per a les columnes: nom del producte, euros, dòlars.
SELECT 
    nombre AS 'nom del producte', 
    precio AS euros, 
    ROUND(precio * 1.1, 2) AS dòlars
FROM producto;

-- 6. Llista els noms (nombre) i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT 
    nombre AS 'nom del producte', 
    precio AS euros, 
    ROUND(precio * 1.1, 2) AS dòlars
FROM producto;

-- 7. Llista els noms (nombre) i els preus (precio) dels productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre, precio 
FROM producto;

-- 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant (iniciales).
SELECT 
    nombre, 
    UPPER(LEFT(nombre, 2)) AS iniciales
FROM fabricante;

-- 9. Llista els noms i els preus dels productes, arrodonint el valor del preu (precio)
SELECT nombre, ROUND(precio) AS precio_redondeado
FROM producto;

-- 10. Llista els noms i els preus de tots els productes (precio truncado) de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS precio_truncado
FROM producto;

-- 11. Mostra una llista amb els codis dels fabricants que apareixen a la taula producto, incloent possibles repeticions.
SELECT codigo_fabricante
FROM producto;

-- 12. Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante
FROM producto;

-- 13. Llista els noms dels fabricants ordenats de manera ascendent
SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

-- 14. Llista els noms dels fabricants ordenats de manera descendent
SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

-- 15. Llista els noms i els preus dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- 16. Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT *
FROM fabricante
LIMIT 5;

-- 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT *
FROM fabricante
LIMIT 2 OFFSET 3;

-- 18. Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT).
SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;

-- 19. Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT).
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

-- 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 22. Llista tots els productes amb nom, preu i nom del fabricant ordenats alfabèticament pel nom del producte.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.nombre ASC;

-- 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant.
SELECT p.codigo, p.nombre, f.codigo, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 24. Retorna el nom, el preu i el nom del fabricant, del producte més barat.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC
LIMIT 1;

-- 25. Retorna el nom del producte, el preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;

-- 26. Retorna una llista amb nom i preu de tots els productes del fabricant Lenovo.
SELECT p.nombre, p.precio
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- 27. Retorna una llista amb nom i preu de tots els productes del fabricant Crucial amb preu > 200€.
SELECT p.nombre, p.precio
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- 28. Productes de Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- 29. Productes de Asus, Hewlett-Packard i Seagate. Fent servir l'operador IN.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. Nom, preu i fabricant on el fabricant acabi en 'e'.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

-- 31. Nom, preu i fabricant on el fabricant contingui la lletra 'w'.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- 32. Productes >= 180€. Ordena preu DESC i nom ASC.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- 33. Codi i nom de fabricant solament d'aquells que tenen productes.
SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
INNER JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34. Tots els fabricants i els seus productes (incloent els que no tenen productes).
SELECT f.nombre, p.nombre
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Fabricants que no tenen cap producte associat.
SELECT f.nombre
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 36. Productes de Lenovo (Sense INNER JOIN).
SELECT * FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37. Productes amb el mateix preu que el més car de Lenovo (Sense INNER JOIN).
SELECT * FROM producto 
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 38. Nom del producte més car de Lenovo.
SELECT nombre 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo')
ORDER BY precio DESC 
LIMIT 1;

-- 39. Nom del producte més barat de Hewlett-Packard.
SELECT nombre 
FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard')
ORDER BY precio ASC 
LIMIT 1;

-- 40. Productes amb preu >= al més car de Lenovo.
SELECT * FROM producto 
WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 41. Productes d'Asus amb preu superior a la seva mitjana.
SELECT * FROM producto 
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));
