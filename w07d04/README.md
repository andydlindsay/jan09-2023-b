# W07D04 - Data Fetching & Other Side Effects

### To Do
- [x] Rules for Hooks
- [x] Pure Functions and Side Effects
- [x] `useEffect`
- [x] Cleanup
- [x] Dependencies
- [x] _useEffect_ Flow

### Rules for Hooks
* don't call inside loop or condition (must be called top-level)
* have to be called inside a React function (components or custom hooks)
* all hooks must start with `use`

### Pure Functions
* doesn't rely on or produce side effects
* given the same args returns the same value

```js
let additionVal = 112;
let user = null;

const addTwo = (num) => {
  user = {username: 'jstamos'};
  const result = num + additionVal;
  // console.log(result);
  return result;
};
```

### Side Effects
* writing to stdout
* modifying the DOM directly
* establishing a socket connection Chat
* making an HTTP request /AJAX
* setting timers and intervals

```js
// how often our callback gets called
// and when our callback gets called
useEffect(() => {
  // side effects go in here
})
```


```js
useEffect(() => {}); // called on EVERY single render
useEffect(() => {}, [username]) // called on initial render and then only if username changes
useEffect(() => {}, []); // called on initial render and then never again
```


/interviewers
/appointments
/days












