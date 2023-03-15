interface Pet {
  name: string;
  breed: string;
}

interface MyUser {
  pet?: Pet[];
  id?: number;
  username: string;
  age: number;
  friends?: MyUser[];
}

const myObj: MyUser = {
  // id: 2,
  username: 'jstamos',
  age: 42,
};

const myArr: MyUser[] = [];
myArr.push(myObj);
