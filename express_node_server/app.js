const express = require('express')
const app = express()

const path = require('path')

app.use(express.static(path.resolve(__dirname, "public")));


app.use(function (req, res, next) {
    const proxy = req.query.proxy;
    if (proxy) {
        req.header.cookie = req.header.cookie + `__proxy__${proxy}`;
    }
    next();
})

app.use("/getTestData", require("./router/test"));
app.use("/homePageContent", require("./router/home_page_content"));
app.use("/users", require("./router/user"));

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`server runing@http://localhost:${port}`)
})

// app.get('/', function (req, res) {
//     res.send('Hello World!')
// })

// app.listen(3000)