
# Topics for Today

* Primary Keys/Foreign Keys
* Naming Conventions
* Data Types
* Relationship Types
* Design Concepts
* Entity Relationship Diagrams

# Primary and Foreign Keys

* Primary Key: Field values that uniquely identify a particular record within a table
* A PK must be unique (within the table) and can never be null
* A PK's data type is usually auto-incrementing integer (INTEGER or BIGINT)
* A Foreign Key is formed from field values that match a Primary Key stored in another table
* The Primary Key and Foreign Key MUST be the same data type



# sleep patterns, physical health, mental health, nutrition, asynchronous life events

# List of Tables for the Life Tracker App

- users (first name, last name, email address, TDEE, weight, height, BMI, age, body fat %, ....)
- meals (DEE (calories),  )

- recipes (id, name, ingredients, quantity, instructions, build vs. loose, ... )
- ingredients (id, name, price_per_weight, best_location_to_purchase)

- events ( date, time, repeat style, type (meal, entertainment, workout, ), planned vs. unplanned tag,  )


events
------------------------------------------------------------------------------------------
id (INTEGER) | title | date | start_time | repeat style | planned vs. unplanned | end_time
------------------------------------------------------------------------------------------
33| "Intro to SQL" |  Feb 6, 2023 | 10:00 am PT | "mon,tue,wed,thu,fri" | planned
34| "Database Design Lecture" |  Feb 7, 2023 | 10:00 am PT | "mon,tue,wed,thu,fri" | planned
35| "Light Breakfast" |  Feb 7, 2023 | 10:00 am PT | "mon,tue,wed,thu,fri" | planned

events.id = 33      <------   the way to refer to an individual "record" in the table


meals
------------------------------------------------------------------------------------------
id | title              | recipe_id | number_of_servings | event_id (INTEGER)
------------------------------------------------------------------------------------------
55 | 'lite breakfast'   | 56         | 1                  | 35
56 | 'lite breakfast'   | 56         | 1                  | 35
57 | 'lite breakfast 1' | 56         | 1                  | 35
58 | 'lite breakfast 2' | 56         | 1                  | 35


CREATE TABLE meals (
	id serial PRIMARY KEY,
	title ( 50 ) UNIQUE NOT NULL,
  recipe_id INTEGER,
  number_of_servings INTEGER,
  event_id INTEGER
);


recipes
---------------------
id | name
---------------------
1 | french toast
2 | pancakes
3 | salmon in puffed pastry

recipes_ingredients
-------------------------
recipe_id | ingredient_id
-------------------------
1         | 2
1         | 5
2         | 2
2         | 3

ingredients
-------------------------
id | name
-------------------------
1 | tomatoes
2 | flour
3 | butter
4 | salmon
5 | cinnamon

SELECT recipe.name, ingredient.name 
FROM recipes 
INNER JOIN recipe_ingredient ON recipe_ingredient.recipe_id = recipes.id
INNER JOIN ingredients ON recipe_ingredient.ingredient_id = ingredients.id
WHERE recipes.id = 1;





# Naming Conventions

* Table and field names are written in snake_case
* Table names are always pluralized
* The primary key for each table will simply be called id
* A foreign key's name is the singular of the primary key's table appended with _id (eg. user_id is the foreign key pointing to the id field in the users table)

# Data Types

* Each field in a table must have a data type defined for it
* The data type tells the database how much room to set aside to store the value and allows the database to perform type validation on data before insertion (to protect the data integrity of the table)
* Choosing the perfect data type is less of a concern nowadays because disk space is now comparably cheap

# Relationship Types

* One-to-Many: One record in the first table is related to one or more records in the second table
* One-to-One: One record in the first table is related to one (and only one) record in the second table
* Many-to-Many: One or more records in the first table are related to one or more records in the second table

It could be argued that there is really only one relationship type: One-to-Many as One-to-One's are extremely rare and Many-to-Many's are implemented using two One-to-Many's

# Design Concepts

* Make fields required if they represent the bare minimum for a row  (remember that additional data can be added to a record after it has been created)
* Intelligent default values can be set for fields (such as the current timestamp for a created_on field)
* Don't store calculated fields (a field that can be derived from one or more other fields, such as full_name is a combination of first_name and last_name)
* Pull repeated values out to their own table and make reference to them with a foreign key
* Try not to delete anything (use a boolean flag instead to mark a record as active or inactive)
* Consider using a type field instead of using two (or more) tables to store very similar data
 (eg. create an orders table with an order_type field instead of a purchase_orders and a sales_orders table)

# Entity Relationship Diagram (ERD)

* A visual depiction of the database tables and how they are related to each other
* Extremely useful for reasoning about how the database should be structured
* Can be created using pen and paper, a whiteboard, or using an online application

# Useful Links

[Database Normalization](https://en.wikipedia.org/wiki/Database_normalization){:target="_blank"}
[Postgres Data Types](https://www.postgresqltutorial.com/postgresql-data-types/){:target="_blank"}
[Relationship Types](http://etutorials.org/SQL/Database+design+for+mere+mortals/Part+II+The+Design+Process/Chapter+10.+Table+Relationships/Types+of+Relationships/){:target="_blank"}
[app.diagrams.net (online ERD)](https://app.diagrams.net/){:target="_blank"}
