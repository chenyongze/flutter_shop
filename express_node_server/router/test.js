const express = require("express");
const router = express();

const config = require("./config")

const base_url = "http://" + config.IP + ":" + config.PORT + "/images/ad/";

router.get("/", (req, res) => {

    var id = req.query.id;
    console.log("req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": [
            {
                "image": base_url + "180.png",
            },
            {
                "image": base_url + "180.png",
            },
            {
                "image": base_url + "180.png",
            },
            {
                "image": base_url + "180.png",
            },
        ]
    };

    res.send(data);
});

module.exports = router;