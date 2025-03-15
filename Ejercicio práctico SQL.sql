a) Crear la base de datos con el archivo create_restaurant_db.sql


b) Explorar la tabla “menu_items” para conocer los productos del menú.

-- 1.- Realizar consultas para contestar las siguientes preguntas:


--Explorando la tabla menu_items
SELECT * FROM menu_items;

-- ● Encontrar el número de artículos en el menú. 
SELECT COUNT(menu_item_id) FROM menu_items;
/* RESPUESTA: Hay 32 articulos en el menu */

--● ¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name, price FROM menu_items
ORDER BY price ASC;
/* RESPUESTA: El platillo menos caro es Edamane y el más caro es Shrimp Scampi */

--● ¿Cuántos platos americanos hay en el menú?
SELECT category, 
COUNT(category)
FROM menu_items
WHERE category='American'
GROUP BY 1
/* RESPUESTA: Hay 6 platos americanos en el menu */

-- ● ¿Cuál es el precio promedio de los platos?
SELECT ROUND(AVG(price),2) 
FROM menu_items;
/* RESPUESTA: El precio promedio es 13.29 */

c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

--Explorando la tabla order_details
SELECT * FROM order_details

-- ● ¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT( DISTINCT item_id) AS Pedidos_unicos
FROM order_details;
/* RESPUESTA: Se realizaron 32 pedidos unicos */

-- ● ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT * FROM order_details
ORDER BY order_id DESC
LIMIT 5;
/* RESPUESTA: Fueron los pedidos; 12234 con 5370 articulos,
                                  12233 con 5369 articulos
								  12232 con 5369 articulos
								  12231 con 5369 articulos
								  12230 con 5369 articulos */
								  

-- ● ¿Cuándo se realizó el primer pedido y el último pedido?
SELECT DATE(order_date) 
FROM order_details
ORDER BY 1 ASC
LIMIT 1;
/* RESPUESTA: El primer pedido se realizo el 2023-01-01*/

SELECT DATE(order_date) 
FROM order_details
ORDER BY 1 DESC
LIMIT 1;
/* RESPUESTA: El último pedido se realizo el 2023-03-31*/


-- ● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?*/
SELECT count(*) FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';
/* RESPUESTA: Se hicieron un total de 702 pedidos */ 


d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.

1.- Realizar un left join entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).

SELECT * FROM order_details
INNER JOIN menu_items
On order_details.item_id = menu_items.menu_item_id

-- ¿Cuantas ordernes se realizaron por cada platillo?
   -- El platillo con más ordenes fue la Hamburguesa

SELECT item_name, SUM(order_id)
FROM order_details
LEFT JOIN menu_items
On order_details.item_id = menu_items.menu_item_id
GROUP BY 1
ORDER BY 2 DESC
