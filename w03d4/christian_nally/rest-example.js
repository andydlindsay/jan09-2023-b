const routeGenerator = (resourceName) => {
  console.log(`Browse\tGET\t/${resourceName}`);
  console.log(`Read\tGET\t/${resourceName}/:id`);
  console.log(`Edit\tPOST\t/${resourceName}/:id`);
  console.log(`Add\tPOST\t/${resourceName}`);
  console.log(`Delete\tPOST\t/${resourceName}/:id/delete`);
};

routeGenerator('bet');




routeGenerator('team');

