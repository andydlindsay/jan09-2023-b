let username: string | number | boolean = 'Alice';
username = 'Bob';
username = 42;
username = true;

const names: (string | number)[] = [];
names.push('Carol');
names.push(42);
// names.push(true);
const output = names.pop();
