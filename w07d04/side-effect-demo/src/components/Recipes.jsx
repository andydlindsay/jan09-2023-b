import {useEffect, useState} from 'react';
import axios from 'axios';

const Recipes = () => {
  const [recipes, setRecipes] = useState([
    {
      id: 4,
      title: 'pizza',
      ingredients: []
    }
  ]);

  useEffect(() => {
    axios.get('http://my-json-server.typicode.com/andydlindsay/chef-andy/recipes')
      .then((response) => {
        setRecipes((prev) => {
          const newRecipes = [...prev, ...response.data];
          return newRecipes;
        });
      });
  }, []);

  const mappedRecipes = recipes.map((recipe) => {
    return <p key={recipe.id}>Recipe: {recipe.title} (num ingredients: {recipe.ingredients.length})</p>
  });

  return (
    <div>
      <h2>All the Recipes!</h2>
      { mappedRecipes } 
    </div>
  );
};

export default Recipes;
