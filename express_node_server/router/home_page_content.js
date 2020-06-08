/**
 * 首页数据
 */
const express = require("express");
const router = express();

const config = require("./config")

const base_url = "http://" + config.IP + ":" + config.PORT + "/images/ad/";

router.post("/", (req, res) => {

    var id = req.query.id;
    console.log('hot_page_content', "req.query.id  ::: ", id);
    var data = {
        "code": 0,
        "message": "success",
        "data": {
            "slides": [
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
            ],
            'category': [
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "001",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "002",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "003",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "004",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "005",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "006",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "007",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "008",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "009",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "010",
                },
                {
                    "image": base_url + "180.png",
                    "firstCategoryName": "011",
                },
            ],
            'recomend': [
                {
                    "image": base_url + "180.png",
                },
            ],
            'floor1': [

            ],
            'floor1Pic': {

            },
            'title': '这是一个首页',
        },
    };

    res.send(data);
});

module.exports = router;