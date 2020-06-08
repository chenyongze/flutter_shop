/*
 * @Author: your name
 * @Date: 2020-06-08 07:19:50
 * @LastEditTime: 2020-06-09 07:06:06
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /express_node_server/router/user.js
 */

var express = require('express');
var router = express.Router();
var db = require("../config/db.connect"); //引入数据库封装模块

/* GET home page. */
router.get('/', function (req, res, next) {

    //查询users表
    db.query("SELECT * FROM love_user", [], function (results, fields) {
        console.log(results);
        // res.render('index', { title: 'Express11' });
        res.json({
            'code': 8,
            'data': results,
        })
    })

});

module.exports = router;