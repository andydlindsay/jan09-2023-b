// if it looks like a duck, and walks like a duck, and quacks like a duck, then it's probably a duck

interface PotentialUser {
  username: string;
  password: string;
}

const login = (user: PotentialUser): boolean => {
  return true;
}

const user = {
  username: 'jstamos',
  password: '1234',
  moreStuff: 'hello'
};

login(user);
