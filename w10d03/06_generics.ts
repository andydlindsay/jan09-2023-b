interface Container<T, S> {
  name: string;
  contents: T;
  moreContents?: S;
}

const stringContainer: Container<string, number> = {
  name: 'string container',
  contents: 'contents'
};

const booleanContainer: Container<boolean, boolean> = {
  name: 'boolean container',
  contents: false
};