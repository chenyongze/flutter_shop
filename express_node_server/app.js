const express = require('express')
const app = express()

const path = require('path')

const resMsg = require("./utils/index").resMsg;


app.use(express.static(path.resolve(__dirname, "public")));


app.use(function (req, res, next) {
    const proxy = req.query.proxy;
    if (proxy) {
        req.header.cookie = req.header.cookie + `__proxy__${proxy}`;
    }
    next();
})

app.use("/getTestData", require("./router/test"));
app.use("/getHotGoods", require("./router/hot_goods"));
app.use("/homePageContent", require("./router/home_page_content"));
app.use("/users", require("./router/user"));


//404 handler
app.use(function (req, res, next) {
    res.status(404).json(resMsg(404));
});

// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get("env") === "development" ? err : {};

    // render the error page
    res.status(err.status || 500).json(resMsg());
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
    console.log(`server runing@http://localhost:${port}`)
})

// app.get('/', function (req, res) {
//     res.send('Hello World!')
// })

// app.listen(3000)