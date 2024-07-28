SELECT 
s1.item_name,
s1.ing_id,
s1.ing_name,
s1.ing_weight,
s1.ing_price,
s1.order_quantity,
s1.recipe_quantity,
s1.order_quantity*recipe_quantity AS ordered_weight,
s1.ing_price/s1.ing_weight AS unit_cost,
(s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) AS ingredient_cost

FROM (SELECT 
	o.item_id,
	i.sku,
	i.item_name,
	r.ing_id,
	ing.ing_name,
	r.quantity AS recipe_quantity,
	SUM(o.quantity) AS order_quantity,
	ing.ing_weight,
	ing.ing_price
FROM 
	orders o
	LEFT JOIN item i ON o.item_id = i.item_id
	LEFT JOIN recipe r ON i.sku = r.recipe_id
	LEFT JOIN ingredient ing ON ing.ing_id = r.ing_id
GROUP BY 
	o.item_id, 
	i.sku, 
	i.item_name,
	r.ing_id,
	r.quantity,
	ing.ing_name,
	ing.ing_weight,
	ing.ing_price) s1
