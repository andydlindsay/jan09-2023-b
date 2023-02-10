require('dotenv').config();

const express = require('express');
const morgan = require('morgan');

const app = express();
// const router = express.Router();
const port = process.env.PORT || 3000;

app.use(morgan('dev')); // logger


// require routers
const productRouter = require('./routes/product-router');
const blogpostRouter = require('./routes/blogpost-router');

// pass the routers to the Express app as middleware
app.use('/api/admin/products', productRouter);
app.use('/blogposts', blogpostRouter);
// app.use('*', productRouter);

app.listen(port, () => {
  console.log(`app listening on port ${port}`);
});
